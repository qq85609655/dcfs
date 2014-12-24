<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    Data data = (Data)request.getAttribute("data");
    String ID = data.getString("ADOPT_ORG_ID","");  //��֯����ID
%>
<BZ:html>
<BZ:head>
	<title>Ԯ���������Ŀά��</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	function _save(){
    	//ҳ���У��
    	if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/organSupp/aidProjectModifySubmit.action";
 			document.organForm.submit();
    	}
    }
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- �����Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					Ԯ���;�����Ŀ��Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">��Ŀ����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ITEM_NAME" defaultValue="" prefix="MKR_" style="width:90%" maxlength="20" notnull="��������Ŀ����"/>		
							<BZ:input field="ADOPT_ORG_ID" id="MKR_ADOPT_ORG_ID" type="hidden" defaultValue="" prefix="MKR_"/>
						</td>
						<td class="bz-edit-data-title">��Ŀ������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ITEM_HEADER" defaultValue="" prefix="MKR_" maxlength="20" style="width:90%" notnull="��������Ŀ������"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="COLLABORATION_NAME" style="width:90%" defaultValue="" prefix="MKR_" maxlength="20" notnull="���������������"/>	
							<BZ:input field="ID" defaultValue="" id="MKR_ID" prefix="MKR_" type="hidden"/>
						</td>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="PROFITOR" style="width:90%"  defaultValue="" prefix="MKR_" maxlength="20"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ʼʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:input field="BEGIN_TIME" type="date" style="width:100px" id="MKR_BEGIN_TIME" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_END_TIME\\')}',readonly:true" defaultValue="" prefix="MKR_"/>
						</td>
						<td class="bz-edit-data-title">����ʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:input field="END_TIME" style="width:100px"  type="date" id="MKR_END_TIME"   dateExtend="minDate:'#F{$dp.$D(\\'MKR_BEGIN_TIME\\')}',readonly:true" defaultValue="" prefix="MKR_"/>			
											
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Ͷ����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="INVESTED_FUNDS" style="width:100px" defaultValue="" prefix="MKR_" restriction="number" />��Ԫ				
						</td>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE" style="width:90%" defaultValue="" prefix="MKR_" restriction="telephone"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="EMAIL" style="width:90%" defaultValue="" prefix="MKR_" restriction="email"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ŀ���ڵ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" style="width:90%" defaultValue="" prefix="MKR_" style="width:80%"/>			
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- �����Ϣend -->
	
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_save();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
