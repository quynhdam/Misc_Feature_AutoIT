#include <GUIConstantsEx.au3>
#include <SendMessage.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIGdiDC.au3>
#include <WinAPIHObj.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <Process.au3>
#include <Debug.au3>
#include <WinAPISysWin.au3>
#include <ScreenCapture.au3>
Opt("WinTitleMatchMode", 2)

Global $sProgramName = "Hearthstone"

;_RunDos($sProgramPath)
Local $hWnd = WinGetHandle($sProgramName)
Local $aWinlist = GetAllWindow($sProgramName)
For $i = 0 To UBound($aWinlist) - 1
	If StringInStr($aWinlist[$i][0], $sProgramName) Then
		$hWnd = $aWinlist[$i][1]
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $hWnd = ' & $hWnd & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
		ExitLoop
	EndIf
	;If Not WinActive($hWnd) Then ExitLoop
Next


;WinActivate($hWnd)
;WinSetState($hWnd, '', @SW_MAXIMIZE)

;_DebugArrayDisplay($aWnd, "Windows")
If Not $hWnd Then
	ConsoleWrite("Not WinHandler" & @CRLF)
	Exit
EndIf
Example1($hWnd)
;ShellExecute("Test.bmp")





Func Example1($hWnd)
	; Create GUI
	Local $iSize = WinGetPos($hWnd)
	Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $iSize[2] + 80, $iSize[3] + 80)
	Local $idPic = GUICtrlCreatePic('', 40, 40, $iSize[2], $iSize[3])
	Local $hPic = GUICtrlGetHandle($idPic)

	; Create bitmap

	GUISetState(@SW_SHOW)
	Local $iFPS = 60
	Local $iDelay = 1000 / $iFPS
	Do
		Local $hDC = _WinAPI_GetDC($hPic)
		Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
		Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $iSize[2], $iSize[3])
		Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
		Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
		Local $hBmp = _WinAPI_CreateCompatibleBitmap($hDC, $iSize[2], $iSize[3])
		Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hBmp)
		_WinAPI_PrintWindow($hWnd, $hSrcDC)
		_WinAPI_BitBlt($hDestDC, 0, 0, $iSize[2], $iSize[3], $hSrcDC, 0, 0, $MERGECOPY)

		_WinAPI_ReleaseDC($hPic, $hDC)
		_WinAPI_SelectObject($hDestDC, $hDestSv)
		_WinAPI_SelectObject($hSrcDC, $hSrcSv)
		_WinAPI_DeleteDC($hDestDC)
		_WinAPI_DeleteDC($hSrcDC)
		_WinAPI_DeleteObject($hBmp)


		;_WinAPI_SaveHBITMAPToFile("Test.bmp", $hBitmap)
;~ ShellExecute("Test.jpg")

		; Set bitmap to control
		_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
		Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
		If $hObj <> $hBitmap Then
			_WinAPI_DeleteObject($hBitmap)
		EndIf
		Sleep($iDelay)
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example1

Func GetAllWindow($sWindowName = "") ;code by Authenticity - modified by UEZ
	Local $aWin = WinList($sWindowName), $aWindows[1][4]
	Local $iStyle, $iEx_Style, $iCounter = 0
	Local $i, $hWnd_state, $aWinPos

	For $i = 1 To $aWin[0][0]
		$iEx_Style = BitAND(_WinAPI_GetWindowLong($aWin[$i][1], $GWL_EXSTYLE), $WS_EX_TOOLWINDOW)
		$iStyle = BitAND(WinGetState($aWin[$i][1]), 2)
		If $iEx_Style <> -1 And Not $iEx_Style And $iStyle Then
			$aWinPos = WinGetPos($aWin[$i][1])
			If $aWinPos[2] > 1 And $aWinPos[3] > 1 Then
				$aWindows[$iCounter][0] = $aWin[$i][0]
				$aWindows[$iCounter][1] = $aWin[$i][1]
				$aWindows[$iCounter][2] = $aWinPos[2]
				$aWindows[$iCounter][3] = $aWinPos[3]
				$iCounter += 1
			EndIf
			ReDim $aWindows[$iCounter + 1][4]
		EndIf
	Next
	ReDim $aWindows[$iCounter][4]
	Return $aWindows
EndFunc   ;==>GetAllWindow

