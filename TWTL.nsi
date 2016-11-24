; TWTL Installer NSIS Script

; inclusion and definitions
!include "MUI2.nsh"

!define ORGNAME "NOTRESPONDING"
!define APPNAME "TWTL"
!define VERSION_MAJOR 1
!define VERSION_MINOR 0
Unicode True

; Edit these lines so each of them is correct filename of executable for output
!define INST_SERVICE_EXEC_NAME "twtlsvc.exe"
!define INST_ENGINE_EXEC_NAME "twtleng.exe"
!define INST_GUI_EXEC_NAME "twtlgui.exe"
!define INST_UNINST_EXEC_NAME "uninstall.exe"

; Edit these lines so each of them is correct path to executable on input
!define BUILD_SERVICE_EXEC_PATH "Service\?"
!define BUILD_ENGINE_EXEC_PATH "Engine\?"
!define BUILD_GUI_EXEC_PATH "GUI\?"

!define REG_KEY_INST_INFO \
  "Software\${ORGNAME}\${APPNAME}"
!define REG_KEY_UNINST_INFO \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"

; Beginning of installer description
Name "${APPNAME}"
OutFile "TWTLInstaller.exe"

InstallDir "$ProgramFiles\${ORGNAME}\${APPNAME}"
ShowInstDetails Show
XPStyle On
RequestExecutionLevel Admin

!define MUI_ABORTWARNING

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

Section
  ; File installation
  SetOutPath $InstDir
  CreateDirectory $InstDir
  File License.txt
  File /oname=${INST_SERVICE_EXEC_NAME} "${BUILD_SERVICE_EXEC_PATH}"
  File /oname=${INST_ENGINE_EXEC_NAME} "${BUILD_ENGINE_EXEC_PATH}"
  File /oname=${INST_GUI_EXEC_NAME} "${BUILD_GUI_EXEC_PATH}"
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
  ; Service installation and startup
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Install'
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Start'
  ; Uninstaller generation and registry uninstallation information
  WriteUninstaller "$InstDir\${INST_UNINST_EXEC_NAME}"
  WriteRegStr HKLM \
    "${REG_KEY_UNINST_INFO}" \
    "DisplayName" "${APPNAME}"
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

Section "Uninstall"
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Stop'
  Exec '"$InstDir\${INST_SERVICE_EXEC_NAME}" Uninstall'
  Delete $InstDir\License.txt
  Delete "$InstDir\${INST_SERVICE_EXEC_NAME}"
  Delete "$InstDir\${INST_ENGINE_EXEC_NAME}"
  Delete "$InstDir\${INST_GUI_EXEC_NAME}"
  Delete "$InstDir\${INST_UNINST_EXEC_NAME}"
  RmDir $InstDir
  DeleteRegKey HKLM \
    "${REG_KEY_INST_INFO}"
  DeleteRegKey HKLM \
    "${REG_KEY_UNINST_INFO}"
SectionEnd
