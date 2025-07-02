.PHONY: setup dev test review clean help

# ヘルプ
help:
	@echo "三位一体開発コマンド:"
	@echo "  make setup    - 初期セットアップ"
	@echo "  make dev      - 開発サーバー起動"
	@echo "  make test     - テスト実行"
	@echo "  make review   - Geminiでコードレビュー"
	@echo "  make clean    - キャッシュクリア"

# セットアップ
setup:
	npm install
	mkdir -p .claude/commands
	@echo "Claude CodeとGemini CLIがインストールされていることを確認してください"
	@echo "  npm install -g @anthropic-ai/claude-code"
	@echo "  npm install -g @google/gemini-cli"

# 開発
dev:
	npm run dev

# テスト
test:
	npm test
	npm run typecheck
	npm run lint

# レビュー
review:
	@echo "変更内容をGeminiでレビューします..."
	git diff --cached > /tmp/changes.diff
	gemini -p "コードレビュー: $$(cat /tmp/changes.diff | head -100)"

# クリーンアップ
clean:
	rm -rf node_modules
	rm -rf .next
	rm -rf dist
	rm -f *.log
	npm cache clean --force

# スライド関連
slide:
	@read -p "スライドのトピックを入力: " topic; \
	claude "/project:generate-presentation $$topic"

slide-simple:
	@read -p "スライドのタイトルを入力: " title; \
	read -p "スライドの内容を入力: " content; \
	claude "/project:create-slide \"$$title\" \"$$content\""

slide-serve:
	@echo "スライドをブラウザでプレビュー..."
	@latest=$$(ls -t slides/generated/*.html 2>/dev/null | head -1); \
	if [ -n "$$latest" ]; then \
		python3 -m http.server 8080 --directory $$(dirname $$latest) & \
		echo "http://localhost:8080/$$(basename $$latest) でプレビュー可能"; \
	else \
		echo "HTMLスライドが見つかりません"; \
	fi

# ヘルプに追加
help:
	@echo "  make slide    - AI支援でプレゼンテーション生成"
	@echo "  make slide-simple - シンプルなスライド作成"
	@echo "  make slide-serve  - 最新のスライドをブラウザでプレビュー"
