#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Zelda

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once
#include <WinAPISysWin.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <String.au3>
Global $sFilePath = ""
Global $sTitle_OpenProgram = ""
Global $sProgramText = "" 
Global $bOpenAndWait = "" 
Global $bConsoleCommand = ""  
Global $bShowWindownWhenRunning = "" 
Global $bCapture = "" 
Global $sState = ""
Global $RadioState = ""

Func OpenProgram_($sFilePath, $sTitle_OpenProgram, $sProgramText, $bOpenAndWait, $bConsoleCommand, $bShowWindownWhenRunning, $bCapture, $sState, $RadioState)
	If $sFilePath = "" And $sTitle_OpenProgram = "" Then 
		ConsoleWrite("Please enter Program Path and Program Title" & @CRLF)
	EndIf
	If $RadioState = True Then 
		If $bOpenAndWait = True And $bConsoleCommand = False Then 
			ConsoleWrite("$RadioState-------Running with $bOpenWait=True And $bConsoleCommand=False" & @CRLF)
			ShellExecuteWait($sFilePath)
			WinSetState($sTitle_OpenProgram, $sProgramText, $sState)
		
		ElseIf $bOpenAndWait = False And $bConsoleCommand = True  Then 
			If $bShowWindownWhenRunning = True And $bCapture = True Then 
				ConsoleWrite("$RadioState-------Running with $bOpenAndWait = False And $bConsoleCommand = True And $bShowWindownWhenRunning = True And $bCapture = True" & @CRLF)
				Capture($sFilePath)
			EndIf
			If $bShowWindownWhenRunning = True And $bCapture = False Then 
				ConsoleWrite("$RadioState-------Running with Running with $bOpenAndWait = False And $bConsoleCommand = True And $bShowWindownWhenRunning = True And $bCapture = False" & @CRLF)
				_RunCmd($sFilePath)
			EndIf
		Else 
			ConsoleWrite("$RadioState-------Running with else" & @CRLF)
			OpenProgram($sFilePath, $sState)
		EndIf 
	EndIf
	If $RadioState = False Then 
		If $bOpenAndWait = True And $bConsoleCommand = False Then 
			ConsoleWrite("$RadioState=False-------Running with $bOpenWait=True And $bConsoleCommand=False" & @CRLF)
			ShellExecuteWait($sFilePath)
			WinSetState($sTitle_OpenProgram, $sProgramText, $sState)
		
		ElseIf $bOpenAndWait = False And $bConsoleCommand = True  Then 
			If $bShowWindownWhenRunning = True And $bCapture = True Then 
				ConsoleWrite("$RadioState=False-------Running with $bOpenAndWait = False And $bConsoleCommand = True And $bShowWindownWhenRunning = True And $bCapture = True" & @CRLF)
				Capture($sFilePath)
			EndIf
			If $bShowWindownWhenRunning = True And $bCapture = False Then 
				ConsoleWrite("$RadioState=False-------Running with Running with $bOpenAndWait = False And $bConsoleCommand = True And $bShowWindownWhenRunning = True And $bCapture = False" & @CRLF)
				
				_RunCmd($sFilePath)
			EndIf
		Else 
			ConsoleWrite("$RadioState=False-------Running with else" & @CRLF)
			OpenProgram($sFilePath, $sState)
		EndIf
	EndIf 
EndFunc

Func OpenProgram($Path, $iState)
	Local $Title_Process = GetTitleFromFilePath($Path)
	ConsoleWrite("$Title_process: " &  $Title_Process & @CRLF)
	Local $aWinInTaskBar[1][2]
	$iCount = 0

	$aList = WinList()

	For $i = 1 To $aList[0][0]
		$iExStyle = _WinAPI_GetWindowLong($aList[$i][1], $GWL_EXSTYLE) 

		If NOT BitAND($iExStyle, $WS_EX_TOOLWINDOW) AND _  
		   BitAND(WinGetState($aList[$i][1]), 2 ) Then    
			$iCount += 1
			Redim $aWinInTaskBar[ $iCount + 1][2]
			$aWinInTaskBar[ $iCount][0] = $aList[$i][0]
			$aWinInTaskBar[ $iCount][1] = $aList[$i][1]
		EndIf
	Next
	$aWinInTaskBar[0][0] = UBound($aWinInTaskBar) - 1

	;_ArrayDisplay($aWinInTaskBar)
	$sHandle = ""
	ConsoleWrite("FilePath= " & $Path & @CRLF)
	$id = ProcessExists($Title_Process & ".exe")
	ConsoleWrite("id = " & $id & @CRLF)
	$aRet = WinList("[REGEXPTITLE:(?i)([^Default IME][^MSCTFIME UI][^GDI+ Window].*)]")
		;$aRet = WinList('[REGEXPTITLE:(.+)]')
		
	For $i = 1 To $aRet[0][0]
			
		$idTmp = WinGetProcess($aRet[$i][1])
		If $idTmp = $id Then 
			ConsoleWrite($aRet[$i][0] & '-->' & $aRet[$i][1]& @CRLF)
			$sHandle = $aRet[$i][1]
			ConsoleWrite("$sHandle: " & $sHandle & @CRLF)
			Return $sHandle	
		EndIf
	Next
	For $i = 0 to $aWinInTaskBar[0][0]
		If StringCompare($aWinInTaskBar[$i][1], $sHandle, $STR_CASESENSE) = 0 Then 
			ConsoleWrite("$aWinInTaskBar[$i][1]: " & $aWinInTaskBar[$i][1] & @CRLF)
			WinSetState($sHandle, "", $iState) 
		Else 
			;ConsoleWrite("$sHandle: " & $sHandle & @CRLF)
		EndIf
	Next
	If $sHandle = "" Then 
		Run($Path, "", $iState)
	EndIf
	
EndFunc


Func Capture($sComment)
    Local $testFile = @ScriptDir &'\Capture.txt'
    FileOpen($testFile, 1)
   ; Local $psexec = "start " & $sTitle_OpenProgram & ":"
    FileWriteLine($testFile, _RunCmd($sComment) )
    FileClose($testFile)
EndFunc
Func _RunCmd($sCommand)
    Local $nPid = Run(@Comspec & " /k" & $sCommand & @CRLF, "", @SW_MAXIMIZE), $sRet = ""
    If @Error then Return "ERROR:" & @ERROR
    ProcessWait($nPid)
    While 1
        $sRet &= StdoutRead($nPID)
        If @error Or (Not ProcessExists ($nPid)) Then ExitLoop
    WEnd

    Return $sRet
	
EndFunc
Func GetTitleFromFilePath($File)
	Local $iDelimiter = StringInStr($File, "\", 0, -1)
	If $iDelimiter = 0 Then $iDelimiter = StringInStr($File, "/", 0, -1)
	If $iDelimiter = 0 Then $iDelimiter = StringInStr($File, ":", 0, -1)
	If $iDelimiter = 0 Then
	
	Else
		If StringInStr($File, ".exe") > 0 Then
			$File = StringRight($File, StringLen($File) - $iDelimiter)
			Local $sProgName = StringSplit($File, ".")[1]
			Return $sProgName
		EndIf
	EndIf
	Return 
EndFunc 