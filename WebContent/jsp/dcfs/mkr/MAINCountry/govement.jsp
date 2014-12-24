<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.DataList"%><BZ:html>
<%
	String path = request.getContextPath();
	DataList contactList = (DataList)request.getAttribute("contactList");
	String GOV_ID = (String)request.getAttribute("GOV_ID");
	String COUNTRY_CODE=(String)request.getAttribute("COUNTRY_CODE");
	DataList goveList = (DataList)request.getAttribute("goveList");
	Data govData = (Data)request.getAttribute("govementData");
%>
<BZ:head>
	<title>����������Ϣ</title>
	<BZ:webScript edit="true" list="true" />
</BZ:head>
<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['downFrame','rightFrame','mainFrame']);
	});
	
	//�޸�����������Ϣ
	function _submit(){
		if(confirm("ȷ���ύ��")){	
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			var country_code = document.getElementById("COUNTRY_CODE").value;
			document.srcForm.action=path+"mkr/MAINCountry/reviseGovement.action?COUNTRY_CODE="+country_code;
			document.srcForm.submit();
			parent.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action?COUNTRY_CODE="+country_code+"&m=ok";
		}
	}
	
	//��̬���һ����ϵ����Ϣ
	function add(){
			seqNum++;
			var rowCount = info.rows.length;
			var newTr=$("<tr>");
			newTr.html("<td class='center'><input name='xuanze' class='ace' type='checkbox' /></td>"
				+ "<td><input name='C_CONTACT_NAME" + seqNum + "' id='C_CONTACT_NAME" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' notnull='��������ϵ������'/></td>"
				+ "<td><input name='C_CONTACT_POSITION" + seqNum + "' id='C_CONTACT_POSITION" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text'/></td>"
				+ "<td><input name='C_CONTACT_TEL" + seqNum + "' id='C_CONTACT_TEL" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' /></td>"
				+ "<td><input name='C_CONTACT_EMAIL" + seqNum + "' id='C_CONTACT_EMAIL" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text'/></td>"
				+"<td></td>");
			$("#info").append(newTr);
	}

	//��̬ɾ����ϵ����Ϣ
	function _deleteRow() {
		var num = 0;
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				num += 1;
			}
		}
		$(':checkbox[name=xuanze]').each(function(){
			if($(this).attr('checked')){
				$(this).closest('tr').remove();
			}
		}); 
	}
	//�ύ��ϵ����Ϣ
	function _submitContact(){
		if(confirm("ȷ���ύ��")){
			//ҳ���У��
			if (!runFormVerify(document.linkFrom, false)) {
				return;
			}
			var i=0;
			for(i=1;i<seqNum;i++){
				//�ж���ϵ����Ϣ�Ƿ�Ϊ��
				var infoNum = document.getElementsByName("C_CONTACT_NAME"+i);
				if (infoNum.length < 1){
					alert("������������һ���ļ���Ϣ��");
					return;
				}
			}
			//���ύ
			var obj = document.forms["linkFrom"];
			var gov_id = document.getElementById("C_GOV_ID").value;
			var country_code = document.getElementById("COUNTRY_CODE").value;
			obj.action=path+'mkr/MAINCountry/addContact.action?rowNum=' + seqNum+"&COUNTRY_CODE="+country_code+"&GOV_ID="+gov_id;
			obj.submit();
		}
	}

	//ɾ����ϵ����Ϣ
	function _delContact(ID){
		var gov_id = document.getElementById("C_GOV_ID").value;
		var country_code = document.getElementById("COUNTRY_CODE").value;
		document.linkFrom.action=path+"mkr/MAINCountry/delContact.action?ID="+ID+"&COUNTRY_CODE="+country_code+"&GOV_ID="+gov_id;
		document.linkFrom.submit();
	}
</script>
<BZ:body property="govementData" codeNames="ZFBMXZ;">
	<BZ:form name="srcForm">
			<div class="bz-edit clearfix" style="margin: 0;padding:0;width: 100%" desc="�༭����">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>����������Ϣ</div>
					</div>
					<div class="bz-edit-data-content clearfix" desc="������">
						<!-- �༭���� ��ʼ -->
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="15%">��������(CN)</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input field="NAME_CN" prefix="G_" notnull="��������������(CN)" id="G_NAME_CN" defaultValue="" style="width:70%;" />
									<input type="hidden" id="COUNTRY_CODE" name="COUNTRY_CODE" value="<%=COUNTRY_CODE %>" /></td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">��������(EN)</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input field="NAME_EN" prefix="G_" id="G_NAME_EN" notnull="��������������(EN)" defaultValue="" style="width:70%;" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">��������</td>
								<td class="bz-edit-data-value" width="30%">
									<BZ:select field="NATURE" formTitle="" prefix="G_" isCode="true" codeName="ZFBMXZ">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title" width="15%">����ְ��</td>
								<td class="bz-edit-data-value" colspan="3">
									<!-- 
									<BZ:checkbox field="GOVER_FUNCTIONS0" prefix="G_" value="0" formTitle="">��ͨЭ��</BZ:checkbox>
									<BZ:checkbox field="GOVER_FUNCTIONS1" prefix="G_" value="1" formTitle="">�ݽ��ļ�</BZ:checkbox>
								    <BZ:checkbox field="GOVER_FUNCTIONS2" prefix="G_" value="2" formTitle="">��������</BZ:checkbox>
									<BZ:checkbox field="GOVER_FUNCTIONS3" prefix="G_" value="3" formTitle="">ǩ�����������</BZ:checkbox>
									 -->
									 <%
										for(int i=0;i<goveList.size();i++){
											Data data =goveList.getData(i);
											String name = data.getString("NAME");
											String value = data.getString("VALUE");
											String a=String.valueOf(i);
											StringBuffer str = new StringBuffer();
											String num = str.append(a).toString();
											num = govData.getString("GOVER_FUNCTIONS"+i,"");
											if(""!=num){
									%>
												<input type="checkbox" name="G_GOVER_FUNCTIONS<%=a%>" value="<%=value%>" checked="checked"/> <%=name %>
									<% 
											}else{
									%>
												<input type="checkbox" name="G_GOVER_FUNCTIONS<%=a%>" value="<%=value%>"/> <%=name %>	
									<%								
											}
										}
									%>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">����������</td>
								<td class="bz-edit-data-value">
									<BZ:input field="HEAD_NAME" prefix="G_" id="G_HEAD_NAME" notnull="�����븺��������" defaultValue="" />
								</td>
								<td class="bz-edit-data-title" width="15%">�����˵绰</td>
								<td class="bz-edit-data-value">
									<BZ:input field="HEAD_PHONE" id="G_HEAD_PHONE" prefix="G_" defaultValue="" restriction="mobile" />
								</td>
								<td class="bz-edit-data-title" width="15%">����������</td>
								<td class="bz-edit-data-value">
									<BZ:input field="HEAD_EMAIL" id="G_HEAD_EMAIL" prefix="G_" defaultValue="" restriction="email" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">��ַ</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input field="WEBSITE" prefix="G_" id="G_WEBSITE" defaultValue="" style="width:70%" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">��ַ</td>
								<td class="bz-edit-data-value" width="30%" colspan="5">
									<BZ:input field="ADDRESS" prefix="G_" id="G_ADDRESS" defaultValue="" style="width:70%" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">�Ǽ�����</td>
								<td class="bz-edit-data-value">
									<BZ:input field="REG_DATE" prefix="G_" type="Date" notnull="������Ǽ�����" id="G_REG_DATE" defaultValue="" />
								</td>
								<td class="bz-edit-data-title" width="15%">����޸�����</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="MOD_DATE" type="Date" onlyValue="true" defaultValue=""/>
								</td>
								<td class="bz-edit-data-title" width="15%">�����</td>
								<td class="bz-edit-data-value">
									<BZ:input field="SEQ_NO" id="G_SEQ_NO" prefix="G_" defaultValue="" />
									<BZ:input type="hidden" field="GOV_ID" id="G_GOV_ID" prefix="G_" defaultValue="" />
								</td>
							</tr>
						</table>
						<!-- �༭���� ���� -->
						<!-- ��ť�� ��ʼ -->
						<div class="bz-action-frame">
							<div class="bz-action-edit" desc="��ť��">
								<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();" />
							</div>
						</div>
						<!-- ��ť�� ���� -->
					</div>
				</div>
			</div>
	</BZ:form>	
	<BZ:form name="linkFrom">	
			<!-- ��ϵ����Ϣbegin -->
			<div class="bz-edit clearfix" style="margin: 0;padding:0; width:100%;" desc="�༭����">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>����������Ϣ</div>
					</div>
					<!-- ���ܰ�ť������Start -->
					<div class="table-row table-btns" style="text-align: left">
						<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="add()" />
						<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_deleteRow()" />
					</div>
					<div class="blue-hr"></div>
					<!-- ���ܰ�ť������End -->
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="info">
							<thead>
								<tr>
									<!-- 						
									<th class="center" style="width: 3%;"></th>
									 -->
									<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_NAME">��ϵ������</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_POSITION">��ϵ��ְλ</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_TEL">��ϵ�˵绰</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_EMAIL">��ϵ������</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_EMAIL">����</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="contactList">
									<tr class="emptyData">
										<!-- 
											<td class="center">
												<input name="xuanze" type="checkbox" value="<BZ:data field="GOV_ID" defaultValue="" onlyValue="true"/>" class="ace">
											</td>
										 -->
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="CONTACT_NAME" defaultValue=""
											onlyValue="true" /></td>
										<td><BZ:data field="CONTACT_POSITION" defaultValue=""
											onlyValue="true" /></td>
										<td><BZ:data field="CONTACT_TEL" defaultValue=""
											onlyValue="true" /></td>
										<td><BZ:data field="CONTACT_EMAIL" defaultValue=""
											onlyValue="true" /></td>
										<td>
											<input type="button" value="ɾ��" class="btn btn-sm btn-primary" onclick="_delContact('<BZ:data field="ID" onlyValue="true"/>')"/>
										</td>
									</tr>
								</BZ:for>
								<input type="hidden" name="C_GOV_ID" id="C_GOV_ID" value="<%=GOV_ID %>" />
							</tbody>
						</table>
					</div>
					<!-- ��ť�� ��ʼ -->
					<div class="bz-action-frame">
						<div class="bz-action-edit" desc="��ť��">
							<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_submitContact();" />
						</div>
					</div>
				<!-- ��ť�� ���� -->
				</div>
			</div>
			<!--��ϵ����Ϣ end -->
	</BZ:form>
</BZ:body>
</BZ:html>
