<%
/**   
 * @Title: advice_feedback_confirm.jsp
 * @Description: 安置部征求意见反馈确认
 * @author xugy
 * @date 2014-9-12上午10:15:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");
String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT");

String CI_ID = data.getString("CI_ID");//儿童材料ID
String AF_ID = data.getString("AF_ID");//收养人文件ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>安置部征求意见反馈确认</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//
function _change(obj){
	var ADVICE_FEEDBACK_RESULT = obj.value;
	var tab = document.getElementById("tab");
	var tr = document.getElementById("insertTr");
	var index = tr.rowIndex + 1;
	
	var id = tab.rows[index].id;
	if(id == "returnReason"){
		var returnReason = document.getElementById("returnReason");
		var rowIndex =  returnReason.rowIndex;
		tab.deleteRow(rowIndex);
	}
	
	var endDateTitle = document.getElementById("endDateTitle");
	var endDateValue = document.getElementById("endDateValue");
	endDateTitle.innerHTML="";
	endDateValue.innerHTML="";
	if(ADVICE_FEEDBACK_RESULT == "4"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "退文";
		
		var newTr = tab.insertRow(index);
		newTr.id="returnReason";
		var newTd1 = newTr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = newTr.insertCell();
		newTd2.className="bz-edit-data-value";
		newTd2.colSpan="3";
		
		var title=document.getElementById("title-one").innerHTML;
		newTd1.innerHTML=title;
		var value=document.getElementById("value-one").innerHTML;
		newTd2.innerHTML=value;
	}else if(ADVICE_FEEDBACK_RESULT == "3"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "重新匹配";
	}else if(ADVICE_FEEDBACK_RESULT == "2"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "暂停";
		
		var title1=document.getElementById("title-three").innerHTML;
		endDateTitle.innerHTML=title1;
		var value1=document.getElementById("value-three").innerHTML;
		endDateValue.innerHTML=value1;
		
		var newTr = tab.insertRow(index);
		newTr.id="returnReason";
		var newTd1 = newTr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = newTr.insertCell();
		newTd2.className="bz-edit-data-value";
		newTd2.colSpan="3";
		
		var title=document.getElementById("title-two").innerHTML;
		newTd1.innerHTML=title;
		var value=document.getElementById("value-two").innerHTML;
		newTd2.innerHTML=value;
	}else if(ADVICE_FEEDBACK_RESULT == "1"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "同意";
	}
}
//保存
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"advice/feedbackConfirmSave.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;ETSFLX;WJLX;SYLX;">
<div id="title-one" style="display: none;">
	<font color="red">*</font>退文原因
</div>
<div id="value-one" style="display: none;">
	<BZ:input type="textarea" prefix="R_" field="RETURN_REASON" defaultValue="" style="width:98%;height:60px;" maxlength="1000" notnull="请填写退文原因"/>
</div>
<div id="title-two" style="display: none;">
	<font color="red">*</font>暂停原因
</div>
<div id="value-two" style="display: none;">
	<BZ:input type="textarea" prefix="R_" field="PAUSE_REASON" defaultValue="" style="width:98%;height:60px;" maxlength="1000" notnull="请填写暂停原因"/>
</div>
<div id="title-three" style="display: none;">
	<font color="red">*</font>暂停期限
</div>
<div id="value-three" style="display: none;">
	<BZ:input prefix="R_" field="END_DATE" defaultValue="" type="date" notnull="暂停期限不能为空"/>
</div>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" field="MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收养组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文编号 </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">批准书日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">到期日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人家庭信息</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>儿童信息</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>反馈确认</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="15%">公约收养</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/>
						</td>
						<td class="bz-edit-data-title" width="15%">通知日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<%
					if("1".equals(IS_CONVENTION_ADOPT)){
					%>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>收养国中央机关</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="F_" field="ADVICE_GOV_ID" defaultValue="" isCode="true" codeName="COUNTRY_GOVMENT_LIST" width="50%" formTitle="收养国中央机关" notnull="请选择收养国中央机关">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>签署日期</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="F_" field="ADVICE_FEEDBACK_DATE" defaultValue="" type="date" notnull="签署日期不能为空"/>
						</td>
					</tr>
					<%} %>
					<tr id="insertTr">
						<td class="bz-edit-data-title"><font color="red">*</font>反馈结果</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="F_" field="ADVICE_FEEDBACK_RESULT" formTitle="反馈结果" onchange="_change(this)">
								<BZ:option value="1">同意</BZ:option>
								<BZ:option value="2">暂停</BZ:option>
								<BZ:option value="3">重新匹配</BZ:option>
								<BZ:option value="4">退文</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title" id="endDateTitle"></td>
						<td class="bz-edit-data-value" id="endDateValue"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>反馈意见</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="F_" field="ADVICE_FEEDBACK_OPINION" id="F_ADVICE_FEEDBACK_OPINION" defaultValue="同意" style="width:98%;height:60px;" notnull="请填写反馈意见" maxlength="1000"/>
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="F_" field="ADVICE_FEEDBACK_REMARKS" defaultValue="" style="width:98%;height:60px;" maxlength="1000"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="确&nbsp;&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
