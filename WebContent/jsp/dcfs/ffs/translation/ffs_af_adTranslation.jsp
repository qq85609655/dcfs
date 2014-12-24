<%
/**   
 * @Title: ffs_af_adTranslation.jsp
 * @Description:  �ļ�����ҳ
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
	<div class="page-content">�����ݣ�</div>
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="window.history.go(-1);"/>
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
    <title>�ļ�����ҳ��</title>
    <BZ:webScript edit="true"/>
	<up:uploadResource/>
</BZ:head>
<BZ:body property="data" codeNames="">
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		})

	//���뱣��
	function _save() {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/ffs/ffsaftranslation/adTranslationSave.action";		
		document.srcForm.submit();
	}
	//��������ύ
	function _submit() {
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/ffs/ffsaftranslation/adTranslationSave.action";
		document.srcForm.submit();
	}
	//�����б�
	function _goback(){
		document.srcForm.action = path + "/ffs/ffsaftranslation/adTranslationList.action";
		document.srcForm.submit();
	}
	
	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="AT_ID"				id="R_AT_ID"				defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="AF_ID"				id="R_AF_ID"				defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"	id="R_TRANSLATION_STATE"	defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_TYPE" 	id="R_TRANSLATION_TYPE"		defaultValue=""/>
        
		<!-- ��������end -->
		<!--֪ͨ��Ϣ:start-->
		<div id="tab-retranslation">
			<br>
			<table class="specialtable" align="center" style='width:98%;text-align:center'>
				<tr>
                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>֪ͨ��Ϣ</b></td>
                </tr>
				<tr>
					<td class="edit-data-title" width="15%">֪ͨ��</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">֪ͨ����</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">����״̬</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE"  onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">����ԭ��</td>
					<td class="edit-data-value" colspan="5" width="85%"><BZ:dataValue field="AA_CONTENT" defaultValue="" /></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">��������</td>
					<td class="edit-data-value" colspan="5" width="85%">
					<up:uploadList id="NOTICE_FILEID" firstColWidth="20px" attTypeCode="AF" packageId='<%=NOTICE_FILEID%>'/>
					</td>
				</tr>
			</table>			
		</div>
		<!--֪ͨ��Ϣ:end-->

		<!--������Ϣ��start-->
		<div class='panel-container'>
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
					<td class="edit-data-title" colspan="6" style="text-align:center"><b>������Ϣ</b></td>
				</tr>
				
				<tr>
					<td class="edit-data-title">���븽��</td>
					<td class="edit-data-value" colspan="5" width="85%">
					<up:uploadBody name="R_TRANSLATION_FILEID" id="R_TRANSLATION_FILEID" attTypeCode="AF" packageId="<%=TRANSLATION_FILEID%>" smallType="<%=AttConstants.AF_BFFJ %>"  bigType="AF" diskStoreRuleParamValues="<%=strPar%>" autoUpload="false" queueStyle="border: solid 1px #CCCCCC;" queueTableStyle="padding:2px" selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;" selectAreaStyle="width:80%" selectFrameStyle="80%" queueTableStyle="width:80%"/>
					</td>					
				</tr>
				<tr>
					<td  class="edit-data-title">����˵��</td>
					<td  class="edit-data-value" colspan="5">
					<BZ:input prefix="R_" field="TRANSLATION_DESC" id="R_TRANSLATION_DESC" type="textarea" formTitle="����˵��" defaultValue="" maxlength="600" style="width:80%;height:100px"/>
					</td>
				</tr>
				
				<tr>
					<td class="edit-data-title" width="15%">���뵥λ</td>
					<td class="edit-data-value" width="18%"><BZ:dataValue field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">������</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">��������</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
				</tr>
			</table>
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