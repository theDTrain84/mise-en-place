# Changelog

- v1.3, Oct 6, 2026: the phone line, corrected. `front` opens as kitchen when a front window is already alive (`front --front` forces). The plugin stays off in user AND project settings; `front` turns it on for its own session with `--settings .claude/front.json` (the `--channels` flag alone cannot enable a disabled plugin). New `bridge` function frees the line. Never toggle the plugin in the desktop app. Template added: `templates/front.json`.
- v1, October 4, 2026: first release. The guide (SETUP.md), the templates, the wake hook, the launchers, and "The table" explainer.
- v1.1, Oct 4, 2026: the phone line is loaded only by the front launcher; never enable the plugin in settings. Local voice recipe added (docs/voice.md).
- v1.2, Oct 4, 2026: docs/the-table updated to the published piece (tools.dnsc.ai/civic/the-table).
