;Global_Variable.au3
#include-once

#Region Constant
Global Const $_g_c_sFrmConfigPath = "./Configs/form_config.ini"
Global Const $_g_c_sActionConfigPath = "./Configs/action_configs.ini"
Global Const $_g_conf_sActionName = "name"
Global Const $_g_conf_sActionCount = "count"
Global Const $_g_conf_sActionHotKey = "hotkey"
Global Const $_g_conf_sProcessAction = "process"
Global Const $_g_conf_sActionCommonSection = "common"
#EndRegion Constant


#Region Action constant used to search for text, tooltip in config files
Global Const $ACTION_INI_SECTION_NAME = "actions"
Global Const $AC_OPEN_FILE =  "1"
Global Const $AC_SENDKEY =  "2"
Global Const $AC_SENDMOUSE_EVT =  "3"
Global Const $AC_WINDOW_STATE =  "4"
Global Const $AC_DELAY = "5"
Global Const $AC_DELIMITER = "|"

Global Const $ACTION_GROUP_COUNT = 6
#EndRegion action set

#Region Global configuration
Global $_g_iActionCount = 0
Global $_g_aAction[31][4]
Global $h_g_actionConfigFile
#EndRegion Global configuration

Func _Init_Global_Variables()
	For $i = 1 To 30
		$_g_aAction[$i][0] = ""
		$_g_aAction[$i][1] = ""
		$_g_aAction[$i][2] = ""
	Next
EndFunc   ;==>_Init_Global_Variables
