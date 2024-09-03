{ inputs, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
		# System stuff
        neovim
        git
		gcc
		cargo
		python3
		nodejs

		# User stuff
		hyprpaper
		hyprlock
		hypridle
		alacritty
		wofi
		brightnessctl
		starship
		zoxide
		fzf
		eza
		fastfetch
		keepassxc
		xfce.ristretto
		inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.godot_4
		libresprite
		btop
		vlc
		grim
		wl-clipboard
		teams

		# Scripts
		(writeShellScriptBin "nixos-config" ''
			sudo -v
			previous_dir=$(pwd)
			cd ~/nixos
			git pull
			nvim .
			git add .
			read -p "Commit message: " message
			git commit -m "$message"
			git push
			sudo nixos-rebuild switch --flake .
			nix run home-manager -- --flake . switch
			cd $previous_dir
		'')
    ];

	programs.thunar.enable = true;
	programs.zsh.enable = true;
    programs.firefox.enable = true;
    programs.hyprland.enable = true;
	programs.file-roller.enable = true;
	programs.steam.enable = true;

	# Add fonts
	fonts.packages = with pkgs; [
		(nerdfonts.override {fonts = ["JetBrainsMono"];})
		inter
		jetbrains-mono
	];
}
