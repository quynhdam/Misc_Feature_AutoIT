;OpenProgram_Action.au3


#cs
String represent open action:
ID,$sProgPath, $sProgTitle, $sProgText, $iRunType = $i_RUN_IF_OPEN, $bWait = False, $bIsConsole = False, $bShow = TRUE, $bCaptureOutput = False, $iWinState = @SW_RESTORE
Example:
	$sProgPath, $sProgTitle, $sProgText, 1, False, False, False, False, @SW_RESTORE = 9
#ce


Func _OpenProgram($sProgPath, $sProgTitle, $sProgText, $bRunIfOpen = True, $bWait = False, $bIsConsole = False, $bShow = TRUE, $bCaptureOutput = False,$iWinState = @SW_RESTORE)


EndFunc   ;==>_OpenProgram





