# Shared helpers for no-cape hooks. Sourced by the hook scripts, never executed.
#
# Two delivery modes, one knowledge base:
#   lean — the original no-cape stance: knowledge, visibility, model judgment.
#          Roster at SessionStart, keyword POINTERS at UserPromptSubmit.
#   cape — enforcement for model tiers that still need it: directive roster with
#          kernels at SessionStart, keyword DIRECTIVES at UserPromptSubmit, and a
#          verification gate at Stop.
#
# Mode resolution (first hit wins):
#   1. NO_CAPE_MODE env var ("lean" | "cape")
#   2. "mode" in <cwd>/.no-cape.json
#   3. Auto by model id: fable/mythos-class → lean, anything else → cape,
#      unknown → lean (fail open to the non-coercive mode).
#
# Only SessionStart receives the model id, so it resolves the mode once and
# caches it per session under ~/.no-cape/state/<session_id>; the other hooks
# read the cache.
#
# PERFORMANCE CONSTRAINT: UserPromptSubmit runs on every prompt, and on
# Windows (git-bash/MSYS) both external processes AND subshells are forks
# costing ~100-500ms each. So: pure bash builtins only (no grep/sed/cat/jq),
# and results returned via out-parameters (printf -v) instead of $(...)
# command substitution. Keep it that way.

# Read all of stdin into the named variable without spawning cat.
read_stdin() { # read_stdin <outvar>
    IFS= read -r -d '' "$1" || true
}

# Extract a top-level string field from a JSON document into <outvar>.
# Handles escaped characters inside the value; empty if the key is absent.
# (The value group can never cross an unescaped quote: neither alternative
# in (\\.|[^"\\]) matches a bare '"', so greedy matching is safe.)
json_str_v() { # json_str_v <outvar> <json> <key>
    local __re="\"$3\"[[:space:]]*:[[:space:]]*\"((\\\\.|[^\"\\\\])*)\""
    if [[ $2 =~ $__re ]]; then
        printf -v "$1" '%s' "${BASH_REMATCH[1]}"
    else
        printf -v "$1" ''
    fi
}

# Undo the JSON escapes that matter for shell use of an extracted value.
# Deliberately minimal — keep .no-cape.json values simple.
json_unescape_v() { # json_unescape_v <outvar> <string>
    local __s="$2"
    __s="${__s//\\\"/\"}"
    __s="${__s//\\n/ }"
    __s="${__s//\\t/ }"
    __s="${__s//\\\\/\\}"
    printf -v "$1" '%s' "$__s"
}

json_bool_true() { # json_bool_true <json> <key> — status return, no subshell
    local __re="\"$2\"[[:space:]]*:[[:space:]]*true"
    [[ $1 =~ $__re ]]
}

# Escape arbitrary text for embedding in a JSON string value.
escape_for_json_v() { # escape_for_json_v <outvar> <string>
    local __s="$2"
    __s="${__s//\\/\\\\}"
    __s="${__s//\"/\\\"}"
    __s="${__s//$'\n'/\\n}"
    __s="${__s//$'\r'/\\r}"
    __s="${__s//$'\t'/\\t}"
    printf -v "$1" '%s' "$__s"
}

NOCAPE_STATE_DIR="${HOME:-/tmp}/.no-cape/state"

nocape_config_v() { # nocape_config_v <outvar> <cwd> — project config, or empty
    local __f="$2/.no-cape.json" __c=""
    if [[ -n "$2" && -f "$__f" ]]; then
        IFS= read -r -d '' __c < "$__f" || true
    fi
    printf -v "$1" '%s' "$__c"
}

resolve_mode_v() { # resolve_mode_v <outvar> <cwd> <model-id>
    case "${NO_CAPE_MODE:-}" in
        lean|cape) printf -v "$1" '%s' "$NO_CAPE_MODE"; return ;;
    esac
    local __cfg __mode
    nocape_config_v __cfg "$2"
    json_str_v __mode "$__cfg" "mode"
    case "$__mode" in
        lean|cape) printf -v "$1" '%s' "$__mode"; return ;;
    esac
    case "$3" in
        "")               printf -v "$1" 'lean' ;;
        *fable*|*mythos*) printf -v "$1" 'lean' ;;
        *)                printf -v "$1" 'cape' ;;
    esac
}

# Persist the resolved mode for the hooks that never see the model id.
# Runs once per session (SessionStart), so the mkdir/find spawns are fine here.
cache_mode() { # cache_mode <session_id> <mode> <model-id>
    [ -n "$1" ] || return 0
    mkdir -p "$NOCAPE_STATE_DIR" 2>/dev/null || true
    printf 'mode=%s\nmodel=%s\n' "$2" "$3" > "$NOCAPE_STATE_DIR/$1" 2>/dev/null || true
    # Housekeeping: session state is worthless after the session; drop old files.
    find "$NOCAPE_STATE_DIR" -type f -mtime +7 -delete 2>/dev/null || true
}

# Read the cached mode; if the cache is missing (session started before the
# plugin was installed, state dir wiped), re-resolve without model info.
cached_mode_v() { # cached_mode_v <outvar> <session_id> <cwd>
    local __f="$NOCAPE_STATE_DIR/$2" __mode="" __line
    if [[ -n "$2" && -f "$__f" ]]; then
        while IFS= read -r __line || [ -n "$__line" ]; do
            case "$__line" in mode=*) __mode="${__line#mode=}"; break ;; esac
        done < "$__f"
        __mode="${__mode%$'\r'}"
        case "$__mode" in
            lean|cape) printf -v "$1" '%s' "$__mode"; return ;;
        esac
    fi
    resolve_mode_v "$1" "$3" ""
}
