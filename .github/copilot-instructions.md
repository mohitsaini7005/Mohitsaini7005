# GitHub Profile Repository - mohitsaini7005/Mohitsaini7005

This is a GitHub profile repository that displays on Mohit Saini's GitHub profile page. It contains personal information, tech stack, project highlights, and animated contribution visualizations.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Repository Setup and Dependencies
- Install Python markdown processor: `pip3 install markdown`
- yamllint is pre-installed for YAML validation
- No traditional build tools required - this is a profile repository, not a software project

### Core Validation Commands
Always run these commands to validate changes before committing:

```bash
# Validate README.md markdown syntax and parsing
python3 -c "
import markdown
with open('README.md', 'r') as f:
    content = f.read()
html = markdown.markdown(content)
print('✓ README.md parsed successfully -', len(html), 'characters of HTML')
"
```

```bash
# Validate GitHub Actions workflow
python3 -c "
import yaml
with open('.github/workflows/snake.yml', 'r') as f:
    workflow = yaml.safe_load(f)
print('✓ Workflow YAML parsed successfully')
print('✓ Workflow name:', workflow.get('name'))
jobs = workflow.get('jobs', {})
print('✓ Found jobs:', list(jobs.keys()))
"
```

```bash
# Lint YAML workflow (warnings are acceptable)
yamllint .github/workflows/snake.yml
```

**Timing Expectations:**
- README markdown validation: < 1 second
- YAML workflow validation: < 1 second  
- YAML linting: < 1 second

## Repository Structure

### Key Files
- `README.md` - Main profile content with personal info, tech stack badges, projects
- `.github/workflows/snake.yml` - GitHub Actions workflow that generates contribution snake animation
- `snake.yml` - Empty file (can be ignored or removed)

### GitHub Actions Workflow
The snake.yml workflow:
- Runs daily at midnight UTC (cron schedule)
- Can be manually triggered (workflow_dispatch)  
- Triggers on pushes to main branch
- **Timeout: 10 minutes** - NEVER CANCEL, let it complete
- Generates contribution snake animations and deploys to 'output' branch
- **Cannot be run locally** - requires GitHub Actions environment

## Validation Scenarios

After making changes, ALWAYS validate:

1. **README Content Validation:**
   ```bash
   # Check markdown parsing
   python3 -c "
   import markdown, re
   with open('README.md', 'r') as f:
       content = f.read()
   html = markdown.markdown(content)
   print('Markdown parsing successful')
   
   # Check for broken badge/link syntax
   lines = content.split('\n')
   for i, line in enumerate(lines, 1):
       if '[' in line and ']' in line and '(' in line and ')' in line:
           open_sq = line.count('[')
           close_sq = line.count(']') 
           open_paren = line.count('(')
           close_paren = line.count(')')
           if open_sq != close_sq or open_paren != close_paren:
               print(f'Warning: Line {i} may have unmatched brackets')
   print('README validation complete')
   "
   ```

2. **Workflow Integrity Check:**
   ```bash
   # Ensure workflow structure is intact
   python3 -c "
   import yaml
   with open('.github/workflows/snake.yml', 'r') as f:
       workflow = yaml.safe_load(f)
   
   # Verify essential components
   assert 'name' in workflow, 'Missing workflow name'
   assert 'jobs' in workflow, 'Missing jobs section'
   assert 'generate' in workflow['jobs'], 'Missing generate job'
   
   generate_job = workflow['jobs']['generate']
   assert 'steps' in generate_job, 'Missing steps in generate job'
   assert len(generate_job['steps']) >= 3, 'Missing required steps'
   
   print('Workflow structure validation passed')
   "
   ```

3. **Profile Display Test:**
   After editing README.md, manually verify:
   - Badges render correctly by checking a few shield.io URLs in browser
   - Social links work (LinkedIn, GitHub, Instagram, etc.)
   - No broken formatting or missing images
   
   **Note:** URL accessibility testing may be limited in sandboxed environments. Focus on syntax validation and manual verification when possible.

## Common Tasks

### Updating Tech Stack Badges
Tech stack badges use shields.io format:
```markdown
![TechName](https://img.shields.io/badge/TechName-HexColor?style=for-the-badge&logo=tech&logoColor=white)
```

Always validate after adding new badges:
```bash
python3 -c "
import re
with open('README.md', 'r') as f:
    content = f.read()
badges = re.findall(r'!\[([^\]]*)\]\(https://img\.shields\.io/badge/[^)]+\)', content)
print(f'Found {len(badges)} shield.io badges')
for badge in badges[-5:]:  # Show last 5 added
    print(f'- {badge}')
"
```

### Updating Project Descriptions
Project sections are in markdown format around line 63-77:
- Keep descriptions concise (1-2 bullet points each)
- Maintain consistent formatting with existing entries
- Always validate markdown after changes

### Modifying Social Links
Social links appear in two sections:
- "Connect with Me" section (~lines 93-101) 
- "Social Links" section (~lines 104-108)
- Update both sections when adding/removing platforms
- Test actual URLs manually

### GitHub Actions Workflow Modifications
- **CRITICAL**: Do not modify the workflow unless necessary
- If changes are required, always validate YAML structure first
- The workflow depends on GitHub secrets (GITHUB_TOKEN) and specific action versions
- **Timeout is 10 minutes** - do not reduce this value

## Important Notes

- This repository displays on the GitHub profile page - changes are immediately visible
- The snake animation updates automatically via GitHub Actions
- No build, compile, or deployment steps required for README changes
- Always verify changes don't break markdown rendering before committing
- The 'output' branch contains generated snake animations - do not modify manually

## Troubleshooting

**README not displaying properly:**
1. Check markdown syntax with validation commands above
2. Verify image URLs are accessible
3. Check for unmatched brackets in links

**Snake animation not updating:**
1. Check workflow runs in GitHub Actions tab
2. Verify workflow file integrity with validation commands
3. Ensure repository has proper permissions for GitHub Actions

**Badge issues:**
1. Test shield.io URLs manually in browser
2. Check URL encoding for special characters
3. Verify badge syntax matches existing working examples

## Repository-Specific Commands Reference

```bash
# Quick repository overview
ls -la /home/runner/work/Mohitsaini7005/Mohitsaini7005

# Expected output:
# .git/
# .github/
# README.md (main profile content)  
# snake.yml (empty, can ignore)

# Complete repository validation (comprehensive check)
python3 -c "
print('=== GitHub Profile Repository Validation ===')
import markdown, yaml, re, os

# 1. README validation
print('\\n1. README.md Validation:')
try:
    with open('README.md', 'r') as f:
        content = f.read()
    html = markdown.markdown(content)
    print(f'   ✓ Markdown parsing successful ({len(html)} chars)')
    
    badges = re.findall(r'!\[([^\]]*)\]\(https://img\.shields\.io/badge/[^)]+\)', content)
    print(f'   ✓ Found {len(badges)} shield.io badges')
    
    lines = content.split('\\n')
    issues = 0
    for i, line in enumerate(lines, 1):
        if '[' in line and ']' in line and '(' in line and ')' in line:
            if line.count('[') != line.count(']') or line.count('(') != line.count(')'):
                issues += 1
    
    if issues == 0:
        print('   ✓ No syntax issues detected')
    else:
        print(f'   ⚠️ {issues} potential syntax issues')
        
except Exception as e:
    print(f'   ✗ README validation failed: {e}')

# 2. Workflow validation  
print('\\n2. GitHub Actions Workflow:')
try:
    with open('.github/workflows/snake.yml', 'r') as f:
        workflow = yaml.safe_load(f)
    
    print(f'   ✓ Workflow: {workflow.get(\"name\", \"Unknown\")}')
    jobs = workflow.get('jobs', {})
    print(f'   ✓ Jobs: {list(jobs.keys())}')
    
    if 'generate' in jobs:
        timeout = jobs['generate'].get('timeout-minutes', 'Not set')
        print(f'   ✓ Timeout: {timeout} minutes')
        steps = len(jobs['generate'].get('steps', []))
        print(f'   ✓ Steps: {steps}')
    
except Exception as e:
    print(f'   ✗ Workflow validation failed: {e}')

# 3. File structure
print('\\n3. Repository Structure:')
required_files = ['README.md', '.github/workflows/snake.yml']
for file_path in required_files:
    if os.path.exists(file_path):
        print(f'   ✓ {file_path}')
    else:
        print(f'   ✗ {file_path} missing')

print('\\n=== Validation Complete ===')
"
```