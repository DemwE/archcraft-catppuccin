# ------------------------------------------------------------------------------
# Catppuccin-Frappe theme for Archcraft
# ------------------------------------------------------------------------------

# Colors
background='#303446' #base
text='#c6d0f5' #text


# Wallpaper
wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
wallpaper="$wdir/wallpaper"

# Polybar
polybar_font='Iosevka Nerd Font:size=10;3'
polybar_background='#232634' #crust
polybar_date='#85c1dc' #sapphire
polybar_network='#ef9f76' #peach
polybar_volume='#ca9ee6' #mauve
polybar_current_workspace='#e78284' #red
polybar_occupied_workspace='#85c1dc' #sapphire
polybar_urgent_workspace='#e5c890' #yellow
polybar_empty_workspace='#c6d0f5' #text

# Rofi
rofi_font='Iosevka 10'
rofi_icon='Papirus-Apps'
rofi_background='#232634' #crust
rofi_background_alt='#414559' #surface0
rofi_foreground='#c6d0f5' #text
rofi_selected='#ca9ee6' #mauve
rofi_active='#a6d189' #green
rofi_urgent='#e5c890' #yellow

# Terminal
terminal_font_name='JetBrainsMono Nerd Font'
terminal_font_size='10'

wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
terminal_colors="$wdir/terminal-colors.yml"

# Geany
geany_colors='catppuccin-frappe.conf'
geany_font='JetBrains Mono 10'

# Appearance
gtk_font='Noto Sans 9'
gtk_theme='Catppuccin-Frappe'
icon_theme='Luv-Folders-Dark'
cursor_theme='Vimix'

# Openbox
ob_theme='Catppuccin-Frappe'
ob_layout='LMIC'
ob_font='JetBrains Mono'
ob_font_size='9'
ob_menu='menu-icons.xml'
ob_margin_t='44'
ob_margin_b='10'
ob_margin_l='10'
ob_margin_r='10'

# Dunst
dunst_width='300'
dunst_height='80'
dunst_offset='10x44'
dunst_origin='top-right'
dunst_font='Iosevka Custom 9'
dunst_border='1'
dunst_separator='2'
dunst_corner_radius='8'

# Plank
plank_hmode='auto'
plank_offset='0'
plank_position='bottom'
plank_theme='Transparent'
plank_icon_size='32'
plank_zoom_percent='120'

# Picom
picom_backend='glx'
picom_corner='8'
picom_shadow_r='14'
picom_shadow_o='0.30'
picom_shadow_x='-12'
picom_shadow_y='-12'
picom_blur_method='none'
picom_blur_strength='0'
