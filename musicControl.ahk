DetectHiddenWindows, On

usingSpotify = True

getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice.
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
	spotifyHwnd := getSpotifyHwnd()
	; Chromium ignores keys when it isn't focused.
	; Focus the document window without bringing the app to the foreground.
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	Return
}

operaKey(key) {
	SetTitleMatchMode, 2
	ControlGet, OutputVar, Hwnd,,Chrome_RenderWidgetHostHWND1, Opera
	ControlFocus,,ahk_id %outputvar%
	ControlSend, , %key% , Opera
	Return
}

; NumpadEnter: Play/Pause
NumpadEnter::     
{
	if (usingSpotify){
		spotifyKey("{Space}")
		Return
	} else {
		operaKey("{Space}")
		Return
	}
}

; Numpad6: Next
Numpad6::
{
	if (usingSpotify){
		spotifyKey("^{Right}")
		Return
	} else {
		operaKey("+{Right}")
		Return
	}
}

; Numpad4: Previous
Numpad4::
{
	if (usingSpotify){
		spotifyKey("^{Left}")
		Return
	} else {
		operaKey("0")
		Return
	}
}

; NumpadAdd: Seek forward
NumpadAdd::
{
	if (usingSpotify){
		spotifyKey("+{Right}")
		Return
	} else {
		operaKey("{Right}")
		Return
	}
}

; NumpadSub: Seek backward
NumpadSub::
{
	if (usingSpotify){
		spotifyKey("+{Left}")
		Return
	} else {
		operaKey("{Left}")
		Return
	}
}

; Numpad8: Volume up
Numpad8::
{
	if (usingSpotify){
		spotifyKey("^{Up}")
		Return
	} else {
		operaKey("{Up}")
		Return
	}
}

; Numpad2: Volume down
Numpad2::
{
	if (usingSpotify){
		spotifyKey("^{Down}")
		Return
	} else {
		operaKey("{Down}")
		Return
	}
}

; XButton2: Seek forward
XButton2::
{
	if (usingSpotify){
		spotifyKey("+{Right}")
		Return
	} else {
		operaKey("{Right}")
		Return
	}
}

; XButton1: Seek backward
XButton1::
{
	if (usingSpotify){
		spotifyKey("+{Left}")
		Return
	} else {
		operaKey("{Left}")
		Return
	}
}

;Switch between opera and spotify
Numpad0::
{
	if (usingSpotify) {
		usingSpotify := False
		Gui, Font, s50, Verdana
		Gui, Add, Text,,Opera
		Gui, -Caption
		Gui, show, y0 x0
		sleep 250
		Gui, Destroy
		
	} else {
		usingSpotify := True
		Gui, Font, s50, Verdana
		Gui, Add, Text,,Spotify
		Gui, -Caption
		Gui, show, y0 x0
		sleep 250
		Gui, Destroy
		
	}
	Return
}

; NumpadDiv::ExitApp 
NumpadDiv::
{
	ExitApp 
}