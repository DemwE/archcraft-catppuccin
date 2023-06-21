# ------------------------------------------------------------------------------
# Catppuccin-Latte theme for Archcraft
# ------------------------------------------------------------------------------

# Colors
background='#eff1f5' #base
text='#4c4f69' #text


# Wallpaper
wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
wallpaper="$wdir/wallpaper"

# Polybar
polybar_font='Iosevka Nerd Font:size=10;3'
polybar_background='#dce0e8' #crust
polybar_date='#209fb5' #sapphire
polybar_network='#fe640b' #peach
polybar_volume='#8839ef' #mauve
polybar_current_workspace='#d20f39' #red
polybar_occupied_workspace='#209fb5' #sapphire
polybar_urgent_workspace='#df8e1d' #yellow
polybar_empty_workspace='#4c4f69' #text

# Rofi
rofi_font='Iosevka 10'
rofi_icon='Papirus-Apps'
rofi_background='#dce0e8' #crust
rofi_background_alt='#ccd0da' #surface0
rofi_foreground='#4c4f69' #text
rofi_selected='#8839ef' #mauve
rofi_active='#40a02b' #green
rofi_urgent='#df8e1d' #yellow

# Terminal
terminal_font_name='JetBrainsMono Nerd Font'
terminal_font_size='10'

wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
terminal_colors="$wdir/terminal-colors.yml"

# Geany
wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
geany_colors="$wdir/geany-colors.conf"
geany_colors_scheme='geany-colors.conf'
geany_font='JetBrains Mono 10'

# Appearance
gtk_font='Noto Sans 9'
gtk_theme='Catppuccin-Latte'
icon_theme='Luv-Folders-Dark'
cursor_theme='Vimix'

# Openbox
ob_theme='Catppuccin-Latte'
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
