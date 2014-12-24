<%
/**   
 * </div>@Title: PP_feedback_homepage.jsp
 * @Description: ���ú󱨸���ҳ
 * @author xugy
 * @date 2014-11-5����1:28:22
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%
Data data = (Data)request.getAttribute("data");
String SIGN_NO = data.getString("SIGN_NO");
int NUM = data.getInt("NUM");
String CHILD_TYPE = data.getString("CHILD_TYPE");
String IS_PUBLIC = data.getString("IS_PUBLIC");
%>
<html>
<head>
	<title>���ú󱨸���ҳ</title>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>

<script type="text/javascript">
//$(document).ready(function() {
	//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
//});
//

</script>
<style type="text/css">
	#tab{
		border-style: solid; 
		border-width: 2px;
		border-collapse: collapse;	
		border-spacing: 1;
	}
	#tab tr td {
		border: 1px black solid;
	}
	#tab tr th {
		border: 1px black solid;
	}
</style>
</head>
<body>
<div style="text-align: center;width:90%">
<div class="page-content"  style="width:100%">
<div class="wrapper">
<div id="PrintArea" style="text-align: center;width:100%;">
	<table style="width:100%;text-align: center" border="0">
		<tr>
			<td style="width: 10%;">&nbsp;</td>
			<td style="width: 80%;font-weight: bold;text-align:center;"><font size="5"><span class="title-black">�� �� �� �� �� �� ҳ</span></font></td>
			<td style="width: 10%;text-align: right;"><img src="<%=request.getContextPath() %>/barcode?msg=<%=SIGN_NO %>" style="height:60px" class="print-barcode"/></td>
		</tr>
		<tr>
			<td style="font-weight: bold;text-align:center;" colspan="3"><font size="5"><b><span class="title4">PAGE ONE FORM OF THE POST PLACEMENT REPORT</span></b></font>
			</td>
		</tr>
	</table>
	<br>
	<table id="tab" style="width:100%;text-align: center" class="table-print">
		<thead>
		<tr>
			<th width="10%">���<br>No.</th>
			<th width="45%">��&nbsp;Ϣ&nbsp;��&nbsp;��<br>INFORMATION CATEGORY</th>
			<th width="45%">��&nbsp;Ϣ&nbsp;��&nbsp;��<br>INFORMATION DETAILS</th>
		</tr>
		</thead>
		<tr>
			<td>1</td>
			<td>�ݽ������������֯����<br>Agency that Facilitated the Adoption</td>
			<td><%= data.getString("NAME_CN","")%><br> <%= data.getString("NAME_EN","")%></td>
		</tr>
		<tr>
			<td>2</td>
			<td>����������֪ͨ�顷���<br>Number of the Notice of Coming to China for Adoption</td>
			<td><%= data.getString("SIGN_NO","")%></td>
		</tr>
		<tr>
			<td>3</td>
			<td>����������֪ͨ�顷ǩ������<br>The issue date of the Notice of Coming to China for Adoption</td>
			<td><%= data.getDate("SIGN_DATE")%></td>
		</tr>
		<tr>
			<td>4</td>
			<td>���ú󱨸����<br>Report Sequence</td>
			<td>
				<table style="border: 0;width: 95%">
					<tr>
						<td style="border: 0;text-align:left">
						<input type="checkbox" <%if(NUM == 1){ %> checked="checked" <%} %> disabled="disabled">��1��<br>
						First
						</td>
						<td style="border: 0;text-align:left">
						<input type="checkbox" <%if(NUM == 2){ %> checked="checked" <%} %> disabled="disabled">��2��<br>
						Second
						</td>
						<td style="border: 0;text-align:left">
						<input type="checkbox" <%if(NUM == 3){ %> checked="checked" <%} %> disabled="disabled">��3��<br>
						Third
						</td>
					</tr>
					<tr>	
						<td style="border: 0;text-align:left">				
						<input type="checkbox" <%if(NUM == 4){ %> checked="checked" <%} %> disabled="disabled">��4��<br>
						Fourth
						</td>
						<td style="border: 0;text-align:left">
						<input type="checkbox" <%if(NUM == 5){ %> checked="checked" <%} %> disabled="disabled">��5��<br>
						Fifth
						</td>
						<td style="border: 0;text-align:left">
						<input type="checkbox" <%if(NUM == 6){ %> checked="checked" <%} %> disabled="disabled">��6��<br>
						Sixth
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>5</td>
			<td>��������ԭ����<br>Adoptee's Chinese Name</td>
			<td><%=data.getString("NAME","") %><br><%=data.getString("NAME_PINYIN","") %></td>
		</tr>
		<tr>
			<td>6</td>
			<td>��������������<br>Adoptee's New Name</td>
			<td><%=data.getString("CHILD_NAME_EN","") %></td>
		</tr>
		<tr>
			<td>7</td>
			<td>��������<br>Date of Birth</td>
			<td><%=data.getDate("BIRTHDAY") %></td>
		</tr>
		<tr>
			<td>8</td>
			<td>����ʱ����״��<br>Health Status at Adoption</td>
			<td style="text-align: left;">
				<input type="checkbox" <%if("1".equals(CHILD_TYPE)){ %> checked="checked" <%} %> disabled="disabled">����  Normal<br/>
				<input type="checkbox" <%if("2".equals(CHILD_TYPE)){ %> checked="checked" <%} %> disabled="disabled">����  Special Need
			</td>
		</tr>
		<tr>
			<td>9</td>
			<td>�����Ǽ�����<br>Date of Adoption Registration</td>
			<td><%=data.getDate("ADREG_DATE") %></td>
		</tr>
		<tr>
			<td>10</td>
			<td>�뼮����<br>Date of Naturalization</td>
			<td><%=data.getDate("NATION_DATE") %></td>
		</tr>
		<tr>
			<td>11</td>
			<td>��������<br>Father's Name</td>
			<td><%=data.getString("MALE_NAME","") %></td>
		</tr>
		<tr>
			<td>12</td>
			<td>��ĸ����<br>Mother's Name</td>
			<td><%=data.getString("FEMALE_NAME","") %></td>
		</tr>
		<tr>
			<td>13</td>
			<td>�繤�ҷ�����<br>Date of Home Visit by Social Worker</td>
			<td><%=data.getDate("VISIT_DATE") %></td>
		</tr>
		<tr>
			<td>14</td>
			<td>��ɱ�������<br>Date of Finishing the Report</td>
			<td><%=data.getDate("REPORT_DATE") %></td>
		</tr>
		<tr>
			<td>15</td>
			<td>���������������֯����<br>Agency that Finished the Report</td>
			<td><%=data.getString("ORG_NAME","") %></td>
		</tr>
		<tr>
			<td>16</td>
			<td colspan="2" style="text-align: left">
				<input type="checkbox" <%if("1".equals(IS_PUBLIC)){ %> checked="checked" <%} %> disabled="disabled">������ͬ���й���ͯ��������������ʹ�ñ����漰��Ƭ��������<br>The adopters agree that this report and photos attached be used for publicity by CCCWA<br>
				<input type="checkbox" <%if("0".equals(IS_PUBLIC)){ %> checked="checked" <%} %> disabled="disabled">�����˲�ͬ���й���ͯ��������������ʹ�ñ����漰��Ƭ��������<br>The adopters do not agree that this report and photos attached be used for publicity by CCCWA
			</td>
		</tr>
	</table>
</div>
<!-- ��ť�� ��ʼ -->
<div class="bz-action-frame">
	<div class="bz-action-edit" desc="��ť��">
	<br>
		<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>
		<br>
	</div>
</div>
</div>
</div>
</div>
<!-- ��ť�� ���� -->
</body>
<script>
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>
</html>
