;#RequireAdmin
#include-once
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <Debug.au3>
#include <GuiTab.au3>
#include <GuiListBox.au3>
#include <Array.au3>
#include <GuiToolTip.au3>
#include <Misc.au3>
#include <WinAPIRes.au3>
#include <WinAPIError.au3>
#include <GuiSlider.au3>

#include "Util_HotKeyPicker.au3"
#include "..\Control\Global_Variable.au3"

#Region ### START Koda GUI section ### Form=koda_actiondetails.kxf
Global $Frm_NewAction = GUICreate("Tabbed Notebook Dialog", 1107, 315, 182, 114)
GUISetOnEvent($GUI_EVENT_CLOSE, "h_fNA_BtnCancClick")
Global $h_fNA_Tab = GUICtrlCreateTab(576, 6, 524, 265)
GUICtrlSetFont($h_fNA_Tab, 9, 400, 0, "Arial")
Global $h_frmNA_TabOpen = GUICtrlCreateTabItem("Open Program")
Global $h_fNA_tOpen_lbProgPath = GUICtrlCreateLabel("Program Path", 584, 41, 80, 19)
GUICtrlSetFont($h_fNA_tOpen_lbProgPath, 9, 400, 0, "Arial")
Global $h_fNA_tOpen_sProgPath = GUICtrlCreateInput("", 664, 38, 385, 23)
GUICtrlSetFont($h_fNA_tOpen_sProgPath, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tOpen_sProgPath, "Could be program's full execution path or just the command to call the program (in case of Windows 10 APP)" & @CRLF & "For example, Skype is started using start:skype")
Global $h_tOpen_BtnSearchFilePath = GUICtrlCreateButton("...", 1056, 36, 27, 25)
GUICtrlSetFont($h_tOpen_BtnSearchFilePath, 9, 400, 0, "Arial")
GUICtrlSetOnEvent($h_tOpen_BtnSearchFilePath, "h_tOpen_BtnSearchFilePathClick")
Global $h_fNA_tOpen_lbProgName = GUICtrlCreateLabel("Program Title", 584, 73, 78, 19)
GUICtrlSetFont($h_fNA_tOpen_lbProgName, 9, 400, 0, "Arial")
Global $h_fNA_tOpen_sProgName = GUICtrlCreateInput("", 664, 70, 177, 23)
GUICtrlSetFont($h_fNA_tOpen_sProgName, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tOpen_sProgName, "The text appear in title of the program you want to open, partial is enough to identify the window")
Global $h_fNA_tOpen_lbProgTxt = GUICtrlCreateLabel("Program text", 848, 73, 73, 19)
GUICtrlSetFont($h_fNA_tOpen_lbProgTxt, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tOpen_lbProgTxt, "Additional text inside the window used to better identify the window" & @CRLF & "The text could be found by using AutoIT Info Tool ")
Global $h_fNA_tOpen_sProgText = GUICtrlCreateInput("", 928, 70, 153, 23)
GUICtrlSetFont($h_fNA_tOpen_sProgText, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tOpen_sProgText, "[Optional] Default is empty" & @CRLF & "Additional text inside the window used to better identify the window" & @CRLF & "The text could be found by using AutoIT Info Tool ")
Global $h_fNA_tOpen_rdbActiveRun = GUICtrlCreateRadio("Activate if running", 664, 103, 113, 17)
GUICtrlSetState($h_fNA_tOpen_rdbActiveRun, $GUI_CHECKED)
GUICtrlSetFont($h_fNA_tOpen_rdbActiveRun, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tOpen_rdbActiveRun, "Program will be activated if already running")
Global $h_fNA_tOpen_rdbOpenNewIns = GUICtrlCreateRadio("Open new instance", 824, 103, 185, 17)
GUICtrlSetFont($h_fNA_tOpen_rdbOpenNewIns, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tOpen_rdbOpenNewIns, "Open new instance even when program is running already")
Global $h_fNA_tOpen_chkOpenWait = GUICtrlCreateCheckbox("Open and wait until program finish", 664, 127, 217, 17)
GUICtrlSetFont($h_fNA_tOpen_chkOpenWait, 9, 400, 0, "Arial")
Global $h_fNA_tOpen_chkConsole = GUICtrlCreateCheckbox("Console command", 664, 151, 129, 17)
GUICtrlSetFont($h_fNA_tOpen_chkConsole, 9, 400, 0, "Arial")
GUICtrlSetOnEvent($h_fNA_tOpen_chkConsole, "h_fNA_tOpen_chkConsoleClick")
Global $h_fNA_tOpen_chkConsoleShow = GUICtrlCreateCheckbox("Show cmd window when running", 824, 151, 233, 17)
GUICtrlSetFont($h_fNA_tOpen_chkConsoleShow, 9, 400, 0, "Arial")
GUICtrlSetState($h_fNA_tOpen_chkConsoleShow, $GUI_DISABLE)
Global $h_fNA_tOpen_chkConsoleCapt = GUICtrlCreateCheckbox("Capture command's output", 824, 175, 177, 17)
GUICtrlSetFont($h_fNA_tOpen_chkConsoleCapt, 9, 400, 0, "Arial")
GUICtrlSetState($h_fNA_tOpen_chkConsoleCapt, $GUI_DISABLE)
Global $h_fNA_tOpen_lbWinState = GUICtrlCreateLabel("Window state when open", 584, 207, 142, 19)
GUICtrlSetFont($h_fNA_tOpen_lbWinState, 9, 400, 0, "Arial")
Global $h_fNA_tOpen_cbbWinState = GUICtrlCreateCombo("", 728, 205, 105, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($h_fNA_tOpen_cbbWinState, "Restore|Maximize|Minimize", "Restore")
GUICtrlSetFont($h_fNA_tOpen_cbbWinState, 9, 400, 0, "Arial")
Global $h_frmNA_TabSendKey = GUICtrlCreateTabItem("Send Key")
Global $h_fNA_tSendK_rdbCurActive = GUICtrlCreateRadio("Send to current active window", 664, 39, 185, 17)
GUICtrlSetState($h_fNA_tSendK_rdbCurActive, $GUI_CHECKED)
GUICtrlSetFont($h_fNA_tSendK_rdbCurActive, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tSendK_rdbCurActive, "Send to current active window")
GUICtrlSetOnEvent($h_fNA_tSendK_rdbCurActive, "h_fNA_tSendK_rdbCurActiveClick")
Global $h_fNA_tSendK_rdbSpecificWnd = GUICtrlCreateRadio("Send to a specific window", 856, 39, 177, 17)
GUICtrlSetFont($h_fNA_tSendK_rdbSpecificWnd, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tSendK_rdbSpecificWnd, "Send to a specific window based on its title name")
GUICtrlSetOnEvent($h_fNA_tSendK_rdbSpecificWnd, "h_fNA_tSendK_rdbSpecificWndClick")
Global $h_fNA_tSendK_sText2Send = GUICtrlCreateInput("", 664, 87, 425, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tSendK_sText2Send, 9, 400, 0, "Arial")
GUICtrlSetOnEvent($h_fNA_tSendK_sText2Send, "h_fNA_tSendK_sText2SendChange")
GUICtrlSetTip($h_fNA_tSendK_sText2Send, "Could be KeyStroke or clear text, or full path of the file that contains text (need to check the 'Send text stored in file' option)" & @CRLF & "Keystroke Example:" & @CRLF & @TAB & "Ctrl+Alt+F" & @CRLF & @TAB & "Alt+K" & @CRLF  & @TAB & "Win+1" & @CRLF & "Path examples: "& @CRLF  & @TAB & "C:\mytext.txt" & @CRLF  & "Text examples:"& @CRLF  & @TAB & "Blah blah blah" & "")
Global $h_fNA_tSendK_lbTextToSend = GUICtrlCreateLabel("Text to send", 584, 89, 70, 19)
GUICtrlSetFont($h_fNA_tSendK_lbTextToSend, 9, 400, 0, "Arial")
Global $h_fNA_tSendK_lbProgTitle = GUICtrlCreateLabel("Program Title", 584, 121, 78, 19)
GUICtrlSetFont($h_fNA_tSendK_lbProgTitle, 9, 400, 0, "Arial")
GUICtrlSetState($h_fNA_tSendK_lbProgTitle, $GUI_HIDE)
Global $h_fNA_tSendK_chkRaw = GUICtrlCreateCheckbox("Send raw", 1008, 63, 81, 17)
GUICtrlSetFont($h_fNA_tSendK_chkRaw, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tSendK_chkRaw, "The raw text will be sent, not translated to KeyStroke")
GUICtrlSetOnEvent($h_fNA_tSendK_chkRaw, "h_fNA_tSendK_chkRawClick")
Global $h_fNA_tSendK_chkTxt_inFile = GUICtrlCreateCheckbox("Send text stored in file", 664, 63, 137, 17)
GUICtrlSetFont($h_fNA_tSendK_chkTxt_inFile, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tSendK_chkTxt_inFile, "If this option is checked, the text to send will be the full path of file content")
GUICtrlSetOnEvent($h_fNA_tSendK_chkTxt_inFile, "h_fNA_tSendK_chkTxt_inFileClick")
Global $h_fNA_tSendK_sProg2Send = GUICtrlCreateInput("", 664, 119, 425, 23)
GUICtrlSetFont($h_fNA_tSendK_sProg2Send, 9, 400, 0, "Arial")
GUICtrlSetState($h_fNA_tSendK_sProg2Send, $GUI_HIDE)
GUICtrlSetTip($h_fNA_tSendK_sProg2Send, "The window title (or window hanler) of the program you want to send the text to" & @CRLF & "If this field is blank, the window will be specified follow this order:" & @CRLF & "1. If there is already a window defined in the previous action, that window will be picked" & @CRLF &"2. Current active window")
Global $h_fNA_tSendK_chkKeyStrokes = GUICtrlCreateCheckbox("Send keystrockes", 856, 63, 113, 17)
GUICtrlSetFont($h_fNA_tSendK_chkKeyStrokes, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tSendK_chkKeyStrokes, "A key strokes combines of Ctrl, Shift, Alt and one normal key")
GUICtrlSetOnEvent($h_fNA_tSendK_chkKeyStrokes, "h_fNA_tSendK_chkKeyStrokesClick")
Global $h_frmNA_TabSendClick = GUICtrlCreateTabItem("Send Click")
Global $Label1 = GUICtrlCreateLabel("Window Title", 584, 41, 74, 19)
GUICtrlSetFont($Label1, 9, 400, 0, "Arial")
Global $h_fNA_tClick_sWnd = GUICtrlCreateInput("", 664, 39, 177, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_sWnd, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_sWnd, "If no name is specified, the current active window is picked")
Global $Label2 = GUICtrlCreateLabel("X coordinate", 584, 73, 72, 19)
GUICtrlSetFont($Label2, 9, 400, 0, "Arial")
Global $h_fNA_tClick_sWndText = GUICtrlCreateInput("", 880, 39, 209, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_sWndText, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_sWndText, "If no name is specified, the current active window is picked")
Global $Label3 = GUICtrlCreateLabel("Y coordinate", 584, 105, 72, 19)
GUICtrlSetFont($Label3, 9, 400, 0, "Arial")
Global $h_fNA_tClick_iX = GUICtrlCreateInput("", 664, 71, 113, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_iX, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_iX, "If no name is specified, the current active window is picked")
Global $h_fNA_tClick_iY = GUICtrlCreateInput("", 664, 103, 113, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_iY, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_iY, "If no name is specified, the current active window is picked")
Global $h_fNA_tClick_chkScreenCoor = GUICtrlCreateCheckbox("Screen's coordinate", 792, 74, 145, 17)
GUICtrlSetFont($h_fNA_tClick_chkScreenCoor, 9, 400, 0, "Arial")
Global $h_fNA_tClick_btnSearchWnd = GUICtrlCreateButton("", 787, 102, 27, 25, $BS_ICON)
GUICtrlSetImage($h_fNA_tClick_btnSearchWnd, "C:\Windows\System32\shell32.dll", -57, 0)
GUICtrlSetFont($h_fNA_tClick_btnSearchWnd, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_btnSearchWnd, "Find window by clicking on it")
GUICtrlSetOnEvent($h_fNA_tClick_btnSearchWnd, "h_fNA_tClick_btnSearchWndClick")
Global $Label4 = GUICtrlCreateLabel("Mouse", 616, 137, 41, 19)
GUICtrlSetFont($Label4, 9, 400, 0, "Arial")
Global $h_fNA_tClick_cbbMouseBtn = GUICtrlCreateCombo("MOUSE_CLICK_PRIMARY", 664, 135, 177, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($h_fNA_tClick_cbbMouseBtn, "MOUSE_CLICK_LEFT|MOUSE_CLICK_RIGHT|MOUSE_CLICK_MIDDLE|MOUSE_CLICK_MAIN|MOUSE_CLICK_MENU|MOUSE_CLICK_PRIMARY|MOUSE_CLICK_SECONDARY")
GUICtrlSetFont($h_fNA_tClick_cbbMouseBtn, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_cbbMouseBtn, "If the user has swapped the left and right mouse buttons in the control panel, 'Left' and 'right' always click those buttons," & @CRLF & "whether the buttons are swapped or not." & @CRLF & "The 'primary' or 'main' button will be the main click, whether or not the buttons are swapped."& @CRLF & "The 'secondary' or 'menu' buttons will usually bring up the context menu, whether the buttons are swapped or not.")
Global $Label5 = GUICtrlCreateLabel("Click", 864, 137, 31, 19)
GUICtrlSetFont($Label5, 9, 400, 0, "Arial")
Global $h_fNA_tClick_iClickCount = GUICtrlCreateInput("1", 904, 135, 33, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_iClickCount, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_iClickCount, "If no name is specified, the current active window is picked")
Global $Label7 = GUICtrlCreateLabel("Speed", 1000, 137, 40, 19)
GUICtrlSetFont($Label7, 9, 400, 0, "Arial")
Global $h_fNA_tClick_iTimeBetweenClicks = GUICtrlCreateInput("10", 1041, 135, 25, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_iTimeBetweenClicks, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_iTimeBetweenClicks, "Time between to consecutive clicks")
Global $Label8 = GUICtrlCreateLabel("time(s)", 944, 137, 43, 19)
GUICtrlSetFont($Label8, 9, 400, 0, "Arial")
Global $Label9 = GUICtrlCreateLabel("ms", 1072, 137, 22, 19)
GUICtrlSetFont($Label9, 9, 400, 0, "Arial")
Global $Label10 = GUICtrlCreateLabel("Text", 848, 41, 26, 19)
GUICtrlSetFont($Label10, 9, 400, 0, "Arial")
Global $Label11 = GUICtrlCreateLabel("Control ID", 597, 169, 59, 19)
GUICtrlSetFont($Label11, 9, 400, 0, "Arial")
Global $h_fNA_tClick_sControl = GUICtrlCreateInput("", 664, 167, 257, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_sControl, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_sControl, "Control ID of the control under cursor","Experimenting - Optional")
Global $Label12 = GUICtrlCreateLabel("Control X", 600, 201, 54, 19)
GUICtrlSetFont($Label12, 9, 400, 0, "Arial")
Global $h_fNA_tClick_iCtrlX = GUICtrlCreateInput("", 664, 199, 113, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_iCtrlX, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_iCtrlX, "Control X coordinate to click","Optional")
Global $Label13 = GUICtrlCreateLabel("Control Y", 600, 233, 54, 19)
GUICtrlSetFont($Label13, 9, 400, 0, "Arial")
Global $h_fNA_tClick_iCtrlY = GUICtrlCreateInput("", 664, 231, 113, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tClick_iCtrlY, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tClick_iCtrlY, "Control Y coordinate to click","Optional")
Global $h_frmNA_TabSetWndState = GUICtrlCreateTabItem("Set Window State")
GUICtrlSetState($h_frmNA_TabSetWndState,$GUI_SHOW)
Global $h_fNA_tWinState_sProgName = GUICtrlCreateInput("", 664, 39, 185, 23)
GUICtrlSetFont($h_fNA_tWinState_sProgName, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tWinState_sProgName, "The window title (or window hanler) of the program you want to send the text to" & @CRLF & "If this field is blank, the window will be specified follow this order:" & @CRLF & "1. If there is already a window defined in the previous action, that window will be picked" & @CRLF &"2. Current active window")
Global $h_fNA_tWinState_sProgText = GUICtrlCreateInput("", 896, 39, 193, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_AUTOVSCROLL,$ES_NOHIDESEL))
GUICtrlSetFont($h_fNA_tWinState_sProgText, 9, 400, 0, "Arial")
GUICtrlSetTip($h_fNA_tWinState_sProgText, "If no name is specified, the current active window is picked")
Global $h_fNA_tWinState_rdbShow = GUICtrlCreateRadio("Show", 672, 71, 57, 17)
GUICtrlSetState($h_fNA_tWinState_rdbShow, $GUI_CHECKED)
GUICtrlSetFont($h_fNA_tWinState_rdbShow, 9, 400, 0, "Arial")
Global $h_fNA_tWinState_rdbMaximize = GUICtrlCreateRadio("Maximize", 736, 71, 73, 17)
GUICtrlSetFont($h_fNA_tWinState_rdbMaximize, 9, 400, 0, "Arial")
Global $h_fNA_tWinState_rdbMinimize = GUICtrlCreateRadio("Minimize", 824, 71, 73, 17)
GUICtrlSetFont($h_fNA_tWinState_rdbMinimize, 9, 400, 0, "Arial")
Global $h_fNA_tWinState_rdbHide = GUICtrlCreateRadio("Hide", 904, 71, 49, 17)
GUICtrlSetFont($h_fNA_tWinState_rdbHide, 9, 400, 0, "Arial")
Global $Label6 = GUICtrlCreateLabel("Program Title", 584, 41, 78, 19)
GUICtrlSetFont($Label6, 9, 400, 0, "Arial")
Global $Label14 = GUICtrlCreateLabel("Transparency", 584, 96, 79, 19)
GUICtrlSetFont($Label14, 9, 400, 0, "Arial")
Global $h_fNA_tWinState_TransparentSlider = GUICtrlCreateSlider(664, 96, 198, 29)
GUICtrlSetLimit($h_fNA_tWinState_TransparentSlider, 255, 0)
GUICtrlSetData($h_fNA_tWinState_TransparentSlider, 255)
GUICtrlSetOnEvent($h_fNA_tWinState_TransparentSlider, "h_fNA_tWinState_TransparentSliderChange")
Global $h_fNA_tWinState_iTransparentValue = GUICtrlCreateInput("255", 864, 96, 33, 23)
GUICtrlSetFont($h_fNA_tWinState_iTransparentValue, 9, 400, 0, "Arial")
GUICtrlSetOnEvent($h_fNA_tWinState_iTransparentValue, "h_fNA_tWinState_iTransparentValueChange")
Global $h_fNA_tWinState_TransparentTestBtn = GUICtrlCreateButton("Test", 920, 95, 43, 25)
GUICtrlSetFont($h_fNA_tWinState_TransparentTestBtn, 9, 400, 0, "Arial")
GUICtrlSetOnEvent($h_fNA_tWinState_TransparentTestBtn, "h_fNA_tWinState_TransparentTestBtnClick")
Global $Label16 = GUICtrlCreateLabel("Text", 864, 41, 26, 19)
GUICtrlSetFont($Label16, 9, 400, 0, "Arial")
Global $h_frmNA_TabMisc = GUICtrlCreateTabItem("Misc")
Global $Label15 = GUICtrlCreateLabel("Delay", 612, 39, 35, 19)
GUICtrlSetFont($Label15, 9, 400, 0, "Arial")
Global $h_fNA_tMisc_iDelay = GUICtrlCreateInput("", 656, 36, 73, 23)
GUICtrlSetFont($h_fNA_tMisc_iDelay, 9, 400, 0, "Arial")
Global $Combo1 = GUICtrlCreateCombo("second(s)", 736, 36, 105, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($Combo1, "milisecond(s)|second(s)|minute(s)|hour(s)")
GUICtrlSetFont($Combo1, 9, 400, 0, "Arial")
GUICtrlCreateTabItem("")
Global $h_fNA_BtnAdd = GUICtrlCreateButton("Add", 758, 278, 75, 25)
GUICtrlSetOnEvent($h_fNA_BtnAdd, "h_fNA_BtnAddClick")
Global $h_fNA_BtnApply = GUICtrlCreateButton("Update", 846, 278, 75, 25)
GUICtrlSetOnEvent($h_fNA_BtnApply, "h_fNA_BtnApplyClick")
Global $h_fNA_BtnCanc = GUICtrlCreateButton("&Cancel", 1024, 278, 75, 25)
GUICtrlSetOnEvent($h_fNA_BtnCanc, "h_fNA_BtnCancClick")
Global $h_fNA_BtnActionUp = GUICtrlCreateButton("Up", 528, 56, 40, 25, $BS_ICON)
GUICtrlSetImage($h_fNA_BtnActionUp, "C:\Windows\System32\shell32.dll", -247, 0)
GUICtrlSetOnEvent($h_fNA_BtnActionUp, "h_fNA_BtnActionUpClick")
Global $h_fNA_BtnActionDown = GUICtrlCreateButton("Down", 528, 88, 40, 25, $BS_ICON)
GUICtrlSetImage($h_fNA_BtnActionDown, "C:\Windows\System32\shell32.dll", -248, 0)
GUICtrlSetOnEvent($h_fNA_BtnActionDown, "h_fNA_BtnActionDownClick")
Global $h_fNA_BtnActionDelete = GUICtrlCreateButton("Delete", 528, 120, 40, 25, $BS_ICON)
GUICtrlSetImage($h_fNA_BtnActionDelete, "C:\Windows\System32\shell32.dll", -132, 0)
GUICtrlSetOnEvent($h_fNA_BtnActionDelete, "h_fNA_BtnDeleteClick")
Global $h_fNA_ActionList = GUICtrlCreateList("", 8, 8, 513, 260, BitOR($LBS_NOTIFY,$WS_HSCROLL,$WS_VSCROLL), 0)
GUICtrlSetOnEvent($h_fNA_ActionList, "h_fNA_ActionListClick")
Global $h_fNA_BtnDelete = GUICtrlCreateButton("Delete", 935, 278, 75, 25)
GUICtrlSetOnEvent($h_fNA_BtnDelete, "h_fNA_BtnDeleteClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUISetState(@SW_HIDE)
Local Enum $i_TAB_OPEN, _
		$i_TAB_SEND_KEY, _
		$i_TAB_SEND_CLICK, _
		$i_TAB_SET_STATE, _
		$i_TAB_MICS

Local $a_fNA_ActionDetail[1][2]
Local $i_fNA_ListAction_curIdx = -1
Local $b_fNA_tClick_Capture = False
Global $s_fNA_ActionID = ""

_frm_NewAction_Initialize()
;_ParseAction("1|E:\SelfStudy\AutoIT\ISN_AutoIT_Studio\Projects\ScreenPreview\ScreenPreview_x64.exe|ScreenPreview_x64|Hhihi|True|True|True|True|False|9", False)

;~ While 1
;~ 	Sleep(100)
;~ WEnd


#Region Form-Level actions
Func _frm_NewAction_Initialize($sActionID = "")
	;If not initialized, then ONLY this form is opened (just for testing)
	If $sActionID = "" Then
		$s_fNA_ActionID = "0"
		$a_fNA_ActionDetail[0][0] = 0
		$a_fNA_ActionDetail[0][1] = ""
		Local $iIndex, $sData
		$iIndex = _GUICtrlListBox_GetCurSel($h_fNA_ActionList)
		If $iIndex < 0 Then
			GUICtrlSetState($h_fNA_BtnDelete, $GUI_DISABLE)
			GUICtrlSetState($h_fNA_BtnApply, $GUI_DISABLE)
		EndIf
	Else
		;The form is initialized with parameter
		Local $aTmp = _Util_ReadActionDetails($sActionID)
		$s_fNA_ActionID = $sActionID ; Copy actionID
		_Info("_frm_NewAction_Initialize() ActionID = " & $sActionID & @CRLF)
		If (IsArray($aTmp)) Then
			
			$a_fNA_ActionDetail = 0
			$a_fNA_ActionDetail = $aTmp
			$aTmp = 0

			GUICtrlSetData($h_fNA_ActionList, "") ;Clear current List

			_GUICtrlListBox_BeginUpdate($h_fNA_ActionList)
			For $i = 1 To $a_fNA_ActionDetail[0][0] Step +1
				$a_fNA_ActionDetail[$i][0] = _ParseAction($a_fNA_ActionDetail[$i][1]) ;Generate string
				_GUICtrlListBox_AddString($h_fNA_ActionList, $a_fNA_ActionDetail[$i][0]) ;Add string to list box
			Next
			_GUICtrlListBox_SetCurSel($h_fNA_ActionList, 0)
			_GUICtrlListBox_UpdateHScroll($h_fNA_ActionList)
			_GUICtrlListBox_EndUpdate($h_fNA_ActionList)
			$i_fNA_ListAction_curIdx = 0
			h_fNA_ActionListClick()
		Else
;~ _Error("_frm_NewAction_Initialize: Not an array - Line " & @ScriptLineNumber & @CRLF)
		EndIf
	EndIf
EndFunc   ;==>_frm_NewAction_Initialize

Func h_fNA_ActionListClick()
	Local $iIndex, $sData
	$iIndex = _GUICtrlListBox_GetCurSel($h_fNA_ActionList)

	If $iIndex >= 0 Then
		If $i_fNA_ListAction_curIdx <> $iIndex Then
			If BitAND(GUICtrlGetState($h_fNA_BtnDelete), $GUI_DISABLE) Then GUICtrlSetState($h_fNA_BtnDelete, $GUI_ENABLE)
			If BitAND(GUICtrlGetState($h_fNA_BtnApply), $GUI_DISABLE) Then GUICtrlSetState($h_fNA_BtnApply, $GUI_ENABLE)
			ConsoleWrite("h_fNA_ActionListClick, $iIndex=" & $iIndex & " Data = " & $a_fNA_ActionDetail[$iIndex + 1][1] & @CRLF)
			_ParseAction($a_fNA_ActionDetail[$iIndex + 1][1], 1)
			$i_fNA_ListAction_curIdx = $iIndex
		EndIf
	EndIf
EndFunc   ;==>h_fNA_ActionListClick


Func h_fNA_BtnAddClick()
	Local $sTmp, $iActionCount = $a_fNA_ActionDetail[0][0]
	$sTmp = _Read_CurrentTab_Data()

	ReDim $a_fNA_ActionDetail[$iActionCount + 2][2]
	$iActionCount += 1
	$a_fNA_ActionDetail[0][0] = $iActionCount
	$a_fNA_ActionDetail[$iActionCount][0] = _ParseAction($sTmp)
	$a_fNA_ActionDetail[$iActionCount][1] = $sTmp

	_GUICtrlListBox_BeginUpdate($h_fNA_ActionList)
	_GUICtrlListBox_AddString($h_fNA_ActionList, $a_fNA_ActionDetail[$iActionCount][0])
	_GUICtrlListBox_UpdateHScroll($h_fNA_ActionList)
	_GUICtrlListBox_SetCurSel($h_fNA_ActionList, $iActionCount - 1)
	_GUICtrlListBox_EndUpdate($h_fNA_ActionList)
	$i_fNA_ListAction_curIdx = $iActionCount - 1
	h_fNA_ActionListClick()
	
	;Save to configuration
	ConsoleWrite("iAction = " & $iActionCount & " ID = " & $s_fNA_ActionID & @CRLF)
	_Util_IniWrite($_g_c_sActionConfigPath, $s_fNA_ActionID, "" & $iActionCount, $sTmp)
	_Util_IniWrite($_g_c_sActionConfigPath, $s_fNA_ActionID, $_g_conf_sActionCount, $iActionCount)
EndFunc   ;==>h_fNA_BtnAddClick

Func h_fNA_BtnApplyClick()
	Local $sTmp
	$sTmp = _Read_CurrentTab_Data()
	$a_fNA_ActionDetail[$i_fNA_ListAction_curIdx + 1][0] = _ParseAction($sTmp)
	$a_fNA_ActionDetail[$i_fNA_ListAction_curIdx + 1][1] = $sTmp

	_Info("Old string: " & _GUICtrlListBox_GetText($h_fNA_ActionList, $i_fNA_ListAction_curIdx) _
			 & @CRLF & "New strig: " & $a_fNA_ActionDetail[$i_fNA_ListAction_curIdx + 1][0] & @CRLF & "idx=" & $i_fNA_ListAction_curIdx & @CRLF)
	_GUICtrlListBox_ReplaceString($h_fNA_ActionList, $i_fNA_ListAction_curIdx, $a_fNA_ActionDetail[$i_fNA_ListAction_curIdx + 1][0])
	_GUICtrlListBox_BeginUpdate($h_fNA_ActionList)

	_GUICtrlListBox_UpdateHScroll($h_fNA_ActionList)
	_GUICtrlListBox_SetCurSel($h_fNA_ActionList, $i_fNA_ListAction_curIdx)
	_GUICtrlListBox_EndUpdate($h_fNA_ActionList)

	$iTmp = _GUICtrlListBox_GetCurSel($h_fNA_ActionList)
	If $iTmp < 0 Then
		GUICtrlSetState($h_fNA_BtnApply, $GUI_DISABLE)
	Else
		$i_fNA_ListAction_curIdx = $iTmp
	EndIf
	_Util_IniWrite($_g_c_sActionConfigPath, $s_fNA_ActionID, ($i_fNA_ListAction_curIdx + 1) & "", $sTmp) ; Update ini file
	h_fNA_ActionListClick()
EndFunc   ;==>h_fNA_BtnApplyClick

Func h_fNA_BtnDeleteClick()
	Local $iIndex, $sData
	$iIndex = _GUICtrlListBox_GetCurSel($h_fNA_ActionList)
	If $iIndex >= 0 Then
		;MsgBox features: Title=Yes, Text=Yes, Buttons=Yes and No, Default Button=Second, Icon=Question
		If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
		$iMsgBoxAnswer = MsgBox(292, "Information", "Are you sure you want to delete this item?")
		Select
			Case $iMsgBoxAnswer = 6 ;Yes
				_GUICtrlListBox_DeleteString($h_fNA_ActionList, $iIndex);Delete in GUI
				_ArrayDelete($a_fNA_ActionDetail, $iIndex + 1);Delete array
				$a_fNA_ActionDetail[0][0] -= 1 ;Update number in array

				;Update configuration files
				For $i = $iIndex + 1 To $a_fNA_ActionDetail[0][0]
					_Util_IniWrite($_g_c_sActionConfigPath, $s_fNA_ActionID, ($i) & "", $a_fNA_ActionDetail[$i][1])
				Next
				_Util_IniDelete($_g_c_sActionConfigPath, $s_fNA_ActionID, ($a_fNA_ActionDetail[0][0]+1) & "")
				_Util_IniWrite($_g_c_sActionConfigPath, $s_fNA_ActionID, $_g_conf_sActionCount, $a_fNA_ActionDetail[0][0])
				
			Case $iMsgBoxAnswer = 7 ;No

		EndSelect
	EndIf
EndFunc   ;==>h_fNA_BtnDeleteClick

Func h_fNA_BtnCancClick()
	GUISetState(@SW_HIDE, $Frm_NewAction)
	GUISetState(@SW_ENABLE, $actionForm)
	WinActivate($actionForm)
EndFunc   ;==>h_fNA_BtnCancClick

Func h_fNA_BtnActionUpClick()
	_moveListItem(-1)
EndFunc   ;==>h_fNA_BtnActionUpClick

Func h_fNA_BtnActionDownClick()
	_moveListItem(1)
EndFunc   ;==>h_fNA_BtnActionDownClick


Func _moveListItem($iStep = -1)
	Local $iPos = _GUICtrlListBox_GetCurSel($h_fNA_ActionList) ; 0-based
	If ($iStep = -1 And $iPos > 0) Or ($iStep = 1 And $iPos < _GUICtrlListBox_GetCount($h_fNA_ActionList) - 1) Then
		_Info(($iStep = 1 ? "Down" : "Up") & @CRLF)
		Local $sText, $sData
		_GUICtrlListBox_BeginUpdate($h_fNA_ActionList)
		;Copy old data
		$sDisplayText = $a_fNA_ActionDetail[$iPos + 1 + $iStep][0] ;Action[0][0] is count, index start from 1
		$sData = $a_fNA_ActionDetail[$iPos + 1 + $iStep][1]
		_Info("text:" & $sDisplayText & @CRLF & "Data:" & $sData & @CRLF)

		;Overide
		$a_fNA_ActionDetail[$iPos + 1 + $iStep][1] = $a_fNA_ActionDetail[$iPos + 1][1]
		$a_fNA_ActionDetail[$iPos + 1 + $iStep][0] = $a_fNA_ActionDetail[$iPos + 1][0]
		_GUICtrlListBox_ReplaceString($h_fNA_ActionList, $iPos + $iStep, $a_fNA_ActionDetail[$iPos + 1][0])

		$a_fNA_ActionDetail[$iPos + 1][0] = $sDisplayText
		$a_fNA_ActionDetail[$iPos + 1][1] = $sData
		_GUICtrlListBox_ReplaceString($h_fNA_ActionList, $iPos, $sDisplayText)
		_GUICtrlListBox_SetCurSel($h_fNA_ActionList, $iPos + $iStep)
		_GUICtrlListBox_EndUpdate($h_fNA_ActionList)
		$i_fNA_ListAction_curIdx = $iPos + $iStep
		;_DebugArrayDisplay($a_fNA_ActionDetail, $iStep = 1 ? "Down" : "Up")
		_saveAction()
	EndIf

EndFunc   ;==>_moveListItem

Func _saveAction($sAction = "")

EndFunc   ;==>_saveAction
#EndRegion Form-Level actions

#Region Tab Windows State
Func h_fNA_tWinState_TransparentTestBtnClick()
	ConsoleWrite("Trans test click" & @CRLF)
	Local $sProgName = "", $sProgText = "", $iState = 0, $iTransparent = 0
	$sProgName = GUICtrlRead($h_fNA_tWinState_sProgName)
	$sProgText = GUICtrlRead($h_fNA_tWinState_sProgText)
	$iTransparent = Int(GUICtrlRead($h_fNA_tWinState_iTransparentValue))
	Local $curMode = Opt("WinTitleMatchMode")
	Opt("WinTitleMatchMode", 2)
	ConsoleWrite("Checking handle of Program " & $sProgName & " " & $sProgText & @CRLF)
	Local $hWnd = WinGetHandle($sProgName, $sProgText)
	If IsHWnd($hWnd) Then
		$ret = WinSetTrans($hWnd, "", $iTransparent)
		If $ret = 0 Then _Error("WinSetTrans failed")
	Else
		_Error("h_fNA_tWinState_TransparentTestBtnClick => Not win handle")
	EndIf
	Opt("WinTitleMatchMode", $curMode)

EndFunc   ;==>h_fNA_tWinState_TransparentTestBtnClick

Func _fNA_tWinState_getWinState()
	If GUICtrlRead($h_fNA_tWinState_rdbShow) = $GUI_CHECKED Then Return @SW_SHOW
	If GUICtrlRead($h_fNA_tWinState_rdbMaximize) = $GUI_CHECKED Then Return @SW_MAXIMIZE
	If GUICtrlRead($h_fNA_tWinState_rdbMinimize) = $GUI_CHECKED Then Return @SW_MINIMIZE
	If GUICtrlRead($h_fNA_tWinState_rdbHide) = $GUI_CHECKED Then Return @SW_HIDE
EndFunc   ;==>_fNA_tWinState_getWinState

Func h_fNA_tWinState_TransparentSliderChange()
	Local $iData = GUICtrlRead($h_fNA_tWinState_TransparentSlider)
	GUICtrlSetData($h_fNA_tWinState_iTransparentValue, $iData)

EndFunc   ;==>h_fNA_tWinState_TransparentSliderChange

Func h_fNA_tWinState_iTransparentValueChange()
	Local $iData = GUICtrlRead($h_fNA_tWinState_iTransparentValue)

	If $iData > _GUICtrlSlider_GetRangeMax($h_fNA_tWinState_TransparentSlider) Then $iData = 255
	If $iData < _GUICtrlSlider_GetRangeMin($h_fNA_tWinState_TransparentSlider) Then $iData = 0
	GUICtrlSetData($h_fNA_tWinState_TransparentSlider, $iData)
	GUICtrlSetData($h_fNA_tWinState_iTransparentValue, $iData)
EndFunc   ;==>h_fNA_tWinState_iTransparentValueChange
#EndRegion Tab Windows State

#Region Tab Send Click
Func h_fNA_tClick_btnSearchWndClick()
	_h_fNA_tClick_StartGetMouse()
EndFunc   ;==>h_fNA_tClick_btnSearchWndClick

Func _h_fNA_tClick_StartGetMouse()
	;_Trace("-->_h_fNA_tClick_StartGetMouse: $b_fNA_tClick_Capture = " & $b_fNA_tClick_Capture & @CRLF)
	Local $sClickHotKey = "{ENTER}"
	If $b_fNA_tClick_Capture = False Then
		$b_fNA_tClick_Capture = True
		HotKeySet($sClickHotKey, "_h_fNA_tClick_StartGetMouse") ;When the function is recall, value of $b_fNA_tClick_Capture will be changed

		Local $hPos, $hCurWnd, $sCurTitle, $sCurText, $iToolX, $iToolY, $bWinPos, $aWinPos, $iLastX = 0, $iLastY = 0, $aControl
		Local $hAutoITWin = WinGetHandle("[active]")

		GUICtrlSetState($h_fNA_tClick_btnSearchWnd, $GUI_DISABLE) ;Disable button until finish

		If GUICtrlRead($h_fNA_tClick_chkScreenCoor) = $GUI_CHECKED Then
			;Use screen's coordinate
			Opt("MouseCoordMode", 1)
			$bWinPos = False
		Else
			;Use window's coordinate
			Opt("MouseCoordMode", 0)
			$bWinPos = True
		EndIf

		While $b_fNA_tClick_Capture = True
			$hPos = MouseGetPos()
			GUICtrlSetData($h_fNA_tClick_iX, $hPos[0])
			GUICtrlSetData($h_fNA_tClick_iY, $hPos[1])
			$hCurWnd = WinGetHandle("[ACTIVE]")

			If IsHWnd($hCurWnd) Then ;If this is a window
				$sCurTitle = WinGetTitle($hCurWnd)
				$sCurText = WinGetText($hCurWnd)

				;Calculate tooltip's position
				If $bWinPos Then
					$aWinPos = WinGetPos($hCurWnd)
					$iToolX = $hPos[0] + $aWinPos[0]
					$iToolY = $hPos[1] + $aWinPos[1]
				Else
					$iToolX = $hPos[0]
					$iToolY = $hPos[1]
				EndIf

				;If active window changed (compare text)
				If (StringCompare(GUICtrlRead($h_fNA_tClick_sWnd), $sCurTitle)) <> 0 Then
					$sCurTitle = StringReplace($sCurTitle, @LF, "")
					$sCurTitle = StringReplace($sCurTitle, @CR, "")
					GUICtrlSetData($h_fNA_tClick_sWnd, $sCurTitle)
					GUICtrlSetData($h_fNA_tClick_sWndText, $sCurText)
					;$sCurTitle =
				EndIf

				;Update control ID under cursor
				$aControl = GUIGetCursorInfo($hCurWnd)
				If IsArray($aControl) Then GUICtrlSetData($h_fNA_tClick_sControl, $aControl[4])

			EndIf

			;If mouse moved then update tooltip
			If $iLastX <> $hPos[0] Or $iLastY <> $hPos[1] Then
				ToolTip(StringFormat("X = %d, Y = %d" & @CRLF & "Click to destination coordinate in the destination window, then" & _
						"press ENTER to stop", $hPos[0], $hPos[1]), $iToolX, $iToolY, "Current position")
				$iLastX = $hPos[0]
				$iLastY = $hPos[1]
			EndIf
			Sleep(50)
		WEnd

		;Some times the text inside the window is very long lines, only get the 1st line (configuration file ini doesn't allow multiple line)
		$sCurText = StringStripCR($sCurText)
		$sCurText = StringReplace($sCurText,@LF,"")
		$sCurText = StringReplace($sCurText,@CRLF,"")
		$sCurText = StringLeft($sCurText, 40) ;Only allow 40 character max
		GUICtrlSetTip($h_fNA_tClick_sWndText, $sCurText)
		GUICtrlSetData($h_fNA_tClick_sWndText, $sCurText)

		WinActivate($hAutoITWin) ;re-activate autoit window
		Opt("MouseCoordMode", Default) ;Restore mouse coordinate mode

	Else
		GUICtrlSetState($h_fNA_tClick_btnSearchWnd, $GUI_ENABLE)
		$b_fNA_tClick_Capture = False
		ToolTip("")
		HotKeySet($sClickHotKey)
	EndIf
	_Trace("!<--- _h_fNA_tClick_StartGetMouse: $b_fNA_tClick_Capture = " & $b_fNA_tClick_Capture & @CRLF)
EndFunc   ;==>_h_fNA_tClick_StartGetMouse


#EndRegion Tab Send Click

#Region Tab Open Program

Func h_fNA_tOpen_chkConsoleClick()

	If GUICtrlRead($h_fNA_tOpen_chkConsole) = $GUI_CHECKED Then
		GUICtrlSetState($h_fNA_tOpen_chkConsoleShow, $GUI_ENABLE)
		GUICtrlSetState($h_fNA_tOpen_chkConsoleCapt, $GUI_ENABLE)

		;WinState label & Combobox
		GUICtrlSetState($h_fNA_tOpen_lbWinState, $GUI_DISABLE)
		GUICtrlSetState($h_fNA_tOpen_cbbWinState, $GUI_DISABLE)

	ElseIf GUICtrlRead($h_fNA_tOpen_chkConsole) = $GUI_UNCHECKED Then

		GUICtrlSetState($h_fNA_tOpen_chkConsoleShow, $GUI_DISABLE)
		GUICtrlSetState($h_fNA_tOpen_chkConsoleCapt, $GUI_DISABLE)

		GUICtrlSetState($h_fNA_tOpen_chkConsoleShow, $GUI_UNCHECKED)
		GUICtrlSetState($h_fNA_tOpen_chkConsoleCapt, $GUI_UNCHECKED)

		;WinState label & combobox
		GUICtrlSetState($h_fNA_tOpen_lbWinState, $GUI_ENABLE)
		GUICtrlSetState($h_fNA_tOpen_cbbWinState, $GUI_ENABLE)
	EndIf
EndFunc   ;==>h_fNA_tOpen_chkConsoleClick


Func h_tOpen_BtnSearchFilePathClick()
	Local $sPath = FileOpenDialog("", "", "Executable (*.exe)")
	GUICtrlSetData($h_fNA_tOpen_sProgPath, $sPath)

	Local $iDelimiter = StringInStr($sPath, "\", 0, -1)
	If $iDelimiter = 0 Then $iDelimiter = StringInStr($sPath, "/", 0, -1)
	If $iDelimiter = 0 Then $iDelimiter = StringInStr($sPath, ":", 0, -1)
	If $iDelimiter = 0 Then
		GUICtrlSetData($h_fNA_tOpen_sProgName, $sPath)
	Else
		If StringInStr($sPath, ".exe") > 0 Then
			$sPath = StringRight($sPath, StringLen($sPath) - $iDelimiter)
			Local $sProgName = StringSplit($sPath, ".")[1]
			GUICtrlSetData($h_fNA_tOpen_sProgName, $sProgName)
		EndIf
	EndIf
EndFunc   ;==>h_tOpen_BtnSearchFilePathClick


#EndRegion Tab Open Program

#Region Tab Send Key
Func h_fNA_tSendK_chkRawClick()
	If GUICtrlRead($h_fNA_tSendK_chkRaw) = $GUI_CHECKED Then
		If GUICtrlRead($h_fNA_tSendK_chkKeyStrokes) = $GUI_CHECKED Then
			GUICtrlSetState($h_fNA_tSendK_chkKeyStrokes, $GUI_UNCHECKED)
		EndIf
	EndIf

EndFunc   ;==>h_fNA_tSendK_chkRawClick

Func h_fNA_tSendK_chkKeyStrokesClick()
	If GUICtrlRead($h_fNA_tSendK_chkKeyStrokes) = $GUI_CHECKED Then
		_get_HotKey_GUI($Frm_NewAction, $h_fNA_tSendK_sText2Send)
		If GUICtrlRead($h_fNA_tSendK_chkKeyStrokes) = $GUI_CHECKED Then
			If GUICtrlRead($h_fNA_tSendK_chkRaw) = $GUI_CHECKED Then
				GUICtrlSetState($h_fNA_tSendK_chkRaw, $GUI_UNCHECKED)
			EndIf
		EndIf
	Else
		GUICtrlSetData($h_fNA_tSendK_sText2Send, "")
	EndIf

EndFunc   ;==>h_fNA_tSendK_chkKeyStrokesClick

Func h_fNA_tSendK_chkTxt_inFileClick()
	If GUICtrlRead($h_fNA_tSendK_chkTxt_inFile) = $GUI_CHECKED Then
		Local $sPath = FileOpenDialog("Please choose the file you want to use!", "", "All (*.txt)")
		If @error > 0 Then
			_Error("! FileOpen failed" & @CRLF)
		Else
			GUICtrlSetData($h_fNA_tSendK_sText2Send, $sPath)
			
		EndIf
	Else
		GUICtrlSetData($h_fNA_tSendK_sText2Send, "")
		
	EndIf
	
EndFunc   ;==>h_fNA_tSendK_chkTxt_inFileClick

Func h_fNA_tSendK_sText2SendChange()
	ConsoleWrite("h_fNA_tSendK_sText2SendChange" & @CRLF)
	If GUICtrlRead($h_fNA_tSendK_chkKeyStrokes) = $GUI_CHECKED And StringLen(StringStripWS(GUICtrlRead($h_fNA_tSendK_sText2Send), $STR_STRIPALL)) = 0 Then
		GUICtrlSetState($h_fNA_tSendK_chkKeyStrokes, $GUI_UNCHECKED)
	EndIf
EndFunc   ;==>h_fNA_tSendK_sText2SendChange

Func h_fNA_tSendK_rdbCurActiveClick()
	GUICtrlSetState($h_fNA_tSendK_lbProgTitle, $GUI_HIDE)
	GUICtrlSetState($h_fNA_tSendK_sProg2Send, $GUI_HIDE)
EndFunc   ;==>h_fNA_tSendK_rdbCurActiveClick

Func h_fNA_tSendK_rdbSpecificWndClick()
	If GUICtrlRead($h_fNA_tSendK_rdbSpecificWnd) = $GUI_CHECKED Then
		GUICtrlSetState($h_fNA_tSendK_lbProgTitle, $GUI_SHOW)
		GUICtrlSetState($h_fNA_tSendK_sProg2Send, $GUI_SHOW)
	EndIf

EndFunc   ;==>h_fNA_tSendK_rdbSpecificWndClick

#EndRegion Tab Send Key


Func _ParseAction($sAction, $bIsAdd = 0)
	Local $sAcDetail = ""

	Local $a_sA = StringSplit($sAction, $AC_DELIMITER)
	If Not IsArray($a_sA) Then
		_Error("!ERROR _ParseAction failed with " & $sAction & @CRLF)
		Return 0
	EndIf
	;_DebugArrayDisplay($a_sA,"Array res")

	Switch $a_sA[1]
		Case $AC_OPEN_FILE
			Local $sProgPath, $sProgTitle, $sProgText, $bRunIfOpen = True
			Local $bWait = False, $bIsConsole = False, $bShow = False, $bCaptureOutput = False, $iWinState

			$sProgPath = $a_sA[2]
			$sProgTitle = $a_sA[3]
			$sProgText = $a_sA[4]
			$bRunIfOpen = $a_sA[5] == "True" ? True : False
			$bWait = $a_sA[6] == "True" ? True : False
			$bIsConsole = $a_sA[7] == "True" ? True : False
			$bShow = $a_sA[8] == "True" ? True : False
			$bCaptureOutput = $a_sA[9] == "True" ? True : False
			$iWinState = $a_sA[10]

			$sAcDetail &= "Open " & $sProgTitle & " with text " & $sProgText & " Flags: " & $bRunIfOpen & "," & $bWait _
					 & "," & $bIsConsole & "," & $bShow & "," & $bCaptureOutput & "," & $iWinState

			If $bIsAdd > 0 Then
				_TabOpenProgram_SetData($sProgPath, $sProgTitle, $sProgText, $bRunIfOpen, $bWait, $bIsConsole, $bShow, _
						$bCaptureOutput, $iWinState)
				If _GUICtrlTab_GetCurSel($h_fNA_Tab) <> Int($AC_OPEN_FILE) - 1 Then
					_GUICtrlTab_ActivateTab($h_fNA_Tab, Int($AC_OPEN_FILE) - 1) ;Tab index is 0-based but action is 1-based
				EndIf
			EndIf
		Case $AC_SENDKEY
			Local $bSendCurWindow, $bSendTxtInFile, $bSendKeyStroke, $bSendRaw, $sText2Send, $sWindowTitle
			$bSendCurWindow = $a_sA[2] = "True" ? True : False
			$bSendTxtInFile = $a_sA[3] = "True" ? True : False
			$bSendKeyStroke = $a_sA[4] = "True" ? True : False
			$bSendRaw = $a_sA[5] = "True" ? True : False
			$sText2Send = $a_sA[6]
			$sWindowTitle = $a_sA[7]

			$sAcDetail = StringFormat("Send %skey %s%s to %s", $bSendRaw ? "raw " : " ", $sText2Send, $bSendKeyStroke ? " as keystroke" : "", $sWindowTitle = "" ? "current active window." : ("window with name: " & $sWindowTitle & "."))

			If $bIsAdd > 0 Then
				_TabSendKey_SetData($bSendCurWindow, $bSendTxtInFile, $bSendKeyStroke, $bSendRaw, $sText2Send, $sWindowTitle)
				If _GUICtrlTab_GetCurSel($h_fNA_Tab) <> Int($AC_SENDKEY) - 1 Then
					_GUICtrlTab_ActivateTab($h_fNA_Tab, Int($AC_SENDKEY) - 1) ;Tab index is 0-based but action is 1-based
				EndIf
			EndIf
		Case $AC_SENDMOUSE_EVT
			Local $sWinTitle, $sWinText, $iWinX, $iWinY, $bScreenCoord, $iMouse, $iClick, $iClickInterval, $hControlID, $iCtrlX, $iCtrlY
			$sWinTitle = $a_sA[2]
			$sWinText = $a_sA[3]
			$iWinX = $a_sA[4]
			$iWinY = $a_sA[5]
			$bScreenCoord = $a_sA[6] = "True" ? True : False
			$iMouse = $a_sA[7]
			$iClick = $a_sA[8]
			$iClickInterval = $a_sA[9]
			$hControlID = $a_sA[10]
			$iCtrlX = $a_sA[11]
			$iCtrlY = $a_sA[12]

			$sAcDetail = StringFormat("Send %smouse click to %s at %scoordinate (%s,%s)%s %s", _
					Int($iClick) > 1 ? ($iClick & " ") : "", _
					$sWinTitle & (StringLen($sWinText) > 0 ? (" with text " & StringLeft($sWinText, 50)) : ""), _
					$bScreenCoord = True ? "screen " : "", _
					$iWinX, $iWinY, _
					$iClick > 1 ? (" each " & $iClickInterval & " miliseconds") : "", _
					$hControlID = "0" ? "" : ("into control with ID " & $hControlID))

			If $bIsAdd > 0 Then
				_TabSendClick_SetData($sWinTitle, $sWinText, $iWinX, $iWinY, $bScreenCoord, $iMouse, $iClick, $iClickInterval, _
						$hControlID, $iCtrlX, $iCtrlY)
				If _GUICtrlTab_GetCurSel($h_fNA_Tab) <> Int($AC_SENDMOUSE_EVT) - 1 Then
					_GUICtrlTab_ActivateTab($h_fNA_Tab, Int($AC_SENDMOUSE_EVT) - 1) ;Tab index is 0-based but action is 1-based
				EndIf
			EndIf
		Case $AC_WINDOW_STATE
			Local $sProgName, $sProgText, $iState, $iTransparent
			Local $sState = ""
			$sProgName = $a_sA[2]
			$sProgText = $a_sA[3]
			$iState = Int($a_sA[4])
			Switch $iState
				Case @SW_SHOW
					$sState = "show"
				Case @SW_MAXIMIZE
					$sState = "maximize"
				Case @SW_MINIMIZE
					$sState = "minimize"
				Case @SW_HIDE
					$sState = "hidden"
			EndSwitch
			$iTransparent = Int($a_sA[5])


			$sAcDetail = StringFormat("Set the state of %s to %s%s", $sProgName, $sState, $iTransparent <> 255 ? " with transparency as " & $iTransparent : "")
			If $bIsAdd > 0 Then
				_TabWindowState_SetData($sProgName, $sProgText, $iState, $iTransparent)
				If _GUICtrlTab_GetCurSel($h_fNA_Tab) <> Int($AC_WINDOW_STATE) - 1 Then
					_GUICtrlTab_ActivateTab($h_fNA_Tab, Int($AC_WINDOW_STATE) - 1) ;Tab index is 0-based but action is 1-based
				EndIf
			EndIf
		Case $AC_DELAY


			If _GUICtrlTab_GetCurSel($h_fNA_Tab) <> Int($AC_DELAY) - 1 Then
				_GUICtrlTab_ActivateTab($h_fNA_Tab, Int($AC_DELAY) - 1)     ;Tab index is 0-based but action is 1-based
			EndIf
	EndSwitch
	_Info("_Parse_action: " & $sAcDetail & @CRLF)
	Return $sAcDetail
EndFunc   ;==>_ParseAction
#Region Get/Set data of Tabs
Func _Read_CurrentTab_Data()
	Local $iCurTab = GUICtrlRead($h_fNA_Tab)
	Local $sTmp = "", $iActionCount = $a_fNA_ActionDetail[0][0], $sListData
	Switch $iCurTab
		Case $i_TAB_OPEN
			$sTmp = _TabOpenProgram_GetData()
		Case $i_TAB_SEND_KEY
			$sTmp = _TabSendKey_GetData()
		Case $i_TAB_SEND_CLICK
			$sTmp = _TabSendClick_GetData()
		Case $i_TAB_SET_STATE
			$sTmp = _TabWindowState_GetData()
	EndSwitch
	$sTmp = StringStripWS($sTmp, $STR_STRIPLEADING + $STR_STRIPTRAILING)
	_Info("_Read_CurrentTab_Data()" & @CRLF & $sTmp & @CRLF)
	Return $sTmp
EndFunc   ;==>_Read_CurrentTab_Data

Func _TabWindowState_GetData()
	Local $sFormat = StringReplace("%s,%s,%s,%s,%s", ",", $AC_DELIMITER)
	Local $sTemp = ""
	Local $sProgName, $sProgText, $iState, $iTransparent
	$sProgName = GUICtrlRead($h_fNA_tWinState_sProgName)
	$sProgText = GUICtrlRead($h_fNA_tWinState_sProgText)
	$iState = _fNA_tWinState_getWinState()
	$iTransparent = GUICtrlRead($h_fNA_tWinState_iTransparentValue)
	$sTemp = StringFormat($sFormat, $AC_WINDOW_STATE, $sProgName, $sProgText, $iState, $iTransparent)
	Return $sTemp
EndFunc   ;==>_TabWindowState_GetData

Func _TabWindowState_SetData($sProgName, $sProgText, $iState, $iTransparent)
	GUICtrlSetData($h_fNA_tWinState_sProgName, $sProgName)
	GUICtrlSetData($h_fNA_tWinState_sProgText, $sProgText)
	GUICtrlSetData($h_fNA_tWinState_iTransparentValue, $iState)
	GUICtrlSetData($h_fNA_tWinState_TransparentSlider, $iState)
EndFunc   ;==>_TabWindowState_SetData

Func _TabSendClick_GetData()
	Local $sFormat = StringReplace("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s", ",", $AC_DELIMITER)
	Local $sWinTitle, $sWinText, $iWinX, $iWinY, $bScreenCoord, $iMouse, $iClick, $iClickInterval, $hControlID, $iCtrlX, $iCtrlY
	Local $sTemp = ""

	$sWinTitle = GUICtrlRead($h_fNA_tClick_sWnd)
	$sWinText = GUICtrlRead($h_fNA_tClick_sWndText)
	$iWinX = GUICtrlRead($h_fNA_tClick_iX)
	$iWinY = GUICtrlRead($h_fNA_tClick_iY)
	$bScreenCoord = GUICtrlRead($h_fNA_tClick_chkScreenCoor) = $GUI_CHECKED ? True : False
	$iMouse = GUICtrlRead($h_fNA_tClick_cbbMouseBtn)
	$iClick = GUICtrlRead($h_fNA_tClick_iClickCount)
	$iClickInterval = GUICtrlRead($h_fNA_tClick_iTimeBetweenClicks)
	$hControlID = GUICtrlRead($h_fNA_tClick_sControl)
	$iCtrlX = GUICtrlRead($h_fNA_tClick_iCtrlX)
	$iCtrlY = GUICtrlRead($h_fNA_tClick_iCtrlY)

	;ControlClick ( "title", "text", controlID [, button = "left" [, clicks = 1 [, x [, y]]]] ) ;If application's coord, follow ControlClick
	;MouseClick ( "button" [, x, y [, clicks = 1 [, speed = 10]]] ) ; If screen coord, follow MouseClick
	$sTemp = StringFormat($sFormat, $AC_SENDMOUSE_EVT, $sWinTitle, $sWinText, $iWinX, $iWinY, $bScreenCoord, $iMouse, _
			$iClick, $iClickInterval, $hControlID, $iCtrlX, $iCtrlY)
	Return $sTemp
EndFunc   ;==>_TabSendClick_GetData

Func _TabSendClick_SetData($sWinTitle, $sWinText, $iWinX, $iWinY, $bScreenCoord, $iMouse, $iClick, $iClickInterval, $hControlID = 0, $iCtrlX = 0, $iCtrlY = 0)
	GUICtrlSetData($h_fNA_tClick_sWnd, $sWinTitle)
	GUICtrlSetData($h_fNA_tClick_sWndText, $sWinText)
	GUICtrlSetData($h_fNA_tClick_iX, $iWinX)
	GUICtrlSetData($h_fNA_tClick_iY, $iWinY)
	GUICtrlSetState($h_fNA_tClick_chkScreenCoor, $bScreenCoord = True ? $GUI_CHECKED : $GUI_UNCHECKED)
	GUICtrlSetData($h_fNA_tClick_cbbMouseBtn, $iMouse)
	GUICtrlSetData($h_fNA_tClick_iClickCount, $iClick)
	GUICtrlSetData($h_fNA_tClick_iTimeBetweenClicks, $iClickInterval)
	GUICtrlSetData($h_fNA_tClick_sControl, $hControlID)
	GUICtrlSetData($h_fNA_tClick_iCtrlX, $iCtrlX)
	GUICtrlSetData($h_fNA_tClick_iCtrlY, $iCtrlY)
EndFunc   ;==>_TabSendClick_SetData


Func _TabSendKey_GetData()
	_Trace("==> _TabSendKey_GetData" & @CRLF)
	Local $sFormat = StringReplace("%s,%s,%s,%s,%s,%s,%s", ",", $AC_DELIMITER)
	Local $bSendCurWindow, $bSendTxtInFile, $bSendKeyStroke, $bSendRaw, $sText2Send, $sWindowTitle
	Local $sTmp

	$bSendCurWindow = GUICtrlRead($h_fNA_tSendK_rdbCurActive) = $GUI_CHECKED ? True : False
	$bSendTxtInFile = GUICtrlRead($h_fNA_tSendK_chkTxt_inFile) = $GUI_CHECKED ? True : False
	$bSendKeyStroke = GUICtrlRead($h_fNA_tSendK_chkKeyStrokes) = $GUI_CHECKED ? True : False
	$bSendRaw = GUICtrlRead($h_fNA_tSendK_chkRaw) = $GUI_CHECKED ? True : False

	$sText2Send = GUICtrlRead($h_fNA_tSendK_sText2Send)
	$sWindowTitle = GUICtrlRead($h_fNA_tSendK_sProg2Send)

	$sTmp = StringFormat($sFormat, $AC_SENDKEY, $bSendCurWindow, $bSendTxtInFile, $bSendKeyStroke, $bSendRaw, $sText2Send, $sWindowTitle)

	Return $sTmp
	If $bSendTxtInFile Then

	EndIf
EndFunc   ;==>_TabSendKey_GetData

Func _TabSendKey_SetData($bSendCurWindow, $bSendTxtInFile, $bSendKeyStroke, $bSendRaw, $sText2Send, $sWindowTitle)
	_Trace("==> _TabSendKey_SetData" & @CRLF)
	If $bSendCurWindow Then
		GUICtrlSetState($h_fNA_tSendK_rdbCurActive, $GUI_CHECKED)
		GUICtrlSetState($h_fNA_tSendK_rdbSpecificWnd, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($h_fNA_tSendK_rdbCurActive, $GUI_UNCHECKED)
		GUICtrlSetState($h_fNA_tSendK_rdbSpecificWnd, $GUI_CHECKED)
	EndIf

	If $bSendTxtInFile Then GUICtrlSetState($h_fNA_tSendK_chkTxt_inFile, $GUI_CHECKED)
	If $bSendKeyStroke Then GUICtrlSetState($h_fNA_tSendK_chkKeyStrokes, $GUI_CHECKED)
	If $bSendRaw Then GUICtrlSetState($h_fNA_tSendK_chkRaw, $GUI_CHECKED)

	GUICtrlSetData($h_fNA_tSendK_sText2Send, $sText2Send)
	GUICtrlSetData($h_fNA_tSendK_sProg2Send, $sWindowTitle)

EndFunc   ;==>_TabSendKey_SetData

Func _TabOpenProgram_GetData()
	_Trace("==> _TabOpenProgram_GetData" & @CRLF)
	Local $sRes = "", $sFormat, $sTmp
	Local $sProgPath, $sProgTitle, $sProgText, $bRunIfOpen = True
	Local $bWait = False, $bIsConsole = False, $bShow = False, $bCaptureOutput = False, $iWinState = @SW_RESTORE

	$sProgPath = GUICtrlRead($h_fNA_tOpen_sProgPath)     ;Program's full path
	$sProgTitle = GUICtrlRead($h_fNA_tOpen_sProgName)     ;Program's partial title
	$sProgText = GUICtrlRead($h_fNA_tOpen_sProgText)     ; Program's text (appear inside AutoIT Info)
	$bRunIfOpen = GUICtrlRead($h_fNA_tOpen_rdbActiveRun) = $GUI_CHECKED ? True : False ;
	$bWait = GUICtrlRead($h_fNA_tOpen_chkOpenWait) = $GUI_CHECKED ? True : False

	$bIsConsole = GUICtrlRead($h_fNA_tOpen_chkConsole) = $GUI_CHECKED ? True : False
	$bShow = GUICtrlRead($h_fNA_tOpen_chkConsoleShow) = $GUI_CHECKED ? True : False
	$bCaptureOutput = GUICtrlRead($h_fNA_tOpen_chkConsoleCapt) = $GUI_CHECKED ? True : False

	$sTmp = GUICtrlRead($h_fNA_tOpen_cbbWinState)     ;CBB Winstate
	If StringInStr($sTmp, "Resto") Then
		$iWinState = @SW_RESTORE
	ElseIf StringInStr($sTmp, "Maxi") Then
		$iWinState = @SW_MAXIMIZE
	ElseIf StringInStr($sTmp, "Mini") Then
		$iWinState = @SW_MINIMIZE
	EndIf

	$sFormat = StringReplace("%s,%s,%s,%s,%s,%s,%s,%s,%s,%d", ",", $AC_DELIMITER)
	$sRes = StringFormat($sFormat, $AC_OPEN_FILE, $sProgPath, $sProgTitle, $sProgText, $bRunIfOpen, _
			$bWait, $bIsConsole, $bShow, $bCaptureOutput, $iWinState)
	Return $sRes
EndFunc   ;==>_TabOpenProgram_GetData

Func _TabOpenProgram_SetData($sProgPath, $sProgTitle, $sProgText, $bRunIfOpen, $bWait, $bIsConsole, $bShow, $bCaptureOutput, $iWinState)
	_Trace("==> _TabOpenProgram_SetData" & @CRLF)
	GUICtrlSetData($h_fNA_tOpen_sProgPath, "")     ;Clear text
	GUICtrlSetData($h_fNA_tOpen_sProgPath, $sProgPath)     ;Program's full path

	GUICtrlSetData($h_fNA_tOpen_sProgName, "")     ;Clear text
	GUICtrlSetData($h_fNA_tOpen_sProgName, $sProgTitle)     ;Program's partial title

	GUICtrlSetData($h_fNA_tOpen_sProgText, "")     ;Clear text
	GUICtrlSetData($h_fNA_tOpen_sProgText, $sProgText)     ; Program's text (appear inside AutoIT Info)

	If $bRunIfOpen = True Then
		If GUICtrlRead($h_fNA_tOpen_rdbOpenNewIns) = $GUI_CHECKED Then GUICtrlSetState($h_fNA_tOpen_rdbOpenNewIns, $GUI_UNCHECKED)
		If GUICtrlRead($h_fNA_tOpen_rdbActiveRun) = $GUI_UNCHECKED Then GUICtrlSetState($h_fNA_tOpen_rdbActiveRun, $GUI_CHECKED)
	Else
		If GUICtrlRead($h_fNA_tOpen_rdbOpenNewIns) = $GUI_UNCHECKED Then GUICtrlSetState($h_fNA_tOpen_rdbOpenNewIns, $GUI_CHECKED)
		If GUICtrlRead($h_fNA_tOpen_rdbActiveRun) = $GUI_CHECKED Then GUICtrlSetState($h_fNA_tOpen_rdbActiveRun, $GUI_UNCHECKED)
	EndIf

	If $bWait Then
		If GUICtrlRead($h_fNA_tOpen_chkOpenWait) = $GUI_UNCHECKED Then GUICtrlSetState($h_fNA_tOpen_chkOpenWait, $GUI_CHECKED)
	Else
		If GUICtrlRead($h_fNA_tOpen_chkOpenWait) = $GUI_CHECKED Then GUICtrlSetState($h_fNA_tOpen_chkOpenWait, $GUI_UNCHECKED)
	EndIf


	If $bIsConsole Then
		GUICtrlSetState($h_fNA_tOpen_chkConsole, $GUI_CHECKED)
	Else
		GUICtrlSetState($h_fNA_tOpen_chkConsole, $GUI_UNCHECKED)
	EndIf
	h_fNA_tOpen_chkConsoleClick()
	If $bShow Then
		GUICtrlSetState($h_fNA_tOpen_chkConsoleShow, $GUI_CHECKED)
	Else
		GUICtrlSetState($h_fNA_tOpen_chkConsoleShow, $GUI_UNCHECKED)
	EndIf

	If $bCaptureOutput Then
		GUICtrlSetState($h_fNA_tOpen_chkConsoleCapt, $GUI_CHECKED)
	Else
		GUICtrlSetState($h_fNA_tOpen_chkConsoleCapt, $GUI_UNCHECKED)
	EndIf

	;Restore|Maximize|Minimize
	If Int($iWinState) = @SW_RESTORE Then     ;9
		GUICtrlSetData($h_fNA_tOpen_cbbWinState, "Restore")
	ElseIf Int($iWinState) = @SW_MAXIMIZE Then     ;3
		GUICtrlSetData($h_fNA_tOpen_cbbWinState, "Maximize")
	ElseIf Int($iWinState) = @SW_MINIMIZE Then     ;6
		GUICtrlSetData($h_fNA_tOpen_cbbWinState, "Minimize")
	EndIf
EndFunc   ;==>_TabOpenProgram_SetData

#EndRegion Get/Set data of Tabs
