<%
/**   
 * @Title: apply_translation_singletran.jsp
 * @Description:  ���������ļ�����ҳ
 * @author panfeng   
 * @date 2014-10-10 ����1:29:03 
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	
	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
%>
<BZ:html>
<script type="text/javascript" src="<%=path%>/resource/js/common.js"/>
<BZ:head>
	<up:uploadResource isImage="true"/>
    <title>�ļ�����ҳ������������</title>
    <BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>	
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		var path = "<%=path%>";
		var formType = "dqsy";
		var arrayFields = new Array('NAME','BIRTHDAY','PHOTO','NATION','PASSPORT_NO','EDUCATION','JOB_CN','JOB_EN','HEALTH','HEALTH_CONTENT_CN','HEALTH_CONTENT_EN','HEIGHT','WEIGHT','BMI','PUNISHMENT_FLAG','PUNISHMENT_CN','PUNISHMENT_EN','ILLEGALACT_FLAG','ILLEGALACT_CN','ILLEGALACT_EN','RELIGION_CN','RELIGION_EN','MARRY_TIMES','YEAR_INCOME');

		var FAMILY_TYPE = "<BZ:dataValue type="String" field="FAMILY_TYPE" defaultValue="1" onlyValue="true"/>";		//��������
		var FILE_TYPE = "<BZ:dataValue type="String" field="FILE_TYPE" defaultValue="1" onlyValue="true"/>";			//�ļ�����	
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// �������Ա�
		
		var	MALE_NAME			= "<BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>";		
		var	MALE_BIRTHDAY		= "<BZ:dataValue type="String" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>";
		if(""!=MALE_BIRTHDAY){
			MALE_BIRTHDAY = MALE_BIRTHDAY.substr(0,10);
		}
		var	MALE_PHOTO			= "<BZ:dataValue type="String" field="MALE_PHOTO" defaultValue="" onlyValue="true"/>";
		var	MALE_NATION			= "<BZ:dataValue type="String" field="MALE_NATION" defaultValue="" onlyValue="true"/>";
		var	MALE_PASSPORT_NO	= "<BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>";
		var	MALE_EDUCATION		= "<BZ:dataValue type="String" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>";
		var	MALE_JOB_CN			= "<BZ:dataValue type="String" field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>";
		var	MALE_JOB_EN			= "<BZ:dataValue type="String" field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>";
		var	MALE_MARRY_TIMES	= "<BZ:dataValue type="String" field="MALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>";
		var	MALE_YEAR_INCOME	= "<BZ:dataValue type="String" field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>";
		var	FEMALE_NAME			= "<BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>";		
		var	FEMALE_BIRTHDAY		= "<BZ:dataValue type="String" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>";
		if(""!=FEMALE_BIRTHDAY){
			FEMALE_BIRTHDAY = FEMALE_BIRTHDAY.substr(0,10);
		}		
		var AGE = ("2"==ADOPTER_SEX)?getAge(FEMALE_BIRTHDAY):getAge(MALE_BIRTHDAY);
		var	FEMALE_PHOTO		= "<BZ:dataValue type="String" field="FEMALE_PHOTO" defaultValue="" onlyValue="true"/>";
		var	FEMALE_NATION		= "<BZ:dataValue type="String" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>";
		var	FEMALE_PASSPORT_NO	= "<BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>";
		var	FEMALE_EDUCATION	= "<BZ:dataValue type="String" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>";
		var	FEMALE_JOB_CN		= "<BZ:dataValue type="String" field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>";
		var	FEMALE_JOB_EN		= "<BZ:dataValue type="String" field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>";
		var	FEMALE_MARRY_TIMES	= "<BZ:dataValue type="String" field="FEMALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>";
		var	FEMALE_YEAR_INCOME	= "<BZ:dataValue type="String" field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>";
		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//�������˵Ľ���״��
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//Ů�����˵Ľ���״��		
		var MALE_HEALTH_CONTENT_CN = "<BZ:dataValue type="String" field="MALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>";	//�������˵Ľ���״������-����
		var FEMALE_HEALTH_CONTENT_CN = "<BZ:dataValue type="String" field="FEMALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>";	//Ů�����˵Ľ���״������-����
		var MALE_HEALTH_CONTENT_EN = "<BZ:dataValue type="String" field="MALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>";	//�������˵Ľ���״������-����
		var FEMALE_HEALTH_CONTENT_EN = "<BZ:dataValue type="String" field="FEMALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>";	//Ů�����˵Ľ���״������-����
		
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//��������Υ����Ϊ�����´���
		var MALE_PUNISHMENT_CN = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>";	//��������Υ����Ϊ�����´���
		var MALE_PUNISHMENT_EN = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>";	//��������Υ����Ϊ�����´���
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů������Υ����Ϊ�����´���
		var FEMALE_PUNISHMENT_CN = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>";	//Ů������Υ����Ϊ�����´���
		var FEMALE_PUNISHMENT_EN = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>";	//Ů������Υ����Ϊ�����´���
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//�����������޲����Ⱥ�
		var MALE_ILLEGALACT_CN = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>";	//�����������޲����Ⱥ�
		var MALE_ILLEGALACT_EN = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>";	//�����������޲����Ⱥ�

		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů���������޲����Ⱥ�
		var FEMALE_ILLEGALACT_CN = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>";	//Ů���������޲����Ⱥ�
		var FEMALE_ILLEGALACT_EN = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>";	//Ů���������޲����Ⱥ�

		var MARRY_DATE = "<BZ:dataValue type="String" field="MARRY_DATE" defaultValue="" onlyValue="true"/>";			//�������
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//��ͥ���ʲ�
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";			//��ͥ��ծ��
		
		var CONABITA_PARTNERS = "<BZ:dataValue type="String" field="CONABITA_PARTNERS" defaultValue="0" onlyValue="true"/>";//ͬ�ӻ��
		var GAY_STATEMENT =  "<BZ:dataValue type="String" field="GAY_STATEMENT" defaultValue="0" onlyValue="true"/>";//��ͬ��������
		
		var objField = [{"name":"NAME","MALE":MALE_NAME,"FEMALE":FEMALE_NAME,"syn":"1","type":"text","pre":""},
						{"name":"BIRTHDAY","MALE":MALE_BIRTHDAY,"FEMALE":FEMALE_BIRTHDAY,"syn":"1","type":"text","pre":""},
						{"name":"PHOTO","MALE":MALE_PHOTO,"FEMALE":FEMALE_PHOTO,"syn":"1","type":"photo","pre":""},
						{"name":"NATION","MALE":MALE_NATION,"FEMALE":FEMALE_NATION,"syn":"1","type":"select","pre":""},
						{"name":"PASSPORT_NO","MALE":MALE_PASSPORT_NO,"FEMALE":FEMALE_PASSPORT_NO,"syn":"1","type":"text","pre":""},
						{"name":"EDUCATION","MALE":MALE_EDUCATION,"FEMALE":FEMALE_EDUCATION,"syn":"1","type":"select","pre":""},
						{"name":"JOB_CN","MALE":MALE_JOB_CN,"FEMALE":FEMALE_JOB_CN,"syn":"0","type":"text","pre":"cn"},
						{"name":"JOB_EN","MALE":MALE_JOB_EN,"FEMALE":FEMALE_JOB_EN,"syn":"0","type":"text","pre":"en"},
						{"name":"MARRY_TIMES","MALE":MALE_MARRY_TIMES,"FEMALE":FEMALE_MARRY_TIMES,"syn":"1","type":"text","pre":""},
						{"name":"YEAR_INCOME","MALE":MALE_YEAR_INCOME,"FEMALE":FEMALE_YEAR_INCOME,"syn":"1","type":"text","pre":""},
						{"name":"HEALTH","MALE":male_health,"FEMALE":female_health,"syn":"1","type":"select","pre":""},
						{"name":"HEALTH_CONTENT_CN","MALE":MALE_HEALTH_CONTENT_CN,"FEMALE":FEMALE_HEALTH_CONTENT_CN,"syn":"0","type":"text","pre":"cn"},
						{"name":"HEALTH_CONTENT_EN","MALE":MALE_HEALTH_CONTENT_EN,"FEMALE":FEMALE_HEALTH_CONTENT_EN,"syn":"0","type":"text","pre":"en"}
						];

		male_health = ("2"==ADOPTER_SEX)?female_health:male_health;		
		
		MALE_PUNISHMENT_FLAG = ("2"==ADOPTER_SEX)?FEMALE_PUNISHMENT_FLAG:MALE_PUNISHMENT_FLAG;
		MALE_PUNISHMENT_CN = ("2"==ADOPTER_SEX)?FEMALE_PUNISHMENT_CN:MALE_PUNISHMENT_CN;
		MALE_PUNISHMENT_EN = ("2"==ADOPTER_SEX)?FEMALE_PUNISHMENT_EN:MALE_PUNISHMENT_EN;
		MALE_ILLEGALACT_FLAG = ("2"==ADOPTER_SEX)?FEMALE_ILLEGALACT_FLAG:MALE_ILLEGALACT_FLAG;
		MALE_ILLEGALACT_CN = ("2"==ADOPTER_SEX)?FEMALE_ILLEGALACT_CN:MALE_ILLEGALACT_CN;
		MALE_ILLEGALACT_EN = ("2"==ADOPTER_SEX)?FEMALE_ILLEGALACT_EN:MALE_ILLEGALACT_EN;
		
		$(document).ready( function() {
			//$('#tabTitle').scrollToFixed({marginTop:40});
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		    $('#tab-container').easytabs();
			
			_initData();

			//��ʼ������״��˵������ʾ������
			_setMale_health(male_health);			
		
			//��ʼ������Υ����Ϊ�����´���
			_setMALE_PUNISHMENT_FLAG(MALE_PUNISHMENT_FLAG);
			//��ʼ���������޲����Ⱥ�
			_setMALE_ILLEGALACT_FLAG(MALE_ILLEGALACT_FLAG);
			//����ͬ�ӻ��
			_setRadio("CONABITA_PARTNERS",CONABITA_PARTNERS);
			//���÷�ͬ��������
			_setRadio("GAY_STATEMENT",GAY_STATEMENT);			
			
			//���ü�ͥ���ʲ�
			_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
			
		})

		//�������Ա��޸�
		function _chgADOPTER_SEX(o,p,n){
			ADOPTER_SEX = o.value();
			_chgValue(o,p,n);
		}

		//����״���޸�
		function _chgMaleHealth(o,p,n){
			_setMale_health(o.value);
			_chgValue(o,p,n);
		}
		function _setMale_health(p){
			if("2"== p){
				$("#tb_dqsy_cn_MALE_HEALTH_CONTENT_CN").show();
				$("#tb_dqsy_en_MALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#tb_dqsy_cn_MALE_HEALTH_CONTENT_CN").hide();
				$("#tb_dqsy_en_MALE_HEALTH_CONTENT_EN").hide();
			}
		}

	
	//Υ����Ϊ�����´����޸�
	function _chgMALE_PUNISHMENT_FLAG(o,p,n){
		_setMALE_PUNISHMENT_FLAG(o.value);
		_chgValue(o,p,n);
	}

	//����Υ����Ϊ�����´���	
	function _setMALE_PUNISHMENT_FLAG(f){
		MALE_PUNISHMENT_FLAG = f;
		if(f == "1"){
			$("#tb_dqsy_cn_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_dqsy_cn_MALE_PUNISHMENT_FLAG1").get(0).checked = true;		
			$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG1").get(0).checked = true;			
			$("#tb_dqsy_cn_MALE_PUNISHMENT_CN").show();
			$("#tb_dqsy_cn_MALE_PUNISHMENT_CN").val(MALE_PUNISHMENT_CN);
			$("#tb_dqsy_en_MALE_PUNISHMENT_EN").show();
			$("#tb_dqsy_en_MALE_PUNISHMENT_EN").val(MALE_PUNISHMENT_EN) ;
		}else{
			$("#tb_dqsy_cn_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_dqsy_cn_MALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG0").get(0).checked = true;			
			$("#tb_dqsy_cn_MALE_PUNISHMENT_CN").hide();
			$("#tb_dqsy_en_MALE_PUNISHMENT_EN").hide();
		}	
	}

	//���޲����Ⱥ��޸�
	function _chgMALE_ILLEGALACT_FLAG(o,p,n){
		_setMALE_ILLEGALACT_FLAG(o.value);
		_chgValue(o,p,n);
	}
	
	//�������޲����Ⱥ�
	function _setMALE_ILLEGALACT_FLAG(f){
		MALE_ILLEGALACT_FLAG = f;
		if(f == "1"){
			$("#tb_dqsy_cn_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_dqsy_cn_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_dqsy_cn_MALE_ILLEGALACT_CN").show();
			$("#tb_dqsy_cn_MALE_ILLEGALACT_CN").val(MALE_ILLEGALACT_CN);
			$("#tb_dqsy_en_MALE_ILLEGALACT_EN").show();
			$("#tb_dqsy_en_MALE_ILLEGALACT_EN").val(MALE_ILLEGALACT_EN);

		}else{
			$("#tb_dqsy_cn_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_dqsy_cn_MALE_ILLEGALACT_FLAG0").get(0).checked = true;	
			$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#tb_dqsy_cn_MALE_ILLEGALACT_CN").hide();
			$("#tb_dqsy_en_MALE_ILLEGALACT_EN").hide();
		}			
	}
	
	//raido��ؼ��޸�
	function _chgRadio(o,p,n){
		 _setRadio(n,o.value);
		 _chgValue(o,p,n);
	}
	
	function _setRadio(rname,rvalue){
		var oc0 = "#tb_dqsy_cn_" + rname + "0";
		var oc1 = "#tb_dqsy_cn_" + rname + "1";
		var oe0 = "#tb_dqsy_en_" + rname + "0";
		var oe1 = "#tb_dqsy_en_" + rname + "1";

		if("1"  == rvalue){			
			$(oc0).removeAttr("checked");
			$(oc1).get(0).checked = true;	
			$(oe0).removeAttr("checked");
			$(oe1).get(0).checked = true;				
		}else{
			$(oc1).removeAttr("checked");
			$(oc0).get(0).checked = true;	
			
			$(oe1).removeAttr("checked");
			$(oe0).get(0).checked = true;				
		}			
	}
			
	/*
	* ���������޸�
	* o������
	* p����ǩҳ
	* n����������
	* s���Ա�
	*/
	function _chgBirthday(o,p,n,s){
		if(s=="1"){		
			document.getElementById("tb_dqsy_cn_MALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_dqsy_en_MALE_AGE").innerHTML = getAge(o.value);
		}else if(s=="2"){
			document.getElementById("tb_dqsy_cn_FEMALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_dqsy_en_FEMALE_AGE").innerHTML = getAge(o.value)
		}
		_chgValue(o,p,n);
	}
	
	
	/*
	* ��������޸�
	* o������
	* p����ǩҳ
	* n����������
	*/
	function _chgMarryDate(o,p,n){
		_setMarryLength(o.value);	
		_chgValue(o,p,n);
	}
	
	/*
	* ���ý��ʱ��
	* d���������
	*/
	function _setMarryLength(d){
		$("#tb_dqsy_cn_MARRY_LENGTH").text(getAge(d));
		$("#tb_dqsy_en_MARRY_LENGTH").text(getAge(d));
	}
	/*
	*��ͥ���ʲ��޸�
	*/
	function _chgTotalAsset(o,p,n){
		TOTAL_ASSET = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
		_chgValue(o,p,n);
	}
	
	/*
	*��ͥ��ծ���޸�
	*/
	function _chgTotalDebt(o,p,n){
		TOTAL_DEBT = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
		_chgValue(o,p,n);
	}
	
	/*
	* ���ü�ͥ���ʲ�
	*/
	function _setTotalManny(a,d){
		if(a=="" || d==""){
			return;
		}
		var r = parseInt(a) - parseInt(d)
		$("#tb_dqsy_cn_TOTAL_MANNY").text(r);
		$("#tb_dqsy_en_TOTAL_MANNY").text(r);	
	}
	/*
	* �������ı�������
	* o������
	* p����ǩҳ -1ʱ������Ҫ��Ӣ��ͬ��
	* n����������
	*/	
	function _chgValue(o,p,n){
		if(p!="-1"){
			var _id1 = _getP(p) + n;
			document.getElementById(_id1).value = o.value;
		}
		var ret = o.value;
		
		//�����Ӣ����ߣ��������򱣴湫���������
		if(n=="MALE_FEET" || n=="MALE_INCH"){
			n = "MALE_HEIGHT";
			ret = height;
		}
		if(n=="FEMALE_FEET" || n=="FEMALE_INCH"){
			n = "FEMALE_HEIGHT";
			ret = height;
		}
		//�����Ӣ�����أ��������򱣴湫����������
		if(n=="MALE_WEIGHT" ){
			ret = weight;
		}
		if(n=="FEMALE_WEIGHT"){
			ret = weight;
		}
		//����ǵ������������Ů�������жϺ������Ա�����Ů���ڶ���ǰ��ǰ׺"FE"���������������Ӧ�ֶ�
		if(formType == "dqsy" || formType == "jzn"){
			if("2" == ADOPTER_SEX){
				if(n.substr(0,4)=="MALE"){
					n = "FE" + n;
				}
			}
		}
		var _id2 = "P_" + n;
		//alert(_id2 + ":" + ret);
		document.getElementById(_id2).value = ret;
		
	}
	
	function _getP(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_dqsy_en_";		
			break;
		case 1:
			p1 = "tb_dqsy_cn_";
			break;	
		}
		return p1;
	}
	
	function _getP1(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_dqsy_cn_";		
			break;
		case 1:
			p1 = "tb_dqsy_en_";
			break;	
		}
		return p1;
	}

	//���뱣��
	function _save() {
	if (_check(document.srcForm)) {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/sce/translation/save.action";
		
		document.srcForm.submit();
	  }
	}
	//��������ύ
	function _submit() {
	if (_check(document.srcForm)) {
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/sce/translation/save.action";
		document.srcForm.submit();
	  }
	}
	//�����б�
	function _goback(){
		document.srcForm.action = path + "/sce/translation/applyTranslationList.action";
		document.srcForm.submit();
	}

	function _setData(){		
		var objField;
		if("1" == ADOPTER_SEX){//�е���
			$.each(arrayFields,function(n,value) {
				objField = "#P_FEMALE_" + value;
				$(objField).val("");
			}); 
		}else{//Ů����
			$.each(arrayFields,function(n,value) {
				objField = "#P_MALE_" + value;
				$(objField).val("");
			}); 
		}
	}

	function _initData(){
		$.each(objField,function(n,value) {
			var obj1 = "#tb_dqsy_cn_MALE_" + value.name;
			var obj2 = "#tb_dqsy_en_MALE_" + value.name;
			if("0"==value.syn){
				obj1 = "#tb_dqsy_"+value.pre+"_MALE_" + value.name;
			}
			if("select"==value.type){			
				_setSelectValue(obj1,("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				if("1"==value.syn){					
					_setSelectValue(obj2,("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				}
			}
			else if("text"==value.type){
				$(obj1).val(("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				if("1"==value.syn){					
					$(obj2).val(("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				}
			}
		}); 
	}

	function _setSelectValue(selName,selValue){
		var s1 = selName + " option";
		var s2 = selName;
		
		var count = $(s1).length;
		for(var i=0;i<count;i++){
			if($(s2).get(0).options[i].value==$.trim(selValue)){
				$(s2).get(0).options[i].selected = true;
				break;
			}
		}
	}


	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
        <BZ:input type="hidden" prefix="P_" field="RI_ID" id="P_RI_ID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="AF_ID" id="P_AF_ID" defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="AT_ID" id="R_AT_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"	id="R_TRANSLATION_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_TYPE" 	id="TRANSLATION_TYPE" defaultValue=""/>

        <BZ:input type="hidden" prefix="P_" field="MALE_NAME" id="P_MALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_NATION" id="P_MALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PASSPORT_NO" id="P_MALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_EDUCATION" id="P_MALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_JOB_CN" id="P_MALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_JOB_EN" id="P_MALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH" id="P_MALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH_CONTENT_CN" id="P_MALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH_CONTENT_EN" id="P_MALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEASUREMENT" id="P_MEASUREMENT" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_FLAG" id="P_MALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_CN" id="P_MALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_EN" id="P_MALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_FLAG" id="P_MALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_CN" id="P_MALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_EN" id="P_MALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_MARRY_TIMES" id="P_MALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_YEAR_INCOME" id="P_MALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_NAME" id="P_FEMALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_NATION" id="P_FEMALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PASSPORT_NO" id="P_FEMALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_EDUCATION" id="P_FEMALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_JOB_CN" id="P_FEMALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_JOB_EN" id="P_FEMALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH" id="P_FEMALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH_CONTENT_CN" id="P_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH_CONTENT_EN" id="P_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_FLAG" id="P_FEMALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_CN" id="P_FEMALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_EN" id="P_FEMALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_FLAG" id="P_FEMALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_CN" id="P_FEMALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_EN" id="P_FEMALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_MARRY_TIMES" id="P_FEMALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_YEAR_INCOME" id="P_FEMALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MARRY_CONDITION" id="P_MARRY_CONDITION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MARRY_DATE" 		id="P_MARRY_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CONABITA_PARTNERS" id="P_CONABITA_PARTNERS" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="CONABITA_PARTNERS_TIME" id="P_CONABITA_PARTNERS_TIME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="GAY_STATEMENT" id="P_GAY_STATEMENT" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="CURRENCY" id="P_CURRENCY" defaultValue="840"/> 
        <BZ:input type="hidden" prefix="P_" field="TOTAL_ASSET" id="P_TOTAL_ASSET" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="TOTAL_DEBT" id="P_TOTAL_DEBT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILD_CONDITION_CN" id="P_CHILD_CONDITION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILD_CONDITION_EN" id="P_CHILD_CONDITION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="UNDERAGE_NUM" id="P_UNDERAGE_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADDRESS" id="P_ADDRESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_CN" id="P_ADOPT_REQUEST_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_EN" id="P_ADOPT_REQUEST_EN" defaultValue=""/> 
		<BZ:input type="hidden" prefix="P_" field="ADOPTER_SEX" 		id="P_ADOPTER_SEX" defaultValue=""/> 

		<!-- ��������end -->
		<!--�ط�˵��:start-->
		<div id="tab-retranslation" style="display:<BZ:dataValue field="TRANSLATION_TYPE" onlyValue="true" checkValue="0=none;1=none;2=block"/>">
			<br>
			<table class="specialtable" align="center" style='width:98%;text-align:center'>
				<tr>
					<td class="edit-data-title" width="15%">֪ͨ��</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">֪ͨ����</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">�ط�״̬</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE"  onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">�ط�ԭ��</td>
					<td class="edit-data-value" colspan="5" width="85%"><BZ:dataValue field="AA_CONTENT" defaultValue="" /></td>
				</tr>
			</table>
		</div>
		<!--�ط�˵��:end-->
		
        <div id="tab-container" class='tab-container'>
			<ul class='etabs'>
					<li class='tab' id="tb1"><a href="#tab1">������Ϣ(����)</a></li>
					<li class='tab' id="tb2"><a href="#tab2">������Ϣ(����)</a></li>
			</ul>
			<div class='panel-container'>
            	<!--��ͥ�������(��)��start-->
            	<div id="tab1">
                	<!--�ļ�������Ϣ��start-->
                    <table class="specialtable">
                        <tr>
                            <td class="edit-data-title" width="15%">������֯(CN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">������֯(EN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">�ļ�����</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
                            </td>
                            <td class="edit-data-title" width="15%">��������</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
                            </td>
                            <td class="edit-data-title" width="15%">���ı��</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FILE_NO" hrefTitle="���ı��" defaultValue="" />
                            </td>
                        </tr>
                    </table>
                    <!--�ļ�������Ϣ��end-->                   
                    </table>
                    <!--����������start-->
                    <table id="tb_dqsy_cn" class="specialtable">
                    	<tr>
                             <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--��������Ϣ��start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>
                                        <td class="edit-data-title" width="15%">��������</td>
                                        <td class="edit-data-value" width="26%">
                                            <input id="tb_dqsy_cn_MALE_NAME"  class="inputText" maxlength="150" type="text" onkeyup="_check_one(this);" onmouseout="_inputMouseOut(this);" onmousemove="_inputMouseOver(this);"onblur="_inputMouseBlur(this);error_onblur(this);hide(true);" onfocus="_inputMouseFocus(this);this.select();" onclick="error_onclick(this);" onchange="_chgValue(this,0,'MALE_NAME')" value="" size="30" />
                                        </td>
                                        <td class="edit-data-title" width="15%">�Ա�</td>
                                        <td class="edit-data-value" width="26%">
                                            <BZ:select field="ADOPTER_SEX" id="tb_dqsy_cn_ADOPTER_SEX" formTitle=""  notnull="" width="210px" onchange="_chgValue(this,0,'ADOPTER_SEX')">
                                                <BZ:option value="1">��</BZ:option>
                                                <BZ:option value="2">Ů</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-value" width="18%" rowspan="6">
                                            <up:uploadImage attTypeCode="AF" id="P_MALE_PHOTO" packageId="<%=afId%>" name="P_MALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
											hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=AttConstants.AF_MALEPHOTO %>" diskStoreRuleParamValues="<%=strPar%>"/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
											<input onclick="error_onclick(this);"  style="width:200px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="" onchange="_chgBirthday(this,0,'MALE_BIRTHDAY','1')" id="tb_dqsy_cn_MALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" class="Wdate" value=""/>
                                        </td>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <div id="tb_dqsy_cn_MALE_AGE" style="font-size:14px">
                                            <script>											
											document.write(AGE);
                                            </script>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_dqsy_cn_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="210px">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>
                                        </td>
                                        <td class="edit-data-title">���պ���</td>
                                        <td class="edit-data-value">
											<input id="tb_dqsy_cn_MALE_PASSPORT_NO"  class="inputText" maxlength="50" type="text" onkeyup="_check_one(this);" onmouseout="_inputMouseOut(this);" onmousemove="_inputMouseOver(this);"onblur="_inputMouseBlur(this);error_onblur(this);hide(true);" onfocus="_inputMouseFocus(this);this.select();" onclick="error_onclick(this);" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')" value="" size="30" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ܽ����̶�</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="MALE_EDUCATION" formTitle="�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_dqsy_cn_MALE_EDUCATION" width="210px" onchange="_chgValue(this,0,'MALE_EDUCATION')">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>
                                        </td>
                                        <td class="edit-data-title">ְҵ</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_JOB_CN" type="String" formTitle="������ְҵ" defaultValue=""  id="tb_dqsy_cn_MALE_JOB_CN" size="30" onchange="_chgValue(this,-1,'MALE_JOB_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value">
                                            <BZ:select width="100px" field="MALE_HEALTH" formTitle="�����˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_dqsy_cn_MALE_HEALTH" onchange="_chgMaleHealth(this,0,'MALE_HEALTH')">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>                                            
                                        </td>
										<td class="edit-data-value" colspan="2">
											<textarea name="P_MALE_HEALTH_CONTENT_CN" id="tb_dqsy_cn_MALE_HEALTH_CONTENT_CN" maxlength="1000" style="display:none;width:90%" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_CN')"></textarea>
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_dqsy_cn_MALE_PUNISHMENT_FLAG0" value="0" onchange="_chgMALE_PUNISHMENT_FLAG(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                            <input type="radio" name="tb_dqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_dqsy_cn_MALE_PUNISHMENT_FLAG1" value="1" onchange="_chgMALE_PUNISHMENT_FLAG(this,-1,'MALE_PUNISHMENT_FLAG')">��
										</td>
										<td class="edit-data-value" colspan="3">
                                            <BZ:input field="MALE_PUNISHMENT_CN" id="tb_dqsy_cn_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_CN')"/>
                                        </td>
									</tr>
									<tr>
                                        <td class="edit-data-title">���޲����Ⱥ�</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_dqsy_cn_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgMALE_ILLEGALACT_FLAG(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                            <input type="radio" name="tb_dqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_dqsy_cn_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgMALE_ILLEGALACT_FLAG(this,-1,'MALE_ILLEGALACT_FLAG')">��
										</td>
										<td class="edit-data-value" colspan="3">
                                            <BZ:input field="MALE_ILLEGALACT_CN" id="tb_dqsy_cn_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value">
                                        <BZ:select field="MARRY_CONDITION" id="tb_dqsy_cn_MARRY_CONDITION" formTitle=""  defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" notnull="" width="210px" onchange="_chgValue(this,0,'MARRY_CONDITION')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                        </BZ:select>                                       
                                        </td>
                                        <td class="edit-data-title">ͬ�ӻ��</td>
                                        <td class="edit-data-value" colspan="2">
										    <input type="radio" name="tb_dqsy_cn_CONABITA_PARTNERS" id="tb_dqsy_cn_CONABITA_PARTNERS0" value="0" onchange="_chgRadio(this,-1,'CONABITA_PARTNERS')">��
                                            <input type="radio" name="tb_dqsy_cn_CONABITA_PARTNERS" id="tb_dqsy_cn_CONABITA_PARTNERS1" value="1" onchange="_chgRadio(this,-1,'CONABITA_PARTNERS')">��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">ͬ��ʱ��</td>
                                        <td class="edit-data-value">
                                            <BZ:input  field="CONABITA_PARTNERS_TIME" id="tb_dqsy_cn_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" onchange="_chgValue(this,0,'CONABITA_PARTNERS_TIME')"/>��
                                        </td>
                                        <td class="edit-data-title">��ͬ��������</td>
                                        <td class="edit-data-value" colspan="2">
										    <input type="radio" name="tb_dqsy_cn_GAY_STATEMENT" id="tb_dqsy_cn_GAY_STATEMENT0" value="0" onchange="_chgRadio(this,-1,'GAY_STATEMENT')">��
                                            <input type="radio" name="tb_dqsy_cn_GAY_STATEMENT" id="tb_dqsy_cn_GAY_STATEMENT1" value="1" onchange="_chgRadio(this,-1,'GAY_STATEMENT')">��
                                        </td>
                                    </tr>
                                    <tr>
                                        
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���ҵ�λ</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CURRENCY" id="tb_dqsy_cn_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  notnull="" width="210px" onchange="_chgValue(this,0,'CURRENCY')"></BZ:select>
                                        </td>
                                        <td class="edit-data-title">������</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_YEAR_INCOME" id="tb_dqsy_cn_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'MALE_YEAR_INCOME')" maxlength="22"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="TOTAL_ASSET" id="tb_dqsy_cn_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,0,'TOTAL_ASSET')"/>
                                        </td>
                                        <td class="edit-data-title">��ͥ��ծ��</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input  field="TOTAL_DEBT" id="tb_dqsy_cn_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,0,'TOTAL_DEBT')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value" colspan="4">
                                            <div id="tb_dqsy_cn_TOTAL_MANNY"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">18����������Ů����</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="UNDERAGE_NUM" id="tb_dqsy_cn_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'UNDERAGE_NUM')"/>��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��Ů���������</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="CHILD_CONDITION_CN" id="tb_dqsy_cn_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥסַ</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="ADDRESS" id="tb_dqsy_cn_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,0,'ADDRESS')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����Ҫ��</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="ADOPT_REQUEST_CN" id="tb_dqsy_cn_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_CN')"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table> 
                    <!--����������end-->
                </div>
                <!--��ͥ�������(��)��end-->
                <!--��ͥ�������(��)��start-->
                <div id="tab2">
					<!--�ļ�������Ϣ��start-->
					<table class="specialtable">
						<tr>
							<td class="edit-data-title" width="15%">������֯(CN)</td>
							<td class="edit-data-value" colspan="5">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������֯(EN)</td>
							<td class="edit-data-value" colspan="5">
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">�ļ�����</td>
							<td class="edit-data-value" width="18%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
							</td>
							<td class="edit-data-title" width="15%">��������</td>
							<td class="edit-data-value" width="18%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
							</td>
							<td class="edit-data-title" width="15%">���ı��</td>
							<td class="edit-data-value" width="18%">
								<BZ:dataValue field="FILE_NO" hrefTitle="���ı��" defaultValue="" />
							</td>
						</tr>
					</table>
					<!--�ļ�������Ϣ��end-->											 
					<!--����������start-->
					<table id="tb_dqsy_en" class="specialtable">
						<tr>	
							<td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
						</tr>
						<tr>
							<td>
								<!--��������Ϣ��start-->                            	  
								<table class="specialtable">                          	
									<tr>
										<td class="edit-data-title" width="15%">��������</td>
										<td class="edit-data-value" width="25%">
											<input id="tb_dqsy_en_MALE_NAME"  class="inputText" maxlength="150" type="text" onkeyup="_check_one(this);" onmouseout="_inputMouseOut(this);" onmousemove="_inputMouseOver(this);"onblur="_inputMouseBlur(this);error_onblur(this);hide(true);" onfocus="_inputMouseFocus(this);this.select();" onclick="error_onclick(this);" onchange="_chgValue(this,0,'MALE_NAME')" value="" size="30" />
										</td>
										<td class="edit-data-title" width="15%">�Ա�</td>
										<td class="edit-data-value" width="27%">
											<BZ:select field="ADOPTER_SEX" id="tb_dqsy_en_ADOPTER_SEX" formTitle="" defaultValue="2" notnull="" width="210px" onchange="_chgValue(this,1,'ADOPTER_SEX')">
												<BZ:option value="1">��</BZ:option>
												<BZ:option value="2">Ů</BZ:option>
											</BZ:select>					
										</td>
										<td class="edit-data-value" width="18%" rowspan="6">
											��Ƭ<br>(�������Ļ�����Ϣҳ�������Ƭ��ά��)
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��������</td>
										<td class="edit-data-value">
											<input onclick="error_onclick(this);"  style="width:200px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="" onchange="_chgBirthday(this,1,'MALE_BIRTHDAY','1')" id="tb_dqsy_en_MALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" class="Wdate" value=""/>
										</td>
										<td class="edit-data-title">����</td>
										<td class="edit-data-value">
											<div id="tb_dqsy_en_MALE_AGE" style="font-size:14px">
											<script>
											document.write(AGE);
											</script>
											</div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">����</td>
										<td class="edit-data-value">
											<BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_dqsy_en_MALE_NATION" onchange="_chgValue(this,1,'MALE_NATION')" width="210px">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-title">���պ���</td>
										<td class="edit-data-value">
											<input id="tb_dqsy_en_MALE_PASSPORT_NO"  class="inputText" maxlength="50" type="text" onkeyup="_check_one(this);" onmouseout="_inputMouseOut(this);" onmousemove="_inputMouseOver(this);"onblur="_inputMouseBlur(this);error_onblur(this);hide(true);" onfocus="_inputMouseFocus(this);this.select();" onclick="error_onclick(this);" onchange="_chgValue(this,1,'MALE_PASSPORT_NO')" value="" size="30" />
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">�ܽ����̶�</td>
										<td class="edit-data-value">
											<BZ:select field="MALE_EDUCATION" formTitle="�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_dqsy_en_MALE_EDUCATION" width="210px" onchange="_chgValue(this,1,'MALE_EDUCATION')">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-title">ְҵ</td>
										<td class="edit-data-value">
											<BZ:input field="MALE_JOB_EN" type="String" formTitle="������ְҵ" defaultValue=""  id="tb_dqsy_en_MALE_JOB_EN" onchange="_chgValue(this,-1,'MALE_JOB_EN')" style="width:210px"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">����״��</td>
										<td class="edit-data-value" colspan="3">
											<BZ:select width="100px" field="MALE_HEALTH" formTitle="�����˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_dqsy_en_MALE_HEALTH" onchange="_chgMaleHealth(this,1,'MALE_HEALTH')">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>					
											<textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_EN" id="tb_dqsy_en_MALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_EN')"></textarea>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">���</td>
										<td class="edit-data-value">
											<BZ:select field="MEASUREMENT" id="tb_dqsy_en_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_setMeasurement(this,1,'MEASUREMENT')">
												<BZ:option value="0">����</BZ:option>
												<BZ:option value="1">Ӣ��</BZ:option>
											</BZ:select>
											<span id="tb_dqsy_en_MALE_HEIGHT_INCH" style="display: none">
												<BZ:input field="MALE_FEET" id="tb_dqsy_en_MALE_FEET" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:10%" onchange="_chgHeight(this,1,'MALE_FEET','1')"/>Ӣ��
												<BZ:input field="MALE_INCH" id="tb_dqsy_en_MALE_INCH" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:10%" onchange="_chgHeight(this,1,'MALE_INCH','1')"/>Ӣ��
											</span>
											<span id="tb_dqsy_en_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_dqsy_en_MALE_HEIGHT" formTitle="" defaultValue="" restriction="number" maxlength="" size="10" onchange="_chgHeight(this,1,'MALE_HEIGHT','1')"/>����</span>
										</td>
										<td class="edit-data-title">����</td>
										<td class="edit-data-value">
											<BZ:input field="MALE_WEIGHT" id="tb_dqsy_en_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setMaleBMI()" size="10" onchange="_chgWeight(this,1,'MALE_WEIGHT','1')" maxlength="50"/><span id="tb_dqsy_en_MALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_dqsy_en_MALE_WEIGHT_KILOGRAM">ǧ��</span>
										</td>
									</tr>                                    
									<tr>
										<td class="edit-data-title">����ָ��</td>
										<td class="edit-data-value" colspan="4">
											<div id="tb_dqsy_en_MALE_BMI" style="font-size:14px">&nbsp;</div>
										</td>
									</tr>
									<tr>
									<tr>
										<td class="edit-data-title">Υ����Ϊ�����´���</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_dqsy_en_MALE_PUNISHMENT_FLAG" id="tb_dqsy_en_MALE_PUNISHMENT_FLAG0" value="0" onchange="_chgMALE_PUNISHMENT_FLAG(this,-1,'MALE_PUNISHMENT_FLAG')">��
											<input type="radio" name="tb_dqsy_en_MALE_PUNISHMENT_FLAG" id="tb_dqsy_en_MALE_PUNISHMENT_FLAG1" value="1" onchange="_chgMALE_PUNISHMENT_FLAG(this,-1,'MALE_PUNISHMENT_FLAG')">��
										</td>
										<td class="edit-data-value" colspan="3">
											<BZ:input field="MALE_PUNISHMENT_EN" id="tb_dqsy_en_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">���޲����Ⱥ�</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_dqsy_en_MALE_ILLEGALACT_FLAG" id="tb_dqsy_en_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgMALE_ILLEGALACT_FLAG(this,-1,'MALE_ILLEGALACT_FLAG')">��
											<input type="radio" name="tb_dqsy_en_MALE_ILLEGALACT_FLAG" id="tb_dqsy_en_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgMALE_ILLEGALACT_FLAG(this,-1,'MALE_ILLEGALACT_FLAG')">��
										</td>
										<td class="edit-data-value" colspan="3">
											<BZ:input field="MALE_ILLEGALACT_EN" id="tb_dqsy_en_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">�ڽ�����</td>
										<td class="edit-data-value">
											<BZ:input field="MALE_RELIGION_EN" id="tb_dqsy_en_MALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500" size="30" onchange="_chgValue(this,-1,'MALE_RELIGION_EN')"/>
										</td>
										<td class="edit-data-title">����״��</td>
										<td class="edit-data-value" colspan="2">
										<BZ:select field="MARRY_CONDITION" id="tb_dqsy_en_MARRY_CONDITION" formTitle=""  defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" notnull="" width="210px" onchange="_chgValue(this,1,'MARRY_CONDITION')">
												<BZ:option value="">--��ѡ��--</BZ:option>
										</BZ:select>                                       
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">ͬ�ӻ��</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_dqsy_en_CONABITA_PARTNERS" id="tb_dqsy_en_CONABITA_PARTNERS0" value="0" onchange="_chgRadio(this,1,'CONABITA_PARTNERS')">��
											<input type="radio" name="tb_dqsy_en_CONABITA_PARTNERS" id="tb_dqsy_en_CONABITA_PARTNERS1" value="1" onchange="_chgRadio(this,1,'CONABITA_PARTNERS')">��
										</td>
										<td class="edit-data-title">ͬ��ʱ��</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input  field="CONABITA_PARTNERS_TIME" id="tb_dqsy_en_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" onchange="_chgValue(this,1,'CONABITA_PARTNERS_TIME')"/>��
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ͬ��������</td>
										<td class="edit-data-value" colspan="4">
											<input type="radio" name="tb_dqsy_en_GAY_STATEMENT" id="tb_dqsy_en_GAY_STATEMENT0" value="0" onchange="_chgRadio(this,1,'GAY_STATEMENT')">��
											<input type="radio" name="tb_dqsy_en_GAY_STATEMENT" id="tb_dqsy_en_GAY_STATEMENT1" value="1" onchange="_chgRadio(this,1,'GAY_STATEMENT')">��
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">���ҵ�λ</td>
										<td class="edit-data-value">
											<BZ:select field="CURRENCY" id="tb_dqsy_en_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  notnull="" width="210px" onchange="_chgValue(this,1,'CURRENCY')"></BZ:select>
										</td>
										<td class="edit-data-title">������</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_YEAR_INCOME" id="tb_dqsy_en_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'MALE_YEAR_INCOME')" maxlength="22"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ͥ���ʲ�</td>
										<td class="edit-data-value">
											<BZ:input field="TOTAL_ASSET" id="tb_dqsy_en_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,1,'TOTAL_ASSET')"/>
										</td>
										<td class="edit-data-title">��ͥ��ծ��</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input  field="TOTAL_DEBT" id="tb_dqsy_en_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,1,'TOTAL_DEBT')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ͥ���ʲ�</td>
										<td class="edit-data-value" colspan="4">
											<div id="tb_dqsy_en_TOTAL_MANNY"></div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">18����������Ů����</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="UNDERAGE_NUM" id="tb_dqsy_en_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'UNDERAGE_NUM')"/>��
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��Ů���������</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="CHILD_CONDITION_EN" id="tb_dqsy_en_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ͥסַ</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="ADDRESS" id="tb_dqsy_en_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,1,'ADDRESS')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">����Ҫ��</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="ADOPT_REQUEST_EN" id="tb_dqsy_en_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_EN')"/>
										</td>
									</tr>
								</table>
                                        </td>
                                    </tr>
                                </table>
                                <!--����������end-->                                
                            </td>
                        </tr>
					</table>     	
                </div>
                <!--��ͥ�������(��)��end-->                                
			</div>
		</div>
		<!--������Ϣ��start-->
		<div id="tab-translation">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="edit-data-title" colspan="2" style="text-align:center"><b>������Ϣ</b></td>
                </tr>
                <tr>
					<td  class="edit-data-title" width="15%">����˵��</td>
					<td  class="edit-data-value">
					<BZ:input prefix="R_" field="TRANSLATION_DESC" id="R_TRANSLATION_DESC" type="textarea" formTitle="����˵��" defaultValue="" maxlength="500" style="width:80%"/>
					</td>
				</tr>
			</table>
		</div>
		<!--������Ϣ��end-->
		<br>
		<!-- ��ť����:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����:end -->
	</BZ:form>
	</BZ:body>
</BZ:html>
