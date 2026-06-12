Root Cause

The original script used multiline Bash brace expansion that was not interpreted correctly by Git Bash.

Git Bash attempted to treat the directory names as shell commands.

Resolution

Rewrote the script using explicit mkdir -p commands for each directory.

The scaffold was successfully created afterward.

Lessons Learned
Cross-platform shell compatibility matters.
Git Bash behavior may differ from Linux shell expectations.
Bootstrap scripts should be tested in the same environment where they will be executed.
Explicit commands are sometimes better than clever syntax when portability matters.
Future Improvements
Add validation checks for required tools.
Add a bootstrap verification script.
Add README documentation explaining repo structure.
EOF

cat > docs/journal/lessons-learned.md <<'EOF'

TITAN Lessons Learned
Lesson 001 - Shell Script Portability
Context

While creating the initial TITAN repository scaffold, the first Bash script failed in Git Bash.

Issue

Multiline brace expansion was interpreted incorrectly.

Impact

The scaffold failed before all directories could be created.

Resolution

The script was rewritten using explicit mkdir -p commands.

Takeaway

For cross-platform development, especially on Windows with Git Bash, prioritize clarity and portability over compact shell syntax.
EOF

cat > docs/architecture-decisions/ADR-001-platform-choice.md <<'EOF'

