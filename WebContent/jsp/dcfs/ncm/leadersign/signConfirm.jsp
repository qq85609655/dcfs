<%
/**   
 * @Title: advice_feedback_confirm.jsp
 * @Description: 中心领导签批确认
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
Data data=(Data)request.getAttribute("LeaderSign_form_data");

String AF_ID = data.getString("AF_ID");//收养人文件ID
String CI_ID = data.getString("CI_ID");//儿童材料ID

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>中心领导签批确认</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//
//保存
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"leaderSing/signConfirm.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"leaderSing/findSignlist.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="LeaderSign_form_data" codeNames="WJLX;SYLX;SDFS;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden"  name="MI_ID" id="MI_ID" value="<BZ:dataValue field="MI_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="AF_ID" id="AF_ID" value="<BZ:dataValue field="AF_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="CI_ID" id="CI_ID" value="<BZ:dataValue field="CI_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="PROVINCE_ID" id="PROVINCE_ID" value="<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="COUNTRY_CODE" id="COUNTRY_CODE" value="<BZ:dataValue field="COUNTRY_CODE" defaultValue="" onlyValue="true"/>"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<tr>
						<td class="bz-edit-data-title">收养组织（CN）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">收养组织（EN）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文编号</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">材料锁定方式</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="LOCK_MODE" defaultValue="" codeName="SDFS"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人基本信息</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoSign.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>被收养人基本信息</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoSign.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>签批确认</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>签批日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:input prefix="F_" field="SIGN_DATE" defaultValue="" type="date" formTitle="签批日期" notnull="签批日期不能为空"/>
						</td>
						<td class="bz-edit-data-title" width="15%">签批意见</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:select prefix="F_" field="SIGN_STATE" formTitle="签批意见">
								<BZ:option value="1" selected="true">同意</BZ:option>
								<BZ:option value="2">不同意</BZ:option>
							</BZ:select>
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
