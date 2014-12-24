<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: wjdl_batchadd.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-8-5 ����13:57:23
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
 	//�������ݶ���
	Data wjdlData = new Data();
	request.setAttribute("wjdlData",wjdlData);
	
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
	//��ȡ������ϢID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
%>
<BZ:html>

<BZ:head language="CN">
	<title>�����ļ���¼</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
</BZ:head>

<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		_getAfCost();
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID');
	});
	
	
	//�����ļ���¼��Ϣ
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//�Ƿ�¼�������Ϣ
			_dyShowPjInfo();
			
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//�ж��ļ���Ϣ�Ƿ�Ϊ��
			var infoNum = document.getElementsByName("P_FILE_TYPE");
			if (infoNum.length < 1){
				alert("������������һ���ļ���Ϣ��");
				return;
			}
			
			//ͨ�������б�ѡ��������ֶθ�ֵ
			var temp1 = $("#P_COUNTRY_CODE").find("option:selected").text();
			var temp2 = $("#P_ADOPT_ORG_ID").find("option:selected").text();
			$("#P_COUNTRY_CN").val(temp1);//����CN
			$("#P_NAME_CN").val(temp2);//��֯CN
			
			//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
			$("#P_FAMILY_TYPE").attr("disabled",false);
			$("#P_PAID_SHOULD_NUM").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveBatchFlieRecord.action?rowNum=' + seqNum ;
			obj.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	//��̬���һ���ļ���Ϣ
	function _addRow() {
		var af_cost=$("#P_AF_COST").val();
		var temp_sum_cost=$("#P_PAID_SHOULD_NUM").val();
		var sum_af_cost=Number(af_cost)+Number(temp_sum_cost);
		$("#P_PAID_SHOULD_NUM").val(sum_af_cost);
		
		seqNum++;
		var rowCount = info.rows.length;
		var newTr=$("<tr>");
		newTr.html("<td class='center'><input name='xuanze' class='ace' type='checkbox' /></td>"
			+ "<td><select name='P_FILE_TYPE" + seqNum + "' id='P_FILE_TYPE" + seqNum + "' onchange='_dynamicJznsy(" + seqNum + ")' type='text' style='height:22px; font-size:12px; width: 95%' notnull='��ѡ���ļ�����'><option value=''>--��ѡ��--</option><option value='10'>����</option><option value='30'>�쵼����</option><option value='31'>�ڻ�</option><option value='32'>����</option><option value='33'>����Ů����</option><option value='34'>��������</option><option value='35'>����</option></select></td>"
			+ "<td><select name='P_FAMILY_TYPE" + seqNum + "' id='P_FAMILY_TYPE" + seqNum + "' onchange='_dynamicHide(" + seqNum + ");_dySetSyrxb(" + seqNum + ")' type='text' style='height:22px; font-size:12px; width: 95%' formTitle='null' notnull='��ѡ���ļ�����'><option value=''>--��ѡ��--</option><option value='1'>˫������</option><option value='2'>����������Ů��</option><option value='2'>�����������У�</option></select><br/><span id='syrxb" + seqNum + "' style='display:none;'><select name='P_ADOPTER_SEX" + seqNum + "' id='P_ADOPTER_SEX" + seqNum + "' onchange='_dynamic2Hide(" + seqNum + ")' type='text' style='height:22px; font-size:12px; width: 95%' formTitle='null' notnull='��ѡ���������Ա�'><option value=''>--��ѡ��--</option><option value='1'>��</option><option value='2'>Ů</option></select></span></td>"
			+ "<td><input name='P_MALE_NAME" + seqNum + "' id='P_MALE_NAME" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' notnull='�������з�'/></td>"
			+ "<td><input name='P_MALE_BIRTHDAY" + seqNum + "' id='P_MALE_BIRTHDAY" + seqNum + "' class='Wdate' style='padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;' onclick='error_onclick(this);' onfocus='WdatePicker({dateFmt:&quot;yyyy-MM-dd&quot;,maxDate:&quot;%y-%M-%d&quot;})' type='text' notnull='��ѡ���г�������'/></td>"
			+ "<td><input name='P_FEMALE_NAME" + seqNum + "' id='P_FEMALE_NAME" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' notnull='������Ů��'/></td>"
			+ "<td><input name='P_FEMALE_BIRTHDAY" + seqNum + "' id='P_FEMALE_BIRTHDAY" + seqNum + "' class='Wdate' style='padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;' onclick='error_onclick(this);' onfocus='WdatePicker({dateFmt:&quot;yyyy-MM-dd&quot;,maxDate:&quot;%y-%M-%d&quot;})' type='text' notnull='��ѡ��Ů��������'/></td>"
			+ "<td><input name='P_REG_REMARK" + seqNum + "' id='P_REG_REMARK" + seqNum + "' class='inputText' style='width: 97%' type='text'/></td>");
		/* newTr.html("<td class=\"center\">"+
					"<input name=\"xuanze\" class=\"ace\" onclick=\"error_onclick(this);\" type=\"checkbox\" />"+
						"</td>"+
						"<td>"+
							"<select name=\"P_FILE_TYPE\" onkeyup=\"_check_one(this);\" onchange=\"_dynamicJznsy()\" type=\"text\" style=\"height:22px; font-size:12px; width: 95%\" formTitle=\"null\" notnull=\"��ѡ���ļ�����\"><option value=\"\">--��ѡ��--</option><option value=\"10\">����</option><option value=\"30\">�쵼����</option><option value=\"31\">�ڻ�</option><option value=\"32\">����</option><option value=\"33\">����Ů����</option><option value=\"34\">��������</option><option value=\"35\">����</option></select>"+
						"</td>"+
						"<td>"+
							"<select name=\"P_FAMILY_TYPE\" onkeyup=\"_check_one(this);\" onchange=\"_dynamicHide()\" type=\"text\" style=\"height:22px; font-size:12px; width: 95%\" formTitle=\"null\" notnull=\"��ѡ���ļ�����\"><option value=\"\">--��ѡ��--</option><option value=\"1\">˫������</option><option value=\"2\">����������Ů��</option><option value=\"2\">�����������У�</option></select>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_MALE_NAME\" class=\"inputText\" style=\"width: 93%\" onkeyup=\"_check_one(this);\" onchange=\"\" type=\"text\" formTitle=\"null\" notnull=\"�������з�\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_MALE_BIRTHDAY\" class=\"Wdate\" style=\"padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;\" onclick=\"error_onclick(this);\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})\" type=\"text\" formTitle=\"null\" notnull=\"��ѡ���г�������\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_FEMALE_NAME\" class=\"inputText\" style=\"width: 93%\" onkeyup=\"_check_one(this);\" onchange=\"\" type=\"text\" formTitle=\"null\" notnull=\"������Ů��\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_FEMALE_BIRTHDAY\" class=\"Wdate\" style=\"padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;\" onclick=\"error_onclick(this);\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})\" type=\"text\" formTitle=\"null\" notnull=\"��ѡ��Ů��������\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_REG_REMARK\" class=\"inputText\" style=\"width: 97%\" onkeyup=\"_check_one(this);\" onchange=\"\" type=\"text\"/>"+
						"</td>"); */
		$("#info").append(newTr);
		
	}
	//ɾ��ѡ����ļ���Ϣ
	function _deleteRow() {
		var af_cost=$("#P_AF_COST").val();
		
		var num = 0;
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				num += 1;
			}
		}
		var totalNum = (arrays.length+1-num)*af_cost;
		$("#P_PAID_SHOULD_NUM").val(totalNum);//��̬����Ӧ�ɷ���
		$(':checkbox[name=xuanze]').each(function(){
			if($(this).attr('checked')){
				$(this).closest('tr').remove();
			}
		}); 
	}
	
	//�����������ͣ���̬����Ů�������������ڽ���ֻ���ͱ���������
	function _dynamicHide(obj){
		var optionText = $("#P_FAMILY_TYPE" + obj).find("option:selected").text();
		if(optionText=="����������Ů��"){
			//��̬������Ů��������������ֻ�����Ժͳ�ʼֵ
			$("#P_MALE_NAME" + obj).val("");
			$("#P_MALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",true);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",true);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//����Ů����������������Ϊ������
			$("#P_FEMALE_NAME" + obj).attr("notnull","������Ů������");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","������Ů����������");
			$("#P_MALE_NAME" + obj).removeAttr("notnull");
			$("#P_MALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else if(optionText=="�����������У�"){
			//��̬������Ů��������������ֻ�����Ժͳ�ʼֵ
			$("#P_FEMALE_NAME" + obj).val("");
			$("#P_FEMALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",true);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",true);
			//�����з���������������Ϊ������
			$("#P_MALE_NAME" + obj).attr("notnull","�������з�����");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","�������з���������");
			$("#P_FEMALE_NAME" + obj).removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else if(optionText=="˫������"){
			//�Ƴ���Ů����������������Ϊֻ������
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//�����з���������������Ϊ������
			$("#P_MALE_NAME" + obj).attr("notnull","�������з�����");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","�������з���������");
			$("#P_FEMALE_NAME" + obj).attr("notnull","������Ů����������");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","������Ů����������");
		}
	}
	
	//�����������Ա𣬶�̬����Ů�������������ڽ���ֻ���ͱ���������
	function _dynamic2Hide(obj){
		var optionText = $("#P_ADOPTER_SEX" + obj).find("option:selected").text();
		if(optionText=="Ů"){
			//��̬������Ů��������������ֻ�����Ժͳ�ʼֵ
			$("#P_MALE_NAME" + obj).val("");
			$("#P_MALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",true);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",true);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//����Ů����������������Ϊ������
			$("#P_FEMALE_NAME" + obj).attr("notnull","������Ů������");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","������Ů����������");
			$("#P_MALE_NAME" + obj).removeAttr("notnull");
			$("#P_MALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else if(optionText=="��"){
			//��̬������Ů��������������ֻ�����Ժͳ�ʼֵ
			$("#P_FEMALE_NAME" + obj).val("");
			$("#P_FEMALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",true);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",true);
			//�����з���������������Ϊ������
			$("#P_MALE_NAME" + obj).attr("notnull","�������з�����");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","�������з���������");
			$("#P_FEMALE_NAME" + obj).removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else{
			//�Ƴ���Ů����������������Ϊֻ������
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//�����з���������������Ϊ������
			$("#P_MALE_NAME" + obj).attr("notnull","�������з�����");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","�������з���������");
			$("#P_FEMALE_NAME" + obj).attr("notnull","������Ů����������");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","������Ů����������");
		}
	}
	
	
	/**
	*�ļ�����Ϊ����Ů����ʱ���������������б�ֻ��ѡ����������Ů����
	*@author:mayun
	*@date:2014-7-17
	*/
	function _dynamicJznsy(obj){
		var sylx = $("#P_FILE_TYPE" + obj).find("option:selected").val();
		if(sylx=="33"){
			//������������Ϊ˫�����������û�
			$("#P_FAMILY_TYPE" + obj)[0].selectedIndex = 1; 
			$("#P_FAMILY_TYPE" + obj).attr("disabled",true);
			$("#syrxb" + obj).show();
			$("#P_ADOPTER_SEX" + obj).attr("notnull","�������������Ա�");
			//ȥ����Ů�������������ڱ�������
			$("#P_MALE_NAME" + obj).removeAttr("notnull");
			$("#P_MALE_BIRTHDAY" + obj).removeAttr("notnull");
			$("#P_FEMALE_NAME" + obj).removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY" + obj).removeAttr("notnull"); 
		}else{
			$("#P_FAMILY_TYPE" + obj)[0].selectedIndex = 0; 
			$("#P_FAMILY_TYPE" + obj).attr("disabled",false); 
			$("#syrxb" + obj).hide();
			$("#P_ADOPTER_SEX" + obj).removeAttr("notnull");
		}
	}
	
	//�����������Ͷ�̬���������Ա�ֵ
	function _dySetSyrxb(obj){
		var sylx = $("#P_FAMILY_TYPE" + obj).find("option:selected").text();
		if(sylx=="����������Ů��"){
			$("#P_ADOPTER_SEX" + obj)[0].selectedIndex = 2; 
		}else if(sylx=="�����������У�"){
			$("#P_ADOPTER_SEX" + obj)[0].selectedIndex = 1; 
		}else{
			$("#P_ADOPTER_SEX" + obj)[0].selectedIndex = 0; 
		}
	}
	
	
	
	
	//��̬��ʾƱ��¼����Ϣ
	function _dyShowPjInfo(){
		var temp=document.getElementsByName("P_ISPIAOJU");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var num = temp[i].value;
				$("#P_ISPIAOJUVALUE").val(num);
				if(num==0){//��
					$("#pjInfo").hide();
					$("#P_PAID_WAY").val("");
					$("#P_PAR_VALUE").val("");
					$("#P_PAID_WAY").removeAttr("notnull");
					$("#P_PAR_VALUE").removeAttr("notnull");
				}else{//��
					$("#pjInfo").show();
					$("#P_PAID_WAY").attr("notnull","������ɷѷ�ʽ");
					$("#P_PAR_VALUE").attr("notnull","������Ʊ����");
				}
			}
		}
	}
	
	
	
	//��ȡӦ�ɽ��
	function _getAfCost(){
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=getAfCost&file_type=ZCWJFWF',
			type: 'POST',
			timeout:1000,
			dataType: 'json',
			success: function(data){
				$("#P_AF_COST").val(data.VALUE1);
				$("#P_PAID_SHOULD_NUM").val(data.VALUE1);
			}
	  	  });
	}
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;WJLX_DL;FYLB;JFFS;FWF" property="wjdlData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_CN"/>
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_EN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_CN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_EN"/>
		<BZ:input type="hidden" field="ISPIAOJUVALUE" prefix="P_" id="P_ISPIAOJUVALUE"/>
		<BZ:input type="hidden" prefix="P_" field="AF_COST" id="P_AF_COST"/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ļ�������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:select field="COUNTRY_CODE" formTitle="" notnull="���������"
									prefix="P_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
									onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--��ѡ��--
									</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
									onchange="_setOrgID('P_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
							<td class="bz-edit-data-title" width="20%" style="text-align: center;">
								<input type="button" value="���" class="btn btn-sm btn-primary" onclick="_addRow()"/>
								<input type="button" value="�Ƴ�" class="btn btn-sm btn-primary" onclick="_deleteRow()"/>
							</td>
						</tr>
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
									<tr style="background-color: rgb(180, 180, 249);">
										<th style="width: 3%; text-align: center; border-left: 0;">
											<div class="sorting_disabled">
												<input type="checkbox" class="ace">
											</div>
										</th>
										<th style="width: 12%; text-align: center;">
											<div class="sorting_disabled" id="FILE_TYPE">�ļ�����</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="FAMILY_TYPE">��������</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="MALE_NAME">�з�</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="MALE_BIRTHDAY">�г�������</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_NAME">Ů��</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_BIRTHDAY">Ů��������</div></th>
										<th style="width: 25%; text-align: center;">
											<div class="sorting_disabled" id="REG_REMARK">��ע</div></th>
									</tr>
									</thead>
									<tbody>
									<tr class="emptyData">
										<td class="center">
										</td>
										<td>
											<BZ:select field="FILE_TYPE" id="P_FILE_TYPE" notnull="�������ļ�����" formTitle="" prefix="P_" isCode="true" codeName="WJLX_DL" onchange="_dynamicJznsy('')" width="95%">
												<option value="">--��ѡ��--</option>
											</BZ:select>
										</td>
										<td>
											<BZ:select field="FAMILY_TYPE" id="P_FAMILY_TYPE" notnull="��������������" formTitle="" prefix="P_" isCode="false" onchange="_dynamicHide('');_dySetSyrxb('')" width="95%">
												<option value="">--��ѡ��--</option>
												<option value="1">˫������</option>
												<option value="2">����������Ů��</option>
												<option value="2">�����������У�</option>
											</BZ:select>
											<br/>
											<span id="syrxb" style="display:none">
											<BZ:select field="ADOPTER_SEX" id="P_ADOPTER_SEX" notnull="�������������Ա�" formTitle="" prefix="P_" isCode="false" onchange="_dynamic2Hide('')" width="95%">
												<option value="">--��ѡ��--</option>
												<option value="1">��</option>
												<option value="2">Ů</option>
											</BZ:select>
											</span>
										</td>
										<td>
											<BZ:input field="MALE_NAME" id="P_MALE_NAME" prefix="P_" type="String"  formTitle="�з�" defaultValue="" notnull="�������з�" style="width:93%" maxlength="150"/>
										</td>
										<td>
											<BZ:input field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" prefix="P_" notnull="��ѡ���г�������" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
										</td>
										<td>
											<BZ:input field="FEMALE_NAME" id="P_FEMALE_NAME" prefix="P_" type="String"  formTitle="Ů��" defaultValue="" notnull="������Ů��" style="width:93%" maxlength="150"/>
										</td>
										<td>
											<BZ:input field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" prefix="P_" notnull="��ѡ��Ů��������" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
										</td>
										<td>
											<BZ:input field="REG_REMARK" id="P_REG_REMARK" type="String" prefix="P_" formTitle="��ע" defaultValue=""  style="width:97%" maxlength="500"/>
										</td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�Ƿ�¼��Ʊ����Ϣ</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:radio field="ISPIAOJU"  prefix="P_" formTitle="�Ƿ�¼��Ʊ����Ϣ" value="0" defaultChecked="true" onclick="_dyShowPjInfo()"/>��
								<BZ:radio field="ISPIAOJU"  prefix="P_" formTitle="�Ƿ�¼��Ʊ����Ϣ" value="1" onclick="_dyShowPjInfo()"/>��
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" id="pjInfo" style="display:none">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ʊ����Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="COST_TYPE" formTitle="" prefix="P_" isCode="true" codeName="FYLB" defaultValue="10" disabled="true" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>Ӧ�ɷ���</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input field="PAID_SHOULD_NUM" id="P_PAID_SHOULD_NUM" prefix="P_" formTitle="Ӧ�ɷ���"  style="width:67%"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�ɷѷ�ʽ</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="PAID_WAY"  formTitle="" prefix="P_" isCode="true" codeName="JFFS" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>Ʊ����</td>
							<td class="bz-edit-data-value">
								<BZ:input field="PAR_VALUE" id="P_PAR_VALUE" prefix="P_" type="String" restriction="number"  formTitle="Ʊ����" defaultValue="" style="width:67%"/>
							</td>
							<td class="bz-edit-data-title">�ɷ�Ʊ��</td>
							<td class="bz-edit-data-value">
								<BZ:input field="BILL_NO" prefix="P_" type="String"  formTitle="�ɷ�Ʊ��" defaultValue="" style="width:67%"/>
							</td>
							<td class="bz-edit-data-title">�ɷ�ƾ��</td>
							<td class="bz-edit-data-value">
								<up:uploadBody 
									attTypeCode="OTHER" 
									bigType="<%=AttConstants.FAM %>"
									smallType="<%=AttConstants.FAW_JFPJ %>"
									id="P_FILE_CODE" 
									name="P_FILE_CODE"
									packageId="<%=cheque_id %>" 
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="class_code=FAM"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
									/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�ɷѱ�ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="REMARKS" id="P_REMARKS" type="textarea" prefix="P_" formTitle="�ɷѱ�ע" maxlength="500" style="width:80%" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�Ǽ�" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
