<%
/**   
 * @Title: suppleQuery_view.jsp
 * @Description:  �����ļ���Ϣ�鿴ҳ��
 * @author yangrt   
 * @date 2014-9-5 ����14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String aa_id = (String)request.getAttribute("AA_ID");
	String flag = (String)request.getAttribute("Flag");
	String UPLOAD_IDS = (String)request.getAttribute("UPLOAD_IDS");	
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�����ļ���Ϣ�鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		});
		
		//���ز����ļ��б�ҳ��
		function _goback(){
			window.location.href=path+'ffs/filemanager/SuppleFileList.action';
		}
		
		//�����ļ���ϸ��Ϣ�鿴ҳ��
		function _showFileDetail(){
			var af_id = $("#R_AF_ID").val();
			var url = path + "ffs/filemanager/SuppleFileShow.action?type=show&AF_ID=" + af_id;
			_open(url, "window", 1000, 600);
			/* document.srcForm.action=url;
			document.srcForm.submit(); */
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<input type="hidden" name="AA_ID" value="<%=aa_id %>"/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>����֪ͨ��������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">֪ͨ����<br>Date of notification</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="NOTICE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">����֪ͨ��</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="SEND_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�Ƿ��޸ĸû�����Ϣ</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_MODIFY" checkValue="0=No;1=Yes;" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">�Ƿ񲹳丽��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_ADDATTACH" checkValue="0=No;1=Yes;" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">֪ͨ����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">���䷴������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEEDBACK_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">���䷴����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEEDBACK_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<%-- <tr>
							<td class="bz-edit-data-title">���䷴������(��)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADD_CONTENT_CN" onlyValue="true" defaultValue=""/>
							</td>
						</tr> --%>
						<tr>
							<td class="bz-edit-data-title">���䷴������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADD_CONTENT_EN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="20%">���丽����Ϣ</td>
							<td class="bz-edit-data-value"  colspan="3">
								<up:uploadList attTypeCode="AF" id="R_UPLOAD_IDS" packageId="<%=UPLOAD_IDS %>" smallType="<%=AttConstants.AF_WJBC %>"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="View detail" class="btn btn-sm btn-primary" onclick="_showFileDetail()"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>