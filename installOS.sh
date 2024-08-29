if [$ID != "arch"]; then
  echo "only arch is supported"
  exit 1
fi
#update system
sudo pacman -Syu
#installs yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

# install desktop
sudo pacman -Sy plasma
sudo systemctl enable sddm
#install supplemental packages
sudo pacman -Sy spectacle flatpak adobe-source-han-sans-jp-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-kr-fonts adobe-source-han-serif-tw-fonts adobe-source-han-serif-hk-fonts adobe-source-han-serif-otc-fonts wget
# add tkg kernal
git clone https://github.com/Frogging-Family/linux-tkg.git
cd linux-tkg
makepkg -si
cd ~
sudo rm -rf ~/yay
# echo some useful things
echo """
check https://nowsci.com/winapps/ for running most windows apps in linux, potentially better than WINE/PROTON. Note that you might need to use a Win11 pro ISO rather than Win10 pro. You very likely don't need to buy a key.
""" >> ~/tips.txt
#user custom stuff
read "which browser do you want to use most often: 1 = chrome, 2 = microsoft edge, 3 = firefox" browser_result
if [$browser_result == "1"]; then
  yay -Sy google-chrome
else if [$browser_result == "2"]; then
  yay -Sy microsoft-edge-stable-bin
else if [$browser_result == "3"]; then
  sudo pacman -Sy firefox
fi
read "install waydroid? this allows for use of most android apps within Linux via a LXC [y/n]" waydroid_result
if [$waydroid_result == "y"]; then
  yay -Sy binder_linux-dkms
  sudo modprobe binder-linux device=binder,hwbinder,vndbinder
  yay -Sy waydroid
fi
read "install distrobox? This will let you run linux packages designed for other distros without needing to go through the AUR [y/n]" distro_result
if [$distro_result == "y"]; then
  sudo pacman -Sy distrobox podman
  read "install Box Buddy? This is a Distrobox manager [y/n]" box_result
  if [$box_result == "y"]; then
    flatpak install flathub io.github.dvlv.boxbuddyrs -y
  fi
fi
read "install bottles? This will allow you to run most windows apps as if they were designed for linux? do note, it sandboxes them from your system somewhat [Y/N]" bottles_result
if [$bottles_result == "y"]; then
  flatpak install flathub com.usebottles.bottles -y
fi
read "which office suite do you want to install? 1 = WPS, 2 = Libre, 3 = None" office_result
if [$office_result == "1"]; then
  flatpak install flathub com.wps.Office -y
else if [$office_result == "2"]; then
  flatpak install flathub org.libreoffice.LibreOffice -y
fi
read "install steam? [y/n]" steam_result
if [$steam_result == "y"]; then
  sudo pacman -Sy steam
  read "install packages to manage proton? e.g. ProtonPlus, Proton Tricks, ProtonupQT [y/n]" proton_supp_result
  if [$proton_supp_result == "y"]; then
    flatpak install flathub com.vysp3r.ProtonPlus net.davidotek.pupgui2 com.github.Matoking.protontricks -y
    echo "\nuse 'flatpak override --user --filesystem=/path/to/other/Steam/Library com.github.Matoking.protontricks' to allow ProtonUpQT to access other drives" >> ~/tips.txt
  fi
  read "install Heroic Launcher? This is for games off of Epic [y/n]" hero_result
  if [$hero_result == "y"]; then
    yay -Sy heroic-games-launcher
  fi
fi
read "install Celeste? This allows you to sync almost any cloud storage to your filesystem [y/n]" cloud_result
if [$cloud_result == "y"]; then
  flatpak install flathub com.hunterwittenborn.Celeste -y
fi
read "install graphics tablet/android as display software? 1 = Android Virtual Pen, 2 = Weylus Comunnity Edition, 3 = both" grapthic_result
if [$grapthic_result == "1"]; then
  flatpak install flathub io.github.androidvirtualpen.virtualpen -y
else if [$grapthic_result == "2"]; then
  flatpak install flathub io.github.electronstudio.WeylusCommunityEdition -y
else if [$grapthic_result == "3"]; then
  flatpak install flathub io.github.electronstudio.WeylusCommunityEdition io.github.androidvirtualpen.virtualpen -y
fi
read "install packages for STL thumbnails [y/n]" cad_result
if [$cad_result == "y"]; then
  yay -Sy stl-thumb
  yay -Sy stl-thumb-kde
fi
