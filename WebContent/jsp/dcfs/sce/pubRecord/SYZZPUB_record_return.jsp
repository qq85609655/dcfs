<%
/**   
 * @Title: SYZZPUB_record_return.jsp
 * @Description:������֯ί���˻�ҳ��
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
<BZ:head language="EN">
	<title>������֯��дί���˻�ԭ��</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	function _submit(){
		if(confirm("Are you sure you want to submit?")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"record/SYZZPUBRecordAddReason.action";
			document.srcForm.submit();
		}
	}
	
	//���ص㷢�˻��б�
	function _goback(){
		document.srcForm.action=path+"record/SYZZPUBRecordList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="TXRTFBTHLX;">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="S_"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ί���˻�(Return agency-specific files)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�˻�ʱ��<br>Return date</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="RETURN_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�˻�����<br>Return type</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="RETURN_TYPE"  defaultValue="" codeName="TXRTFBTHLX" isShowEN="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">�˻�ԭ��<br>Reason for return</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="S_" field="RETURN_REASON" id="S_RETURN_REASON" defaultValue="" style="width:700px;height:40px;" maxlength="" />
								<BZ:input prefix="S_" field="RETURN_DATE" id="S_RETURN_DATE" defaultValue="" type="hidden" maxlength="" />
								<BZ:input prefix="S_" field="RETURN_TYPE" id="S_RETURN_TYPE" defaultValue="" type="hidden" maxlength="" />
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
