# My Rust Project

```sh
# Initialize the template:
nix flake init -t github:ggemre/fleet#rust

# Initialize direnv and git
direnv allow
git init

# Build the project
nix build

# Run the project
nix run

# Run the checks (tests, clippy, and fmt)
nix flake check

# Add a new crate
cargo add <CRATE_NAME>
```
