;Utility_Script.au3
#include-once
#include <Debug.au3>
;Dim @DEBUG_ERROR 5
Global Enum $DEBUG_ERROR, _
		$DEBUG_INFO, _
		$DEBUG_TRACE

Global $g_iDebugLevel = $DEBUG_TRACE
Global $g_sLogFilePath = "Logs\Dbg_" & @YEAR & "_" & @MON & "_" & @MDAY & ".log"
Global $g_bEnableDebug2File = False


#Region Debug utility
Func _Info($sLog)
	_Debug($sLog, $DEBUG_INFO)
EndFunc   ;==>_Info

Func _Error($sLog)
	_Debug(@TAB & @TAB & "> " & $sLog, $DEBUG_ERROR)
EndFunc   ;==>_Error

Func _Trace($sLog)
	_Debug($sLog, $DEBUG_TRACE)
EndFunc   ;==>_Trace

Func _Debug($sLog, $iDebugLevel = 0)

	If $iDebugLevel <= $g_iDebugLevel Then
		ConsoleWrite($sLog)
		If $g_bEnableDebug2File Then _Debug2File($sLog)
	EndIf

EndFunc   ;==>_Debug


Func _Debug2File($sLog, $sFilePath = $g_sLogFilePath)
	If StringLen($g_sLogFilePath) Then Return
	;@HotKeyPressed
	$hLogFile = FileOpen($g_sLogFilePath, $FO_APPEND + $FO_CREATEPATH)
	If $hLogFile <> -1 Then
		$g_iLogWriteRes = FileWrite($hLogFile, $sLog)
		If $g_iLogWriteRes = 0 Then
			TrayTip("Error", "Can not write to debug file " & $g_sLogFilePath, 0, 0)
		Else
			FileClose($hLogFile)
		EndIf
	Else
		TrayTip("Error", "Can not write to debug file " & $g_sLogFilePath, 0, 0)
	EndIf
EndFunc   ;==>_Debug2File

Func _TrayTip($sTitle, $sText, $iTimeout = 0, $iOption = 0)
	TrayTip($sTitle, $sText, $iTimeout, $iOption)
EndFunc   ;==>_TrayTip
#EndRegion Debug utility

#Region Read config from standard Ini file

Func _Util_IniWrite($sIniFilePath, $sSectionName, $sKeyName, $sValue)
	Local $writeRet = IniWrite($sIniFilePath, $sSectionName, $sKeyName, $sValue)
	If $writeRet = 0 Then
		ConsoleWrite("! WriteFailed" & @CRLF)
		;MsgBox features: Title=Yes, Text=Yes, Buttons=OK, Icon=Critical
		MsgBox(16, "Error!", "Can not write data to the configuration file " & $sIniFilePath & "." & @CRLF & "The file is not exist or is at Read-Only state!")
	EndIf
EndFunc   ;==>_Util_IniWrite

Func _Util_IniDelete($sIniFilePath, $sSectionName, $sKeyName)
	Local $writeRet = IniDelete($sIniFilePath, $sSectionName, $sKeyName)
	If $writeRet = 0 Then
		ConsoleWrite("! Delete Failed" & @CRLF)
		;MsgBox features: Title=Yes, Text=Yes, Buttons=OK, Icon=Critical
		MsgBox(16, "Error!", "Can not write data to the configuration file " & $sIniFilePath & "." & @CRLF & "The file isn't exist or at Read-Only state!")
	EndIf
EndFunc   ;==>_Util_IniDelete

Func _Util_ReadActionDetails($actionID)
	Local $iCount
	$iCount = Int(_Util_GetIniActionConfig($actionID, $_g_conf_sActionCount, "-1"))
	
	If $iCount <= 0 Then Return 0

	Local $aRet[$iCount + 2][2]
	$aRet[0][0] = $iCount & ""
	$aRet[0][1] = ""
	For $i = 1 To $iCount
		$aRet[$i][0] = ""
		$aRet[$i][1] = ""
	Next
	
	For $i = 1 To $iCount Step +1
		$aRet[$i][0] = "" ;Action Text
		$aRet[$i][1] = _Util_GetIniActionConfig($actionID, ("" & $i), "") ;Action configuration strings
	Next
	Return $aRet
EndFunc   ;==>_Util_ReadActionDetails

Func _Util_GetIniFormConfig($sSection, $sKey, $sDefValue = "")
	Local $sTmp = _Util_GetIniConfig($_g_c_sFrmConfigPath, $sSection, $sKey, $sDefValue)
	If $sTmp = $sDefValue Then
		Return $sDefValue
	Else
		Return $sTmp
	EndIf
EndFunc   ;==>_Util_GetIniFormConfig

Func _Util_GetIniActionConfig($sSection, $sKey, $sDefValue = "")
	Local $sTmp = _Util_GetIniConfig($_g_c_sActionConfigPath, $sSection, $sKey, $sDefValue)
	If $sTmp = $sDefValue Then
		Return $sDefValue
	Else
		Return $sTmp
	EndIf
EndFunc   ;==>_Util_GetIniActionConfig

Func _Util_GetIniConfig($sConfigFilePath, $sSection, $sKey, $sDefValue = "")
	Local $sTmp = IniRead($sConfigFilePath, $sSection, $sKey, $sDefValue)
	If $sTmp = $sDefValue Then
		Return $sDefValue
	Else
		Return $sTmp
	EndIf
EndFunc   ;==>_Util_GetIniConfig
#EndRegion Read config from standard Ini file

Func _EnumCtrl($hWnd)
	Local $sClassList = WinGetClassList($hWnd)
	Local $aSplit = StringSplit($sClassList, @CRLF)

	Local $iCnt, $aCtrlList[1]
	For $i = 1 To $aSplit[0]
		$iCnt = 1
		If $aSplit[$i] = "" Then ContinueLoop
		$aCtrlList[0] += 1
		ReDim $aCtrlList[$aCtrlList[0] + 1]
		$aCtrlList[$aCtrlList[0]] = $aSplit[$i] & $iCnt
		For $j = $i + 1 To $aSplit[0]
			If $aSplit[$i] <> $aSplit[$j] Then
				ContinueLoop
			Else
				$iCnt += 1
				$aCtrlList[0] += 1
				ReDim $aCtrlList[$aCtrlList[0] + 1]
				$aCtrlList[$aCtrlList[0]] = $aSplit[$i] & $iCnt
				$aSplit[$j] = ""
			EndIf
		Next
		$aSplit[$i] = ""
	Next
	Return $aCtrlList
EndFunc   ;==>_EnumCtrl


; #FUNCTION# ====================================================================================================================
; Name ..........: _CtrlGetClassNN_ByPos - CAN NOT USE - NOT COMPLETED YET
; Description ...:
; Syntax ........: _CtrlGetClassNN_ByPos([$aMPos = 0])
; Parameters ....: $aMPos               - [optional] an array describe Mouse position. Default is 0.
; Return values .: Control class nameNN in string type
; Author ........: ofLight
; Link	.........: https://www.autoitscript.com/forum/topic/51438-control-id-class-instance-text/
; Example .......: _CtrlGetClassNN_ByPos(MouseGetPos())
; ===============================================================================================================================
Func _CtrlGetClassNN_ByPos($aMPos = 0, $hWin = 0)
	If Not IsHWnd($hWin) Then Return ''

	$aWinPos = WinGetPos($hWin)
	;_DebugArrayDisplay($aWinPos)
	;_DebugArrayDisplay($aMPos)

	Local $sCreateArray = '', $sClassList = WinGetClassList($hWin)
	Local $sSplitClass = StringSplit(StringTrimRight($sClassList, 1), @LF), $sReturn = ''

	;$OptMCM = Opt('MouseCoordMode', 2)
	If $aMPos = 0 Then
		$aMPos = MouseGetPos()
	EndIf

	;Opt('MouseCoordMode', $OptMCM)

	For $iCount = UBound($sSplitClass) - 1 To 1 Step -1
		Local $nCount = 0
		While 1
			$nCount += 1
			Local $aCPos = ControlGetPos($hWin, '', $sSplitClass[$iCount] & $nCount)
			If @error Then ExitLoop
			If $aMPos[0] >= $aCPos[0] And $aMPos[0] <= ($aCPos[0] + $aCPos[2]) _
					And $aMPos[1] >= $aCPos[1] And $aMPos[1] <= ($aCPos[1] + $aCPos[3]) Then
				If $sSplitClass[$iCount] <> '' Then
					;Opt('MouseCoordMode', Default)
					_DebugArrayDisplay($aCPos)
					Return $sSplitClass[$iCount] & $nCount
				EndIf
			EndIf
		WEnd
	Next
	;Opt('MouseCoordMode', Default)
	Return $sReturn
EndFunc   ;==>_CtrlGetClassNN_ByPos


#cs not used yet
Func _CreateBitmapFromIcon($iBackground, $sIcon, $iIndex, $iWidth, $iHeight)
	Local $hDC = _WinAPI_GetDC(0)
	Local $hBackDC = _WinAPI_CreateCompatibleDC($hDC)
	$iBackground = BitAND(BitShift($iBackground, -16) + BitAND($iBackground, 0xFF00) + BitShift($iBackground, 16), 0xFFFFFF)
	Local $hBitmap = _WinAPI_CreateSolidBitmap(0, $iBackground, $iWidth, $iHeight)
	Local $hBackSv = _WinAPI_SelectObject($hBackDC, $hBitmap)
	Local $hIcon = _WinAPI_ShellExtractIcon($sIcon, $iIndex, $iWidth, $iHeight)
	If Not @error Then
		_WinAPI_DrawIconEx($hBackDC, 0, 0, $hIcon, 0, 0, 0, 0, 0x0003)
		_WinAPI_DestroyIcon($hIcon)
	EndIf
	_WinAPI_SelectObject($hBackDC, $hBackSv)
	_WinAPI_ReleaseDC(0, $hDC)
	_WinAPI_DeleteDC($hBackDC)
	Return $hBitmap
EndFunc ;==>_CreateBitmapFromIcon
#ce not used yet
