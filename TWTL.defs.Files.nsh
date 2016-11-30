!ifndef TWTL_FILES_NSH
!define TWTL_FILES_NSH

; Edit these lines so each of them is correct filename of executable for output
!define INST_SERVICE_EXEC_NAME "twtlsvc.exe"
!define INST_ENGINE_EXEC_NAME "twtleng.exe"
!define INST_ENGINE_DLL1_NAME "TWTL_Snapshot.dll"
!define INST_ENGINE_DLL2_NAME "TWTL_Database.dll"
!define INST_GUI_EXEC_NAME "twtlgui.exe"
!define INST_GUI_DATA_NAME "twtlgui_Data"
!define INST_UNINST_EXEC_NAME "uninstall.exe"

; Edit these lines so each of them is correct path to executable on input
!define BUILD_SERVICE_EXEC_PATH "Service\TWTLService.exe"
!define BUILD_ENGINE_EXEC_PATH "Engine\TWTL_Main.exe"
!define BUILD_ENGINE_DLL1_PATH "Engine\TWTL_Snapshot.dll"
!define BUILD_ENGINE_DLL2_PATH "Engine\TWTL_Database.dll"
!define BUILD_GUI_EXEC_PATH "GUI\TWTL_GUI.exe"
!define BUILD_GUI_DATA_PATH "GUI\TWTL_GUI_Data\"

; Example: uncomment lines below and comment lines above
; !define BUILD_SERVICE_EXEC_PATH "Service\TWTLService\Release\TWTLService.exe"
; !define BUILD_ENGINE_EXEC_PATH "Engine\Project\Release\TWTL_Main.exe"
; !define BUILD_ENGINE_DLL1_PATH "Engine\Project\Release\TWTL_Snapshot.dll"
; !define BUILD_ENGINE_DLL2_PATH "Engine\Project\Release\TWTL_Database.dll"
; !define BUILD_GUI_EXEC_PATH "GUI\TWTL_UnityGUI\gui.exe"
; !define BUILD_GUI_DATA_PATH "GUI\TWTL_UnityGUI\gui_Data\"

!endif ;TWTL_FILES_NSH
