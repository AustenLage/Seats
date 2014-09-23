#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Seats Installer", 227, 242, 234, 277)
GUISetBkColor(0x008080)
$Label1 = GUICtrlCreateLabel("Seats installer version v1.0", 48, 24, 130, 17)
$Label2 = GUICtrlCreateLabel("Click install to install seats v1.0", 40, 48, 149, 17)
$Button1 = GUICtrlCreateButton("Install!", 8, 72, 209, 33)
GUICtrlSetBkColor(-1, 0x00FF00)
$Label3 = GUICtrlCreateLabel("Idle", 104, 0, 21, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Label4 = GUICtrlCreateLabel("When Complete:", 72, 112, 83, 17)
$Checkbox1 = GUICtrlCreateCheckbox("View release notes (changelog)", 32, 128, 169, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Checkbox2 = GUICtrlCreateCheckbox("Launch seats (start program)", 32, 144, 169, 17)
$Label5 = GUICtrlCreateLabel("ONLY CHANGE IF ABSOLUTELY NEEDED:", 8, 168, 217, 17)
$Input1 = GUICtrlCreateInput("Input1", 56, 192, 169, 21)
$Label6 = GUICtrlCreateLabel("Install Dir:", 0, 192, 50, 17)
$Button2 = GUICtrlCreateButton("Button2", 88, 216, 41, 17)
$Button3 = GUICtrlCreateButton("Button3", 136, 216, 41, 17)
$Button4 = GUICtrlCreateButton("Button4", 184, 216, 41, 17)
$Label7 = GUICtrlCreateLabel("Install Dir Presets:", 0, 216, 88, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

