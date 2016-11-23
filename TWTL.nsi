; TWTL Installer NSIS Script
!include "MUI2.nsh"

!define ORGNAME "Notresponding"
!define APPNAME "TWTL"
!define VERSION_MAJOR 1
!define VERSION_MINOR 0
Unicode True

; Edit these lines so each of them is correct filename of executable for output
!define INST_SERVICE_EXEC_NAME "twtlsvc.exe"
!define INST_ENGINE_EXEC_NAME "twtleng.exe"
!define INST_GUI_EXEC_NAME "twtlgui.exe"

; Edit these lines so each of them is correct path to executable on input
!define BUILD_SERVICE_EXEC_PATH "Service\?"
!define BUILD_ENGINE_EXEC_PATH "Engine\?"
!define BUILD_GUI_EXEC_PATH "GUI\?"

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
  File /oname="${INST_ENGINE_EXEC_PATH}" "${BUILD_ENGINE_EXEC_PATH}"
  File /oname="${INST_GUI_EXEC_PATH}"  "${BUILD_GUI_EXEC_PATH}"
  ; Uninstaller generation and registry uninstallation information
  WriteUninstaller $InstDir\uninstall.exe
  WriteRegStr HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" \
    "DisplayName" "${APPNAME}"
  WriteRegStr HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" \
    "Publisher" "${ORGNAME}"
  WriteRegStr HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" \
    "UninstallString" "$\"$InstDir\uninstall.exe$\""
  WriteRegDWORD HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" \
    "VersionMajor" ${VERSION_MAJOR}
  WriteRegDWORD HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" \
    "VersionMinor" ${VERSION_MINOR}
SectionEnd

Section "Uninstall"
  Delete $InstDir\License.txt
  ;Delete $InstDir\twtlsvc.exe
  Delete $InstDir\twtlngin.exe
  Delete $InstDir\twtlgui.exe
  Delete $InstDir\uninstall.exe
  RmDir $InstDir
  DeleteRegKey HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
SectionEnd
