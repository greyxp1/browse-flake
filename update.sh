#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
candidate=$(mktemp sources.json.XXXXXX)
trap 'rm -f "$candidate"' EXIT

curl -fsSL https://anoma.ly/release/browse/cli/stable.json |
  jq -e '
    def artifact($target):
      .targets[$target]
      | select(.url | startswith("/release/browse/files/"))
      | select(.sha256 | test("^[a-f0-9]{64}$"))
      | {url: ("https://anoma.ly" + .url), sha256};

    .release
    | select(.version | test("^[0-9]+\\.[0-9]+\\.[0-9]+$"))
    | {
        version,
        "x86_64-linux": artifact("linux-x64"),
        "aarch64-linux": artifact("linux-arm64")
      }
  ' > "$candidate"
mv "$candidate" sources.json
