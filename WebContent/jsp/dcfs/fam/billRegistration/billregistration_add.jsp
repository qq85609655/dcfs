<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.DataList"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: billregistration_add.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-11-14 ����13:22:54
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
    //��ȡ���ݶ����б�
    DataList dataList = (DataList)session.getAttribute("fileList");
	Data tdata =(Data)request.getAttribute("regData");
	String CHEQUE_ID ="";
	if(tdata!=null){
		if(tdata.getString("CHEQUE_ID",null)!=null){
			CHEQUE_ID=tdata.getString("CHEQUE_ID","");
		}
	}else{
	   	tdata=new Data();
	   	session.setAttribute("regData", tdata);
	}
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	
	//��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>

<BZ:head language="CN">
	<title>Ʊ�ݵǼ�</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID');
		
		//���ļ��б�������ʱ�������ҡ�������֯�û�
		<%
		if(dataList.size() != 0){
		%>
			$("#P_COUNTRY_CODE").attr("disabled",true);
			$("#P_ADOPT_ORG_ID").attr("disabled",true);
		<%
		}
		%>
		
	});
	
	//����ļ�
	function _fileSelect() {
		var CHEQUE_ID = document.getElementById("P_CHEQUE_ID").value;
		var PAID_NO = document.getElementById("P_PAID_NO").value;
		var country_code = document.getElementById("P_COUNTRY_CODE").value;
		var adopt_org_id = document.getElementById("P_ADOPT_ORG_ID").value;
		var name_cn = document.getElementById("P_NAME_CN").value;
		var PAID_WAY = document.getElementById("P_PAID_WAY").value;
		var PAR_VALUE = document.getElementById("P_PAR_VALUE").value;
		var BILL_NO = document.getElementById("P_BILL_NO").value;
		var REMARKS = document.getElementById("P_REMARKS").value;
		if(country_code=="" || adopt_org_id=="null" || adopt_org_id==""){
			alert("��ѡ����Һ�������֯��");
			return false;
		}else{
			var url = "fam/billRegistration/selectFileList.action?CHEQUE_ID="+CHEQUE_ID+"&PAID_NO="+PAID_NO+"&country_code="+country_code+"&adopt_org_id="+adopt_org_id+"&name_cn="+name_cn+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
			//���봦��
			url=encodeURI(url);
			url=encodeURI(url);
			window.open(path + url,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		}
	}
	
	function _timeout(){
		var count = 0,is_true = false;
	    setInterval(function(){
	        if(!count){
	        	is_true = start_project();
	        	count++;
	        }
	        if(is_true){
	            start_config();
	            is_true = false;
	        }
	    },1000);
	}
	function refreshLocalList(CHEQUE_ID,PAID_NO,COUNTRY_CODE,ADOPT_ORG_ID,NAME_CN,PAID_WAY,PAR_VALUE,BILL_NO,REMARKS){
		var url = "fam/billRegistration/billRegistrationAdd.action?CHEQUE_ID="+CHEQUE_ID+"&PAID_NO="+PAID_NO+"&COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
		//���봦��
		url=encodeURI(url);
		url=encodeURI(url);
		window.location.href = path + url;
	}
	function _gray(){
		//���ļ��б�������ʱ�������ҡ�������֯�û�
		$("#P_COUNTRY_CODE").attr("disabled",true);
		$("#P_NAME_CN").attr("disabled",true);
	}
	
	//�Ƴ��ļ�
	function _delete(){
	  	var num = 0;
		var chioceuuid = [];
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				chioceuuid[num++] = arrays[i].value.split("#")[0];
			}
		}
		if(num < 1){
			page.alert('��ѡ��Ҫ�Ƴ����ļ���');
			return;
		}else{
	  		var uuid = chioceuuid.join("#");
			var CHEQUE_ID = document.getElementById("P_CHEQUE_ID").value;
			var PAID_NO = document.getElementById("P_PAID_NO").value;
			var COUNTRY_CODE = document.getElementById("P_COUNTRY_CODE").value;
			var ADOPT_ORG_ID = document.getElementById("P_ADOPT_ORG_ID").value;
			var NAME_CN = document.getElementById("P_NAME_CN").value;
			var PAID_WAY = document.getElementById("P_PAID_WAY").value;
			var PAR_VALUE = document.getElementById("P_PAR_VALUE").value;
			var BILL_NO = document.getElementById("P_BILL_NO").value;
			var REMARKS = document.getElementById("P_REMARKS").value;
	  		if (confirm("ȷ���Ƴ���Щ�ļ���")){
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.fam.billRegistration.BillRegistrationAjax2',
					type: 'POST',
					data: {'uuid':uuid,'date':new Date().valueOf()},
					dataType: 'json',
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert("������Ϣ��"+XMLHttpRequest+":"+textStatus+":"+errorThrown);
					},
					success: function(data){
						var url = "fam/billRegistration/billRegistrationAdd.action?CHEQUE_ID="+CHEQUE_ID+"&PAID_NO="+PAID_NO+"&COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
						//���봦��
						url=encodeURI(url);
						url=encodeURI(url);
						window.location.href = path + url;
					}
			  	});
			}
	  	}
	}
	
	//�������
	function _save() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		
		//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
		$("#P_COUNTRY_CODE").attr("disabled",false);
		$("#P_ADOPT_ORG_ID").attr("disabled",false);
		$("#P_COST_TYPE").attr("disabled",false);
		//���ύ
		document.getElementById("P_CHEQUE_TRANSFER_STATE").value = 0;
		document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action?type=pjdjsave";
		document.srcForm.submit();
	}
	//�ύ����
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
			$("#P_COUNTRY_CODE").attr("disabled",false);
			$("#P_ADOPT_ORG_ID").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			//���ύ
			document.getElementById("P_CHEQUE_TRANSFER_STATE").value = 1;
			document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action?type=pjdjsubmit";
			document.srcForm.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'fam/billRegistration/billRegistrationList.action';
	}
	
	
	
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;WJLX;FYLB;JFFS;FWF" property="regData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input prefix="P_" field="CHEQUE_ID" id="P_CHEQUE_ID" type="hidden" defaultValue=""/>
		<BZ:input prefix="P_" field="CHEQUE_TRANSFER_STATE" id="P_CHEQUE_TRANSFER_STATE" type="hidden" />
		<BZ:input prefix="P_" field="PAID_NO" id="P_PAID_NO" type="hidden" defaultValue=""/>
		<input type="hidden" id="P_PAGEACTION" name="P_PAGEACTION" value="create" />
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ʊ�ݵǼǻ�����Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:select field="COUNTRY_CODE" formTitle="" notnull="���������"
									prefix="P_" isCode="true" codeName="SYS_GJSY_CN" width="70%"
									onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--��ѡ��--
									</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="70%"
									onchange="_setOrgID('P_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								<BZ:input type="hidden" field="NAME_CN"  prefix="P_" id="P_NAME_CN"/>
								<BZ:input type="hidden" field="NAME_EN"  prefix="P_" id="P_NAME_EN"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�������</td>
							<td class="bz-edit-data-value">
								<BZ:select field="COST_TYPE" formTitle="" prefix="P_" isCode="true" codeName="FYLB" defaultValue="10" disabled="true" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>�ɷѷ�ʽ</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PAID_WAY"  formTitle="" prefix="P_" isCode="true" codeName="JFFS" width="70%" notnull="������ɷѷ�ʽ">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>Ʊ����</td>
							<td class="bz-edit-data-value">
								<BZ:input field="PAR_VALUE" id="P_PAR_VALUE" prefix="P_" type="String" restriction="number"  formTitle="Ʊ����" defaultValue="" style="width:67%" notnull="������Ʊ����"/>
							</td>
							<td class="bz-edit-data-title">�ɷ�Ʊ��</td>
							<td class="bz-edit-data-value">
								<BZ:input field="BILL_NO" prefix="P_" type="String" id="P_BILL_NO" formTitle="�ɷ�Ʊ��" defaultValue="" style="width:67%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�ɷѱ�ע</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="REMARKS" id="P_REMARKS" type="textarea" prefix="P_" formTitle="�ɷѱ�ע" maxlength="500" style="width:80%" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<div class="ui-state-default bz-edit-title" desc="��ť">
					<div style="text-align:right;">
						<input type="button" value="����ļ�" class="btn btn-sm btn-primary" onclick="_fileSelect()"/>&nbsp;
						<input type="button" value="�Ƴ��ļ�" class="btn btn-sm btn-primary" onclick="_delete();"/>&nbsp;&nbsp;
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="������">
				<div class="table-responsive">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table  table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
									<tr>
										<th class="center" style="width:5%;">
											<div class="sorting_disabled">
												<input name="abcd" type="checkbox" class="ace">
											</div>
										</th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled">���</div></th>
										<th style="width: 30%; text-align: center;">
											<div class="sorting_disabled" id="FILE_NO">�ļ����</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="REG_DATE">�Ǽ�����</div></th>
										<th style="width: 20%; text-align: center;">
											<div class="sorting_disabled" id="FILE_TYPE">�ļ�����</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="AF_COST">Ӧ�ɽ��</div></th>
									</tr>
									</thead>
									<tbody>
										<BZ:for property="fileList">
											<tr class="emptyData">
												<td class="center"><input name="abc" type="checkbox"
													value="<BZ:data field="AF_ID" onlyValue="true"/>" class="ace">
												</td>
												<td class="center">
													<BZ:i/>
												</td>
												<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
												<td class="center"><BZ:data field="REG_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
												<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
												<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
											</tr>
										</BZ:for>
									</tbody>
								</table>
								<!-- <table class="bz-edit-data-table" border="0">
									<tr>
										<td class="bz-edit-data-title" width="85%" style="text-align: center; border-top:none;">
											<font size="2px"><strong>�ϼ�</strong></font>
										</td>
										<td class="bz-edit-data-value" width="15%" style="border-top:none;">
										</td>
									</tr>
								</table> -->
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
