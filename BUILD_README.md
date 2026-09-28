# SWU Collection Manager — première release Windows

## Chaîne de build

1. `SWU_Collection_Manager_V493.py` est empaqueté par PyInstaller en `SWU_Collection_Manager.exe`.
2. Inno Setup 7 transforme cet EXE en `SWU_Collection_Manager_Setup.exe`.
3. L'asset GitHub de chaque release doit conserver exactement le nom `SWU_Collection_Manager_Setup.exe`.

URL permanente utilisée par le bouton de mise à jour :

`https://github.com/ShamPanda77/SWU-Collection-Manager/releases/latest/download/SWU_Collection_Manager_Setup.exe`

## Données utilisateur

Le programme installé stocke les données modifiables dans :

`%LOCALAPPDATA%\SWU Collection Manager`

Cela comprend la base SQLite, les comptes, les collections, les listes, les sauvegardes et le cache d'images.

L'installeur ne remplace la base SQLite initiale que si elle n'existe pas encore (`onlyifdoesntexist`). Les mises à jour remplacent le programme, pas les données utilisateur.
