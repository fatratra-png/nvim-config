# nvim — AstroNvim v6

Configuration basée sur AstroNvim v6, avec le core installé depuis ton fork
`fatratra-png/astronvim-config`.

Guide de prise en main complet : [`CHEATSHEET.md`](CHEATSHEET.md).

## Structure

- `lua/lazy_setup.lua` — bootstrap lazy.nvim + options AstroNvim
- `lua/community.lua` — packs AstroCommunity (lua, java, kotlin, typescript,
  python, html/css, svelte, tailwind)
- `lua/plugins/` — personnalisations (astrocore, astroui, astrolsp, user)
- `lua/config/maven.lua` — commandes Maven
- `lua/polish.lua` — autosave + setup final

## Raccourcis utiles

- `<Space>e` neo-tree · `-` Oil
- `<Space>ff` fichiers · `<Space>fw` grep · `<Space>fb` buffers (snacks picker)
- `<Space>lf` ou `<Space>cf` formater le buffer
- `<Space>ntr` test le plus proche · `<Space>ntf` tests du fichier ·
  `<Space>nts` résumé · `<Space>nto` sortie
- `:Mvn`, `:MvnClean`, `:MvnTest`, `:MvnPackage`, `:MvnInstall`, ...
- `:Mason` gérer les LSP/outils · `:Lazy` gérer les plugins · `:checkhealth`

## Notes

- Le fork n'a pas de tags Git : pas de pin de version (`pin_plugins = false`),
  le core suit `main` du fork.
- Le LSP Kotlin tourne avec le JDK 21 (`~/.jdks/ms-21.0.11`) car son
  compilateur embarqué ne supporte pas Java 25.
- Pour ajouter Dart/Go : ajouter `{ import = "astrocommunity.pack.dart" }` (ou
  `go`) dans `lua/community.lua`, puis `:Lazy sync`.
- Ancienne config sauvegardée dans `~/.config/nvim.bak-2026-11-19`.
