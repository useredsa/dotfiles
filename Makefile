.POSIX:

.PHONY: acpilight alacritty bash broot bspwm cf dolphin env kak kitty mime qutebrowser rofi sxhkd xbacklight xconf

xbacklight:
	# Don't symmlink across multiple partitions for udev rules!
	sudo cp "$$(pwd)/etc/udev/rules.d/90-backlight.rules" /etc/udev/rules.d/

acpilight: xbacklight

alacritty:
	ln -sf "$$(pwd)/.config/alacritty" "$$HOME/.config/"

kitty:
	ln -sf "$$(pwd)/.config/kitty" "$$HOME/.config/"

bash: env
	ln -sf "$$(pwd)/.bashrc" "$$HOME"
	ln -sf "$$(pwd)/.bash_profile" "$$HOME"

# Needs bc
bspwm:
	ln -sf "$$(pwd)/.config/bspwm" "$$HOME/.config/"
	sudo "$$(pwd)/.config/bspwm/bsp-layout-install.sh"

cf:
	ln -sf "$$(pwd)/.cf" "$$HOME"

dolphin: kdeconf
	ln -sf "$$(pwd)/.config/dolphinrc" "$$HOME/.config/"

broot:
	ln -sf "$$(pwd)/.config/broot" "$$HOME/.config/"

env:
	ln -sf "$$(pwd)/.gitconfig" "$$HOME"
	ln -sf "$$(pwd)/gitignore" "$$HOME/.config/"
	# ln -sf "$$(pwd)/.profile" "$$HOME"

kak:
	ln -sf "$$(pwd)/.config/kak" "$$HOME/.config/"
	mkdir -p "$HOME/.config/kak/plugins"
	git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak
	echo "Now Init kak and type :plug-install" to install the plugins

mime:
	ln -sf "$$(pwd)/.config/mimeapps.list" "$$HOME/.config/"

qutebrowser:
	ln -sf "$$(pwd)/.config/qutebrowser" "$$HOME/.config/"
	git clone "https://github.com/dracula/qutebrowser-dracula-theme.git" "$$HOME/.config/qutebrowser/dracula"
	echo "Now install the languages (tedious)"

rofi:
	ln -sf "$$(pwd)/.config/rofi" "$$HOME/.config/"

.config/sxhkd/conf-parser: .config/sxhkd/conf-parser.cpp
	g++ -Wall -O2 $< -o $@

sxhkd: .config/sxhkd/conf-parser
	ln -sf "$$(pwd)/.config/sxhkd" "$$HOME/.config/"
	ln -sf "$$(pwd)/.config/sxhkd/bspc-toggle-visibility.sh" "$$HOME/.local/bin"

xconf:
	ln -sf "$$(pwd)/.xinitrc" "$$HOME"
