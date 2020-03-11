if(!FileExist("skinsDir.txt"))
{
	MsgBox, Please select your osu! skins folder!
	FileSelectFolder, Folder
	Folder := RegExReplace(Folder, "\\$")  ; Removes the trailing backslash, if present.
	FileDelete, skinsDir.txt
	FileAppend, %Folder%, skinsDir.txt
}

FileRead, Folder, skinsDir.txt

; MsgBox, %Folder%
Loop, Files, % Folder "\*", D
	myResult .= A_LoopFileName "|"

Gui, Add, DropDownList, w360 vSkinChoice gSetupControls, %myResult%
Gui, Add, Button, w360 h30 vAddScoreBar disabled gAddScorebar, Add Feiri's scorebar-bg
Gui, Add, Button, w360 h30 vAddOverlay disabled gAddOverlay, Add inputarea-overlay-bg blocker
Gui, Add, Button, w360 h30 vChangeCursor disabled gChangeCursor, Change cursor
Gui, Add, Button, w360 h30 vChangeHitsounds disabled gChangeHitsounds, Change hitsounds

Gui, Add, Button, w360 h30 vResetScorebar disabled gResetScorebar, Reset original scorebar-bg
Gui, Add, Button, w360 h30 vResetOverlay disabled gResetOverlay, Reset original inputarea-overlay-bg
Gui, Add, Button, w360 h30 vResetCursor disabled gResetCursor, Reset original cursor
Gui, Add, Button, w360 h30 vResetHitsounds disabled gResetHitsounds, Reset original hitsounds
Gui, Show
Return

SetupControls:
	GuiControl, Enable, AddScoreBar 
	GuiControl, Enable, AddOverlay 
	GuiControl, Enable, ChangeCursor
	GuiControl, Enable, ChangeHitsounds

	GuiControlGet, SkinChoice
	fullPath = %Folder%\%SkinChoice%

	; msgBox, %fullPath%

	if(FileExist(fullpath "\oldScorebar"))
	{
		GuiControl, Enable, ResetScorebar 
	}
	else
	{
		GuiControl, Disable, ResetScorebar 
	}

	if(FileExist(fullpath "\oldOverlay"))
	{
		GuiControl, Enable, ResetOverlay 
	}
	else
	{
		GuiControl, Disable, ResetOverlay 
	}

	if(FileExist(fullpath "\oldCursor"))
	{
		GuiControl, Enable, ResetCursor 
	}
	else
	{
		GuiControl, Disable, ResetCursor 
	}

	if(FileExist(fullpath "\oldHitsounds"))
	{
		GuiControl, Enable, ResetHitsounds 
	}
	else
	{
		GuiControl, Disable, ResetHitsounds 
	}

Return

AddScorebar:
	GuiControlGet, SkinChoice
	fullPath = %Folder%\%SkinChoice%
	FileCreateDir, %fullPath%\oldScorebar
	FileMove, %fullPath%\scorebar-bg.png, %fullPath%\oldScorebar\scorebar-bg.png, 1
	FileMove, %fullPath%\scorebar-bg@2x.png, %fullPath%\oldScorebar\scorebar-bg@2x.png, 1
	FileCopy, resources\scorebar-bg.png, %fullPath%\scorebar-bg.png, 1
MsgBox, Added Feiri's scorebar-bg.png
Return

AddOverlay:
	GuiControlGet, SkinChoice
	fullPath = %Folder%\%SkinChoice%
	FileCreateDir, %fullPath%\oldOverlay
	FileMove, %fullPath%\inputoverlay-background.png, %fullPath%\oldOverlay\inputoverlay-background.png, 1
	FileMove, %fullPath%\inputoverlay-background@2x.png, %fullPath%\oldOverlay\inputoverlay-background@2x.png, 1
	FileCopy, resources\inputoverlay-background.png, %fullPath%\inputoverlay-background.png, 1
MsgBox, Added inputarea-overlay-bg.png place blocker
Return

ChangeCursor:
Gui 2: Add, Text, w360, Select which skin you'd like to get the cursor from
Gui 2: Add, DropDownList, w360 vCursorSkinChoice gCopyCursor, %myResult%
Gui 2: Show
; MsgBox, Changing cursor!
Return

CopyCursor:
	GuiControlGet, SkinChoice, 1:
	fullPath = %Folder%\%SkinChoice%
	; msgBox, %SkinChoice%
	FileCreateDir, %fullPath%\oldCursor
	FileCopy, %fullpath%\cursor*, %fullpath%\oldCursor\*.*
	FileDelete, %fullpath%\cursor*
	GuiControlGet, CursorSkinChoice
	FileCopy, %Folder%\%CursorSkinChoice%\cursor*, %fullpath%\*.*
	MsgBox, Changing cursor!
	Gui, 2: destroy
Return

ChangeHitsounds:
	Gui 3: Add, Text, w360, Select which skin you'd like to get the hitsounds from
	Gui 3: Add, DropDownList, w360 vHitsoundSkinChoice gCopyHitsounds, %myResult%
	Gui 3: Show
Return

CopyHitsounds:
	GuiControlGet, SkinChoice, 1:
	fullPath = %Folder%\%SkinChoice%
	; msgBox, %SkinChoice%
	FileCreateDir, %fullPath%\oldHitsounds
	FileCopy, %fullpath%\*.wav, %fullpath%\oldHitsounds\*.*
	FileDelete, %fullpath%\*.wav
	GuiControlGet, HitsoundSkinChoice
	FileCopy, %Folder%\%HitsoundSkinChoice%\*.wav, %fullpath%\*.*
	MsgBox, Changing hitsounds!
	Gui, 3: destroy
Return

ResetScorebar:
	GuiControlGet, SkinChoice
	fullPath = %Folder%\%SkinChoice%
	FileMove, %fullPath%\oldScorebar\scorebar-bg.png, %fullPath%\scorebar-bg.png, 1
	FileMove, %fullPath%\oldScorebar\scorebar-bg@2x.png, %fullPath%\scorebar-bg@2x.png, 1
	FileRemoveDir, %fullPath%\oldScorebar
MsgBox, Removed Feiri's scorebar-bg.png
Return

ResetOverlay:
	GuiControlGet, SkinChoice
	fullPath = %Folder%\%SkinChoice%
	FileMove, %fullPath%\oldOverlay\inputoverlay-background.png, %fullPath%\inputoverlay-background.png, 1
	FileMove, %fullPath%\oldOverlay\inputoverlay-background@2x.png, %fullPath%\inputoverlay-background@2x.png, 1
	FileRemoveDir, %fullPath%\oldOverlay
MsgBox, Removed inputarea-overlay-bg.png place blocker
Return

ResetCursor:
	GuiControlGet, SkinChoice, 1:
	fullPath = %Folder%\%SkinChoice%
	FileDelete, %fullpath%\cursor*
	FileMove, %fullpath%\OldCursor\*, %fullpath%\*.*
	FileRemoveDir, %fullPath%\oldCursor
MsgBox, Restored original cursor
Return

ResetHitsounds:
	GuiControlGet, SkinChoice, 1:
	fullPath = %Folder%\%SkinChoice%
	FileDelete, %fullpath%\*.wav
	FileMove, %fullpath%\OldHitsounds\*, %fullpath%\*.*
	FileRemoveDir, %fullPath%\OldHitsounds
MsgBox, Restored original hitsounds
Return


GuiClose: 
ExitApp	