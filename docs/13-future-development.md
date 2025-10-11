# Future Development

This document outlines potential areas for future development and improvement of the Chelipeds project.

## 1. Implement a Feature Management System

The current version of Chelipeds provides a single, opinionated configuration. A major goal for the future is to implement a modular feature management system. This would allow users to enable or disable different "feature sets" at build time, such as:

*   **Gaming**: Steam, Lutris, and other gaming-related software.
*   **Design**: GIMP, Inkscape, and other graphic design applications.
*   **Video Editing**: Kdenlive, Shotcut, and other video editing tools.

This could be implemented using separate `Containerfile`s for each feature set, or by using a configuration management tool like Ansible.

## 2. Expand Hardware Support

Currently, Chelipeds is focused on x86_64 architecture. Expanding support to other architectures, particularly ARM, would greatly increase the project's reach. This would involve:

*   Creating a new `Containerfile` based on an ARM base image.
*   Ensuring all packages and scripts are compatible with ARM.
*   Testing on ARM-based hardware like the Raspberry Pi.

## 3. Create a User-Friendly Configuration Tool

Customizing the system currently requires manual editing of the `Containerfile` and the `overlay/` directory. To make customization more accessible, a user-friendly configuration tool could be created. This could be:

*   A command-line tool that guides users through the process of enabling/disabling features and adding packages.
*   A web-based interface, similar to the "Ignition generator" mentioned in the release process documentation.

## 4. Enhance the Desktop Experience

While the minimal desktop environment is intentional, there are opportunities to improve the user experience:

*   **System Settings**: A graphical tool for managing system settings like display, network, and sound.
*   **File Manager**: A more feature-rich file manager with support for network shares and other advanced features.
*   **Flatpak Management**: A graphical tool for managing Flatpak applications.
*   **Keybinding Customization**: An expanded version of the `chelipeds-generate-keys` script that allows for easy customization of keybindings.

## 5. Improve the Documentation

The documentation is a vital part of the project. It could be improved by:

*   **Developer Guide**: A more detailed guide on using the development environment, including tutorials and examples.
*   **Customization Tutorial**: A step-by-step tutorial on how to create a custom version of Chelipeds.
*   **Application Recommendations**: A more comprehensive list of recommended applications for different use cases.

## 6. Add a Test Suite

To ensure the quality and stability of the system, a test suite should be added. This could include:

*   **Script Tests**: Unit tests for the custom shell scripts.
*   **Service Tests**: Integration tests for the systemd services.
*   **Build Tests**: Tests to ensure that the container image builds successfully and that all services start as expected.
