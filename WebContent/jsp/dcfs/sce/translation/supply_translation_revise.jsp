<%
/**   
 * @Title: supply_translation_revise.jsp
 * @Description:  Ԥ�����䷭��ҳ��
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
	<div class="page-content">�޲������ݣ�</div>
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="window.history.go(-1);"/>
		</div>
	</div>
</html>
<%}else{
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	
	Data adData = (Data)request.getAttribute("data");
	String UPLOAD_IDS = adData.getString("UPLOAD_IDS","");
	//��ȡ������ϢID
	String ra_id = adData.getString("RA_ID","");
	String user_org_id = "org_id=" + (String)request.getAttribute("ORG_ID") + ";ra_id=" + ra_id;
%>


<BZ:html>
<BZ:head>
    <title>Ԥ�����䷭��ҳ��</title>
    <BZ:webScript edit="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<up:uploadResource/>
	<script>
	
	//��������
	function _save() {
	if (_check(document.srcForm)) {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/sce/translation/supplyTranslationSave.action";
		
		document.srcForm.submit();
	  }
	}
	//��������ύ
	function _submit() {
	if (confirm("ȷ���ύ���ύ������Ϣ�޷��޸ģ�")) {
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/sce/translation/supplyTranslationSave.action";
		document.srcForm.submit();
	  }
	}
	//�����б�
	function _goback(){
		document.srcForm.action = path + "/sce/translation/supplyTranslationList.action";
		document.srcForm.submit();
	}
	
	</script>
</BZ:head>
<BZ:body property="data" codeNames="">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- ��������begin -->
    <BZ:input type="hidden" prefix="P_" field="RA_ID"				id="P_RA_ID"				defaultValue=""/> 
	<BZ:input type="hidden" prefix="R_" field="AT_ID"				id="R_AT_ID"				defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="AT_TYPE"        		id="R_AT_TYPE" 				defaultValue=""/> 
	<BZ:input type="hidden" prefix="R_" field="RI_ID"				id="R_RI_ID"				defaultValue=""/> 
	<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"	id="R_TRANSLATION_STATE"	defaultValue=""/> 
	<!-- ��������end -->
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			$('#tab-container').easytabs();
		})
	
	</script>	
	<!--֪ͨ��Ϣ:start-->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����֪ͨ��Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">֪ͨ��</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">֪ͨ����</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">����״̬</td>
						<td class="bz-edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE" defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<BZ:input prefix="P_" field="ADD_CONTENT_EN" id="P_ADD_CONTENT_EN" type="textarea" formTitle="��������" defaultValue="" maxlength="1000" style="width:80%;height:100px"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">���丽��</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--֪ͨ��Ϣ:end-->

	<!--������Ϣ��start-->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���䷭����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<BZ:input prefix="P_" field="ADD_CONTENT_CN" id="P_ADD_CONTENT_CN" type="textarea" formTitle="��������" defaultValue="" maxlength="1000" style="width:80%;height:100px"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���븽��</td>
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
						<td  class="bz-edit-data-title">����˵��</td>
						<td  class="bz-edit-data-value" colspan="5">
						<BZ:input prefix="R_" field="TRANSLATION_DESC" id="R_TRANSLATION_DESC" type="textarea" formTitle="����˵��" defaultValue="" maxlength="600" style="width:80%;height:100px"/>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
	</div>
	<!--������Ϣ��end-->
	<br>
	<!-- ��ť����:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť����:end -->
	</BZ:form>
	</BZ:body>
</BZ:html>
<%}%>