#include-once
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <Misc.au3>
#include <WinAPISysWin.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Local $h_HKP_hWnd, $h_HKP_gui_Main
Local $h_HKP_sz_Flag, $h_HKP_i_Hotkey
Local $h_HKP_ParentForm, $h_HKP_TargetControl, $h_HKP_GetBtn
Func _get_HotKey_GUI($hParentForm="", $hTargetControl="")
	HotKeySet('{CAPSLOCK}', '_HKP_GetCode_ExcludeHotkey')
	HotKeySet('{NUMLOCK}', '_HKP_GetCode_ExcludeHotkey')

	Local Const $HKM_SETHOTKEY = $WM_USER + 1
	Local Const $HKM_GETHOTKEY = $WM_USER + 2
	Local Const $HKM_SETRULES = $WM_USER + 3

	Local Const $HOTKEYF_ALT = 0x04
	Local Const $HOTKEYF_CONTROL = 0x02
	Local Const $HOTKEYF_EXT = 0x80 ; Extended key
	Local Const $HOTKEYF_SHIFT = 0x01

	; invalid key combinations
	Local Const $HKCOMB_A = 0x8 ; ALT
	Local Const $HKCOMB_C = 0x4 ; CTRL
	Local Const $HKCOMB_CA = 0x40 ; CTRL+ALT
	Local Const $HKCOMB_NONE = 0x1 ; Unmodified keys
	Local Const $HKCOMB_S = 0x2 ; SHIFT
	Local Const $HKCOMB_SA = 0x20 ; SHIFT+ALT
	Local Const $HKCOMB_SC = 0x10 ; SHIFT+CTRL
	Local Const $HKCOMB_SCA = 0x80 ; SHIFT+CTRL+ALT

	$h_HKP_sz_Flag = ""
	$h_HKP_i_Hotkey = 0
	$h_HKP_ParentForm = $hParentForm
	$h_HKP_TargetControl = $hTargetControl

	$h_HKP_gui_Main = GUICreate('Get Hotkey', 220, 90,Default,Default,Default,Default,$hParentForm)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_HKP_Exit")
	$h_HKP_GetBtn = GUICtrlCreateButton('Select Key', 10, 50, 200, 30) ;
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	GUICtrlSetOnEvent($h_HKP_GetBtn, "_HKP_return_HotKey")

	$h_HKP_hWnd = _WinAPI_CreateWindowEx(0, 'msctls_hotkey32', '', BitOR($WS_CHILD, $WS_VISIBLE), 10, 10, 200, 25, $h_HKP_gui_Main)
	ControlFocus($h_HKP_hWnd,"","")
	_SendMessage($h_HKP_hWnd, $HKM_SETRULES, _
			BitOR($HKCOMB_NONE, $HKCOMB_S), _       ; invalid key combinations
			BitOR(BitShift($HOTKEYF_ALT, -16), BitAND(0, 0xFFFF))) ; add ALT to invalid entries
	;GUISetOnEvent($GUI_EVENT_PRIMARYUP, "_HKP_check_HotKey",$h_HKP_hWnd)
	;GUICtrlSetState($h_HKP_GetBtn, $GUI_DISABLE)
	GUISetState(@SW_SHOW, $h_HKP_gui_Main)
	GUISwitch($h_HKP_ParentForm)
	GUISetState(@SW_DISABLE)
;~ 	While WinExists("Get Hotkey")
;~ 		Sleep(100)
;~ 	WEnd

	Return $h_HKP_sz_Flag & $h_HKP_i_Hotkey
EndFunc   ;==>_get_HotKey_GUI

Func _HKP_return_HotKey()
	ConsoleWrite("_HKP_return_HotKey" & @CRLF)
	Local Const $HKM_GETHOTKEY = $WM_USER + 2
	Local Const $HOTKEYF_ALT = 0x04
	Local Const $HOTKEYF_CONTROL = 0x02
	Local Const $HOTKEYF_EXT = 0x80 ; Extended key
	Local Const $HOTKEYF_SHIFT = 0x01

	$h_HKP_i_Hotkey = _SendMessage($h_HKP_hWnd, $HKM_GETHOTKEY)
	$n_Flag = BitShift($h_HKP_i_Hotkey, 8)          ; high byte
	$h_HKP_i_Hotkey = BitAND($h_HKP_i_Hotkey, 0xFF) ; low byte
	$h_HKP_sz_Flag = ""
	If BitAND($n_Flag, $HOTKEYF_SHIFT) Then $h_HKP_sz_Flag = "Shift+"
	If BitAND($n_Flag, $HOTKEYF_CONTROL) Then $h_HKP_sz_Flag = $h_HKP_sz_Flag & "Ctrl+"
	If BitAND($n_Flag, $HOTKEYF_ALT) Then $h_HKP_sz_Flag = $h_HKP_sz_Flag & "Alt+"
	_HKP_Exit()
EndFunc   ;==>_HKP_return_HotKey
Func _HKP_check_HotKey()
	ConsoleWrite("_HKP_check_HotKey" & @CRLF)
	If StringLen($h_HKP_sz_Flag) > 0 Then
		GUICtrlSetState($h_HKP_GetBtn, $GUI_ENABLE)
	EndIf

EndFunc

Func _HKP_Exit()
	ConsoleWrite("_HKP_Exit with value = " & $h_HKP_sz_Flag & $h_HKP_i_Hotkey & @CRLF)
	HotKeySet('{CAPSLOCK}')
	HotKeySet('{NUMLOCK}')
	_WinAPI_DestroyWindow($h_HKP_hWnd)
	GUIDelete($h_HKP_gui_Main)

	GUISetState(@SW_ENABLE, $h_HKP_ParentForm)
	GUISetState(@SW_RESTORE, $h_HKP_ParentForm)
	GUICtrlSetData($h_HKP_TargetControl, $h_HKP_sz_Flag & Chr($h_HKP_i_Hotkey))

	$h_HKP_ParentForm = ""
	$h_HKP_TargetControl = ""
EndFunc   ;==>_HKP_Exit

Func _HKP_GetCode($string)
	$temp = StringSplit($string, '+')

	$lastTerm = StringLower(StringStripWS($temp[UBound($temp) - 1], 8))

	If StringLen($lastTerm) > 1 Then
		If StringLeft($lastTerm, 1) = 'F' Then
			$append = '{' & StringUpper($lastTerm) & '}'
		EndIf
	Else
		$temp = StringLower(StringRight($string, 1))
		If $temp = '!' Then
			$append = '{PGUP}'
		ElseIf $temp = '"' Then
			$append = '{PGDN}'
		ElseIf $temp = '$' Then
			$append = '{HOME}'
		ElseIf $temp = '#' Then
			$append = '{END}'
		ElseIf $temp = '-' Then
			$append = '{INS}'
		Else
			$append = StringLower(StringRight($string, 1))
		EndIf
	EndIf

	$hotkeyAssignment = ''
	If StringInStr($string, 'CTRL') > 0 Then
		$hotkeyAssignment &= '^'
	EndIf

	If StringInStr($string, 'SHIFT') > 0 Then
		$hotkeyAssignment &= '+'
	EndIf

	If StringInStr($string, 'ALT') > 0 Then
		$hotkeyAssignment &= '!'
	EndIf

	$hotkeyAssignment &= $append

	Return $hotkeyAssignment
EndFunc   ;==>_HKP_GetCode

Func _HKP_GetCode_ExcludeHotkey()
	Local Const $HKM_SETHOTKEY = $WM_USER + 1
	_SendMessage(_WinAPI_GetFocus(), $HKM_SETHOTKEY)
EndFunc   ;==>_HKP_GetCode_ExcludeHotkey
