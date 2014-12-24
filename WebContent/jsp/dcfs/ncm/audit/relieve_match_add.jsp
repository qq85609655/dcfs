<%
/**   
 * @Title: relieve_match_add.jsp
 * @Description: 解除匹配
 * @author xugy
 * @date 2014-9-4下午5:38:06
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="hx.util.InfoClueTo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String AF_ID = data.getString("AF_ID");//收养人文件ID
String CI_ID = data.getString("CI_ID");//儿童材料ID
String FILE_TYPE = data.getString("FILE_TYPE");//文件类型

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>解除匹配</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
	//
	function _submit(){
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"matchAudit/relieveMatchSave.action";
		document.srcForm.submit();
	}
	//返回儿童匹配列表
	function _goback(){
		document.srcForm.action=path+"matchAudit/matchAuditList.action";
		document.srcForm.submit();
	}
	//
	function _changeAfterRelieve(REVOKE_MATCH_TYPE){
		var tab = document.getElementById("tab");
		var id = tab.rows[2].id;
		if(REVOKE_MATCH_TYPE == "1"){//只退文
			if(id == "returnReason"){
				tab.deleteRow(document.getElementById("returnReason").rowIndex);
			}
			var newTr = tab.insertRow(2);
			newTr.id="returnReason";
			var newTd1 = newTr.insertCell();
			newTd1.className="bz-edit-data-title";
			var newTd2 = newTr.insertCell();
			newTd2.className="bz-edit-data-value";
			newTd2.colSpan="3";
			
			var af_relieve_title=document.getElementById("af_relieve_title").innerHTML;
			newTd1.innerHTML=af_relieve_title;
			var af_relieve_value=document.getElementById("af_relieve_value").innerHTML;
			newTd2.innerHTML=af_relieve_value;
		}
		if(REVOKE_MATCH_TYPE == "2"){//只退材料
			if(id == "returnReason"){
				tab.deleteRow(document.getElementById("returnReason").rowIndex);
			}
			var newTr = tab.insertRow(2);
			newTr.id="returnReason";
			var newTd1 = newTr.insertCell();
			newTd1.className="bz-edit-data-title";
			var newTd2 = newTr.insertCell();
			newTd2.className="bz-edit-data-value";
			newTd2.colSpan="3";
			
			var ci_relieve_title=document.getElementById("ci_relieve_title").innerHTML;
			newTd1.innerHTML=ci_relieve_title;
			var ci_relieve_value=document.getElementById("ci_relieve_value").innerHTML;
			newTd2.innerHTML=ci_relieve_value;
		}
		if(REVOKE_MATCH_TYPE == "3"){//重新匹配
			tab.deleteRow(2);
		}
		if(REVOKE_MATCH_TYPE == "4"){//退文退材料
			if(id == "returnReason"){
				tab.deleteRow(document.getElementById("returnReason").rowIndex);
			}
			var newTr = tab.insertRow(2);
			newTr.id="returnReason";
			var newTd1 = newTr.insertCell();
			newTd1.className="bz-edit-data-title";
			var newTd2 = newTr.insertCell();
			newTd2.className="bz-edit-data-value";
			var newTd3 = newTr.insertCell();
			newTd3.className="bz-edit-data-title";
			var newTd4 = newTr.insertCell();
			newTd4.className="bz-edit-data-value";
			
			var af_relieve_title=document.getElementById("af_relieve_title").innerHTML;
			newTd1.innerHTML=af_relieve_title;
			var af_relieve_value=document.getElementById("af_relieve_value").innerHTML;
			newTd2.innerHTML=af_relieve_value;
			var ci_relieve_title=document.getElementById("ci_relieve_title").innerHTML;
			newTd3.innerHTML=ci_relieve_title;
			var ci_relieve_value=document.getElementById("ci_relieve_value").innerHTML;
			newTd4.innerHTML=ci_relieve_value;
		}
		
	}
	//查看同胞信息
	function _viewEtcl(CHILD_NOs){
		$.layer({
			type : 2,
			title : "儿童材料查看",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			//page : {dom : '#planList'},
			iframe: {src: '<BZ:url/>/mormalMatch/showTwinsCI.action?CHILD_NOs='+CHILD_NOs},
			area: ['1050px','580px'],
			offset: ['100px' , '50px']
		});
	}
	</script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;">
<div id="af_relieve_title" style="display: none;">
	<font color="red">*</font>退文原因
</div>
<div id="af_relieve_value" style="display: none;">
	<BZ:input field="AF_RETURN_REASON" type="textarea" defaultValue="" formTitle="退文原因" style="width:99%;height:40px;" notnull="退文原因不能为空"/>
</div>
<div id="ci_relieve_title" style="display: none;">
	<font color="red">*</font>退材料原因
</div>
<div id="ci_relieve_value" style="display: none;">
	<BZ:input field="CI_RETURN_REASON" type="textarea" defaultValue="" formTitle="退材料原因" style="width:99%;height:40px;" notnull="退材料原因不能为空"/>
</div>
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="MI_" field="MI_ID" defaultValue="" type="hidden"/>
	<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
	<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养人基本信息</div>
				</div>
				<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童基本信息</div>
				</div>
				<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFirst.action?CI_ID=<%=CI_ID%>"></iframe>
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>解除匹配信息</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0" id="tab">
						<tr>
							<td class="bz-edit-data-title" width="20%">解除日期</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REVOKE_MATCH_DATE" defaultValue="" onlyValue="true" type="date"/>
							</td>
							<td class="bz-edit-data-title" width="20%">解除人</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REVOKE_MATCH_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<%
							if("23".equals(FILE_TYPE)){
							%>
							<td class="bz-edit-data-value" colspan="4" style="font-size: 14pt;font-weight: bold;color: red;">
								此文件的文件类型为“特双”，解除匹配后文件转为“特普”，如要退文或重新匹配，待文件转为“特普”后再进行处置。
							</td>
							<%    
							}else{
							%>
							<td class="bz-edit-data-title"><font color="red">*</font>解除匹配类型</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:select prefix="MI_" field="REVOKE_MATCH_TYPE" onchange="_changeAfterRelieve(this.value)" defaultValue="3" formTitle="解除匹配类型">
									<BZ:option value="1">退文</BZ:option>
									<%-- <BZ:option value="2">退材料</BZ:option> --%>
									<BZ:option value="3">重新匹配</BZ:option>
									<%-- <BZ:option value="4">退文退材料</BZ:option> --%>
								</BZ:select>
							</td>
							<%} %>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>解除匹配原因</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="MI_" field="REVOKE_MATCH_REASON" type="textarea" defaultValue="" style="width:99%;height:60px;" notnull="解除匹配原因不能为空"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提&nbsp;&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
