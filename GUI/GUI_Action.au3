#include-once
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

#include "GUI_ActionDetails.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Control\Utility_Script.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Testing\_SendText.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Testing\_SetWindowState.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Testing\_OpenProgram.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Testing\_SendClick.au3"
;#include "C:\Users\QuynhDam\Desktop\demo_OpenGUI.au3"
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Testing\Excute.au3"
Opt("GUIOnEventMode", 1)
Global $TAB
#Region ### START Koda GUI section ### Form=koda_action.kxf
Global $actionForm = GUICreate("mainForm", 690, 343, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_TABSTOP))
Global $MenuItem178 = GUICtrlCreateMenu("&File")
Global $menuConfigre = GUICtrlCreateMenuItem("Configure", $MenuItem178)
Global $menuExit = GUICtrlCreateMenuItem("Exit" & @TAB, $MenuItem178)
Global $MenuItem363 = GUICtrlCreateMenu("&Help")
Global $menuAbout = GUICtrlCreateMenuItem("About" & @TAB, $MenuItem363)
GUISetOnEvent($GUI_EVENT_CLOSE, "actionFormClose")
Global $h_fA_lvAction = GUICtrlCreateListView("Name|HotKey|Action", 8, 8, 358, 304, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS, $LVS_AUTOARRANGE), BitOR($WS_EX_CLIENTEDGE, $LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
_GUICtrlListView_SetExtendedListViewStyle($h_fA_lvAction, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 150)
GUICtrlSetOnEvent(-1, "h_fA_lvActionClick")
Global $h_fA_btnAdd = GUICtrlCreateButton("", 371, 8, 34, 30, $BS_ICON)
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -150)
GUICtrlSetTip(-1, "Add new")
GUICtrlSetOnEvent(-1, "h_fA_btnAddClick")
Global $h_fA_btnEdit = GUICtrlCreateButton("", 371, 50, 34, 30, BitOR($BS_FLAT, $BS_ICON))
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -36)
GUICtrlSetTip(-1, "Modify")
GUICtrlSetOnEvent(-1, "h_fA_btnEditClick")
Global $h_fA_btnDelete = GUICtrlCreateButton("", 371, 92, 34, 30, $BS_ICON)
GUICtrlSetImage(-1, "C:\Windows\System32\shell32.dll", -132, 0)
GUICtrlSetOnEvent(-1, "h_fA_btnDeleteClick")
Global $Label1 = GUICtrlCreateLabel("Name", 416, 11, 32, 17)
Global $h_fA_sName = GUICtrlCreateInput("", 456, 8, 225, 21)
Global $Label2 = GUICtrlCreateLabel("Action", 416, 43, 34, 17)
Global $Input1 = GUICtrlCreateInput("", 456, 136, 161, 21)
Global $Label3 = GUICtrlCreateLabel("HotKey", 416, 139, 39, 17)
Global $h_fA_btnSet = GUICtrlCreateButton("Set", 632, 133, 51, 25)
GUICtrlSetOnEvent(-1, "h_fA_btnSetClick")
Global $h_fA_sAction = GUICtrlCreateEdit("", 456, 40, 225, 89)
GUICtrlSetData(-1, "")
Global $Group1 = GUICtrlCreateGroup("Function", 384, 176, 297, 137)
Global $btnOpenProgram = GUICtrlCreateButton("Open Program", 416, 200, 75, 25)
GUICtrlSetOnEvent($btnOpenProgram, "OpenProgram_")
Global $btnSendKey = GUICtrlCreateButton("Send  Key", 416, 240, 75, 25)
GUICtrlSetOnEvent($btnSendKey, "SendText")
Global $btnSendClick = GUICtrlCreateButton("Send Click", 576, 200, 75, 25)
GUICtrlSetOnEvent($btnSendClick, "SendClick")
Global $btnSetWindowsState = GUICtrlCreateButton("Set Windows State", 480, 280, 107, 25)
GUICtrlSetOnEvent($btnSetWindowsState, "SetWindownState")
Global $btnMisc = GUICtrlCreateButton("Excute", 576, 240, 75, 25)
GUICtrlSetOnEvent($btnMisc, "__Test__")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $actionForm_AccelTable[2][2] = [["^{CAPS LOCK}", $menuConfigre],["^!,", $menuAbout]]
GUISetAccelerators($actionForm_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $i_fA_lvActionCurIdx = -1
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY_H")
;GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
_FormAction_Initialize()


;~ While 1
;~ 	Sleep(10)
;~ WEnd

Func _FormAction_Initialize()
	Local $hExStyle = _GUICtrlListView_GetExtendedListViewStyle($h_fA_lvAction)
	_GUICtrlListView_SetExtendedListViewStyle($h_fA_lvAction, BitOR($hExStyle, $LVS_EX_HEADERDRAGDROP, $LVS_EX_INFOTIP))
	_GUICtrlListView_SetColumnWidth($h_fA_lvAction, 2, $LVSCW_AUTOSIZE_USEHEADER) ;Fill the last colum
	_ActionLoad($_g_c_sActionConfigPath)
	Local $hWndList = GUICtrlGetHandle($h_fA_lvAction)
	
EndFunc   ;==>_FormAction_Initialize

Func _ActionLoad($sConfigPath)
	Local $iCount = Int(_Util_GetIniActionConfig($_g_conf_sActionCommonSection, $_g_conf_sActionCount, "0"))
	If ($iCount = 0) Then
		_Error("No action found! Please create one!")
		Return 0
	EndIf
	Local $sAction, $sName, $sHotKey
	Local $sDelimiter = Opt("GUIDataSeparatorChar")

	For $i = 0 To $iCount - 1
		$sName = _Util_GetIniActionConfig($i, $_g_conf_sActionName, "")
		$sHotKey = _Util_GetIniActionConfig($i, $_g_conf_sActionHotKey, "")
		$sAction = _Util_GetIniActionConfig($i, "1", "")
		GUICtrlCreateListViewItem(StringFormat(StringReplace("%s|%s|%s", "|", $sDelimiter), $sName, $sHotKey, _ParseAction($sAction)), $h_fA_lvAction)
		;GUICtrlSetOnEvent(-1, "h_fA_lvRowClick")
	Next

	Return True
EndFunc   ;==>_ActionLoad


Func actionFormClose()
	Exit
EndFunc   ;==>actionFormClose
Func h_fA_btnAddClick()
	Local $iCount = Int(_Util_GetIniActionConfig($_g_conf_sActionCommonSection, $_g_conf_sActionCount, "0"))
	IniWrite($_g_c_sActionConfigPath,$_g_conf_sActionCommonSection,$_g_conf_sActionCount,$iCount+1);Increase common section
	IniWrite($_g_c_sActionConfigPath,$iCount, $_g_conf_sActionName, "") ;Create name key
	IniWrite($_g_c_sActionConfigPath,$iCount, $_g_conf_sActionHotKey, "") ;Create hotkey key in ini file
	IniWrite($_g_c_sActionConfigPath,$iCount, $_g_conf_sActionCount, 0) ;Create count key with default value 0
	
	_frm_NewAction_Initialize($iCount)
	
	GUISetState(@SW_SHOW, $Frm_NewAction)
	
EndFunc   ;==>h_fA_btnAddClick

Func h_fA_btnDeleteClick()

EndFunc   ;==>h_fA_btnDeleteClick

Func h_fA_btnEditClick()
	Local $sItemText = _GUICtrlListView_GetItem($h_fA_lvAction,$i_fA_lvActionCurIdx)[3]
	ConsoleWrite("h_fA_btnEditClick: Cur idx:" & $i_fA_lvActionCurIdx & @CRLF)
	_frm_NewAction_Initialize($i_fA_lvActionCurIdx & "")
	
	GUISetState(@SW_SHOW,$Frm_NewAction)
EndFunc   ;==>h_fA_btnEditClick

Func h_fA_btnSetClick()

EndFunc   ;==>h_fA_btnSetClick
Func h_fA_lvActionClick()
	$str = StringSplit(GUICtrlRead(GUICtrlRead($h_fA_lvAction)), "|")
	If Not IsArray($str) Then 
		_Error("!ERROR _ParseAction failed with " & $sAction & @CRLF)
		Return 0
	EndIf
	_DebugArrayDisplay($str)
	GUICtrlSetData($h_fA_sName,$str[1] )
	GUICtrlSetData($Input1, $str[2])
	GUICtrlSetData($h_fA_sAction, $str[3])
EndFunc   ;==>h_fA_lvActionClick

Func h_fA_lvRowClick()
	Return True
EndFunc   ;==>h_fA_lvRowClick


Func WM_NOTIFY_Handle($hWnd, $iMsg, $wParam, $lParam)
	Local $tagMNHDR, $event, $hwndFrom, $code
	$tagMNHDR = DllStructCreate("int;int;int;", $lParam)
	If @error Then Return 0
	$code = DllStructGetData($tagMNHDR, 3)
	If $wParam = $h_fA_lvAction And $code = -3 Then $g_b_doubleClicked = True
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY_Handle

Func WM_NOTIFY_H($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Global $h_fA_lvAction
	Local $hwndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
	$hWndListView = $h_fA_lvAction
	If Not IsHWnd($h_fA_lvAction) Then $hWndListView = GUICtrlGetHandle($h_fA_lvAction)

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hwndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hwndFrom
		Case $hWndListView
			$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
			$i_fA_lvActionCurIdx = Int(DllStructGetData($tInfo, "Index"))
			$i_fA_lvActionCurIdx = $i_fA_lvActionCurIdx >=0 ? $i_fA_lvActionCurIdx:-1
			Switch $iCode
				Case $NM_CLICK ; Sent by a list-view control when the user clicks an item with the left mouse button
                    Return $i_fA_lvActionCurIdx
				Case $NM_DBLCLK     ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					;~ _DebugPrint("$NM_DBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hwndFrom & @CRLF & _
					;~ 		"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					;~ 		"-->Code:" & @TAB & $iCode & @CRLF & _
					;~ 		"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @CRLF & _
					;~ 		"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					;~ 		"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					;~ 		"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					;~ 		"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					;~ 		"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					;~ 		"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					;~ 		"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
					;~ 		"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;~ ; No return value
					h_fA_btnEditClick()
			EndSwitch
	EndSwitch

EndFunc   ;==>WM_NOTIFY_H

Func GetIndexListView($listview)
	
    Local $last_selected_item_index = -1
    Do
        $iCount = _GUICtrlListView_GetItemCount($listview)
        For $i = 0 To $iCount - 1
            If _GUICtrlListView_GetItemSelected($listview, $i) Then
                $now_selected_item_index = $i
                If $last_selected_item_index <> $now_selected_item_index Then
                   ; MsgBox(0, 0, $now_selected_item_index)
                    $last_selected_item_index = $now_selected_item_index
					Return $now_selected_item_index
                    ContinueLoop
                EndIf
            EndIf
        Next
    Until GUIGetMsg() = $GUI_EVENT_CLOSE
    
EndFunc 




Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
    ConsoleWrite( _
            "!===========================================================" & @CRLF & _
            "+======================================================" & @CRLF & _
            "-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
            "+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
Func _SetData()
	GUICtrlSetData($h_fA_sName, )
	GUICtrlSetData($h_fA_sAction, )
	GUICtrlSetData($Input1, )
EndFunc

