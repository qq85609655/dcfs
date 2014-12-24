<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: billregistration_revise.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-11-19 ����20:19:38
 * @version V1.0   
 */
 	Data tdata =(Data)session.getAttribute("regData");
	System.out.println(tdata);
    /******Java���빦������Start******/
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	
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
</BZ:head>

<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	//����ļ�
	function _fileSelect() {
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
			var url = "fam/billRegistration/selectFileList.action?country_code="+country_code+"&adopt_org_id="+adopt_org_id+"&name_cn="+name_cn+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
			//���봦��
			url=encodeURI(url);
			url=encodeURI(url);
			window.open(path + url,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		}
	}
	
	function refreshLocalList(COUNTRY_CODE,ADOPT_ORG_ID,NAME_CN,PAID_WAY,PAR_VALUE,BILL_NO,REMARKS){
		var url = "fam/billRegistration/billRegistrationAdd.action?COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
		//���봦��
		url=encodeURI(url);
		url=encodeURI(url);
		window.location.href = path + url;
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
						var url = "fam/billRegistration/billRegistrationAdd.action?COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
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
		$("#P_COST_TYPE").attr("disabled",false);
		//���ύ
		document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action";
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
			$("#P_COST_TYPE").attr("disabled",false);
			//���ύ
			document.getElementById("P_CHEQUE_TRANSFER_STATE").value = 1;
			document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action";
			document.srcForm.submit();
			
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'fam/billRegistration/billRegistrationList.action';
	}
	//ɾ��ѡ����ļ���Ϣ
	function _deleteRow() {
		var num = 0;
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				num += 1;
			}
		}
		var totalNum = (arrays.length-num)*800;
		$("#P_PAID_SHOULD_NUM").val(totalNum);//��̬����Ӧ�ɷ���
		$(':checkbox[name=xuanze]').each(function(){
			if($(this).attr('checked')){
				$(this).closest('tr').remove();
			}
		}); 
	}
	
	
	/**
	*Ʊ�����Ƿ���ڵ���Ӧ�ɽ��
	*@author�� mayun
	*@date�� 2014-7-17
	*@return:true Ʊ����>=Ӧ�ɽ��; false:Ʊ����<Ӧ�ɽ�� 
	*/
	function _checkBill(){
		var pmje=$("#P_PAR_VALUE").val();//Ʊ����
		var yjfy = $("#P_PAID_SHOULD_NUM").val();//Ӧ�ɷ���
		
		if(parseFloat(pmje)<parseFloat(yjfy)){
			alert("Ʊ�������>=Ӧ�ɽ��,������Ǽ�!");
			return false;
		}else{
			return true;
		}
	}
	
	
	/**
	*
	*���ݹ����г�����������֯
	*@ author :mayun
	*@ date:2014-7-24
	*/
	function _findSyzzNameList(){
		$("#P_NAME_CN").val("");//���������֯����
		$("#P_ADOPT_ORG_ID").val("");//���������֯ID
		var countryCode = $("#P_COUNTRY_CODE").find("option:selected").val();//����Code
		var language = $("#P_ADOPT_ORG_ID").attr("isShowEN");//�Ƿ���ʾӢ��
		if(null != countryCode&&""!=countryCode){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=findSyzzNameList&countryCode='+countryCode,
				type: 'POST',
				dataType: 'json',
				timeout: 1000,
				success: function(data){
			       var option ={
				      dataType: 'json',
					  width: 320,        //ָ��������Ŀ��. Default: inputԪ�صĿ��
					  max: 100,            //������ʾ��Ŀ�ĸ���.Default: 10
					  delay :1000,
					  highlight: false,
					  scroll: true,
					  minChars: 0,        //�ڴ���autoCompleteǰ�û�������Ҫ������ַ���.Default: 1�������Ϊ0�����������˫������ɾ�������������ʱ��ʾ�б�
					  autoFill: true,    //Ҫ��Ҫ���û�ѡ��ʱ�Զ����û���ǰ������ڵ�ֵ���뵽input��. Default: false
					  mustMatch:false,    //�������Ϊtrue,autoCompleteֻ������ƥ��Ľ�������������,���е��û�������ǷǷ��ַ�ʱ����ò���������.Default: false
				      matchContains: true,//�����Ƚ�ʱ�Ƿ�Ҫ���ַ����ڲ��鿴ƥ��,��ba�Ƿ���foo bar�е�baƥ��.ʹ�û���ʱ�Ƚ���Ҫ.��Ҫ��autofill����.Default: false
				      cacheLength:1,      //����ĳ���.���Դ����ݿ���ȡ���Ľ����Ҫ�����������¼.���1Ϊ������.Default: 10
				      matchSubset:false,   //autoComplete�ɲ�����ʹ�öԷ�������ѯ�Ļ���,��������foo�Ĳ�ѯ���,��ô����û�����foo�Ͳ���Ҫ�ٽ��м�����,ֱ��ʹ�û���.ͨ���Ǵ����ѡ���Լ���������ĸ������������.ֻ���ڻ��泤�ȴ���1ʱ��Ч.Default: true
				      matchCase:false,    // �Ƚ��Ƿ�����Сд���п���.ʹ�û���ʱ�Ƚ���Ҫ.����������һ��ѡ��,���Ҳ�Ͳ������,�ͺñ�footҪ��Ҫ��FOO�Ļ�����ȥ��.Default: false   	  
			          multiple:false,     //�Ƿ�����������ֵ�����ʹ��autoComplete��������ֵ. Default: false
			          multipleSeparator:",",//����Ƕ�ѡʱ,�����ֿ�����ѡ����ַ�. Default: ","
			          maxitemstoshow:-1,  //��Ĭ��ֵ�� -1 �� ���ƵĽ����������ʾ�����������Ƿǳ����õ�������д��������ݺͲ���Ϊ�û��ṩһ���嵥���г����ܰ������԰ټƵ���Ŀ��Ҫ���ô˹��ܣ�����ֵ����Ϊ-1 ��
						
			          formatItem: function(row, i, max){//���ݼ��ش���
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME;
			          	}
			               
			          },
			          formatMatch: function(row, i, max){//����ƥ�䴦��
			          if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME ;
			          	}
			          },
			          formatResult: function(row){//���ݽ������
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME ;
			          	}
			          }            
					}
					$("#P_NAME_CN").autocomplete(data,option);   
					$("#P_NAME_CN").setOptions(data).flushCache();//�������
			        $("#P_NAME_CN").result(function(event, value, formatted){//ѡ������Code��ֵ����
			        	$("#P_ADOPT_ORG_ID").val(value.CODEVALUE);
					}); 
				}
			  });
		}else{
			//alert("��ѡ�����!");
			return false;
		}
	}
	
</script>

<BZ:body codeNames="GJSY;WJLX;FYLB;JFFS;FWF" property="regData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input prefix="P_" field="CHEQUE_ID" id="P_CHEQUE_ID" type="hidden" />
		<BZ:input prefix="P_" field="CHEQUE_TRANSFER_STATE" id="P_CHEQUE_TRANSFER_STATE" type="hidden" />
		<input type="hidden" id="P_PAGEACTION" name="P_PAGEACTION" value="update" />
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
								<BZ:select field="COUNTRY_CODE" notnull="���������" formTitle="" prefix="P_" isCode="true" codeName="GJSY" width="70%" disabled="true" onchange="_findSyzzNameList()">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:input prefix="P_" field="NAME_CN" id="P_NAME_CN" defaultValue="" className="inputOne" formTitle="������֯" style="width:67%" maxlength="300" notnull="������������֯"  disabled="true"/>
								<BZ:input type="hidden" field="ADOPT_ORG_ID"  prefix="P_" id="P_ADOPT_ORG_ID"/>
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
								<BZ:input field="BILL_NO" id="P_BILL_NO" prefix="P_" type="String"  formTitle="�ɷ�Ʊ��" defaultValue="" style="width:67%"/>
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
				<!-- ��ť���� begin -->
				<div class="ui-state-default bz-edit-title" desc="��ť">
					<div style="text-align:right;">
						<input type="button" value="����ļ�" class="btn btn-sm btn-primary" onclick="_fileSelect()"/>&nbsp;
						<input type="button" value="�Ƴ��ļ�" class="btn btn-sm btn-primary" onclick="_delete();"/>&nbsp;&nbsp;
					</div>
				</div>
				<!-- ��ť���� end -->
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
											<div class="sorting_disabled" id="FAMILY_TYPE">�ļ����</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="MALE_NAME">�Ǽ�����</div></th>
										<th style="width: 20%; text-align: center;">
											<div class="sorting_disabled" id="MALE_BIRTHDAY">�ļ�����</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_NAME">Ӧ�ɽ��</div></th>
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
