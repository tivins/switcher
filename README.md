# switcher

Palette pour aller vite dans un projet.

- **rofi** (raccourci global) : `Entrée` → Thunar, `Ctrl+Entrée` → terminal dans le dossier.
- **shell** : `p [requête|alias]` → `cd` dans le shell courant via fzf.

Les projets sont trouvés par scan des racines configurées, complétés par des alias.
Le tri se fait par fréquence × récence d'usage (à la zoxide) ; rofi et `p` partagent le même historique.

## Installation

Dépendances : `python3` (≥ 3.11), `rofi`, `fzf`.

```bash
./install.sh
```

Puis associer `switcher` à un raccourci clavier dans *Paramètres → Clavier → Raccourcis d'application*,
ou en ligne de commande :

```bash
xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/custom/<Super>o' -n -t string -s switcher
```

## Configuration

`~/.config/switcher/config.toml` (créé au premier lancement depuis `config.example.toml`) :

- `[[root]]` : dossiers scannés (par défaut `~/projects`, à adapter) et profondeur. On ne descend pas dans un dossier qui contient un marqueur.
- `markers` : fichiers qui identifient un projet (`.git`, `Cargo.toml`…).
- `exclude` : noms de dossiers ignorés.
- `[aliases]` : `nom = "chemin"`. `p nom` y va directement.
- `[[action]]` : touche rofi + commande (`{path}` remplacé). La première action est celle de `Entrée`.

Historique : `~/.local/share/switcher/history.json`.

## Commandes

```
switcher                 palette rofi
switcher list [--tsv]    liste triée
switcher list --aliases  noms d'alias
switcher alias NOM       chemin d'un alias
switcher touch CHEMIN    enregistre une visite
switcher config          chemin du fichier de config
```
