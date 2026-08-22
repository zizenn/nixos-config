#!/usr/bin/env python3
"""
Categorize a Nix package into an appropriate _personal module file using qwen2.5-coder:1.5b
"""

import json
import subprocess
import sys
import os

def get_existing_categories(personal_dir):
    """Get list of existing .nix files in _personal directory"""
    files = []
    for f in os.listdir(personal_dir):
        if f.endswith('.nix'):
            files.append(f[:-3])  # Remove .nix extension
    return files

def get_file_contents(personal_dir, category):
    """Get the content of a category file"""
    path = os.path.join(personal_dir, f"{category}.nix")
    if os.path.exists(path):
        with open(path, 'r') as f:
            return f.read()
    return ""

def build_prompt(package_name, categories, personal_dir):
    """Build the prompt for the LLM"""
    category_info = []
    for cat in categories:
        content = get_file_contents(personal_dir, cat)
        category_info.append(f"## {cat}.nix\n```nix\n{content}\n```")
    
    categories_str = "\n\n".join(category_info)
    
    return f"""You are a NixOS configuration expert. Categorize the package "{package_name}" into one of these existing module files, or suggest a new category name.

Existing categories and their contents:

{categories_str}

Rules:
- apps.nix: GUI applications, desktop apps, user-facing programs (home.packages + program configs)
- programs.nix: System-level programs, services, daemons (nixos.modules.base programs)
- mail.nix: Email-related configuration (aerc, etc.)
- New categories should be lowercase, descriptive nouns (e.g., "media", "dev", "gaming")

Respond with ONLY the category name (e.g., "apps", "programs", "media", "dev"), nothing else."""

def categorize_package(package_name, personal_dir):
    """Use Ollama to categorize the package"""
    categories = get_existing_categories(personal_dir)
    prompt = build_prompt(package_name, categories, personal_dir)
    
    try:
        result = subprocess.run(
            ['ollama', 'run', 'qwen2.5-coder:1.5b', prompt],
            capture_output=True,
            text=True,
            timeout=60
        )
        output = result.stdout.strip()
        
        # Extract just the category name (first word, lowercase, alphanumeric + underscore)
        import re
        match = re.match(r'^([a-z_][a-z0-9_]*)', output.lower())
        if match:
            return match.group(1)
        
        # Fallback: try to find a valid category in the output
        for cat in categories:
            if cat in output.lower():
                return cat
                
    except subprocess.TimeoutExpired:
        print("LLM request timed out", file=sys.stderr)
    except Exception as e:
        print(f"Error calling LLM: {e}", file=sys.stderr)
    
    # Default fallback
    return "apps"

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: categorize-package.py <package_name> <personal_dir>")
        sys.exit(1)
    
    package_name = sys.argv[1]
    personal_dir = sys.argv[2]
    
    category = categorize_package(package_name, personal_dir)
    print(category)