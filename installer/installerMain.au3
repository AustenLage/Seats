#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Zip.au3>

#AutoIt3Wrapper_If_Run
	#AutoIt3Wrapper_Run_AU3Check=Y
	#AutoIt3Wrapper_Run_Tidy=N
#Autoit3Wrapper_If_Compile
	#AutoIt3Wrapper_OutFile="SeatsInstaller.exe"
	#AutoIt3Wrapper_Run_AU3Stripper=Y
	#AutoIt3Wrapper_Run_AU3Check=Y
	#AutoIt3Wrapper_Run_Tidy=Y
	#AutoIt3Wrapper_Compression=4
	#AutoIt3Wrapper_Res_Description="Seats Installer"
#AutoIt3wrapper_EndIf

Global $ScriptVersion = "b1.0"

#Region ### START Koda GUI section ### Form=
	Global $InstallerMain = GUICreate("Seats Installer", 228, 243, 234, 277)
	GUISetBkColor(0xFFFFFF)
	Global $Label1 = GUICtrlCreateLabel("Seats installer version v1.0", 48, 24, 130, 17)
	Global $Label2 = GUICtrlCreateLabel("Click install to install seats b1.0", 40, 48, 149, 17)
	Global $Button1 = GUICtrlCreateButton("Install!", 8, 72, 209, 33)
	GUICtrlSetBkColor(-1, 0x00FF00)
	Global $Label3 = GUICtrlCreateLabel("Idle", 104, 0, 35, 17)
	GUICtrlSetColor(-1, 0xFF0000)
	Global $Label4 = GUICtrlCreateLabel("When Complete:", 72, 112, 83, 17)
	Global $Checkbox1 = GUICtrlCreateCheckbox("View release notes", 32, 128, 169, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox2 = GUICtrlCreateCheckbox("Launch", 32, 144, 169, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Label5 = GUICtrlCreateLabel("ONLY CHANGE IF ABSOLUTELY NEEDED:", 8, 168, 217, 17)
	If IsAdmin() Then
		Global $Input1 = GUICtrlCreateInput(@ProgramFilesDir & "\Seats", 52, 191, 169, 21)
	Else
		Global $Input1 = GUICtrlCreateInput(@MyDocumentsDir & "\Seats", 52, 191, 169, 21)
	EndIf
	Global $Label6 = GUICtrlCreateLabel("Install Dir:", 1, 194, 50, 17)
	Global $Button2 = GUICtrlCreateButton("Desktop", 88, 216, 62, 17)
	Global $Button3 = GUICtrlCreateButton("Documents", 151, 216, 62, 17)
	Global $Label7 = GUICtrlCreateLabel("Install Dir Presets:", 0, 216, 88, 17)
	GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			_Install(GUICtrlRead($Input1))
		Case $Button2
			GUICtrlSetData($Input1, @DesktopDir & "\Seats")
		Case $Button3
			GUICtrlSetData($Input1, @MyDocumentsDir & "\Seats")
	EndSwitch
WEnd

Func _Install($sInstallDir)
	GUICtrlSetData($Label3, "Installing...")
	GUICtrlSetColor($Label4, 0x00FF00)
	DirCreate(@TempDir & "\SeatsTemp")
	DirCreate($sInstallDir)
	FileInstall("C:\Users\Austen\Desktop\SeatsCompile\Compile.zip", @TempDir & "\SeatsTemp\SeatsInstall.zip")
	_Zip_UnzipAll(@TempDir & "\SeatsTemp\SeatsInstall.zip", $sInstallDir)
	DirRemove(@TempDir & "\SeatsTemp")
	RegWrite("HKEY_CURRENT_USER\Software\Seats", "ScriptVersion", "REG_SZ", $ScriptVersion)
	RegWrite("HKEY_CURRENT_USER\Software\Seats", "InstallDir", "REG_SZ", $sInstallDir)
	FileCreateShortcut($sInstallDir & "\Compile\Seats.exe", @DesktopDir & "\Seats.lnk")
	GUIDelete($InstallerMain)
	If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
		MsgBox(0, "Release Notes", FileRead($sInstallDir & "\Compile\releasenotes.txt"))
	EndIf
	If GUICtrlRead($Checkbox2) = $GUI_CHECKED Then
		Run($sInstallDir & "\Compile\Seats.exe")
	EndIf
	Exit 0
EndFunc   ;==>_Install
