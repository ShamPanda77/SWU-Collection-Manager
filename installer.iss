#define MyAppName "SWU Collection Manager"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "ShamPanda77"
#define MyAppExeName "SWU_Collection_Manager.exe"

[Setup]
AppId={{8B7A7B52-4E0E-4D8A-A4A0-8C3E1B5D2A91}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\SWU Collection Manager
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=installer_output
OutputBaseFilename=SWU_Collection_Manager_Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64
SetupIconFile=SWU_Collection_Manager.ico
UninstallDisplayIcon={app}\SWU_Collection_Manager.exe

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Créer un raccourci sur le Bureau"; GroupDescription: "Raccourcis :"; Flags: unchecked

[Files]
Source: "dist\SWU_Collection_Manager.exe"; DestDir: "{app}"; Flags: ignoreversion

; Base SQLite initiale : copiée uniquement lors de la première installation.
; Une mise à jour ne remplace jamais la base utilisateur existante.
Source: "release_data\SWU_Collection_Manager.sqlite"; DestDir: "{localappdata}\SWU Collection Manager\Donnees"; Flags: onlyifdoesntexist

; Les icônes d'affinité sont initialisées dans les données utilisateur mais
; ne sont jamais remplacées lors d'une mise à jour.
Source: "release_data\affinity_icons\*"; DestDir: "{localappdata}\SWU Collection Manager\aspect_icons"; Flags: ignoreversion onlyifdoesntexist recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\SWU Collection Manager"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\SWU Collection Manager"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Lancer SWU Collection Manager"; Flags: nowait postinstall skipifsilent
