# Guide de prise en main — Neovim + AstroNvim

> Ta configuration est basée sur **AstroNvim v6**. Ce fichier est le mode d'emploi
> complet : garde-le ouvert dans un onglet avec `nvim ~/.config/nvim/CHEATSHEET.md`.
>
> **Les 3 réflexes qui changent tout**
> 1. `Échap` te ramène **toujours** en mode normal.
> 2. `<Space>` est la touche **leader**. Appuie dessus **seule** : which-key
>    affiche toutes les commandes possibles. C'est ton meilleur outil au début.
> 3. Presque tout se lit comme une phrase : `d` (supprimer) + `w` (mot) = `dw`.

---

## Sommaire

1. [Survivre aux 5 premières minutes](#1-survivre-aux-5-premières-minutes)
2. [Les modes](#2-les-modes)
3. [La grammaire de Vim](#3-la-grammaire-de-vim)
4. [Se déplacer](#4-se-déplacer)
5. [Éditer, supprimer, annuler](#5-éditer-supprimer-annuler)
6. [Les text objects](#6-les-text-objects)
7. [Copier-coller et registres](#7-copier-coller-et-registres)
8. [Chercher et remplacer](#8-chercher-et-remplacer)
9. [Sauver, quitter, ouvrir un fichier](#9-sauver-quitter-ouvrir-un-fichier)
10. [Explorateur et recherche de fichiers](#10-explorateur-et-recherche-de-fichiers)
11. [Buffers, fenêtres, onglets](#11-buffers-fenêtres-onglets)
12. [Code : LSP, formatage, symboles](#12-code--lsp-formatage-symboles)
13. [Git](#13-git)
14. [Terminal intégré](#14-terminal-intégré)
15. [Débogage (DAP)](#15-débogage-dap)
16. [Sessions](#16-sessions)
17. [Macros, marques, plis, divers](#17-macros-marques-plis-divers)
18. [Raccourcis VS Code / IntelliJ → Neovim](#18-raccourcis-vs-code--intellij--neovim)
19. [Toggles et confort AstroNvim](#19-toggles-et-confort-astronvim)
20. [Commandes de gestion et dépannage](#20-commandes-de-gestion-et-dépannage)
21. [Apprendre et s'entraîner](#21-apprendre-et-sentraîner)
22. [Pièges de cette configuration](#22-pièges-de-cette-configuration)
23. [Mémo condensé](#23-mémo-condensé)

---

## 1. Survivre aux 5 premières minutes

| Touche | Action |
|---|---|
| `i` | passer en mode insertion (taper du texte) |
| `Échap` | revenir en mode normal |
| `:w` + Entrée | sauvegarder |
| `:q` + Entrée | fermer la fenêtre |
| `:wq` + Entrée, ou `ZZ` | sauvegarder et quitter |
| `:q!` + Entrée | quitter sans sauvegarder (voir l'avertissement autosave) |
| `u` | annuler |
| `Ctrl-r` | rétablir |
| `<Space>` seul | afficher le menu which-key |
| `:Tutor` | tutoriel interactif (en anglais) |

> ⚠️ **L'autosave est activé dans cette config** : le fichier est écrit dès que tu
> quittes le mode insertion, changes de fenêtre ou modifies le buffer.
> `:q!` ne protège donc **pas** d'une modification déjà enregistrée.
> Pour annuler, utilise `u` (ou `:earlier`).

---

## 2. Les modes

| Mode | Comment y entrer | À quoi ça sert |
|---|---|---|
| Normal | `Échap` | se déplacer, commander (mode par défaut) |
| Insertion | `i` `a` `I` `A` `o` `O` | taper du texte |
| Visuel | `v` `V` `Ctrl-v` | sélectionner caractères / lignes / bloc |
| Visuel bloc | `Ctrl-v` | sélection en colonnes |
| Commande | `:` | commandes (`:w`, `:q`, `:Tutor`…) |
| Terminal | `<Space>tf` puis `i` | terminal intégré (Échap ne sort pas, voir §14) |
| Remplacement | `R` | écraser du texte en tapant |

- `Ctrl-[` fait la même chose qu'`Échap`.
- En insertion, `jk` ou `jj` rapide fait aussi `Échap` (better-escape).
- `gv` resélectionne la dernière sélection visuelle.

---

## 3. La grammaire de Vim

Une commande Vim se lit :

```
[nombre]  opérateur  [nombre]  déplacement / text-object
   3          d           2           w
   └──────────┴───────────────────────┘
          supprime 6 mots
```

**Opérateurs principaux**

| Touche | Action |
|---|---|
| `d` | supprimer (delete) |
| `c` | supprimer puis passer en insertion (change) |
| `y` | copier (yank) |
| `p` / `P` | coller après / avant |
| `>` / `<` | indenter / désindenter |
| `g~` | inverser la casse |
| `gu` / `gU` | minuscules / majuscules |
| `gq` / `gw` | reformater le texte (largeur) |
| `=` | réindenter automatiquement |
| `g@` | appliquer une fonction (avancé) |

**Exemples**

| Commande | Effet |
|---|---|
| `dw` | supprimer jusqu'au mot suivant |
| `d2w` ou `2dw` | supprimer 2 mots |
| `dd` | supprimer la ligne |
| `3dd` | supprimer 3 lignes |
| `d$` ou `D` | supprimer jusqu'à la fin de ligne |
| `d0` | supprimer jusqu'au début de ligne |
| `diw` | supprimer le mot sous le curseur (sans les espaces) |
| `ciw` | changer le mot sous le curseur |
| `ci"` | changer le contenu entre guillemets |
| `yap` | copier le paragraphe |
| `>ip` | indenter le paragraphe |
| `gUiw` | mettre le mot en majuscules |
| `J` | joindre la ligne suivante (avec espace) |
| `gJ` | joindre sans espace |
| `~` | inverser la casse du caractère |
| `Ctrl-a` / `Ctrl-x` | incrémenter / décrémenter le nombre sous le curseur |

`.` répète la dernière modification. `5.` la répète 5 fois.
`@:` répète la dernière commande `:`.

---

## 4. Se déplacer

### Base

| Touche | Action |
|---|---|
| `h` `j` `k` `l` | gauche, bas, haut, droite |
| `w` / `b` | mot suivant / précédent |
| `W` / `B` | idem, en ignorant la ponctuation |
| `e` / `ge` | fin du mot / fin du mot précédent |
| `0` / `^` | début de ligne / premier caractère non blanc |
| `$` | fin de ligne |
| `gg` / `G` | début / fin du fichier |
| `42G` ou `:42` | aller à la ligne 42 |
| `Ctrl-d` / `Ctrl-u` | descendre / monter d'une demi-page |
| `Ctrl-f` / `Ctrl-b` | page suivante / précédente |
| `Ctrl-e` / `Ctrl-y` | faire défiler d'une ligne |
| `zz` / `zt` / `zb` | centrer / mettre en haut / en bas l'écran sur le curseur |

### Sauts précis

| Touche | Action |
|---|---|
| `f x` | sauter au caractère `x` sur la ligne |
| `F x` | idem, en arrière |
| `t x` / `T x` | s'arrêter juste avant `x` |
| `;` / `,` | répéter le dernier `f`/`t` / en sens inverse |
| `%` | parenthèse, crochet ou accolade correspondante |
| `{` / `}` | paragraphe précédent / suivant |
| `(` / `)` | phrase précédente / suivante |
| `H` / `M` / `L` | haut / milieu / bas de l'écran |
| `Ctrl-o` / `Ctrl-i` | reculer / avancer dans l'historique des sauts |
| `''` | revenir au dernier saut |
| `g;` / `g,` | dernier / précédent emplacement modifié |

### AstroNvim

`j`/`k` suivent les lignes **affichées** (wrapping) quand il n'y a pas de compte.
`5j` descend de 5 lignes réelles.

### Marques

| Commande | Action |
|---|---|
| `ma` | poser la marque `a` |
| `'a` | aller à la ligne de la marque `a` |
| `` `a `` | aller à la position exacte de la marque `a` |
| `:marks` | lister les marques |
| `'.` | dernière modification |
| `'<` / `'>` | début / fin de la dernière sélection visuelle |
| `<Space>f'` | picker des marques |

---

## 5. Éditer, supprimer, annuler

| Touche | Action |
|---|---|
| `i` / `a` | insérer avant / après le curseur |
| `I` / `A` | insérer en début / fin de ligne |
| `o` / `O` | nouvelle ligne en dessous / au-dessus |
| `gi` | revenir au dernier point d'insertion |
| `x` / `X` | supprimer le caractère sous / avant le curseur |
| `r x` | remplacer un caractère par `x` |
| `R` | mode remplacement (écrase au fur et à mesure) |
| `s` / `S` | supprimer le caractère / la ligne et insérer |
| `dd` / `D` | supprimer la ligne / jusqu'à la fin de ligne |
| `cc` / `C` | changer la ligne / jusqu'à la fin de ligne |
| `yy` / `Y` | copier la ligne |
| `p` / `P` | coller après / avant |
| `J` / `gJ` | joindre la ligne suivante avec / sans espace |
| `>>` / `<<` | indenter / désindenter la ligne |
| `u` | annuler |
| `Ctrl-r` | rétablir |
| `U` | annuler toutes les modifications de la ligne |
| `g-` / `g+` | parcourir l'arbre d'annulation |
| `:earlier 10m` / `:later 10m` | remonter / avancer dans le temps |
| `.` | répéter la dernière modification |
| `gcc` | commenter / décommenter la ligne |
| `gc` (visuel) | commenter la sélection |
| `<Space>/` | commenter / décommenter |
| `gco` / `gcO` | ajouter un commentaire en dessous / au-dessus |

En visuel, `>` et `<` gardent la sélection ; `gv` la récupère.
`p` en visuel remplace la sélection **et** écrase le registre non nommé avec le
texte supprimé ; `P` colle sans l'écraser.

---

## 6. Les text objects

Un text object se place **après** un opérateur, ou après `v` en visuel.

| Objet | Signification |
|---|---|
| `iw` / `aw` | mot intérieur / mot + espaces |
| `iW` / `aW` | idem, sans ponctuation |
| `is` / `as` | phrase |
| `ip` / `ap` | paragraphe |
| `i(` / `a(` (ou `ib` / `ab`) | intérieur / autour des parenthèses |
| `i[` / `a[` | crochets |
| `i{` / `a{` (ou `iB` / `aB`) | accolades |
| `i<` / `a<` | chevrons |
| `i"` / `a"` | guillemets doubles |
| `i'` / `a'` | guillemets simples |
| `` i` `` / `` a` `` | backticks |
| `it` / `at` | balise HTML/XML |
| `af` / `if` | fonction (Treesitter) |
| `ac` / `ic` | classe |
| `ak` / `ik` | bloc |
| `aa` / `ia` | argument / paramètre |
| `ao` / `io` | boucle |
| `a?` / `i?` | condition (`if`, `switch`…) |

**Exemples**

| Commande | Effet |
|---|---|
| `ciw` | changer le mot |
| `ci"` | changer l'intérieur des guillemets |
| `da(` | supprimer les parenthèses **et** leur contenu |
| `yaf` | copier la fonction entière |
| `vip` | sélectionner le paragraphe |
| `>i{` | indenter le bloc |
| `gqap` | reformater le paragraphe |

Les text objects Treesitter (`af`, `if`, `ac`, `ic`, `ak`, `ik`, `aa`, `ia`, `ao`,
`io`, `a?`, `i?`) dépendent du langage et du parser installé.

---

## 7. Copier-coller et registres

Le presse-papiers système est branché : `clipboard=unnamedplus`.
Sur ce système (Wayland), `wl-copy` est installé. Donc :

- `yy` copie la ligne **dans le presse-papiers système**.
- `p` colle **depuis le presse-papiers système**.
- En visuel, `Ctrl-c` copie aussi vers le système (mapping perso).
- En insertion, `Ctrl-r +` colle le presse-papiers système (`Ctrl-v` sert à
  insérer un caractère littéral, ce n'est pas un collage).

| Touche | Action |
|---|---|
| `yy` / `dd` | copier / couper la ligne |
| `yiw` / `diw` | copier / supprimer le mot |
| `y$` / `d$` | copier / supprimer jusqu'à la fin de ligne |
| `p` / `P` | coller après / avant |
| `gp` / `gP` | coller puis placer le curseur après |
| `"+y` / `"+p` | forcer le registre système |
| `"*y` / `"*p` | registre X11 (sélection primaire) |
| `"ayy` | copier dans le registre nommé `a` |
| `"ap` | coller le registre `a` |
| `"0p` | coller le dernier **yank** (pas écrasé par les suppressions) |
| `"1p` | coller la dernière suppression |
| `"_dd` | supprimer sans écraser le registre (trou noir) |
| `:reg` ou `<Space>fr` | voir tous les registres |
| `Ctrl-r +` (en insertion) | insérer le presse-papiers système |
| `Ctrl-r a` (en insertion) | insérer le registre `a` |
| `<Space>up` | basculer le mode paste (si l'indentation part en vrille) |

**Astuce** : `"0p` est très utile après avoir collé par-dessus autre chose, car
les suppressions n'écrasent pas le registre `0`.

---

## 8. Chercher et remplacer

### Dans le fichier

| Touche | Action |
|---|---|
| `/texte` + Entrée | chercher vers l'avant |
| `?texte` + Entrée | chercher vers l'arrière |
| `n` / `N` | occurrence suivante / précédente |
| `*` / `#` | chercher le mot sous le curseur (avant / arrière) |
| `g*` / `g#` | idem, sans délimiter le mot |
| `:noh` | enlever le surlignage |
| `:set hlsearch` | activer le surlignage (généralement déjà actif) |

### Remplacer

| Commande | Effet |
|---|---|
| `:s/ancien/nouveau/` | remplacer la 1re occurrence de la ligne |
| `:s/ancien/nouveau/g` | remplacer toutes les occurrences de la ligne |
| `:%s/ancien/nouveau/g` | remplacer dans tout le fichier |
| `:%s/ancien/nouveau/gc` | demander confirmation à chaque fois |
| `:%s/\<mot\>/autre/g` | mot entier uniquement |
| `:'<,'>s/ancien/nouveau/g` | dans la sélection visuelle (le `'<,'>` est ajouté tout seul) |
| `:10,20s/ancien/nouveau/g` | entre les lignes 10 et 20 |
| `&` | répéter la dernière substitution sur la ligne |
| `g&` | répéter sur tout le fichier |
| `:%s/\s\+$//e` | supprimer les espaces en fin de ligne |

**Regex utile**

| Motif | Sens |
|---|---|
| `\v` | mode « very magic » : moins de backslashes |
| `\<` / `\>` | début / fin de mot |
| `\(...\)` | groupe (avec `\v`, `(...)`) |
| `\|` | alternative (avec `\v`, `\|`) |
| `\d` / `\s` / `\w` | chiffre / espace / caractère de mot |
| `.*` | n'importe quoi |
| `^` / `$` | début / fin de ligne |

Exemple : `:%s/\v(\w+)@(\w+)\.com/\1 [at] \2.com/g`.

### Dans le projet

| Touche | Action |
|---|---|
| `<Space>fw` | chercher un texte dans tout le projet (ripgrep) |
| `<Space>fW` | idem, fichiers cachés/ignorés inclus |
| `<Space>fc` | chercher le mot sous le curseur |
| `<Space>ff` | chercher un fichier |
| `<Space>fF` | tous les fichiers (cachés/ignorés inclus) |
| `<Space>fl` | chercher dans les lignes du buffer |
| `<Space>fT` | lister les TODO/FIXME |
| `<Space>fu` | historique d'annulation (picker) |
| `<Space>f<CR>` | reprendre la dernière recherche |

Dans un picker : `Entrée` ouvre, `Ctrl-x` split, `Ctrl-v` split vertical,
`Ctrl-t` onglet, `Tab` sélectionne plusieurs résultats, `Ctrl-q` envoie dans la
quickfix list, `Échap` ferme.

**Remplacer dans tout le projet** : `<Space>fw`, `Ctrl-q` pour envoyer les
résultats dans la quickfix, puis `:cfdo %s/ancien/nouveau/g | update`.
(À faire sur une copie ou après un commit, évidemment.)

---

## 9. Sauver, quitter, ouvrir un fichier

| Commande | Action |
|---|---|
| `:w` | sauvegarder |
| `:w fichier` | sauvegarder sous un autre nom |
| `:wq` / `ZZ` | sauvegarder et fermer |
| `:q` | fermer la fenêtre |
| `:q!` | fermer sans sauvegarder |
| `ZQ` | quitter sans sauvegarder |
| `:wa` | sauvegarder tous les buffers |
| `:qa` / `:qa!` | quitter tout / tout forcer |
| `:e chemin` | ouvrir un fichier |
| `:enew` | nouveau buffer vide |
| `:saveas chemin` | sauvegarder sous un autre nom |
| `:r fichier` | insérer le contenu d'un fichier |
| `:r !commande` | insérer la sortie d'une commande |
| `:!commande` | exécuter une commande shell |
| `:pwd` / `:cd dossier` | dossier courant |
| `:w !sudo tee % > /dev/null` | sauvegarder un fichier système (si tu as sudo) |

Raccourcis AstroNvim : `<Space>w` sauvegarder, `<Space>q` fermer la fenêtre,
`<Space>Q` quitter Neovim, `<Space>n` nouveau fichier, `<Space>R` renommer le
fichier courant.

> ⚠️ Autosave : dès que tu quittes l'insertion ou changes de fenêtre, le fichier
> est écrit. Pour « annuler et quitter », fais `u` puis `:q`, pas `:q!`.

---

## 10. Explorateur et recherche de fichiers

### Ouvrir un projet

```bash
cd mon-projet
nvim .
```

Neo-tree s'ouvre automatiquement quand on ouvre un dossier.

### Neo-tree (barre latérale)

| Touche | Action |
|---|---|
| `<Space>e` | ouvrir / fermer l'explorateur |
| `<Space>o` | donner le focus à l'explorateur |
| `Entrée` ou `l` | ouvrir fichier / dossier |
| `a` | créer un fichier |
| `A` | créer un dossier |
| `d` | supprimer |
| `r` | renommer |
| `c` | copier vers… |
| `m` | déplacer vers… |
| `y` / `x` / `p` | copier / couper / coller |
| `H` | afficher les fichiers cachés |
| `R` | rafraîchir |
| `?` | aide de tous les raccourcis |
| `q` | fermer |

Dans neo-tree, `f` ouvre un sous-menu de recherche (fichiers, grep) dans le
dossier sélectionné.

### Oil (le dossier comme un buffer)

`-` ouvre le dossier parent dans **Oil**. Tu peux y **éditer les noms de
fichiers directement**, puis `:w` pour appliquer les renommages/déplacements/
suppressions. `g?` affiche l'aide, `-` remonte d'un dossier.

### Pickers (le plus rapide)

| Touche | Action |
|---|---|
| `<Space>ff` | fichiers du projet |
| `<Space>fo` | fichiers récents |
| `<Space>fp` | changer de projet |
| `<Space>fb` | buffers ouverts |
| `<Space>fs` | picker « intelligent » (buffers + récents + fichiers) |
| `<Space>fg` | fichiers suivis par git |
| `<Space>f'` | marques |
| `<Space>fr` | registres |
| `<Space>fk` | **tous les raccourcis** (cherchable) |
| `<Space>fh` | aide Neovim |
| `<Space>fC` | commandes Neovim |
| `<Space>fm` | pages man |
| `<Space>fn` | notifications |
| `<Space>ft` | thèmes |
| `<Space>fa` | fichiers de config AstroNvim |

---

## 11. Buffers, fenêtres, onglets

**Buffer** = fichier ouvert en mémoire. **Fenêtre** = vue sur un buffer.
**Onglet** = ensemble de fenêtres. AstroNvim affiche les buffers dans la tabline,
pas les onglets.

### Buffers

| Touche | Action |
|---|---|
| `:ls` | lister les buffers |
| `:b 3` / `:b nom` | aller au buffer 3 / au buffer nommé |
| `]b` / `[b` | buffer suivant / précédent |
| `<Space>fb` | picker des buffers |
| `<Space>bb` | choisir un buffer depuis la tabline |
| `<Space>bp` | buffer précédent |
| `<Space>c` | fermer le buffer courant |
| `<Space>C` | fermer le buffer courant de force |
| `<Space>bd` | fermer un buffer depuis la tabline |
| `<Space>bc` | fermer tous les autres buffers |
| `<Space>bC` | fermer tous les buffers |
| `<Space>bl` / `<Space>br` | fermer les buffers à gauche / à droite |
| `>b` / `<b` | déplacer le buffer à droite / à gauche |
| `<Space>b\` | ouvrir un buffer en split horizontal depuis la tabline |

Pour un split vertical depuis la tabline : `<Space>b` puis la barre verticale `|`.

### Fenêtres

| Touche | Action |
|---|---|
| `:sp fichier` | split horizontal |
| `:vsp fichier` | split vertical |
| `\` | split horizontal |
| Barre verticale | split vertical |
| `Ctrl-h/j/k/l` | aller à gauche / bas / haut / droite |
| `Ctrl-←/→/↑/↓` | redimensionner |
| `Ctrl-w =` | égaliser les tailles |
| `Ctrl-w o` | garder seulement cette fenêtre |
| `:q` ou `<Space>q` | fermer la fenêtre |
| `Ctrl-w x` | échanger deux fenêtres |
| `Ctrl-w r` | faire tourner les fenêtres |

### Onglets

| Touche | Action |
|---|---|
| `:tabnew` | nouvel onglet |
| `gt` / `gT` | onglet suivant / précédent |
| `]t` / `[t` | onglet suivant / précédent (AstroNvim) |
| `:tabclose` | fermer l'onglet |
| `:tabonly` | garder seulement cet onglet |
| `1gt`, `2gt`… | aller à l'onglet 1, 2… |

---

## 12. Code : LSP, formatage, symboles

### Navigation

| Touche | Action |
|---|---|
| `K` | documentation / info sur le symbole |
| `gK` ou `<Space>lh` | aide sur la signature |
| `gd` | aller à la définition |
| `gD` | aller à la déclaration |
| `gI` | aller à l'implémentation |
| `gy` | définition du type |
| `<Space>lr` | renommer le symbole partout |
| `<Space>lR` | chercher les références |
| `<Space>la` | actions de code (import, quick fix…) |
| `<Space>lA` | actions « source » |
| `<Space>lG` | chercher un symbole dans le projet |
| `<Space>ls` | chercher un symbole dans le fichier |
| `<Space>lS` | plan des symboles (aerial) |
| `]y` / `[y` | symbole suivant / précédent (aerial) |
| `]f` / `[f` | fonction suivante / précédente |
| `]k` / `[k` | bloc suivant / précédent |
| `]a` / `[a` | argument suivant / précédent |
| `>F` / `<F` | échanger avec la fonction suivante / précédente |
| `>A` / `<A` | échanger avec l'argument suivant / précédent |

### Diagnostics et formatage

| Touche | Action |
|---|---|
| `]e` / `[e` | erreur suivante / précédente |
| `]w` / `[w` | warning suivant / précédent |
| `<Space>ld` ou `gl` | diagnostic sous le curseur |
| `<Space>lD` | picker de tous les diagnostics |
| `<Space>lf` ou `<Space>cf` | formater le buffer |
| `<Space>lf` (visuel) | formater la sélection |
| `<Space>uf` / `<Space>uF` | activer/désactiver l'autoformat (buffer / global) |
| `<Space>li` | santé du LSP (`:checkhealth vim.lsp`) |
| `<Space>ll` / `<Space>lL` | rafraîchir / exécuter les CodeLens |
| `<Space>uL` | activer/désactiver les CodeLens |
| `<Space>uh` / `<Space>uH` | inlay hints (buffer / global) |
| `<Space>u?` | aide à la signature automatique |

Le LSP s'installe via **Mason** : `:Mason`. Si un serveur manque, `:Mason`
puis `i` sur le paquet. Les serveurs installés sont visibles dans `:Mason`.

### Python / Java / Kotlin

- Python : `<Space>lv` choisit le virtualenv (venv-selector).
- Java : `nvim-jdtls` est installé ; utilise `<Space>la` (actions de code) pour
  organiser les imports, ou `:lua require('jdtls').organize_imports()`.
- Kotlin : le LSP tourne avec le JDK 21 (voir §22).
- Maven : `:Mvn`, `:MvnClean`, `:MvnCompile`, `:MvnTest`, `:MvnPackage`,
  `:MvnInstall`, `:MvnVerify`, `:MvnDependencyTree`.
- Tests : `<Space>ntr` (test le plus proche), `<Space>ntf` (fichier),
  `<Space>ntl` (dernier), `<Space>nts` (résumé), `<Space>nto` (sortie).

---

## 13. Git

| Touche | Action |
|---|---|
| `<Space>gt` | statut git (picker) |
| `<Space>gc` | commits du dépôt |
| `<Space>gC` | commits du fichier |
| `<Space>gb` | branches |
| `<Space>gT` | stash |
| `<Space>go` | ouvrir le fichier/ligne sur GitHub |
| `<Space>gg` ou `<Space>tl` | lazygit (⚠️ non installé, voir §22) |
| `]g` / `[g` | hunk suivant / précédent |
| `]G` / `[G` | premier / dernier hunk |
| `<Space>gs` | stage / unstage le hunk |
| `<Space>gS` | stage le buffer |
| `<Space>gr` | reset le hunk |
| `<Space>gR` | reset le buffer |
| `<Space>gp` | prévisualiser le hunk |
| `<Space>gl` / `<Space>gL` | blame ligne / blame complet |
| `<Space>gd` | diff du fichier |
| `ig` (opérateur/visuel) | « inside hunk » |

Les marques `▎` dans la marge indiquent les modifications (gitsigns).

**Commit rapide sans lazygit** : `<Space>tf` (terminal), puis
`git add -p` et `git commit`. Ou installe lazygit pour `<Space>gg`.

---

## 14. Terminal intégré

| Touche | Action |
|---|---|
| `<Space>tf` | terminal flottant |
| `<Space>th` | terminal horizontal (10 lignes) |
| `<Space>tv` | terminal vertical (80 colonnes) |
| `<Space>tn` | terminal Node |
| `<Space>tp` | terminal Python |
| `F7` | basculer le terminal |
| `Ctrl-'` | basculer le terminal (si le terminal l'envoie) |

Dans un terminal, **`Échap` ne sort pas** : c'est le programme qui le reçoit.
Pour revenir en mode normal : `Ctrl-\` puis `Ctrl-n` (deux touches séparées).
Ensuite, `i` pour ré-entrer dans le terminal.

---

## 15. Débogage (DAP)

| Touche | Action |
|---|---|
| `F5` | démarrer / continuer |
| `F9` | point d'arrêt |
| `F10` | pas à pas principal (step over) |
| `F11` | entrer dans la fonction (step into) |
| `Shift-F11` | sortir de la fonction (step out) |
| `Shift-F5` | terminer la session |
| `Ctrl-F5` | redémarrer |
| `F6` | pause |
| `<Space>db` / `<Space>dB` | point d'arrêt / tout supprimer |
| `<Space>dc` | démarrer / continuer |
| `<Space>di` / `<Space>do` / `<Space>dO` | step into / over / out |
| `<Space>dq` / `<Space>dQ` | fermer / terminer la session |
| `<Space>dr` | redémarrer |
| `<Space>ds` | exécuter jusqu'au curseur |
| `<Space>dR` | REPL |
| `<Space>du` | interface du débogueur |
| `<Space>dh` | survol d'une variable |
| `<Space>dE` (visuel) | évaluer la sélection |

Les touches F peuvent être capturées par le terminal ou le bureau ; les
raccourcis `<Space>d…` sont les alternatives fiables.

---

## 16. Sessions

| Touche | Action |
|---|---|
| `<Space>Sl` | charger la dernière session |
| `<Space>Ss` | sauvegarder la session |
| `<Space>SS` | sauvegarder la session du dossier |
| `<Space>St` | sauvegarder l'onglet courant |
| `<Space>Sf` | charger une session |
| `<Space>SF` | charger une session de dossier |
| `<Space>S.` | charger la session du dossier courant |
| `<Space>Sd` / `<Space>SD` | supprimer une session / session de dossier |

AstroNvim sauvegarde automatiquement la dernière session et la session du
dossier à la fermeture. À la réouverture, `<Space>Sl` (ou `s` sur l'écran
d'accueil) la restaure.

---

## 17. Macros, marques, plis, divers

### Macros

| Commande | Action |
|---|---|
| `qa` | commencer l'enregistrement dans le registre `a` |
| `q` | arrêter l'enregistrement |
| `@a` | rejouer la macro `a` |
| `@@` | rejouer la dernière macro |
| `5@a` | rejouer 5 fois |
| `qA` | ajouter à la fin de la macro `a` |
| `:normal @a` | rejouer sur les lignes sélectionnées |

### Plis (folds)

| Touche | Action |
|---|---|
| `za` | ouvrir / fermer le pli sous le curseur |
| `zo` / `zc` | ouvrir / fermer |
| `zR` / `zM` | tout ouvrir / tout fermer |
| `zj` / `zk` | pli suivant / précédent |
| `zv` | ouvrir juste assez pour voir le curseur |
| `zf` | créer un pli manuel (sélection) |

AstroNvim calcule les plis via LSP/Treesitter/indentation (`foldcolumn = 1`).

### Divers

| Touche | Action |
|---|---|
| `gx` | ouvrir l'URL sous le curseur |
| `gf` | ouvrir le fichier sous le curseur |
| `Ctrl-^` | fichier alternatif |
| `q:` | historique des commandes |
| `q/` | historique des recherches |
| `:set spell` ou `<Space>us` | correcteur orthographique |
| `]s` / `[s` | faute suivante / précédente |
| `z=` | suggestions d'orthographe |
| `zg` / `zw` | ajouter / retirer un mot du dictionnaire |
| `:earlier 10m` / `:later 10m` | voyage dans le temps |
| `g-` / `g+` | arbre d'annulation |
| `!!commande` | filtrer la ligne par une commande shell |
| `:g/motif/d` | supprimer toutes les lignes contenant le motif |
| `:v/motif/d` | supprimer toutes les lignes ne contenant pas le motif |
| `:normal @a` | appliquer une macro à une plage |

---

## 18. Raccourcis VS Code / IntelliJ → Neovim

C'est ici que se règle ta question sur **Ctrl-Shift-E**.

| Habitude VS Code / IntelliJ | Équivalent ici |
|---|---|
| `Ctrl-S` sauver | `:w`, `<Space>w` (et autosave) |
| `Ctrl-Z` annuler | `u` |
| `Ctrl-Y` / `Ctrl-Shift-Z` rétablir | `Ctrl-r` |
| `Ctrl-C` copier | `y` (visuel) ou `yy` |
| `Ctrl-X` couper | `d` (visuel) ou `dd` |
| `Ctrl-V` coller | `p` |
| `Ctrl-F` chercher | `/` ou `<Space>fl` |
| `Ctrl-H` remplacer | `:%s/ancien/nouveau/gc` |
| `Ctrl-P` ouvrir un fichier | `<Space>ff` |
| `Ctrl-Shift-P` palette de commandes | `:` ou `<Space>fC` |
| `Ctrl-Shift-E` explorateur | **`<Space>e`** (voir ci-dessous) |
| `Ctrl-Shift-F` chercher dans le projet | `<Space>fw` |
| `Ctrl-B` masquer la barre latérale | `<Space>e` |
| `Ctrl-/` commenter | `<Space>/` ou `gcc` |
| `F12` aller à la définition | `gd` |
| `Shift-F12` références | `<Space>lR` |
| `Ctrl-Space` complétion | `Ctrl-Space` (blink) |
| `Ctrl-Tab` changer d'onglet | `]b` / `[b` ou `<Space>fb` |
| `Ctrl-W` fermer l'onglet | `:bd` ou `<Space>c` (⚠️ `Ctrl-W` est un préfixe de fenêtre) |
| `Alt-↑/↓` déplacer la ligne | `:m .-2` / `:m .+1` (pas de raccourci par défaut) |

### Ctrl-Shift-E

**Ctrl-Shift-E n'existe pas dans Neovim.** C'est un raccourci VS Code /
IntelliJ pour ouvrir l'explorateur. Ici, l'équivalent est :

- `<Space>e` : ouvrir/fermer neo-tree ;
- `<Space>o` : y mettre le focus ;
- `-` : ouvrir Oil sur le dossier courant.

De plus, beaucoup de terminaux **n'envoient pas** `Ctrl-Shift-E` à Neovim
(ils l'interceptent ou l'envoient comme `Ctrl-E`). Si tu veux vraiment le
forcer, ajoute ceci dans `lua/plugins/astrocore.lua` (section `mappings.n`) :

```lua
["<C-S-e>"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
```

…et utilise un terminal qui transmet ce raccourci (Kitty, WezTerm, Ghostty).
Sinon, reste sur `<Space>e`, c'est plus fiable.

---

## 19. Toggles et confort AstroNvim

| Touche | Action |
|---|---|
| `<Space>h` | écran d'accueil (fichiers récents, favoris) |
| `<Space>e` / `<Space>o` | explorateur / focus explorateur |
| `<Space>w` | sauvegarder |
| `<Space>q` / `<Space>Q` | fermer la fenêtre / quitter Neovim |
| `<Space>n` | nouveau fichier |
| `<Space>R` | renommer le fichier courant |
| `<Space>/` | commenter |
| `<Space>un` | numéros de ligne |
| `<Space>uw` | retour à la ligne (wrap) |
| `<Space>us` | correcteur orthographique |
| `<Space>ud` | diagnostics |
| `<Space>uv` / `<Space>uV` | texte virtuel / lignes virtuelles |
| `<Space>ut` | tabline |
| `<Space>ul` | statusline |
| `<Space>up` | mode paste |
| `<Space>uZ` | mode zen |
| `<Space>u` puis barre verticale | guides d'indentation |
| `<Space>uD` | fermer les notifications |
| `<Space>ur` | surlignage des références |
| `<Space>uA` | autochdir |
| `<Space>ub` | fond clair/sombre |
| `<Space>ug` | signcolumn |
| `<Space>u>` | foldcolumn |
| `<Space>ui` | réglage de l'indentation |
| `<Space>uN` | notifications |
| `<Space>uS` | conceal |
| `<Space>uu` | surlignage des URL |
| `<Space>uy` | syntaxe du buffer |

Pour retrouver la disposition de la capture d'écran : `<Space>e` (explorateur
à gauche) puis `<Space>lS` (plan des symboles à droite). Le thème est
`astrodark`, avec un fond noir et des couleurs plus vives (voir
`lua/plugins/astroui.lua`). `<Space>ft` permet de changer de thème.
Pour ajuster une couleur : modifie la palette dans `lua/plugins/astroui.lua`,
puis `:colorscheme astrodark` (ou redémarre Neovim).

---

## 20. Commandes de gestion et dépannage

| Commande | Action |
|---|---|
| `:Lazy` | gérer les plugins |
| `:Lazy update` | mettre à jour les plugins |
| `:Lazy sync` | installer/mettre à jour/supprimer |
| `:Mason` | gérer les LSP, formateurs, linters |
| `:checkhealth` | diagnostic général |
| `:checkhealth vim.lsp` | diagnostic LSP |
| `:messages` | voir les messages/erreurs |
| `:Tutor` | tutoriel interactif |
| `:help sujet` | aide (`:help registers`, `:help text-objects`…) |
| `:Mvn`, `:MvnTest`, `:MvnPackage`… | commandes Maven |
| `:e chemin` | ouvrir un fichier |
| `:terminal` | terminal intégré |
| `:Neotree` / `:Oil` | ouvrir les explorateurs |
| `:colorscheme astrodark` | revenir au thème |
| `:set ft?` | voir le type de fichier |
| `:LspRestart` | redémarrer les LSP (si disponible) |

**Si une touche ne fait rien** :

1. Appuie sur `<Space>` et regarde which-key.
2. `<Space>fk` cherche dans tous les raccourcis.
3. `:map <touche>` montre le mapping exact.
4. `:messages` montre les erreurs.
5. `:checkhealth` vérifie l'installation.

**Si le LSP ne répond pas** : `:Mason` (le serveur est-il installé ?),
`:checkhealth vim.lsp`, puis redémarre Neovim. Pour un fichier isolé, vérifie
que le dossier est bien un projet (racine git, `pom.xml`, `package.json`…).

**Si le presse-papiers ne marche pas** : sur Wayland, `wl-copy` doit être
installé (c'est le cas ici). Sur X11, ce serait `xclip` ou `xsel`.

**Si les icônes sont des carrés** : installe une **Nerd Font** dans ton
terminal (JetBrainsMono Nerd Font, par exemple) et sélectionne-la.

**Si lazygit manque** : `<Space>gg` ne marchera pas. Installe `lazygit`, ou
utilise `<Space>gt` et le terminal.

---

## 21. Apprendre et s'entraîner

1. **`:Tutor`** — tutoriel interactif officiel (en anglais dans cette version
   de Neovim). 30 minutes, très rentable.
2. **`vimtutor fr`** — la version française du tutoriel Vim, dans un terminal
   (elle utilise Vim, pas Neovim, mais les commandes de base sont identiques).
3. **`<Space>fk`** — liste cherchable de tous les raccourcis de ta config.
4. **`<Space>fh`** — chercher dans l'aide intégrée.
5. **`:help`** — l'aide de référence : `:help keycodes`, `:help registers`,
   `:help text-objects`, `:help motion.txt`.
6. **`<Space>h`** — écran d'accueil avec les fichiers récents.

**Plan de progression suggéré**

| Jour | Objectif |
|---|---|
| 1 | modes, `hjkl`, `i`/`Échap`, `:w`/`:q`, `u`/`Ctrl-r` |
| 2 | `w`/`b`, `0`/`$`, `gg`/`G`, `dd`/`yy`/`p`, `/` et `n` |
| 3 | la grammaire `opérateur + déplacement`, `ciw`, `ci"`, `di(` |
| 4 | `<Space>ff`, `<Space>fw`, `<Space>e`, `<Space>fb` |
| 5 | `gd`, `K`, `<Space>lr`, `<Space>la`, `<Space>lf` |
| 6 | `q`/`@`, marques, macros, splits |
| 7 | tout le reste : git, terminal, sessions, DAP |

Ne cherche pas à tout mémoriser : utilise `<Space>` et which-key. Les doigts
apprennent par répétition.

---

## 22. Pièges de cette configuration

- **Autosave** : `FocusLost`, `InsertLeave` et `TextChanged` écrivent le
  fichier. `:q!` ne restaure pas l'état précédent. Utilise `u` ou `:earlier`.
- **`<Space>c` attend 300 ms** : `<Space>cf` (formater) commence par
  `<Space>c`, donc Neovim attend de savoir si tu vas taper `f`. C'est normal.
- **Lazygit n'est pas installé** : `<Space>gg` et `<Space>tl` échoueront.
  `<Space>gt` (statut git) fonctionne sans.
- **Kotlin** : le LSP utilise le JDK 21 (`~/.jdks/ms-21.0.11`), pas Java 25.
- **Copilot** : `github/copilot.vim` est installé mais doit être authentifié
  avec `:Copilot setup`. Il accepte les suggestions avec `Tab` (attention aux
  conflits avec blink).
- **`Ctrl-S` / `Ctrl-Q`** : certains terminaux interceptent ces touches
  (contrôle de flux). Si `Ctrl-S` gèle le terminal, tape `stty -ixon` dans ton
  shell, ou utilise `<Space>w`.
- **`Ctrl-Shift-E`** : voir §18, ce n'est pas un raccourci Neovim.
- **`:Tutor` est en anglais** dans cette version ; `vimtutor fr` est en
  français.
- **Le fork AstroNvim** n'a pas de tags Git, donc `pin_plugins = false` : le
  core suit `main` du fork. Si une mise à jour casse quelque chose,
  `:Lazy restore` ou les snapshots peuvent aider.
- **Ancienne config** : `~/.config/nvim.bak-2026-11-19`.

---

## 23. Mémo condensé

```
MODES          i a I A o O   Échap   v V Ctrl-v   :   R
SAUVER         :w  :wq  ZZ   :q  :q!  ZQ   <Space>w  <Space>q
DÉPLACEMENT    h j k l   w b e  0 ^ $  gg G   42G  :42
               f x  t x  ;  ,   %  { }   Ctrl-d/u/f/b  zz
ÉDITER         x  r  s  dd  cc  yy  p  P  J  >>  <<  u  Ctrl-r  .
TEXT OBJECTS   iw aw  i" a"  i( a(  i{ a{  ip ap  af if  ac ic
COPIER         yy  yiw  "+y  "ayy  "0p  "_dd   :reg  <Space>fr
CHERCHER       /mot  n N  *  :noh   :%s/a/b/gc   <Space>fw
FICHIERS       <Space>ff  <Space>fo  <Space>fb  <Space>fp
EXPLORATEUR    <Space>e  <Space>o  -  (Oil)
BUFFERS        ]b [b  <Space>fb  <Space>c  <Space>bd
FENÊTRES       Ctrl-h/j/k/l  \  |  :sp  :vsp  Ctrl-w =
LSP            K  gd  gI  <Space>lr  <Space>lR  <Space>la
               <Space>lf  ]e [e  ]w [w  <Space>ld
GIT            <Space>gt  <Space>gc  ]g [g  <Space>gs  <Space>gl
TERMINAL       <Space>tf  <Space>th  <Space>tv  F7
               sortir : Ctrl-\ puis Ctrl-n
SESSIONS       <Space>Sl  <Space>Ss  <Space>Sf
AIDE           <Space>fk  <Space>fh  :Tutor  :help  :checkhealth
```

---

*Dernière mise à jour : 19 novembre 2026.*
