# Home Manager Migration Instructions

This guide helps you migrate from shell script symlink management to home-manager.

## Prerequisites

1. Ensure Nix and nix-darwin are installed
2. Backup your existing configuration

## Migration Steps

### 1. Review Generated Configuration

Check the generated `nix/home-manager.nix` file and customize as needed:

- Update `username` variable
- Add/remove symlinks as required
- Organize imports

### 2. Update flake.nix

Ensure your flake.nix imports the home-manager configuration:

```nix
home-manager.users.YOUR_USERNAME = import ./nix/home-manager.nix;
```

### 3. Apply Configuration

```bash
# Build and switch (with backup for conflicts)
sudo darwin-rebuild switch --flake .#YOUR_SYSTEM_NAME --impure
```

### 4. Update Migration Scripts

Modify your existing migration scripts to:
- Remove manual symlink creation
- Add informational messages about home-manager
- Keep any non-symlink setup (directories, permissions, etc.)

### 5. Test and Verify

```bash
# Check symlinks were created correctly
find ~/.config -type l -ls | head -10

# Verify configuration works
source ~/.zshrc  # or your shell
```

## Troubleshooting

### Conflicting Files

If you get "file is in the way" errors:

1. Backup existing files:
   ```bash
   mkdir -p ~/backup-configs
   mv ~/.config/CONFLICTING_DIR ~/backup-configs/
   ```

2. Re-run darwin-rebuild

### Unsupported File Types

Some files cannot be symlinked (sockets, device files):
- Comment out those entries in home-manager configuration
- Manage them manually or through other means

### Rollback

To rollback changes:
```bash
# List generations
sudo darwin-rebuild --list-generations

# Rollback to previous generation
sudo darwin-rebuild rollback
```

## Benefits After Migration

✅ Declarative configuration management
✅ Atomic updates and rollbacks
✅ Conflict detection and handling
✅ Cross-system consistency
✅ Integration with Nix ecosystem
