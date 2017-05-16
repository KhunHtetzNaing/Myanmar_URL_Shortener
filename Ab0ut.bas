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
	Dim t As Timer
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim su As StringUtils
	Dim p As PhoneIntents
	Dim lstOne As ListView
	Dim B As AdView
	Dim I As InterstitialAd
	Dim ph As Phone
	
	Dim lt As Label
	Dim share As Button
	Dim sbg As BitmapDrawable
End Sub

Sub Activity_Create(FirstTime As Boolean)
	lt.Initialize("")
	lt.Color = Colors.rgb(0, 150, 136)
	lt.Gravity = Gravity.CENTER
	lt.Text = "About"
	lt.TextColor = Colors.White
	lt.TextSize = 17
	lt.Typeface = Typeface.DEFAULT_BOLD
	Activity.AddView(lt,0%x,0%y,100%x,55dip)
	
	sbg.Initialize(LoadBitmap(File.DirAssets,"share.png"))
	share.Initialize("share")
	share.Background = sbg
	share.Gravity = Gravity.CENTER
	Activity.AddView(share,100%x - 40dip,12.5dip,30dip,30dip)
	
	ph.SetScreenOrientation(1)
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
	
	t.Initialize("t",100)
	t.Enabled=False

	Activity.Title = "About"
	Activity.Color = Colors.White
	
	Dim imvLogo As ImageView
	imvLogo.Initialize ("imv")
	imvLogo.Bitmap = LoadBitmap(File.DirAssets , "icon.png")
	imvLogo.Gravity = Gravity.FILL
	Activity.AddView ( imvLogo , 50%x - 50dip  , 50dip+20dip ,  100dip  ,  100dip )
	
	Dim lblName As  Label
	Dim bg As ColorDrawable
	bg.Initialize (Colors.DarkGray , 10dip)
	lblName.Initialize ("lbname")
	lblName.Background = bg
	lblName.Gravity = Gravity.CENTER
	lblName.Text = "Myanmar URL Shortener"
	lblName.TextSize = 13
	lblName.TextColor = Colors.White
	Activity.AddView (lblName , 100%x / 2 - 90dip , imvLogo.Top+imvLogo.Height+10dip , 180dip , 50dip)
	lblName.Height = su.MeasureMultilineTextHeight (lblName, lblName.Text ) + 5dip
	
	
	Dim c As ColorDrawable
	c.Initialize (Colors.rgb(233, 30, 99) , 10dip )
	lstOne.Initialize ("lstOnes")
	lstOne.Background = c
	lstOne.SingleLineLayout .Label.TextSize = 12
	lstOne.SingleLineLayout .Label .TextColor = Colors.White
	lstOne.SingleLineLayout .Label .Gravity = Gravity.CENTER
	lstOne.SingleLineLayout .ItemHeight = 40dip
	lstOne.AddSingleLine2 ("Developed By : Khun Htetz Naing    ", 1)
	lstOne.AddSingleLine2 ("Email : khunht3tzn4ing@gmail.com    ",2)
	lstOne.AddSingleLine2 ("Powered By : Myanmar Android App    ",3)
	lstOne.AddSingleLine2 ("Website : www.MyanmarAndroidApp.com  ", 4)
	lstOne.AddSingleLine2 ("Facebook : www.fb.com/MmFreeAndroidApps   ", 5)
	Activity.AddView ( lstOne, 30dip , lblName.Top+lblName.Height+10dip , 100%x -  60dip, 200dip)
	
	Dim lblCredit As Label
	lblCredit.Initialize ("lblCredit")
	lblCredit.TextColor = Colors.RGB (74,20,140)
	lblCredit.TextSize = 13
	lblCredit.Gravity = Gravity.CENTER
	lblCredit.Text = "Credit : TinyUrl"
	Activity.AddView (lblCredit, 10dip,(lstOne.Top+lstOne.Height)+3%y, 100%x - 20dip, 50dip)
	lblCredit.Height = su.MeasureMultilineTextHeight (lblCredit, lblCredit.Text )
		
End Sub
 

Sub share_Click
	Dim ShareIt As Intent
	Dim cp As BClipboard
	cp.clrText
	cp.setText("You can shorten any URL to short URL with this Myanmar URL Shortener!"&CRLF& "Download Free This App Here : http://www.myanmarandroidapp.com/search?q=Myanmar+URL+Shortener" &CRLF& "#MyanmarURLShortener")
	ShareIt.Initialize (ShareIt.ACTION_SEND,"")
	ShareIt.SetType ("text/plain")
	ShareIt.PutExtra ("android.intent.extra.TEXT",cp.getText)
	ShareIt.PutExtra ("android.intent.extra.SUBJECT","Get Free!!")
	ShareIt.WrapAsIntentChooser("Share App Via...")
	StartActivity (ShareIt)
End Sub

Sub Activity_Click
	t.Enabled = True
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

Sub t_Tick
	If i.Ready Then i.Show Else i.LoadAd
	t.Enabled = False
End Sub

Sub imv_Click
	Try
 
		Dim Facebook As Intent
 
		Facebook.Initialize(Facebook.ACTION_VIEW, "fb://profile/100006126339714")
		StartActivity(Facebook)
 
	Catch
 
		Dim Facebook As Intent
		Facebook.Initialize(Facebook.ACTION_VIEW, "https://m.facebook.com/MgHtetzNaing")
 
		StartActivity(Facebook)
 
	End Try
End Sub

Sub lbname_Click
	StartActivity(p.OpenBrowser("https://play.google.com/store/apps/details?id=com.htetznaing.mmallsimregistration2"))
End Sub

Sub lblCredit_Click
	Try
 
		Dim Facebook As Intent
 
		Facebook.Initialize(Facebook.ACTION_VIEW, "fb://profile/100001706923539")
		StartActivity(Facebook)
 
	Catch
 
		Dim Facebook As Intent
		Facebook.Initialize(Facebook.ACTION_VIEW, "https://m.facebook.com/Crab.111000")
 
		StartActivity(Facebook)
 
	End Try
End Sub
Sub Activity_Resume
     
End Sub

Sub Activity_Pause (UserClosed As Boolean)
     
End Sub

Sub lstOnes_ItemClick (Position As Int, Value As Object)
	Select Value
		Case 1
			Try
 
				Dim Facebook As Intent
 
				Facebook.Initialize(Facebook.ACTION_VIEW, "fb://page/627699334104477")
				StartActivity(Facebook)
 
			Catch
 
				Dim Facebook As Intent
				Facebook.Initialize(Facebook.ACTION_VIEW, "https://m.facebook.com/MmFreeAndroidApps")
 
				StartActivity(Facebook)
 
			End Try
		Case 2
			Dim Message As Email
			Message.To.Add("khunhtetznaing@gmail.com")
			Message.CC.Add("")
			StartActivity(Message.GetIntent)
			
		Case 3
			Try
 
				Dim Facebook As Intent
 
				Facebook.Initialize(Facebook.ACTION_VIEW, "fb://page/627699334104477")
				StartActivity(Facebook)
 
			Catch
 
				Dim Facebook As Intent
				Facebook.Initialize(Facebook.ACTION_VIEW, "https://m.facebook.com/MmFreeAndroidApps")
 
				StartActivity(Facebook)
 
			End Try
			
		Case 4
			StartActivity(p.OpenBrowser ("http://www.htetznaing.com/"))
				   
		Case 5
			Try
 
				Dim Facebook As Intent
 
				Facebook.Initialize(Facebook.ACTION_VIEW, "fb://page/627699334104477")
				StartActivity(Facebook)
 
			Catch
 
				Dim Facebook As Intent
				Facebook.Initialize(Facebook.ACTION_VIEW, "https://m.facebook.com/MmFreeAndroidApps")
 
				StartActivity(Facebook)
 
			End Try
	End Select
End Sub