#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

_GUIMain()

Func _GUIMain()
	#Region ### Source=C:\Users\Austen\Desktop\SeatsMain.kxf
	Global $SeatsMain = GUICreate("Seats - A seating chart generator for Mrs. Potter", 505, 444, 349, 219)
	GUISetBkColor(0xC0C0C0)
	Global $Group1 = GUICtrlCreateGroup("", 409, -9, 98, 33)
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
	Global $Input1 = GUICtrlCreateInput("", 200, 72, 25, 21)
	GUICtrlSetCursor(-1, 5)
	Global $Input2 = GUICtrlCreateInput("", 248, 72, 25, 21)
	GUICtrlSetCursor(-1, 5)
	Global $Label5 = GUICtrlCreateLabel("x", 234, 79, 9, 17)
	GUICtrlCreateEdit("", 334, 73, 161, 384)
	GUICtrlSetData(-1, "")
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $Button4 = GUICtrlCreateButton("Name File", 1, 416, 71, 25)
	Global $Button5 = GUICtrlCreateButton("Seating Chart", 72, 416, 70, 25)
	Global $Label6 = GUICtrlCreateLabel("Load:", 3, 401, 31, 17)
	Global $Label7 = GUICtrlCreateLabel("*Student Names (One per line):", 334, 57, 150, 17)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUISetState(@SW_SHOW)
	#EndRegion ### Source=C:\Users\Austen\Desktop\SeatsMain.kxf

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				$intMessage = MsgBox(BitOR($MB_ICONINFORMATION, 65), "Are you sure?", "Are you sure you would like to exit seats?")
				If $intMessage = 1 Then
					Exit 0
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
		EndSwitch
	WEnd
EndFunc   ;==>_GUIMain

Func _OptionsGUI()
	#Region Source=C:\Users\Austen\Desktop\SeatsOptions.kxf
	Global $SeatsOptions = GUICreate("Seats - Options", 488, 122, 700, 471)
	Global $Checkbox1 = GUICtrlCreateCheckbox("AutoUpdates", 0, 0, 84, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button10 = GUICtrlCreateButton("Reset to Defaults", 397, 0, 89, 28)
	Global $Button11 = GUICtrlCreateButton("Cancel", 272, 88, 73, 33)
	Global $Button12 = GUICtrlCreateButton("Apply", 200, 88, 73, 33)
	Global $Button13 = GUICtrlCreateButton("OK", 128, 88, 73, 33)
	Global $Label10 = GUICtrlCreateLabel("Default Save Directory:", 0, 24, 114, 17)
	Global $Input10 = GUICtrlCreateInput("Input1", 115, 22, 197, 21)
	Global $Button14 = GUICtrlCreateButton("...", 313, 28, 39, 16)
	GUISetState(@SW_SHOW)
	#EndRegion Source=C:\Users\Austen\Desktop\SeatsOptions.kxf

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($SeatsOptions)
				Return
			Case $Button11
				GUIDelete($SeatsOptions)
				Return
			Case $Button12
				_ApplyOptions()
				Return
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
				ShellExecute("http://github.com/vortexoxide/seats")
			Case $Button198798
				GUIDelete($AboutMain)
				ExitLoop
		EndSwitch
	WEnd
	Return
EndFunc   ;==>_AboutGUI

Func _ApplyOptions()
	;;Apply new options
	GUIDelete($SeatsOptions)
	Return
EndFunc   ;==>_ApplyOptions

Func _HandleError($sFunction, $iError, $iExtended)
	;;Error handling and logging, possibly send to google doc automatically?
EndFunc   ;==>_HandleError
