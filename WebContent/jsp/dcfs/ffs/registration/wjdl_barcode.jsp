<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="hx.database.databean.*"%>
<BZ:html>
<BZ:head>
	<title>生成条形码</title>
	<BZ:webScript edit="true" />
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
	<script>
	
	//页面返回
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
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table table-print" border="0" style="width: 400px;" align="center">
					<tr>
						<td class="bz-edit-data-title" width="30%">收文编号</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">登记日期</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="REG_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">收养组织</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">文件类型</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">男收养人</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">女收养人</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="REG_REMARK" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table table-print" border="0" style="width: 400px;" align="center">
					<tr>
						<td class="bz-edit-data-value" width="50%" style="text-align: center;">
							<font face="黑体" size="6"><b><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></b></font>
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
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">打印</button>&nbsp;&nbsp;
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	<script>
	//打印控制语句
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
</BZ:body>
</BZ:html>
