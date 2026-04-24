#!/bin/bash
# Split Warp into 4 panes and launch AI coding CLIs
# Layout:
#   Top-Left (empty)    | Top-Right (claude)
#   Bottom-Left (gemini)| Bottom-Right (codex)

tell_warp() {
  osascript -e "tell application \"System Events\" to tell process \"Warp\" to $1"
}

type_and_run() {
  # Combine keystroke + Enter in a single osascript call so they're atomic
  osascript -e "
    tell application \"System Events\"
      keystroke \"$1\"
      delay 0.1
      key code 36
    end tell
  "
}

# Split down (2 panes: top, bottom)
tell_warp 'keystroke "d" using {command down, shift down}'
sleep 0.5

# Now in bottom pane - split right (bottom-left, bottom-right)
tell_warp 'keystroke "d" using command down'
sleep 0.5

# Now in bottom-right - type codex command
type_and_run "codex"
sleep 0.3

# Move to bottom-left
tell_warp 'keystroke "[" using command down'
sleep 0.4

# Type gemini command in bottom-left
type_and_run "gemini"
sleep 0.3

# Move to top pane
tell_warp 'keystroke "[" using command down'
sleep 0.4

# Split top pane right (top-left, top-right)
tell_warp 'keystroke "d" using command down'
sleep 0.5

# Now in top-right - type claude command
type_and_run "claude"
sleep 0.3

# Move to top-left pane (the empty one)
tell_warp 'keystroke "[" using command down'
