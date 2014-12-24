<%
/**   
 * @Title: addmaterial_view.jsp
 * @Description:  ����֪ͨ��ϸ�鿴ҳ��
 * @author panfeng   
 * @date 2014-9-15 ����11:01:46 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	Data adData = (Data)request.getAttribute("detaildata");
	String UPLOAD_IDS = adData.getString("UPLOAD_IDS","");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>����֪ͨ��ϸ�鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<BZ:body property="detaildata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;">
		<!-- �鿴����begin -->
		<div class="bz-edit clearfix" desc="�鿴����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ������֪ͨ��Ϣ(SUPPLEMENTARY NOTICE INFORMATION)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">֪ͨ��<br>NOTICE PERSON</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEND_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">֪ͨ����<br>Date of notification</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NOTICE_DATE" defaultValue="" type="Date"/>
							</td>
							<td class="bz-edit-data-title" width="15%">֪ͨ����<br>NOTICE DEPARTMENT</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ADD_TYPE" defaultValue="" checkValue="1=Audit Department;2=Resettlement Department;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">֪ͨ����<br>NOTICE CONTENT</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="NOTICE_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ظ�����<br>Date of reply</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" type="Date"/>
							</td>
							<td class="bz-edit-data-title">����״̬<br>Supplement status</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="AA_STATUS" defaultValue="" checkValue="0=to be added;1=in process of adding;2=added"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ظ�����<br>REPLY CONTENT</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADD_CONTENT_EN" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ظ�����<br>REPLY MATERIAL</td>
							<td class="bz-edit-data-value" colspan="5">
								<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �鿴����end -->
		<!-- ��ť�� ��ʼ -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��" id="print1">
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
			</div>
		</div>
		<!-- ��ť�� ���� -->
	</BZ:body>
</BZ:html>