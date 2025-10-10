Chelipeds is designed to be customizable. You can add your own packages, configurations, and scripts to create a personalized environment.

### Adding Packages

To add additional packages to the system, you can edit the `Containerfile` and add them to the `dnf install` command. For example, to install the `htop` package, you would modify the `RUN dnf -y install \` section to include `htop`.

### Using the Overlay

The `overlay/` directory allows you to override or add files to the system. Any files or directories you place in `overlay/` will be copied to the root of the image during the build process. This is useful for:

*   Adding custom configurations to `/etc`.
*   Placing your own scripts in `/usr/local/bin`.
*   Adding or overriding systemd units.

By using the `Containerfile` and the `overlay/` directory, you can create a fully customized version of Chelipeds that meets your specific needs.
