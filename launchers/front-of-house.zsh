# Three shell functions. Source this file from ~/.zshrc:   source ~/<name>/launchers/front-of-house.zsh
# Replace <name> with the folder you made for the partnership.
# The channel plugin stays OFF in user and project settings. Only `front` turns it on, for its own
# session, via --settings front.json (the --channels flag alone cannot enable a disabled plugin).
# `bridge` frees the line when another process took it; then /mcp -> telegram -> reconnect in the front window.
bridge()  { pkill -f "claude-plugins-official/telegram/" 2>/dev/null; sed -i '' 's/"telegram@claude-plugins-official": true/"telegram@claude-plugins-official": false/' ~/.claude/settings.json; rm -f ~/.claude/channels/telegram/bot.pid; echo "line freed; in the front window run /mcp -> telegram -> reconnect"; }
# front: if a live front window already holds the line, this window opens as kitchen instead (pass --front to force).
front()   { cd ~/<name>; local pf=~/.claude/channels/telegram/bot.pid
            if [ "$1" != "--front" ] && [ -f "$pf" ] && kill -0 "$(cat "$pf" 2>/dev/null)" 2>/dev/null; then
              echo "front of house is already open (bot pid $(cat "$pf")); opening this window as kitchen"; LANE=kitchen claude "$@"; return; fi
            [ "$1" = "--front" ] && shift
            bridge >/dev/null && LANE=front claude --settings ~/<name>/.claude/front.json --channels plugin:telegram@claude-plugins-official "$@"; }
kitchen() { cd ~/<name> && LANE=kitchen claude "$@"; }
