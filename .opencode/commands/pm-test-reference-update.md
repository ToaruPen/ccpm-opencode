---
description: Test the task reference update logic
---

# Test Reference Update

Test the task reference update logic used in epic-sync.

## Usage
```
/pm-test-reference-update
```

## Instructions

This is a development/testing command to verify the reference update logic works correctly.

### 1. Create Test Files

```bash
mkdir -p /tmp/test-refs
cd /tmp/test-refs

# Create task 001 with references
cat > 001.md << 'EOF'
---
name: Task One
status: open
depends_on: []
parallel: true
conflicts_with: [002, 003]
---
# Task One
EOF

# Create task 002
cat > 002.md << 'EOF'
---
name: Task Two
status: open
depends_on: [001]
parallel: false
conflicts_with: [003]
---
# Task Two
EOF

# Create task 003
cat > 003.md << 'EOF'
---
name: Task Three
status: open
depends_on: [001, 002]
parallel: false
conflicts_with: []
---
# Task Three
EOF
```

### 2. Create Mappings

Simulate issue number assignment:
```bash
cat > /tmp/task-mapping.txt << 'EOF'
001.md:42
002.md:43
003.md:44
EOF
```

### 3. Update References

Process files and update references:
```bash
while IFS=: read -r task_file task_number; do
  content=$(cat "$task_file")
  
  while IFS=: read -r old_num new_num; do
    content=$(echo "$content" | sed "s/\b$old_num\b/$new_num/g")
  done < /tmp/id-mapping.txt
  
  echo "$content" > "${task_number}.md"
done < /tmp/task-mapping.txt
```

### 4. Verify Results

Expected:
- 42.md: conflicts_with: [43, 44]
- 43.md: depends_on: [42], conflicts_with: [44]
- 44.md: depends_on: [42, 43]

### 5. Cleanup

```bash
rm -rf /tmp/test-refs
rm -f /tmp/task-mapping.txt /tmp/id-mapping.txt
echo "Test complete"
```
