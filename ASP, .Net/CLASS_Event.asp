<%
Class RecurringEvent
	'=================================================Variable Definitions========================================
	Private mnEventId, msSchema, mdStartDate, mdEndDate, mdThisDate, mnCategoryId, msRecurrenceType, msRecurrenceParameters, aryValidDates, msTitle, msSubTitle, mdTime, msCity, msState, mnEventYear
	'=================================================Property Definitions========================================
	Public Property Let EventId(value)
		mnEventId = value
	End Property
	
	Public Property Let StartDate(value)
		mdStartDate = value
	End Property
	
	Public Property Let EndDate(value)
		mdEndDate = value
	End Property
	
	Public Property Let ThisDate(value)
		mdThisDate = value
	End Property
	
    'some code removed, repetitive.

	Public Property Let RecurrenceType(value)
		msRecurrenceType = value
	End Property
	
	Public Property Let RecurrenceParameters(value)
		msRecurrenceParameters = value
	End Property
	
	Public Property Let Schema(value)
		msSchema = value
	End Property
	
	Public Property Get ValidDates()
		ValidDates = aryValidDates
	End Property
	'=============================================================================================================
	Private Sub Class_Initialize()
		mnEventId = -1
		mdStartDate = -1
		mdEndDate = -1
		mdThisDate = -1
		msTitle = ""
		msSubTitle = ""
		mdTime = ""
		msCity = ""
		msState = ""
		mnCategoryId = "-1"
		msRecurrenceType = ""
		msRecurrenceParameters = ""
		msSchema = DFLT_SCHEMA
		aryValidDates = Array()
	End Sub
	'=============================================================================================================
	Public Function GenerateEventList()
		Dim sSQL, rs, aryValidDates, aryEventInfo, oHTML, i
		
		If cInt(mnCategoryId) = -1 Then
			sSQL = "SELECT * " & _
			         "FROM Events " & _
					"WHERE (StartDate <= #" & mdEndDate & "# AND EndDate >= #" & mdStartDate & "#)" &_
					"AND events.pending=no"
			If msCity <> "" AND msState <> "" Then sSQL = sSQL & " AND msCity = '" & msCity & "' AND msState = '" & msState & "'"
		Else
			sSQL = "SELECT * " & _
			         "FROM Events, CategoryItems " & _
					"WHERE CategoryItems.CategoryId = " & mnCategoryId & " " & _
					  "AND CategoryItems.ItemId = Events.EventId " & _
					  "AND (StartDate <= #" & mdEndDate & "# AND EndDate >= #" & mdStartDate & "#)" & _
					  "AND events.pending=no"
			
			If msCity <> "" AND msState <> "" Then sSQL = sSQL & " AND msCity = '" & msCity & "' AND msState = '" & msState & "'"
		End If
		sSQL = sSQL & " ORDER BY StartDate, Title"
		
		Set rs = GetRecordset(msSchema, sSQL)
		Set oHTML = New StringBuilder
		If Not rs.bof AND Not rs.eof Then
			Do While Not rs.eof
				If Len(rs("RecurrenceType")) > 0 Then
					aryValidDates = GetValidDates()
					For i=0 To uBound(aryValidDates)
						aryEventDetails = Split(aryValidDates(i))
					Next
				Else
					If DateSerial(Year(rs("StartDate")),Month(rs("StartDate")),Day(rs("StartDate"))) > DateSerial(Year(mdStartDate),Month(mdStartDate),Day(mdStartDate)) Then
						sThisDate = DateSerial(Year(rs("StartDate")),Month(rs("StartDate")),Day(rs("StartDate")))
					Else 
						sThisDate = DateSerial(Year(mdStartDate),Month(mdStartDate),Day(mdStartDate))
					End If
					oHTML.Append("<tr valign='top'><td nowrap style='text-align:center'>")
						oHTML.Append GenerateCategoryViewEventBlock(sThisDate, rs("EndDate"), rs("EventId"), rs("Title"), rs("SubTitle"), rs("Time"), rs("City"), rs("State")) ''This function defined in excluded code for proprietary reasons.
					oHTML.Append "</td></tr>"
				End If
				rs.MoveNext
			Loop
		Else
			oHTML.Append "<div id='noEvents'>No events found.</div>"
		End If
		GenerateEventList = oHTML.ToString()
		Set oHTML = Nothing
		rs.Close
		Set rs = Nothing
	End Function
	'==============================================================================================================================
	Public Function GetValidDates()
		Dim sSQL, rs, validDates, msRecurrenceParameters, msRecurrenceType, x, i, msEventDate, dateMemory, aryOccurrences, oHTML, iValidDate, sThisDate, iDaysToAdd
		Dim mdEndOfMonth
		validDates = Array()
		ReDim validDates(-1)

		If mnEventId > -1 Then
			sSQL = "SELECT * FROM Events WHERE EventId=" & mnEventId	
		ElseIf cInt(mnCategoryId) = -1 Then
			sSQL = "SELECT * " & _
			         "FROM Events " & _
					"WHERE (StartDate <= #" & mdEndDate & "# AND EndDate >= #" & mdStartDate & "#)" &_
					"AND events.pending=no"
			If msCity <> "" AND msState <> "" Then sSQL = sSQL & " AND msCity = '" & msCity & "' AND msState = '" & msState & "'"
		Else
			sSQL = "SELECT * " & _
			         "FROM Events, CategoryItems " & _
					"WHERE CategoryItems.CategoryId = " & mnCategoryId & " " & _
					  "AND CategoryItems.ItemId = Events.EventId " & _
					  "AND (StartDate <= #" & mdEndDate & "# AND EndDate >= #" & mdStartDate & "#)" & _
					  "AND events.pending=no"
			
			If msCity <> "" AND msState <> "" Then sSQL = sSQL & " AND msCity = '" & msCity & "' AND msState = '" & msState & "'"
		End If
		sSQL = sSQL & " ORDER BY StartDate, Title"
		Set rs = GetRecordset(msSchema, sSQL)
		Set oHTML = New StringBuilder
		If Not rs.bof AND Not rs.eof Then
			Do Until rs.EOF
				If mdStartDate = -1 Then mdStartDate = DateSerial(Year(rs("StartDate")),Month(rs("StartDate")),1)
				If mdEndDate = -1 Then mdEndDate = DateAdd("d",-1,DateAdd("m",1,DateSerial(Year(rs("EndDate")),Month(rs("EndDate")),1)))
				If Len(rs("RecurrenceType") & "") = 0 Then
					Redim PRESERVE ValidDates(uBound(ValidDates)+1)
					ValidDates(uBound(ValidDates)) = rs("StartDate") & ";;" & rs("EndDate") & ";;" & rs("EventId")
				Else
					msRecurrenceType = rs("RecurrenceType")
					If Len(rs("RecurrenceParameters")) > 0 Then msRecurrenceParameters = Split(rs("RecurrenceParameters"),";")
					Select Case msRecurrenceType
						Case "D"
							If DateSerial(Year(rs("StartDate")),Month(rs("StartDate")),Day(rs("StartDate"))) > DateSerial(Year(mdStartDate),Month(mdStartDate),Day(mdStartDate)) Then
								sThisDate = DateSerial(Year(rs("StartDate")),Month(rs("StartDate")),Day(rs("StartDate")))
							Else 
								sThisDate = DateSerial(Year(mdStartDate),Month(mdStartDate),Day(mdStartDate))
							End If
							If msRecurrenceParameters(0) = "WKD" Then
								If mdStartDate <> mdEndDate Then
									Do Until DateSerial(Year(sThisDate),Month(sThisDate),Day(sThisDate)) > DateSerial(Year(mdEndDate),Month(mdEndDate),Day(mdEndDate)) Or sThisDate > rs("EndDate")
										If Weekday(sThisDate) > 1 And Weekday(sThisDate) < 7 Then
											aryOccurrences = GetEventOccurrences
											i = False
											For x=0 To uBound(aryOccurrences)
												dateMemory = Split(aryOccurrences(x),";;")
												If DateSerial(Year(dateMemory(0)),Month(dateMemory(0)),Day(dateMemory(0))) = sThisDate And cInt(dateMemory(2)) = rs("EventId") Then
													If dateMemory(1) <> "REMOVED" Then
														Redim PRESERVE ValidDates(uBound(ValidDates)+1)
														ValidDates(uBound(ValidDates)) = dateMemory(1) & ";;" & dateMemory(1) & ";;" & rs("EventID")
													End If
													i = True
													Exit For
												End If
											Next
											If Not i Then
												Redim PRESERVE ValidDates(uBound(ValidDates)+1)
												ValidDates(uBound(ValidDates)) = sThisDate & ";;" & sThisDate & ";;" & rs("EventID")
											End If
										End If
										sThisDate = DateAdd("d",1,sThisDate)
									Loop
								Else
									If Weekday(mdStartDate) > 1 And Weekday(mdStartDate) < 7 Then
										aryOccurrences = GetEventOccurrences
										i = False
										For x=0 To uBound(aryOccurrences)
											dateMemory = Split(aryOccurrences(x),";;")
											If DateSerial(Year(dateMemory(0)),Month(dateMemory(0)),Day(dateMemory(0))) = sThisDate And cInt(dateMemory(2)) = rs("EventId") Then
												If dateMemory(1) <> "REMOVED" Then
													Redim PRESERVE ValidDates(uBound(ValidDates)+1)
													ValidDates(uBound(ValidDates)) = dateMemory(1) & ";;" & dateMemory(1) & ";;" & rs("EventID")
												End If
												i = True
												Exit For
											End If
										Next
										If Not i Then
											Redim PRESERVE ValidDates(uBound(ValidDates)+1)
											ValidDates(uBound(ValidDates)) = sThisDate & ";;" & sThisDate & ";;" & rs("EventID")
										End If
									End If
								End If
							Else
								If mdStartDate <> mdEndDate Then
									sThisDate = rs("StartDate")
									Do Until DateSerial(Year(sThisDate),Month(sThisDate),Day(sThisDate)) > DateSerial(Year(mdEndDate),Month(mdEndDate),Day(mdEndDate)) Or sThisDate > rs("EndDate")
										aryOccurrences = GetEventOccurrences
										i = False
										For x=0 To uBound(aryOccurrences)
											dateMemory = Split(aryOccurrences(x),";;")
											If DateSerial(Year(dateMemory(0)),Month(dateMemory(0)),Day(dateMemory(0))) = sThisDate And cInt(dateMemory(2)) = rs("EventId") Then
												If dateMemory(1) <> "REMOVED" Then
													Redim PRESERVE ValidDates(uBound(ValidDates)+1)
													ValidDates(uBound(ValidDates)) = dateMemory(1) & ";;" & dateMemory(1) & ";;" & rs("EventID")
												End If
												i = True
												Exit For
											End If
										Next
										If Not i Then
											Redim PRESERVE ValidDates(uBound(ValidDates)+1)
											ValidDates(uBound(ValidDates)) = sThisDate & ";;" & sThisDate & ";;" & rs("EventID")
										End If
										sThisDate = DateAdd("d",msRecurrenceParameters(0),sThisDate)
									Loop
								Else
									If DateSerial(Year(rs("StartDate")),Month(rs("StartDate")),Day(rs("StartDate"))) > DateSerial(Year(sThisDate),Month(sThisDate),1) Then
										sThisDate = DateSerial(Year(sThisDate),Month(sThisDate),Day(rs("StartDate")))
									Else
										sThisDate = DateSerial(Year(sThisDate),Month(sThisDate),1)
									End If
									Do Until DateSerial(Year(sThisDate),Month(sThisDate),Day(sThisDate)) > DateSerial(Year(mdEndDate),Month(mdEndDate),Day(mdEndDate)) Or sThisDate > rs("EndDate")
										If DateSerial(Year(sThisDate),Month(sThisDate),Day(sThisDate)) = DateSerial(Year(mdStartDate),Month(mdStartDate),Day(mdStartDate)) Then
											aryOccurrences = GetEventOccurrences
											i = False
											For x=0 To uBound(aryOccurrences)
												dateMemory = Split(aryOccurrences(x),";;")
												If DateSerial(Year(dateMemory(0)),Month(dateMemory(0)),Day(dateMemory(0))) = sThisDate And cInt(dateMemory(2)) = rs("EventId") Then
													If dateMemory(1) <> "REMOVED" Then
														Redim PRESERVE ValidDates(uBound(ValidDates)+1)
														ValidDates(uBound(ValidDates)) = dateMemory(1) & ";;" & dateMemory(1) & ";;" & rs("EventID")
													End If
													i = True
													Exit For
												End If
											Next
											If Not i Then
												Redim PRESERVE ValidDates(uBound(ValidDates)+1)
												ValidDates(uBound(ValidDates)) = sThisDate & ";;" & sThisDate & ";;" & rs("EventID")
											End If
										End If
										sThisDate = DateAdd("d",msRecurrenceParameters(0),sThisDate)
									Loop
								End If
							End If
						'Additional select cases removed
					End Select
				End If
				rs.MoveNext
			Loop
		End If
		If uBound(ValidDates) > -1 Then
			x=0
			i=1
			Do Until i = uBound(ValidDates)+1
				If DateSerial(Year(Left(ValidDates(i),inStr(ValidDates(i),";;")-1)),Month(Left(ValidDates(i),inStr(ValidDates(i),";;")-1)),Day(Left(ValidDates(i),inStr(ValidDates(i),";;")-1))) < DateSerial(Year(Left(ValidDates(x),inStr(ValidDates(x),";;")-1)),Month(Left(ValidDates(x),inStr(ValidDates(x),";;")-1)),Day(Left(ValidDates(x),inStr(ValidDates(x),";;")-1))) Then
					DateMemory = ValidDates(i)
					ValidDates(i) = ValidDates(x)
					ValidDates(x) = DateMemory
					x=0
					i=1
				Else
					x=x+1
					i=i+1
				End If
			Loop
		End If
		GetValidDates = ValidDates
		rs.Close
		Set rs = Nothing
	End Function
	'==============================================================================================================================
	Private Function GetEventOccurrences()
		Dim aryEventOccurrences, rs, sSQL
		
		aryEventOccurrences = Array()
		ReDim aryEventOccurrences(-1)
		
		sSQL = "SELECT EventId, OriginalDate, OccurrenceDate, RemoveOccurrence " & _
				"FROM EventOccurrences " & _
				"WHERE OriginalDate >= #" & mdStartDate & "# AND OriginalDate <= #" & mdEndDate & "# " & _
				"ORDER BY EventId"
		Set rs = GetRecordset(msSchema, sSQL)
		If Not rs.BOF And Not rs.EOF Then
			Do Until rs.EOF
				If rs("RemoveOccurrence") <> -1 Then
					ReDim PRESERVE aryEventOccurrences(uBound(aryEventOccurrences)+1)
					aryEventOccurrences(uBound(aryEventOccurrences)) = rs("OriginalDate") & ";;" & rs("OccurrenceDate") & ";;" & rs("EventId")
				Else
					ReDim PRESERVE aryEventOccurrences(uBound(aryEventOccurrences)+1)
					aryEventOccurrences(uBound(aryEventOccurrences)) = rs("OriginalDate") & ";;REMOVED;;" & rs("EventId")
				End If
				rs.MoveNext
			Loop	
		End If

		GetEventOccurrences = aryEventOccurrences
		
		rs.Close
		Set rs = Nothing
	End Function	
	'==============================================================================================================================
	Public Function GenerateEventBlock()
		Dim oHTML, rs, sSQL
		
		sSQL = "SELECT * FROM EventOccurrences WHERE EventId=" & mnEventId & " AND OccurrenceDate=#" & mdStartDate & "#"
		Set rs = GetRecordset(msSchema, sSQL)
		If Not rs.BOF And Not rs.EOF Then
			Set oHTML = New StringBuilder
			oHTML.Append("<tr valign='top'><td  nowrap style='text-align:center'>")
				oHTML.Append("<span class='EventDates'>")
				oHTML.Append(mdStartDate)
				If mdStartDate <> mdEndDate Then
					oHTML.Append(" - ")
					oHTML.Append(Month(mdEndDate))
					oHTML.Append("/")
					oHTML.Append(Day(mdEndDate))
					oHTML.Append("/")
					oHTML.Append(Year(mdEndDate))
				End If
				oHTML.Append("</span>")
				oHTML.Append("</td>")
				oHTML.Append("<td style='padding: 0px 0px 10px 15px;' width=100% >")
				
				oHTML.Append("<a class='EventTitle' href='index.asp?pageID=" & application("events") & "&EventId=")
				oHTML.Append(mnEventId)
				oHTML.Append("&occurrenceDate=" & mdStartDate & "'>")
				oHTML.Append(rs("Title"))
				oHTML.Append("</a>")
				If len(rs("Subtitle")) >0  Then
					oHTML.Append("<div class='EventLocation'>")
					oHTML.Append(rs("Subtitle"))
					oHTML.Append("</div>")
				End If
				If len(rs("Time")) >0  Then
					oHTML.Append("<div class='EventLocation'>")
					oHTML.Append("Time: ")
					oHTML.Append(rs("Time"))
					oHTML.Append("</div>")
				End If
				If rs("City") <> "" AND rs("State") <> "" Then
					oHTML.Append("<div class='EventLocation'>")
					oHTML.Append(rs("City"))
					oHTML.Append(", ")
					oHTML.Append(rs("State"))
					oHTML.Append("</div>")
				End If
				
				oHTML.Append("<a class='MoreInfoLink' href='index.asp?pageID=" & application("events") & "&EventId=")
				oHTML.Append(mnEventId)
				oHTML.Append("'>More Info...</a>")
			oHTML.Append("</td></tr>")
		Else
			sSQL = "SELECT * FROM Events WHERE EventId=" & mnEventId
			Set rs = GetRecordset(msSchema, sSQL)
			If Not rs.BOF And Not rs.EOF Then
				Set oHTML = New StringBuilder
				oHTML.Append("<tr valign='top'><td  nowrap style='text-align:center'>")
					oHTML.Append("<span class='EventDates'>")
					oHTML.Append(mdStartDate)
					If mdStartDate <> mdEndDate Then
						oHTML.Append(" - ")
						oHTML.Append(Month(mdEndDate))
						oHTML.Append("/")
						oHTML.Append(Day(mdEndDate))
						oHTML.Append("/")
						oHTML.Append(Year(mdEndDate))
					End If
					oHTML.Append("</span>")
					oHTML.Append("</td>")
					oHTML.Append("<td style='padding: 0px 0px 10px 15px;' width=100% >")
					
					oHTML.Append("<a class='EventTitle' href='index.asp?pageID=" & application("events") & "&EventId=")
					oHTML.Append(mnEventId)
					oHTML.Append("'>")
					oHTML.Append(rs("Title"))
					oHTML.Append("</a>")
					If len(rs("Subtitle")) >0  Then
						oHTML.Append("<div class='EventLocation'>")
						oHTML.Append(rs("Subtitle"))
						oHTML.Append("</div>")
					End If
					If len(rs("Time")) >0  Then
						oHTML.Append("<div class='EventLocation'>")
						oHTML.Append("Time: ")
						oHTML.Append(rs("Time"))
						oHTML.Append("</div>")
					End If
					If rs("City") <> "" AND rs("State") <> "" Then
						oHTML.Append("<div class='EventLocation'>")
						oHTML.Append(rs("City"))
						oHTML.Append(", ")
						oHTML.Append(rs("State"))
						oHTML.Append("</div>")
					End If
					
					oHTML.Append("<a class='MoreInfoLink' href='index.asp?pageID=" & application("events") & "&EventId=")
					oHTML.Append(mnEventId)
					oHTML.Append("'>More Info...</a>")
				oHTML.Append("</td></tr>")
			End If
		End If
		rs.Close
		Set rs = Nothing
		
		GenerateEventBlock = oHTML.ToString
		Set oTHML = Nothing
	End Function
	'==============================================================================================================================
	Private Sub Class_Terminate()
	
	End Sub
	'==============================================================================================================================
End Class
%>