<%
/**   
 * @Title: DAB_archive_release_filing.jsp
 * @Description: 档案部解档
 * @author xugy
 * @date 2014-11-2下午4:25:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>档案部解档</title>
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
	if (confirm('确定解档？')) {
		document.srcForm.action=path+"notice/saveDABReleaseFiling.action";
		document.srcForm.submit();
	}
}
//返回
function _goback(){
	document.srcForm.action=path+"notice/DABArchiveFilingList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="AI_" field="ARCHIVE_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>解档信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<tr>
						<td class="bz-edit-data-title" width="20%">档案号</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">归档日期</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ARCHIVE_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">解档人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CANCLE_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">解档日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CANCLE_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>解档原因</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="AI_" field="CANCLE_REASON" defaultValue="" style="width:98%;height:60px;" notnull="解档原因不能为空"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="解&nbsp;&nbsp;&nbsp;档" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
