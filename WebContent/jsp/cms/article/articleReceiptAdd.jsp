<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data = (Data)request.getAttribute("data");
if(data==null){
	data=new Data();
}
String content = data.getString("CONTENT","");
String LOGIN_PERSON = data.getString("LOGIN_PERSON","");
String IS_HAVE_ATT = data.getString("IS_HAVE_ATT","");

%>
<BZ:html>
<BZ:head>
	<title>回复</title>
	<up:uploadResource/>
	<BZ:webScript edit="true"/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		
		/* $(".reply").click(function(){
			var RECEIPT_OBJECT = $(this).parents("tr").attr("id");
			$("#R_RECEIPT_OBJECT").val(RECEIPT_OBJECT);
			var RECEIPT_OBJECT_NAME = $(this).parents("tr").find(".RECEIPT_PERSON").text();
			$("#object").text("回复"+RECEIPT_OBJECT_NAME+"：");
		}); */
		
		$(".font").click(function(){
			$(".big2").removeClass("blod");
			$(".big2").removeClass("big");
			$(".medium2").removeClass("blod");
			$(".medium2").removeClass("medium");
			$(".smaller2").removeClass("blod");
			$(".smaller2").removeClass("smaller");
			
			$(this).addClass("blod");
			var css = $(this).attr("id");
			$(this).addClass(css);
			$("#content").removeClass().addClass(css); 
		});
	});
	
	function save(){
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		var ID = document.getElementById("R_ID").value;
		document.srcForm.action=path+"article/receiptSave.action?ID="+ID;
		document.srcForm.submit();
	}
	
	function cancel(){
		document.srcForm.action=path+"article/receiptList.action";
		document.srcForm.submit();
	}
</script>
<style type="text/css">
#apDiv4 {
	width:100%;
	border-bottom: 1px dotted #000;
}
.big{
	cursor: pointer;
	font-size: 24px;
}
.medium{
	cursor: pointer;
	font-size: 16px;
}
.smaller{
	cursor: pointer;
	font-size: 12px;
}
.blod{
	font-weight: bold;
	color: red;
}
</style>
<BZ:body property="data" codeNames="SYS_ORGAN;SYS_PERSON">
<BZ:form name="srcForm" id="srcForm" method="post" action=""  >
<BZ:input prefix="R_" field="ID" id="R_ID" defaultValue="" type="hidden"/>
	<div class="bz-action-frame">
		<div class="bz-action" desc="按钮区">
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="cancel()" />
		</div>
	</div>
	<div class="bz-edit clearfix" style="width: 90%;">
		<div>
			<div align="center">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<BZ:dataValue field="TITLE" defaultValue=""/>
			</div>
			<div class="bz-edit-data-content clearfix">
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="50%" />
						<col width="50%" />
					</colgroup>
					<tr>
						<td>
							发布时间【<BZ:dataValue field="CREATE_TIME" defaultValue="" type="date"/>】
						</td>
						<td style="text-align: right;">
							【内容字体：
							<font class="font big2" id="big" style="cursor: pointer;">大</font>
							<font class="font medium medium2 blod" id="medium" style="cursor: pointer;">中</font>
							<font class="font smaller2" id="smaller" style="cursor: pointer;">小</font>
							】
						</td>
					</tr>
					<tr>
						<td colspan="2" height="30px">
							<div id="apDiv4"></div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="content" class="medium">
								<%=content %>
							</div>
						</td>
					</tr>
					<%
					if("1".equals(IS_HAVE_ATT)){
					%>
					<tr>
						<td colspan="2">
							<up:uploadList id="PACKAGE_ID" attTypeCode="CMS_ARTICLE_ATT" packageId='<%=data.getString("PACKAGE_ID","") %>' />
						</td>
					</tr>
					<%} %>
					<tr>
						<td colspan="2" height="30px">
							<div id="apDiv4"></div>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0">
					<BZ:for property="dl" fordata="mydata">
						<tr id="<BZ:data field="RECEIPT_PERSON" onlyValue="true"/>" style="width: 50px;">
							<td style="width: 15%;border: 1px white solid;background-color: #f9f9f9;text-align: right;">
								<BZ:data field="RECEIPT_PERSON" defaultValue="" className="RECEIPT_PERSON" codeName="SYS_PERSON"/>：
							</td>
							<td style="width: 65%;border: 1px white solid;background-color: #f9f9f9;">
								<BZ:data field="RECEIPT_CONTENT" defaultValue="" />
							</td>
							<td style="width: 20%;border: 1px white solid;background-color: #f9f9f9;">
								<BZ:data field="RECEIPT_TIME" defaultValue="" />
							</td>
						</tr>
					</BZ:for>
				</table>
			</div>
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>
