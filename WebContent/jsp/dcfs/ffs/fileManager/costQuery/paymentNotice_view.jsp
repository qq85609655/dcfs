<%
/**   
 * @Title: paymentNotice_view.jsp
 * @Description:  �߽�֪ͨ��Ϣ�鿴
 * @author yangrt   
 * @date 2014-8-29 10:20:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String upload_id = (String)request.getAttribute("UPLOAD_ID");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�߽�֪ͨ��Ϣ�鿴</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);
			});
			//�����б�ҳ
			function _goback(){
				window.location.href=path+'ffs/filemanager/PaymentNoticeList.action';
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="FYLB;">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�߽�֪ͨ��Ϣ(Payment reminder information)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�߽ɱ��<br>Reminder number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">�������<br>Payment type</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" isShowEN="true" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">Ӧ�ɽ��<br>Amount payable</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������ͯ����<br>Number of normal children</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_NUM" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title">�����ͯ����<br>Number of special needs children</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="S_CHILD_NUM" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ɷ�����<br>Payment content</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PAID_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����<br>Attachment</td>
							<td class="bz-edit-data-value" colspan="5">
								<up:uploadList attTypeCode="OTHER" id="R_ATTACHMENT" packageId="<%=upload_id %>" smallType="<%=AttConstants.FAW_JFPJ %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ע<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">֪ͨ��<br>Notice people</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">֪ͨ����<br>Date of notification</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<!-- ��ť����Start -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>