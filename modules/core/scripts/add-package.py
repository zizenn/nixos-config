#!/usr/bin/env python3
"""
Add a package to a Nix file in the appropriate location
"""

import sys
import re
import os

def add_package_to_file(package_name, target_file):
    """Add package to the appropriate section in the Nix file"""
    # Create file with default template if it doesn't exist
    if not os.path.exists(target_file):
        dir_name = os.path.basename(target_file).replace('.nix', '')
        if dir_name == 'programs':
            content = '{ ... }: {\n  nixos.modules.base = {pkgs, ...}: {\n    programs = {\n    };\n  };\n}'
        else:
            content = '{ ... }: {\n  homeManager.modules.base = { pkgs, ... }: {\n    home.packages = with pkgs; [\n    ];\n  };\n}'
        with open(target_file, 'w') as f:
            f.write(content)
        print(f"Created new file: {target_file}")
    
    with open(target_file, 'r') as f:
        content = f.read()
    
    # Find the home.packages section
    # Pattern: home.packages = with pkgs; [ ... ];
    packages_pattern = r'(home\.packages\s*=\s*with\s+pkgs;\s*\[)([^\]]*)(\];)'
    
    def replace_packages(match):
        prefix = match.group(1)
        packages_content = match.group(2)
        suffix = match.group(3)
        
        # Check if package already exists
        if re.search(rf'^\s*{re.escape(package_name)}\b', packages_content, re.MULTILINE):
            return match.group(0)
        
        # Add package (maintain alphabetical order)
        lines = [line.strip() for line in packages_content.split('\n') if line.strip() and not line.strip().startswith('#')]
        lines.append(package_name)
        lines.sort()
        
        # Format with proper indentation (6 spaces)
        new_content = '\n'.join(f'      {pkg}' for pkg in lines)
        return f'{prefix}\n{new_content}\n    {suffix}'
    
    new_content = re.sub(packages_pattern, replace_packages, content, flags=re.DOTALL)
    
    # Also check for programs section (for programs.nix style)
    # programs = { ... }; - need to handle nested braces
    def find_programs_block(content):
        """Find the programs = { ... }; block, handling nested braces"""
        start_pattern = r'programs\s*=\s*\{'
        match = re.search(start_pattern, content)
        if not match:
            return None, None, None
        
        start = match.start()
        brace_count = 0
        in_block = False
        end = None
        
        for i, char in enumerate(content[start:], start):
            if char == '{':
                brace_count += 1
                in_block = True
            elif char == '}':
                brace_count -= 1
                if in_block and brace_count == 0:
                    end = i + 1
                    break
        
        if end is None:
            return None, None, None
        
        # Find the semicolon after the closing brace
        semicolon_pos = content.find(';', end)
        if semicolon_pos == -1:
            return None, None, None
        
        block = content[start:semicolon_pos + 1]
        inner_content = content[match.end():end - 1]  # Content inside the braces
        return block, inner_content, (start, semicolon_pos + 1)
    
    programs_block, programs_content, positions = find_programs_block(new_content)
    if programs_block and programs_content is not None:
        # Check if package already exists as a program
        if not re.search(rf'^\s*{re.escape(package_name)}\s*\.\s*enable', programs_content, re.MULTILINE):
            # Add new program entry with proper indentation (6 spaces)
            new_entry = f'      {package_name}.enable = true;'
            new_programs_content = programs_content.rstrip() + '\n' + new_entry + '\n    '
            # Reconstruct the block
            new_block = 'programs = {\n' + new_programs_content + '};'
            if positions:
                start, end = positions
                new_content = new_content[:start] + new_block + new_content[end:]
    
    with open(target_file, 'w') as f:
        f.write(new_content)
    
    print(f"Added {package_name} to {target_file}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: add-package.py <package_name> <target_file>")
        sys.exit(1)
    
    package_name = sys.argv[1]
    target_file = sys.argv[2]
    
    add_package_to_file(package_name, target_file)