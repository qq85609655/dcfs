<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="hx.database.databean.*"%>
<BZ:html>
<BZ:head>
	<title>����������</title>
	<BZ:webScript edit="true" />
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
	<script>
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;FYLB;JFFS;SYZZ">
	
	<BZ:input field="AF_ID" id="AF_ID" type="hidden" defaultValue="" />
	<div id='PrintArea'>
		<BZ:for property="printShow" fordata="fordata">
		<script type="text/javascript">
		<%
			String file_no = ((Data)pageContext.getAttribute("fordata")).getString("FILE_NO","");
		%>
		</script>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table table-print" border="0" style="width: 400px;" align="center">
					<tr>
						<td class="bz-edit-data-title" width="30%">���ı��</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">�Ǽ�����</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="REG_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">������֯</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">�ļ�����</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">��������</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">Ů������</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="REG_REMARK" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table table-print" border="0" style="width: 400px;" align="center">
					<tr>
						<td class="bz-edit-data-value" width="50%" style="text-align: center;">
							<font face="����" size="6"><b><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></b></font>
						</td>
						<td class="bz-edit-data-value" width="50%" style="text-align: center;">
							<img src="<%=request.getContextPath() %>/barcode?msg=<%=file_no %>" height="80px" width=135px/>
						</td>
					</tr>
				</table>
				<h1>&nbsp;</h1>
			</div>
		</BZ:for>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">��ӡ</button>&nbsp;&nbsp;
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	<script>
	//��ӡ�������
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
</BZ:body>
</BZ:html>
