#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Zelda

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once
#include <File.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Debug.au3>
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\GUI_ActionDetails.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\GUI_Action.au3"
Global $bSendCurWindow = ""
Global $bSendTxtInFile = ""
Global $bSendKeyStroke = ""
Global $bSendRaw = ""
Global $sText2Send = ""
Global $sWindowTitle = ""
Func SendText($bSendCurWindow, $bSendTxtInFile, $bSendKeyStroke, $bSendRaw, $sText2Send, $sWindowTitle)
	
If $bSendCurWindow = True Then 
		Local $sTitle_SendText = WinGetTitle("[ACTIVE]")	
		ConsoleWrite($sTitle_SendText)
		If $bSendTxtInFile = True  Then 
			;$TextToSend = GUICtrlRead($edTextToSend)
			ConsoleWrite("Running with option $bSendCurWindow=True And $bSendTxtInFile = True" & @CRLF)
			$sFilePathh = $sText2Send
			ConsoleWrite("$sFilePath: " & $sFilePathh &  @CRLF)
			SendData($sFilePathh, $sTitle_SendText)
			;GetTextInFile()
		EndIf
		If $bSendKeyStroke = True  Then 
			ConsoleWrite("Running with option $bSendCurWindow=True And $bSendKeyStroke = True" & @CRLF)
			WinActivate($sWindowTitle)
			GetKeyStrockeds($sText2Send)
		EndIf
		If $bSendRaw = True  Then 
			ConsoleWrite("Running with option $bSendCurWindow=True And $bSendRaw = True" & @CRLF)
			WinActivate($sWindowTitle)
			SendRaw($sText2Send)
		EndIf
Else 
		;$sTitle_SendText = GUICtrlRead($h_fNA_tSendK_sProg2Send)
		ConsoleWrite("$sTitle_SendText: " & $sWindowTitle &  @CRLF)
		If $bSendTxtInFile = True  Then 
			ConsoleWrite("Running with option $bSendCurWindow=False And $bSendTxtInFile = True" & @CRLF)
			;$sTextToSend = GUICtrlRead($edTextToSend)
			$sFilePathh = $sText2Send
			;ConsoleWrite("$sFilePath: " & $sFilePathh &  @CRLF)
			SendData($sFilePathh, $sWindowTitle)
			;GetTextInFile()
		EndIf
		If $bSendKeyStroke = True  Then 
			ConsoleWrite("Running with option $bSendCurWindow=False And $bSendKeyStroke = True" & @CRLF)
			WinActivate($sWindowTitle)
			GetKeyStrockeds($sText2Send)
		EndIf
		If $bSendRaw = True  Then 
			ConsoleWrite("Running with option $bSendCurWindow=False And $bSendRaw = True" & @CRLF)
			WinActivate($sWindowTitle)
			SendRaw($sText2Send)
		EndIf
	EndIf
	
EndFunc
;Func Send data 
Func SendData($sFilePath, $sTitlee)
	$sFileOpen = FileOpen($sFilePath, 0)
	If $sFileOpen = -1 Then 
		MsgBox(0, "", "Open file false")
		Exit 
	EndIf 
	$sFileRead = FileRead($sFileOpen)
	FileClose($sFileOpen)
	ClipPut($sFileRead)
	;ConsoleWrite($sFileRead & @CRLF)
	If WinExists($sTitlee) = 0 Then 
		ConsoleWrite("Not exist title" & @CRLF)
		;Run($sTitlee & ".exe")
		WinActivate($sTitlee)
	Else 
		ConsoleWrite("Exist title" & @CRLF)
		WinActivate($sTitlee)
		
	EndIf 
	Send("^v")
EndFunc
;Func get Text in file when $iTextInFile enable
Func GetTextInFile()
	
		Send("^v")
;~ 		Send("{CTRLDOWN}")
;~ 		Send("{CTRLUP}")
;~ 		Send("{SHIFTDOWN}")
;~ 		Send("{SHIFTUP}")
;~ 	
EndFunc
;Func handle $sTextToSend when $sKeyStrocked enable
Func GetKeyStrockeds($sText)
		$StringToSend = ""
	
		$sTextToSend = $sText
		$StringToSend = StringReplace($sTextToSend, "+", "")
		ConsoleWrite($StringToSend)
		$StringToSend = StringReplace($StringToSend, "Alt", "!")
		ConsoleWrite($StringToSend)
		$StringToSend = StringReplace($StringToSend, "Shift", "+")
		ConsoleWrite($StringToSend)
		$StringToSend = StringReplace($StringToSend, "Ctrl", "^")
		ConsoleWrite($StringToSend)
	
		$sTextToSend = $StringToSend
		Send($sTextToSend, 0)
	
	
EndFunc
;Func handle $sTextToSend when $iRaw enable
Func SendRaw($Text)
	$sTextToSend = $Text
	Send($sTextToSend, $SEND_RAW)
EndFunc 
