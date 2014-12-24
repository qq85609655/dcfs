<%
/**   
 * @Title: SYZZ_appointment_add.jsp
 * @Description: 收养组织预约申请添加
 * @author xugy
 * @date 2014-9-30上午10:23:23
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
<BZ:head language="EN">
	<title>预约申请添加</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//保存
function _save(ORDER_STATE){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"appointment/SYZZAppointmentSave.action?ORDER_STATE="+ORDER_STATE;
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"appointment/SYZZAppointmentRecordList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="AR_" field="AR_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AR_" field="MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>预约基本信息(Appointment information)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">男收养人<br>Adoptive father</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">女收养人<br>Adoptive mother</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">文件类型<br>Document type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title">省份<br>Province</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">福利院<br>SWI</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">姓名<br>Name</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">性别<br>Sex</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">签批号<br>Application number</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养登记机关名称（中文）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REG_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养登记机关名称（英文）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REG_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址（中文）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_ADDRESS_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址（英文）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_ADDRESS_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">联系人（中文）</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">联系人（英文）</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_NAMEPY" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">联系电话</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_TEL" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">邮箱</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_MAIL" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>预约申请信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>预约时间<br>Date of appointment</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="AR_" field="ORDER_DATE" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="lang:'en'" defaultValue="" formTitle="预约时间" notnull="预约时间不能为空"/>
						</td>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>预约人联系电话</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="AR_" field="ORDER_PHONE" defaultValue="" formTitle="预约人联系电话" notnull="预约人联系电话不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>预约人邮箱</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AR_" field="ORDER_TEL" defaultValue="" style="width:50%;" formTitle="预约人邮箱" notnull="预约人邮箱不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注<br>Remarks</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AR_" field="REMARKS" type="textarea" defaultValue="" style="width:99%;height:40px;" formTitle="备注"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save('0')" />&nbsp;
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_save('1')" />&nbsp;
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
