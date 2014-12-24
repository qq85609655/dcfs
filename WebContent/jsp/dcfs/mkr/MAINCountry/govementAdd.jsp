<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String COUNTRY_CODE=(String)request.getAttribute("COUNTRY_CODE");
	DataList goveList = (DataList)request.getAttribute("goveList");
%> 

<%@page import="hx.database.databean.DataList"%><BZ:html>
<BZ:head>
	<title>����������Ϣ</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script>
$(document).ready(function() {
	dyniframesize(['downFrame','rightFrame','mainFrame']);
});

//�������������Ϣ
function _submit(){
	if(confirm("ȷ���ύ��")){
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"mkr/MAINCountry/addGovement.action";
		document.srcForm.submit();
		var country_code = document.getElementById("COUNTRY_CODE").value;
		parent.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action?COUNTRY_CODE="+country_code+"&m=ok";
	}
}
</script>
<BZ:body property="data" codeNames="ZFBMXZ;">
	<BZ:form name="srcForm">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- ��������Ϣbegin -->
	<div class="bz-edit clearfix" style="margin: 0;padding:0;width:100%;"  desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>
						����������Ϣ
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="������">
					<!-- �༭���� ��ʼ -->
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������(CN)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="NAME_CN" prefix="G_" notnull="��������������(CN)" id="G_NAME_CN" defaultValue="" style="width:70%;"/>
								<input type="hidden" id="COUNTRY_CODE" name="COUNTRY_CODE" value="<%=COUNTRY_CODE %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��������(EN)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="NAME_EN" prefix="G_" notnull="��������������(EN)" id="G_NAME_EN" defaultValue="" style="width:70%;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��������</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:select field="NATURE"   formTitle="" prefix="G_" isCode="true" codeName="ZFBMXZ">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%">����ְ��</td>
							<td class="bz-edit-data-value" colspan="3">
								<!-- 
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS0" value="0" formTitle="">��ͨЭ��</BZ:checkbox>
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS1" value="1" formTitle="">�ݽ��ļ�</BZ:checkbox>
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS2" value="2" formTitle="">��������</BZ:checkbox>
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS3" value="3" formTitle="">ǩ�����������</BZ:checkbox>
								 -->
								 <%
									for(int i=0;i<goveList.size();i++){
										Data data =goveList.getData(i);
										String name = data.getString("NAME");
										String value = data.getString("VALUE");
										String a=String.valueOf(i);
										StringBuffer str = new StringBuffer();
								%>
											<input type="checkbox" name="G_GOVER_FUNCTIONS<%=a%>" value="<%=value%>" /> <%=name %>
								<% 
									}
								%>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">����������</td>
							<td class="bz-edit-data-value">
								<BZ:input field="HEAD_NAME" prefix="G_" notnull="�����븺��������" id="G_HEAD_NAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�����˵绰</td>
							<td class="bz-edit-data-value" >
								<BZ:input  field="HEAD_PHONE" id="G_HEAD_PHONE" prefix="G_" defaultValue="" restriction="mobile"/>
							</td>
							<td class="bz-edit-data-title" width="15%">����������</td>
							<td class="bz-edit-data-value" >
								<BZ:input  field="HEAD_EMAIL" id="G_HEAD_EMAIL" prefix="G_"  defaultValue="" restriction="email"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ַ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="WEBSITE" prefix="G_" id="G_WEBSITE" defaultValue=""  style="width:70%"/>		
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ַ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="ADDRESS" prefix="G_" id="G_ADDRESS" defaultValue="" style="width:70%"/>		
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">�Ǽ�����</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:input field="REG_DATE" prefix="G_" type="date" id="G_REG_DATE" notnull="������Ǽ�����" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">����޸�����</td>
							<td class="bz-edit-data-value" width="15%">
							<!-- 							
								<BZ:input  field="MOD_DATE" id="G_MOD_DATE" type="date" prefix="G_" defaultValue=""/>
							 -->
							</td>
							<td class="bz-edit-data-title" width="15%">�����</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:input  field="SEQ_NO" id="G_SEQ_NO" prefix="G_"  defaultValue=""/>
							</td>
						</tr>
					</table>
					<!-- �༭���� ���� -->
					<!-- ��ť�� ��ʼ -->
					<div class="bz-action-frame">
					<div class="bz-action-edit" desc="��ť��">
						<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>
					</div>
					</div>
					<!-- ��ť�� ���� -->
				</div>
			</div>
		</div>
	<!--��������Ϣ end -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
