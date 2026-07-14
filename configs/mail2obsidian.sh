#!/usr/bin/env bash
set -euo pipefail

email=$(cat)

msgid=$(echo "$email" \
  | grep -im1 '^message-id:' \
  | sed 's/^[Mm]essage-[Ii][Dd]:\s*//' \
  | tr -d '<>' \
  | xargs)

body=$(echo "$email" \
  | sed -n '/^$/,$ p' \
  | sed '1d' \
  | sed '/^--/d')

summary=$(echo "summarize this email into a task under 5 words. reply with only the summary:" \
  | cat - <(echo "$body") \
  | ollama run qwen2.5:1.5b 2>/dev/null \
  | head -1 \
  | tr -d '\n\r')

[ -z "$summary" ] && summary="untitled"

slug=$(echo "$summary" \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/[^a-z0-9]/-/g' \
  | sed 's/--*/-/g; s/^-//; s/-$//')

[ -z "$slug" ] && slug="task-$(date +%s)"

mkdir -p ~/vault/inbox

cat > ~/vault/inbox/"${slug}.md" << EOF
---
message-id: ${msgid}
---

- [ ] ${summary}

[open in aerc](aerc-todo://${msgid})

\`\`\`
${email}
\`\`\`
EOF
