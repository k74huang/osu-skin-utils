if(!FileExist("skinsDir.txt"))
{
	MsgBox, Please select your osu! skins folder!
	FileSelectFolder, Folder
	Folder := RegExReplace(Folder, "\\$")  ; Removes the trailing backslash, if present.
	FileDelete, skinsDir.txt
	FileAppend, %Folder%, skinsDir.txt
}

FileRead, Folder, skinsDir.txt

MsgBox, %Folder%
Loop, Files, % Folder "\*", D
	myResult .= A_LoopFileName "|"

Gui, Add, DropDownList, w360 vSkinChoice, %myResult%
Gui, Add, Button, w360 h30 gAddScorebar, Add Feiri's scorebar-bg
Gui, Add, Button, w360 h30 gRemoveScorebar, Remove Feiri's scorebar-bg
Gui, Add, Button, w360 h30 gAddOverlay, Add inputarea-overlay-bg blocker
Gui, Add, Button, w360 h30 gRemoveOverlay, Remove inputarea-overlay-bg blocker
Gui, Add, Button, w360 h30 gChangeCursor, Change cursor
Gui, Add, Button, w360 h30 gChangeHitsounds, Change hitsounds
Gui, Show
Return

AddScorebar:
MsgBox, Added Feiri's scorebar-bg.png
Return

RemoveScorebar:
MsgBox, Removed Feiri's scorebar-bg.png
Return

AddOverlay:
MsgBox, Added inputarea-overlay-bg.png place blocker
Return

RemoveOverlay:
MsgBox, Removed inputarea-overlay-bg.png place blocker
Return

ChangeCursor:
MsgBox, Changing cursor!
Return

ChangeHitsounds:
MsgBox, Changing hitsounds!
Return

GuiClose: 
ExitApp	