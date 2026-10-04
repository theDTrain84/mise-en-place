# Two launchers. Source this file from ~/.zshrc:   source ~/<name>/launchers/front-of-house.zsh
# Replace <name> with the folder you made for the partnership. Only `front` loads the channel plugin.
front()   { cd ~/<name> && LANE=front   claude --channels plugin:telegram@claude-plugins-official "$@"; }
kitchen() { cd ~/<name> && LANE=kitchen claude "$@"; }
