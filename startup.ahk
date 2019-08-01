#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FormatTime, TimeStr,, HH

if (TimeStr < 9){
	MsgBox, 4, , Have you checked into workday yet?

	IfMsgBox Yes 
    	CreateMessage()
	else 
	    LaunchUIPath()
		Sleep, 6000
}
	

ExitApp
    
LaunchUIPath(){
	run cmd.exe
	WinWait, ahk_exe cmd.exe ; Intention to make sure the next line doesn't execute too soon and not hit CMD (I have not checked for an appropriate WinTitle. But you can definitely get it.)
	Send cd C:\Users\jfrost\AppData\Local\UiPath\app-19.5.0{Enter}
	Send UiRobot -file "C:\Users\jfrost\Documents\UiPath\FirstProcess\Main.xaml"{Enter}
}



CreateMessage(Text="",Font="",TC="",SC="",TS="",xPos="",yPos="",TimeOut="")
	{
	If Text = 
		Text = Great Work!
	If Font = 
		Font = Impact
	If TC = 
		TC = White
	If SC = 
		SC = 828284
	If TS = 
		TS = 60
	If xPos = 
		xPos = center
	If yPos = 
		yPos = 25
	If TimeOut = 
		TimeOut = 1000
	If SC != 0
		{
		Gui, 99:Font, S%TS% C%SC%, %Font%
		Gui, 99:Add, Text, x12 y12, %Text%
		}
	Gui, 99:Font, S%TS% C%TC%, %Font%
	Gui, 99:Add, Text, x10 y10 BackgroundTrans, %Text%

	Gui, 99:Color, EEAA99
	Gui, 99:+LastFound -Caption +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui, 99:Show, x%xPos% y%yPos% AutoSize, TransSplashTextWindow
	If TimeOut != 0
		{
		SetTimer, TextOff, %TimeOut%
		Return
		TextOff:
		TransSplashText_Off()
		Return
		}
	}

TransSplashText_Off()
	{
	Gui, 99:Destroy
	SetTimer, TextOff, Off
	}