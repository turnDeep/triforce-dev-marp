# 📊 Marpスライド機能

## 基本的な使い方

### 1. クイックスライド作成
```bash
# Claudeに直接依頼
claude
> 「AIの未来」についてのプレゼンテーションを作成して

# またはコマンドで
make slide
```

### 2. カスタムスライド作成
```bash
# 特定の内容でスライドを作成
/project:create-slide "プロジェクト進捗" "
- タスクA: 完了
- タスクB: 進行中
- タスクC: 未着手
"
```

### 3. プレビューと編集
```bash
# 生成されたスライドをプレビュー
make slide-serve

# VS Codeで編集（Marp拡張機能でリアルタイムプレビュー）
code slides/generated/最新のファイル.md
```

## ワークフロー例

### プレゼン準備フロー
1. **アイデア整理**
   ```
   claude> 機械学習の基礎についてプレゼンを作りたい
   ```

2. **自動生成**
   - ClaudeがGeminiと相談して構成を決定
   - Marp形式で出力

3. **レビューと調整**
   ```
   claude> 3枚目のスライドにグラフを追加して
   ```

4. **エクスポート**
   - PDF: 配布用
   - HTML: Web公開用
   - PPTX: 編集可能な形式

## カスタマイズ

### テーマの変更
```markdown
---
marp: true
theme: uncover  # gaia, uncover, default から選択
class: invert   # 暗いテーマ
---
```

### カスタムCSS
```markdown
---
marp: true
style: |
  section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  }
---
```

## Tips

- **画像の追加**: `![](path/to/image.png)`
- **背景画像**: `![bg](path/to/background.png)`
- **分割レイアウト**: `![bg left](image.png)`で左右分割
- **アニメーション**: `<!-- _class: lead -->`でスライド種別指定
