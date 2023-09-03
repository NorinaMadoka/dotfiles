{config, ...}: let
  inherit (config.colorScheme) colors;
in {
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      dg = "https://duckduckgo.com/?q={}";
    };
    settings = {
      # https://github.com/tinted-theming/base16-qutebrowser/blob/main/templates/default.mustache
      colors.webpage.preferred_color_scheme = "dark";
      colors.completion.fg = "#${colors.base05}";
      colors.completion.odd.bg = "#${colors.base01}";
      colors.completion.even.bg = "#${colors.base00}";
      colors.completion.category.fg = "#${colors.base0A}";
      colors.completion.category.bg = "#${colors.base00}";
      colors.completion.category.border.top = "#${colors.base00}";
      colors.completion.category.border.bottom = "#${colors.base00}";
      colors.completion.item.selected.fg = "#${colors.base05}";
      colors.completion.item.selected.bg = "#${colors.base02}";
      colors.completion.item.selected.border.top = "#${colors.base02}";
      colors.completion.item.selected.border.bottom = "#${colors.base02}";
      colors.completion.item.selected.match.fg = "#${colors.base0B}";
      colors.completion.match.fg = "#${colors.base0B}";
      colors.completion.scrollbar.fg = "#${colors.base05}";
      colors.completion.scrollbar.bg = "#${colors.base00}";
      colors.contextmenu.disabled.bg = "#${colors.base01}";
      colors.contextmenu.disabled.fg = "#${colors.base04}";
      colors.contextmenu.menu.bg = "#${colors.base00}";
      colors.contextmenu.menu.fg = "#${colors.base05}";
      colors.contextmenu.selected.bg = "#${colors.base02}";
      colors.contextmenu.selected.fg = "#${colors.base05}";
      colors.downloads.bar.bg = "#${colors.base00}";
      colors.downloads.start.fg = "#${colors.base00}";
      colors.downloads.start.bg = "#${colors.base0D}";
      colors.downloads.stop.fg = "#${colors.base00}";
      colors.downloads.stop.bg = "#${colors.base0C}";
      colors.downloads.error.fg = "#${colors.base08}";
      colors.hints.fg = "#${colors.base00}";
      colors.hints.bg = "#${colors.base0A}";
      colors.hints.match.fg = "#${colors.base05}";
      colors.keyhint.fg = "#${colors.base05}";
      colors.keyhint.suffix.fg = "#${colors.base05}";
      colors.keyhint.bg = "#${colors.base00}";
      colors.messages.error.fg = "#${colors.base00}";
      colors.messages.error.bg = "#${colors.base08}";
      colors.messages.error.border = "#${colors.base08}";
      colors.messages.warning.fg = "#${colors.base00}";
      colors.messages.warning.bg = "#${colors.base0E}";
      colors.messages.warning.border = "#${colors.base0E}";
      colors.messages.info.fg = "#${colors.base05}";
      colors.messages.info.bg = "#${colors.base00}";
      colors.messages.info.border = "#${colors.base00}";
      colors.prompts.fg = "#${colors.base05}";
      colors.prompts.border = "#${colors.base00}";
      colors.prompts.bg = "#${colors.base00}";
      colors.prompts.selected.bg = "#${colors.base02}";
      colors.prompts.selected.fg = "#${colors.base05}";
      colors.statusbar.normal.fg = "#${colors.base0B}";
      colors.statusbar.normal.bg = "#${colors.base00}";
      colors.statusbar.insert.fg = "#${colors.base00}";
      colors.statusbar.insert.bg = "#${colors.base0D}";
      colors.statusbar.passthrough.fg = "#${colors.base00}";
      colors.statusbar.passthrough.bg = "#${colors.base0C}";
      colors.statusbar.private.fg = "#${colors.base00}";
      colors.statusbar.private.bg = "#${colors.base01}";
      colors.statusbar.command.fg = "#${colors.base05}";
      colors.statusbar.command.bg = "#${colors.base00}";
      colors.statusbar.command.private.fg = "#${colors.base05}";
      colors.statusbar.command.private.bg = "#${colors.base00}";
      colors.statusbar.caret.fg = "#${colors.base00}";
      colors.statusbar.caret.bg = "#${colors.base0E}";
      colors.statusbar.caret.selection.fg = "#${colors.base00}";
      colors.statusbar.caret.selection.bg = "#${colors.base0D}";
      colors.statusbar.progress.bg = "#${colors.base0D}";
      colors.statusbar.url.fg = "#${colors.base05}";
      colors.statusbar.url.error.fg = "#${colors.base08}";
      colors.statusbar.url.hover.fg = "#${colors.base05}";
      colors.statusbar.url.success.http.fg = "#${colors.base0C}";
      colors.statusbar.url.success.https.fg = "#${colors.base0B}";
      colors.statusbar.url.warn.fg = "#${colors.base0E}";
      colors.tabs.bar.bg = "#${colors.base00}";
      colors.tabs.indicator.start = "#${colors.base0D}";
      colors.tabs.indicator.stop = "#${colors.base0C}";
      colors.tabs.indicator.error = "#${colors.base08}";
      colors.tabs.odd.fg = "#${colors.base05}";
      colors.tabs.odd.bg = "#${colors.base01}";
      colors.tabs.even.fg = "#${colors.base05}";
      colors.tabs.even.bg = "#${colors.base00}";
      colors.tabs.pinned.even.bg = "#${colors.base0C}";
      colors.tabs.pinned.even.fg = "#${colors.base07}";
      colors.tabs.pinned.odd.bg = "#${colors.base0B}";
      colors.tabs.pinned.odd.fg = "#${colors.base07}";
      colors.tabs.pinned.selected.even.bg = "#${colors.base02}";
      colors.tabs.pinned.selected.even.fg = "#${colors.base05}";
      colors.tabs.pinned.selected.odd.bg = "#${colors.base02}";
      colors.tabs.pinned.selected.odd.fg = "#${colors.base05}";
      colors.tabs.selected.odd.fg = "#${colors.base05}";
      colors.tabs.selected.odd.bg = "#${colors.base02}";
      colors.tabs.selected.even.fg = "#${colors.base05}";
      colors.tabs.selected.even.bg = "#${colors.base02}";
    };
  };
}
