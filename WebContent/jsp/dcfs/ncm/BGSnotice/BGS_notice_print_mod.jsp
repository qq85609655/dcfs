<%
/**   
 * @Title: BGS_notice_print_mod.jsp
 * @Description: 办公室打印修改
 * @author xugy
 * @date 2014-9-16下午2:40:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
//Data data=(Data)request.getAttribute("data");


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>办公室打印修改</title>
	<BZ:webScript edit="true" tree="true" isAjax="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//保存并打印
function _saveAndPrint(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"notice/saveAndPrint.action";
	document.srcForm.submit();
}
//预览
function _printPreview(){
	var MI_ID = document.getElementById("MI_MI_ID").value;
	var smallType1 = "<%=AttConstants.LHSYZNTZS%>";
	var data1 = getData("com.dcfs.ncm.AjaxGetAttInfo","MI_ID="+MI_ID+"&smallType="+smallType1);
	var ID1 = data1.getString("ID");
	var ATT_NAME1 = data1.getString("ATT_NAME");
	var ATT_TYPE1 = data1.getString("ATT_TYPE");
	window.open(path + "/jsp/dcfs/common/pdfView.jsp?name="+ATT_NAME1+"&attId="+ID1+"&attTypeCode=AR&type="+ATT_TYPE1);
	
	var smallType2 = "<%=AttConstants.SWSYTZ%>";
	var data2 = getData("com.dcfs.ncm.AjaxGetAttInfo","MI_ID="+MI_ID+"&smallType="+smallType2);
	var ID2 = data2.getString("ID");
	var ATT_NAME2 = data2.getString("ATT_NAME");
	var ATT_TYPE2 = data2.getString("ATT_TYPE");
	window.open(path + "/jsp/dcfs/common/pdfView.jsp?name="+ATT_NAME2+"&attId="+ID2+"&attTypeCode=AR&type="+ATT_TYPE2);
}

//返回
function _goback(){
	document.srcForm.action=path+"notice/BGSNoticePrintList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data" codeNames="ETXB;WJLX;PROVINCE;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="MI_" field="MI_ID" id="MI_MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>通知书摘要信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">收文编号</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">收文日期</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
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
						<td class="bz-edit-data-title">男方</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">女方</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">儿童类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" checkValue="1=正常儿童;2=特需儿童;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">省份</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
						</td>
						<td class="bz-edit-data-title">福利院</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">报批日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_SUBMIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">签批日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">落款日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">寄发日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">寄发状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_STATE" defaultValue="" onlyValue="true" checkValue="0=未寄发;1=已寄发;"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>修改落款日期</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>落款日期</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:input prefix="MI_" field="NOTICE_SIGN_DATE" defaultValue="" type="date" notnull="落款日期不能为空"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="保存并打印" class="btn btn-sm btn-primary" onclick="_saveAndPrint()" />
			<input type="button" value="预&nbsp;&nbsp;&nbsp;览" class="btn btn-sm btn-primary" onclick="_printPreview()" />
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
