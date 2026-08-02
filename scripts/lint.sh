#!/usr/bin/env bash
# LLM Wiki 结构健康检查(lint)
# 检查:frontmatter、wikilink 指向、孤儿页面、index.md 漂移、log.md 格式、topic hub 完整性。
# 用法: scripts/lint.sh   (退出码非 0 = 有问题)
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WIKI="$ROOT/wiki"
CATS="topics entities concepts sources syntheses answers"
problems=0

say() { printf '%s\n' "$*"; }

# 内容页列表(排除 _templates/_examples 与 index/log)
PAGES=()
while IFS= read -r f; do PAGES+=("$f"); done < <(find "$WIKI" -maxdepth 2 -name '*.md' \
  -not -path '*/_*' -not -name index.md -not -name log.md)

slug_exists() { # $1 = slug; 在任意分类目录下找 <slug>.md
  local slug="$1" cat
  for cat in $CATS; do
    [ -f "$WIKI/$cat/$slug.md" ] && return 0
  done
  return 1
}

# --- 1. frontmatter ---
for f in "${PAGES[@]}"; do
  if [ "$(head -n1 "$f")" != "---" ]; then
    say "no-frontmatter: $f"; problems=$((problems+1))
  fi
done

# --- 2. broken wikilinks(所有内容页 + index) ---
for f in "${PAGES[@]}" "$WIKI/index.md"; do
  [ -f "$f" ] || continue
  while IFS= read -r slug; do
    [ -z "$slug" ] && continue
    if ! slug_exists "$slug"; then
      say "broken-link: $f -> [[$slug]]"; problems=$((problems+1))
    fi
  done < <(grep -o '\[\[[^]|]*' "$f" | sed 's/\[\[//' | sort -u)
done

# --- 3. orphans(entities/concepts/syntheses 无入链;sources/answers 按设计是叶子) ---
for f in "$WIKI"/entities/*.md "$WIKI"/concepts/*.md "$WIKI"/syntheses/*.md; do
  [ -f "$f" ] || continue
  base="$(basename "$f" .md)"
  if ! grep -rl "\[\[$base" "${PAGES[@]}" "$WIKI/index.md" 2>/dev/null \
      | grep -qv "^$f$"; then
    say "orphan: $f(无入链,考虑合并/删除或加引用)"; problems=$((problems+1))
  fi
done

# --- 4. index.md 漂移:每个分类页面都应在 index 中;index 的链接必须可解析 ---
for cat in $CATS; do
  for f in "$WIKI/$cat"/*.md; do
    [ -f "$f" ] || continue
    base="$(basename "$f" .md)"
    if ! grep -q "\[\[$base" "$WIKI/index.md"; then
      say "index-missing: $base(页面存在但 index 未列出)"; problems=$((problems+1))
    fi
  done
done
while IFS= read -r slug; do
  [ -z "$slug" ] && continue
  if ! slug_exists "$slug"; then
    say "index-broken-link: [[$slug]]"; problems=$((problems+1))
  fi
done < <(grep -o '\[\[[^]|]*' "$WIKI/index.md" | sed 's/\[\[//' | sort -u)

# --- 5. log.md 条目日期格式 ---
if [ -f "$WIKI/log.md" ]; then
  while IFS= read -r line; do
    if [[ "$line" == "## "* ]] && ! [[ "$line" =~ ^##\ \[[0-9]{4}-[0-9]{2}-[0-9]{2}\] ]]; then
      say "log-bad-date: $line"; problems=$((problems+1))
    fi
  done < "$WIKI/log.md"
fi

# --- 6. frontmatter 的 topic 字段必须有对应 topics/<slug>.md ---
for f in "${PAGES[@]}"; do
  while IFS= read -r t; do
    [ -z "$t" ] && continue
    if [ ! -f "$WIKI/topics/$t.md" ]; then
      say "topic-missing: $f -> topic: $t(无 topics/$t.md)"; problems=$((problems+1))
    fi
  done < <(grep -o '^topic:.*' "$f" | sed 's/^topic:[[:space:]]*//' | tr ',' '\n' | tr -d '[] ' | grep -v '^$')
done

# --- 汇总 ---
if [ "$problems" -eq 0 ]; then
  say "lint clean ✓(${#PAGES[@]} pages checked)"
  exit 0
fi
say ""
say "✗ $problems issue(s) found"
exit 1
