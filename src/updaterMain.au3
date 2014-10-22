#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.10.2
	Author:         Austen Lage

	Script Function:
	Auto updater for Seats

#ce ----------------------------------------------------------------------------

#include <Array.au3>
#include <Inet.au3>
#include <String.au3>
#include <MsgBoxConstants.au3>

#AutoIt3Wrapper_If_Run
	#AutoIt3Wrapper_Run_AU3Check=Y
	#AutoIt3Wrapper_Run_Tidy=N
#Autoit3Wrapper_If_Compile
	#AutoIt3Wrapper_OutFile="SeatsUpdater.exe"
	#AutoIt3Wrapper_Run_AU3Stripper=Y
	#AutoIt3Wrapper_Run_AU3Check=Y
	#AutoIt3Wrapper_Run_Tidy=Y
	#AutoIt3Wrapper_Compression=4
	#AutoIt3Wrapper_Res_Description="Seats - Updater"
#AutoIt3wrapper_EndIf

_DoUpdate()

Func _DoUpdate()
	If Ping("google.com") Then
		DirCreate(@MyDocumentsDir & "\SeatsTemp")
		$dData = InetRead("http://goo.gl/D7XrUv")
		$sData = BinaryToString($dData)
		$aData = _StringBetween($sData, "[", "]")
		InetClose($dData)
		$InstallDir = RegRead("HKEY_CURRENT_USER\Software\Seats", "InstallDir")
		$LatestVersion = $aData[0]
		$ScriptVersion = RegRead("HKEY_CURRENT_USER\Software\Seats", "ScriptVersion")
		$DownloadURL = $aData[1]
		If $LatestVersion <> $ScriptVersion Then
			$iResponse = MsgBox(36, "Update Available!", "A new version of Seats is available!" & @CRLF & _
					"Installed Version: " & $ScriptVersion & @CRLF & _
					"Latest version: " & $LatestVersion & @CRLF & _
					"Would you like to update?")
			If $iResponse = 6 Then
				InetGet($DownloadURL, @TempDir & "\SeatsTemp\Seats.exe")
				If @error Then
					MsgBox($MB_ICONERROR, "Error", "There was an issue downloading the update from the server!")
					Exit 0
				EndIf
				ProcessClose("Seats.exe")
				Sleep(100)
				FileDelete($InstallDir & "\Seats.exe")
				Sleep(100)
				FileMove(@TempDir & "\SeatsTemp\Seats.exe", $InstallDir)
			Else
				MsgBox($MB_ICONINFORMATION, "Tip", "You can turn off automatic updates by clicking the options button in Seats!")
				Exit 0
			EndIf
		Else
			Exit 0
		EndIf
	Else
		MsgBox($MB_ICONERROR, "Error", "There was an issue checking the server for the latest version!")
	EndIf
EndFunc   ;==>_DoUpdate
