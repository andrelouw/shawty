#!/bin/bash
CHECK_MINT="command -v mint > /dev/null 2>&1"

install_mint() {
	echo "⬇️  Installing Mint..."
	brew install mint
}

install_mint_if_needed() {
	if ! eval $CHECK_MINT; then
		if [[ -z "${CI}" ]]; then
			while true; do
			read -p "Do you wish to install mint? (y/n) " yn
			case $yn in
				[Yy]* ) install_mint; break;;
				[Nn]* ) echo "⛔️ mint required for setup, exiting!"; exit 1;;
				* ) echo "Please answer y(yes) or n(no).";;
			esac
		done
		else
			echo "⚙️ Running on CI, skipping confirmation step..."
			install_mint
		fi
	else
		echo "✅ Mint already installed "
	fi
}

bootstrap_mint() {
    echo "⬇️  Installing mints..."
    mint bootstrap
}

bootstrap_mint_if_needed() {
		if [[ -z "${CI}" ]]; then
			while true; do
			read -p "Do you wish to install mints? (y/n) " yn
			case $yn in
				[Yy]* ) bootstrap_mint; break;;
				[Nn]* ) echo "⚠️  Some tools might not work properly before all mints are installed!"; break;;
				* ) echo "Please answer y(yes) or n(no).";;
			esac
		done
		else
			echo "⚙️ Running on CI, skipping confirmation step..."
      bootstrap_mint
		fi
}

install_mint_if_needed
bootstrap_mint_if_needed
