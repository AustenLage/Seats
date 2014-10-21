#include <Inet.au3>
#include <MsgBoxConstants.au3>

_CheckVersion()

Func _CheckVersion()
	If Ping("google.com") Then
		InetGet("http://goo.gl/D7XrUv", @TempDir & "\SeatsTemp\version.ini")
		$LatestVersion = IniRead(@TempDir & "\SeatsTemp\version.ini", "test", "version", "ERROR")
		MsgBox(0, "", $LatestVersion)
		$ScriptVersion = RegRead("HKEY_CURRENT_USER\Software\Seats", "ScriptVersion")
		If $LatestVersion <> $ScriptVersion Then
			MsgBox(36, "Update Available!", "A new version of seats is available." & @CRLF & _
					"Installed Version: " & $ScriptVersion & @CRLF & _
					"Latest version: " & $LatestVersion & @CRLF & _
					"Would you like to update?")
		Else
			Exit 0
		EndIf
	Else
		MsgBox($MB_ICONERROR, "Error", "There was an issue checking the server for the latest version!")
	EndIf
EndFunc   ;==>_CheckVersion
