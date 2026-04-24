#!/bin/bash
if [ -f "$HOME/Library/Preferences/com.knollsoft.Rectangle.plist" ]; then
    defaults import com.knollsoft.Rectangle "$HOME/Library/Preferences/com.knollsoft.Rectangle.plist"
fi
