function PrintTableToExcelEx(objTab)
{
	//创建Excel对象
	try 
	{
		var xls = new ActiveXObject( "Excel.Application" );
	}
	catch(e) 
	{
		alert( "您必须安装Excel电子表格软件，同时浏览器须使用“ActiveX 控件”，您的浏览器须允许执行控件。 请点击【帮助】了解浏览器设置方法！");
		return false;
	}
	

	//添加并激活一个worksheet
	var xlBook = xls.Workbooks.Add;
	var xlsheet = xlBook.Worksheets(1);

	var CurX = 1;
	var CurY = 1;

	for (var i = 0; i < objTab.rows.length; i++)//遍历表格的每一行
	{
		for (var j = 0; j < objTab.rows[i].cells.length; j++)//遍历同一行的每一个单元格
		{
			var cell = objTab.rows[i].cells[j];//当前遍历的单元格
			
			var v = cell.outerText;
			
			if ( cell.children != null && cell.children.length != 0 )
			{
				v = "";
				for ( var k = 0; k < cell.children.length; k++ )
				{
					var CellChild = cell.children[k];
				
					switch (CellChild.type)
					{
						case "select-one"://如果是单选的下拉框，则提取被选中的值
							for ( var l = 0; l < CellChild.options.length; l++ )
								if ( CellChild.options[l].selected ) v += CellChild.options[l].text;
									break;
						case "text"://文本框
							v += CellChild.value;
							break;
						case "checkbox"://单选框
							v += CellChild.checked ? "√" : "□";
							break;
						case undefined:
							v += cell.outerText;
							break;
						case "hidden"://隐藏域
							break;
						default:
							//v += CellChild.id + "/";
							//v += CellChild.tagname + "/";
							//v += CellChild.type + "/"
							v += CellChild.value;
							break; 
					}//end of switch (CellChild.type)
				}//end of for ( var k = 0; k < cell.children.length; k++ )
			}//end of if ( cell.children != null && cell.children.length != 0 )
		
			while ( xlsheet.Cells(CurX,CurY).MergeCells ) CurY++;
		
			try
			{
				xlsheet.Cells(CurX, CurY).RowHeight = cell.offsetHeight;
				xlsheet.Cells(CurX, CurY).ColumnWidth    = cell.offsetWidth;
			}
			catch(e) 
			{
				//每行和每列只能设置一次高度和宽度，设置多次就会出现异常
			}

			xlsheet.Cells(CurX, CurY).HorizontalAlignment = 2; 
			var align = cell.getAttribute("align");
			switch ( align )
			{
				case "left":
					xlsheet.Cells(CurX, CurY).HorizontalAlignment = 2;//XlHalign.xlHalignLeft;
					break;
				case "center":
					xlsheet.Cells(CurX, CurY).HorizontalAlignment = 3;;//XlHalign.xlHalignCenter; 
					break;
				case "right":
					xlsheet.Cells(CurX, CurY).HorizontalAlignment = 4;//XlHalign.xlHalignRight;
					break;
			}//end of switch ( align )
			xlsheet.Cells(CurX, CurY).WrapText = true;
			xlsheet.Cells(CurX, CurY).VerticalAlignment = 2;
			xlsheet.Cells(CurX, CurY).Value = v;
			xlsheet.Cells(CurX, CurY).Borders.LineStyle = 1;
			
			//加粗第一列
			if( CurY == 1)
			{
				with (xls.Range(xls.Cells(CurX, CurY), xls.Cells(CurX, CurY)))
				{
					Font.FontStyle = "加粗"
				}
			}
			var rowSpan = cell.getAttribute("RowSpan");
			var colSpan = cell.getAttribute("ColSpan");
			if ( rowSpan >= 2 || colSpan >= 2 )
			{
				var R = xls.Range(xls.Cells(CurX, CurY), xls.Cells(CurX + rowSpan - 1, CurY + colSpan - 1));
				R.MergeCells = true;
				R.Borders.LineStyle = 1;
			}
			CurY++; 
		}//end of for (var j = 0; j < objTab.rows[i].cells.length; j++)
		
		CurX++;
		CurY = 1;
	}//end of for (var i = 0; i < objTab.rows.length; i++)
	xlsheet.Columns.AutoFit; //自动适应大小，否则单元格会很大
	xls.visible = true;
	return;
}
