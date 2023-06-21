#!/usr/bin/env bash

## Script To Apply Themes

## Theme ------------------------------------
TDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="${TDIR##*/}"

source "$HOME"/.config/openbox-themes/themes/"$THEME"/theme.bash

## Directories ------------------------------
PATH_CONF="$HOME/.config"
PATH_TERM="$PATH_CONF/alacritty"
PATH_DUNST="$PATH_CONF/dunst"
PATH_GEANY="$PATH_CONF/geany"
PATH_OBOX="$PATH_CONF/openbox"
PATH_OBTS="$PATH_CONF/openbox-themes"
PATH_PBAR="$PATH_OBTS/themes/$THEME/polybar"
PATH_ROFI="$PATH_OBTS/themes/$THEME/rofi"

## Wallpaper ---------------------------------
apply_wallpaper() {
	for head in {0..10}; do
		nitrogen --head=$head --save --set-zoom-fill "$wallpaper" &>/dev/null
	done
}

## Polybar -----------------------------------
apply_polybar() {
	# modify polybar launch script
	sed -i -e "s/STYLE=.*/STYLE=\"$THEME\"/g" ${PATH_OBTS}/themes/polybar.sh

	# apply default theme fonts
	sed -i -e "s/font-0 = .*/font-0 = \"$polybar_font\"/g" ${PATH_PBAR}/config.ini

	# rewrite colors file
	cat > ${PATH_PBAR}/colors.ini <<- EOF
		[color]

		BACKGROUND = ${polybar_background}
		TEXT = ${text}

		DATE = ${polybar_date}
		NETWORK = ${polybar_network}
		VOLUME = ${polybar_volume}

		CURRENT = ${polybar_current_workspace}
		OCCUPIED = ${polybar_occupied_workspace}
		URGENT = ${polybar_urgent_workspace}
		EMPTY = ${polybar_empty_workspace}
	EOF

	# launch polybar
	bash ${PATH_OBTS}/themes/polybar.sh
}

# Rofi --------------------------------------
apply_rofi() {
	# modify rofi scripts
	sed -i -e "s/STYLE=.*/STYLE=\"$THEME\"/g" \
		${PATH_OBTS}/scripts/askpass \
		${PATH_OBTS}/scripts/launcher \
		${PATH_OBTS}/scripts/music \
		${PATH_OBTS}/scripts/powermenu \
		${PATH_OBTS}/scripts/runner \
		${PATH_OBTS}/scripts/screenshot
	
	# apply default theme fonts
	sed -i -e "s/font:.*/font: \"$rofi_font\";/g" ${PATH_ROFI}/shared/fonts.rasi

	# rewrite colors file
	cat > ${PATH_ROFI}/shared/colors.rasi <<- EOF
		* {
			background:     ${rofi_background};
			background-alt: ${rofi_background_alt};
			foreground:     ${rofi_foreground};
			selected:       ${rofi_selected};
			active:         ${rofi_active};
			urgent:         ${rofi_urgent};
		}
	EOF

	# modify icon theme
	if [[ -f "$PATH_CONF"/rofi/config.rasi ]]; then
		sed -i -e "s/icon-theme:.*/icon-theme: \"$rofi_icon\";/g" ${PATH_CONF}/rofi/config.rasi
	fi
}

# Network Menu ------------------------------
apply_netmenu() {
	if [[ -f "$PATH_CONF"/networkmanager-dmenu/config.ini ]]; then
		sed -i -e "s#dmenu_command = .*#dmenu_command = rofi -dmenu -theme $PATH_ROFI/networkmenu.rasi#g" ${PATH_CONF}/networkmanager-dmenu/config.ini
	fi
}

# Terminal ----------------------------------
apply_terminal() {
	# alacritty : fonts
	sed -i ${PATH_TERM}/fonts.yml \
		-e "s/family: .*/family: \"$terminal_font_name\"/g" \
		-e "s/size: .*/size: $terminal_font_size/g"

	# alacritty : colors
	cp $terminal_colors ${PATH_TERM}/colors.yml
}

# Geany -------------------------------------
apply_geany() {
	sed -i ${PATH_GEANY}/geany.conf \
		-e "s/color_scheme=.*/color_scheme=$geany_colors/g" \
		-e "s/editor_font=.*/editor_font=$geany_font/g"
}

# Appearance --------------------------------
apply_appearance() {
	# apply gtk theme, icons, cursor & fonts
	xfconf-query -c xsettings -p /Gtk/FontName -s "$gtk_font"
	xfconf-query -c xsettings -p /Net/ThemeName -s "$gtk_theme"
	xfconf-query -c xsettings -p /Net/IconThemeName -s "$icon_theme"
	xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "$cursor_theme"
	
	# inherit cursor theme
	if [[ -f "$HOME"/.icons/default/index.theme ]]; then
		sed -i -e "s/Inherits=.*/Inherits=$cursor_theme/g" "$HOME"/.icons/default/index.theme
	fi	
}

# Openbox -----------------------------------
apply_obconfig () {
	namespace="http://openbox.org/3.4/rc"
	config="$PATH_OBOX/rc.xml"

	# Theme
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:name' -v "$ob_theme" "$config"

	# Title
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:titleLayout' -v "$ob_layout" "$config"

	# Fonts
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:name' -v "$ob_font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:size' -v "$ob_font_size" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:weight' -v Bold "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:name' -v "$ob_font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:size' -v "$ob_font_size" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:weight' -v Normal "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:name' -v "$ob_font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:size' -v "$ob_font_size" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:weight' -v Bold "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:name' -v "$ob_font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:size' -v "$ob_font_size" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:weight' -v Normal "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:name' -v "$ob_font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:size' -v "$ob_font_size" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:weight' -v Bold "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:name' -v "$ob_font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:size' -v "$ob_font_size" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:weight' -v Normal "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:slant' -v Normal "$config"

	# Openbox Menu Style
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:menu/a:file' -v "$ob_menu" "$config"

	# Margins
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:top' -v ${ob_margin_t} "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:bottom' -v ${ob_margin_b} "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:left' -v ${ob_margin_l} "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:right' -v ${ob_margin_r} "$config"

	# Reload Openbox Config
	openbox --reconfigure
}

# Dunst -------------------------------------
apply_dunst() {
	# modify dunst config
	sed -i ${PATH_DUNST}/dunstrc \
		-e "s/width = .*/width = $dunst_width/g" \
		-e "s/height = .*/height = $dunst_height/g" \
		-e "s/offset = .*/offset = $dunst_offset/g" \
		-e "s/origin = .*/origin = $dunst_origin/g" \
		-e "s/font = .*/font = $dunst_font/g" \
		-e "s/frame_width = .*/frame_width = $dunst_border/g" \
		-e "s/separator_height = .*/separator_height = $dunst_separator/g" \
		-e "s/line_height = .*/line_height = $dunst_separator/g"\
		-e "s/corner_radius = .*/corner_radius = $dunst_corner_radius/g"

	# modify colors
	sed -i '/urgency_low/Q' ${PATH_DUNST}/dunstrc
	cat >> ${PATH_DUNST}/dunstrc <<- _EOF_
		[global]
		frame_color = "#89B4FA"
		separator_color= frame

		[urgency_low]
		background = "#1E1E2E"
		foreground = "#CDD6F4"

		[urgency_normal]
		background = "#1E1E2E"
		foreground = "#CDD6F4"

		[urgency_critical]
		background = "#1E1E2E"
		foreground = "#CDD6F4"
		frame_color = "#FAB387"
	_EOF_

	# restart dunst
	pkill dunst && dunst &
}

# Plank -------------------------------------
apply_plank() {
	# create temporary config file
	cat > "$HOME"/.cache/plank.conf <<- _EOF_
		[dock1]
		alignment='center'
		auto-pinning=true
		current-workspace-only=false
		dock-items=['xfce-settings-manager.dockitem', 'Alacritty.dockitem', 'thunar.dockitem', 'firefox.dockitem', 'geany.dockitem']
		hide-delay=0
		hide-mode='$plank_hmode'
		icon-size=$plank_icon_size
		items-alignment='center'
		lock-items=false
		monitor=''
		offset=$plank_offset
		pinned-only=false
		position='$plank_position'
		pressure-reveal=false
		show-dock-item=false
		theme='$plank_theme'
		tooltips-enabled=true
		unhide-delay=0
		zoom-enabled=true
		zoom-percent=$plank_zoom_percent
	_EOF_

	# apply config and reload plank
	cat "$HOME"/.cache/plank.conf | dconf load /net/launchpad/plank/docks/
}

# Compositor --------------------------------
apply_compositor() {
	picom_cfg="$PATH_CONF/picom.conf"

	# modify picom config
	sed -i "$picom_cfg" \
		-e "s/backend = .*/backend = \"$picom_backend\";/g" \
		-e "s/corner-radius = .*/corner-radius = $picom_corner;/g" \
		-e "s/shadow-radius = .*/shadow-radius = $picom_shadow_r;/g" \
		-e "s/shadow-opacity = .*/shadow-opacity = $picom_shadow_o;/g" \
		-e "s/shadow-offset-x = .*/shadow-offset-x = $picom_shadow_x;/g" \
		-e "s/shadow-offset-y = .*/shadow-offset-y = $picom_shadow_y;/g" \
		-e "s/method = .*/method = \"$picom_blur_method\";/g" \
		-e "s/strength = .*/strength = $picom_blur_strength;/g"
}

# Create Theme File -------------------------
create_file() {
	theme_file="$PATH_OBTS/themes/.current"
	if [[ ! -f "$theme_file" ]]; then
		touch ${theme_file}
	fi
	echo "$THEME" > ${theme_file}
}

# Notify User -------------------------------
notify_user() {
	dunstify -u normal -h string:x-dunst-stack-tag:applytheme -i /usr/share/archcraft/icons/dunst/themes.png "Applying Style : $THEME"
}

## Execute Script ---------------------------
echo "Applying Style : $THEME"
notify_user
create_file
echo "Applying wallpaper"
apply_wallpaper
echo "Applying polybar"
apply_polybar
echo "Applying rofi"
apply_rofi
echo "Applying network menu"
apply_netmenu
echo "Applying terminal"
apply_terminal
echo "Applying geany"
apply_geany
echo "Applying appearance"
apply_appearance
echo "Applying openbox"
apply_obconfig
echo "Applying dunst"
apply_dunst
echo "Applying plank"
apply_plank
echo "Applying compositor"
apply_compositor
echo "Done"

# fix cursor theme (run it in the end)
xsetroot -cursor_name left_ptr
