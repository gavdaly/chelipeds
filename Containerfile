# syntax=docker/dockerfile:1
FROM quay.io/fedora/fedora-bootc:44
LABEL org.opencontainers.image.title="Chelipeds (Niri Dev)" org.opencontainers.image.version="44"
RUN dnf -y upgrade \
  && dnf -y install \
  niri waybar wofi mako swaylock greetd tuigreet grim slurp wl-clipboard wf-recorder cliphist tesseract tesseract-langpack-eng wtype libnotify \
  xdg-desktop-portal-wlr xdg-desktop-portal-gtk kitty jetbrains-mono-fonts \
  podman podman-compose buildah skopeo crun toolbox distrobox \
  mosh selinux-policy-targeted firewalld flatpak curl wget jq rsync chezmoi openssh-server NetworkManager-tui bluez blueman gnome-keyring lxqt-policykit bcachefs-tools \
  google-noto-sans-fonts google-noto-sans-cjk-fonts google-noto-emoji-fonts \
  && dnf clean all
COPY voxtype-bin /usr/local/bin/voxtype
COPY overlay/ /
COPY config/ /etc/skel/.config/
COPY scripts/ /usr/local/bin/
COPY systemd/ /etc/systemd/system/
COPY bootc-config.json /etc/chelipeds/bootc-config.json
RUN mkdir -p /var/home /etc/systemd/user/default.target.wants /etc/systemd/system/multi-user.target.wants \
  && chmod 755 /var/home \
  && find /usr/local/bin -type f -exec chmod +x {} + \
  && cp /etc/systemd/system/cliphist.service /etc/systemd/user/cliphist.service \
  && cp /etc/systemd/system/update-tools.timer /etc/systemd/user/update-tools.timer \
  && cp /etc/systemd/system/update-tools.service /etc/systemd/user/update-tools.service \
  && cp /etc/systemd/system/swaylock-suspend.service /etc/systemd/user/swaylock-suspend.service \
  && cp /etc/systemd/system/chelipeds-update-notify.service /etc/systemd/user/chelipeds-update-notify.service \
  && ln -sf /etc/systemd/user/cliphist.service /etc/systemd/user/default.target.wants/cliphist.service \
  && ln -sf /etc/systemd/user/update-tools.timer /etc/systemd/user/default.target.wants/update-tools.timer \
  && ln -sf /etc/systemd/user/chelipeds-update-notify.service /etc/systemd/user/default.target.wants/chelipeds-update-notify.service \
  && ln -sf /etc/systemd/system/install-flatpaks.service /etc/systemd/system/multi-user.target.wants/install-flatpaks.service \
  && flatpak --system remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo \
  && voxtype setup onnx --enable || true
ENV PATH="/root/.cargo/bin:/root/.local/bin:${PATH}"
