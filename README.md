# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). Runs on macOS (primary, full app set) and Linux (work, CLI-only).

## Bootstrap a new machine

1. Get the age private key onto the machine first — `chezmoi apply` will try to decrypt secrets and fail without it. Copy `~/.config/age/chezmoi.key` from another machine/backup, or see [Age encryption](#age-encryption) to add a new key instead.
2. Install chezmoi and apply this repo in one step:

   ```
   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --ssh slimctl/dotfiles
   ```

   You'll be prompted to pick package groups (`ai` / `k8s` / `iac` / `cloud` / `dev` / `containers`) — pick whatever's relevant to that machine.
3. Homebrew and all packages install automatically as part of apply (see below). Nothing else to do manually.

## What runs automatically on apply

- `run_once_before_install-homebrew.sh` — installs Homebrew if missing, once.
- `run_onchange_install-packages.sh.tmpl` — builds a Brewfile from `.chezmoidata/packages.toml` (common + OS-specific + selected package groups) and runs `brew bundle --cleanup --no-upgrade`. Only reruns when the rendered package list actually changes. `--no-upgrade` means editing `packages.toml` never force-upgrades things already installed — it only installs new entries and removes ones dropped from the list.
- Encrypted files (currently `dot_ssh/encrypted_config.age`) decrypt automatically using the age identity from `.chezmoi.toml.tmpl`.

macOS-only paths: `.config/borders`, `.config/aerospace`, `~/.ssh` — skipped entirely on Linux, see `.chezmoiignore`.

## Adding packages

Edit `.chezmoidata/packages.toml`:

- `[packages.common]` — brew formulae/casks installed on every machine, every OS. Only put genuinely cross-platform casks here — check `brew info --cask <name>` first; a `Binary`/`Font` artifact works on Linux, an `app`/`pkg` artifact is macOS-only.
- `[packages.darwin]` / `[packages.linux]` — OS-only `brew`/`cask`. `darwin.mas` is Mac App Store apps: `{ "App Name" = id }`, where `id` is the numeric ID from the app's App Store URL.
- `[packages.<group>]` (`ai`/`k8s`/`iac`/`cloud`/`dev`/`containers`) — optional groups chosen per-machine at `chezmoi init`. Can define `brew`, `tap`, `cask`, `mas` same as the OS sections.

No need to touch `run_onchange_install-packages.sh.tmpl` for new packages — only if adding a new field type beyond brew/tap/cask/mas.

To change which groups a machine has after the fact, either re-run `chezmoi init` (re-prompts) or hand-edit `packageGroups` in `~/.config/chezmoi/chezmoi.toml`.

## Age encryption

Secrets (currently just `dot_ssh/encrypted_config.age`) are encrypted with [age](https://github.com/FiloSottile/age), configured in `.chezmoi.toml.tmpl`.

- Private key: `~/.config/age/chezmoi.key` — never committed, back it up somewhere safe.
- Public recipients live in `.chezmoi.toml.tmpl`'s `[age].recipients`.

New machine, new key instead of copying an existing one:

```
age-keygen -o ~/.config/age/chezmoi.key
```

Add the printed public key to `recipients` in `.chezmoi.toml.tmpl` and commit. Then, **from a machine that can already decrypt**, re-encrypt existing secrets so the new key can actually read them (adding a recipient doesn't retroactively grant access to already-encrypted files): `chezmoi add --encrypt <path>`.

Edit an encrypted file: `chezmoi edit <path>` (decrypts, opens in nvim per `[edit]`, re-encrypts on save).

## Useful commands

```
chezmoi diff                    # preview changes before applying
chezmoi apply                   # apply changes
chezmoi update                  # pull latest + apply
chezmoi cd                      # shell into the source dir
chezmoi execute-template --file < .chezmoiscripts/run_onchange_install-packages.sh.tmpl
                                 # preview the generated Brewfile without running it
```
