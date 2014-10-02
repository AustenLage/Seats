#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.10.2
	Author:         Austen Lage

	Script Function:
	Generate Seating Chart

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <_Random.au3>

Global $FormGroup[10][10], $FormCount[10][10], $aStudentNumbers[82], $bError

_Initialize()
_GUIMain()

Func _GUIMain()
	ConsoleWrite('@@ (25) :(' & @MIN & ':' & @SEC & ') _GUIMain()' & @CR) ;### Function Trace
	#Region ### START Koda GUI section ### Form=C:\Users\Austen\Desktop\SeatsMain.kxf
	Global $SeatsMain = GUICreate("Seats - A seating chart generator for Mrs. Potter", 504, 443, 348, 219)
	GUISetBkColor(0xF0F0F0)
	Global $Group1 = GUICtrlCreateGroup("", 417, -9, 114, 33)
	Global $Button98776576 = GUICtrlCreateButton("Options", 423, 0, 42, 17)
	Global $Button2 = GUICtrlCreateButton("About", 467, 0, 41, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $Group2 = GUICtrlCreateGroup("Group2", -11, -18, 57, 41)
	Global $Button3 = GUICtrlCreateButton("Help", -2, 0, 41, 17)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $Radio1 = GUICtrlCreateRadio("Numbers", 171, 128, 64, 18)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetCursor(-1, 0)
	Global $Radio2 = GUICtrlCreateRadio("Names", 267, 128, 55, 18)
	GUICtrlSetCursor(-1, 0)
	Global $Label2 = GUICtrlCreateLabel("or", 241, 130, 15, 17)
	Global $Label3 = GUICtrlCreateLabel("*Dimensions:", 211, 151, 65, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	Global $Label4 = GUICtrlCreateLabel("* = Required Field", 414, 32, 88, 17)
	GUICtrlSetColor(-1, 0xFF0000)
	Global $Input1098098 = GUICtrlCreateInput("9", 202, 168, 25, 21)
	GUICtrlSetCursor(-1, 5)
	Global $Input87877 = GUICtrlCreateInput("9", 256, 168, 25, 21)
	GUICtrlSetCursor(-1, 5)
	Global $Label5 = GUICtrlCreateLabel("x", 237, 175, 9, 17)
	Global $Edit1 = GUICtrlCreateEdit("", 342, 73, 161, 368)
	GUICtrlSetData(-1, "")
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $Button4 = GUICtrlCreateButton("Name File", 1, 416, 71, 25)
	Global $Button5 = GUICtrlCreateButton("Seating Chart", 72, 416, 70, 25)
	Global $Label6 = GUICtrlCreateLabel("Load:", 3, 400, 31, 17)
	Global $Label7 = GUICtrlCreateLabel("*Students :", 342, 56, 46, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $Button6 = GUICtrlCreateButton("Generate Form", 155, 192, 177, 49)
	Global $Label8 = GUICtrlCreateLabel("*Generate Chart With:", 195, 107, 113, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	Global $Button176565 = GUICtrlCreateButton("IMPORTANT NAME FILE FORMAT INFO", 54, 0, 353, 17)
	GUICtrlSetBkColor(-1, 0xFF0000)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				If RegRead("HKEY_CURRENT_USER\Software\Seats", "ExitGUI") <> "true" Then
					GUISetState(@SW_DISABLE, $SeatsMain)
					#Region
					$ExitGUI = GUICreate("Are You Sure?", 316, 254, 346, 262)
					GUICtrlCreateGroup("", 9, 1, 297, 193)
					$Label1908 = GUICtrlCreateLabel("Are you sure you would like to exit Seats?", 66, 88, 200, 17)
					$Button12344 = GUICtrlCreateButton("&Yes", 73, 203, 75, 25)
					$Button234234 = GUICtrlCreateButton("&No", 178, 203, 75, 25)
					$Checkbox1998 = GUICtrlCreateCheckbox("Don't ask me again", 0, 232, 113, 17)
					GUISetState(@SW_SHOW)
					#EndRegion

					While 1
						Switch GUIGetMsg()
							Case $GUI_EVENT_CLOSE
								ExitLoop
							Case $Button12344
								Exit 0
							Case $Button234234
								ExitLoop
							Case $Checkbox1998
								If GUICtrlRead($Checkbox1998) = $GUI_CHECKED Then
									RegWrite("HKEY_CURRENT_USER\Software\Seats", "ExitGUI", "REG_SZ", "true")
								Else
									RegWrite("HKEY_CURRENT_USER\Software\Seats", "ExitGUI", "REG_SZ", "false")
								EndIf
						EndSwitch
					WEnd
					GUISetState(@SW_ENABLE, $SeatsMain)
					WinActivate($SeatsMain)
				Else
					Return
				EndIf
			Case $Button98776576
				GUISetState(@SW_DISABLE, $SeatsMain)
				_OptionsGUI()
				GUISetState(@SW_ENABLE, $SeatsMain)
				WinActivate($SeatsMain)
			Case $Button2
				GUISetState(@SW_DISABLE, $SeatsMain)
				_AboutGUI()
				GUISetState(@SW_ENABLE, $SeatsMain)
				WinActivate($SeatsMain)
			Case $Button6
				_FormGUI()
			Case $Button176565
				MsgBox($MB_ICONINFORMATION,"IMPORTANT FORMAT INFO!","In order for your names to be parsed correctly" & @CRLF & _
					"and to prevent multiple names on one seat" & @CRLF & _
					"you must only have one name per line!" & @CRLF & _
					"Example:" & @CRLF & _
					"Austen Lage" & @CRLF & _
					"Mrs. Potter" & @CRLF & _
					"Jacob Mcilhenny" & @CRLF & _
					& @CRLF & _
					"If there are more students than the total capacity of the" & @CRLF & _
					"chart dimensions, an exception will be thrown!"
			Case $Radio2
				GUICtrlSetState($Edit1, $GUI_SHOW)
				GUICtrlSetState($Button176565, $GUI_SHOW)
				GUICtrlSetState($Label7, $GUI_SHOW)
			Case $Radio1
				GUICtrlSetState($Edit1, $GUI_HIDE)
				GUICtrlSetState($Button176565, $GUI_HIDE)
				GUICtrlSetState($Label7, $GUI_HIDE)
		EndSwitch
	WEnd
EndFunc   ;==>_GUIMain


Func _FormGUI()
	ConsoleWrite('@@ (124) :(' & @MIN & ':' & @SEC & ') _FormGUI()' & @CR) ;### Function Trace
	$bError = 0
	$Timer = TimerInit()
	#Region ### START Koda GUI section ### Form=C:\Users\Austen\Desktop\FormGUI.kxf
	Global $FormGUI = GUICreate("Seating Chart", 896, 575, 348, 135, BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX, $WS_THICKFRAME), $WS_EX_WINDOWEDGE)
	Global $MenuItem1 = GUICtrlCreateMenu("&File")
	Global $MenuItem3 = GUICtrlCreateMenuItem("Save Seating Chart" & @TAB & "Shift+Ctrl+Alt+\", $MenuItem1)
	Global $MenuItem4 = GUICtrlCreateMenuItem("Save Names File", $MenuItem1)
	Global $MenuItem2 = GUICtrlCreateMenuItem("Load Seating Chart", $MenuItem1)
	Global $MenuItem6 = GUICtrlCreateMenuItem("Regenerate Chart", $MenuItem1)
	Global $MenuItem5 = GUICtrlCreateMenuItem("Return To Menu Screen", $MenuItem1)
	Global $PageControl1 = GUICtrlCreateTab(10, 0, 875, 551)
	GUICtrlSetResizing(-1, $GUI_DOCKAUTO + $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Global $TabSheet1 = GUICtrlCreateTabItem("Chart Sheet")
	$FormGroup[1][3] = GUICtrlCreateGroup("Group1,3", 206, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][4] = GUICtrlCreateGroup("Group1,4", 302, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][5] = GUICtrlCreateGroup("Group1,5", 398, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][6] = GUICtrlCreateGroup("Group1,6", 494, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][7] = GUICtrlCreateGroup("Group1,7", 590, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][9] = GUICtrlCreateGroup("Group1,9", 782, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][2] = GUICtrlCreateGroup("Group1,2", 110, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][8] = GUICtrlCreateGroup("Group1,8", 686, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[1][1] = GUICtrlCreateGroup("Group1,1", 14, 33, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][1] = GUICtrlCreateGroup("Group2,1", 14, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][4] = GUICtrlCreateGroup("Group2,4", 302, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][5] = GUICtrlCreateGroup("Group2,5", 398, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][6] = GUICtrlCreateGroup("Group2,6", 494, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][7] = GUICtrlCreateGroup("Group2,7", 590, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][8] = GUICtrlCreateGroup("Group2,8", 686, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][3] = GUICtrlCreateGroup("Group2,3", 206, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][9] = GUICtrlCreateGroup("Group2,9", 782, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[2][2] = GUICtrlCreateGroup("Group2,2", 110, 89, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][3] = GUICtrlCreateGroup("Group3,3", 206, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][4] = GUICtrlCreateGroup("Group3,4", 302, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][5] = GUICtrlCreateGroup("Group3,5", 398, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][6] = GUICtrlCreateGroup("Group3,6", 494, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][7] = GUICtrlCreateGroup("Group3,7", 590, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][9] = GUICtrlCreateGroup("Group3,9", 782, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][2] = GUICtrlCreateGroup("Group3,2", 110, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][8] = GUICtrlCreateGroup("Group3,8", 686, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[3][1] = GUICtrlCreateGroup("Group3,1", 14, 145, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][1] = GUICtrlCreateGroup("Group4,1", 14, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][3] = GUICtrlCreateGroup("Group4,3", 206, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][4] = GUICtrlCreateGroup("Group4,4", 302, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][5] = GUICtrlCreateGroup("Group4,5", 398, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][6] = GUICtrlCreateGroup("Group4,6", 494, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][7] = GUICtrlCreateGroup("Group4,7", 590, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][9] = GUICtrlCreateGroup("Group4,9", 782, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][2] = GUICtrlCreateGroup("Group4,2", 110, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[4][8] = GUICtrlCreateGroup("Group4,8", 686, 201, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][1] = GUICtrlCreateGroup("Group5,1", 14, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][3] = GUICtrlCreateGroup("Group5,3", 206, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][4] = GUICtrlCreateGroup("Group5,4", 302, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][5] = GUICtrlCreateGroup("Group5,5", 398, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][6] = GUICtrlCreateGroup("Group5,6", 494, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][7] = GUICtrlCreateGroup("Group5,7", 590, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][9] = GUICtrlCreateGroup("Group5,9", 782, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][2] = GUICtrlCreateGroup("Group5,2", 110, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[5][8] = GUICtrlCreateGroup("Group5,8", 686, 257, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][1] = GUICtrlCreateGroup("Group6,1", 14, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][3] = GUICtrlCreateGroup("Group6,3", 206, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][4] = GUICtrlCreateGroup("Group6,4", 302, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][5] = GUICtrlCreateGroup("Group6,5", 398, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][6] = GUICtrlCreateGroup("Group6,6", 494, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][7] = GUICtrlCreateGroup("Group6,7", 590, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][9] = GUICtrlCreateGroup("Group6,9", 782, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][2] = GUICtrlCreateGroup("Group6,2", 110, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[6][8] = GUICtrlCreateGroup("Group6,8", 686, 313, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][1] = GUICtrlCreateGroup("Group7,1", 14, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][3] = GUICtrlCreateGroup("Group7,3", 206, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][4] = GUICtrlCreateGroup("Group7,4", 302, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][5] = GUICtrlCreateGroup("Group7,5", 398, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][6] = GUICtrlCreateGroup("Group7,6", 494, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][7] = GUICtrlCreateGroup("Group7,7", 590, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][9] = GUICtrlCreateGroup("Group7,9", 782, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][2] = GUICtrlCreateGroup("Group7,2", 110, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[7][8] = GUICtrlCreateGroup("Group7,8", 686, 369, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][1] = GUICtrlCreateGroup("Group8,1", 14, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][3] = GUICtrlCreateGroup("Group8,3", 206, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][4] = GUICtrlCreateGroup("Group8,4", 302, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][5] = GUICtrlCreateGroup("Group8,5", 398, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][6] = GUICtrlCreateGroup("Group8,6", 494, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][7] = GUICtrlCreateGroup("Group8,7", 590, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][9] = GUICtrlCreateGroup("Group8,9", 782, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][2] = GUICtrlCreateGroup("Group8,2", 110, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[8][8] = GUICtrlCreateGroup("Group8,8", 686, 425, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][1] = GUICtrlCreateGroup("Group9,1", 14, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][3] = GUICtrlCreateGroup("Group9,3", 206, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][4] = GUICtrlCreateGroup("Group9,4", 302, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][5] = GUICtrlCreateGroup("Group9,5", 398, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][6] = GUICtrlCreateGroup("Group9,6", 494, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][7] = GUICtrlCreateGroup("Group9,7", 590, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][9] = GUICtrlCreateGroup("Group9,9", 782, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][2] = GUICtrlCreateGroup("Group9,2", 110, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$FormGroup[9][8] = GUICtrlCreateGroup("Group9,8", 686, 481, 97, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER), $WS_EX_TRANSPARENT)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	Global $TabSheet2 = GUICtrlCreateTabItem("Exclude Seats")
	Global $Label1 = GUICtrlCreateLabel("NOT DONE", 220, 194, 494, 108)
	GUICtrlSetFont(-1, 70, 400, 0, "Arial")
	GUICtrlSetColor(-1, 0xFF0000)
	Global $TabSheet3 = GUICtrlCreateTabItem("Problem Students")
	Global $Label9898989 = GUICtrlCreateLabel("NOT DONE", 238, 189, 494, 108)
	GUICtrlSetFont(-1, 70, 400, 0, "Arial")
	GUICtrlSetColor(-1, 0xFF0000)
	GUICtrlCreateTabItem("")
	Global $Button129843769826354 = GUICtrlCreateButton("Return to Main Screen", 770, 0, 113, 17)
	Global $FormGUI_AccelTable[1][2] = [["^!+\", $MenuItem3]]
	GUISetAccelerators($FormGUI_AccelTable)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	Global $Horizontle = GUICtrlRead($Input87877)
	Global $Vertical = GUICtrlRead($Input1098098)

	_HideDesksV($Vertical, $Horizontle)

	;_ArrayDisplay($FormCount) - Debug

	_FillChart("numbers")

	ConsoleWrite("Time taken to generate form" & Int(TimerDiff($Timer)) & @CRLF) ;Write form creation speed to console/STDout Stream

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				$iMessage = MsgBox(4, "Are You Sure?", "Are you sure you would like to exit this page?" & @CRLF & _
						"Unsaved seating charts will be lost!")
				If $iMessage = 6 Then
					GUIDelete($FormGUI)
					ExitLoop
				EndIf
			Case $Button129843769826354
				$iMessage = MsgBox(4, "Are You Sure?", "Are you sure you would like to exit this page?" & @CRLF & _
						"Unsaved seating charts will be lost!")
				If $iMessage = 6 Then
					GUIDelete($FormGUI)
					ExitLoop
				EndIf
			Case $MenuItem5
				$iMessage = MsgBox(4, "Are You Sure?", "Are you sure you would like to exit this page?" & @CRLF & _
						"Unsaved seating charts will be lost!")
				If $iMessage = 6 Then
					GUIDelete($FormGUI)
					ExitLoop
				EndIf
		EndSwitch

		If $bError = 1 Then
			GUIDelete($FormGUI)
			ExitLoop
		EndIf
	WEnd

EndFunc   ;==>_FormGUI

Func _OptionsGUI()
	ConsoleWrite('@@ (360) :(' & @MIN & ':' & @SEC & ') _OptionsGUI()' & @CR) ;### Function Trace
	#Region Form=C:\Users\Austen\Desktop\SeatsOptions.kxf
	Global $SeatsOptions = GUICreate("Seats - Options", 488, 122, 700, 471)
	Global $Checkbox112 = GUICtrlCreateCheckbox("AutoUpdates", 0, 0, 84, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button10 = GUICtrlCreateButton("Reset to Defaults", 397, 0, 89, 28)
	Global $Button11 = GUICtrlCreateButton("Cancel", 272, 88, 73, 33)
	Global $Button12 = GUICtrlCreateButton("Apply", 200, 88, 73, 33)
	Global $Button13 = GUICtrlCreateButton("OK", 128, 88, 73, 33)
	Global $Label10 = GUICtrlCreateLabel("Default Save Directory:", 0, 24, 114, 17)
	Global $Input10 = GUICtrlCreateInput("Input1", 115, 22, 197, 21)
	Global $Button14 = GUICtrlCreateButton("...", 313, 28, 39, 16)
	GUISetState(@SW_SHOW)
	#EndRegion Form=C:\Users\Austen\Desktop\SeatsOptions.kxf

	GUICtrlSetData($Input10, RegRead("HKEY_CURRENT_USER\Software\Seats", "BrowseDir"))

	If RegRead("HKEY_CURRENT_USER\Software\Seats", "AutoUpdate") <> 1 Then
		GUICtrlSetState($Checkbox112, $GUI_UNCHECKED)
	EndIf

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($SeatsOptions)
				ExitLoop
			Case $Button11
				GUIDelete($SeatsOptions)
				ExitLoop
			Case $Button12
				GUICtrlSetState($Input10, $GUI_DISABLE)
				GUICtrlSetState($Checkbox112, $GUI_DISABLE)
				_ApplyOptions()
				ExitLoop
		EndSwitch
	WEnd
	Return
EndFunc   ;==>_OptionsGUI

Func _AboutGUI()
	ConsoleWrite('@@ (400) :(' & @MIN & ':' & @SEC & ') _AboutGUI()' & @CR) ;### Function Trace
	Global $AboutMain = GUICreate("About!", 626, 177, 237, 222)
	Global $Label24 = GUICtrlCreateLabel("All code, ideas, and GUI design by: Austen Lage", 139, 24, 347, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	Global $Label70 = GUICtrlCreateLabel("Thank you so much for using my program, I really appreciate it! If you have any questions, comments, or concerns", 30, 101, 564, 19, $SS_CENTER)
	GUICtrlSetColor(-1, 0x000000)
	Global $Button68 = GUICtrlCreateButton("http://github.com/VortexOxide", 224, 56, 177, 33)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetTip(-1, "Go to Vortex's GitHub")
	Global $Label1098 = GUICtrlCreateLabel("please contact me via issue, or pull request on my GitHub! I am also available at austenlage98@hotmail.com", 30, 115, 564, 19, $SS_CENTER)
	GUICtrlSetColor(-1, 0x000000)
	Global $Button198798 = GUICtrlCreateButton("Close", 262, 151, 100, 25)
	GUICtrlSetTip(-1, "Close about window")
	Global $AboutMain_AccelTable[1][2] = [["{DEL}", $Button68]]
	GUISetAccelerators($AboutMain_AccelTable)
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($AboutMain)
				ExitLoop
			Case $Button68
				ShellExecute("http://github.com/vortexoxide/")
			Case $Button198798
				GUIDelete($AboutMain)
				ExitLoop
		EndSwitch
	WEnd
	Return
EndFunc   ;==>_AboutGUI

Func _Initialize()
	ConsoleWrite('@@ (433) :(' & @MIN & ':' & @SEC & ') _Initialize()' & @CR) ;### Function Trace
	If RegRead("HKEY_CURRENT_USER\Software\Seats", "FirstRun") = "true" Then
		Return
	Else
		MsgBox($MB_ICONINFORMATION, "Welcome!", "Welcome, it looks like it is your first time running seats. If you need help please click the 'help' button in the top left corner.")
		RegWrite("HKEY_CURRENT_USER\Software\Seats", "FirstRun", "REG_SZ", "true")
	EndIf
EndFunc   ;==>_Initialize
Func _ApplyOptions()
	ConsoleWrite('@@ (443) :(' & @MIN & ':' & @SEC & ') _ApplyOptions()' & @CR) ;### Function Trace
	If GUICtrlRead($Checkbox112) = $GUI_CHECKED Then
		$sResult = 1
	Else
		$sResult = 0
	EndIf
	RegWrite("HKEY_CURRENT_USER\Software\Seats", "BrowseDir", "REG_SZ", GUICtrlRead($Input10))
	RegWrite("HKEY_CURRENT_USER\Software\Seats", "AutoUpdate", "REG_SZ", $sResult)
	_DebugMsgBox(GUICtrlRead($Checkbox112))
	GUIDelete($SeatsOptions)
	Return
EndFunc   ;==>_ApplyOptions

Func _HandleError($sFunction, $sError)
	ConsoleWrite('@@ (457) :(' & @MIN & ':' & @SEC & ') _HandleError()' & @CR) ;### Function Trace
	MsgBox($MB_ICONERROR, "SWEARING!", "The Gerbils didn't like that! :(" & @CRLF & @CRLF & _
			"Function: " & $sFunction & @CRLF & @CRLF & _
			"Description: " & $sError)
	;;Error handling and logging, possibly send to google doc automatically?
EndFunc   ;==>_HandleError

Func _SizeChart()
	ConsoleWrite('@@ (465) :(' & @MIN & ':' & @SEC & ') _SizeChart()' & @CR) ;### Function Trace
	Local $iHorizontle = GUICtrlRead($Input1098098)
	Switch $iHorizontle
		Case "1"
	EndSwitch
EndFunc   ;==>_SizeChart

Func _HideDesksV($iVertical, $iHorizontle) ;Hides desks vertically and passes $iHorizontal to the horizontal hiding function
	ConsoleWrite('@@ (473) :(' & @MIN & ':' & @SEC & ') _HideDesksV()' & @CR) ;### Function Trace
	;Horizontle Switch
	Switch $iVertical
		Case "1"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[2][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[3][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[4][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[6][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[7][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[8][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "2"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[2][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[3][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[6][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[7][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[8][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "3"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[2][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[3][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[7][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[8][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "4"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[2][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[7][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[8][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "5"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[2][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[8][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "6"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[8][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "7"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[1][$i], $GUI_HIDE)
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
			Return
		Case "8"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[9][$i], $GUI_HIDE)
				_HideDesksH($iHorizontle)
				_DeskGetState($i)
			Next
		Case "9"
			_HideDesksH($iHorizontle)
			For $i = 1 To 9
				_DeskGetState($i)
			Next
			Return
		Case Else
			$bError = 1
			_HandleError("_SizeChartV", "The maximum chart size is 9x9!")
			Return
	EndSwitch
EndFunc   ;==>_HideDesksV

Func _HideDesksH($iHorizontal) ;Hides desks horizontally
	ConsoleWrite('@@ (573) :(' & @MIN & ':' & @SEC & ') _HideDesksH()' & @CR) ;### Function Trace
	Switch $iHorizontal
		Case "1"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][2], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][3], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][4], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][6], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][7], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][8], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "2"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][2], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][3], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][6], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][7], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][8], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "3"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][2], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][3], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][7], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][8], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "4"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][2], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][7], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][8], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "5"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][2], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][8], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "6"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][8], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "7"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
				GUICtrlSetState($FormGroup[$i][9], $GUI_HIDE)
			Next
		Case "8"
			For $i = 1 To 9
				GUICtrlSetState($FormGroup[$i][1], $GUI_HIDE)
			Next
		Case "9"
			Return
		Case Else
			$bError = 1
			_HandleError("_SizeChartH", "The maximum chart size is 9x9!")
			Return
	EndSwitch
EndFunc   ;==>_HideDesksH

Func _DeskGetState($i) ;Returns a coordinate array containing the state of each group control, so I can determine which seats to actually give a number or name to.
	ConsoleWrite('@@ (645) :(' & @MIN & ':' & @SEC & ') _DeskGetState()' & @CR) ;### Function Trace
	$FormCount[1][$i] = GUICtrlGetState($FormGroup[1][$i])
	$FormCount[2][$i] = GUICtrlGetState($FormGroup[2][$i])
	$FormCount[3][$i] = GUICtrlGetState($FormGroup[3][$i])
	$FormCount[4][$i] = GUICtrlGetState($FormGroup[4][$i])
	$FormCount[5][$i] = GUICtrlGetState($FormGroup[5][$i])
	$FormCount[6][$i] = GUICtrlGetState($FormGroup[6][$i])
	$FormCount[7][$i] = GUICtrlGetState($FormGroup[7][$i])
	$FormCount[8][$i] = GUICtrlGetState($FormGroup[8][$i])
	$FormCount[9][$i] = GUICtrlGetState($FormGroup[9][$i])
EndFunc   ;==>_DeskGetState

Func _CountSeats() ;Gets total number of open seats on seating chart
	ConsoleWrite('@@ (658) :(' & @MIN & ':' & @SEC & ') _CountSeats()' & @CR) ;### Function Trace
	Local $iOpenSeats

	For $i = 1 To 9
		If $FormCount[1][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[2][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[3][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[4][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[5][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[6][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[7][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[8][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	For $i = 1 To 9
		If $FormCount[9][$i] = 80 Then
			$iOpenSeats = $iOpenSeats + 1
		EndIf
	Next
	Return $iOpenSeats
EndFunc   ;==>_CountSeats

Func _FillChart($sOption) ;$sOption ("Names" or "Numbers")
	ConsoleWrite('@@ (710) :(' & @MIN & ':' & @SEC & ') _FillChart()' & @CR) ;### Function Trace
	If $sOption = "numbers" Then
		$iSeats = _CountSeats()
		$aStudentNumbers = _RandomUnique($iSeats, 1, $iSeats, 1)
		Local $SetCount = 1
		For $i = 1 To 9
			If $FormCount[1][$i] = "80" Then
				GUICtrlSetData($FormGroup[1][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[2][$i] = "80" Then
				GUICtrlSetData($FormGroup[2][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[3][$i] = "80" Then
				GUICtrlSetData($FormGroup[3][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[4][$i] = "80" Then
				GUICtrlSetData($FormGroup[4][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[5][$i] = "80" Then
				GUICtrlSetData($FormGroup[5][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[6][$i] = "80" Then
				GUICtrlSetData($FormGroup[6][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[7][$i] = "80" Then
				GUICtrlSetData($FormGroup[7][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[8][$i] = "80" Then
				GUICtrlSetData($FormGroup[8][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
			If $FormCount[9][$i] = "80" Then
				GUICtrlSetData($FormGroup[9][$i], $aStudentNumbers[$SetCount])
				$SetCount = $SetCount + 1
			EndIf
		Next
		$SetCount = 1
	Else
		$iSeats = _CountSeats()
		$aStudentNumbers = _RandomUnique($iSeats, 1, $iSeats, 1)
		Local $SetCount = 1
		
	
EndFunc   ;==>_FillChart

Func _DebugMsgBox($sText)
	ConsoleWrite('@@ (758) :(' & @MIN & ':' & @SEC & ') _DebugMsgBox()' & @CR) ;### Function Trace
	MsgBox(0, "Debug", $sText)
EndFunc   ;==>_DebugMsgBox

Func _CountStudents()
 	FileWrite(@TempDir & "\SeatsTemp\TempStudents.seats", GUICtrlRead($Edit1))
 	$iStudents = _FileCountLines(@TempDir & "\SeatsTemp\TempStudents.seats)
 	If @Error <> 0 Then
 		_HandleError(_CountStudents,"The temorary student file could not be accessed, or created! error #" & @error)
 	EndIf
 	
EndFunc

Func _RegenerateChart()
	;;Call functions to regenerate chart without re-opening FormGUI
EndFunc
