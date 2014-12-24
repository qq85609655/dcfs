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
<BZ:head language="EN">
	<title>�ڻ����нӴ���Ϣά��(Tour reception in China)</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	//�ύ��ϵ����Ϣ
	function _save(){
    	//ҳ���У��
    	if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/organSupp/receptionModifySubmit.action";
	 		document.organForm.submit();
    	}
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="JDFLX;FZRLB;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!--�ڻ����нӴ���Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ڻ����нӴ������Ϣ(Tour reception in China information)
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">�Ӵ�������<br>Recipient</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="RECEIVE_TYPE" id="MKR_RECEIVE_TYPE" width="170px" isCode="true" codeName="JDFLX" isShowEN="true" formTitle="�Ӵ�������" notnull="������Ӵ�������" defaultValue="">
								<BZ:option value="">--Please select--</BZ:option>
							</BZ:select>	
							<BZ:input field="ADOPT_ORG_ID" id="MKR_ADOPT_ORG_ID" type="hidden" defaultValue="" prefix="MKR_"/>
						</td>
						<td class="bz-edit-data-title">���������<br>Person in charge</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="HEADER_TYPE" width="170px" id="MKR_HEADER_TYPE" isCode="true" codeName="FZRLB" isShowEN="true" notnull="�����븺�������" formTitle="���������" defaultValue="">
								<BZ:option value="">--Please select--</BZ:option>
							</BZ:select>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����<br>Name</td>
						<td class="bz-edit-data-value">
							<BZ:input field="NAME"  defaultValue="" prefix="MKR_" style="width:90%" maxlength="20" notnull="����������"/>	
							<BZ:input field="ID" defaultValue="" id="MKR_ID" prefix="MKR_" type="hidden"/>
						</td>
						<td class="bz-edit-data-title">���֤����<br>ID number</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ID_NUMBER"  defaultValue="" style="width:90%" prefix="MKR_" restriction="number" notnull="���������֤����"  maxlength="20"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�绰����<br>Telephone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE"  defaultValue="" style="width:90%" prefix="MKR_" restriction="telephone"/>				
						</td>
						<td class="bz-edit-data-title">�ֻ�����<br>Cellphone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="MOBEL" defaultValue="" style="width:90%" prefix="MKR_" restriction="mobile"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����<br>Fax</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX"  defaultValue="" style="width:90%" prefix="MKR_" />				
						</td>
						<td class="bz-edit-data-title">����<br>Email</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL" defaultValue="" style="width:90%" prefix="MKR_" restriction="email"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������λ<br>Organization/Company</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="WORK_UNIT" defaultValue="" prefix="MKR_" style="width:80%"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ<br>Address</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" defaultValue="" prefix="MKR_" style="width:80%"/>			
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
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
