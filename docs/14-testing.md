# Testing

This project includes a test suite to ensure the quality and stability of the system. The test suite includes both static analysis (shellcheck) and unit tests (bats).

## Running Tests

To run the test suite, execute the following command from the root of the project:

```bash
./run-tests.sh
```

This will run all the shellcheck and bats tests in the project.

## Bats

Bats (Bash Automated Testing System) is a testing framework for Bash that allows you to write tests in a structured way. The `*.bats` files in the `tests/` directory contain the bats tests for the project.
## Automated pre-flight checks

GitHub Actions validates every script with Bash and ShellCheck, parses `bootc-config.json`, verifies systemd units, and checks the diff before building the image. The build job then creates the Fedora 44 bootc image, ISO, signed release artifacts, and R2 uploads.
