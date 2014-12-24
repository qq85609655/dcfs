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
    
    //��֯ID
    String ADOPT_ORG_ID = (String)request.getAttribute("ADOPT_ORG_ID");
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
%>
<BZ:html>
<BZ:head language="EN">
	<title>����ά��</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	function _save(){
		if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/orgexpmgr/branchModifySubmit.action";
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
					��֧������Ϣ(Branch office information)
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=ADOPT_ORG_ID %>'/>
				<BZ:input type="hidden" prefix="MKR_" field="ID" defaultValue='<%=data.getString("ID") %>'/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">���ڵ���<br>Region</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="AREA" defaultValue="" notnull="���������ڵ���" prefix="MKR_" style="width:90%;"/>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������<br>Director</td>
						<td class="bz-edit-data-value">
							<BZ:input field="HEADER" defaultValue="" style="width:90%" notnull="�����븺������Ϣ" maxlength="20" prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">�绰<br>Telephone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE" restriction="telephone" style="width:90%" defaultValue="" prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʼ�<br>Email</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL" defaultValue="" style="width:90%" restriction="email" prefix="MKR_" />					
						</td>
						<td class="bz-edit-data-title">����<br>Fax</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" defaultValue="" style="width:90%" prefix="MKR_" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ<br>Address</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" defaultValue="" prefix="MKR_" style="width:90%;"/>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����������<br>Basic information</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_INTRODUCTION_INFO" rows="4" cols="85%"><%=data.getString("INTRODUCTION_INFO")!=null&&!"".equals(data.getString("INTRODUCTION_INFO"))?data.getString("INTRODUCTION_INFO"):"" %></textarea>		
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
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save();"/>
			<!-- <input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback()"/> -->
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
