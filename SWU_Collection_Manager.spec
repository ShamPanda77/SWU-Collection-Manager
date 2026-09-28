# -*- mode: python ; coding: utf-8 -*-
from pathlib import Path
from PyInstaller.utils.hooks import collect_data_files

ROOT = Path(SPEC).resolve().parent

# Les icônes d'affinité sont des ressources de lecture. Les données utilisateur
# (base, comptes, collections, cache, sauvegardes) ne sont volontairement pas
# intégrées dans l'EXE : elles sont gérées par Inno Setup dans %LOCALAPPDATA%.
datas = []
icons_dir = ROOT / "release_data" / "aspect_icons"
if icons_dir.exists():
    datas.append((str(icons_dir), "aspect_icons"))

# ReportLab utilise plusieurs fichiers de données de polices/encodages.
datas += collect_data_files("reportlab")

hiddenimports = [
    "reportlab.pdfbase._fontdata",
    "reportlab.pdfbase.ttfonts",
    "reportlab.pdfbase.pdfmetrics",
    "reportlab.lib.utils",
    "openpyxl",
]

# L'application est une interface Tkinter sans console.
a = Analysis(
    [str(ROOT / "SWU_Collection_Manager_V495.py")],
    pathex=[str(ROOT)],
    binaries=[],
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name="SWU_Collection_Manager",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    icon=str(ROOT / "SWU_Collection_Manager.ico") if (ROOT / "SWU_Collection_Manager.ico").exists() else None,
)
