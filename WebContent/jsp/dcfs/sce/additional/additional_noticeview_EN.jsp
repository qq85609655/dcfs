<%
/**   
 * @Title: additional_noticeview_CN.jsp
 * @Description:  Ԥ�������ѯ�鿴ҳ�棨����֪ͨ/Ӣ�ģ�
 * @author panfeng   
 * @date 2014-9-12 ����10:11:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String UPLOAD_IDS = (String)request.getAttribute("UPLOAD_IDS");
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������ѯ�鿴ҳ�棨����֪ͨ��</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
	</script>
</BZ:html>
<BZ:body property="noticedata">
	<!-- �鿴����begin -->
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
						<td class="bz-edit-data-title" width="20%">֪ͨ��<br>notify the person</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="SEND_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">����֪ͨ����<br>date of notification</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" type="Date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ��޸�<br>whether to modify</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="IS_MODIFY" defaultValue="" checkValue="0=No;1=Yes"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">֪ͨ����<br>notification content</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NOTICE_CONTENT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ظ���<br>reply person</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEEDBACK_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�ظ�����<br>reply date</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" type="Date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ظ�����<br>reply content</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADD_CONTENT_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ظ�����<br>reply attachment</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- �鿴����end -->
</BZ:body>