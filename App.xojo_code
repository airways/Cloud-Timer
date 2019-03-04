#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  App.AutoQuit = False
		  
		  if ServiceTimer = nil then
		    ServiceTimer = new ServiceTimer
		    ServiceTimer.Mode = Timer.ModeMultiple
		    // Set a shorter first run interval to make debugging easier.
		    // After the first run, this will be reset to kInterval * 1000 by
		    // the timer's Action event handler.
		    ServiceTimer.Period = kFirstRunInterval * 1000
		    ServiceTimer.Enabled = true
		  end if
		  
		  AppLog.Append("Application started: version " + Str(App.MajorVersion) + "." + Str(App.MinorVersion) + "." + Str(App.BugVersion) + " (build " + Str(App.NonReleaseVersion) + ")")
		  AppLog.Append("Service timer interval is " + Str(kInterval) + " seconds, first run will be in " + Str(kFirstRunInterval) + " seconds")
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ClearLog()
		  redim App.AppLog(-1)
		  AppLog.Append("Log cleared")
		  AppLog.Append("Service timer interval is " + Str(kInterval) + " seconds")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(stream as string = "APP", message as string)
		  using Xojo.Core
		  
		  dim prefix as string = "[" + Date.Now.ToText + "] "
		  dim logLine as string = prefix + message
		  
		  System.Log(System.LogLevelDebug, logLine)
		  
		  select case stream.Uppercase
		  case "APP"
		    AppLog.Append(logLine)
		  case "API"
		    // You can add multiple streams by creating more arrays and adding clauses here
		    //ApiLog.Append(logLine)
		  case "*"
		    AppLog.Append(logLine)
		    //ApiLog.Append(logLine)
		  else
		    AppLog.Append(prefix + "ERROR: Bad Log Stream " + stream)
		    AppLog.Append(logLine)
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendEmail(toAddress as string, subject as string, message as string, attachment as FolderItem = nil)
		  Dim email As New EmailMessage
		  email.FromAddress = kEmailFrom
		  email.Subject = subject
		  email.BodyPlainText = message
		  email.AddRecipient(toAddress)
		  dim emailAttachment as new EmailAttachment
		  emailAttachment.LoadFromFile(attachment)
		  email.Attachments.Append(emailAttachment)
		  
		  if SMTP = nil then SMTP = new SMTPSecureSocket
		  
		  SMTP.Address = kSMTPServer
		  SMTP.Port = kSMTPPort
		  SMTP.Username = kSMTPUsername
		  SMTP.Password = kSMTPPassword
		  SMTP.Messages.Append(email)
		  
		  #if TargetXojoCloud
		    dim fwp as new XojoCloud.FirewallPort(kSMTPPort, XojoCloud.FirewallPort.Direction.Outgoing)
		    fwp.Open()
		    if fwp.isOpen() then
		      SMTP.SendMail
		      fwp.Close()
		    else
		      // Not an ERROR so that it doesn't trigger another call to SendEmail
		      App.Log("NOTICE: Cannot open firewall port " + Str(kSMTPPort))
		    end if
		  #else
		    SMTP.SendMail
		  #endif
		  
		  if SMTP.LastErrorCode = 0 then
		    App.Log("Sent mail to " + toAddress + ": " + subject)
		  else
		    App.Log("ERROR: SMTP error: " + Str(SMTP.LastErrorCode))
		  end if
		End Sub
	#tag EndMethod


	#tag Note, Name = Readme
		= About =
		This example is provided by Near North Software. Please visit us online at https://www.nearnorthsoftware.com
		
		
		= Timer Logic =
		
		Customize the ServiceTimer class' Action event handler to do whateve ryou need.
		
		Change kInterval to the number of seconds between each run you wish the timer to run at.
		
		Change kFirstRunInterval to the number of seconds after the app starts you want the timer to run for the first time.
		After this first run, the timer will thereafter run at the kInterval period instead.
		
		
		= Authentication =
		
		Please change the kAdminUsername, kAdminPassword, and kAdminSalt values to something specific for your application.
		kAdminPassword may be plain text but you should instead set it to a hashed value with the following code added to the
		App.Open() event handler:
		
		App.Log("your_new_password_here!!123" + kAdminSalt)
		
		Take the value from the app log, remove this line of code, and use the hashed value in kAdminPassword. If you change
		kAdminSalt after doing this, you will need to recalculate the hash.
		
		
		= Email =
		
		To use SendEmail method you will need to set all of the kEmail* and kSMTP* constants on the App object correctly.
		
		
		= License =
		
		Copyright (c)2018-2019. Near North Software.
		
		Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
		documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
		rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
		persons to whom the Software is furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
		Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
		WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
		COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
		OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
		
		
		"Near North", "Near North Software", and "Near North Screenshots" are trademarks of Near North Software. All other
		trademarks cited herein are the property of their respective owners. All company, product and service names used in
		this software are for identification purposes only. Use of these names, logos, and brands does not imply endorsement.
	#tag EndNote


	#tag Property, Flags = &h0
		AppLog() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ServiceTimer As ServiceTimer
	#tag EndProperty

	#tag Property, Flags = &h0
		SMTP As SMTPSecureSocket
	#tag EndProperty


	#tag Constant, Name = kAdminPassword, Type = String, Dynamic = False, Default = \"change_me_123!", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kAdminSalt, Type = String, Dynamic = False, Default = \"082yh3r08h24380f89h23f8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kAdminUsername, Type = String, Dynamic = False, Default = \"admin", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEmailFrom, Type = String, Dynamic = False, Default = \"sample@example.com", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEmailLogsTo, Type = String, Dynamic = False, Default = \"test@example.com", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kFirstRunInterval, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kInterval, Type = Double, Dynamic = False, Default = \"60", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSMTPPassword, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSMTPPort, Type = Double, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSMTPServer, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSMTPUsername, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
