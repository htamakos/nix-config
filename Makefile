USERNAME = `whoami`
HOSTNAME = `hostname -s`

.PHONY: install uninstall install-nix-darwin

install:
	@echo "Installing Nix"
	sudo curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes || :
	source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh || :
	mkdir -p ~/.config/nix
	echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
	@echo "Complete"

install-nix-darwin:
	@echo "Installing nix-darwin"
	@nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#${HOSTNAME}
	@echo "Complete"

darwin-rebuild:
	@echo "Rebuilding darwin configuration..."
	@/run/current-system/sw/bin/darwin-rebuild switch --flake .#${HOSTNAME}
	@echo "Darwin rebuild complete."

build-home-private:
	NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix run nixpkgs#home-manager -- switch --flake .#htamakos@HironorinoMacBook-Pro --impure

build-home-test-private:
	@nix run nixpkgs#home-manager -- switch --flake .#testuser@HironorinoMacBook-Pro

build-home-work:
	NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix run nixpkgs#home-manager -- switch --flake .#h-tamakosshi@PC107859 --impure

uninstall:
	@echo "UnInstalling Nix"
	sudo launchctl bootout system/org.nixos.nix-daemon || :
	sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist || :
	sudo mv /etc/bashrc.backup-before-nix /etc/bashrc || :
	sudo mv /etc/zshrc.backup-before-nix /etc/zshrc || :
	sudo rm -rf "/etc/nix" \
		"/nix" \
		"/var/root/.nix-profile" \
		"/var/root/.nix-defexpr" \
		"/var/root/.nix-channels" \
		"/var/root/.local/state/nix" \
		"/var/root/.cache/nix" \
		"/Users/${USERNAME}/.nix-profile" \
		"/Users/${USERNAME}/.nix-defexpr" \
		"/Users/${USERNAME}/.nix-channels" \
		"/Users/${USERNAME}/.local/state/nix" \
		"/Users/${USERNAME}/.cache/nix" \
		"/Users/${USERNAME}/nix"
	@echo "Complete"
