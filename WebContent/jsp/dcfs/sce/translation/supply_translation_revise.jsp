<%
/**   
 * @Title: supply_translation_revise.jsp
 * @Description:  预批补充翻译页面
 * @author panfeng   
 * @date 2014-10-16 
 * @version V1.0   
 */
%>

<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data dataItem = (Data)request.getAttribute("data");
	String RA_ID = dataItem.getString("RA_ID","");
	if("".equals(RA_ID)){
%>
<html>
	<div class="page-content">无补充数据！</div>
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="window.history.go(-1);"/>
		</div>
	</div>
</html>
<%}else{
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	
	Data adData = (Data)request.getAttribute("data");
	String UPLOAD_IDS = adData.getString("UPLOAD_IDS","");
	//获取附件信息ID
	String ra_id = adData.getString("RA_ID","");
	String user_org_id = "org_id=" + (String)request.getAttribute("ORG_ID") + ";ra_id=" + ra_id;
%>


<BZ:html>
<BZ:head>
    <title>预批补充翻译页面</title>
    <BZ:webScript edit="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<up:uploadResource/>
	<script>
	
	//补翻保存
	function _save() {
	if (_check(document.srcForm)) {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/sce/translation/supplyTranslationSave.action";
		
		document.srcForm.submit();
	  }
	}
	//补翻完成提交
	function _submit() {
	if (confirm("确定提交吗？提交后翻译信息无法修改！")) {
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/sce/translation/supplyTranslationSave.action";
		document.srcForm.submit();
	  }
	}
	//返回列表
	function _goback(){
		document.srcForm.action = path + "/sce/translation/supplyTranslationList.action";
		document.srcForm.submit();
	}
	
	</script>
</BZ:head>
<BZ:body property="data" codeNames="">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- 隐藏区域begin -->
    <BZ:input type="hidden" prefix="P_" field="RA_ID"				id="P_RA_ID"				defaultValue=""/> 
	<BZ:input type="hidden" prefix="R_" field="AT_ID"				id="R_AT_ID"				defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="AT_TYPE"        		id="R_AT_TYPE" 				defaultValue=""/> 
	<BZ:input type="hidden" prefix="R_" field="RI_ID"				id="R_RI_ID"				defaultValue=""/> 
	<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"	id="R_TRANSLATION_STATE"	defaultValue=""/> 
	<!-- 隐藏区域end -->
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			$('#tab-container').easytabs();
		})
	
	</script>	
	<!--通知信息:start-->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>补充通知信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">通知人</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">通知日期</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">补翻状态</td>
						<td class="bz-edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE" defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">补充内容</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<BZ:input prefix="P_" field="ADD_CONTENT_EN" id="P_ADD_CONTENT_EN" type="textarea" formTitle="补充内容" defaultValue="" maxlength="1000" style="width:80%;height:100px"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">补充附件</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--通知信息:end-->

	<!--翻译信息：start-->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>补充翻译信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">翻译内容</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<BZ:input prefix="P_" field="ADD_CONTENT_CN" id="P_ADD_CONTENT_CN" type="textarea" formTitle="翻译内容" defaultValue="" maxlength="1000" style="width:80%;height:100px"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">翻译附件</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadBody 
									attTypeCode="AF" 
									bigType="<%=AttConstants.AF %>"
									smallType="<%=AttConstants.AF_BFFJ %>"
									id="P_UPLOAD_IDS_CN"
									name="P_UPLOAD_IDS_CN"
									packageId="<%=ra_id %>"
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="<%=user_org_id %>"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"/>		
						</td>
					</tr>
					<tr>
						<td  class="bz-edit-data-title">翻译说明</td>
						<td  class="bz-edit-data-value" colspan="5">
						<BZ:input prefix="R_" field="TRANSLATION_DESC" id="R_TRANSLATION_DESC" type="textarea" formTitle="翻译说明" defaultValue="" maxlength="600" style="width:80%;height:100px"/>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
	</div>
	<!--翻译信息：end-->
	<br>
	<!-- 按钮区域:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="保&nbsp;&nbsp;存" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;
			<input type="button" value="提&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
			<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区域:end -->
	</BZ:form>
	</BZ:body>
</BZ:html>
<%}%>