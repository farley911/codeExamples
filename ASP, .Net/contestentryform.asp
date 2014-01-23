<%
	Set upl = Server.CreateObject("SoftArtisans.FileUp")
	
	If Len(upl.Form("_captchacode")) > 0 Then
		if TestCaptcha("ASPCAPTCHA", upl.Form("_captchacode")) then			
			If Right(Request.ServerVariables("HTTP_HOST"),17) = "whatsbubbling.net" And Len(upl.Form("_HomePhoneFX")) = 0 And Len(upl.Form("_HomeFaxFX")) = 0 Then 			
				mnId = Request.QueryString("entryID")
						
				sTableName = upl.Form("_TableName")
				sIdFld = upl.Form("_IDFldName")
				mnId = upl.Form(sIdFld)
				mnId = CInt(mnId)
			
				sSQL = "SELECT * FROM " & sTableName & " WHERE " & sIdFld & " = " & mnId
				Set rs = GetUpdatableRecordset(DFLT_SCHEMA, sSQL)
				If mnId <= -1 Then
					rs.AddNew
				End If
				
				For Each fld In upl.Form
					If Left(fld, 1) <> "_" AND fld <> upl.Form("_IDFldName") Then
						If Trim(upl.Form(fld)) = "" Then
							rs(fld) = Null
						ElseIf fld = upl.Form("Movie") And Len(upl.Form(fld)) < 1 Then
							rs(fld) = 0
						Else 
							rs(fld) = upl.Form(fld)
						End If
					End If
				Next
				
				rs.Update()
					
				' If this is a new record, grab the primary key value
				If mnId <= -1 Then
					mnId = rs(sIdFld)
				End If
					
				rs.Close()
				Set rs = Nothing
			  
				msEntryID = mnId & ""
				msFName = upl.Form("_FName") & ""
				msMI = upl.Form("_MI") & ""
				msLName = upl.Form("_LName") & ""
				msEmail = upl.Form("_Email") & ""
				msCountry = upl.Form("_Country") & ""
				msAddress = upl.Form("_Address") & ""
				msCity = upl.Form("_City") & ""
				msState = upl.Form("_State") & ""
				msZipCode = upl.Form("_ZipCode") & ""
				msPhone = upl.Form("_Phone") & ""
				msStudent = upl.Form("_Student") & ""
					If msStudent = "" Then msStudent = 0
				ms5YearGrad = upl.Form("_5YearGrad") & ""
					If ms5YearGrad = "" Then ms5YearGrad = 0
				msConsultant = upl.Form("_Consultant") & ""
					If msConsultant = "" Then msConsultant = 0
				msCorporate = upl.Form("_Corporate") & ""
					If msCorporate = "" Then msCorporate = 0
				msEntrepreneur = upl.Form("_Entrepreneur") & ""
					If msEntrepreneur = "" Then msEntrepreneur = 0
				msEducator = upl.Form("_Educator") & ""
					If msEducator = "" Then msEducator = 0
				msFindUs = upl.Form("_FindUs") & ""
				msGender = upl.Form("_Gender") & ""
				msTeam = upl.Form("_Team") & ""
					
				sSQL = "INSERT INTO Entrants (EntryID, FName, MI, LName, Email, Country, Address, City, State, ZipCode, Phone, Student, 5YearGrad, Consultant, Corporate, Entrepreneur, Educator, FindUs, Gender, Team) VALUES (" & msEntryID & ", '" & msFName & "', '" & msMI & "', '" &  msLName & "', '" & msEmail & "', '" & msCountry & "', '" & msAddress & "', '" & msCity & "', '" & msState & "', '" & msZipCode & "', '" & msPhone & "', " & msStudent & ", " & ms5YearGrad & ", " & msConsultant & ", " & msCorporate & ", " & msEntrepreneur & ", " & msEducator & ", '" & msFindUs & "', '" & msGender & "', '" & msTeam & "')"
				ExecuteStatement DFLT_SCHEMA, sSQL
			
				sSQL2 = "UPDATE Entries SET "
				firstImg = true
				If NOT upl.Form("_PDF").IsEmpty Then
					SaveFile upl.Form("_PDF"),"PDF","PDF"
					sSQL2 = sSQL2 & "PDF='/usr/ContestEntries/" & mnId & "_PDF" & "." & ext & "'"
					firstImg = false
				End If
			
				For i = 1 To 7
					msImgFld = "_Img" & i
					If NOT upl.Form(msImgFld).IsEmpty Then
						SaveFile upl.Form(msImgFld),i,"Img"
						If firstImg Then
							sSQL2 = sSQL2 & Right(msImgFld,Len(msImgFld)-1) & "='/usr/ContestEntries/" & mnId & "_" & i & "." & ext & "'"
							firstImg = false
						Else
							sSQL2 = sSQL2 & ", " & Right(msImgFld,Len(msImgFld)-1) & "='/usr/ContestEntries/" & mnId & "_" & i & "." & ext & "'"
						End If
					End If
				Next
				sSQL2 = sSQL2 & " WHERE ID=" & mnId
				executeStatement DFLT_SCHEMA, sSQL2
			
				SendEmail
				
				Set upl = Nothing
				
				mnPageState = 1
			End If
		else
			mnPageState = 3
		end if
	Else
		mnPageState = ""
	End If
	
	Sub SaveFile(resource, id, fileType)
    	Dim sFilePath, sContentType, bPermitAction, ShortFilename
		Dim i

		ShortFileName = resource.UserFileName
		i = Len(ShortFileName)
		  
		'IE8 Fix added 5-19-09 by Josh Koehler
		iFilenameStart = InstrRev(ShortFileName, "\")
		if iFilenameStart > 0 then
			ShortFileName=right(ShortFileName,len(ShortFileName)-iFilenameStart)
		else
			ShortFileName = ShortFileName
		end if
		
		iFilenameStart = InstrRev(ShortFileName, ".")
			
		ext = right(ShortFileName,len(ShortFileName)-iFilenameStart)
	
		bPermitAction = False
		sContentType = resource.ContentType

		Select Case fileType
			Case "Img"
				Select Case LCase(sContentType) 
					Case "image/gif", "image/jpeg", "image/pjpeg", "image/png", "image/x-png"
						bPermitAction = True
					Case Else
			   			bPermitAction = False
						msContent = "Unknown content type: " & sContentType & "<br><br>Upload canceled."
				End Select
			Case "PDF"
				Select Case LCase(sContentType) 
					Case "application/pdf"
						bPermitAction = True
					Case Else
						bPermitAction = False
						msContent = "Unknown content type: " & sContentType & "<br><br>Upload canceled."
				End Select
		End Select
		
        If bPermitAction Then
			If Not IsObject(resource) Then
				msContent = "The form contains a tag named 'filename' which is not of TYPE='FILE'. Please " & _
								  "check your form definition."
			ElseIf resource.IsEmpty Then
				msContent = "The file that you uploaded was empty. " & _
								"Most likely, you did not specify a valid filename to your " & _
								"browser or you left the filename field blank. Please try again."
			ElseIf resource.ContentDisposition <> "form-data" Then
				msContent = "Your upload did not succeed, most likely because your browser " & _
								"does not support Upload via this mechanism."
			Else
				On Error Resume Next 
				
				If Instr(msFolder, "SecureDocs") > 0 Then
					resource.SaveAs Server.MapPath("\usr\ContestEntries") & "\" & mnId & "_" & id & "." & ext
					If fileType = "Img" Then 
						msImgs = msImgs & COMPANY_URL & "\usr\ContestEntries" & "\" & mnId & "_" & id & "." & ext & "," & id & ";"
					ElseIf fileType = "PDF" Then
						msPDF = COMPANY_URL & "\usr\ContestEntries" & "\" & mnId & "_" & id & "." & ext
					End If
				Else
					resource.SaveAs Server.MapPath("\usr\ContestEntries") & "\" & mnId & "_" & id & "." & ext
					If fileType = "Img" Then 
						msImgs = msImgs & COMPANY_URL & "\usr\ContestEntries" & "\" & mnId & "_" & id & "." & ext & "," & id & ";"
					ElseIf fileType = "PDF" Then
						msPDF = COMPANY_URL & "\usr\ContestEntries" & "\" & mnId & "_" & id & "." & ext
					End If
				End If
				If Err.Number <> 0 Then
				Else 				   
				End If
			End If
      	End If

    End Sub

	Function SendEmail()
		Dim aryFields, aryLabels, iCount, i, Mailer, tempStr, oPageInfo, fldId
		
		aryFields = split(upl.Form("_emailFields"), ",")
		aryLabels = split(upl.Form("_emailLabels"), ",")

		iCount = uBound(aryLabels)
		strBody = "<p>Thank you for successfully entering the 2011 Kitchen Tools International Design Competition, sponsored by World Kitchen.!<br />This email confirms that your entry was successfully received and entered! Please keep a copy for your records. All winners will be announced at the 2010 International Home + Housewares Show in Chicago, IL on March 14-16th and on the <a href='" & COMPANY_URL & "'>" & COMPANY_URL & "</a> site  Only winners will be notified of their status. Please visit <a href='" & COMPANY_URL & "'>" & COMPANY_URL & "</a> for competition updates and news.<br />Thank you again for participating in this exploration of how to elevate the dining experience.</p><p>Below is a copy of the information you provided. Your entry ID is " & mnID & " please write this down for future reference to your entry.</p>"
		If upl.Form("Movie") Then strBody = strBody & "<p>If you would like to submit a movie, please email the video file to <a href='new-ideas@worldkitchen.com'>new-ideas@worldkitchen.com</a>. Only .wav, .mpg, or .mov formats will be accepted.  Please focus on making sure the video helps show how your concept works and how it fits. The video is limited to 3 minutes or less. In the email, please include your Entry ID which is " & mnId & " (If you do not provide the ID your movie will not be accepted), your name,  and design entry name. Remember, make absolutely no reference to your name, location, school or workplace on the actual video. A movie is not required.</p>"
		for i = 0 to iCount
			Select Case aryLabels(i)
				Case "Name"
					strBody = strBody & aryLabels(i) & ": "
					strBody = strBody & upl.Form("_FName") & " "
					If Len(upl.Form("_MI")) > 0 Then strBody = strBody & upl.Form("_MI") & " "
					strBody = strBody & upl.Form("_LName") & "<br />"
				Case "Address"
					strBody = strBody & aryLabels(i) & ": "
					strBody = strBody & upl.Form("_Address") & "<br />"
					strBody = strBody & upl.Form("_City") & ", " & upl.Form("_State") & " " & upl.Form("_ZipCode") & "<br />"
				Case "Phone"
					strBody = strBody & aryLabels(i) & ": "
					strBody = strBody & upl.Form("_Phone") & "<br />"
				Case "Which of the following describes you"
					If Len(upl.Form("_Student")) > 0 Then tempStr = tempStr & "<br />Current Student"
					If Len(upl.Form("_5YearGrad")) > 0 Then tempStr = tempStr & "<br />Graduated in the last 5 years"
					If Len(upl.Form("_Consultant")) > 0 Then tempStr = tempStr & "<br />Design Consultant"
					If Len(upl.Form("_Corporate")) > 0 Then tempStr = tempStr & "<br />Corporate Designer"
					If Len(upl.Form("_Entrepreneur")) > 0 Then tempStr = tempStr & "<br />Entrepreneur"
					If Len(upl.Form("_Educator")) > 0 Then tempStr = tempStr & "<br />Educator/Faculty Member"
					If Len(tempStr) > 0 Then strBody = strBody & aryLabels(i) & ": " & tempStr & "<br />"
				Case "Team members"
					If upl.Form("_Team") <> "Separate each name with a comma(,)" Then strBody = strBody & aryLabels(i) & ": " & upl.Form("_Team") & "<br />"
				Case "Image"
					If Len(msImgs) > 0 Then
						strBody = strBody & "Images: "
						tempStr = Split(msImgs,";")
						For each img in tempStr
							If Len (img) > 0 Then
								fldId = Split(img,",")
								strBody = strBody & "<a href='" & fldId(0) & "'>" & upl.Form("_Img" & fldId(1) & "Fake") & "</a><br />"
							End If
						Next
					End If
				Case "PDF"
					If Len(upl.Form("_PDFFake")) > 0 Then strBody = strBody & "PDF: <a href='" & msPDF & "'>" & upl.Form("_PDFFake") & "</a>"
				Case Else
					If Len(upl.Form(aryFields(i))) > 0 Then 
						strBody = strBody & aryLabels(i) & ": " & upl.Form(aryFields(i)) & "<br />"
					End If
			End Select
		next

		Set objMailer = Server.CreateObject("CDO.Message")
		'Set oPageInfo = Session("PageInfo")
		With objMailer
			.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = EMAIL_SERVER
			.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 	' 1 = cdoSendUsingPickup; 2 = cdoSendUsingPort
			.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
			
			.Configuration.Fields.Update

			.To = upl.Form("_Email")
	   		.From = DFLT_EMAIL
			.ReplyTo = DFLT_EMAIL
	   		.Subject  = APP_TITLE & " Contest Entry Confirmation"
	   		.HTMLBody  = strbody
	   		.Send
			
	   		.To = DFLT_EMAIL
	   		.From = upl.Form("_Email")
			.ReplyTo = upl.Form("_Email")
	   		.Subject  = APP_TITLE & " New Contest Entry Recieved"
	   		.HTMLBody  = "A new entry has been received for the current What's Bubbling? design competition. The Entry ID associated with the entry is " & mnId & ". You may view this entry at any time by logging into the <a href='" & COMPANY_URL & "/admin'>admin</a> tool."
			.Send
			
		End With
		Set objMailer = Nothing
	End Function

'Additional code generating a HTML form has been removed due to the use of proprietary code and to shorten the length of this sample.

%>
<script src='/script/jquery-1.3.2.min.js' language='JavaScript' type='text/javascript'></script>
<script language="JavaScript">
	function uploadMultipleFiles(){
		if (document.getElementById("_multipleUploadCB").checked == true){
			document.getElementById("multipleUpload").style.display = "block";
		}
		else{
			document.getElementById("multipleUpload").style.display = "none";
		}
	}
	function teamEntry(){
		document.getElementById("teamEntry").style.display = "Block";	
	}
	function rulesAcceptance(){
		if (document.getElementById("Terms").checked == true){
			$('#submit').attr('disabled','disabled');
			submitForm();	
			return false;
		}
		else{
			alert("You must accept the contest rules before your entry will be accepted.");
			return false;
		}
	}
</script>