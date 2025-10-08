# Fedora 43 (beta) bootc base
FROM quay.io/fedora/fedora-bootc:43

LABEL org.opencontainers.image.title="Chelipeds (Niri Dev)"
LABEL org.opencontainers.image.description="Fedora 43 bootc image with Niri, developer stack, Flatpaks, and Chelipeds tuning."
LABEL org.opencontainers.image.vendor="Chelipeds"
LABEL org.opencontainers.image.version="43"



# --- Packages ---
RUN dnf -y upgrade && dnf -y install \
    niri waybar wofi mako wl-clipboard grim slurp swappy \
    swaybg swayidle swaylock \
    xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
    cascadia-code-nf-fonts kitty \
    neovim gcc gcc-c++ clang cmake ninja-build make gdb git \
    podman podman-compose buildah skopeo crun podman-tui toolbox distrobox \
    flatpak \
    curl wget rsync jq htop strace lsof tcpdump traceroute tailscale nfs-utils mosh wireguard-tools libnotify \
    nautilus openssh-server \
    lxqt-policykit nm-connection-editor NetworkManager-tui bluez blueman \
    fwupd cups cups-client cups-filters \
    google-noto-sans-fonts google-noto-sans-cjk-fonts google-noto-serif-fonts google-noto-emoji-fonts \
    firewalld gnome-keyring syncthing ly \
  && dnf clean all

# --- Copy overlay (configs, units, scripts, defaults) ---
COPY overlay/ /

# --- Ensure perms on helpers ---
RUN find /usr/local/bin -type f -exec chmod +x {} \; \
 && find /usr/local/libexec -type f -exec chmod +x {} \; \
 && chmod +x /usr/bin/niri-session || true

# --- Enable system services via wants/ symlinks ---
RUN ln -sf /etc/systemd/system/chelipeds-update-check.timer /etc/systemd/system/timers.target.wants/chelipeds-update-check.timer \
 && ln -sf /usr/lib/systemd/system/sshd.service              /etc/systemd/system/multi-user.target.wants/sshd.service \
 && ln -sf /usr/lib/systemd/system/firewalld.service         /etc/systemd/system/multi-user.target.wants/firewalld.service \
 && ln -sf /usr/lib/systemd/system/bluetooth.service         /etc/systemd/system/multi-user.target.wants/bluetooth.service \
 && ln -sf /usr/lib/systemd/system/cups.service              /etc/systemd/system/multi-user.target.wants/cups.service \
 && ln -sf /usr/lib/systemd/system/fwupd.service             /etc/systemd/system/multi-user.target.wants/fwupd.service \
 && ln -sf /usr/lib/systemd/system/power-profiles-daemon.service /etc/systemd/system/multi-user.target.wants/power-profiles-daemon.service \
 && ln -sf /usr/lib/systemd/system/ly.service                /etc/systemd/system/multi-user.target.wants/ly.service

# --- Enable user services globally (default.target.wants) ---
RUN install -d /etc/systemd/user/default.target.wants \
 && ln -sf /etc/systemd/user/waybar.service                     /etc/systemd/user/default.target.wants/waybar.service \
 && ln -sf /etc/systemd/user/mako.service                       /etc/systemd/user/default.target.wants/mako.service \
 && ln -sf /etc/systemd/user/swaybg.service                     /etc/systemd/user/default.target.wants/swaybg.service \
 && ln -sf /etc/systemd/user/swayidle.service                   /etc/systemd/user/default.target.wants/swayidle.service \
 && ln -sf /etc/systemd/user/polkit-agent.service               /etc/systemd/user/default.target.wants/polkit-agent.service \
 && ln -sf /etc/systemd/user/blueman-applet.service             /etc/systemd/user/default.target.wants/blueman-applet.service \
 && ln -sf /etc/systemd/user/gnome-keyring-daemon.service       /etc/systemd/user/default.target.wants/gnome-keyring-daemon.service \
 && ln -sf /etc/systemd/user/chelipeds-generate-keys.service    /etc/systemd/user/default.target.wants/chelipeds-generate-keys.service \
 && ln -sf /etc/systemd/user/chelipeds-devsetup.service         /etc/systemd/user/default.target.wants/chelipeds-devsetup.service \
 && ln -sf /etc/systemd/user/update-tools.timer                 /etc/systemd/user/default.target.wants/update-tools.timer \
 && ln -sf /usr/lib/systemd/user/syncthing.service              /etc/systemd/user/default.target.wants/syncthing.service || true

# --- Flatpak: Flathub ---
RUN flatpak --system remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
