<%
/**   
 * @Title: singleparent_cn_edit.jsp
 * @Description:  ��������������-�༭
 * @author wangz   
 * @date 2014-10-29
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
	String strPar1 = "org_id="+orgId + ",af_id=" + afId;
	String ADOPTER_SEX = d.getString("ADOPTER_SEX");
	String smallType =AttConstants.AF_MALEPHOTO;
	if("2".equals(ADOPTER_SEX)){
		smallType =AttConstants.AF_FEMALEPHOTO;
	}
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
		var path = "<%=path%>";
		var formType = "dqsy";
		var arrayFields = new Array('NAME','BIRTHDAY','PHOTO','NATION','PASSPORT_NO','EDUCATION','JOB_CN','JOB_EN','HEALTH','HEALTH_CONTENT_CN','HEALTH_CONTENT_EN','HEIGHT','WEIGHT','BMI','PUNISHMENT_FLAG','PUNISHMENT_CN','PUNISHMENT_EN','ILLEGALACT_FLAG','ILLEGALACT_CN','ILLEGALACT_EN','RELIGION_CN','RELIGION_EN','MARRY_TIMES','YEAR_INCOME');

		var FAMILY_TYPE = "<BZ:dataValue type="String" field="FAMILY_TYPE" defaultValue="1" onlyValue="true"/>";		//��������
		var FILE_TYPE = "<BZ:dataValue type="String" field="FILE_TYPE" defaultValue="1" onlyValue="true"/>";			//�ļ�����	
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// �������Ա�
		
		var	MALE_NAME			= "<BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>";	var	MALE_BIRTHDAY		= "<BZ:dataValue type="String" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>";
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
		
		//var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//������λ
		var measurement = "0";//���ü�����λΪ����
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
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";			//��ͥ��ծ��
		
		var IS_FORMULATE = "<BZ:dataValue type="String" field="IS_FORMULATE" defaultValue="0" onlyValue="true"/>";		//����ָ���໤��
		var IS_ABUSE_ABANDON = "<BZ:dataValue type="String" field="IS_ABUSE_ABANDON" defaultValue="0" onlyValue="true"/>";		//��������Ű������
		var IS_MEDICALRECOVERY = "<BZ:dataValue type="String" field="IS_MEDICALRECOVERY" defaultValue="0" onlyValue="true"/>";	//�����ƻ�
		var ADOPT_PREPARE = "<BZ:dataValue type="String" field="ADOPT_PREPARE" defaultValue="0" onlyValue="true"/>";	//����ǰ׼��
		var RISK_AWARENESS = "<BZ:dataValue type="String" field="RISK_AWARENESS" defaultValue="0" onlyValue="true"/>";	//������ʶ
		var IS_SUBMIT_REPORT = "<BZ:dataValue type="String" field="IS_SUBMIT_REPORT" defaultValue="0" onlyValue="true"/>";//ͬ��ݽ����ú󱨸�����
		var IS_FAMILY_OTHERS_FLAG = "<BZ:dataValue type="String" field="IS_FAMILY_OTHERS_FLAG" defaultValue="0" onlyValue="true"/>";//��������������ͬס
		var PARENTING = "<BZ:dataValue type="String" field="PARENTING" defaultValue="0" onlyValue="true"/>";			// ��������
		var CONABITA_PARTNERS = "<BZ:dataValue type="String" field="CONABITA_PARTNERS" defaultValue="0" onlyValue="true"/>";//ͬ�ӻ��
		var GAY_STATEMENT =  "<BZ:dataValue type="String" field="GAY_STATEMENT" defaultValue="0" onlyValue="true"/>";//��ͬ��������
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//��Ч����
		//�����Ч����Ϊ-1����ת��Ϊ2
		if(VALID_PERIOD=="-1"){
			VALID_PERIOD="2";
		}
		var HOMESTUDY_ORG = "<BZ:dataValue type="String" field="HOMESTUDY_ORG" defaultValue="" onlyValue="true"/>";	//�ҵ������֯
		
		var objField = [{"name":"NAME","MALE":MALE_NAME,"FEMALE":FEMALE_NAME,"syn":"1","type":"text","pre":""},
						{"name":"BIRTHDAY","MALE":MALE_BIRTHDAY,"FEMALE":FEMALE_BIRTHDAY,"syn":"1","type":"text","pre":""},
						{"name":"PHOTO","MALE":MALE_PHOTO,"FEMALE":FEMALE_PHOTO,"syn":"1","type":"photo","pre":""},
						{"name":"NATION","MALE":MALE_NATION,"FEMALE":FEMALE_NATION,"syn":"1","type":"select","pre":""},
						{"name":"PASSPORT_NO","MALE":MALE_PASSPORT_NO,"FEMALE":FEMALE_PASSPORT_NO,"syn":"1","type":"text","pre":""},
						{"name":"EDUCATION","MALE":MALE_EDUCATION,"FEMALE":FEMALE_EDUCATION,"syn":"1","type":"select","pre":""},
						{"name":"JOB_CN","MALE":MALE_JOB_CN,"FEMALE":FEMALE_JOB_CN,"syn":"0","type":"text","pre":"cn"},
						//{"name":"JOB_EN","MALE":MALE_JOB_EN,"FEMALE":FEMALE_JOB_EN,"syn":"0","type":"text","pre":"en"},
						{"name":"MARRY_TIMES","MALE":MALE_MARRY_TIMES,"FEMALE":FEMALE_MARRY_TIMES,"syn":"1","type":"text","pre":""},
						{"name":"YEAR_INCOME","MALE":MALE_YEAR_INCOME,"FEMALE":FEMALE_YEAR_INCOME,"syn":"1","type":"text","pre":""},
						{"name":"HEALTH","MALE":male_health,"FEMALE":female_health,"syn":"1","type":"select","pre":""},
						{"name":"HEALTH_CONTENT_CN","MALE":MALE_HEALTH_CONTENT_CN,"FEMALE":FEMALE_HEALTH_CONTENT_CN,"syn":"0","type":"text","pre":"cn"},
						//{"name":"HEALTH_CONTENT_EN","MALE":MALE_HEALTH_CONTENT_EN,"FEMALE":FEMALE_HEALTH_CONTENT_EN,"syn":"0","type":"text","pre":"en"},
						{"name":"RELIGION_CN","MALE":MALE_RELIGION_CN,"FEMALE":FEMALE_RELIGION_CN,"syn":"0","type":"text","pre":"cn"},
						//{"name":"RELIGION_EN","MALE":MALE_RELIGION_EN,"FEMALE":FEMALE_RELIGION_EN,"syn":"0","type":"text","pre":"en"}
						];

		male_health = ("2"==ADOPTER_SEX)?female_health:male_health;		
		height = ("2"==ADOPTER_SEX)?female_height:male_height;
		weight = ("2"==ADOPTER_SEX)?female_weight:male_weight;
		
		MALE_PUNISHMENT_FLAG = ("2"==ADOPTER_SEX)?FEMALE_PUNISHMENT_FLAG:MALE_PUNISHMENT_FLAG;
		MALE_PUNISHMENT_CN = ("2"==ADOPTER_SEX)?FEMALE_PUNISHMENT_CN:MALE_PUNISHMENT_CN;
		MALE_PUNISHMENT_EN = ("2"==ADOPTER_SEX)?FEMALE_PUNISHMENT_EN:MALE_PUNISHMENT_EN;
		MALE_ILLEGALACT_FLAG = ("2"==ADOPTER_SEX)?FEMALE_ILLEGALACT_FLAG:MALE_ILLEGALACT_FLAG;
		MALE_ILLEGALACT_CN = ("2"==ADOPTER_SEX)?FEMALE_ILLEGALACT_CN:MALE_ILLEGALACT_CN;
		MALE_ILLEGALACT_EN = ("2"==ADOPTER_SEX)?FEMALE_ILLEGALACT_EN:MALE_ILLEGALACT_EN;
		
		$(document).ready( function() {
			//����iframe
			dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			_initData();

			//��ʼ������״��˵������ʾ������
			_setMale_health(male_health);			
			//������ߡ����ص���ʾ��ʽ�����ơ�Ӣ�ƣ�
			_setMeasurement(measurement);			
			//����BMI
			_setBMI(ADOPTER_SEX);
		
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
			//��������ָ���໤��
			_setRadio("IS_FORMULATE",IS_FORMULATE);         
			//���ò�������Ű������
			_setRadio("IS_ABUSE_ABANDON",IS_ABUSE_ABANDON);         
			//���ø����ƻ�               
			_setRadio("IS_MEDICALRECOVERY",IS_MEDICALRECOVERY);         
			//��������ǰ׼��             
			_setRadio("ADOPT_PREPARE",ADOPT_PREPARE);         
			//���÷�����ʶ               
			_setRadio("RISK_AWARENESS",RISK_AWARENESS);         
			//����ͬ��ݽ����ú󱨸����� 
			_setRadio("IS_SUBMIT_REPORT",IS_SUBMIT_REPORT);         
			//���ü�������������ͬס     
			_setRadio("IS_FAMILY_OTHERS_FLAG",IS_FAMILY_OTHERS_FLAG);         
			//������������              
			_setRadio("PARENTING",PARENTING);  
			//������Ч����
			_setValidPeriod(VALID_PERIOD);
			//���üҵ������֯
			_setHomestudyOrg(HOMESTUDY_ORG);
			//����ͬ�ӻ��
			_setConabitaPartners(CONABITA_PARTNERS);
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
				//$("#tb_dqsy_en_MALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#tb_dqsy_cn_MALE_HEALTH_CONTENT_CN").hide();
				//$("#tb_dqsy_en_MALE_HEALTH_CONTENT_EN").hide();
			}
		}

		//������λ�޸�
		function _chgMeasurement(o,p,n){
			_setMeasurement(o.value);
			_chgValue(o,p,n);
		}

		function _setMeasurement(m){
			measurement = m;
			if("0" == m){	//0:����
				$("#tb_dqsy_cn_MALE_HEIGHT_INCH").hide();				
				$("#tb_dqsy_cn_MALE_WEIGHT_POUNDS").hide();							
				$("#tb_dqsy_cn_MALE_HEIGHT_METRE").show();				
				$("#tb_dqsy_cn_MALE_WEIGHT_KILOGRAM").show();
				$("#tb_dqsy_cn_MALE_HEIGHT").val(height);
				$("#tb_dqsy_cn_MALE_WEIGHT").val(weight);
				//$("#tb_dqsy_en_MALE_HEIGHT_INCH").hide();
				//$("#tb_dqsy_en_MALE_WEIGHT_POUNDS").hide();
				//$("#tb_dqsy_en_MALE_HEIGHT_METRE").show();
				//$("#tb_dqsy_en_MALE_WEIGHT_KILOGRAM").show();
				//$("#tb_dqsy_en_MALE_HEIGHT").val(height);
				//$("#tb_dqsy_en_MALE_WEIGHT").val(weight);
			}else{ //Ӣ��
				$("#tb_dqsy_cn_MALE_HEIGHT_INCH").show();
				$("#tb_dqsy_cn_MALE_HEIGHT_METRE").hide();
				$("#tb_dqsy_cn_MALE_WEIGHT_POUNDS").show();
				$("#tb_dqsy_cn_MALE_WEIGHT_KILOGRAM").hide();
				//$("#tb_dqsy_en_MALE_HEIGHT_INCH").show();
				//$("#tb_dqsy_en_MALE_HEIGHT_METRE").hide();
				//$("#tb_dqsy_en_MALE_WEIGHT_POUNDS").show();
				//$("#tb_dqsy_en_MALE_WEIGHT_KILOGRAM").hide();

				//���������ת��ΪӢ�����,1Ӣ��=0.3048�ף�1Ӣ��=0.0254��
				var mh = converToValues(height,1);	
				$("#tb_dqsy_cn_MALE_FEET").val(mh[0]);
				$("#tb_dqsy_cn_MALE_INCH").val(mh[1]);
				//$("#tb_dqsy_en_MALE_FEET").val(mh[0]);
				//$("#tb_dqsy_en_MALE_INCH").val(mh[1]);
				
				var mw = converToValues(weight,3);
				$("#tb_dqsy_cn_MALE_WEIGHT").val(mw);
				//$("#tb_dqsy_en_MALE_WEIGHT").val(mw);
			}	
		}
	
	function _setBMI(s){
		$("#tb_dqsy_cn_MALE_BMI").text(_bmi(height/100,weight));
		//$("#tb_dqsy_en_MALE_BMI").text(_bmi(height/100,weight));
	}
	
	function _bmi(h,w){
		return parseFloat(w / (h * h)).toFixed(2);
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
			//$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			//$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG1").get(0).checked = true;			
			$("#tb_dqsy_cn_MALE_PUNISHMENT_CN").show();
			$("#tb_dqsy_cn_MALE_PUNISHMENT_CN").val(MALE_PUNISHMENT_CN);
			//$("#tb_dqsy_en_MALE_PUNISHMENT_EN").show();
			//$("#tb_dqsy_en_MALE_PUNISHMENT_EN").val(MALE_PUNISHMENT_EN) ;
		}else{
			$("#tb_dqsy_cn_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_dqsy_cn_MALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			//$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			//$("#tb_dqsy_en_MALE_PUNISHMENT_FLAG0").get(0).checked = true;			
			$("#tb_dqsy_cn_MALE_PUNISHMENT_CN").hide();
			//$("#tb_dqsy_en_MALE_PUNISHMENT_EN").hide();
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
			//$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			//$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_dqsy_cn_MALE_ILLEGALACT_CN").show();
			$("#tb_dqsy_cn_MALE_ILLEGALACT_CN").val(MALE_ILLEGALACT_CN);
			//$("#tb_dqsy_en_MALE_ILLEGALACT_EN").show();
			//$("#tb_dqsy_en_MALE_ILLEGALACT_EN").val(MALE_ILLEGALACT_EN);

		}else{
			$("#tb_dqsy_cn_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_dqsy_cn_MALE_ILLEGALACT_FLAG0").get(0).checked = true;	
			//$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			//$("#tb_dqsy_en_MALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#tb_dqsy_cn_MALE_ILLEGALACT_CN").hide();
			//$("#tb_dqsy_en_MALE_ILLEGALACT_EN").hide();
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
		//var oe0 = "#tb_dqsy_en_" + rname + "0";
		//var oe1 = "#tb_dqsy_en_" + rname + "1";

		if("1"  == rvalue){			
			$(oc0).removeAttr("checked");
			$(oc1).get(0).checked = true;	
			//$(oe0).removeAttr("checked");
			//$(oe1).get(0).checked = true;				
		}else{
			$(oc1).removeAttr("checked");
			$(oc0).get(0).checked = true;	
			
			//$(oe1).removeAttr("checked");
			//$(oe0).get(0).checked = true;				
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
			//document.getElementById("tb_dqsy_en_MALE_AGE").innerHTML = getAge(o.value);
		}else if(s=="2"){
			document.getElementById("tb_dqsy_cn_FEMALE_AGE").innerHTML = getAge(o.value);
			//document.getElementById("tb_dqsy_en_FEMALE_AGE").innerHTML = getAge(o.value)
		}
		_chgValue(o,p,n);
	}
	
	/*
	*����޸�
	*/
	function _chgHeight(o,p,n,s){
		if(measurement == "0"){
			height = o.value;			
		}else if(measurement == "1"){
			var arr = new Array();
			var obj1,obj2;		
			obj1 = "#" + _getP1(p) + "MALE_FEET";
			//obj2 = "#" + _getP1(p) + "MALE_INCH";			
			arr[0] = ($(obj1).val()!="")?$(obj1).val():0;
			//arr[1] = ($(obj2).val()!="")?$(obj2).val():0;		
			height = converToValues(arr,2);			
		}
		_setBMI(s);
		_chgValue(o,p,n);
	}
	/*
	*Ӣ�������޸�
	*/	
	function _chgWeight(o,p,n,s){
		
		if(measurement == "0"){
			
			weight = o.value;			
		}else if(measurement == "1"){
			weight = converToValues(o.value,4);			
		}
		
		_setBMI(s);
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
	*���üҵ���֯
	*/
	function _setHomestudyOrg(v){
		if(v=="Other"){
			$("#tb_HOMESTUDY_ORG_NAME").show();
		}else{
			$("#tb_HOMESTUDY_ORG_NAME").hide();
		}	
	}

	//����ͬ�ӻ��
	function _setConabitaPartners(v){
		if(v=="1"){	
			$("#tb_dqsy_cn_CONABITA_PARTNERS_TIME_TITLE").show();
			$("#tb_dqsy_cn_CONABITA_PARTNERS_TIME_VALUE").show();
		}else{
			$("#tb_dqsy_cn_CONABITA_PARTNERS_TIME_TITLE").hide();
			$("#tb_dqsy_cn_CONABITA_PARTNERS_TIME_VALUE").hide();
		}	
	}
	function _chgConabitaPartners(o,p,n){
		_setConabitaPartners(o.value);
		_chgRadio(o,p,n);
	}

	/*
	*�ҵ���֯�޸�
	*/
	function _chgHomestudyOrg(v){
		$("#FE_HOMESTUDY_ORG_NAME").val(v);
	
		_setHomestudyOrg(v);	
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



	

	/************************************************************/
	/*
	* �������ı�������,������������ֵ
	* o������
	* p����ǩҳ -1ʱ������Ҫ��Ӣ��ͬ��(�����ҳ���иò�����Ч)
	* n����������
	*/	
	function _chgValue(o,p,n){
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
		var _id2 = "FE_" + n;
		document.getElementById(_id2).value = ret;	
	}
	
	//��ʼ������
	function _initData(){
		$.each(objField,function(n,value) {
			var obj1 = "#tb_dqsy_cn_MALE_" + value.name;
			
			//var obj2 = "#tb_dqsy_en_MALE_" + value.name;
			//if("0"==value.syn){
			//	obj1 = "#tb_dqsy_"+value.pre+"_MALE_" + value.name;
			//}
			if("select"==value.type){			
				_setSelectValue(obj1,("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				//if("1"==value.syn){					
				//	_setSelectValue(obj2,("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				//}
			}
			else if("text"==value.type){
				$(obj1).val(("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				//if("1"==value.syn){					
				//	$(obj2).val(("2"==ADOPTER_SEX)?value.FEMALE:value.MALE);
				//}
			}
		}); 
	}

	function _setData(){		
		var objField;
		if("1" == ADOPTER_SEX){//�е���
			$.each(arrayFields,function(n,value) {
				objField = "#FE_FEMALE_" + value;
				$(objField).val("");
			}); 
		}else{//Ů����
			$.each(arrayFields,function(n,value) {
				objField = "#FE_MALE_" + value;
				$(objField).val("");
			}); 
		}
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
	* ������Ч��������
	* 1:��Ч����
	* 2:����
	*/
	function _setValidPeriod(v){
		
		if(v=="2"){
			$("#FE_VALID_PERIOD_TYPE").val("2");
			$("#tb_VALID_PERIOD").hide();				
		}else{
			$("#FE_VALID_PERIOD_TYPE").val("1");
			if($("#tb_dqsy_cn_VALID_PERIOD").val()=="-1"){
				$("#tb_dqsy_cn_VALID_PERIOD").val("");
			}
			$("#tb_VALID_PERIOD").show();
		}
	}
	
	//�ύ
	function _submit(){		
		if (!runFormVerify(document.fileForm, false)) {
			alert("ҳ��У�����");
			return;
		}
		document.fileForm.action=path+"/ffs/jbraudit/saveFileInfoAndHistroyInfo.action";
		document.fileForm.submit();
	}

	//���������ϴ�ʹ��
	function getIframeVal(val)  
	{
		//document.getElementById("textareaid").value=urlDecode(val);
		//alert(document.getElementById("frmUpload"));
		//document.getElementById("frmUpload").location.reload();
		
		frmUpload.window.location.reload();
		
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

	</script>
	
	<BZ:form name="fileForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="FE_" field="AF_ID"					id="FE_AF_ID" defaultValue=""/>
        <BZ:input type="hidden" prefix="FE_" field="MALE_NAME"			id="FE_MALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_BIRTHDAY"		id="FE_MALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PHOTO"			id="FE_MALE_PHOTO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_NATION"			id="FE_MALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PASSPORT_NO"	id="FE_MALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_EDUCATION"		id="FE_MALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_JOB_CN"			id="FE_MALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_JOB_EN"			id="FE_MALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH"			id="FE_MALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH_CONTENT_CN" id="FE_MALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH_CONTENT_EN" id="FE_MALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MEASUREMENT"			id="FE_MEASUREMENT" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEIGHT"			id="FE_MALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_WEIGHT"			id="FE_MALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_BMI"			id="FE_MALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_FLAG" id="FE_MALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_CN"	id="FE_MALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_EN"	id="FE_MALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_FLAG" id="FE_MALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_CN"	id="FE_MALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_EN"	id="FE_MALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_RELIGION_CN"	id="FE_MALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_RELIGION_EN"	id="FE_MALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_MARRY_TIMES"	id="FE_MALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_YEAR_INCOME"	id="FE_MALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_NAME"			id="FE_FEMALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_BIRTHDAY"		id="FE_FEMALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PHOTO"		id="FE_FEMALE_PHOTO" defaultValue=""/>
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_NATION"		id="FE_FEMALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PASSPORT_NO"	id="FE_FEMALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_EDUCATION"	id="FE_FEMALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_JOB_CN"		id="FE_FEMALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_JOB_EN"		id="FE_FEMALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH"		id="FE_FEMALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH_CONTENT_CN" id="FE_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH_CONTENT_EN" id="FE_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEIGHT"		id="FE_FEMALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_WEIGHT"		id="FE_FEMALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_BMI"			id="FE_FEMALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_FLAG" id="FE_FEMALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_CN" id="FE_FEMALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_EN" id="FE_FEMALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_FLAG" id="FE_FEMALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_CN" id="FE_FEMALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_EN" id="FE_FEMALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_RELIGION_CN"	id="FE_FEMALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_RELIGION_EN"	id="FE_FEMALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_MARRY_TIMES"	id="FE_FEMALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_YEAR_INCOME"	id="FE_FEMALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MARRY_CONDITION"		id="FE_MARRY_CONDITION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MARRY_DATE" 			id="FE_MARRY_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CONABITA_PARTNERS"	id="FE_CONABITA_PARTNERS" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="CONABITA_PARTNERS_TIME" id="FE_CONABITA_PARTNERS_TIME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="GAY_STATEMENT"		id="FE_GAY_STATEMENT" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="CURRENCY"			id="FE_CURRENCY" defaultValue="840"/> 
        <BZ:input type="hidden" prefix="FE_" field="TOTAL_ASSET"			id="FE_TOTAL_ASSET" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="TOTAL_DEBT"			id="FE_TOTAL_DEBT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILD_CONDITION_CN"	id="FE_CHILD_CONDITION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILD_CONDITION_EN"	id="FE_CHILD_CONDITION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="UNDERAGE_NUM"		id="FE_UNDERAGE_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADDRESS"				id="FE_ADDRESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_REQUEST_CN"	id="FE_ADOPT_REQUEST_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_REQUEST_EN"	id="FE_ADOPT_REQUEST_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FINISH_DATE"			id="FE_FINISH_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="RECOMMENDATION_NUM"	id="FE_RECOMMENDATION_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="HEART_REPORT"		id="FE_HEART_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_MEDICALRECOVERY"	id="FE_IS_MEDICALRECOVERY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MEDICALRECOVERY_CN"	id="FE_MEDICALRECOVERY_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MEDICALRECOVERY_EN"	id="FE_MEDICALRECOVERY_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FORMULATE"		id="FE_IS_FORMULATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_PREPARE"		id="FE_ADOPT_PREPARE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="RISK_AWARENESS"		id="FE_RISK_AWARENESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_ABUSE_ABANDON"	id="FE_IS_ABUSE_ABANDON" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_SUBMIT_REPORT"	id="FE_IS_SUBMIT_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_FLAG" id="FE_IS_FAMILY_OTHERS_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_CN" id="FE_IS_FAMILY_OTHERS_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_EN" id="FE_IS_FAMILY_OTHERS_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_MOTIVATION"	id="FE_ADOPT_MOTIVATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILDREN_ABOVE"		id="FE_CHILDREN_ABOVE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="INTERVIEW_TIMES"		id="FE_INTERVIEW_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ACCEPTED_CARD"		id="FE_ACCEPTED_CARD" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="PARENTING"			id="FE_PARENTING" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="SOCIALWORKER"		id="FE_SOCIALWORKER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="REMARK_CN"			id="FE_REMARK_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="REMARK_EN"			id="FE_REMARK_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="GOVERN_DATE"			id="FE_GOVERN_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="VALID_PERIOD"		id="FE_VALID_PERIOD" defaultValue="-1"/>
        <BZ:input type="hidden" prefix="FE_" field="APPROVE_CHILD_NUM"	id="FE_APPROVE_CHILD_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="AGE_FLOOR" 			id="FE_AGE_FLOOR" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="AGE_UPPER" 			id="FE_AGE_UPPER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILDREN_SEX" 		id="FE_CHILDREN_SEX" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILDREN_HEALTH_CN" 	id="FE_CHILDREN_HEALTH_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILDREN_HEALTH_EN" 	id="FE_CHILDREN_HEALTH_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="PACKAGE_ID" 			id="FE_PACKAGE_ID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CREATE_USERID" 		id="FE_CREATE_USERID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CREATE_DATE" 		id="FE_CREATE_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="SUBMIT_USERID" 		id="FE_SUBMIT_USERID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="SUBMIT_DATE" 		id="FE_SUBMIT_DATE" defaultValue=""/> 
		<BZ:input type="hidden" prefix="FE_" field="ADOPTER_SEX" 		id="FE_ADOPTER_SEX" defaultValue=""/> 

		<!-- ��������end -->
		
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
								<up:uploadImage attTypeCode="AF" id="FE_MALE_PHOTO" packageId="<%=afId%>" name="FE_MALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
								hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=smallType %>" diskStoreRuleParamValues="<%=strPar%>"/> 
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
								<textarea name="FE_MALE_HEALTH_CONTENT_CN" id="tb_dqsy_cn_MALE_HEALTH_CONTENT_CN" maxlength="1000" style="display:none;width:90%" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_CN')"></textarea>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">���</td>
							<td class="edit-data-value">
								<span style="display: none">
								<BZ:select field="MEASUREMENT" id="tb_dqsy_cn_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgMeasurement(this,0,'MEASUREMENT')">
									<BZ:option value="0">����</BZ:option>
									<BZ:option value="1">Ӣ��</BZ:option>
								</BZ:select>
								</span>
								<span id="tb_dqsy_cn_MALE_HEIGHT_INCH" style="display: none">
									<BZ:input field="MALE_FEET" id="tb_dqsy_cn_MALE_FEET" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:10%" onchange="_chgHeight(this,0,'MALE_FEET','1')"/>Ӣ��
									<BZ:input field="MALE_INCH" id="tb_dqsy_cn_MALE_INCH" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:10%" onchange="_chgHeight(this,0,'MALE_INCH','1')"/>Ӣ��
								</span>
								<span id="tb_dqsy_cn_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_dqsy_cn_MALE_HEIGHT" formTitle="" defaultValue="" restriction="number" maxlength="" size="10" onchange="_chgHeight(this,0,'MALE_HEIGHT','1')"/>����</span>
							</td>
							<td class="edit-data-title">����</td>
							<td class="edit-data-value">
								<BZ:input field="MALE_WEIGHT" id="tb_dqsy_cn_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setMaleBMI()" size="10" onchange="_chgWeight(this,0,'MALE_WEIGHT','1')" maxlength="50"/><span id="tb_dqsy_cn_MALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_dqsy_cn_MALE_WEIGHT_KILOGRAM">ǧ��</span>
							</td>
						</tr>                                    
						<tr>
							<td class="edit-data-title">����ָ��</td>
							<td class="edit-data-value" colspan="4">
								<div id="tb_dqsy_cn_MALE_BMI" style="font-size:14px">&nbsp;</div>
							</td>
						</tr>
						<tr>
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
							<td class="edit-data-title">�ڽ�����</td>
							<td class="edit-data-value">
								<BZ:input field="MALE_RELIGION_CN" id="tb_dqsy_cn_MALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" size="30" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')"/>
							</td>
							<td class="edit-data-title">����״��</td>
							<td class="edit-data-value" colspan="2">
							<BZ:select field="MARRY_CONDITION" id="tb_dqsy_cn_MARRY_CONDITION" formTitle=""  defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" notnull="" width="210px" onchange="_chgValue(this,0,'MARRY_CONDITION')">
									<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>                                       
							</td>
						</tr>
						
						 <tr>
                             <td class="edit-data-title">ͬ�ӻ��</td>
                             <td class="edit-data-value">
  								 <input type="radio" name="tb_dqsy_cn_CONABITA_PARTNERS" id="tb_dqsy_cn_CONABITA_PARTNERS0" value="0" onchange="_chgConabitaPartners(this,-1,'CONABITA_PARTNERS')">��
                                 <input type="radio" name="tb_dqsy_cn_CONABITA_PARTNERS" id="tb_dqsy_cn_CONABITA_PARTNERS1" value="1" onchange="_chgConabitaPartners(this,-1,'CONABITA_PARTNERS')">��
                             </td>                                        
                             <td class="edit-data-title">
                             	<span id="tb_dqsy_cn_CONABITA_PARTNERS_TIME_TITLE" style="display: none">ͬ��ʱ��</span>
                             </td>
                             <td class="edit-data-value" colspan="2">
                             	<span id="tb_dqsy_cn_CONABITA_PARTNERS_TIME_VALUE" style="display: none">
                                 <BZ:input  field="CONABITA_PARTNERS_TIME" id="tb_dqsy_cn_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" onchange="_chgValue(this,0,'CONABITA_PARTNERS_TIME')"/>��
                                 </span>
                             </td>                                        
                         </tr>
						<tr>
							<td class="edit-data-title">��ͬ��������</td>
							<td class="edit-data-value" colspan="4">
								<input type="radio" name="tb_dqsy_cn_GAY_STATEMENT" id="tb_dqsy_cn_GAY_STATEMENT0" value="0" onchange="_chgRadio(this,-1,'GAY_STATEMENT')">��
								<input type="radio" name="tb_dqsy_cn_GAY_STATEMENT" id="tb_dqsy_cn_GAY_STATEMENT1" value="1" onchange="_chgRadio(this,-1,'GAY_STATEMENT')">��
							</td>
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
							<td class="edit-data-title" style="width:15%">��ͥ�����������</td>
							<td class="edit-data-value" style="width:18%">
								<BZ:input field="FINISH_DATE" id="tb_dqsy_cn_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,0,'FINISH_DATE')"/>
							</td>
							<td class="edit-data-title" style="width:15%">����������Σ�</td>
							<td class="edit-data-value" style="width:18%">
								<BZ:input field="INTERVIEW_TIMES" id="tb_dqsy_cn_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'INTERVIEW_TIMES')"/>
							</td>                                    
							<td class="edit-data-title" style="width:15%">�Ƽ��ţ��⣩</td>
							<td class="edit-data-value" style="width:19%">
								<BZ:input field="RECOMMENDATION_NUM" id="tb_dqsy_cn_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'RECOMMENDATION_NUM')"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������������</td>
							<td class="edit-data-value">
								<BZ:select field="HEART_REPORT" id="tb_dqsy_cn_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT"  notnull="" width="70%" onchange="_chgValue(this,0,'HEART_REPORT')">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:select field="ADOPT_MOTIVATION" id="tb_dqsy_cn_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,0,'ADOPT_MOTIVATION')">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						
							<td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
							<td class="edit-data-value">
								<BZ:select field="CHILDREN_ABOVE" id="tb_dqsy_cn_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,0,'CHILDREN_ABOVE')">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����ָ���໤��</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_IS_FORMULATE" id="tb_dqsy_cn_IS_FORMULATE0" value="0" onchange="_chgRadio(this,-1,'IS_FORMULATE')">��
								<input type="radio" name="tb_dqsy_cn_IS_FORMULATE" id="tb_dqsy_cn_IS_FORMULATE1" value="1"
								onchange="_chgRadio(this,-1,'IS_FORMULATE')">��
							</td>
							<td class="edit-data-title">��������Ű������</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_IS_ABUSE_ABANDON" id="tb_dqsy_cn_IS_ABUSE_ABANDON0" value="0" onchange="_chgRadio(this,-1,'IS_ABUSE_ABANDON')">��
								<input type="radio" name="tb_dqsy_cn_IS_ABUSE_ABANDON" id="tb_dqsy_cn_IS_ABUSE_ABANDON1" value="1" onchange="_chgRadio(this,-1,'IS_ABUSE_ABANDON')">��
							</td>
						
							<td class="edit-data-title">�����ƻ�</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_IS_MEDICALRECOVERY" id="tb_dqsy_cn_IS_MEDICALRECOVERY0" value="0" onchange="_chgRadio(this,-1,'IS_MEDICALRECOVERY')">��
								<input type="radio" name="tb_dqsy_cn_IS_MEDICALRECOVERY" id="tb_dqsy_cn_IS_MEDICALRECOVERY1" value="1" onchange="_chgRadio(this,-1,'IS_MEDICALRECOVERY')">��
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����ǰ׼��</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_ADOPT_PREPARE" id="tb_dqsy_cn_ADOPT_PREPARE0" value="0" onchange="_chgRadio(this,-1,'ADOPT_PREPARE')">��
								<input type="radio" name="tb_dqsy_cn_ADOPT_PREPARE" id="tb_dqsy_cn_ADOPT_PREPARE1" value="1" onchange="_chgRadio(this,-1,'ADOPT_PREPARE')">��
							</td>
							<td class="edit-data-title">������ʶ</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_RISK_AWARENESS" id="tb_dqsy_cn_RISK_AWARENESS0" value="0" onchange="_chgRadio(this,-1,'RISK_AWARENESS')">��
								<input type="radio" name="tb_dqsy_cn_RISK_AWARENESS" id="tb_dqsy_cn_RISK_AWARENESS1" value="1" onchange="_chgRadio(this,-1,'RISK_AWARENESS')">��
							</td>
					   
							<td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_IS_SUBMIT_REPORT" id="tb_dqsy_cn_IS_SUBMIT_REPORT0" value="0" onchange="_chgRadio(this,-1,'IS_SUBMIT_REPORT')">��
								<input type="radio" name="tb_dqsy_cn_IS_SUBMIT_REPORT" id="tb_dqsy_cn_IS_SUBMIT_REPORT1" value="1" onchange="_chgRadio(this,-1,'IS_SUBMIT_REPORT')">��
							</td>
						</tr>                                    
						<tr>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<input type="radio" name="tb_dqsy_cn_PARENTING" id="tb_dqsy_cn_PARENTING0" value="0" onchange="_chgRadio(this,-1,'PARENTING')">��
								<input type="radio" name="tb_dqsy_cn_PARENTING" id="tb_dqsy_cn_PARENTING1" value="1" onchange="_chgRadio(this,-1,'PARENTING')">��
							</td>
							<td class="edit-data-title">�繤���</td>
							<td class="edit-data-value">
								<BZ:select field="SOCIALWORKER" id="tb_dqsy_cn_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,0,'SOCIALWORKER')" >
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
								<input type="radio" name="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG0" value="0" onchange="_chgRadio(this,-1,'IS_FAMILY_OTHERS_FLAG')">��
								<input type="radio" name="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG1" value="1" onchange="_chgRadio(this,-1,'IS_FAMILY_OTHERS_FLAG')">��
							</td>
							<td class="edit-data-title">����������ͬס˵��</td>
							<td class="edit-data-value" colspan="3">
								<BZ:input field="IS_FAMILY_OTHERS_CN" id="tb_dqsy_cn_IS_FAMILY_OTHERS_CN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ͥ��˵������������</td>
							<td class="edit-data-value" colspan="5">
								<BZ:input field="REMARK_CN" id="tb_dqsy_cn_REMARK_CN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'REMARK_CN')"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
						</tr>
						<tr>
							<td class="edit-data-title">��׼����</td>
							<td class="edit-data-value">
								<BZ:input field="GOVERN_DATE" id="tb_dqsy_cn_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
							</td>
							<td class="edit-data-title">��Ч����</td>
							<td class="edit-data-value">
								<BZ:select field="VALID_PERIOD_TYPE" id="FE_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_setValidPeriod(this.value)">
									<BZ:option value="1">��Ч����</BZ:option>
									<BZ:option value="2">����</BZ:option>
								</BZ:select>
								<span id="tb_VALID_PERIOD" style="display: none">
								<BZ:input field="VALID_PERIOD" id="tb_dqsy_cn_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>��
								</span>
							</td>
							<td class="edit-data-title">��׼��ͯ����</td>
							<td class="edit-data-value">
								<BZ:input field="APPROVE_CHILD_NUM" id="tb_dqsy_cn_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'APPROVE_CHILD_NUM')"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������ͯ����</td>
							<td class="edit-data-value">
								<BZ:input field="AGE_FLOOR" id="tb_dqsy_cn_AGE_FLOOR" formTitle="" defaultValue="" restriction="number" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_FLOOR')"/>��~
								<BZ:input field="AGE_UPPER" id="tb_dqsy_cn_AGE_UPPER" formTitle="" defaultValue="" restriction="number" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_UPPER')"/>��
							</td>
							<td class="edit-data-title">������ͯ�Ա�</td>
							<td class="edit-data-value">
								<BZ:select field="CHILDREN_SEX" id="tb_dqsy_cn_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,0,'CHILDREN_SEX')">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">������ͯ����״��</td>
							<td class="edit-data-value">
								<BZ:select field="CHILDREN_HEALTH_CN" id="tb_dqsy_cn_CHILDREN_HEALTH_CN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%"  onchange="_chgValue(this,0,'CHILDREN_HEALTH_CN')">
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
							<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table> 
		<!--����������end-->                
	</BZ:form>
	<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--����ʹ�ã�start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=xmlstr%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='<%=strPar1%>'/>		
	<!--����ʹ�ã�end-->
	</form>
	</BZ:body>
</BZ:html>
