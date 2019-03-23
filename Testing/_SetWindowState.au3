#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Zelda

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
#include-once
#include <WinAPISysWin.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\GUI_ActionDetails.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\GUI_Action.au3"
#include <Process.au3>
Opt("WinTitleMatchMode", 2)
Global  $sProgName = ""
Global  $sProgText = ""
Global $iState = ""
Global $iTransparent = ""
Func SetWindownState($sProgName, $sProgText, $iState, $iTransparent)
		Open_Program($sProgName, $iState)
	
EndFunc
Func GetValue($sTitle_SetWindowState, $sText, $sState, $iTransparency)
	
	ConsoleWrite($iTransparency &  @CRLF)
	ConsoleWrite($sTitle_SetWindowState &  @CRLF)
	Local $curMode = Opt("WinTitleMatchMode")
	Opt("WinTitleMatchMode", 2)
	ConsoleWrite("Checking handle of Program " & $sTitle_SetWindowState & " " & $sText & @CRLF)
	Local $hWnd = WinGetHandle($sTitle_SetWindowState, $sText)
	If IsHWnd($hWnd) Then
		$ret = WinSetTrans($hWnd, "", $iTransparency)
		If $ret = 0 Then _Error("WinSetTrans failed")
	Else
		_Error("h_fNA_tWinState_TransparentTestBtnClick => Not win handle")
	EndIf
	Opt("WinTitleMatchMode", $curMode)
EndFunc
Func Open_Program($sProgName, $sState)
	
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
	;ConsoleWrite("$sHandle= " & $sHandle & @CRLF)
	Local $iPid = WinGetProcess($sProgName, "")
	Local $sName = _ProcessGetName($iPid)

	;MsgBox($MB_SYSTEMMODAL, "Spotify", $iPid &  "," &  $sName)

	$id = ProcessExists($sName)
	ConsoleWrite("id = " & $id & @CRLF)
	$aRet = WinList("[REGEXPTITLE:(?i)([^Default IME][^MSCTFIME UI][^GDI+ Window].*)]")
		;$aRet = WinList('[REGEXPTITLE:(.+)]')
	
	For $i = 1 To $aRet[0][0]
			
		$idTmp = WinGetProcess($aRet[$i][1])
		If $idTmp = $id Then 
			ConsoleWrite($aRet[$i][0] & '-->' & $aRet[$i][1]& @CRLF)
			$sHandle = $aRet[$i][1]
			ConsoleWrite("$sHandle: " & $sHandle & @CRLF)
			;Return $sHandle	
		EndIf
	Next
	
	For $i = 0 to $aWinInTaskBar[0][0]
		ConsoleWrite("$aWinInTaskBar[$i][1]: " & $aWinInTaskBar[$i][1] & @CRLF)
		If StringCompare($aWinInTaskBar[$i][1], $sHandle, $STR_CASESENSE) = 0 Then 
			ConsoleWrite("$aWinInTaskBar[$i][1]: " & $aWinInTaskBar[$i][1] & @CRLF)
			WinSetState($sHandle, "", $sState) 
		Else 
			ConsoleWrite("Not have parameter " & @CRLF)
		EndIf
	Next
	 
;~ 	$sName_Excute = StringSplit($sName, ".")
;~ 	ConsoleWrite("$sName_Excute: " & $sName_Excute & @CRLF)
;~ 	$iPID_ = Run(@Comspec & " /k" & "start " & $sName_Excute[1] & ":" & @CRLF, "", $sState)
;~ 	ConsoleWrite("$iPID_:" & $iPID_ & @CRLF)
;~ 	If Not IsNumber($iPID_) Then 
;~ 		Run(@Comspec & " /k" & $sName & @CRLF, "", @SW_MAXIMIZE)
;~ 	EndIf
	;Run("start " & $sName_Excute[1] & ":" , "", $sState)
	
	$GetPath = _ProcessGetLocation($sName)
	
	If $GetPath = -1 Then
		ConsoleWrite("Not have " & $sProgName & @CRLF)
	Else
		
			Run("cmd.exe", "", @SW_HIDE)
			WinActivate("C:\Windows\system32\cmd.exe")
			Send($GetPath &  @CRLF )
			GetValue($sProgName, $sProgText, $iState, $iTransparent)
		
	EndIf

	
EndFunc
Func _ProcessGetLocation($sProc = @ScriptFullPath)
    Local $iPID = ProcessExists($sProc)
    If $iPID = 0 Then Return SetError(1, 0, -1)
    
    Local $aProc = DllCall('kernel32.dll', 'hwnd', 'OpenProcess', 'int', BitOR(0x0400, 0x0010), 'int', 0, 'int', $iPID)
    If $aProc[0] = 0 Then Return SetError(1, 0, -1)
    
    Local $vStruct = DllStructCreate('int[1024]')
    DllCall('psapi.dll', 'int', 'EnumProcessModules', 'hwnd', $aProc[0], 'ptr', DllStructGetPtr($vStruct), 'int', DllStructGetSize($vStruct), 'int*', 0)
    
    Local $aReturn = DllCall('psapi.dll', 'int', 'GetModuleFileNameEx', 'hwnd', $aProc[0], 'int', DllStructGetData($vStruct, 1), 'str', '', 'int', 2048)
    If StringLen($aReturn[3]) = 0 Then Return SetError(2, 0, '')
    Return $aReturn[3]
EndFunc