#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region
$SeatsMain = GUICreate("Seats - A seating chart generator for Mrs. Potter", 504, 460, 249, 155)
GUISetBkColor(0xC0C0C0)
$Button1 = GUICtrlCreateButton("Options", 419, 0, 41, 17)
$Button2 = GUICtrlCreateButton("About", 462, 0, 41, 17)
$Button3 = GUICtrlCreateButton("Help", 0, 0, 41, 17)
GUICtrlSetCursor (-1, 0)
$Group1 = GUICtrlCreateGroup("", 412, -9, 97, 33)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Group2", -9, -18, 57, 41)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetTip(-1, "Need help?")
$Radio1 = GUICtrlCreateRadio("Numbers", 165, 19, 64, 26)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetCursor (-1, 0)
$Radio2 = GUICtrlCreateRadio("Names", 252, 19, 55, 26)
GUICtrlSetCursor (-1, 0)
$Label1 = GUICtrlCreateLabel("*Would you like to generate a seating chart with:", 120, 0, 233, 17)
GUICtrlSetColor(-1, 0x0000FF)
$Label2 = GUICtrlCreateLabel("Or", 232, 24, 15, 17)
$Label3 = GUICtrlCreateLabel("*Dimensions:", 208, 48, 65, 17)
GUICtrlSetColor(-1, 0x0000FF)
$Label4 = GUICtrlCreateLabel("* = Required Field", 416, 32, 88, 17)
$Input1 = GUICtrlCreateInput("", 200, 72, 25, 21)
GUICtrlSetCursor (-1, 5)
$Input2 = GUICtrlCreateInput("", 248, 72, 25, 21)
GUICtrlSetCursor (-1, 5)
$Label5 = GUICtrlCreateLabel("x", 232, 80, 9, 17)
GUICtrlCreateEdit("", 336, 48, 161, 409)
GUICtrlSetState(-1, $GUI_HIDE)
GUISetState(@SW_SHOW)
#EndRegion

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd
