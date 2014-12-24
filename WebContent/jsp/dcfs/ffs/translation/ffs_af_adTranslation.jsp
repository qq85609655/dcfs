<%
/**   
 * @Title: ffs_af_adTranslation.jsp
 * @Description:  文件补翻页
 * @author wangz   
 * @date 2014-8-27
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
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	Data dataItem = (Data)request.getAttribute("data");
	if(dataItem==null){
%>
<html>
	<div class="page-content">无数据！</div>
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="window.history.go(-1);"/>
		</div>
	</div>
</html>
<%}else{
	String NOTICE_FILEID = dataItem.getString("NOTICE_FILEID","");
	String TRANSLATION_FILEID = dataItem.getString("TRANSLATION_FILEID","");
	String orgId = dataItem.getString("ADOPT_ORG_ID","");
	String afId = dataItem.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
%>

<BZ:html>
<BZ:head>
    <title>文件补翻页面</title>
    <BZ:webScript edit="true"/>
	<up:uploadResource/>
</BZ:head>
<BZ:body property="data" codeNames="">
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		})

	//翻译保存
	function _save() {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/ffs/ffsaftranslation/adTranslationSave.action";		
		document.srcForm.submit();
	}
	//翻译完成提交
	function _submit() {
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/ffs/ffsaftranslation/adTranslationSave.action";
		document.srcForm.submit();
	}
	//返回列表
	function _goback(){
		document.srcForm.action = path + "/ffs/ffsaftranslation/adTranslationList.action";
		document.srcForm.submit();
	}
	
	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="AT_ID"				id="R_AT_ID"				defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="AF_ID"				id="R_AF_ID"				defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"	id="R_TRANSLATION_STATE"	defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_TYPE" 	id="R_TRANSLATION_TYPE"		defaultValue=""/>
        
		<!-- 隐藏区域end -->
		<!--通知信息:start-->
		<div id="tab-retranslation">
			<br>
			<table class="specialtable" align="center" style='width:98%;text-align:center'>
				<tr>
                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>通知信息</b></td>
                </tr>
				<tr>
					<td class="edit-data-title" width="15%">通知人</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">通知日期</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">补翻状态</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE"  onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">补翻原因</td>
					<td class="edit-data-value" colspan="5" width="85%"><BZ:dataValue field="AA_CONTENT" defaultValue="" /></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">补翻附件</td>
					<td class="edit-data-value" colspan="5" width="85%">
					<up:uploadList id="NOTICE_FILEID" firstColWidth="20px" attTypeCode="AF" packageId='<%=NOTICE_FILEID%>'/>
					</td>
				</tr>
			</table>			
		</div>
		<!--通知信息:end-->

		<!--翻译信息：start-->
		<div class='panel-container'>
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
					<td class="edit-data-title" colspan="6" style="text-align:center"><b>翻译信息</b></td>
				</tr>
				
				<tr>
					<td class="edit-data-title">翻译附件</td>
					<td class="edit-data-value" colspan="5" width="85%">
					<up:uploadBody name="R_TRANSLATION_FILEID" id="R_TRANSLATION_FILEID" attTypeCode="AF" packageId="<%=TRANSLATION_FILEID%>" smallType="<%=AttConstants.AF_BFFJ %>"  bigType="AF" diskStoreRuleParamValues="<%=strPar%>" autoUpload="false" queueStyle="border: solid 1px #CCCCCC;" queueTableStyle="padding:2px" selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;" selectAreaStyle="width:80%" selectFrameStyle="80%" queueTableStyle="width:80%"/>
					</td>					
				</tr>
				<tr>
					<td  class="edit-data-title">翻译说明</td>
					<td  class="edit-data-value" colspan="5">
					<BZ:input prefix="R_" field="TRANSLATION_DESC" id="R_TRANSLATION_DESC" type="textarea" formTitle="翻译说明" defaultValue="" maxlength="600" style="width:80%;height:100px"/>
					</td>
				</tr>
				
				<tr>
					<td class="edit-data-title" width="15%">翻译单位</td>
					<td class="edit-data-value" width="18%"><BZ:dataValue field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">翻译人</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">翻译日期</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
				</tr>
			</table>
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