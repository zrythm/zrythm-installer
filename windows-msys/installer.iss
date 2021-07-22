;
; Copyright (C) 2020-2021 Alexandros Theodotou <alex at zrythm dot org>
;
; This file is part of Zrythm
;
; Zrythm is free software: you can redistribute it and/or modify
; it under the terms of the GNU Affero General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; Zrythm is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU Affero General Public License for more details.
;
; You should have received a copy of the GNU Affero General Public License
; along with Zrythm.  If not, see <https://www.gnu.org/licenses/>.
;
; define AppName and AppVersion through the command line

[Setup]
AppId=zrythm1
AppName={#AppName}
AppComments={#AppName}
AppPublisher=Alexandros Theodotou
AppPublisherURL=https://www.zrythm.org
AppContact=https://www.zrythm.org
AppCopyright=Copyright (C) 2018-2020 Alexandros Theodotou
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
ChangesAssociations=yes
OutputBaseFilename={#AppName} {#AppVersion}
OutputManifestFile=Setup-Manifest.txt
SetupIconFile=zrythm.ico
SetupLogging=yes
WizardStyle=modern
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
UninstallDisplayIcon={app}\bin\zrythm.exe
LicenseFile={#file AddBackslash(SourcePath) + "COPYING"}
VersionInfoVersion={#AppInfoVersion}
Compression=lzma2/ultra64
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Types]
Name: "full"; Description: "Full installation"
Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "zrythm"; Description: "Zrythm DAW"; \
  Types: full compact custom; Flags: fixed
Name: "plugins"; Description: "Bundled LV2 plugins"; \
  Types: full

[Tasks]
Name: desktopicon; Description: "Create a &desktop icon"; \
  GroupDescription: "Additional icons:"; Components: zrythm
Name: quicklaunchicon; \
  Description: "Create a &Quick Launch icon"; \
  GroupDescription: "Additional icons:"; \
  Components: zrythm

[Files]
Source: "bin\*"; DestDir: "{app}\bin"; \
  Flags: ignoreversion recursesubdirs; \
  Components: zrythm
Source: "lib\*"; DestDir: "{app}\lib"; \
  Flags: ignoreversion recursesubdirs; \
  Components: zrythm
Source: "share\*"; DestDir: "{app}\share"; \
  Flags: ignoreversion recursesubdirs; \
  Components: zrythm
Source: "etc\*"; DestDir: "{app}\etc"; \
  Flags: ignoreversion recursesubdirs; \
  Components: zrythm
Source: "Zrythm-*.pdf"; DestDir: "{app}"; \
  Flags: skipifsourcedoesntexist; \
  Components: zrythm
Source: "COPYING"; DestDir: "{app}"; \
  Components: zrythm
Source: "COPYING.GPL3"; DestDir: "{app}"; \
  Components: zrythm
Source: "THANKS"; DestDir: "{app}"; \
  Components: zrythm
Source: "TRANSLATORS"; DestDir: "{app}"; \
  Components: zrythm
Source: "CONTRIBUTING.md"; DestDir: "{app}"; \
  Components: zrythm
Source: "CHANGELOG.md"; DestDir: "{app}"; \
  Components: zrythm
Source: "AUTHORS"; DestDir: "{app}"; \
  Components: zrythm
Source: "THIRDPARTY_INFO"; DestDir: "{app}"; \
  Components: zrythm
Source: "third_party\*"; DestDir: "{app}\third_party"; \
  Flags: ignoreversion recursesubdirs; \
  Components: zrythm
Source: "INSTALLER_README.txt"; DestDir: "{app}"; Flags: isreadme; \
  Components: zrythm
Source: "README.md"; DestDir: "{app}"; \
  Components: zrythm
Source: "share\fonts\zrythm\DSEG14-Classic-MINI\DSEG14ClassicMini-Italic.ttf"; \
  DestDir: "{fonts}"; FontInstall: "DSEG14 Classic Mini-Italic (OpenType)"; \
  Flags: onlyifdoesntexist uninsneveruninstall fontisnttruetype; \
  Components: zrythm
Source: "{#PluginsDir}\*"; DestDir: "{commoncf}\LV2"; \
  Flags: ignoreversion recursesubdirs; \
  Components: plugins

[Messages]

[CustomMessages]

[LangOptions]

[Code]

[Icons]
Name: "{app}\{#AppName}"; Filename:"{app}\bin\zrythm.exe"; \
  WorkingDir: "{app}"; Components: zrythm
Name: "{group}\{#AppName}"; Filename:"{app}\bin\zrythm.exe"; \
  WorkingDir: "{app}"; Components: zrythm; \
  Tasks: quicklaunchicon
Name: "{autoprograms}\{#AppName}"; \
  Filename: "{app}\bin\zrythm.exe"; \
  WorkingDir: "{app}"; Components: zrythm; \
  Tasks: quicklaunchicon
Name: "{autodesktop}\{#AppName}"; \
  Filename: "{app}\bin\zrythm.exe"; \
  WorkingDir: "{app}"; Components: zrythm; \
  Tasks: desktopicon

[Registry]
; Zrythm is used as an org name here
Root: HKLM; Subkey: "Software\Zrythm"; \
  Flags: uninsdeletekeyifempty; Check: IsAdminInstallMode
Root: HKLM; Subkey: "Software\Zrythm\Zrythm"; \
  Flags: uninsdeletekey; Check: IsAdminInstallMode
Root: HKLM; Subkey: "Software\Zrythm\Zrythm\Settings"; \
  ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: IsAdminInstallMode
; register associations
Root: HKLM; Subkey: "Software\Classes\.zpj"; \
  ValueType: string; ValueName: ""; ValueData: "ZrythmProject"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "Software\Classes\ZrythmProject"; \
  ValueType: string; ValueName: ""; \
  ValueData: "Zrythm Project"; Flags: uninsdeletekey
Root: HKLM; \
  Subkey: "Software\Classes\ZrythmProject\DefaultIcon"; \
  ValueType: string; ValueName: ""; \
  ValueData: "{app}\bin\zrythm.exe,0"
Root: HKLM; \
  Subkey: "Software\Classes\ZrythmProject\shell\open\command"; \
  ValueType: string; ValueName: ""; \
  ValueData: """{app}\bin\zrythm.exe"" ""%1"""
