<%
/**   
 * @Title: ST_appointment_accept_add.jsp
 * @Description: 省厅预约受理
 * @author xugy
 * @date 2014-10-2下午3:49:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>省厅预约受理</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//
function _isYes(v){
	if(v == "2"){
		$(".no").css("display","none");
	}
	if(v == "3"){
		$(".no").css("display","");
	}
}
//保存
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"appointment/saveSTAppointmentAcceptAdd.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"appointment/STAppointmentAcceptList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="AR_" field="AR_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>预约基本信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">通知书号</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">国家</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">收养组织</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">男收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">女收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">福利院</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">预约人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">联系电话</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_PHONE" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮箱</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_TEL" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">预约时间</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_DATE" defaultValue="" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养组织备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>预约确认</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%">审核人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEEDBACK_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">审核日期</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核结果</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AR_" field="ORDER_STATE" formTitle="审核结果" onchange="_isYes(this.value)">
								<BZ:option value="2">通过</BZ:option>
								<BZ:option value="3">不通过</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title"><span class="no" style="display: none;">建议时间</span></td>
						<td class="bz-edit-data-value">
							<span class="no" style="display: none;">
							<BZ:input prefix="AR_" field="SUGGEST_DATE" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" defaultValue="" formTitle="建议时间"/>
							</span>
						</td>
					</tr>
					<tr class="no" style="display: none;">
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AR_" field="REMARKS1" type="textarea" defaultValue="" style="width:99%;height:40px;" formTitle="备注"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提&nbsp;&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
