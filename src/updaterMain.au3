#include <Inet.au3>
#include <MsgBoxConstants.au3>

_CheckVersion()

Func _CheckVersion()
	If Ping("24356drsgeragerg.com") Then
		InetGet("GOOGLEDOCSINI", @TempDir & "\Seats\Version.ini")
		$LatestVersion = IniRead(@TempDir & "\Seats\Version.ini", "main", "ScriptVersion", "default")
		$ScriptVersion = RegRead("HKEY_CURRENT_USER\Software\Seats", "ScriptVersion")
		If $LatestVersion <> $ScriptVersion Then
			MsgBox($MB_ICONINFORMATION, "Update Available!", "A new version of seats is available." & @CRLF & _
					"Installed Version: " & $ScriptVersion & @CRLF & _
					"Latest version: " & $LatestVersion & @CRLF & _
					"Would you like to update?")
		Else
			Return
		EndIf
	Else
		MsgBox($MB_ICONERROR, "Error", "There was an issue checking the server for the latest version!")
	EndIf
EndFunc   ;==>_CheckVersion
