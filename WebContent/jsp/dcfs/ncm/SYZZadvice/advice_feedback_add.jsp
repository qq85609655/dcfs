<%
/**   
 * @Title: advice_feedback_add.jsp
 * @Description: 收养组织征求意见反馈
 * @author xugy
 * @date 2014-9-11下午8:26:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data=(Data)request.getAttribute("data");
String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head language="EN">
	<title>收养组织征求意见反馈</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//提交
function _submit(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"advice/adviceFeedbackSave.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"advice/SYZZAdviceList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data" codeNames="ETXB;SYS_COUNTRY_GOVMENT;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" field="IS_CONVENTION_ADOPT" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>匹配信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">男收养人姓名</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">女收养人姓名</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">被收养人（中）</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">被收养人性别（中）</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">被收养人（英）</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">被收养人性别（英）</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">被收养人出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">通知日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>反馈意见信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<%
					if("1".equals(IS_CONVENTION_ADOPT)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>收养国中央机关</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:select prefix="F_" field="ADVICE_GOV_ID" defaultValue="" isCode="true" codeName="SYS_COUNTRY_GOVMENT" width="90%;" formTitle="收养国中央机关" notnull="Please select the Central Authority of Recriving State">
								<BZ:option value="">--Please secect--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<%} %>
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>反馈意见</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:input type="textarea" prefix="F_" field="ADVICE_FEEDBACK_OPINION" defaultValue="" style="width:98%;height:60px;" maxlength="1000" notnull="Please fill in the opinion"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提&nbsp;&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
