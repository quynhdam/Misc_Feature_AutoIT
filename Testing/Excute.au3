#include <MsgBoxConstants.au3>
#include "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\GUI\Gui_Action.au3"
Global $h_fA_lvAction
Func __Test__()
Local $sSection = ""
Local $iIndex = GetIndexListView($h_fA_lvAction)
ConsoleWrite("Index:" & $iIndex & @CRLF)
Local $iIndex_Second = 1
Switch $iIndex
	Case 0
		GetData($iIndex)
	Case 1
		GetData($iIndex)
EndSwitch
EndFunc 
Func GetData($i)
$sFilePath = "C:\Users\QuynhDam\Documents\ISN AutoIt Studio\Projects\HotShortCut\Configs\action_configs.ini"
Local $aArray = IniReadSection($sFilePath, $i)
	If Not @error Then
		For $i = 1 To $aArray[0][0]
			;MsgBox($MB_SYSTEMMODAL, "", "Key: " & $aArray[$i][0] & @CRLF & "Value: " & $aArray[$i][1])
			If StringLen($aArray[$i][1]) > 1 Then 
				$str = StringSplit($aArray[$i][1], "|")
				Switch $str[1]
					Case 3
						ConsoleWrite($str[2] & " ; "& $str[3] &   @CRLF)
					Case 4
						ConsoleWrite($str[2] & "," &  $str[3] & "," &  $str[4] & "," &  $str[5] & @CRLF)
						SetWindownState($str[2], $str[3], $str[4], $str[5])
						Sleep(100)
					Case 1
						OpenProgram_($str[2], $str[3], $str[3], $str[4] , $str[5]  , $str[6]  , $str[7]  , $str[8], $str[9] )
					Case 2
						;ConsoleWrite("2" &  @CRLF)
						;SendText($str[1] , $str[2] , $str[3] , $str[4] , $str[5], $str[6])
				EndSwitch
			EndIf
		Next
	EndIf  
EndFunc 	
		