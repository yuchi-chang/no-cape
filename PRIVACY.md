# Privacy Policy

**no-cape collects nothing.**

no-cape is a fully local Claude Code plugin. In detail:

- It does **not** collect, store, or transmit any personal data, usage data, or telemetry.
- It makes **no network requests** of any kind. All components (skills, hooks, commands) are plain text and local shell scripts.
- Cape mode's prompt keyword scanning runs entirely inside a local hook process on your machine. Prompt content never leaves your machine through this plugin.
- The only files it writes are per-session mode-cache files under `~/.no-cape/state/` on your own machine (containing the session id, resolved mode, and model id). These are deleted automatically after 7 days.

Questions: open an issue at <https://github.com/yuchi-chang/no-cape/issues>.
