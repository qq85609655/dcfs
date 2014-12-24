function PrintTableToExcelEx(objTab)
{
	//����Excel����
	try 
	{
		var xls = new ActiveXObject( "Excel.Application" );
	}
	catch(e) 
	{
		alert( "�����밲װExcel���ӱ�������ͬʱ�������ʹ�á�ActiveX �ؼ��������������������ִ�пؼ��� �������������˽���������÷�����");
		return false;
	}
	

	//��Ӳ�����һ��worksheet
	var xlBook = xls.Workbooks.Add;
	var xlsheet = xlBook.Worksheets(1);

	var CurX = 1;
	var CurY = 1;

	for (var i = 0; i < objTab.rows.length; i++)//��������ÿһ��
	{
		for (var j = 0; j < objTab.rows[i].cells.length; j++)//����ͬһ�е�ÿһ����Ԫ��
		{
			var cell = objTab.rows[i].cells[j];//��ǰ�����ĵ�Ԫ��
			
			var v = cell.outerText;
			
			if ( cell.children != null && cell.children.length != 0 )
			{
				v = "";
				for ( var k = 0; k < cell.children.length; k++ )
				{
					var CellChild = cell.children[k];
				
					switch (CellChild.type)
					{
						case "select-one"://����ǵ�ѡ������������ȡ��ѡ�е�ֵ
							for ( var l = 0; l < CellChild.options.length; l++ )
								if ( CellChild.options[l].selected ) v += CellChild.options[l].text;
									break;
						case "text"://�ı���
							v += CellChild.value;
							break;
						case "checkbox"://��ѡ��
							v += CellChild.checked ? "��" : "��";
							break;
						case undefined:
							v += cell.outerText;
							break;
						case "hidden"://������
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
				//ÿ�к�ÿ��ֻ������һ�θ߶ȺͿ�ȣ����ö�ξͻ�����쳣
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
			
			//�Ӵֵ�һ��
			if( CurY == 1)
			{
				with (xls.Range(xls.Cells(CurX, CurY), xls.Cells(CurX, CurY)))
				{
					Font.FontStyle = "�Ӵ�"
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
	xlsheet.Columns.AutoFit; //�Զ���Ӧ��С������Ԫ���ܴ�
	xls.visible = true;
	return;
}
