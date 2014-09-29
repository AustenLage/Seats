#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

_Initialize()
_GUIMain()

Func _GUIMain()
	#Region ### Source=C:\Users\Austen\Desktop\SeatsMain.kxf
	Global $SeatsMain = GUICreate("Seats - A seating chart generator for Mrs. Potter", 498, 443, 348, 219)
	GUISetBkColor(0xC0C0C0)
	Global $Group1 = GUICtrlCreateGroup("", 409, -9, 114, 33)
	Global $Button1 = GUICtrlCreateButton("Options", 415, 0, 42, 17)
	Global $Button2 = GUICtrlCreateButton("About", 459, 0, 41, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $Group2 = GUICtrlCreateGroup("Group2", -11, -18, 57, 41)
	Global $Button3 = GUICtrlCreateButton("Help", -2, 0, 41, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $Radio1 = GUICtrlCreateRadio("Numbers", 163, 19, 64, 26)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetCursor(-1, 0)
	Global $Radio2 = GUICtrlCreateRadio("Names", 250, 19, 55, 26)
	GUICtrlSetCursor(-1, 0)
	Global $Label1 = GUICtrlCreateLabel("*Would you like to generate a seating chart with:", 118, 0, 233, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	Global $Label2 = GUICtrlCreateLabel("or", 230, 24, 15, 17)
	Global $Label3 = GUICtrlCreateLabel("*Dimensions:", 206, 48, 65, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	Global $Label4 = GUICtrlCreateLabel("* = Required Field", 414, 32, 88, 17)
	GUICtrlSetColor(-1, 0xFF0000)
	Global $Input1098098 = GUICtrlCreateInput("kk", 200, 72, 25, 21)
	GUICtrlSetCursor(-1, 5)
	Global $Input87877 = GUICtrlCreateInput("", 248, 72, 25, 21)
	GUICtrlSetCursor(-1, 5)
	Global $Label5 = GUICtrlCreateLabel("x", 234, 79, 9, 17)
	Global $Edit1 = GUICtrlCreateEdit("", 334, 73, 161, 368)
	GUICtrlSetData(-1, "")
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $Button4 = GUICtrlCreateButton("Name File", 1, 416, 71, 25)
	Global $Button5 = GUICtrlCreateButton("Seating Chart", 72, 416, 70, 25)
	Global $Label6 = GUICtrlCreateLabel("Load:", 3, 401, 31, 17)
	Global $Label7 = GUICtrlCreateLabel("*Student :", 334, 57, 150, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $Button6 = GUICtrlCreateButton("Generate Form", 152, 104, 177, 49)
	GUISetState(@SW_SHOW)
	#EndRegion ### Source=C:\Users\Austen\Desktop\SeatsMain.kxf

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				If RegRead("HKEY_CURRENT_USER\Software\Seats", "ExitGUI") <> "true" Then
					GUISetState(@SW_DISABLE, $SeatsMain)
					#Region
					$ExitGUI = GUICreate("Are You Sure?", 316, 254, 346, 262)
					GUICtrlCreateGroup("", 9, 1, 297, 193)
					$Label1908 = GUICtrlCreateLabel("Are you sure you would like to exit Seats?", 66, 88, 200, 17)
					GUICtrlCreateGroup("", -99, -99, 1, 1)
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
			Case $Button1
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
				_SizeChart()
			Case $Radio2
				GUICtrlSetState($Edit1, $GUI_SHOW)
			Case $Radio1
				GUICtrlSetState($Edit1, $GUI_HIDE)
		EndSwitch
	WEnd
EndFunc   ;==>_GUIMain


	Func _FormGUI()
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Users\17079\Desktop\FormGUI.kxf
$FormGUI = GUICreate("Seating Chart", 893, 571, 91, 93, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$MenuItem1 = GUICtrlCreateMenu("&File")
$MenuItem3 = GUICtrlCreateMenuItem("Save Seating Chart##TAB##"&@TAB&"", $MenuItem1)
$MenuItem4 = GUICtrlCreateMenuItem("Save Names File##TAB##"&@TAB&"", $MenuItem1)
$MenuItem2 = GUICtrlCreateMenuItem("Load Seating Chart##TAB##"&@TAB&"", $MenuItem1)
$PageControl1 = GUICtrlCreateTab(0, 0, 892, 551)
$TabSheet1 = GUICtrlCreateTabItem("Chart Sheet")
GUICtrlCreateGroup("Group3", 204, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group4", 300, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group5", 396, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group6", 492, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group7", 588, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group9", 780, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group2", 108, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group8", 684, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group1", 12, 33, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group10", 12, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group13", 300, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group14", 396, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group15", 492, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group16", 588, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group17", 684, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group12", 204, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group18", 780, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group11", 108, 89, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group21", 204, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group22", 300, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group23", 396, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group24", 492, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group25", 588, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group27", 780, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group20", 108, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group26", 684, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group19", 12, 145, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group28", 12, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group30", 204, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group31", 300, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group32", 396, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group33", 492, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group34", 588, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group36", 780, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group29", 108, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group35", 684, 201, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group37", 12, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group39", 204, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group40", 300, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group41", 396, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group42", 492, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group43", 588, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group45", 780, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group38", 108, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group44", 684, 257, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group46", 12, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group48", 204, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group49", 300, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group50", 396, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group51", 492, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group52", 588, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group54", 780, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group47", 108, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group53", 684, 313, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group55", 12, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group57", 204, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group58", 300, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group59", 396, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group60", 492, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group61", 588, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group63", 780, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group56", 108, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group62", 684, 369, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group64", 12, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group66", 204, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group67", 300, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group68", 396, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group69", 492, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group70", 588, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group72", 780, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group65", 108, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group71", 684, 425, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group73", 12, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group75", 204, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group76", 300, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group77", 396, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group78", 492, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group79", 588, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group81", 780, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group74", 108, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Group80", 684, 481, 99, 55, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("Exclude Seats")
$TabSheet3 = GUICtrlCreateTabItem("Problem Students")
$Label9898989 = GUICtrlCreateLabel("NOT DONE", 232, 192, 494, 108)
GUICtrlSetFont(-1, 70, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateTabItem("")
$Button1 = GUICtrlCreateButton("Return to Main Screen", 776, 0, 113, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

	EndFunc   ;==>_FormGUI

Func _OptionsGUI()
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

	If RegRead("HKEY_CURRENT_USER\Software\Seats", "AutoUpdate") = "false" Then
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
	Global $AboutMain = GUICreate("About!", 626, 177, 237, 222)
	Global $Label24 = GUICtrlCreateLabel("All code, ideas, and GUI design by: Austen Lage", 139, 24, 347, 24)
	GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
	Global $Label70 = GUICtrlCreateLabel("Thank you so much for using my program, I really appreciate it! If you have any questions, comments, or concerns", 30, 101, 564, 19, $SS_CENTER)
	GUICtrlSetColor(-1, 0x000000)
	Global $Button68 = GUICtrlCreateButton("http://github.com/VortexOxide", 224, 56, 177, 33)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetTip(-1, "Go to Vort3chs' GitHub")
	Global $Label1098 = GUICtrlCreateLabel("please contact me via issue, or pull request on my GitHub! I am also available at austenlage98@hotmail.com", 30, 115, 564, 19, $SS_CENTER)
	GUICtrlSetColor(-1, 0x000000)
	Global $Button198798 = GUICtrlCreateButton("Close", 262, 151, 100, 25)
	GUICtrlSetTip(-1, "Close about window")
	Global $AboutMain_AccelTable[1][2] = [["{DEL}", $Button1]]
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
	If RegRead("HKEY_CURRENT_USER\Software\Seats", "FirstRun") = "true" Then
		Return
	Else
		MsgBox($MB_ICONINFORMATION, "Welcome!", "Welcome, it looks like it is your first time running seats. If you need help please click the 'help' button in the top left corner.")
		RegWrite("HKEY_CURRENT_USER\Software\Seats", "FirstRun", "REG_SZ", "true")
		MsgBox(0, "", RegRead("HKEY_CURRENT_USER\Software\Seats", "FirstRun"))
	EndIf
EndFunc   ;==>_Initialize
Func _ApplyOptions()
	RegWrite("HKEY_CURRENT_USER\Software\Seats", "BrowseDir", "REG_SZ", GUICtrlRead($Input10))
	RegWrite("HKEY_CURRENT_USER\Software\Seats", "BrowseDir", "REG_SZ", @MyDocumentsDir)
	GUIDelete($SeatsOptions)
	Return
EndFunc   ;==>_ApplyOptions

Func _HandleError($sFunction, $iError, $iExtended)
	;;Error handling and logging, possibly send to google doc automatically?
EndFunc   ;==>_HandleError

Func _SizeChart()
	Local $iHorizontle = GUICtrlRead($Input1098098)
	Switch $iHorizontle
		Case "1"
	EndSwitch
EndFunc   ;==>_SizeChart

Func _HideDesks($iHorizontle, $iVertical)
	;Horizontle Switch
	Switch $iHorizontle
		Case "1"
			




EndFunc   ;==>_HideDesks
