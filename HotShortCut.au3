#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #RequireAdmin
;*****************************************
;HotShortCut.au3 by MrOnly
;Created with ISN AutoIt Studio v. 1.08
;*****************************************
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Debug.au3>
;~ #include "Control\actionForm_Control.au3"
;~ #include "Control\newActionForm_Control.au3"
;~ #include "Control\Test.au3"

#include "Control\Global_Variable.au3"
#include "Control\Utility_Script.au3"
#include "GUI\Gui_Action.au3"


_DeclareOption()
;~ Initialization()

While (1)
	Sleep(10)
WEnd

Func Initialization()
	OnAutoItExitRegister("_Clear_Resources")
	_DeclareOption()
	_Init_Global_Variables()
;~ _FrmMain_Init()
EndFunc   ;==>Initialization                                                                                                    

Func _DeclareOption()
	;~ Opt("SendCapslockMode", 1)
	Opt("TrayIconDebug", 0) ; 0 - No show debug, 1 - show debug

	Opt("GUIOnEventMode", 1)
	Opt("GUIDataSeparatorChar", $AC_DELIMITER)
	Opt("WinWaitDelay", 10)

EndFunc   ;==>_DeclareOption

Func _Prepare_Resources()
	;~ $h_g_actionConfigFile = FileOpen($_g_c_sActionConfigPath,$FO_OVERWRITE)
	Return True
EndFunc

Func _Clear_Resources()
	;~ FileClose($h_g_actionConfigFile)
	Return True
EndFunc
