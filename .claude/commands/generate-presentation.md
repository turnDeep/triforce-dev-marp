# AI支援プレゼンテーション生成

トピックを指定すると、Geminiと協力して構造化されたプレゼンテーションを生成します。

```bash
TOPIC="$ARGUMENTS"

# Geminiに構成を考えてもらう
STRUCTURE=$(gemini -p "以下のトピックについて、5-7枚のスライドプレゼンテーションの構成を提案してください。各スライドのタイトルと主要ポイント（箇条書き3-4個）を含めてください。Markdown形式で出力してください。トピック: $TOPIC")

# 出力ディレクトリとファイル名
mkdir -p slides/generated
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="slides/generated/${TIMESTAMP}_$(echo $TOPIC | tr ' ' '_' | tr '[:upper:]' '[:lower:]').md"

# Marpヘッダーを追加
cat > "$FILENAME" << 'EOF'
---
marp: true
theme: gaia
paginate: true
backgroundColor: #fff
backgroundImage: linear-gradient(to bottom right, #f6f6f6, #e6e6e6)
style: |
  section {
    font-family: 'Helvetica Neue', Arial, sans-serif;
  }
  h1 {
    color: #2d3748;
    font-size: 2.5em;
  }
  h2 {
    color: #4a5568;
    font-size: 1.8em;
  }
  li {
    font-size: 1.2em;
    line-height: 1.8;
  }
  code {
    background-color: #f7fafc;
    padding: 0.2em 0.4em;
    border-radius: 3px;
  }
---

EOF

# Geminiの出力を追加
echo "$STRUCTURE" >> "$FILENAME"

# フッターを追加
cat >> "$FILENAME" << 'EOF'

---

# ご清聴ありがとうございました

質問やディスカッションはこちらで

EOF

# 複数フォーマットで出力
echo "生成中..."
marp "$FILENAME" -o "${FILENAME%.md}.pdf"
marp "$FILENAME" -o "${FILENAME%.md}.html"
marp "$FILENAME" -o "${FILENAME%.md}.pptx"

echo "プレゼンテーションを生成しました:"
echo "- Markdown: $FILENAME"
echo "- PDF: ${FILENAME%.md}.pdf"
echo "- HTML: ${FILENAME%.md}.html"
echo "- PowerPoint: ${FILENAME%.md}.pptx"
```

引数: プレゼンテーションのトピック
例: /project:generate-presentation "三位一体開発フレームワークの紹介"
