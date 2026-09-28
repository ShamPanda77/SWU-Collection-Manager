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
Source: "SWU_Collection_Manager.ico"; DestDir: "{app}"; Flags: ignoreversion

; Base SQLite initiale : copiée uniquement lors de la première installation.
; Une mise à jour ne remplace jamais la base utilisateur existante.
Source: "release_data\SWU_Collection_Manager.sqlite"; DestDir: "{localappdata}\SWU Collection Manager\Donnees"; Flags: onlyifdoesntexist uninsneveruninstall uninsneveruninstall

; Les icônes d'affinité sont initialisées dans les données utilisateur mais
; ne sont jamais remplacées lors d'une mise à jour.
Source: "release_data\aspect_icons\*"; DestDir: "{localappdata}\SWU Collection Manager\Donnees\aspect_icons"; Flags: ignoreversion onlyifdoesntexist uninsneveruninstall recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\SWU Collection Manager"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\SWU_Collection_Manager.ico"; IconIndex: 0
Name: "{autodesktop}\SWU Collection Manager"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\SWU_Collection_Manager.ico"; IconIndex: 0; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Lancer SWU Collection Manager"; Flags: nowait postinstall skipifsilent


[Code]
var
  KeepUserData: Boolean;

procedure CurUninstallStepChanged(AStep: TUninstallStep);
var
  UserDataRoot: String;
  Answer: Integer;
begin
  if AStep = usUninstall then
  begin
    { En mode silencieux, on conserve toujours les données pour éviter
      une suppression destructive sans confirmation explicite. }
    if UninstallSilent then
    begin
      KeepUserData := True;
      Exit;
    end;

    Answer := MsgBox(
      'Voulez-vous conserver vos données personnelles ?' + #13#10 + #13#10 +
      'Si vous choisissez OUI, vos collections, listes, comptes utilisateurs,' + #13#10 +
      'sauvegardes et autres données personnelles seront conservés.' + #13#10 + #13#10 +
      'Si vous choisissez NON, toutes les données personnelles de SWU Collection Manager' + #13#10 +
      'seront également supprimées.',
      mbConfirmation,
      MB_YESNO
    );

    KeepUserData := (Answer = IDYES);
  end
  else if AStep = usPostUninstall then
  begin
    if not KeepUserData then
    begin
      UserDataRoot := ExpandConstant('{localappdata}\SWU Collection Manager');
      if DirExists(UserDataRoot) then
        DelTree(UserDataRoot, True, True, True);
    end;
  end;
end;
