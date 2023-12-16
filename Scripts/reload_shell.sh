#!/bin/bash

reload_shell() {
   exec "$SHELL"
}

reload_shell_if_needed() {
		if [[ -z "${CI}" ]]; then
			while true; do
			read -p "Do you wish to reload your shell? (y/n) " yn
			case $yn in
				[Yy]* ) reload_shell; break;;
				[Nn]* ) echo "⚠️  Some tools might not work properly without reloading your shell first!"; break;;
				* ) echo "Please answer y(yes) or n(no).";;
			esac
		done
		else
			echo "⚙️ Running on CI, skipping confirmation step..."
      reload_shell
		fi
}

reload_shell_if_needed
