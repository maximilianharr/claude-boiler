# claude-boiler
Boilerplate for claude code


Register Claude Code plugin marketpalce
```bash
/plugin marketplace add anthropics/skills
/plugin marketplace add DietrichGebert/ponytail
```

Install skills
```bash
/plugin install frontend-design@claude-plugins-official
/plugin install skill-creator@claude-plugins-official
/plugin install ponytail@ponytail
```

```npx skills@latest add mattpocock/skills```

Make the local skills and settings (hooks, permissions, statusline) available in every repo, on every machine: clone this repo once, then symlink the individual pieces into your user-level `~/.claude`. `git pull` here keeps all machines in sync.

Don't symlink `~/.claude` itself — it also holds `.credentials.json`, session history, and other per-machine state that must never end up in a (public) git repo. Symlink only these two:
```bash
git clone https://github.com/maximilianharr/claude-boiler.git ~/ws/claude-boiler
ln -s ~/ws/claude-boiler/.claude/skills ~/.claude/skills
ln -s ~/ws/claude-boiler/.claude/settings.json ~/.claude/settings.json
```
Hook commands in `settings.json` use `$HOME/ws/claude-boiler/...` absolute paths for this reason — as user-level config they run with the cwd of whatever repo you're in, not this one.

Install mcps
```
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
```
