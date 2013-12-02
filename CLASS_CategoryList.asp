<%
Class CategoryList
	Public View, CategoryID, SubCatID, pageId, curpage, NumPerPage, SortBy, UPC
	
'********************************************************* Class_Initialize
	Private Sub Class_Initialize()
		pageId = ""
		CategoryID = -1
		SubCatID = -1
		NumPerPage = 10
		curpage = 1
		SortBy = "minPrice DESC, Title"
		View = "CategoryView"
		UPC = ""
	End Sub
'********************************************************* End Class_Initialize
	Public Function ToHTML()
		Dim oHTML
		
		Set oHTML = New StringBuilder
		With oHTML
			Select Case View
				Case "CategoryView"
					.Append(GenerateNav())
					.Append(GenerateCategoryView())
				Case "List"
					.Append(GenerateNav())
					.Append(GenerateListView())
				Case "Detail"
					.Append(GenerateNav())
					.Append(GenerateDetailView())
				Case "NoSubCatDetail"
					.Append(GenerateDetailView())
				End Select
			ToHTML = .ToString()
		End With
		Set oHTML = Nothing
	End Function
	
	Public Function GenerateListView()
		Dim sSQL, rs, moHTML, Key, i, recID, sOrderBy
		Dim aryRec, msImage, iCol, msTemp, msDesc
		Dim TotalPages, recCount, stockOut
		Dim rs2, sSQL2, featuredUPC
		
		If IsEmpty(moHTML) Then Set moHTML = New StringBuilder
		With moHTML
		
			sSQL2 = "SELECT featuredUPC " & _
				"FROM subCatDetail " & _
				"WHERE subCatID = " & SubCatId
			Set rs2 = GetRecordset(DFLT_SCHEMA, sSQL2)
			If Not rs2.BOF AND Not rs2.EOF Then
				sSQL = "SELECT UPC, Title, ProductDesc1, minPrice, salePrice, stockOut, NewProduct " & _
					"FROM Products " & _
					"WHERE UPC='" & rs2("featuredUPC") & "'" & " " & _
					"AND inActive = 0"
				Set rs = GetRecordset(ECOMM_SCHEMA, sSQL)
				If Not rs.BOF AND Not rs.EOF Then
					.Append "<div id='featuredItem'>"
						.Append "<div id='featuredVCenter'>"
							.Append "<div id='featuredImg'>"
								.Append "<a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs2("featuredUPC") & "' title='" & rs("Title") & "'>"
									.Append "<img src='http://www.shopworldkitchen.com/usr/products/" & rs2("featuredUPC") & ".jpg' width='150' onError='this.src=""http://www.shopworldkitchen.com/usr/noImage.gif""'  alt='" & rs("Title") & "' />"
								.Append "</a>"
							.Append "</div>"
							.Append "<div id='featuredCont'>"
								.Append "<h2><span class='leadIn'>Featured Product: </span><br /><a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs2("featuredUPC") & "' title='" & rs("Title") & "'>Pyrex&reg;  " & rs("Title") & "</a>"
									If rs("NewProduct") Then .Append "<img src='webimgs/new.jpg' width='57' height='20' alt='New' title='New' />"
								.Append "</h2>"
								msDesc = rs("ProductDesc1") & ""
								If LCase(Left(msDesc,3)) = "<p>" Then msDesc = Right(msDesc,Len(msDesc)-3)
								If LCase(Right(msDesc,4)) = "</p>" Then msDesc = Left(msDesc,Len(msDesc)-4)
								Set regex = New RegExp  
								With regex  
									 .IgnoreCase = True 
									 .Global = True 
									 .Pattern = "(<a).+(</a>)"
									 msDesc = regex.Replace(msDesc,"")
									 .Pattern = "(<p>)"
									 msDesc = regex.Replace(msDesc,"") 
									 .Pattern = "(</p>)"
									 msDesc = regex.Replace(msDesc,"") 
								End With 
								Set Regex = Nothing
								.Append "<p class='description'>" & msDesc
									If rs("salePrice") <> 0 Then
										.Append "<span class='salePriceUs'> " & formatCurrency(rs("salePrice"),2) & "</span> <span class='oldPrice'>" & formatCurrency(rs("minPrice"),2) & "</span>"
									Else
										.Append "<span class='minPriceUs'> " & formatCurrency(rs("minPrice"),2) & "</span>"
									End If
								.Append "</p>"
								.Append "<a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs2("featuredUPC") & "' title='View Details'>"
									.Append "<img src='/webimgs/viewDetailBtn.png' alt='View Details' width='104px' height='20px' />"
								.Append "</a>"
								.Append "<a href='http://www.shopworldkitchen.com/pyrex.asp?upc=" & rs("UPC") & "' target='_blank' title='Buy Now'>"
									.Append "<img src='/webimgs/buyNowBtn.png' alt='Buy Now' width='104px' height='20px' alt='Buy Now' />"
								.Append "</a>"
							.Append "</div>"
						.Append "</div>"
						featuredUPC = rs2("featuredUPC")
						
						rs.Close()
						Set rs = Nothing
					rs2.Close()
					Set rs2 = Nothing
						
						.Append "<div id='pairsWith'>"
							.Append "<img src='/webimgs/pairsWellTxt.png' alt='Pairs Well With' id='titleImg' width='150px' height='15px' />"
							sSQL = "SELECT TOP 3 UPC FROM " & _
									"(SELECT UPC " & _
									"FROM PairsWith " & _
									"WHERE RelatedUPC = '" & featuredUPC & "'" & _
									" UNION " & _
									"SELECT RelatedUPC AS UPC " & _
									"FROM PairsWith " & _
									"WHERE UPC = '" & featuredUPC & "')"
							Set rs = GetRecordset(DFLT_SCHEMA, sSQL)
							If Not rs.BOF AND Not rs.EOF Then
								Do Until rs.EOF
									sSQL2 = "SELECT Title, ProductDesc1 " & _
											"FROM Products " & _
											"WHERE UPC='" & rs("UPC") & "'"
									Set rs2 = GetRecordset(ECOMM_SCHEMA, sSQL2)
									If Not rs2.EOF And Not rs2.BOF Then
										.Append "<div class='pairedProd'>"
											.Append "<a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs("UPC") & "' title='" & rs2("Title") & "'>"
												.Append "<img src='http://www.shopworldkitchen.com/usr/products/thumbs/" & rs("UPC") & ".jpg' alt='" & rs2("Title") & "' width='50' border='0' class='prodImg' onError='this.src=""http://www.shopworldkitchen.com/usr/noImage.gif""' />"
											.Append "</a>"
											.Append "<a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs("UPC") & "'>"
												.Append "<h4>Pyrex&reg; " & rs2("Title") & "</h4>"
											.Append "</a>"
										.Append "</div>"
									End If
									rs2.Close()
									Set rs2 = Nothing
									rs.MoveNext
								Loop
							End If
							rs.Close()
							Set rs = Nothing
						.Append "</div>"
						.Append "<div style='clear:both'></div>"
					.Append "</div>"
					.Append "<div id='productList'><div id='pencilHR'></div></div>"
				End If				
			End If				
			
			sSQL = "SELECT Products.UPC, Title, ProductDesc1, minPrice, salePrice, stockOut, newProduct " & _
				"FROM Products, ProdCatLinks " & _
				"WHERE ProdCatLinks.UPC = Products.UPC " & _
					"AND brandID = 2 " & _
					"AND ProductCategoryID = " & SubCatID & " " & _
					"AND inActive = 0 " & _
				"ORDER BY PriorityProduct DESC, " & SortBy
			Set rs = GetPagingRecordset(ECOMM_SCHEMA_RW,sSQL,NumPerPage)
			rs.PageSize = NumPerPage
			If Not rs.BOF AND Not rs.EOF then
				If rs.RecordCount=1 Then Response.Redirect "index.asp?pageId=" & pageId & "&CatID=" & catID & "&SubCatID=" & subCatID & "&upc=" & rs("UPC")
				rs.MoveFirst
				TotalPages = rs.PageCount
				rs.AbsolutePage = curpage
			End If			
			If Not rs.BOF AND Not rs.EOF then
				.Append "</div>"
				   Do While Not rs.EOF And recCount < rs.PageSize
					  stockOut = rs("stockOut")
					  If isNull(stockOut) Then stockOut = false
					  If rs("minPrice") = 0 Then stockOut = true
					  recCount = recCount + 1
					  .Append "<div class='productDetail'>"
						  .Append "<div class='productImg'>"
							  .Append "<a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs("UPC") & "' title='" & rs("title") & "'>"
								  .Append "<img src='http://www.shopworldkitchen.com/usr/products/thumbs/" & rs("UPC") & ".jpg' alt='" & rs("title") & "' width='100'  border='0' onError='this.src=""http://www.shopworldkitchen.com/usr/noImage.gif""' />"
							  .Append "</a>"
						  .Append "</div>"
						  .Append "<div class='productCont'>"
							  .Append "<h3><a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs("UPC") & "' title='" & rs("title") & "'>Pyrex&reg;  " & rs("Title") & "</a>"
								  If rs("NewProduct") Then .Append "<img src='webimgs/new.jpg' width='57' height='20' alt='New' title='New' />"
							  .Append "</h3>"
							  msDesc = rs("ProductDesc1") & ""
							  If LCase(Left(msDesc,3)) = "<p>" Then msDesc = Right(msDesc,Len(msDesc)-3)
							  If LCase(Right(msDesc,4)) = "</p>" Then msDesc = Left(msDesc,Len(msDesc)-4)
							  Set regex = New RegExp  
							  With regex  
								   .IgnoreCase = True 
								   .Global = True 
								   .Pattern = "(<a).+(</a>)"
								   msDesc = regex.Replace(msDesc,"")
								   .Pattern = "(<p>)"
								   msDesc = regex.Replace(msDesc,"") 
								   .Pattern = "(</p>)"
								   msDesc = regex.Replace(msDesc,"") 
							  End With 
							  Set Regex = Nothing
							  .Append "<p class='description'>" & msDesc
							  If rs("salePrice") <> 0 Then
								  .Append "<span class='salePriceUs'> " & formatCurrency(rs("salePrice"),2) & "</span> <span class='oldPrice'>" & formatCurrency(rs("minPrice"),2) & "</span>"
							  Else
								  .Append "<span class='minPriceUs'> " & formatCurrency(rs("minPrice"),2) & "</span>"
							  End If
							  .Append "</p>"
							  .Append "<a href='index.asp?pageId=" & pageId & "&CatID=" & CategoryID & "&SubCatID=" & SubCatID & "&upc=" & rs("UPC") & "' title='View Details'>"
								  .Append "<img src='/webimgs/viewDetailBtn.png' alt='View Details' width='104px' height='20px' />"
							  .Append "</a>"
							  .Append "<a href='http://www.shopworldkitchen.com/pyrex.asp?upc=" & rs("UPC") & "' title='Buy Now' target='_blank'>"
								  .Append "<img src='/webimgs/buyNowBtn.png' width='104px' height='20px' alt='Buy Now' />"
							  .Append "</a>"
						  .Append "</div>"
					  .Append "</div>"
					  rs.movenext
				  loop
			End if
			rs.Close()
			Set rs = Nothing
			.Append "</div>"
			GenerateListView = .ToString()
		End With
		Set moHTML = Nothing
	End Function	
End Class
%>


 