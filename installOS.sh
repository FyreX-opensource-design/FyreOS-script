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
sudo rm -rf ~/linux-tkg
# echo some useful things
echo """
check https://nowsci.com/winapps/ for running most windows apps in linux, potentially better than WINE/PROTON. Note that you might need to use a Win11 pro ISO rather than Win10. You very likely don't need to buy a key.
""" >> ~/tips.txt
#user custom stuff
read "which browser do you ant to use most often: 1 = chrome, 2 = microsoft edge, 3 = firefox" browser_result
if [$browser_result == "1"]; then
yay -Sy google-chrome-wayland-vulkan
else if [$browser_result == "2"]; then
yay -Sy microsoft-edge-stable-bin
else if [$browser_result == "3"]; then
sudo pacman -Sy firefox
fi
read "install waydroid? this allows for use of most android apps within Linux via a LXC [Y/N]" waydroid_result
if [$waydroid_result == "Y"]; then
yay -Sy binder_linux-dkms
sudo modprobe binder-linux device=binder,hwbinder,vndbinder
yay -Sy waydroid
fi
read "install packages for 3d printing/general CAD [Y/N]" cad_result
if [$cad_result == "Y"]; then
  yay -Sy stl-thumb
  yay -Sy stl-thumb-kde
  read "use cura? [Y/N]" cura_result
  if [$cura_result == "Y"]; then
    flatpak install flathub com.ultimaker.cura
  fi
fi
