<%
/**   
 * @Title: ffs_af_singleparent_translation.jsp
 * @Description:  �ļ�����ҳ������Ů������
 * @author wangz   
 * @date 2014-8-11 ����10:00:00 
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	String uploadParameter = (String)request.getAttribute("uploadParameter");
	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
	
	String ADOPTER_SEX = d.getString("ADOPTER_SEX");
	String smallType =AttConstants.AF_MALEPHOTO;
	if("2".equals(ADOPTER_SEX)){
		smallType =AttConstants.AF_FEMALEPHOTO;
	}
%>
<BZ:html>
<BZ:head>
	<up:uploadResource isImage="true"/>
    <title>�ļ�����ҳ������Ů������</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		var path = "<%=path%>";
		var formType = "jzn";
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// �������Ա�
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
		
		var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//������λ
		var male_height	 = "<BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>";		//�����������
		var female_height = "<BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>";	//Ů���������
		var male_weight = "<BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>";		//������������
		var female_weight = "<BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>";	//Ů����������
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
		var MALE_RELIGION_CN = "<BZ:dataValue type="String" field="MALE_RELIGION_CN" defaultValue="" onlyValue="true"/>";	//�ڽ�����
		var MALE_RELIGION_EN = "<BZ:dataValue type="String" field="MALE_RELIGION_EN" defaultValue="" onlyValue="true"/>";	//�ڽ�����
		var FEMALE_RELIGION_CN = "<BZ:dataValue type="String" field="FEMALE_RELIGION_CN" defaultValue="" onlyValue="true"/>";	//�ڽ�����
		var FEMALE_RELIGION_EN = "<BZ:dataValue type="String" field="FEMALE_RELIGION_EN" defaultValue="" onlyValue="true"/>";	//�ڽ�����

		var MARRY_DATE = "<BZ:dataValue type="String" field="MARRY_DATE" defaultValue="" onlyValue="true"/>";			//�������
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//��ͥ���ʲ�
		var TOTAL_DEBT = '<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>';			//��ͥ��ծ��
		
		var IS_FORMULATE = "<BZ:dataValue type="String" field="IS_FORMULATE" defaultValue="0" onlyValue="true"/>";		//����ָ���໤��
		var IS_ABUSE_ABANDON = "<BZ:dataValue type="String" field="IS_ABUSE_ABANDON" defaultValue="0" onlyValue="true"/>";		//��������Ű������
		var IS_MEDICALRECOVERY = "<BZ:dataValue type="String" field="IS_MEDICALRECOVERY" defaultValue="0" onlyValue="true"/>";	//�����ƻ�
		var ADOPT_PREPARE = "<BZ:dataValue type="String" field="ADOPT_PREPARE" defaultValue="0" onlyValue="true"/>";	//����ǰ׼��
		var RISK_AWARENESS = "<BZ:dataValue type="String" field="RISK_AWARENESS" defaultValue="0" onlyValue="true"/>";	//������ʶ
		var IS_SUBMIT_REPORT = "<BZ:dataValue type="String" field="IS_SUBMIT_REPORT" defaultValue="0" onlyValue="true"/>";//ͬ��ݽ����ú󱨸�����
		var IS_FAMILY_OTHERS_FLAG = "<BZ:dataValue type="String" field="IS_FAMILY_OTHERS_FLAG" defaultValue="0" onlyValue="true"/>";//��������������ͬס
		var PARENTING = "<BZ:dataValue type="String" field="PARENTING" defaultValue="0" onlyValue="true"/>";			// ��������
		
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//��Ч����
		var VALID_PERIOD_TYPE = "1";
		//�����Ч����Ϊ-1����ת��Ϊ2
		if(VALID_PERIOD=="-1"){
			VALID_PERIOD_TYPE="2";
		}
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
						{"name":"HEALTH_CONTENT_EN","MALE":MALE_HEALTH_CONTENT_EN,"FEMALE":FEMALE_HEALTH_CONTENT_EN,"syn":"0","type":"text","pre":"en"},
						{"name":"RELIGION_CN","MALE":MALE_RELIGION_CN,"FEMALE":FEMALE_RELIGION_CN,"syn":"0","type":"text","pre":"cn"},
						{"name":"RELIGION_EN","MALE":MALE_RELIGION_EN,"FEMALE":FEMALE_RELIGION_EN,"syn":"0","type":"text","pre":"en"}
						];
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		    $('#tab-container').easytabs();
			_initData();
			//������Ч����
			_initValidPeriod(VALID_PERIOD_TYPE);
		})

	function _initData(){
		$.each(objField,function(n,value) {

			var obj1 = "#tb_"+formType+"_cn_MALE_" + value.name;
			var obj2 = "#tb_"+formType+"_en_MALE_" + value.name;
			if("0"==value.syn){
				obj1 = "#tb_"+formType+"_"+value.pre+"_MALE_" + value.name;
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

	/*
	* ���������޸�
	* o������
	* p����ǩҳ
	* n����������
	* s���Ա�
	*/
	function _chgBirthday(o,p,n,s){
		if(s=="1"){		
			document.getElementById("tb_jzn_cn_MALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_jzn_en_MALE_AGE").innerHTML = getAge(o.value);
		}else if(s=="2"){
			document.getElementById("tb_jzn_cn_FEMALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_jzn_en_FEMALE_AGE").innerHTML = getAge(o.value)
		}
		_chgValue(o,p,n);
	}
	/*
	* ���ý��ʱ��
	* d���������
	*/
	function _setMarryLength(d){
		$("#tb_jzn_cn_MARRY_LENGTH").text(getAge(d));
		$("#tb_jzn_en_MARRY_LENGTH").text(getAge(d));
	}
	
	//�����������Ա�
	function _chgAdopterSex(o,p,n){
		ADOPTER_SEX = o.value;
		_chgValue(o,p,n);
	}
	/*
	* ������Ч��������
	* v
	* 1:��Ч����
	* 2:����
	*/
	
	function _setValidPeriod(o,p,n){		
		if(o.value=="2"){			
			$("#tb_jzn_cn_VALID_PERIOD0").hide();
			$("#tb_jzn_en_VALID_PERIOD0").hide();
			$("#P_VALID_PERIOD").val("-1");
		}else{			
			$("#tb_jzn_cn_VALID_PERIOD0").show();
			$("#tb_jzn_en_VALID_PERIOD0").show();
			$("#tb_jzn_cn_VALID_PERIOD").val("");
			$("#tb_jzn_en_VALID_PERIOD").val("");
		}
		_chgValue(o,p,n);
	}
	function _initValidPeriod(v){
		if(v=="2"){
			$("#tb_jzn_cn_VALID_PERIOD_TYPE").val("2");
			$("#tb_jzn_en_VALID_PERIOD_TYPE").val("2");
			$("#tb_jzn_cn_VALID_PERIOD0").hide();
			$("#tb_jzn_en_VALID_PERIOD0").hide();

		}else{
			$("#tb_jzn_cn_VALID_PERIOD_TYPE").val("1");
			$("#tb_jzn_en_VALID_PERIOD_TYPE").val("1");
			$("#tb_jzn_cn_VALID_PERIOD0").show();
			$("#tb_jzn_en_VALID_PERIOD0").show();
		}
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
		
		//����ǵ������������Ů�������жϺ������Ա�����Ů���ڶ���ǰ��ǰ׺"FE"���������������Ӧ�ֶ�
		if(formType == "dqsy" || formType == "jzn"){
			if("2" == ADOPTER_SEX){
				if(n.substr(0,4)=="MALE"){
					n = "FE" + n;
				}
			}
		}
		var _id2 = "P_" + n;
		//alert(_id2+":"+ret);
		document.getElementById(_id2).value = ret;
	}
	
	function _getP(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_jzn_en_";		
			break;
		case 1:
			p1 = "tb_jzn_cn_";
			break;	
		}
		return p1;
	}
	
	function _getP1(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_jzn_cn_";		
			break;
		case 1:
			p1 = "tb_jzn_en_";
			break;	
		}
		return p1;
	}

		//���뱣��
	function _save() {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/ffs/ffsaftranslation/save.action";
		document.srcForm.submit();
	}
	//��������ύ
	function _submit() {
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/ffs/ffsaftranslation/save.action";
		document.srcForm.submit();
	 
	}
	//�����б�
	function _goback(){
		var url = '<BZ:dataValue field="TRANSLATION_TYPE" onlyValue="true" checkValue="0=findList;1=adTranslationList;2=reTranslationList"/>';
		document.srcForm.action = path + "/ffs/ffsaftranslation/"+url+".action";
		document.srcForm.submit();
	}

	//���������ϴ�ʹ��
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
	function _toipload(fn,obj){
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

		var y = obj.offsetTop;
		var ch = document.body.clientHeight;
		while(obj=obj.offsetParent) 
		{ 
			y   +=   obj.offsetTop;			
		}

		if((ch-y)<300){
			y = y - (ch-y); 
		}
		document.uploadForm.PACKAGE_ID.value = packageId;
		document.uploadForm.IS_EN.value = isEn;
		document.uploadForm.action="<%=path%>/uploadManager";
		popWin.showWinIframe("1000","600","fileframe","��������","iframe","#");
		document.uploadForm.submit();
	}
	
	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
        <BZ:input type="hidden" prefix="P_" field="AF_ID" id="P_AF_ID" defaultValue=""/> 
		<BZ:input type="hidden" prefix="R_" field="AT_ID" id="R_AT_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"	id="R_TRANSLATION_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="TRANSLATION_TYPE" 	id="TRANSLATION_TYPE" defaultValue=""/>

        <BZ:input type="hidden" prefix="P_" field="MALE_NAME" id="P_MALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" defaultValue=""/> 
        <!--todo-->
        <BZ:input type="hidden" prefix="P_" field="MALE_PHOTO" id="P_MALE_PHOTO" defaultValue=""/> 
        <!--todo-->        
        <BZ:input type="hidden" prefix="P_" field="MALE_NATION" id="P_MALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PASSPORT_NO" id="P_MALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_EDUCATION" id="P_MALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_JOB_CN" id="P_MALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_JOB_EN" id="P_MALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH" id="P_MALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH_CONTENT_CN" id="P_MALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH_CONTENT_EN" id="P_MALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEASUREMENT" id="P_MEASUREMENT" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEIGHT" id="P_MALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_WEIGHT" id="P_MALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_BMI" id="P_MALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_FLAG" id="P_MALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_CN" id="P_MALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_EN" id="P_MALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_FLAG" id="P_MALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_CN" id="P_MALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_EN" id="P_MALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_RELIGION_CN" id="P_MALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_RELIGION_EN" id="P_MALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_MARRY_TIMES" id="P_MALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_YEAR_INCOME" id="P_MALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_NAME" id="P_FEMALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PHOTO" id="P_FEMALE_PHOTO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_NATION" id="P_FEMALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PASSPORT_NO" id="P_FEMALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_EDUCATION" id="P_FEMALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_JOB_CN" id="P_FEMALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_JOB_EN" id="P_FEMALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH" id="P_FEMALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH_CONTENT_CN" id="P_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH_CONTENT_EN" id="P_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEIGHT" id="P_FEMALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_WEIGHT" id="P_FEMALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_BMI" id="P_FEMALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_FLAG" id="P_FEMALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_CN" id="P_FEMALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_EN" id="P_FEMALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_FLAG" id="P_FEMALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_CN" id="P_FEMALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_EN" id="P_FEMALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_RELIGION_CN" id="P_FEMALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_RELIGION_EN" id="P_FEMALE_RELIGION_EN" defaultValue=""/> 
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
        <BZ:input type="hidden" prefix="P_" field="FINISH_DATE" id="P_FINISH_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="HOMESTUDY_ORG_NAME" id="P_HOMESTUDY_ORG_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="RECOMMENDATION_NUM" id="P_RECOMMENDATION_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="HEART_REPORT" id="P_HEART_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_MEDICALRECOVERY" id="P_IS_MEDICALRECOVERY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEDICALRECOVERY_CN" id="P_MEDICALRECOVERY_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEDICALRECOVERY_EN" id="P_MEDICALRECOVERY_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FORMULATE" id="P_IS_FORMULATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_PREPARE" id="P_ADOPT_PREPARE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="RISK_AWARENESS" id="P_RISK_AWARENESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_ABUSE_ABANDON" id="P_IS_ABUSE_ABANDON" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_SUBMIT_REPORT" id="P_IS_SUBMIT_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_FLAG" id="P_IS_FAMILY_OTHERS_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_CN" id="P_IS_FAMILY_OTHERS_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_EN" id="P_IS_FAMILY_OTHERS_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_MOTIVATION" id="P_ADOPT_MOTIVATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_ABOVE" id="P_CHILDREN_ABOVE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="INTERVIEW_TIMES" id="P_INTERVIEW_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ACCEPTED_CARD" id="P_ACCEPTED_CARD" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="PARENTING" id="P_PARENTING" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SOCIALWORKER" id="P_SOCIALWORKER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="REMARK_CN" id="P_REMARK_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="REMARK_EN"			id="P_REMARK_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="GOVERN_DATE"			id="P_GOVERN_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="VALID_PERIOD"		id="P_VALID_PERIOD" defaultValue="-1"/>
        <BZ:input type="hidden" prefix="P_" field="APPROVE_CHILD_NUM"	id="P_APPROVE_CHILD_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="AGE_FLOOR" 			id="P_AGE_FLOOR" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="AGE_UPPER" 			id="P_AGE_UPPER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_SEX" 		id="P_CHILDREN_SEX" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_HEALTH_CN" 	id="P_CHILDREN_HEALTH_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_HEALTH_EN" 	id="P_CHILDREN_HEALTH_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="PACKAGE_ID" 			id="P_PACKAGE_ID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CREATE_USERID" 		id="P_CREATE_USERID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CREATE_DATE" 		id="P_CREATE_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SUBMIT_USERID" 		id="P_SUBMIT_USERID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SUBMIT_DATE" 		id="P_SUBMIT_DATE" defaultValue=""/> 
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
                <li class='tab'><a href="#tab1">������Ϣ(����)</a></li>
                <li class='tab'><a href="#tab2">������Ϣ(����)</a></li>
            </ul>
			<div class='panel-container'>
            	<!--��ͥ�������(��)��start-->
            	<div id="tab1">
                	<!--�ļ�������Ϣ��start-->
                    <table class="specialtable">
                        <tr>
                            <td class="edit-data-title" width="15%">������֯(CN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">������֯(EN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
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
                    <table id="tb_jzn_cn" class="specialtable">
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
                                        	<% if("1".equals(ADOPTER_SEX)) {%>
                                        	<BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
                                        	<%}else{ %>
                                        	<BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
                                        	<%} %>
                                        </td>
                                        <td class="edit-data-title" width="15%">�Ա�</td>
                                        <td class="edit-data-value" width="26%">
                                            <% if("1".equals(ADOPTER_SEX)) {%>
                                        	��
                                        	<%}else{ %>
                                        	Ů
                                        	<%} %>					
                                        </td>
                                        <td class="edit-data-value" width="18%" rowspan="4">
                                            <up:uploadImage attTypeCode="AF" id="P_MALE_PHOTO" packageId="<%=afId%>" name="P_MALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
											hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=smallType %>" diskStoreRuleParamValues="<%=strPar%>"/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                        	<% if("1".equals(ADOPTER_SEX)) {%>
                                        	<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
                                        	<%}else{ %>
                                        	<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
                                        	<%} %> 
                                        </td>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <div id="tb_jzn_cn_MALE_AGE" style="font-size:14px">
                                            <script>
                                            document.write(getAge($("#tb_jzn_cn_MALE_BIRTHDAY").val()));
                                            </script>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_jzn_cn_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="210px">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>
                                        </td>
                                        <td class="edit-data-title">���պ���</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_PASSPORT_NO" id="tb_jzn_cn_MALE_PASSPORT_NO" type="String" formTitle="�����˻��պ���" defaultValue="" size="30" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')"/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value">�ѻ�</td>
                                        <td class="edit-data-title">�������</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MARRY_DATE" id="tb_jzn_cn_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgValue(this,0,'MARRY_DATE')"/>
                                        </td>
                                    </tr>
								    <tr>
                                        <td class="edit-data-title" colspan="5" style="text-align:center"><b>������׼��Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��׼����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="GOVERN_DATE" id="tb_jzn_cn_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
                                        </td>
                                         <td class="edit-data-title">��Ч����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="VALID_PERIOD_TYPE" id="tb_jzn_cn_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_setValidPeriod(this,0,'VALID_PERIOD_TYPE')">
                                                <BZ:option value="1">��Ч����</BZ:option>
                                                <BZ:option value="2">����</BZ:option>
                                            </BZ:select>
											<span id="tb_jzn_cn_VALID_PERIOD0" style="display: none">
                                            <BZ:input field="VALID_PERIOD" id="tb_jzn_cn_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>��
											</span>
                                        </td>                                     
                                    </tr> 
									<tr>
										<td class="edit-data-title" colspan="1" style="text-align:center"></td>
										<td class="edit-data-title" colspan="3" style="text-align:center">
										<b>������Ϣ</b></td>
										<td class="edit-data-title" colspan="1" style="text-align:center">
										<input type="button" value="�����ϴ�" onclick="_toipload('0',this)" />
										</td>
                                    </tr>
									<tr>
										<td colspan="5">
										<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
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
                                <BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">������֯(EN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
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
                    <table id="tb_jzn_cn" class="specialtable">
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
                                            <% if("1".equals(ADOPTER_SEX)) {%>
                                        	<BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
                                        	<%}else{ %>
                                        	<BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
                                        	<%} %>
                                        </td>
                                        <td class="edit-data-title" width="15%">�Ա�</td>
                                        <td class="edit-data-value" width="26%">
                                            <% if("1".equals(ADOPTER_SEX)) {%>
                                        	��
                                        	<%}else{ %>
                                        	Ů
                                        	<%} %>					
                                        </td>
                                        <td class="edit-data-value" width="18%" rowspan="4">
                                            ��Ƭ<br>(�������Ļ�����Ϣҳ�������Ƭ��ά��)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                        	<% if("1".equals(ADOPTER_SEX)) {%>
                                        	<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
                                        	<%}else{ %>
                                        	<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
                                        	<%} %> 
                                        </td>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <div id="tb_jzn_en_MALE_AGE" style="font-size:14px">
                                            <script>
                                            document.write(getAge($("#tb_jzn_en_MALE_BIRTHDAY").val()));
                                            </script>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_jzn_en_MALE_NATION" onchange="_chgValue(this,1,'MALE_NATION')" width="210px">
											<BZ:option value="">--��ѡ��--</BZ:option>
											</BZ:select>
                                        </td>
                                        <td class="edit-data-title">���պ���</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_PASSPORT_NO" id="tb_jzn_en_MALE_PASSPORT_NO" type="String" formTitle="�����˻��պ���" defaultValue="" size="30" onchange="_chgValue(this,1,'MALE_PASSPORT_NO')"/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value">�ѻ�</td>
                                        <td class="edit-data-title">�������</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MARRY_DATE" id="tb_jzn_en_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgValue(this,1,'MARRY_DATE')"/>
                                        </td>
                                    </tr>
								    <tr>
                                        <td class="edit-data-title" colspan="5" style="text-align:center"><b>������׼��Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��׼����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="GOVERN_DATE" id="tb_jzn_en_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,1,'GOVERN_DATE')"/>
                                        </td>
                                        <td class="edit-data-title">��Ч����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="VALID_PERIOD_TYPE" id="tb_jzn_en_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_setValidPeriod(this,1,'VALID_PERIOD_TYPE')">
                                                <BZ:option value="1">��Ч����</BZ:option>
                                                <BZ:option value="2">����</BZ:option>
                                            </BZ:select>
											<span id="tb_jzn_en_VALID_PERIOD0" style="display: none">
                                            <BZ:input field="VALID_PERIOD" id="tb_jzn_en_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,1,'VALID_PERIOD')"/>��
											</span>
                                        </td>                                       
                                    </tr>
									<tr>
										<td class="edit-data-title" colspan="1" style="text-align:center"></td>
										<td class="edit-data-title" colspan="3" style="text-align:center">
										<b>������Ϣ</b></td>
										<td class="edit-data-title" colspan="1" style="text-align:center">
										<input type="button" value="�����ϴ�" onclick="_toipload('1',this)" />
										</td>
                                    </tr>
									<tr>
										<td colspan="5">
										<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table> 
                    <!--����������end-->  	
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
	<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--����ʹ�ã�start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=uploadParameter%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='org_id=<BZ:dataValue field="ADOPT_ORG_ID" onlyValue="true"/>,af_id=<BZ:dataValue field="AF_ID" onlyValue="true"/>'/>
		
		<!--����ʹ�ã�end-->
	</form>
	</BZ:body>
</BZ:html>
