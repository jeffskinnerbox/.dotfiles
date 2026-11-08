```bash
cat > ~/.local/share/applications/nvim-alacritty.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=NeoVim in Alacritty
Exec=env NVIM_APPNAME=nvim/active alacritty --title "NeoVim using vi" --option font.size=9.0 --option window.dimensions.columns=200 --option window.dimensions.lines=58 --command nvim %F
Terminal=false
Categories=Utility;TextEditor;
MimeType=text/plain;text/markdown;
EOF
```

1. **Validate it:** run `desktop-file-validate ~/.local/share/applications/nvim-alacritty.desktop`.
   It names the exact offending line in the file.
1. **Update it:** run `update-desktop-database ~/.local/share/applications`
1. **Set Default:** run `xdg-mime default nvim-alacritty.desktop text/plain text/markdown`
1. **Refresh the cache:** run `update-desktop-database ~/.local/share/applications`
   after any changes to the file.
