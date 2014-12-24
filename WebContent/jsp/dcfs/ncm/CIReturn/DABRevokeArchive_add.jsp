<%
/**   
 * @Title: DABRevokeArchive_add.jsp
 * @Description: 档案部撤销档案
 * @author xugy
 * @date 2014-12-17下午3:43:15
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

String CI_ID = data.getString("CI_ID");//儿童材料ID
String AF_ID = data.getString("AF_ID");//收养人文件ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>档案部撤销档案</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//保存
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"childInfoReturn/saveDABRevokeArchiveAdd.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"childInfoReturn/DABRevokeArchiveList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="F_" field="NAR_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="F_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="F_" field="AF_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="F_" field="MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
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
				<div>申请确认信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="15%">申请人</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="APPLY_USER" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title" width="15%">申请日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="APPLY_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">申请原因</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="APPLY_INFO" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">确认人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONFIRM_USER" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">确认日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONFIRM_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>确认结果</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="F_" field="CONFIRM_STATE" formTitle="确认结果" defaultValue="" notnull="请选择确认结果">
								<BZ:option value="">--请选择--</BZ:option>
								<BZ:option value="1">同意</BZ:option>
								<BZ:option value="2">不同意</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">确认说明</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="F_" field="CONFIRM_INFO" defaultValue="" style="width:98%;height:60px;" maxlength="1000"/>
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
