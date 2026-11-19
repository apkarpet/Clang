#!/usr/bin/env bash
# Build every program in this repository into build/ and report what compiled.
#
#   ./build.sh            build everything
#   ./build.sh labwork    build only one folder
#
# Each folder with C files is one program. If a folder holds several files that
# each have their own main(), every file is built as its own program.
# Older programs rely on pre-C99 habits (implicit declarations), so they are
# compiled as GNU C17 with -fpermissive. Programs that link against the course's
# Windows-only libi2p.dll are reported as skipped on Linux and macOS.
set -uo pipefail
cd "$(dirname "$0")"

ROOT="${1:-.}"
OUT=build
CFLAGS=(-std=gnu17 -fpermissive -w -O2)
mkdir -p "$OUT"

built=0 skipped=0 failed=0
compile() { # name, sources...
  local name="$1"; shift
  if gcc "${CFLAGS[@]}" -o "$OUT/$name" "$@" -lm 2>"$OUT/.err"; then
    printf '  ok      %s\n' "$name"; built=$((built + 1))
  elif grep -q "undefined reference" "$OUT/.err" && compgen -G "$(dirname "$1")/*i2p*" >/dev/null; then
    printf '  skipped %s (needs the course library libi2p.dll, Windows only)\n' "$name"; skipped=$((skipped + 1))
  else
    printf '  failed  %s: %s\n' "$name" "$(grep -m1 -E 'error' "$OUT/.err")"; failed=$((failed + 1))
  fi
}

while IFS= read -r dir; do
  mapfile -t srcs < <(find "$dir" -maxdepth 1 -name '*.c' | sort)
  base="$(echo "${dir#./}" | tr '/ ' '-_')"
  mains=$(grep -l -E '^\s*(int|void)?\s*main\s*\(' "${srcs[@]}" | wc -l)
  if [ "$mains" -gt 1 ]; then
    for s in "${srcs[@]}"; do compile "$base-$(basename "${s%.c}")" "$s"; done
  else
    compile "$base" "${srcs[@]}"
  fi
done < <(find "$ROOT" -path ./build -prune -o -name '*.c' -printf '%h\n' | sort -u)

rm -f "$OUT/.err"
echo
echo "$built built, $skipped skipped, $failed failed. Binaries are in $OUT/."
