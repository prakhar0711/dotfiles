# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
# pylint settings included to disable linting errors
config.load_autoconfig()
import subprocess
def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], capture_output=True, check=True, text=True)
    lines = x.stdout.split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

xresources = read_xresources("*")

c.colors.statusbar.normal.bg = "#00000000"
c.colors.statusbar.command.bg = "#00000000"
# c.colors.statusbar.normal.bg = xresources["*.background"]
# c.colors.statusbar.command.bg = xresources["*.background"]
c.colors.statusbar.command.fg = xresources["*.foreground"]
c.colors.statusbar.normal.fg = xresources["*color14"]
c.colors.statusbar.passthrough.fg = xresources["*color14"]
c.colors.statusbar.url.fg = xresources["*color13"]
c.colors.statusbar.url.success.https.fg = xresources["*color13"]
c.colors.statusbar.url.hover.fg = xresources["*color12"]
# c.statusbar.show = "always"
c.colors.tabs.even.bg = "#00000000" # transparent tabs!!
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.bar.bg = "#00000000"
# c.colors.tabs.even.bg = xresources["*.background"]
# c.colors.tabs.odd.bg = xresources["*.background"]
c.colors.tabs.even.fg = xresources["*color0"]
c.colors.tabs.odd.fg = xresources["*color0"]
c.colors.tabs.selected.even.bg = xresources["*.foreground"]
c.colors.tabs.selected.odd.bg = xresources["*.foreground"]
c.colors.tabs.selected.even.fg = xresources["*.background"]
c.colors.tabs.selected.odd.fg = xresources["*.background"]
c.colors.hints.bg = xresources["*.background"]
c.colors.hints.fg = xresources["*.foreground"]
c.tabs.show = "multiple"

c.colors.tabs.indicator.start = xresources["*color10"]
c.colors.tabs.indicator.stop = xresources["*color8"]
c.colors.completion.odd.bg = xresources["*.background"]
c.colors.completion.even.bg = xresources["*.background"]
c.colors.completion.fg = xresources["*.foreground"]
c.colors.completion.category.bg = xresources["*.background"]
c.colors.completion.category.fg = xresources["*.foreground"]
c.colors.completion.item.selected.bg = xresources["*.background"]
c.colors.completion.item.selected.fg = xresources["*.foreground"]

c.colors.messages.info.bg = xresources["*.background"]
c.colors.messages.info.fg = xresources["*.foreground"]
c.colors.messages.error.bg = xresources["*.background"]
c.colors.messages.error.fg = xresources["*.foreground"]
c.colors.downloads.error.bg = xresources["*.background"]
c.colors.downloads.error.fg = xresources["*.foreground"]

c.colors.downloads.bar.bg = xresources["*.background"]
c.colors.downloads.start.bg = xresources["*color10"]
c.colors.downloads.start.fg = xresources["*.foreground"]
c.colors.downloads.stop.bg = xresources["*color8"]
c.colors.downloads.stop.fg = xresources["*.foreground"]

c.colors.tooltip.bg = xresources["*.background"]
c.colors.webpage.bg = xresources["*.background"]
c.hints.border = xresources["*.foreground"]

c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 20
#
c.url.searchengines = {
# note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }

c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

config.load_autoconfig() # load settings done via the gui

c.auto_save.session = True # save tabs on quit/restart

# keybinding changes
config.bind('=', 'cmd-set-text -s :open --tab')
config.bind('pon', 'cmd-set-text -s :open --private')
config.bind('o', 'cmd-set-text -s :open --bg')
config.bind('h', 'history')
config.bind('cs', 'cmd-set-text -s :config-source')
config.bind('tH', 'config-cycle tabs.show multiple never')
config.bind('sH', 'config-cycle statusbar.show always never')
config.bind('T', 'hint links tab')
config.bind('pP', 'open -- {primary}')
config.bind('pp', 'open -- {clipboard}')
config.bind('pt', 'open -t -- {clipboard}')
config.bind('qm', 'macro-record')
config.bind('<ctrl-y>', 'spawn --userscript ytdl.sh')
config.bind('tT', 'config-cycle tabs.position top left')
config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('gm', 'tab-move')

# dark mode setup
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# styles, cosmetics
# c.content.user_stylesheets = "~/.config/qutebrowser/styles/youtube-tweaks.css"
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
# c.window.transparent = True # apparently not needed
c.tabs.width = '7%'

# fonts
c.fonts.default_family = ['JetBrainsMono Nerd Font']
c.fonts.default_size = '16pt'
c.fonts.web.family.fixed = 'JetBrainsMono Nerd Font'
c.fonts.web.family.sans_serif = 'JetBrainsMono Nerd Font'
c.fonts.web.family.serif = 'JetBrainsMono Nerd Font'
c.fonts.web.family.standard = 'JetBrainsMono Nerd Font'

# privacy - adjust these settings based on your preference
# config.set("completion.cmd_history_max_items", 0)
# config.set("content.private_browsing", True)
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)
# config.set("content.javascript.enabled", False) # tsh keybind to toggle

# Adblocking info -->
# For yt ads: place the greasemonkey script yt-ads.js in your greasemonkey folder (~/.config/qutebrowser/greasemonkey).
# The script skips through the entire ad, so all you have to do is click the skip button.
# Yeah it's not ublock origin, but if you want a minimal browser, this is a solution for the tradeoff.
# You can also watch yt vids directly in mpv, see qutebrowser FAQ for how to do that.
# If you want additional blocklists, you can get the python-adblock package, or you can uncomment the ublock lists here.

ublock_lists = [
    # EasyList (ads)
    "https://easylist.to/easylist/easylist.txt",

    # EasyPrivacy (tracking)
    "https://easylist.to/easylist/easyprivacy.txt",

    # uBlock filters – Annoyances
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",

    # uBlock filters – Badware
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",

    # uBlock filters – Privacy
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",

    # uBlock filters – Unbreak
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",

    # AdGuard Base
    "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt",

    # Fanboy's Annoyance List
    "https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt",
]
c.content.blocking.enabled = True
config.set("content.blocking.method", "both")
config.set("content.blocking.adblock.lists", ublock_lists)

config.set("content.blocking.hosts.lists", [
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
])
config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --key 79840569F02E9BF1C1EF6A19D1419B5F6E6C6CA5', mode='insert')
config.bind('pw', 'spawn --userscript qute-keepassxc --key 79840569F02E9BF1C1EF6A19D1419B5F6E6C6CA5', mode='normal')

config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End><Delete>", "insert")
config.bind("<Ctrl-x><Ctrl-e>", "open-editor", "insert")
