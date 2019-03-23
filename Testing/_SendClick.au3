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
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\GUI_ActionDetails.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\GUI_Action.au3"

Global $sTitle_SendClick = ""
Global $sText_SendClick = ""
Global $iCoordinate_X = 0
Global $iCoordinate_Y = 0
Global $sMouse = ""
Global $iTime_Click = 0
Global $Speed = 0
Func Get_Title()
	Return GUICtrlRead($h_fNA_tClick_sWnd)
EndFunc
Func Get_Text()
	Return GUICtrlRead($h_fNA_tClick_sWndText)
EndFunc
Func Get_X()
	Return GUICtrlRead($h_fNA_tClick_iX)
EndFunc
Func Get_Y()
	Return GUICtrlRead($h_fNA_tClick_iY)
EndFunc
Func Get_Mouse()
	Return GUICtrlRead($h_fNA_tClick_cbbMouseBtn)
EndFunc
Func Get_TimeClick()
	Return GUICtrlRead($h_fNA_tClick_iClickCount)
EndFunc
Func Get_Speed()
	Return GUICtrlRead($h_fNA_tClick_iTimeBetweenClicks)
EndFunc
Func SendClick($sWinTitle, $sWinText, $iWinX, $iWinY, $bScreenCoord, $iMouse, $iClick, $iClickInterval, $hControlID, $iCtrlX, $iCtrlY)
;~ 	$sTitle_SendClick = Get_Title()
;~ 	$sMouse = Get_Mouse()
;~ 	$Speed = Get_Speed()
;~ 	$sText_SendClick = Get_Text()
;~ 	$iTime_Click = Get_TimeClick()
;~ 	$iCoordinate_X = Get_X()
;~ 	$iCoordinate_Y = Get_Y()
	Local $sChoose_Mouse = ""
;~ 	ConsoleWrite($sTitle_SendClick & @CRLF)
;~ 	ConsoleWrite($sMouse & @CRLF)
;~ 	ConsoleWrite($Speed & @CRLF)
;~ 	ConsoleWrite($sText_SendClick & @CRLF)
;~ 	ConsoleWrite($iCoordinate_X & @CRLF)
;~ 	ConsoleWrite($iCoordinate_Y & @CRLF)
;~ 	ConsoleWrite($iTime_Click & @CRLF)
	Switch $sMouse
		Case "MOUSE_CLICK_PRIMARY"
			 $sChoose_Mouse = "MOUSE_CLICK_PRIMARY"
		Case "MOUSE_CLICK_RIGHT"
			 $sChoose_Mouse = "MOUSE_CLICK_RIGHT"
		Case "MOUSE_CLICK_MIDDLE"
			 $sChoose_Mouse = "MOUSE_CLICK_MIDDLE"
		Case "MOUSE_CLICK_MAIN"
			 $sChoose_Mouse = "MOUSE_CLICK_MAIN"
		Case "MOUSE_CLICK_MENU"
			 $sChoose_Mouse = "MOUSE_CLICK_MENU"
		Case "MOUSE_CLICK_PRIMARY"
			 $sChoose_Mouse = "MOUSE_CLICK_PRIMARY"
		Case "MOUSE_CLICK_SECONDARY"
			 $sChoose_Mouse = "MOUSE_CLICK_SECONDARY"
	EndSwitch 
	ConsoleWrite($sChoose_Mouse)
	WinActivate($sWinTitle, $sWinText)
	MouseClick($sChoose_Mouse, $iWinX, $iWinY, $iClick, $iClickInterval)
	
	
EndFunc