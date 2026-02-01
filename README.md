# cc-sandbox

用 Docker 建一個「AI CLI 工具沙盒」，用來跑 Claude Code / Codex / Gemini CLI；登入與設定透過 volume 掛回本機持久化，容器可常駐。

## 常用套件

- Ubuntu 22.04 + 常用工具
- Python
- Node.js
- AI CLI：`Claude Code、Codex、Gemini CLI`

## 使用方式

1) 啟動

```bash
docker compose up -d
```

2) 進入容器

```bash
docker exec -it cc-sandbox bash
```

## 持久化（Volumes）

`docker-compose.yml` 會掛載以下路徑：

- `${HOME}/.claude` → `/home/user/.claude`
- `${HOME}/.codex` → `/home/user/.codex`
- `${HOME}/.gemini` → `/home/user/.gemini`

建議先建立資料夾：

```bash
mkdir -p ~/.claude ~/.codex ~/.gemini
```

## 常用指令

```bash
docker compose up -d
docker compose down
docker compose logs -f
docker compose up -d --build
```