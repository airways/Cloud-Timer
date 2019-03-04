#tag Class
Protected Class ServiceTimer
Inherits Timer
	#tag Event
		Sub Action()
		  using Xojo.Core
		  
		  App.Log("ServiceTrigger " + Date.Now.ToText)
		  
		  // Disable timer while processing so we don't trigger another run
		  // You may want to comment out this line to ensure the timer always
		  // triggers on time, depending on your needs.
		  me.Enabled = false
		  
		  // Perform custom logic here!
		  
		  App.Log("================================================================================")
		  App.Log("Custom logic, for example talk to an API and send an email message or something...")
		  App.Log("Log to the status window with App.Log() calls.")
		  App.Log("================================================================================")
		  
		  
		  // End of custom logic
		  
		  // Reschedule timer
		  App.Log("Schedule next run for " + Str(App.kInterval) + " seconds from now")
		  me.Period = App.kInterval * 1000
		  me.Enabled = true
		  
		  
		End Sub
	#tag EndEvent


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
