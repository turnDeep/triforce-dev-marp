# スライド作成コマンド

入力内容をMarpスライドに変換します。

```bash
# 引数からタイトルとコンテンツを受け取る
TITLE="${1:-プレゼンテーション}"
CONTENT="$ARGUMENTS"

# 出力ディレクトリを作成
mkdir -p slides

# タイムスタンプ付きファイル名
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="slides/${TIMESTAMP}_${TITLE// /_}.md"

# Marpスライドのテンプレートを作成
cat > "$FILENAME" << 'EOF'
---
marp: true
theme: gaia
paginate: true
backgroundColor: #fff
---

# $TITLE

---

$CONTENT

---

# まとめ

- 主要ポイント1
- 主要ポイント2
- 主要ポイント3

EOF

# 内容を適切に置換
sed -i "s/\$TITLE/$TITLE/g" "$FILENAME"
sed -i "s/\$CONTENT/$CONTENT/g" "$FILENAME"

# PDFに変換（オプション）
marp "$FILENAME" -o "${FILENAME%.md}.pdf"

echo "スライドを作成しました: $FILENAME"
echo "PDFも生成しました: ${FILENAME%.md}.pdf"
```

引数: スライドのタイトルと内容
例: /project:create-slide "AI開発の未来" "AIとの協働開発について..."
