<%
/**   
 * @Title: stepchild_cn_edit.jsp
 * @Description:  继子女收养-中文-编辑
 * @author wangz   
 * @date 2014-9-29
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
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
    <title>收养文件中文</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		var path = "<%=path%>";
		var formType = "jzn";
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// 收养人性别
		var FAMILY_TYPE = "<BZ:dataValue type="String" field="FAMILY_TYPE" defaultValue="1" onlyValue="true"/>";		//收养类型
		var FILE_TYPE = "<BZ:dataValue type="String" field="FILE_TYPE" defaultValue="1" onlyValue="true"/>";			//文件类型	
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// 收养人性别
		
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
		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//男收养人的健康状况
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//女收养人的健康状况		
		var MALE_HEALTH_CONTENT_CN = "<BZ:dataValue type="String" field="MALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>";	//男收养人的健康状况描述-中文
		var FEMALE_HEALTH_CONTENT_CN = "<BZ:dataValue type="String" field="FEMALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>";	//女收养人的健康状况描述-中文
		var MALE_HEALTH_CONTENT_EN = "<BZ:dataValue type="String" field="MALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>";	//男收养人的健康状况描述-外文
		var FEMALE_HEALTH_CONTENT_EN = "<BZ:dataValue type="String" field="FEMALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>";	//女收养人的健康状况描述-外文
		
		var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//计量单位
		var male_height	 = "<BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>";		//男收养人身高
		var female_height = "<BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>";	//女收养人身高
		var male_weight = "<BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>";		//男收养人体重
		var female_weight = "<BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>";	//女收养人体重
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人违法行为及刑事处罚
		var MALE_PUNISHMENT_CN = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>";	//男收养人违法行为及刑事处罚
		var MALE_PUNISHMENT_EN = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>";	//男收养人违法行为及刑事处罚
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人违法行为及刑事处罚
		var FEMALE_PUNISHMENT_CN = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>";	//女收养人违法行为及刑事处罚
		var FEMALE_PUNISHMENT_EN = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>";	//女收养人违法行为及刑事处罚
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人有无不良嗜好
		var MALE_ILLEGALACT_CN = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>";	//男收养人有无不良嗜好
		var MALE_ILLEGALACT_EN = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>";	//男收养人有无不良嗜好

		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人有无不良嗜好
		var FEMALE_ILLEGALACT_CN = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>";	//女收养人有无不良嗜好
		var FEMALE_ILLEGALACT_EN = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>";	//女收养人有无不良嗜好
		var MALE_RELIGION_CN = "<BZ:dataValue type="String" field="MALE_RELIGION_CN" defaultValue="" onlyValue="true"/>";	//宗教信仰
		var MALE_RELIGION_EN = "<BZ:dataValue type="String" field="MALE_RELIGION_EN" defaultValue="" onlyValue="true"/>";	//宗教信仰
		var FEMALE_RELIGION_CN = "<BZ:dataValue type="String" field="FEMALE_RELIGION_CN" defaultValue="" onlyValue="true"/>";	//宗教信仰
		var FEMALE_RELIGION_EN = "<BZ:dataValue type="String" field="FEMALE_RELIGION_EN" defaultValue="" onlyValue="true"/>";	//宗教信仰

		var MARRY_DATE = "<BZ:dataValue type="String" field="MARRY_DATE" defaultValue="" onlyValue="true"/>";			//结婚日期
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//家庭总资产
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";			//家庭总债务
		
		var IS_FORMULATE = "<BZ:dataValue type="String" field="IS_FORMULATE" defaultValue="0" onlyValue="true"/>";		//有无指定监护人
		var IS_ABUSE_ABANDON = "<BZ:dataValue type="String" field="IS_ABUSE_ABANDON" defaultValue="0" onlyValue="true"/>";		//不遗弃不虐待声明
		var IS_MEDICALRECOVERY = "<BZ:dataValue type="String" field="IS_MEDICALRECOVERY" defaultValue="0" onlyValue="true"/>";	//抚育计划
		var ADOPT_PREPARE = "<BZ:dataValue type="String" field="ADOPT_PREPARE" defaultValue="0" onlyValue="true"/>";	//收养前准备
		var RISK_AWARENESS = "<BZ:dataValue type="String" field="RISK_AWARENESS" defaultValue="0" onlyValue="true"/>";	//风险意识
		var IS_SUBMIT_REPORT = "<BZ:dataValue type="String" field="IS_SUBMIT_REPORT" defaultValue="0" onlyValue="true"/>";//同意递交安置后报告声明
		var IS_FAMILY_OTHERS_FLAG = "<BZ:dataValue type="String" field="IS_FAMILY_OTHERS_FLAG" defaultValue="0" onlyValue="true"/>";//家中有无其他人同住
		var PARENTING = "<BZ:dataValue type="String" field="PARENTING" defaultValue="0" onlyValue="true"/>";			// 育儿经验
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//有效期限
		//如果有效期限为-1，则转换为2
		if(VALID_PERIOD=="-1"){
			VALID_PERIOD="2";
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
						//{"name":"HEALTH_CONTENT_EN","MALE":MALE_HEALTH_CONTENT_EN,"FEMALE":FEMALE_HEALTH_CONTENT_EN,"syn":"0","type":"text","pre":"en"},
						{"name":"RELIGION_CN","MALE":MALE_RELIGION_CN,"FEMALE":FEMALE_RELIGION_CN,"syn":"0","type":"text","pre":"cn"},
						//{"name":"RELIGION_EN","MALE":MALE_RELIGION_EN,"FEMALE":FEMALE_RELIGION_EN,"syn":"0","type":"text","pre":"en"}
						];
		$(document).ready( function() {
			dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
			_initData();
			//设置有效期限
			_setValidPeriod(VALID_PERIOD);
		})

	//初始化数据
	function _initData(){
		$.each(objField,function(n,value) {
			var obj1 = "#tb_jzn_cn_MALE_" + value.name;
			
			//var obj2 = "#tb_jzn_en_MALE_" + value.name;
			//if("0"==value.syn){
			//	obj1 = "#tb_jzn_"+value.pre+"_MALE_" + value.name;
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
	* 出生日期修改
	* o：对象
	* p：标签页
	* n：对象名称
	* s：性别
	*/
	function _chgBirthday(o,p,n,s){
		if(s=="1"){		
			document.getElementById("tb_jzn_cn_MALE_AGE").innerHTML = getAge(o.value);
			//document.getElementById("tb_jzn_en_MALE_AGE").innerHTML = getAge(o.value);
		}else if(s=="2"){
			document.getElementById("tb_jzn_cn_FEMALE_AGE").innerHTML = getAge(o.value);
			//document.getElementById("tb_jzn_en_FEMALE_AGE").innerHTML = getAge(o.value)
		}
		_chgValue(o,p,n);
	}
	/*
	* 设置结婚时长
	* d：结婚日期
	*/
	function _setMarryLength(d){
		$("#tb_jzn_cn_MARRY_LENGTH").text(getAge(d));
		//$("#tb_jzn_en_MARRY_LENGTH").text(getAge(d));
	}
	
	//设置收养人性别
	function _chgAdopterSex(o,p,n){
		ADOPTER_SEX = o.value;
		_chgValue(o,p,n);
	}

	/*
	* 设置有效期限类型
	* 1:有效期限
	* 2:长期
	*/
	function _setValidPeriod(v){
		
		if(v=="2"){
			$("#FE_VALID_PERIOD_TYPE").val("2");
			$("#tb_VALID_PERIOD").hide();				
		}else{
			$("#FE_VALID_PERIOD_TYPE").val("1");
			if($("#tb_jzn_cn_VALID_PERIOD").val()=="-1"){
				$("#tb_jzn_cn_VALID_PERIOD").val("");
			}
			$("#tb_VALID_PERIOD").show();
		}
	}

	/*
	* 中外文文本框联动
	* o：对象
	* p：标签页 -1时，不需要中英文同步(在审核页面中该参数无效)
	* n：对象名称
	*/	
	function _chgValue(o,p,n){
		
		var ret = o.value;
		
		//如果是单亲收养或继子女收养，判断后养人性别，如是女则在对象前加前缀"FE"，入库数据则存入对应字段
		if(formType == "dqsy" || formType == "jzn"){
			if("2" == ADOPTER_SEX){
				if(n.substr(0,4)=="MALE"){
					n = "FE" + n;
				}
			}
		}
		var _id2 = "FE_" + n;
		//alert(_id2+":"+ret);
		document.getElementById(_id2).value = ret;
	}
	
	

		//提交
	function _submit(){		
		if (!runFormVerify(document.fileForm, false)) {
			alert("页面校验错误！");
			return;
		}
		document.fileForm.action=path+"/ffs/jbraudit/saveFileInfoAndHistroyInfo.action";
		document.fileForm.submit();
	}

	//批量附件上传使用
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
	//附件上传
	function _toipload(fn){
		p = fn;		
		var packageId,isEn;
		//p=0，上传翻译件
		if(p=="0"){
			packageId = "<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>";
			isEn = "false";
		}else{//p=0，上传原件
			packageId = "<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>";
			isEn = "true";
		}
		document.uploadForm.PACKAGE_ID.value = packageId;
		document.uploadForm.IS_EN.value = isEn;
		document.uploadForm.action="<%=path%>/uploadManager";
		popWin.showWinIframe("1000","600","fileframe","附件管理","iframe","#");
		document.uploadForm.submit();
	}
	
	</script>
	
	<BZ:form name="fileForm" method="post">
		<!-- 隐藏区域begin -->
        <BZ:input type="hidden" prefix="FE_" field="AF_ID" id="FE_AF_ID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_NAME" id="FE_MALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_BIRTHDAY" id="FE_MALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PHOTO" id="FE_MALE_PHOTO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_NATION" id="FE_MALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PASSPORT_NO" id="FE_MALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_EDUCATION" id="FE_MALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_JOB_CN" id="FE_MALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_JOB_EN" id="FE_MALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH" id="FE_MALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH_CONTENT_CN" id="FE_MALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEALTH_CONTENT_EN" id="FE_MALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MEASUREMENT" id="FE_MEASUREMENT" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_HEIGHT" id="FE_MALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_WEIGHT" id="FE_MALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_BMI" id="FE_MALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_FLAG" id="FE_MALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_CN" id="FE_MALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_PUNISHMENT_EN" id="FE_MALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_FLAG" id="FE_MALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_CN" id="FE_MALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_ILLEGALACT_EN" id="FE_MALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_RELIGION_CN" id="FE_MALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_RELIGION_EN" id="FE_MALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_MARRY_TIMES" id="FE_MALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MALE_YEAR_INCOME" id="FE_MALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_NAME" id="FE_FEMALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_BIRTHDAY" id="FE_FEMALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PHOTO" id="FE_FEMALE_PHOTO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_NATION" id="FE_FEMALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PASSPORT_NO" id="FE_FEMALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_EDUCATION" id="FE_FEMALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_JOB_CN" id="FE_FEMALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_JOB_EN" id="FE_FEMALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH" id="FE_FEMALE_HEALTH" defaultValue="1"/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH_CONTENT_CN" id="FE_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEALTH_CONTENT_EN" id="FE_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_HEIGHT" id="FE_FEMALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_WEIGHT" id="FE_FEMALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_BMI" id="FE_FEMALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_FLAG" id="FE_FEMALE_PUNISHMENT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_CN" id="FE_FEMALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_PUNISHMENT_EN" id="FE_FEMALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_FLAG" id="FE_FEMALE_ILLEGALACT_FLAG" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_CN" id="FE_FEMALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_ILLEGALACT_EN" id="FE_FEMALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_RELIGION_CN" id="FE_FEMALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_RELIGION_EN" id="FE_FEMALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_MARRY_TIMES" id="FE_FEMALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FEMALE_YEAR_INCOME" id="FE_FEMALE_YEAR_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MARRY_CONDITION" id="FE_MARRY_CONDITION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MARRY_DATE" 		id="FE_MARRY_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CONABITA_PARTNERS" id="FE_CONABITA_PARTNERS" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="CONABITA_PARTNERS_TIME" id="FE_CONABITA_PARTNERS_TIME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="GAY_STATEMENT" id="FE_GAY_STATEMENT" defaultValue="0"/> 
        <BZ:input type="hidden" prefix="FE_" field="CURRENCY" id="FE_CURRENCY" defaultValue="840"/> 
        <BZ:input type="hidden" prefix="FE_" field="TOTAL_ASSET" id="FE_TOTAL_ASSET" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="TOTAL_DEBT" id="FE_TOTAL_DEBT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILD_CONDITION_CN" id="FE_CHILD_CONDITION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILD_CONDITION_EN" id="FE_CHILD_CONDITION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="UNDERAGE_NUM" id="FE_UNDERAGE_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADDRESS" id="FE_ADDRESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_REQUEST_CN" id="FE_ADOPT_REQUEST_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_REQUEST_EN" id="FE_ADOPT_REQUEST_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="FINISH_DATE" id="FE_FINISH_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="HOMESTUDY_ORG_NAME" id="FE_HOMESTUDY_ORG_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="RECOMMENDATION_NUM" id="FE_RECOMMENDATION_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="HEART_REPORT" id="FE_HEART_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_MEDICALRECOVERY" id="FE_IS_MEDICALRECOVERY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MEDICALRECOVERY_CN" id="FE_MEDICALRECOVERY_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="MEDICALRECOVERY_EN" id="FE_MEDICALRECOVERY_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FORMULATE" id="FE_IS_FORMULATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_PREPARE" id="FE_ADOPT_PREPARE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="RISK_AWARENESS" id="FE_RISK_AWARENESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_ABUSE_ABANDON" id="FE_IS_ABUSE_ABANDON" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_SUBMIT_REPORT" id="FE_IS_SUBMIT_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_FLAG" id="FE_IS_FAMILY_OTHERS_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_CN" id="FE_IS_FAMILY_OTHERS_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="IS_FAMILY_OTHERS_EN" id="FE_IS_FAMILY_OTHERS_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ADOPT_MOTIVATION" id="FE_ADOPT_MOTIVATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="CHILDREN_ABOVE" id="FE_CHILDREN_ABOVE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="INTERVIEW_TIMES" id="FE_INTERVIEW_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="ACCEPTED_CARD" id="FE_ACCEPTED_CARD" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="PARENTING" id="FE_PARENTING" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="SOCIALWORKER" id="FE_SOCIALWORKER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="FE_" field="REMARK_CN" id="FE_REMARK_CN" defaultValue=""/> 
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

		<!-- 隐藏区域end -->
        
		<!--单亲收养：start-->
		<table id="tb_jzn_cn" class="specialtable">
			<tr>
				 <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
			</tr>
			<tr>
				<td>
					<!--收养人信息：start-->                            	  
					<table class="specialtable">                          	
						<tr>
							<td class="edit-data-title" width="15%">外文姓名</td>
							<td class="edit-data-value" width="26%">
								<BZ:input field="MALE_NAME" id="tb_jzn_cn_MALE_NAME" formTitle="" defaultValue="" notnull="true"  maxlength="150" size="30" onchange="_chgValue(this,0,'MALE_NAME')"/>
							</td>
							<td class="edit-data-title" width="15%">性别</td>
							<td class="edit-data-value" width="26%">
								<BZ:select field="ADOPTER_SEX" id="tb_jzn_cn_ADOPTER_SEX" formTitle="" defaultValue="" notnull="" width="210px" onchange="_chgAdopterSex(this,0,'ADOPTER_SEX')">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="1">男</BZ:option>
									<BZ:option value="2">女</BZ:option>
								</BZ:select>					
							</td>
							<td class="edit-data-value" width="18%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="FE_MALE_PHOTO" packageId="<%=afId%>" name="FE_MALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
								hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=smallType %>" diskStoreRuleParamValues="<%=strPar%>"/> 
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">出生日期</td>
							<td class="edit-data-value">
								<BZ:input field="MALE_BIRTHDAY" id="tb_jzn_cn_MALE_BIRTHDAY" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgBirthday(this,0,'MALE_BIRTHDAY','1')"/>
							</td>
							<td class="edit-data-title">年龄</td>
							<td class="edit-data-value">
								<div id="tb_jzn_cn_MALE_AGE" style="font-size:14px">
								<script>											
								document.write(AGE);
								</script>
								</div>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">国籍</td>
							<td class="edit-data-value">
								<BZ:select field="MALE_NATION" formTitle="国籍" codeName="GJ" isCode="true" defaultValue="" id="tb_jzn_cn_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="210px">
								<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
							<td class="edit-data-title">护照号码</td>
							<td class="edit-data-value">
								<BZ:input field="MALE_PASSPORT_NO" id="tb_jzn_cn_MALE_PASSPORT_NO" type="String" formTitle="收养人护照号码" defaultValue="" size="30" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')"/>
							</td>
						</tr>
						 <tr>
							<td class="edit-data-title">婚姻状况</td>
							<td class="edit-data-value">已婚</td>
							<td class="edit-data-title">结婚日期</td>
							<td class="edit-data-value">
								<BZ:input field="MARRY_DATE" id="tb_jzn_cn_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgValue(this,0,'MARRY_DATE')"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">是否公约收养</td>
							<td class="edit-data-value">
								<BZ:select prefix="FE_" field="IS_CONVENTION_ADOPT" id="FE_IS_CONVENTION_ADOPT" formTitle="是否公约收养" defaultValue=""  width="70%">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="0">否</BZ:option>
									<BZ:option value="1">是</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" colspan="5" style="text-align:center"><b>政府批准信息</b></td>
						</tr>
						<tr>
							<td class="edit-data-title">批准日期</td>
							<td class="edit-data-value">
								<BZ:input field="GOVERN_DATE" id="tb_jzn_cn_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
							</td>
							<td class="edit-data-title">有效期限</td>
							<td class="edit-data-value">
								<BZ:select field="VALID_PERIOD_TYPE" id="FE_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_setValidPeriod(this.value)">
									<BZ:option value="1">有效期限</BZ:option>
									<BZ:option value="2">长期</BZ:option>
								</BZ:select>
								<span id="tb_VALID_PERIOD" style="display: none">
								<BZ:input field="VALID_PERIOD" id="tb_jzn_cn_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>月
								</span>
							</td>                                       
						</tr> 
						<tr>
							<td class="edit-data-title" colspan="1" style="text-align:center"></td>
							<td class="edit-data-title" colspan="3" style="text-align:center">
							<b>附件信息</b></td>
							<td class="edit-data-title" colspan="1" style="text-align:center">
							<input type="button" class="btn btn-sm btn-primary" value="附件上传" onclick="_toipload('0')" />
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
		<!--单亲收养：end-->
	</BZ:form>
	<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--附件使用：start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=xmlstr%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value="<%=strPar1%>"/>
		
		<!--附件使用：end-->
	</form>
	</BZ:body>
</BZ:html>
