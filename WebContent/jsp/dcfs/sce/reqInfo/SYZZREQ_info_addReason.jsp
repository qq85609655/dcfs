<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:��д���볷��ԭ��ҳ��
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data d = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
	<title>��д���볷��ԭ��</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		document.srcForm.action="";
	});
	
	function _submit(){
		if(confirm("Are you sure you want to submit?")){
			//ҳ���У��
			document.srcForm.action=path+"info/SYZZREQInfoAddReason.action";
			document.srcForm.submit();
		}
	}
	
	//���ص㷢�˻��б�
	function _goback(){
		document.srcForm.action=path+"info/SYZZREQInfoApplicatList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="RI_ID" prefix="S_"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���볷��(Withdrawal application)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="25%">���볷������<br>Date of application withdrawal</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="REVOKE_REQ_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="25%">���볷����<br>Withdrawal applied by</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="REVOKE_REQ_USERNAME" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="25%">���볷��ԭ��<br>Reason for withdrawal</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="S_" field="REVOKE_REASON" id="S_REVOKE_REASON" defaultValue="" style="width:700px;height:80px;" maxlength="" />
								<BZ:input prefix="S_" field="REVOKE_REQ_DATE" id="S_REVOKE_REQ_DATE" defaultValue="" type="hidden" maxlength="" />
								<BZ:input prefix="S_" field="REVOKE_REQ_USERNAME" id="S_REVOKE_REQ_USERNAME" defaultValue="" type="hidden" maxlength="" />
								<BZ:input prefix="S_" field="REVOKE_REQ_USERID" id="S_REVOKE_REQ_USERID" defaultValue="" type="hidden" maxlength="" />
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
