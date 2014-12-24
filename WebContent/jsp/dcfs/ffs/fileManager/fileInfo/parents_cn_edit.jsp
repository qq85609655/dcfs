<%
/**   
 * @Title: parents_cn_edit.jsp
 * @Description:  ˫�������ļ�_����_�༭
 * @author wangzheng   
 * @date 2014-10-27
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.code.CodeList"%>
<%@page import="java.util.Map"%>

<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>

<%
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	Data d = (Data)request.getAttribute("data");
	CodeList coaList = (CodeList)request.getAttribute("coaList");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
	String strPar1 = "org_id="+orgId + ",af_id=" + afId;
	
%>
<BZ:html>
<BZ:head>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
    <title>�����ļ�����</title>
    <BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">
	<script type="text/javascript">
		//�����ϴ�-���ܷ���ֵ	
		var path = "<%=path%>";		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//�������˵Ľ���״��
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//Ů�����˵Ľ���״��		
		//var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//������λ
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//��������Υ����Ϊ�����´���
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů������Υ����Ϊ�����´���
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//�����������޲����Ⱥ�
		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů���������޲����Ⱥ�		

		var MARRY_DATE = "<BZ:dataValue type="String" field="MARRY_DATE" defaultValue="" onlyValue="true"/>";		//�������
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//��ͥ���ʲ�
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";		//��ͥ��ծ��
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//��Ч����
		var VALID_PERIOD_TYPE = "1";
		//�����Ч����Ϊ-1����ת��Ϊ2
		if(VALID_PERIOD=="-1"){
			VALID_PERIOD_TYPE="2";
		}
		var HOMESTUDY_ORG = "<BZ:dataValue type="String" field="HOMESTUDY_ORG" defaultValue="" onlyValue="true"/>";	//�ҵ������֯
		
		$(document).ready( function() {
			//����iframe
			dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ

		   
			//��ʼ������״��˵������ʾ������
			_setMale_health(male_health);
			_setFemale_health(female_health);
			//������ߡ����ص���ʾ��ʽ�����ơ�Ӣ�ƣ�
			//_setMeasurement(measurement);
			
			//����BMI
			//_setBMI("1");
			//_setBMI("2");
			
			
			//��ʼ������Υ����Ϊ�����´���
			_setMALE_PUNISHMENT_FLAG(MALE_PUNISHMENT_FLAG);
			_setFEMALE_PUNISHMENT_FLAG(FEMALE_PUNISHMENT_FLAG);
			
			//����״��--start			
			$("#FE_MALE_HEALTH").click(function(){
				_setMale_health($(this).val());
			});
			$("#FE_FEMALE_HEALTH").click(function(){
				_setFemale_health($(this).val());
			});
			//����״��--end

			//����Υ����Ϊ����ʽ�����仯����--start
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").click(function(){
				_setMALE_PUNISHMENT_FLAG($(this).val());
			});
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").click(function(){
				_setMALE_PUNISHMENT_FLAG($(this).val());
			});
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").click(function(){
				_setFEMALE_PUNISHMENT_FLAG($(this).val());
			});
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").click(function(){
				_setFEMALE_PUNISHMENT_FLAG($(this).val());
			});
			//����Υ����Ϊ����ʽ�����仯����--end
						
			//��ʼ���������޲����Ⱥ�
			_setMALE_ILLEGALACT_FLAG(MALE_ILLEGALACT_FLAG);
			_setFEMALE_ILLEGALACT_FLAG(FEMALE_ILLEGALACT_FLAG);
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").click(function(){
				_setMALE_ILLEGALACT_FLAG($(this).val());
			});
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").click(function(){
				_setMALE_ILLEGALACT_FLAG($(this).val());
			});
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").click(function(){
				_setFEMALE_ILLEGALACT_FLAG($(this).val());
			});
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").click(function(){
				_setFEMALE_ILLEGALACT_FLAG($(this).val());
			});

			//
			$("#FE_MALE_BIRTHDAY").change(function(){
				_chgBirthday($(this).val());
			});
			$("#FE_FEMALE_BIRTHDAY").change(function(){
				_chgBirthday($(this).val());
			});
			
			//���ý��ʱ��
			_setMarryLength(MARRY_DATE);
			
			//���ü�ͥ���ʲ�
			_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);

			//������Ч����
			_setValidPeriod(VALID_PERIOD_TYPE);

			//���üҵ������֯
			_setHomestudyOrg(HOMESTUDY_ORG);
		})
	//***********ҳ�洦��JS****************************************************
	/*
	* ���������޸�
	* o������
	* s���Ա�
	*/
	function _chgBirthday(o,s){
		if(s=="1"){	
			document.getElementById("MALE_AGE").innerHTML = getAge(o.value);			
		}else if(s=="2"){
			document.getElementById("FEMALE_AGE").innerHTML = getAge(o.value);			
		}		
	}
	
	/*
	* ����״�����ã�ѡ�񲻽�������ʾ�������˵��
	* p=2 ������ p=1 ����
	*/
	function _setMale_health(p){
		
		if("2"== p){
			$("#FE_MALE_HEALTH_CONTENT_CN").show();			
		}else{
			$("#FE_MALE_HEALTH_CONTENT_CN").hide();
		}
	}
	function _setFemale_health(p){
		if("2"== p){
			$("#FE_FEMALE_HEALTH_CONTENT_CN").show();			
		}else{
			$("#FE_FEMALE_HEALTH_CONTENT_CN").hide();
		}			
	}
	/*
	*����BMI
	*s=1 ��
	*s=2 Ů
	*/
	function _setBMI(s){
		if(s=="1"){	//��������			
			if($("#FE_MALE_HEIGHT").val()=="" || $("#FE_MALE_WEIGHT").val()==""){
				return;	
			}
			$("#FE_MALE_BMI").val(_bmi($("#FE_MALE_HEIGHT").val()/100,$("#FE_MALE_WEIGHT").val()));			
			
		}else if(s=="2"){//Ů������
			if($("#FE_FEMALE_HEIGHT").val()=="" || $("#FE_FEMALE_WEIGHT").val()==""){
				return;	
			}
			$("#FE_FEMALE_BMI").val(_bmi($("#FE_FEMALE_HEIGHT").val()/100,$("#FE_FEMALE_WEIGHT").val()));			
		}
			
	}
	
	//����BMI
	function _bmi(h,w){
		return parseFloat(w / (h * h)).toFixed(2);
	}
	
	/*
	* ������������Υ����Ϊ�����´���	
	*f 0���� 1:��
	*/
	function _setMALE_PUNISHMENT_FLAG(f){
		$("#FE_MALE_PUNISHMENT_FLAG").val(f);
		if(f == "1"){
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").get(0).checked = true;			
			$("#FE_MALE_PUNISHMENT_CN").show();
		}else{
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").get(0).checked = true;
			$("#FE_MALE_PUNISHMENT_CN").hide();
		}	
	}

	//����Ů������Υ����Ϊ�����´���
	function _setFEMALE_PUNISHMENT_FLAG(f){
		
		$("#FE_FEMALE_PUNISHMENT_FLAG").val(f);
		if(f == "1"){
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").get(0).checked = true;	
			$("#FE_FEMALE_PUNISHMENT_CN").show();
		}else{
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#FE_FEMALE_PUNISHMENT_CN").hide();
		}			
	}

	//�������޲����Ⱥ�
	function _setMALE_ILLEGALACT_FLAG(f){
		$("#FE_MALE_ILLEGALACT_FLAG").val(f);
		if("1" == f){
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#FE_MALE_ILLEGALACT_CN").show();
		}else{
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#FE_MALE_ILLEGALACT_CN").hide();
		}			
	}
	
	//�������޲����Ⱥ�
	function _setFEMALE_ILLEGALACT_FLAG(f){
		$("#FE_FEMALE_ILLEGALACT_FLAG").val(f);
		if(f == "1"){
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").get(0).checked = true;				
			$("#FE_FEMALE_ILLEGALACT_CN").show();
		}else{
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#FE_FEMALE_ILLEGALACT_CN").hide();
		}			
	}

	/*
	* ��������޸�
	* o������
	*/
	function _chgMarryDate(o){
		_setMarryLength(o.value);	
	}
	
	/*
	* ���ý��ʱ��
	* d���������
	*/
	function _setMarryLength(d){
		$("#FE_MARRY_LENGTH").text(getAge(d));
	}

	/*
	*��ͥ���ʲ��޸�
	*/
	function _chgTotalAsset(o){
		TOTAL_ASSET = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
	}
	
	/*
	*��ͥ��ծ���޸�
	*/
	function _chgTotalDebt(o){
		TOTAL_DEBT = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
	}
	
	/*
	* ���ü�ͥ���ʲ�
	*/
	function _setTotalManny(a,d){
		if(a=="" || d==""){
			return;
		}		
		$("#FE_TOTAL_MANNY").text(a - d);
	}

/*
	* ������Ч��������
	* 1:��Ч����
	* 2:����
	*/
	function _setValidPeriod(v){
		$("#FE_VALID_PERIOD_TYPE").val(v);
		if(v=="2"){			
			$("#tb_VALID_PERIOD").hide();			
		}else{			
			$("#tb_VALID_PERIOD").show();
		}
	}

	function _chgValidPeriod(v){
		if(v=="2"){			
			$("#tb_VALID_PERIOD").hide();
			$("#FE_VALID_PERIOD").val("-1");
		}else{			
			$("#tb_VALID_PERIOD").show();
			$("#FE_VALID_PERIOD").val("");
		}
	}

	/*
	*���üҵ���֯
	*/
	function _setHomestudyOrg(v){
		if(v=="Other"){
			$("#tb_HOMESTUDY_ORG_NAME").show();
		}else{
			$("#tb_HOMESTUDY_ORG_NAME").hide();
		}	
	}

	/*
	*�ҵ���֯�޸�
	*/
	function _chgHomestudyOrg(v){
		$("#FE_HOMESTUDY_ORG_NAME").val(v);
		_setHomestudyOrg(v);	
	}

	//***********�����ϴ�����JS****************************************************
	function getIframeVal(val)  
	{
		//document.getElementById("textareaid").value=urlDecode(val);
		//alert(document.getElementById("frmUpload"));
		//document.getElementById("frmUpload").location.reload();
		if(p=="0"){
			frmUpload.window.location.reload();
		}else{
			frmUpload1.window.location.reload();
		}
	}	
	
	var p = "0";
	//�����ϴ�
	function _toipload(fn){
		p = fn;		
		var packageId,isEn;
		//p=0���ϴ������
		if(p=="0"){
			packageId = "<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>";
			isEn = "false";
		}else{//p=0���ϴ�ԭ��
			packageId = "<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>";
			isEn = "true";
		}
		document.uploadForm.PACKAGE_ID.value = packageId;
		document.uploadForm.IS_EN.value = isEn;
		document.uploadForm.action="<%=path%>/uploadManager";
		popWin.showWinIframe("1000","600","fileframe","��������","iframe","#");
		document.uploadForm.submit();
	}
		//�ύ
	function _submit(){
		
		if (!runFormVerify(document.fileForm, false)) {
			return;
		}	
		document.fileForm.action=path+"/ffs/jbraudit/saveFileInfoAndHistroyInfo.action";
		document.fileForm.submit();
	}
	</script>
	
	<BZ:form name="fileForm" method="post">
		<!-- ��������begin -->
        <BZ:input type="hidden" prefix="FE_" field="AF_ID"					id="FE_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_PHOTO"				id="FE_MALE_PHOTO" defaultValue=""/> 
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_PHOTO"			id="FE_FEMALE_PHOTO" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_FLAG"	id="FE_MALE_PUNISHMENT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_FLAG" id="FE_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_FLAG"	id="FE_MALE_ILLEGALACT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_FLAG" id="FE_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_JOB_EN"			id="FE_MALE_JOB_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH_CONTENT_EN" id="FE_MALE_HEALTH_CONTENT_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_EN"		id="FE_MALE_PUNISHMENT_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_EN"		id="FE_MALE_ILLEGALACT_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="MALE_RELIGION_EN"		id="FE_MALE_RELIGION_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_JOB_EN"			id="FE_FEMALE_JOB_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH_CONTENT_EN" id="FE_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_EN"	id="FE_FEMALE_PUNISHMENT_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_EN"	id="FE_FEMALE_ILLEGALACT_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="FEMALE_RELIGION_EN"		id="FE_FEMALE_RELIGION_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="CHILD_CONDITION_EN"		id="FE_CHILD_CONDITION_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="ADOPT_REQUEST_EN"		id="FE_ADOPT_REQUEST_EN" defaultValue=""/>		
		<BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_EN"	id="FE_IS_FAMILY_OTHERS_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="REMARK_EN"				id="FE_REMARK_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="CHILDREN_HEALTH_CN"		id="FE_CHILDREN_HEALTH_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="PACKAGE_ID"				id="FE_PACKAGE_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="FE_" field="PACKAGE_ID_CN"			id="FE_PACKAGE_ID_CN" defaultValue=""/>
		<!-- ��������end -->
		

		<!--˫��������start-->                            	  
		<table class="specialtable" style="display:block">
			<tr>
				 <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
			</tr>
			<tr>
				<td>
					<table class="specialtable">
						<tr>                                    	
							<td class="edit-data-title" width="15%">&nbsp;</td>
							<td class="edit-data-title" colspan="2" style="text-align:center">��������</td>
							<td class="edit-data-title" colspan="2" style="text-align:center">Ů������</td>
						</tr>
						<tr>
							<td class="edit-data-title" width="15%">����</td>
							<td class="edit-data-value" width="27%">
								<BZ:input prefix="FE_" field="MALE_NAME" id="FE_MALE_NAME" defaultValue="" notnull="��������Ϊ�գ�"  maxlength="150" size="30"/>
							</td>
							<td class="edit-data-value" width="15%" rowspan="5">
								<up:uploadImage attTypeCode="AF" id="FE_MALE_PHOTO" packageId="<%=afId%>" name="FE_MALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_MALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=strPar%>"/>
							</td>
							<td class="edit-data-value" width="28%">
								<BZ:input prefix="FE_" field="FEMALE_NAME" id="FE_FEMALE_NAME" defaultValue="" notnull="��������Ϊ�գ�"  maxlength="150" size="30"/>
							</td>
							<td class="edit-data-value" width="15%" rowspan="5">
								<up:uploadImage attTypeCode="AF" id="FE_FEMALE_PHOTO" packageId="<%=afId%>" name="FE_FEMALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=strPar%>"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="MALE_BIRTHDAY" id="FE_MALE_BIRTHDAY" type="date" onchange="_chgBirthday(this,'1')"/>
																
							</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="FEMALE_BIRTHDAY" id="FE_FEMALE_BIRTHDAY" type="date" onchange="_chgBirthday(this,'2')"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����</td>
							<td class="edit-data-value">
								<div id="MALE_AGE" style="font-size:14px">
								<script>								
								document.write(getAge($("#FE_MALE_BIRTHDAY").val()));
								</script>
								</div>
							</td>
							<td class="edit-data-value" style="font-size:14px">
								<div id="FEMALE_AGE" style="font-size:14px">
								<script>
								document.write(getAge($("#FE_FEMALE_BIRTHDAY").val()));
								</script>
								</div>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue=""  id="FE_MALE_NATION" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:select prefix="FE_" field="FEMALE_NATION" formTitle="����" codeName="GJ" isCode="true"  defaultValue="" id="FE_FEMALE_NATION" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">���պ���</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="MALE_PASSPORT_NO" id="FE_MALE_PASSPORT_NO" type="String" formTitle="�������˻��պ���" defaultValue="" size="36"/>
							</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="FEMALE_PASSPORT_NO" id="FE_FEMALE_PASSPORT_NO" type="String" formTitle="Ů�����˻��պ���" defaultValue="" size="36"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">�ܽ����̶�</td>
							<td class="edit-data-value" colspan="2">
								<BZ:select prefix="FE_" field="MALE_EDUCATION" formTitle="���������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="FE_MALE_EDUCATION" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:select prefix="FE_" field="FEMALE_EDUCATION" formTitle="Ů�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="FE_FEMALE_EDUCATION" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">ְҵ</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input field="MALE_JOB_CN" prefix="FE_" formTitle="��������ְҵ" defaultValue=""  id="FE_MALE_JOB_CN" size="36"/>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input field="FEMALE_JOB_CN" prefix="FE_" formTitle="Ů������ְҵ" defaultValue="" id="FE_FEMALE_JOB_CN" size="36"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����״��</td>
							<td class="edit-data-value" colspan="2">
								<BZ:select field="MALE_HEALTH" prefix="FE_" formTitle="�������˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="FE_MALE_HEALTH" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>								
								<textarea style="dispaly:none;height: 40px;width: 90%;" name="FE_MALE_HEALTH_CONTENT_CN" id="FE_MALE_HEALTH_CONTENT_CN"><BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/></textarea>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:select field="FEMALE_HEALTH" prefix="FE_" formTitle="Ů�����˽���״��"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" id="FE_FEMALE_HEALTH" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
								<textarea style="dispaly:none;height: 40px;width: 90%;" name="FE_FEMALE_HEALTH_CONTENT_CN" id="FE_FEMALE_HEALTH_CONTENT_CN"><BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/></textarea>
							</td>
						</tr>
						 <tr>
							<td class="edit-data-title">���</td>
							<td class="edit-data-value" colspan="2">								
								
								<BZ:input field="MALE_HEIGHT" id="FE_MALE_HEIGHT"  defaultValue="" restriction="number" maxlength="10" size="36" />����
							</td>
							<td class="edit-data-value" colspan="2">
								
								<BZ:input prefix="FE_" field="FEMALE_HEIGHT" id="FE_FEMALE_HEIGHT"  defaultValue="" restriction="number" maxlength="10" size="36" onchange="_setBMI('2')"/>����
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="MALE_WEIGHT" id="FE_MALE_WEIGHT" defaultValue="" restriction="number"  onchange="_setBMI('1')" maxlength="10" size="36"/>ǧ��
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="FEMALE_WEIGHT" id="FE_FEMALE_WEIGHT" defaultValue="" restriction="number" onchange="_setBMI('2')" maxlength="10" size="36"/>ǧ��
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����ָ��</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="MALE_BMI" id="FE_MALE_BMI" defaultValue="" size="10" readonly="true"/>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="FEMALE_BMI" id="FE_FEMALE_BMI" defaultValue="" size="10" readonly="true"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">Υ����Ϊ�����´���</td>
							<td class="edit-data-value" colspan="2">
								<input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG0" value="0">��
								<input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG1" value="1">��
								<BZ:input prefix="FE_" field="MALE_PUNISHMENT_CN" id="FE_MALE_PUNISHMENT_CN" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%"/>
							</td>
							<td class="edit-data-value" colspan="2">
								<input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0" value="0">��
								<input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1" value="1">��
								<BZ:input prefix="FE_" field="FEMALE_PUNISHMENT_CN" id="FE_FEMALE_PUNISHMENT_CN" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">���޲����Ⱥ�</td>
							<td class="edit-data-value" colspan="2">
								<input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG0" value="0">��
								<input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG1" value="1">��
								<BZ:input prefix="FE_" field="MALE_ILLEGALACT_CN" id="FE_MALE_ILLEGALACT_CN" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
							<td class="edit-data-value" colspan="2">
								<input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0" value="0">��
								<input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1" value="1">��
								<BZ:input prefix="FE_" field="FEMALE_ILLEGALACT_CN" id="FE_FEMALE_ILLEGALACT_CN" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">�ڽ�����</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="MALE_RELIGION_CN" id="FE_MALE_RELIGION_CN"  defaultValue="" maxlength="500" size="36"/>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="FEMALE_RELIGION_CN" id="FE_FEMALE_RELIGION_CN"  defaultValue="" maxlength="500" size="36"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" width="15%">����״��</td>
							<td class="edit-data-value" colspan="4">�ѻ�</td>
							
						</tr>
						<tr>
							<td class="edit-data-title" width="15%">�������</td>
							<td class="edit-data-value" width="18%">
								<BZ:input prefix="FE_" field="MARRY_DATE" id="FE_MARRY_DATE" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,1,'MARRY_DATE')"/>
							</td>
							<td class="edit-data-title" width="15%">����ʱ�����꣩</td>
							<td class="edit-data-value" colspan="2">
								<div id="FE_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">ǰ�����</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="MALE_MARRY_TIMES" id="FE_MALE_MARRY_TIMES" restriction="int" defaultValue=""  size="36"/>��
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="FEMALE_MARRY_TIMES" id="FE_FEMALE_MARRY_TIMES" restriction="int" defaultValue="" size="36"/>��
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">���ҵ�λ</td>
							<td class="edit-data-value" colspan="4">
								<BZ:select prefix="FE_" field="CURRENCY" id="FE_CURRENCY" defaultValue="" isCode="true" codeName="HBBZ"  formTitle="���ҵ�λ" width="170px" width="245px">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="MALE_YEAR_INCOME" id="FE_MALE_YEAR_INCOME" defaultValue="" restriction="number"  maxlength="22" size="36"/>
							</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="FEMALE_YEAR_INCOME" id="FE_FEMALE_YEAR_INCOME" defaultValue="" restriction="number"  maxlength="22" size="36"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ͥ���ʲ�</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="TOTAL_ASSET" id="FE_TOTAL_ASSET" defaultValue="" restriction="int" onchange="_chgTotalAsset(this)"/>
							</td>
							<td class="edit-data-title">��ͥ��ծ��</td>
							<td class="edit-data-value" colspan="2">
								<BZ:input prefix="FE_" field="TOTAL_DEBT" id="FE_TOTAL_DEBT" defaultValue="" restriction="int" onchange="_chgTotalDebt(this)"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ͥ���ʲ�</td>
							<td class="edit-data-value" colspan="4">
								<div id="FE_TOTAL_MANNY"></div>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">18����������Ů����</td>
							<td class="edit-data-value" colspan="4">
								<BZ:input prefix="FE_" field="UNDERAGE_NUM" id="FE_UNDERAGE_NUM" defaultValue="" restriction="int"/>��
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��Ů���������</td>
							<td class="edit-data-value" colspan="4">
								<BZ:input prefix="FE_" field="CHILD_CONDITION_CN" id="FE_CHILD_CONDITION_CN" defaultValue="" type="textarea" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ͥסַ</td>
							<td class="edit-data-value" colspan="4">
								<BZ:input prefix="FE_" field="ADDRESS" id="FE_ADDRESS" defaultValue="" maxlength="500" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" width="15%">����Ҫ��</td>
							<td class="edit-data-value" colspan="4">
								<BZ:input prefix="FE_" field="ADOPT_REQUEST_CN" id="FE_ADOPT_REQUEST_CN" defaultValue="" type="textarea" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						 
					</table>
					<table class="specialtable">
						<tr>
							<td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
						</tr>
						<tr>
							<td class="edit-data-title">��ɼҵ���֯����</td>
							<td class="edit-data-value" colspan="3">
								<BZ:select field="HOMESTUDY_ORG" defaultValue="" isCode="true" codeName="ORGCOA_LIST"  formTitle="��ɼҵ���֯����" width="450px" onchange="_chgHomestudyOrg(this.value)">
								<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-value" colspan="2">
								<span id="tb_HOMESTUDY_ORG_NAME" style="display: none">
								<BZ:input prefix="FE_" field="HOMESTUDY_ORG_NAME" id="FE_HOMESTUDY_ORG_NAME" defaultValue="" style="width:90%"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" style="width: 15%">��ͥ�����������</td>
							<td class="edit-data-value" style="width: 18%">
								<BZ:input prefix="FE_" field="FINISH_DATE" id="FE_FINISH_DATE" defaultValue="" type="Date"/>
							</td>
							<td class="edit-data-title" style="width: 15%">����������Σ�</td>
							<td class="edit-data-value" style="width: 18%">
								<BZ:input prefix="FE_" field="INTERVIEW_TIMES" id="FE_INTERVIEW_TIMES" defaultValue="" restriction="int" style="width:60%"/>
							</td>
							<td class="edit-data-title" style="width: 15%">�Ƽ��ţ��⣩</td>
							<td class="edit-data-value" style="width: 18%">
								<BZ:input prefix="FE_" field="RECOMMENDATION_NUM" id="FE_RECOMMENDATION_NUM" defaultValue="" restriction="int" style="width:60%"/></td>
						</tr>
						<tr>
							<td class="edit-data-title">������������</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="HEART_REPORT" id="FE_HEART_REPORT" defaultValue="" isCode="true"  formTitle="������������"  codeName="ADOPTER_HEART_REPORT" width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="ADOPT_MOTIVATION" id="FE_ADOPT_MOTIVATION" defaultValue="" isCode="true" formTitle="��������" codeName="ADOPTER_ADOPT_MOTIVATION" width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="CHILDREN_ABOVE" id="FE_CHILDREN_ABOVE" defaultValue="" isCode="true" formTitle="����10���꼰���Ϻ��Ӷ����������" codeName="ADOPTER_CHILDREN_ABOVE" width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>                                        
							<td class="edit-data-title">����ָ���໤��</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_FORMULATE" id="FE_IS_FORMULATE" defaultValue="" formTitle="����ָ���໤��"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">��������Ű������</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_ABUSE_ABANDON" id="FE_IS_ABUSE_ABANDON" defaultValue="" formTitle="��������Ű������"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>                                    
							<td class="edit-data-title">�����ƻ�</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_MEDICALRECOVERY" id="FE_IS_MEDICALRECOVERY" defaultValue="" formTitle="�����ƻ�"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>								
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����ǰ׼��</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="ADOPT_PREPARE" id="FE_ADOPT_PREPARE" defaultValue="" formTitle="����ǰ׼��"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">������ʶ</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="RISK_AWARENESS" id="FE_RISK_AWARENESS" defaultValue="" formTitle="������ʶ"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>								
							</td>                                    
							<td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_SUBMIT_REPORT" id="FE_IS_SUBMIT_REPORT" defaultValue="" formTitle="ͬ��ݽ����ú󱨸�����"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
						</tr>
						
						<tr>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="PARENTING" id="FE_PARENTING" defaultValue="" formTitle="��������"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">�繤���</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="SOCIALWORKER" id="FE_SOCIALWORKER" formTitle="�繤���" defaultValue=""  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="1">֧��</BZ:option>
									<BZ:option value="2">�������</BZ:option>
									<BZ:option value="3">��֧��</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">�Ƿ�Լ����</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_CONVENTION_ADOPT" id="FE_IS_CONVENTION_ADOPT" formTitle="�Ƿ�Լ����" defaultValue=""  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��������������ͬס</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_FAMILY_OTHERS_FLAG" id="FE_IS_FAMILY_OTHERS_FLAG" defaultValue="" formTitle="��������������ͬס"  width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>																
							</td>
							<td class="edit-data-title">����������ͬס˵��</td>
							<td class="edit-data-value" colspan="3">
								<BZ:input prefix="FE_" field="IS_FAMILY_OTHERS_CN" id="FE_IS_FAMILY_OTHERS_CN" type="textarea" defaultValue="" maxlength="500" style="width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ͥ��˵������������</td>
							<td class="edit-data-value" colspan="5">
								<BZ:input prefix="FE_" field="REMARK_CN" id="FE_REMARK_CN" type="textarea" defaultValue="" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
						</tr>
						<tr>
							<td class="edit-data-title">��׼����</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="GOVERN_DATE" id="FE_GOVERN_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="edit-data-title">��Ч����</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="VALID_PERIOD_TYPE" id="FE_VALID_PERIOD_TYPE" defaultValue="" formTitle="��Ч����" onchange="_chgValidPeriod(this.value)">
									<BZ:option value="1">��Ч����</BZ:option>
									<BZ:option value="2">����</BZ:option>
								</BZ:select>
								<span id="tb_VALID_PERIOD" style="display: none">
								<BZ:input prefix="FE_" field="VALID_PERIOD" id="FE_VALID_PERIOD" defaultValue="" restriction="int" style="width:20%"/>��
								</span>
							</td>
							<td class="edit-data-title">��׼��ͯ����</td>
							<td class="edit-data-value" width="19%">
								<BZ:input prefix="FE_" field="APPROVE_CHILD_NUM" id="FE_APPROVE_CHILD_NUM" defaultValue="" restriction="int"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������ͯ����</td>
							<td class="edit-data-value">
								<BZ:input prefix="FE_" field="AGE_FLOOR" id="FE_AGE_FLOOR" defaultValue="" restriction="int" maxlength="22" style="width:30%"/>��~
								<BZ:input prefix="FE_" field="AGE_UPPER" id="FE_AGE_UPPER" defaultValue="" restriction="int" maxlength="22" style="width:30%"/>��
							</td>
							<td class="edit-data-title">������ͯ�Ա�</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="CHILDREN_SEX" id="FE_CHILDREN_SEX" defaultValue="" isCode="true" formTitle="������ͯ�Ա�" codeName="ADOPTER_CHILDREN_SEX" width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">������ͯ����״��</td>
							<td class="edit-data-value" width="19%">
								<BZ:select prefix="FE_" field="CHILDREN_HEALTH_EN" id="FE_CHILDREN_HEALTH_EN"  defaultValue="" formTitle="������ͯ����״��" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" colspan="1" style="text-align:center"></td>
							<td class="edit-data-title" colspan="4" style="text-align:center">
							<b>������Ϣ</b></td>
							<td class="edit-data-title" colspan="1" style="text-align:center">
							<input type="button" class="btn btn-sm btn-primary" value="�����ϴ�" onclick="_toipload('0')" />
							</td>
						</tr>
						<tr>
							<td colspan="6">
							<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" ></IFRAME> 
							</td>
						</tr>
						<script>
						document.all("frmUpload1").style.height=document.body.scrollHeight; 
						</script>
					</table>                                
				</td>
			</tr>
		</table>     	
	</BZ:form>
	<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--����ʹ�ã�start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=xmlstr%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value=""/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='<%=strPar1%>'/>		
	<!--����ʹ�ã�end-->
	</form>
	</BZ:body>
</BZ:html>

