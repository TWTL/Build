; TWTL Installer NSIS Script

; inclusion and definitions
!include "MUI2.nsh"
!include ".\TWTL.defs.Files.nsh"
!include ".\TWTL.macro.RemoveFilesAndSubDirs.nsh"

!define ORGNAME "NOTRESPONDING"
!define APPNAME "TWTL"
!define VERSION_MAJOR 1
!define VERSION_MINOR 0
Unicode True
SetCompress Off

!define REG_KEY_INST_INFO \
  "Software\${APPNAME}"
!define REG_KEY_UNINST_INFO \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"

!define VERSION_STRING "${VERSION_MAJOR}.${VERSION_MINOR}"

; Beginning of installer description
Name "${APPNAME}"
Icon "TWTL.ico"
OutFile "TWTLInstaller.exe"

InstallDir "$ProgramFiles\${APPNAME}"
ShowInstDetails Show
XPStyle On
RequestExecutionLevel Admin

!define MUI_ICON "TWTL.ico"
!define MUI_UNICON "TWTL.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "TWTL.MUIHeaderImage.bmp"
!define MUI_HEADERIMAGE_UNBITMAP_NOSTRETCH
!define MUI_WELCOMEFINISHPAGE
!define MUI_WELCOMEFINISHPAGE_BITMAP "TWTL.MUIWelcomeFinishPage.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH
!define MUI_UNWELCOMEFINISHPAGE
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "TWTL.MUIWelcomeFinishPage.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP_NOSTRETCH
!define MUI_ABORTWARNING
!define MUI_COMPONENTSPAGE_NODESC

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "English"

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Function un.onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

InstType "Full"
InstType "Minimal"

Section "Basic installation"
  SectionIn RO
  ; File installation
  SetOutPath $InstDir
  CreateDirectory $InstDir
  File License.txt
  File TWTL.ico
  File /oname=${INST_SERVICE_EXEC_NAME} "${BUILD_SERVICE_EXEC_PATH}"
  File /oname=${INST_ENGINE_EXEC_NAME} "${BUILD_ENGINE_EXEC_PATH}"
  File /oname=${INST_ENGINE_DLL1_NAME} "${BUILD_ENGINE_DLL1_PATH}"
  File /oname=${INST_ENGINE_DLL2_NAME} "${BUILD_ENGINE_DLL2_PATH}"
  File /oname=${INST_GUI_EXEC_NAME} "${BUILD_GUI_EXEC_PATH}"
  SetOutPath $InstDir\"${INST_GUI_DATA_NAME}"
  File /nonfatal /a /r "${BUILD_GUI_DATA_PATH}"
  ; Registry installation
  WriteRegStr HKLM \
    "${REG_KEY_INST_INFO}" \
    "SvcPath" "$InstDir\${INST_SERVICE_EXEC_NAME}"
  WriteRegStr HKLM \
    "${REG_KEY_INST_INFO}" \
    "EnginePath" "$InstDir\${INST_ENGINE_EXEC_NAME}"
  WriteRegStr HKLM \
    "${REG_KEY_INST_INFO}" \
    "GUIPath" "$InstDir\${INST_GUI_EXEC_NAME}"
  ; Service installation (startup: Section "Start service now")
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Install'
  ; Uninstaller generation and registry uninstallation information
  WriteUninstaller "$InstDir\${INST_UNINST_EXEC_NAME}"
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "InstallLocation" "$\"$InstDir$\""
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "DisplayName" "${APPNAME}"
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "DisplayVersion" "${VERSION_STRING}"
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "DisplayIcon" "$\"$InstDir\TWTL.ico$\""
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "Publisher" "${ORGNAME}"
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "UninstallString" "$\"$InstDir\${INST_UNINST_EXEC_NAME}$\""
  WriteRegDWORD HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "VersionMajor" ${VERSION_MAJOR}
  WriteRegDWORD HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "VersionMinor" ${VERSION_MINOR}
SectionEnd

Section "Start service now"
  SectionIn 1 2
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Start'
SectionEnd

Section "Create shortcut in Start menu"
  SectionIn 1
  CreateDirectory "$SMPrograms\${APPNAME}"
  CreateShortCut \
    "$SMPrograms\${APPNAME}\${APPNAME}.lnk" \
    "$InstDir\${INST_GUI_EXEC_NAME}" \
    "$InstDir\TWTL.ico"
SectionEnd

Section "Create shortcut in Desktop"
  SectionIn 1
  CreateShortCut \
    "$Desktop\${APPNAME}.lnk" \
    "$InstDir\${INST_GUI_EXEC_NAME}" \
    "$InstDir\TWTL.ico"
SectionEnd

Section "Uninstall"
  ; Stop and delete service
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Stop'
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Uninstall'
  sleep 1000 ; stand for service really removed
  ; Uninstall files
  !insertmacro RemoveFilesAndSubDirs "$InstDir"
  RmDir "$InstDir"
  !insertmacro RemoveFilesAndSubDirs "$SMPrograms\${APPNAME}"
  RmDir "$SMPrograms\${APPNAME}"
  Delete "$Desktop\${APPNAME}.lnk"
  ; Uninstall registry
  DeleteRegKey HKLM \
    "${REG_KEY_INST_INFO}"
  DeleteRegKey HKLM \
    "${REG_KEY_UNINST_INFO}"
SectionEnd
