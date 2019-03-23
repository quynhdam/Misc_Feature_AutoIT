;actionForm_Control.au3
#include-once
#include "Utility_Script.au3"
#include "Global_Variable.au3"
#include "actionForm.isf"
#include "newActionForm_Control.au3"

Func _Init_NewActionFrm()
	ConsoleWrite("_Init_NewActionFrm" & @CRLF)
	$newAction = _newAction()
EndFunc   ;==>_Init_NewActionFrm

Func _Frm_Reload_ListView(ByRef $vAction)
	Local $sRes = ""
	_GUICtrlListView_DeleteAllItems($vAction)
	If $_g_iActionCount = 0 Then
		_GUICtrlButton_Enable($_gfrm_btnDelete, False)
		_GUICtrlButton_Enable($_gfrm_btnEdit, False)
		Return
	EndIf
	For $i = 0 To $_g_iActionCount - 1
		$sRes = $_g_aAction[$i][0] & "|" & $_g_aAction[$i][1] & "|" & $_g_aAction[$i][2]
		If StringLen($sRes) > 0 Then GUICtrlCreateListViewItem($sRes, $vAction)
	Next

	ConsoleWrite('<==_Frm_Reload_ListView' & @CRLF) ;### Debug Console
EndFunc   ;==>_Frm_Reload_ListView

Func _Frm_Read_Ini($sConfigFilePath)
	If Not FileExists($sConfigFilePath) Then
		MsgBox(266256, "Form config not found", "The form_configs.ini not found! Please check again in folder Configs/" & @CRLF & _ 
             "Program will abort!", 0)
		Exit
	EndIf
EndFunc   ;==>_Frm_Read_Ini

Func _Action_Read_Ini($sActionConfPath)
	If Not FileExists($sActionConfPath) Then
		MsgBox(266256, "Action config not found", "The action_configs.ini not found! Please check again in folder Configs/" & @CRLF & "Program will abort!", 0)
		Exit
	EndIf
	$_g_iActionCount = Number(IniRead($_g_c_sActionConfigPath, $_g_conf_sActionCommonSection, "count", 0))
	For $i = 0 To $_g_iActionCount - 1
		Local $sName = "", $sPath = "", $sProcess = "", $sRes = ""
		$sName = IniRead($_g_c_sActionConfigPath, $i, $_g_conf_sNameAction, "0")
		$sPath = IniRead($_g_c_sActionConfigPath, $i, $_g_conf_sPathAction, "")
		$sProcess = IniRead($_g_c_sActionConfigPath, $i, $_g_conf_sProcessAction, "")
		$_g_aAction[$i][0] = $sName
		$_g_aAction[$i][1] = $sPath
		$_g_aAction[$i][2] = $sProcess
		;Local $sRes = "item5|col52|col53";"" & $sName & "|" & $sPath & "|" &  $sProcess & ""
	Next
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $_g_iActionCount = ' & $_g_iActionCount & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console

EndFunc   ;==>_Action_Read_Ini




Func _FrmMain_Init()
	_actionForm()
	_Frm_Read_Ini($_g_c_sFrmConfigPath)
	_Action_Read_Ini($_g_c_sActionConfigPath)
	_Frm_Reload_ListView($_gfrm_vActionList)

EndFunc   ;==>_FrmMain_Init

Func _Frm_Exit()
	ConsoleWrite("! Form Exit" & @CRLF)
	Exit
EndFunc   ;==>_Frm_Exit
