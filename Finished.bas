Type=Activity
Version=6.8
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@






















#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim b1,b2,b3 As Button
	Dim lb As Label
	Dim cp As BClipboard
	Dim lt As Label
	Dim about,share As Button
	Dim abg,sbg As BitmapDrawable

	Dim B As AdView
	Dim I As InterstitialAd
	Dim N As NativeExpressAd
	
	Dim b1bg,b2bg,b3bg As ColorDrawable
End Sub

Sub Activity_Create(FirstTime As Boolean)
	lt.Initialize("")
	lt.Color = Colors.rgb(0, 150, 136)
	lt.Gravity = Gravity.CENTER
	lt.Text = "Choose!"
	lt.TextColor = Colors.White
	lt.TextSize = 17
	lt.Typeface = Typeface.DEFAULT_BOLD
	Activity.AddView(lt,0%x,0%y,100%x,55dip)
	
	abg.Initialize(LoadBitmap(File.DirAssets,"about.png"))
	about.Initialize("about")
	about.Background = abg
	about.Gravity = Gravity.CENTER
	Activity.AddView(about,10dip,12.5dip,30dip,30dip)
	
	sbg.Initialize(LoadBitmap(File.DirAssets,"share.png"))
	share.Initialize("share")
	share.Background = sbg
	share.Gravity = Gravity.CENTER
	Activity.AddView(share,100%x - 40dip,12.5dip,30dip,30dip)
	
	Activity.Color = Colors.White
	
	lb.Initialize("lb")
	lb.Text = "Congratulations!" &CRLF& "Your Link is Shortened!"
	lb.Gravity = Gravity.CENTER
	lb.TextColor = Colors.Black
	lb.TextSize = 20
	Activity.AddView(lb,0%x,55dip+1%y,100%x,10%y)
	
	b1.Initialize("b1")
	b1.Text = "Open Link in Browser"
	Activity.AddView(b1,50%x - 100dip,lb.Top+lb.Height+3%y,200dip,50dip)
	b1bg.Initialize(Colors.rgb(156, 39, 176),15)
	b1.Background = b1bg
	
	b2.Initialize("b2")
	b2.Text = "Copy Link"
	Activity.AddView(b2,50%x - 100dip,b1.Top+b1.Height+1%y,200dip,50dip)
	b2bg.Initialize(Colors.rgb(33, 150, 243),15)
	b2.Background = b2bg
	
	b3.Initialize("b3")
	b3.Text = "Share Link"
	Activity.AddView(b3,50%x-100dip,b2.Top+b2.Height+1%y,200dip,50dip)
	b3bg.Initialize(Colors.rgb(233, 30, 99),15)
	b3.Background = b3bg
	
	'Banner ADs
	B.Initialize2("B","ca-app-pub-4173348573252986/4846246556",B.SIZE_SMART_BANNER)
	Dim height As Int
	If GetDeviceLayoutValues.ApproximateScreenSize < 6 Then
		If 100%x > 100%y Then height = 32dip Else height = 50dip
	Else
		height = 90dip
	End If
	Activity.AddView(B, 0dip, 100%y - height, 100%x, height)
	B.LoadAd
	Log(B)
	
	'Interstitial Ads
	I.Initialize("I","ca-app-pub-4173348573252986/1613578551")
	I.LoadAd
	If I.Ready = False Then
		I.LoadAd
	End If
	
	'Native Ads
	N.Initialize("N","ca-app-pub-4173348573252986/3090311759",100%x,150dip)
	N.LoadAd
	Activity.AddView(N,0%x,b3.Top+b3.Height+1%y,100%x,200dip)
End Sub


Sub b1_Click
	Dim p As PhoneIntents
	StartActivity(p.OpenBrowser(cp.getText))
	
	If I.Ready Then I.Show Else I.LoadAd
End Sub

Sub b2_Click
	cp.setText(cp.getText&CRLF&"This URL Shortened Myanmar URL Shortener!"&CRLF& "#MyanmarURLShortener")
	ToastMessageShow("Link Copied",True)
	If I.Ready Then I.Show Else I.LoadAd
End Sub

Sub b3_Click
	Dim ShareIt As Intent
	ShareIt.Initialize (ShareIt.ACTION_SEND,"")
	ShareIt.SetType ("text/plain")
	ShareIt.PutExtra ("android.intent.extra.TEXT",cp.getText&CRLF&"This URL Shortened Myanmar URL Shortener!"&CRLF& "#MyanmarURLShortener")
	ShareIt.PutExtra ("android.intent.extra.SUBJECT","Get Free!!")
	ShareIt.WrapAsIntentChooser("Share Link Via...")
	StartActivity (ShareIt)
	If I.Ready Then I.Show Else I.LoadAd
End Sub

Sub share_Click
	Dim ShareIt As Intent
	cp.clrText
	cp.setText("You can shorten any URL to short URL with this Myanmar URL Shortener!"&CRLF& "Download Free This App Here : http://www.myanmarandroidapp.com/search?q=Myanmar+URL+Shortener" &CRLF& "#MyanmarURLShortener")
	ShareIt.Initialize (ShareIt.ACTION_SEND,"")
	ShareIt.SetType ("text/plain")
	ShareIt.PutExtra ("android.intent.extra.TEXT",cp.getText)
	ShareIt.PutExtra ("android.intent.extra.SUBJECT","Get Free!!")
	ShareIt.WrapAsIntentChooser("Share App Via...")
	StartActivity (ShareIt)
End Sub

Sub about_Click
	StartActivity(Ab0ut)
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

'Banner Ads
Sub B_FailedToReceiveAd (ErrorCode As String)
	Log("B failed: " & ErrorCode)
End Sub
Sub B_ReceiveAd
	Log("B received")
End Sub

Sub B_AdScreenDismissed
	Log("B Dismissed")
End Sub

'Interstitial Ads
Sub I_AdClosed
	I.LoadAd
End Sub

Sub I_ReceiveAd
	Log("I Received")
End Sub

Sub I_FailedToReceiveAd (ErrorCode As String)
	Log("I not Received - " &"Error Code: "&ErrorCode)
	I.LoadAd
End Sub

Sub I_adopened
	Log("I Opened")
End Sub

'Native Ads

Sub N_FailedToReceiveAd (ErrorCode As String)
	Log("N failed: " & ErrorCode)
End Sub
Sub N_ReceiveAd
	Log("N received")
End Sub

Sub N_AdScreenDismissed
	Log("N Dismissed")
End Sub