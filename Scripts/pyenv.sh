#!/bin/bash
CHECK_PYENV="command -v pyenv > /dev/null 2>&1"

install_pyenv() {
	echo "⬇️  Installing pyenv..."
	brew install pyenv
}

install_pyenv_if_needed() {
	if ! eval $CHECK_PYENV; then
		if [[ -z "${CI}" ]]; then
			while true; do
			read -p "Do you wish to install pyenv? (y/n) " yn
			case $yn in
				[Yy]* ) install_pyenv; break;;
				[Nn]* ) echo "⚠️ pyenv required for certain tools to work!";;
				* ) echo "Please answer y(yes) or n(no).";;
			esac
		done
		else
			echo "⚙️ Running on CI, skipping confirmation step..."
			install_pyenv
		fi
	else
		echo "✅ pyenv already installed "
	fi
}

bootstrap_pyenv() {
  ZSHRC_DIR="${ZDOTDIR:-$HOME}/.zshrc"
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $ZSHRC_DIR
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $ZSHRC_DIR
  echo 'eval "$(pyenv init -)"' >> $ZSHRC_DIR
}

bootstrap_pyenv_if_needed() {
		if [[ -z "${CI}" ]]; then
			while true; do
			read -p "Do you wish to copy pyenv setup to your .zshrc? (y/n) " yn
			case $yn in
				[Yy]* ) bootstrap_pyenv; break;;
				[Nn]* ) echo "⚠️  Pyenv might not work properly if your config is not correct!"; break;;
				* ) echo "Please answer y(yes) or n(no).";;
			esac
		done
		else
			echo "⚙️ Running on CI, skipping bootstrap step..."
		fi
}

install_pyenv_if_needed
bootstrap_pyenv_if_needed
