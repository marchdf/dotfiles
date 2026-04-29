#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

errors=0

log_error() {
    echo "ERROR: $1"
    ((errors++)) || true
}

log_warn() {
    echo "WARN: $1"
}

log_ok() {
    echo "OK: $1"
}

# Find all bash scripts (by shebang)
find_bash_scripts() {
    find "${REPO_ROOT}" -type f ! -path '*/.git/*' -exec grep -l '^#!.*bash' {} \; 2>/dev/null
}

# Find all zsh scripts (by name pattern, excluding p10k)
find_zsh_scripts() {
    find "${REPO_ROOT}" -type f ! -path '*/.git/*' \( -name "*.zsh" -o -name "*.zsh.tmpl" -o -name "*zshrc*" \) ! -name "*p10k*" 2>/dev/null
}

# Find all scripts (bash + zsh)
find_scripts() {
    find_bash_scripts
    find_zsh_scripts
}

# All bash shebangs should be #!/usr/bin/env bash
check_shebangs() {
    echo "=== Checking shebangs ==="
    local bad_shebangs=0

    while IFS= read -r file; do
        # Find the shebang line (may be after chezmoi conditional on line 1-3)
        shebang=$(head -5 "$file" | grep '^#!/' | head -1)

        if [[ "$shebang" != "#!/usr/bin/env bash" ]]; then
            log_error "$file: non-standard shebang: $shebang"
            ((bad_shebangs++)) || true
        fi
    done < <(find_bash_scripts)

    if [[ $bad_shebangs -eq 0 ]]; then
        log_ok "All shebangs are #!/usr/bin/env bash"
    fi
}

# No backticks in code (excluding comments)
check_backticks() {
    echo ""
    echo "=== Checking for backticks ==="
    local found=0
    local bt='`'

    # Check both bash and zsh scripts
    while IFS= read -r file; do
        # Skip this linter script (contains backtick literal for searching)
        [[ "$file" == *"chezmoi_shell_linter"* ]] && continue

        # Check for backticks not in comments (handle whitespace before #)
        if grep -n "${bt}" "$file" | grep -v '^[^:]*:[[:space:]]*#' | grep -q "${bt}"; then
            matches=$(grep -n "${bt}" "$file" | grep -v '^[^:]*:[[:space:]]*#' || true)
            if [[ -n "$matches" ]]; then
                log_error "$file: contains backticks (use \$() instead)"
                echo "$matches" | head -3
                ((found++)) || true
            fi
        fi
    done < <(find_scripts)

    if [[ $found -eq 0 ]]; then
        log_ok "No backticks found"
    fi
}

# Run shellcheck on all bash scripts (renders through chezmoi first)
check_shellcheck() {
    echo ""
    echo "=== Running shellcheck ==="

    if ! command -v shellcheck &>/dev/null; then
        log_warn "shellcheck not installed, skipping"
        return
    fi

    if ! command -v chezmoi &>/dev/null; then
        log_warn "chezmoi not installed, skipping"
        return
    fi

    local checked=0
    local failed=0
    local skipped=0

    while IFS= read -r file; do
        # Render through chezmoi (works for both .tmpl and plain files)
        rendered=$(chezmoi execute-template <"$file" 2>/dev/null || true)

        # Skip if empty (OS-conditional template on wrong OS)
        if [[ -z "$rendered" ]] || [[ "$rendered" =~ ^[[:space:]]*$ ]]; then
            ((skipped++)) || true
            continue
        fi

        ((checked++)) || true
        if ! echo "$rendered" | shellcheck --severity=style -s bash - 2>&1; then
            log_error "shellcheck failed: $file"
            ((failed++)) || true
        fi
    done < <(find_bash_scripts)

    if [[ $failed -eq 0 ]]; then
        log_ok "shellcheck passed on $checked files ($skipped skipped)"
    else
        log_error "shellcheck failed on $failed/$checked files"
    fi
}

# Run shfmt on all scripts (renders through chezmoi first)
check_shfmt() {
    echo ""
    echo "=== Running shfmt ==="

    if ! command -v shfmt &>/dev/null; then
        log_warn "shfmt not installed, skipping"
        return
    fi

    if ! command -v chezmoi &>/dev/null; then
        log_warn "chezmoi not installed, skipping"
        return
    fi

    # Check if shfmt supports zsh
    local shfmt_has_zsh=false
    if echo "" | shfmt -ln=zsh -d 2>/dev/null; then
        shfmt_has_zsh=true
    fi

    local checked=0
    local failed=0
    local skipped=0

    # Build list of zsh files for lookup
    local -A zsh_files
    while IFS= read -r file; do
        zsh_files["$file"]=1
    done < <(find_zsh_scripts)

    # Check all scripts (bash + zsh)
    while IFS= read -r file; do
        # Determine language
        local lang="bash"
        if [[ -n "${zsh_files[$file]:-}" ]]; then
            lang="zsh"
        fi

        # Skip zsh if shfmt doesn't support it
        if [[ "$lang" == "zsh" ]] && [[ "$shfmt_has_zsh" == "false" ]]; then
            ((skipped++)) || true
            continue
        fi

        # Render through chezmoi (works for both .tmpl and plain files)
        rendered=$(chezmoi execute-template <"$file" 2>/dev/null || true)

        # Skip if empty (OS-conditional template on wrong OS)
        if [[ -z "$rendered" ]] || [[ "$rendered" =~ ^[[:space:]]*$ ]]; then
            ((skipped++)) || true
            continue
        fi

        ((checked++)) || true
        if ! echo "$rendered" | shfmt -ln="$lang" -i 4 -d 2>&1; then
            log_error "shfmt ($lang) found issues: $file"
            ((failed++)) || true
        fi
    done < <(find_scripts)

    local msg="shfmt passed on $checked files ($skipped skipped)"
    if [[ "$shfmt_has_zsh" == "false" ]]; then
        msg="$msg - zsh not supported by this shfmt version"
    fi

    if [[ $failed -eq 0 ]]; then
        log_ok "$msg"
    else
        log_error "shfmt found formatting issues in $failed/$checked files"
    fi
}

# Main
main() {
    echo "Linting shell scripts in ${REPO_ROOT}"
    echo ""
    echo "Bash scripts:"
    find_bash_scripts | sort | sed 's|^|  |'
    echo ""
    echo "Zsh scripts:"
    find_zsh_scripts | sort | sed 's|^|  |'
    echo ""

    check_shebangs
    check_backticks
    check_shellcheck
    check_shfmt

    echo ""
    if [[ $errors -gt 0 ]]; then
        echo "Linting failed with $errors error(s)"
        exit 1
    else
        echo "Linting passed"
        exit 0
    fi
}

main "$@"
