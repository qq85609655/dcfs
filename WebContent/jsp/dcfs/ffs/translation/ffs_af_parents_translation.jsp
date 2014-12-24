<%
/**   
 * @Title: ffs_af_translation.jsp
 * @Description:  双亲收养文件翻译页
 * @author wangz   
 * @date 2014-8-11 上午10:00:00 
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="java.util.Map"%>

<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();

	String MALE_PHOTO = (String)request.getAttribute("MALE_PHOTO");	
	String FEMALE_PHOTO = (String)request.getAttribute("FEMALE_PHOTO");
	String uploadParameter = (String)request.getAttribute("uploadParameter");
	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
%>
<BZ:html>
<BZ:head>
	<up:uploadResource isImage="true"/>
    <title>文件翻译页（双亲）</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
</BZ:head>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		//附件上传-接受返回值
	
		var path = "<%=path%>";
		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//男收养人的健康状况
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//女收养人的健康状况
		var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//计量单位
		var male_height	 = "<BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>";		//男收养人身高
		var female_height = "<BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>";	//女收养人身高
		var male_weight = "<BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>";		//男收养人体重
		var female_weight = "<BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>";	//女收养人体重
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人违法行为及刑事处罚
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人违法行为及刑事处罚
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人有无不良嗜好
		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人有无不良嗜好
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
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// 收养人性别
		
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//有效期限
		var VALID_PERIOD_TYPE = "1";
		//如果有效期限为-1，则转换为2
		if(VALID_PERIOD=="-1"){
			VALID_PERIOD_TYPE="2";
		}
		$(document).ready( function() {
			setSigle();
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			
		    $('#tab-container').easytabs();
			//初始化健康状况说明的显示与隐藏
			_setMale_health(male_health);
			_setFemale_health(female_health);
			//设置身高、体重的显示方式（公制、英制）
			_setMeasurement(measurement);
			
			//设置BMI
			_setBMI("1");
			_setBMI("2");
			
			//初始化设置违法行为及刑事处罚
			_setMALE_PUNISHMENT_FLAG(MALE_PUNISHMENT_FLAG);
			_setFEMALE_PUNISHMENT_FLAG(FEMALE_PUNISHMENT_FLAG);
						
			//初始化设置有无不良嗜好
			_setMALE_ILLEGALACT_FLAG(MALE_ILLEGALACT_FLAG);
			_setFEMALE_ILLEGALACT_FLAG(FEMALE_ILLEGALACT_FLAG);
			
			//设置结婚时长
			_setMarryLength(MARRY_DATE);
			
			//设置家庭净资产
			_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
			
			//设置有无指定监护人
			_setRadio("IS_FORMULATE",IS_FORMULATE);         
			//设置不遗弃不虐待声明
			_setRadio("IS_ABUSE_ABANDON",IS_ABUSE_ABANDON);         
			//设置抚育计划               
			_setRadio("IS_MEDICALRECOVERY",IS_MEDICALRECOVERY);         
			//设置收养前准备             
			_setRadio("ADOPT_PREPARE",ADOPT_PREPARE);         
			//设置风险意识               
			_setRadio("RISK_AWARENESS",RISK_AWARENESS);         
			//设置同意递交安置后报告声明 
			_setRadio("IS_SUBMIT_REPORT",IS_SUBMIT_REPORT);         
			//设置家中有无其他人同住     
			_setRadio("IS_FAMILY_OTHERS_FLAG",IS_FAMILY_OTHERS_FLAG);         
			//设置育儿经验              
			_setRadio("PARENTING",PARENTING);  
			//设置有效期限
			_initValidPeriod(VALID_PERIOD_TYPE);
			
			$("#tb_sqsy_cn_MALE_HEALTH").change(function(){
					_setMale_health($(this).val());
			  }); 
			  
			  $("#tb_sqsy_en_MALE_HEALTH").change(function(){
					_setMale_health($(this).val());					
			  });
			  
			 $("#tb_sqsy_cn_FEMALE_HEALTH").change(function(){
					_setFemale_health($(this).val());
			  }); 
			  
			  $("#tb_sqsy_en_FEMALE_HEALTH").change(function(){
					_setFemale_health($(this).val());
			  }); 
			
			$("#tb_sqsy_cn_MEASUREMENT").change(function(){
					_setMeasurement($(this).val());
			  });
			  			  
			$("#tb_sqsy_en_MEASUREMENT").change(function(){
					_setMeasurement($(this).val());
			  });
			  
			  $("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG0").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG1").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  			  
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0").click(function(){
					
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1").click(function(){
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").click(function(){
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").click(function(){
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  	
			  $("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG0").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			   $("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG1").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			   $("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			   $("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  
			  $("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  			  
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
		})

		function _setMale_health(p){
			if("2"== p){
				$("#tb_sqsy_cn_MALE_HEALTH_CONTENT_CN").show();
				$("#tb_sqsy_en_MALE_HEALTH_CONTENT_EN").show();
				
			}else{
				$("#tb_sqsy_cn_MALE_HEALTH_CONTENT_CN").hide();
				$("#tb_sqsy_en_MALE_HEALTH_CONTENT_EN").hide();				
			}
		}
		
		function _setFemale_health(p){
			if(p != 1){
				$("#tb_sqsy_cn_FEMALE_HEALTH_CONTENT_CN").show();
				$("#tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#tb_sqsy_cn_FEMALE_HEALTH_CONTENT_CN").hide();
				$("#tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN").hide();
			}			
		}
		
		function _setMeasurement(m){
			measurement = m;
			if(m == "0"){	//0:公制
				$("#tb_sqsy_cn_MALE_HEIGHT_INCH").hide();				
				$("#tb_sqsy_cn_MALE_WEIGHT_POUNDS").hide();							
				$("#tb_sqsy_cn_MALE_HEIGHT_METRE").show();				
				$("#tb_sqsy_cn_MALE_WEIGHT_KILOGRAM").show();
				$("#tb_sqsy_cn_FEMALE_WEIGHT_POUNDS").hide();				
				$("#tb_sqsy_cn_FEMALE_HEIGHT_INCH").hide();	
				$("#tb_sqsy_cn_FEMALE_HEIGHT_METRE").show();				
				$("#tb_sqsy_cn_FEMALE_WEIGHT_KILOGRAM").show();
				$("#tb_sqsy_cn_MALE_HEIGHT").val(male_height);
				$("#tb_sqsy_cn_MALE_WEIGHT").val(male_weight);
				$("#tb_sqsy_cn_FEMALE_HEIGHT").val(female_height);			
				$("#tb_sqsy_cn_FEMALE_WEIGHT").val(female_weight);
				
				$("#tb_sqsy_en_MALE_HEIGHT_INCH").hide();
				$("#tb_sqsy_en_MALE_WEIGHT_POUNDS").hide();
				$("#tb_sqsy_en_FEMALE_WEIGHT_POUNDS").hide();				
				$("#tb_sqsy_en_FEMALE_HEIGHT_INCH").hide();	
							
				$("#tb_sqsy_en_MALE_HEIGHT_METRE").show();
				$("#tb_sqsy_en_MALE_WEIGHT_KILOGRAM").show();
				$("#tb_sqsy_en_FEMALE_HEIGHT_METRE").show();				
				$("#tb_sqsy_en_FEMALE_WEIGHT_KILOGRAM").show();	
				
				$("#tb_sqsy_en_MALE_HEIGHT").val(male_height);
				$("#tb_sqsy_en_MALE_WEIGHT").val(male_weight);
				$("#tb_sqsy_en_FEMALE_HEIGHT").val(female_height);			
				$("#tb_sqsy_en_FEMALE_WEIGHT").val(female_weight);	
			}else{ //英制
				$("#tb_sqsy_cn_MALE_HEIGHT_INCH").show();
				$("#tb_sqsy_cn_MALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_cn_FEMALE_HEIGHT_INCH").show();
				$("#tb_sqsy_cn_FEMALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_cn_MALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_cn_MALE_WEIGHT_KILOGRAM").hide();
				$("#tb_sqsy_cn_FEMALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_cn_FEMALE_WEIGHT_KILOGRAM").hide();
				
				$("#tb_sqsy_en_MALE_HEIGHT_INCH").show();
				$("#tb_sqsy_en_MALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_en_FEMALE_HEIGHT_INCH").show();
				$("#tb_sqsy_en_FEMALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_en_MALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_en_MALE_WEIGHT_KILOGRAM").hide();
				$("#tb_sqsy_en_FEMALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_en_FEMALE_WEIGHT_KILOGRAM").hide();

				//将公制身高转化为英制身高,1英尺=0.3048米，1英寸=0.0254米
				var mh = converToValues(male_height,1);	
				var fh = converToValues(female_height,1);
				$("#tb_sqsy_cn_MALE_FEET").val(mh[0]);
				$("#tb_sqsy_cn_MALE_INCH").val(mh[1]);
				$("#tb_sqsy_cn_FEMALE_FEET").val(fh[0]);
				$("#tb_sqsy_cn_FEMALE_INCH").val(fh[1]);
				
				$("#tb_sqsy_en_MALE_FEET").val(mh[0]);
				$("#tb_sqsy_en_MALE_INCH").val(mh[1]);
				$("#tb_sqsy_en_FEMALE_FEET").val(fh[0]);
				$("#tb_sqsy_en_FEMALE_INCH").val(fh[1]);				
				
				var mw = converToValues(male_weight,3);
				var fw = converToValues(female_weight,3);				
				$("#tb_sqsy_cn_MALE_WEIGHT").val(mw);
				$("#tb_sqsy_cn_FEMALE_WEIGHT").val(fw);
				$("#tb_sqsy_en_MALE_WEIGHT").val(mw);
				$("#tb_sqsy_en_FEMALE_WEIGHT").val(fw);				
			}	
		}
	
	function _setBMI(s){		
		if(s=="1"){	//男收养人
			if(male_height=="" || male_weight==""){
				return;	
			}
			$("#tb_sqsy_cn_MALE_BMI").text(_bmi(male_height/100,male_weight));
			$("#tb_sqsy_en_MALE_BMI").text(_bmi(male_height/100,male_weight));
			
		}else if(s=="2"){//女收养人
			if(female_height=="" || female_weight==""){
				return;	
			}
			$("#tb_sqsy_cn_FEMALE_BMI").text(_bmi(female_height/100,female_weight));
			$("#tb_sqsy_en_FEMALE_BMI").text(_bmi(female_height/100,female_weight));
		}
			
	}
	
	function _bmi(h,w){
		return parseFloat(w / (h * h)).toFixed(2);
	}

	//设置违法行为及刑事处罚	
	function _setMALE_PUNISHMENT_FLAG(f){
		MALE_PUNISHMENT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG1").get(0).checked = true;		
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").get(0).checked = true;			
			$("#tb_sqsy_cn_MALE_PUNISHMENT_CN").show();
			$("#tb_sqsy_en_MALE_PUNISHMENT_EN").show();
		}else{
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").get(0).checked = true;
			
			$("#tb_sqsy_cn_MALE_PUNISHMENT_CN").hide();
			$("#tb_sqsy_en_MALE_PUNISHMENT_EN").hide();
		}	
	}
	
	//设置违法行为及刑事处罚
	function _setFEMALE_PUNISHMENT_FLAG(f){
		FEMALE_PUNISHMENT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_CN").show();
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_EN").show();
		}else{
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_CN").hide();
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_EN").hide();
		}			
	}
	
	//设置有无不良嗜好
	function _setMALE_ILLEGALACT_FLAG(f){
		MALE_ILLEGALACT_FLAG = f;
		if("1" == f){
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_cn_MALE_ILLEGALACT_CN").show();
			$("#tb_sqsy_en_MALE_ILLEGALACT_EN").show();
		}else{
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#tb_sqsy_cn_MALE_ILLEGALACT_CN").hide();
			$("#tb_sqsy_en_MALE_ILLEGALACT_EN").hide();
		}			
	}
	
		//设置有无不良嗜好
	function _setFEMALE_ILLEGALACT_FLAG(f){
		FEMALE_ILLEGALACT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").get(0).checked = true;				
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_CN").show();
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_EN").show();
		}else{
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_CN").hide();
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_EN").hide();
		}			
	}
	
	//raido类控件修改
	function _chgRadio(o,p,n){
		 _setRadio(n,o.value);
		 _chgValue(o,p,n);
	}
	
	function _setRadio(rname,rvalue){
		var oc0 = "#tb_sqsy_cn_" + rname + "0";
		var oc1 = "#tb_sqsy_cn_" + rname + "1";
		var oe0 = "#tb_sqsy_en_" + rname + "0";
		var oe1 = "#tb_sqsy_en_" + rname + "1";
		if(rvalue == "1"){
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
	* 出生日期修改
	* o：对象
	* p：标签页
	* n：对象名称
	* s：性别
	*/
	function _chgBirthday(o,p,n,s){
		if(s=="1"){		
			document.getElementById("tb_sqsy_cn_MALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_sqsy_en_MALE_AGE").innerHTML = getAge(o.value);
		}else if(s=="2"){
			document.getElementById("tb_sqsy_cn_FEMALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_sqsy_en_FEMALE_AGE").innerHTML = getAge(o.value)
		}
		_chgValue(o,p,n);
	}
	
	/*
	*身高修改
	*/
	function _chgHeight(o,p,n,s){
		if(measurement == "0"){
			if(s=="1"){				
				male_height = o.value;
			}else if(s=="2"){
				female_height = o.value;	
			}
		}else if(measurement == "1"){
			var arr = new Array();
			var obj1,obj2;
			if(s=="1"){				
				obj1 = "#" + _getP1(p) + "MALE_FEET";
				obj2 = "#" + _getP1(p) + "MALE_INCH";			
				arr[0] = ($(obj1).val()!="")?$(obj1).val():0;
				arr[1] = ($(obj2).val()!="")?$(obj2).val():0;		
				male_height = converToValues(arr,2);			
			}else if(s=="2"){
				obj1 = "#" + _getP1(p) + "FEMALE_FEET";
				obj2 = "#" + _getP1(p) + "FEMALE_INCH";	
				arr[0] = ($(obj1).val()!="")?$(obj1).val():0;
				arr[1] = ($(obj2).val()!="")?$(obj2).val():0;

				female_height = converToValues(arr,2);
			}
		}
		_setBMI(s);
		_chgValue(o,p,n);
	}
	/*
	*英制体重修改
	*/	
	function _chgWeight(o,p,n,s){		
		if(measurement == "0"){
			if(s=="1"){				
				male_weight = o.value;
			}else if(s=="2"){
				female_weight = o.value;	
			}
		}else if(measurement == "1"){
			if(s=="1"){				
				male_weight = converToValues(o.value,4);
			}else if(s=="2"){		
				female_weight = converToValues(o.value,4);
			}
		}
		_setBMI(s);
		_chgValue(o,p,n);
	}
	
	/*
	* 结婚日期修改
	* o：对象
	* p：标签页
	* n：对象名称
	*/
	function _chgMarryDate(o,p,n){
		_setMarryLength(o.value);	
		_chgValue(o,p,n);
	}
	
	/*
	* 设置结婚时长
	* d：结婚日期
	*/
	function _setMarryLength(d){
		$("#tb_sqsy_cn_MARRY_LENGTH").text(getAge(d));
		$("#tb_sqsy_en_MARRY_LENGTH").text(getAge(d));
	}
	/*
	*家庭总资产修改
	*/
	function _chgTotalAsset(o,p,n){
		TOTAL_ASSET = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
		_chgValue(o,p,n);
	}
	
	/*
	*家庭总债务修改
	*/
	function _chgTotalDebt(o,p,n){
		TOTAL_DEBT = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
		_chgValue(o,p,n);
	}
	
	/*
	* 设置家庭净资产
	*/
	function _setTotalManny(a,d){
		if(a=="" || d==""){
			return;
		}		
		$("#tb_sqsy_cn_TOTAL_MANNY").text(a - d);
		$("#tb_sqsy_en_TOTAL_MANNY").text(a - d);	
	}

	/*
	* 设置有效期限类型
	* v
	* 1:有效期限
	* 2:长期
	*/
	
	function _setValidPeriod(o,p,n){		
		if(o.value=="2"){			
			$("#tb_sqsy_cn_VALID_PERIOD0").hide();
			$("#tb_sqsy_en_VALID_PERIOD0").hide();
			$("#P_VALID_PERIOD").val("-1");
		}else{			
			$("#tb_sqsy_cn_VALID_PERIOD0").show();
			$("#tb_sqsy_en_VALID_PERIOD0").show();
			$("#tb_sqsy_cn_VALID_PERIOD").val("");
			$("#tb_sqsy_en_VALID_PERIOD").val("");
		}
		_chgValue(o,p,n);
	}
	function _initValidPeriod(v){
		if(v=="2"){
			$("#tb_sqsy_cn_VALID_PERIOD_TYPE").val("2");
			$("#tb_sqsy_en_VALID_PERIOD_TYPE").val("2");
			$("#tb_sqsy_cn_VALID_PERIOD0").hide();
			$("#tb_sqsy_en_VALID_PERIOD0").hide();

		}else{
			$("#tb_sqsy_cn_VALID_PERIOD_TYPE").val("1");
			$("#tb_sqsy_en_VALID_PERIOD_TYPE").val("1");
			$("#tb_sqsy_cn_VALID_PERIOD0").show();
			$("#tb_sqsy_en_VALID_PERIOD0").show();
		}
	}
	/*
	* 中外文文本框联动
	* o：对象
	* p：标签页 -1时，不需要中英文同步
	* n：对象名称
	*/	
	function _chgValue(o,p,n){
		if(p!="-1"){
			var _id1 = _getP(p) + n;
			var obj = document.getElementById(_id1);
			if(null!=obj){
				obj.value = o.value;			
			}
		}
		var ret = o.value;
		
		//如果是英制身高，则隐藏域保存公制身高数据
		if(n=="MALE_FEET" || n=="MALE_INCH"){
			n = "MALE_HEIGHT";
			ret = male_height;
		}
		if(n=="FEMALE_FEET" || n=="FEMALE_INCH"){
			n = "FEMALE_HEIGHT";
			ret = female_height;
		}
		//如果是英制体重，则隐藏域保存公制体重数据
		if(n=="MALE_WEIGHT" ){
			ret = male_weight;
		}
		if(n=="FEMALE_WEIGHT"){
			ret = female_weight;
		}
		var _id2 = "P_" + n;
		//alert(_id2);
		document.getElementById(_id2).value = ret;
		
	}
	
	function _getP(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_sqsy_en_";		
			break;
		case 1:
			p1 = "tb_sqsy_cn_";
			break;	
		}
		return p1;
	}
	
	function _getP1(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_sqsy_cn_";		
			break;
		case 1:
			p1 = "tb_sqsy_en_";
			break;	
		}
		return p1;
	}

	//翻译保存
	function _save() {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/ffs/ffsaftranslation/save.action";		
		document.srcForm.submit();
	  
	}
	//翻译完成提交
	function _submit() {
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
	
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/ffs/ffsaftranslation/save.action";
		document.srcForm.submit();
	  
	}
	//返回列表
	function _goback(){
		var url = '<BZ:dataValue field="TRANSLATION_TYPE" onlyValue="true" checkValue="0=findList;1=adTranslationList;2=reTranslationList"/>';
		document.srcForm.action = path + "/ffs/ffsaftranslation/"+url+".action";
		document.srcForm.submit();
	}

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
	function _toipload(fn,obj){
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

		var y = obj.offsetTop;
		var ch = document.body.clientHeight;
		while(obj=obj.offsetParent) 
		{ 
			y   +=   obj.offsetTop;			
		}
		
		if((ch-y)<300){
			y = y - (ch-y); 
		} 
		
		popWin.showWinIframe("1000","600","fileframe","附件管理","iframe","#",y);
		document.uploadForm.submit();
	}
	
	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
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
        <BZ:input type="hidden" prefix="P_" field="ADDRESS"				id="P_ADDRESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_CN"	id="P_ADOPT_REQUEST_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_EN"	id="P_ADOPT_REQUEST_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FINISH_DATE"			id="P_FINISH_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="HOMESTUDY_ORG_NAME"	id="P_HOMESTUDY_ORG_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="RECOMMENDATION_NUM"	id="P_RECOMMENDATION_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="HEART_REPORT"		id="P_HEART_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_MEDICALRECOVERY"	id="P_IS_MEDICALRECOVERY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEDICALRECOVERY_CN"	id="P_MEDICALRECOVERY_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEDICALRECOVERY_EN"	id="P_MEDICALRECOVERY_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FORMULATE"		id="P_IS_FORMULATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_PREPARE"		id="P_ADOPT_PREPARE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="RISK_AWARENESS"		id="P_RISK_AWARENESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_ABUSE_ABANDON"	id="P_IS_ABUSE_ABANDON" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_SUBMIT_REPORT"	id="P_IS_SUBMIT_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_FLAG" id="P_IS_FAMILY_OTHERS_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_CN" id="P_IS_FAMILY_OTHERS_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_EN" id="P_IS_FAMILY_OTHERS_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_MOTIVATION"	id="P_ADOPT_MOTIVATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_ABOVE"		id="P_CHILDREN_ABOVE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="INTERVIEW_TIMES"		id="P_INTERVIEW_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ACCEPTED_CARD"		id="P_ACCEPTED_CARD" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="PARENTING"			id="P_PARENTING" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SOCIALWORKER"		id="P_SOCIALWORKER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="REMARK_CN"			id="P_REMARK_CN" defaultValue=""/> 
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
		<BZ:input type="hidden" prefix="P_" field="VALID_PERIOD_TYPE" 	id="P_VALID_PERIOD_TYPE" defaultValue=""/> 
		
		<!-- 隐藏区域end -->
		<!--重翻说明:start-->
		<div id="tab-retranslation" style="display:<BZ:dataValue field="TRANSLATION_TYPE" onlyValue="true" checkValue="0=none;1=none;2=block"/>">
			<br>
			<table class="specialtable" align="center" style='width:98%;text-align:center'>
				<tr>
					<td class="edit-data-title" width="15%">通知人</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">通知日期</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">重翻状态</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE"  onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">重翻原因</td>
					<td class="edit-data-value" colspan="5" width="85%"><BZ:dataValue field="AA_CONTENT" defaultValue="" /></td>
				</tr>
			</table>
		</div>
		<!--重翻说明:end-->

        <div id="tab-container" class='tab-container'>
            <ul class='etabs'>
                <li class='tab'><a href="#tab1">基本信息(中文)</a></li>
                <li class='tab'><a href="#tab2">基本信息(外文)</a></li>
            </ul>
			<div class='panel-container'>
            	<!--家庭基本情况(中)：start-->
            	<div id="tab1">
                	<!--文件基本信息：start-->
                    <table class="specialtable">
                        <tr>
                            <td class="edit-data-title" width="15%">收养组织(CN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_CN" defaultValue="" />
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">收养组织(EN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">文件类型</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
                            </td>
                            <td class="edit-data-title" width="15%">收养类型</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
                            </td>
                            <td class="edit-data-title" width="15%">收文编号</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FILE_NO" hrefTitle="收文编号" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                    </table>
                    <!--文件基本信息：end-->
                    <!--双亲收养：start-->
                    <table class="specialtable" id="tb_sqsy_cn">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--收养人信息：start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>                                    	
                                        <td class="edit-data-title" width="15%">&nbsp;</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">男收养人</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">女收养人</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">外文姓名</td>
                                        <td class="edit-data-value" width="27%">
                                            <BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
                                        </td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<up:uploadImage attTypeCode="AF" id="P_MALE_PHOTO" packageId="<%=afId%>" name="P_MALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
											hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" bigType="AF" smallType="<%=AttConstants.AF_MALEPHOTO %>" diskStoreRuleParamValues="<%=strPar%>"/> 
										</td>
                                        <td class="edit-data-value" width="28%">
                                            <BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
                                        </td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<up:uploadImage attTypeCode="AF" id="P_FEMALE_PHOTO" packageId="<%=afId%>" name="P_FEMALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
											hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=AttConstants.AF_FEMALEPHOTO %>" diskStoreRuleParamValues="<%=strPar%>"/> 
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">出生日期</td>
                                        <td class="edit-data-value">
                                            <BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
                                        </td>
                                        <td class="edit-data-value">
                                            <BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue=""  onlyValue="true"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">年龄</td>
                                    	<td class="edit-data-value">
                                    		<div id="tb_sqsy_cn_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge('<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" style="font-size:14px">
                                        	<div id="tb_sqsy_cn_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge('<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">国籍</td>
                                    	<td class="edit-data-value">
                                    		<BZ:select field="MALE_NATION" formTitle="国籍" codeName="GJ" isCode="true" defaultValue="" id="tb_sqsy_cn_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
                                    	</td>
                                    	<td class="edit-data-value">
                                    		<BZ:select field="FEMALE_NATION" formTitle="国籍" codeName="GJ" isCode="true"  defaultValue="" id="tb_sqsy_cn_FEMALE_NATION" onchange="_chgValue(this,0,'FEMALE_NATION')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">护照号码</td>
                                    	<td class="edit-data-value">
                                    		<BZ:input field="MALE_PASSPORT_NO" id="tb_sqsy_cn_MALE_PASSPORT_NO" type="String" formTitle="男收养人护照号码" defaultValue="" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')" size="36"/>
                                    	</td>
                                    	<td class="edit-data-value">
                                    		<BZ:input field="FEMALE_PASSPORT_NO" id="tb_sqsy_cn_FEMALE_PASSPORT_NO" type="String" formTitle="女收养人护照号码" defaultValue="" onchange="_chgValue(this,0,'FEMALE_PASSPORT_NO')" size="36"/>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">受教育程度</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select field="MALE_EDUCATION" formTitle="男收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_cn_MALE_EDUCATION" onchange="_chgValue(this,0,'MALE_EDUCATION')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select field="FEMALE_EDUCATION" formTitle="女收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_cn_FEMALE_EDUCATION" onchange="_chgValue(this,0,'FEMALE_EDUCATION')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">职业</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:input field="MALE_JOB_CN" type="String" formTitle="男收养人职业" defaultValue=""  id="tb_sqsy_cn_MALE_JOB_CN" onchange="_chgValue(this,-1,'MALE_JOB_CN')" size="36"/>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:input field="FEMALE_JOB_CN" type="String" formTitle="女收养人职业" defaultValue="" id="tb_sqsy_cn_FEMALE_JOB_CN" onchange="_chgValue(this,-1,'FEMALE_JOB_CN')" size="36"/>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">健康状况</td>
                                        <td class="edit-data-value" colspan="2">
                                        	<BZ:select width="100px" field="MALE_HEALTH" formTitle="男收养人健康状况" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_cn_MALE_HEALTH" onchange="_chgValue(this,0,'MALE_HEALTH')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
                                        	<textarea style="dispaly:none;height:40px;width: 90%;" name="P_MALE_HEALTH_CONTENT_CN" id="tb_sqsy_cn_MALE_HEALTH_CONTENT_CN" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_CN')"><BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/></textarea>
                                        </td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select width="100px" field="FEMALE_HEALTH" prefix="P_" formTitle="女收养人健康状况"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_cn_FEMALE_HEALTH" onchange="_chgValue(this,0,'FEMALE_HEALTH')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
                                    		<textarea style="dispaly:none;height:40px;width: 90%;" name="P_FEMALE_HEALTH_CONTENT_CN" id="tb_sqsy_cn_FEMALE_HEALTH_CONTENT_CN" onchange="_chgValue(this,-1,'FEMALE_HEALTH_CONTENT_CN')"><BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/></textarea>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">身高</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:select field="MEASUREMENT" id="tb_sqsy_cn_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgValue(this,0,'MEASUREMENT')" width="95px">
                                                <BZ:option value="0">公制</BZ:option>
                                                <BZ:option value="1">英制</BZ:option>
                                            </BZ:select>
                                            <span id="tb_sqsy_cn_MALE_HEIGHT_INCH" style="display: none">
                                                <BZ:input field="MALE_FEET" id="tb_sqsy_cn_MALE_FEET" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'MALE_FEET','1')"/>英尺
                                                <BZ:input field="MALE_INCH" id="tb_sqsy_cn_MALE_INCH" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'MALE_INCH','1')"/>英寸
                                            </span>
                                            <span id="tb_sqsy_cn_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_sqsy_cn_MALE_HEIGHT" formTitle="" defaultValue="" restriction="number" maxlength="" onchange="_chgHeight(this,0,'MALE_HEIGHT','1')"/>厘米</span>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <span id="tb_sqsy_cn_FEMALE_HEIGHT_INCH" style="display: none">
                                                <BZ:input field="FEMALE_FEET" id="tb_sqsy_cn_FEMALE_FEET" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'FEMALE_FEET','2')"/>英尺
                                                <BZ:input field="FEMALE_INCH" id="tb_sqsy_cn_FEMALE_INCH" formTitle="" defaultValue="" restriction="number" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'FEMALE_INCH','2')"/>英寸
                                            </span>
                                            <span id="tb_sqsy_cn_FEMALE_HEIGHT_METRE"><BZ:input field="FEMALE_HEIGHT" id="tb_sqsy_cn_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="number" maxlength="" onchange="_chgHeight(this,0,'FEMALE_HEIGHT','2')"  size="36"/>厘米</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">体重</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_WEIGHT" id="tb_sqsy_cn_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setMaleBMI()" onchange="_chgWeight(this,0,'MALE_WEIGHT','1')" maxlength="50"  size="36"/><span id="tb_sqsy_cn_MALE_WEIGHT_POUNDS" style="display: none">磅</span><span id="tb_sqsy_cn_MALE_WEIGHT_KILOGRAM">千克</span>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_WEIGHT" id="tb_sqsy_cn_FEMALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setFemaleBMI()" onchange="_chgWeight(this,0,'FEMALE_WEIGHT','2')" maxlength="50"  size="36"/><span id="tb_sqsy_cn_FEMALE_WEIGHT_POUNDS" style="display: none">磅</span><span id="tb_sqsy_cn_FEMALE_WEIGHT_KILOGRAM">千克</span>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                    	<td class="edit-data-title">体重指数</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<div id="tb_sqsy_cn_MALE_BMI" style="font-size:14px">&nbsp;</div>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<div id="tb_sqsy_cn_FEMALE_BMI" style="font-size:14px">&nbsp;</div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">违法行为及刑事处罚</td>
                                        <td class="edit-data-value" colspan="2">
                                        	<input type="radio" name="tb_sqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_MALE_PUNISHMENT_FLAG0" value="0" onchange="_chgValue(this,0,'MALE_PUNISHMENT_FLAG')">无
                                            <input type="radio" name="tb_sqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_MALE_PUNISHMENT_FLAG1" value="1" onchange="_chgValue(this,0,'MALE_PUNISHMENT_FLAG')">有
                                            <BZ:input field="MALE_PUNISHMENT_CN" id="tb_sqsy_cn_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_CN')"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                        	<input type="radio" name="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_FLAG')">无
                                            <input type="radio" name="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_FLAG')">有
                                            <BZ:input field="FEMALE_PUNISHMENT_CN" id="tb_sqsy_cn_FEMALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_CN')"/>
                                        </td>
									</tr>
                                    <tr>
                                        <td class="edit-data-title">有无不良嗜好</td>
                                        <td class="edit-data-value" colspan="2">
                                        	<input type="radio" name="tb_sqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,0,'MALE_ILLEGALACT_FLAG')">无
                                            <input type="radio" name="tb_sqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,0,'MALE_ILLEGALACT_FLAG')">有
                                            <BZ:input field="MALE_ILLEGALACT_CN" id="tb_sqsy_cn_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_CN')"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <input type="radio" name="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">无
                                            <input type="radio" name="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">有
                                            <BZ:input field="FEMALE_ILLEGALACT_CN" id="tb_sqsy_cn_FEMALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">宗教信仰</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_RELIGION_CN" id="tb_sqsy_cn_MALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')" size="36"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_RELIGION_CN" id="tb_sqsy_cn_FEMALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'FEMALE_RELIGION_CN')" size="36"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">婚姻状况</td>
                                        <td class="edit-data-value" colspan="4">已婚</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" >结婚日期</td>
                                        <td class="edit-data-value" >
                                            <BZ:input field="MARRY_DATE" id="tb_sqsy_cn_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,0,'MARRY_DATE')"/>
                                        </td>
                                        <td class="edit-data-title"  >婚姻时长（年）</td>
                                        <td class="edit-data-value"  colspan="2">
                                            <div id="tb_sqsy_cn_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">前婚次数</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_MARRY_TIMES" id="tb_sqsy_cn_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'MALE_MARRY_TIMES')" size="36"/>次
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_MARRY_TIMES" id="tb_sqsy_cn_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'FEMALE_MARRY_TIMES')" size="36"/>次
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td class="edit-data-title">货币单位</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:select field="CURRENCY" id="tb_sqsy_cn_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  notnull="" width="245px" onchange="_chgValue(this,0,'CURRENCY')" ></BZ:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">年收入</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_YEAR_INCOME" id="tb_sqsy_cn_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'MALE_YEAR_INCOME')" maxlength="22" size="36"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_YEAR_INCOME" id="tb_sqsy_cn_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'FEMALE_YEAR_INCOME')" maxlength="22" size="36"/>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td class="edit-data-title">家庭总资产</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="TOTAL_ASSET" id="tb_sqsy_cn_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,0,'TOTAL_ASSET')"/>
                                        </td>
                                        <td class="edit-data-title">家庭总债务</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input  field="TOTAL_DEBT" id="tb_sqsy_cn_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,0,'TOTAL_DEBT')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭净资产</td>
                                        <td class="edit-data-value" colspan="4">
                                            <div id="tb_sqsy_cn_TOTAL_MANNY"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">18周岁以下子女数量</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="UNDERAGE_NUM" id="tb_sqsy_cn_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'UNDERAGE_NUM')"/>个
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">子女数量及情况</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="CHILD_CONDITION_CN" id="tb_sqsy_cn_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭住址</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="ADDRESS" id="tb_sqsy_cn_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,0,'ADDRESS')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">收养要求</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="ADOPT_REQUEST_CN" id="tb_sqsy_cn_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_CN')"/>
                                        </td>
                                    </tr>
                                 </table>
                                 <table class="specialtable">    
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">完成家调组织名称</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="HOMESTUDY_ORG_NAME" id="tb_sqsy_cn_HOMESTUDY_ORG_NAME" formTitle="" defaultValue="" maxlength="200" style="width:80%"  onchange="_chgValue(this,0,'HOMESTUDY_ORG_NAME')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭报告完成日期</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="FINISH_DATE" id="tb_sqsy_cn_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,0,'FINISH_DATE')"/>
                                        </td>
                                        <td class="edit-data-title">会见次数（次）</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="INTERVIEW_TIMES" id="tb_sqsy_cn_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'INTERVIEW_TIMES')"/>
                                        </td>                                    
                                        <td class="edit-data-title">推荐信（封）</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="RECOMMENDATION_NUM" id="tb_sqsy_cn_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'RECOMMENDATION_NUM')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">心理评估报告</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="HEART_REPORT" id="tb_sqsy_cn_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT"  notnull="" width="70%" onchange="_chgValue(this,0,'HEART_REPORT')">
                                                <BZ:option value="">--请选择--</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">收养动机</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="ADOPT_MOTIVATION" id="tb_sqsy_cn_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,0,'ADOPT_MOTIVATION')">
                                                <BZ:option value="">--请选择--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    
                                        <td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_ABOVE" id="tb_sqsy_cn_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,0,'CHILDREN_ABOVE')">
                                                <BZ:option value="">--请选择--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">有无指定监护人</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_FORMULATE" id="tb_sqsy_cn_IS_FORMULATE0" value="0" onchange="_chgRadio(this,0,'IS_FORMULATE')">无
                                            <input type="radio" name="tb_sqsy_cn_IS_FORMULATE" id="tb_sqsy_cn_IS_FORMULATE1" value="1" onchange="_chgRadio(this,0,'IS_FORMULATE')">有
                                        </td>
                                        <td class="edit-data-title">不遗弃不虐待声明</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_ABUSE_ABANDON" id="tb_sqsy_cn_IS_ABUSE_ABANDON0" value="0" onchange="_chgRadio(this,0,'IS_ABUSE_ABANDON')">无
                                            <input type="radio" name="tb_sqsy_cn_IS_ABUSE_ABANDON" id="tb_sqsy_cn_IS_ABUSE_ABANDON1" value="1" onchange="_chgRadio(this,0,'IS_ABUSE_ABANDON')">有
                                        </td>
                                    
                                        <td class="edit-data-title">抚育计划</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_MEDICALRECOVERY" id="tb_sqsy_cn_IS_MEDICALRECOVERY0" value="0" onchange="_chgRadio(this,0,'IS_MEDICALRECOVERY')">无
                                            <input type="radio" name="tb_sqsy_cn_IS_MEDICALRECOVERY" id="tb_sqsy_cn_IS_MEDICALRECOVERY1" value="1" onchange="_chgRadio(this,0,'IS_MEDICALRECOVERY')">有
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">收养前准备</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_ADOPT_PREPARE" id="tb_sqsy_cn_ADOPT_PREPARE0" value="0" onchange="_chgRadio(this,0,'ADOPT_PREPARE')">无
                                            <input type="radio" name="tb_sqsy_cn_ADOPT_PREPARE" id="tb_sqsy_cn_ADOPT_PREPARE1" value="1" onchange="_chgRadio(this,0,'ADOPT_PREPARE')">有
                                        </td>
                                        <td class="edit-data-title">风险意识</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_RISK_AWARENESS" id="tb_sqsy_cn_RISK_AWARENESS0" value="0" onchange="_chgRadio(this,0,'RISK_AWARENESS')">无
                                            <input type="radio" name="tb_sqsy_cn_RISK_AWARENESS" id="tb_sqsy_cn_RISK_AWARENESS1" value="1" onchange="_chgRadio(this,0,'RISK_AWARENESS')">有
                                        </td>
                                   
                                        <td class="edit-data-title">同意递交安置后报告声明</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_SUBMIT_REPORT" id="tb_sqsy_cn_IS_SUBMIT_REPORT0" value="0" onchange="_chgRadio(this,0,'IS_SUBMIT_REPORT')">无
                                            <input type="radio" name="tb_sqsy_cn_IS_SUBMIT_REPORT" id="tb_sqsy_cn_IS_SUBMIT_REPORT1" value="1" onchange="_chgRadio(this,0,'IS_SUBMIT_REPORT')">有
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">育儿经验</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_PARENTING" id="tb_sqsy_cn_PARENTING0" value="0" onchange="_chgRadio(this,0,'PARENTING')">无
                                            <input type="radio" name="tb_sqsy_cn_PARENTING" id="tb_sqsy_cn_PARENTING1" value="1" onchange="_chgRadio(this,0,'PARENTING')">有
                                        </td>
                                        <td class="edit-data-title">社工意见</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="SOCIALWORKER" id="tb_sqsy_cn_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,0,'SOCIALWORKER')" >
                                                <BZ:option value="">--请选择--</BZ:option>
                                                <BZ:option value="1">支持</BZ:option>
                                                <BZ:option value="2">保留意见</BZ:option>
                                                <BZ:option value="3">不支持</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家中有无其他人同住</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG0" value="0" onchange="_chgRadio(this,0,'IS_FAMILY_OTHERS_FLAG')">无
                                            <input type="radio" name="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG1" value="1" onchange="_chgRadio(this,0,'IS_FAMILY_OTHERS_FLAG')">有
                                        </td>
                                        <td class="edit-data-title">家中其他人同住说明</td>
                                        <td class="edit-data-value" colspan="3">
                                            <BZ:input field="IS_FAMILY_OTHERS_CN" id="tb_sqsy_cn_IS_FAMILY_OTHERS_CN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭需说明的其他事项</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="REMARK_CN" id="tb_sqsy_cn_REMARK_CN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'REMARK_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>政府批准信息</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">批准日期</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="GOVERN_DATE" id="tb_sqsy_cn_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
                                        </td>
                                        <td class="edit-data-title">有效期限</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="VALID_PERIOD_TYPE" id="tb_sqsy_cn_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_setValidPeriod(this,0,'VALID_PERIOD_TYPE')">
                                                <BZ:option value="1">有效期限</BZ:option>
                                                <BZ:option value="2">长期</BZ:option>
                                            </BZ:select>
											<span id="tb_sqsy_cn_VALID_PERIOD0" style="display: none">
                                            <BZ:input field="VALID_PERIOD" id="tb_sqsy_cn_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>月
											</span>
                                        </td>
                                        <td class="edit-data-title">批准儿童数量</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="APPROVE_CHILD_NUM" id="tb_sqsy_cn_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'APPROVE_CHILD_NUM')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">收养儿童年龄</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="AGE_FLOOR" id="tb_sqsy_cn_AGE_FLOOR" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_FLOOR')"/>岁~
                                            <BZ:input field="AGE_UPPER" id="tb_sqsy_cn_AGE_UPPER" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_UPPER')"/>岁
                                        </td>
                                        <td class="edit-data-title">收养儿童性别</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_SEX" id="tb_sqsy_cn_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,0,'CHILDREN_SEX')">
                                                <BZ:option value="">--请选择--</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">收养儿童健康状况</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_HEALTH_EN" id="tb_sqsy_cn_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%"  onchange="_chgValue(this,0,'CHILDREN_HEALTH_EN')">
                                                <BZ:option value="">--请选择--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    </tr>
									<tr>
										<td class="edit-data-title" colspan="1" style="text-align:center"></td>
										<td class="edit-data-title" colspan="4" style="text-align:center">
										<b>附件信息</b></td>
										<td class="edit-data-title" colspan="1" style="text-align:center">
										<input type="button" value="附件上传" onclick="_toipload('0',this)" />
										</td>
                                    </tr>
									<tr>
										<td colspan="6">
										<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
									
                                </table>                                 
                            </td>
                        </tr> 
                    <!--双亲收养：end--> 
                    </table>                                         
                </div>
                <!--家庭基本情况(中)：end-->
                <!--家庭基本情况(外)：start-->
                <div id="tab2">
					<!--文件基本信息：start-->
					<table class="specialtable">
						<tr>
							<td class="edit-data-title" width="15%">收养组织(CN)</td>
							<td class="edit-data-value" colspan="5">
								<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">收养组织(EN)</td>
							<td class="edit-data-value" colspan="5">
								<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">文件类型</td>
							<td class="edit-data-value" width="18%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="edit-data-title" width="15%">收养类型</td>
							<td class="edit-data-value" width="18%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="edit-data-title" width="15%">收文编号</td>
							<td class="edit-data-value" width="18%">
								<BZ:dataValue field="FILE_NO" hrefTitle="收文编号" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
					<!--文件基本信息：end-->
					<!--双亲收养：start-->                            	  
					<table class="specialtable"  id="tb_sqsy_en" style="display:block">
						<tr>
							 <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
						</tr>
						<tr>
							<td>
								<table class="specialtable">
									<tr>                                    	
										<td class="edit-data-title" width="15%">&nbsp;</td>
										<td class="edit-data-title" colspan="2" style="text-align:center">男收养人</td>
										<td class="edit-data-title" colspan="2" style="text-align:center">女收养人</td>
									</tr>
									<tr>
										<td class="edit-data-title" width="15%">外文姓名</td>
										<td class="edit-data-value" width="27%">
											<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
										</td>
										<td class="edit-data-value" width="15%" rowspan="5">
											照片<br>(请在中文基本信息页面进行照片的维护)
										</td>
										<td class="edit-data-value" width="28%">
											<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
										</td>
										<td class="edit-data-value" width="15%" rowspan="5">
											照片<br>(请在中文基本信息页面进行照片的维护)
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">出生日期</td>
										<td class="edit-data-value">
											<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
										</td>
										<td class="edit-data-value">
											<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">年龄</td>
										<td class="edit-data-value">
											<div id="tb_sqsy_en_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge('<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>'));
											</script>
											</div>
										</td>
										<td class="edit-data-value" style="font-size:14px">
											<div id="tb_sqsy_en_FEMALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge(<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>));
											</script>
											</div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">国籍</td>
										<td class="edit-data-value">
											<BZ:select field="MALE_NATION" formTitle="国籍" codeName="GJ" isCode="true" defaultValue=""  id="tb_sqsy_en_MALE_NATION" onchange="_chgValue(this,1,'MALE_NATION')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="FEMALE_NATION" formTitle="国籍" codeName="GJ" isCode="true"  defaultValue="" id="tb_sqsy_en_FEMALE_NATION" onchange="_chgValue(this,1,'FEMALE_NATION')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">护照号码</td>
										<td class="edit-data-value">
											<BZ:input field="MALE_PASSPORT_NO" id="tb_sqsy_en_MALE_PASSPORT_NO" type="String" formTitle="男收养人护照号码" defaultValue="" onchange="_chgValue(this,1,'MALE_PASSPORT_NO')" size="36"/>
										</td>
										<td class="edit-data-value">
											<BZ:input field="FEMALE_PASSPORT_NO" id="tb_sqsy_en_FEMALE_PASSPORT_NO" type="String" formTitle="女收养人护照号码" defaultValue="" onchange="_chgValue(this,1,'FEMALE_PASSPORT_NO')" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">受教育程度</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="MALE_EDUCATION" formTitle="男收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_en_MALE_EDUCATION" onchange="_chgValue(this,1,'MALE_EDUCATION')"  width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="FEMALE_EDUCATION" formTitle="女收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_en_FEMALE_EDUCATION" onchange="_chgValue(this,1,'FEMALE_EDUCATION')"  width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">职业</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_JOB_EN" type="String" formTitle="男收养人职业" defaultValue=""  id="tb_sqsy_en_MALE_JOB_EN" onchange="_chgValue(this,-1,'MALE_JOB_EN')" size="36"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_JOB_EN" prefix="P_" type="String" formTitle="女收养人职业" defaultValue="" id="tb_sqsy_en_FEMALE_JOB_EN" onchange="_chgValue(this,-1,'FEMALE_JOB_EN')" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">健康状况</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="MALE_HEALTH" prefix="P_" formTitle="男收养人健康状况" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_en_MALE_HEALTH" onchange="_chgValue(this,1,'MALE_HEALTH')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
											<textarea style="dispaly:none;height: 40px;width: 90%;" name="P_MALE_HEALTH_CONTENT_EN" id="tb_sqsy_en_MALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_EN')"><BZ:dataValue field="MALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/></textarea>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="FEMALE_HEALTH" prefix="P_" formTitle="女收养人健康状况"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_en_FEMALE_HEALTH" onchange="_chgValue(this,1,'FEMALE_HEALTH')" width="245px">
											<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
											<textarea style="dispaly:none;height: 40px;width: 90%;" name="P_FEMALE_HEALTH_CONTENT_EN" id="tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'FEMALE_HEALTH_CONTENT_EN')"><BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/></textarea>
										</td>
									</tr>
									 <tr>
										<td class="edit-data-title">身高</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="MEASUREMENT" id="tb_sqsy_en_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgValue(this,1,'MEASUREMENT')">
												<BZ:option value="0">公制</BZ:option>
												<BZ:option value="1">英制</BZ:option>
											</BZ:select>
											<span id="tb_sqsy_en_MALE_HEIGHT_INCH" style="display: none">
												<BZ:input field="MALE_FEET" id="tb_sqsy_en_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'MALE_FEET','1')"/>英尺
												<BZ:input field="MALE_INCH" id="tb_sqsy_en_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'MALE_INCH','1')"/>英寸
											</span>
											<span id="tb_sqsy_en_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_sqsy_en_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" onchange="_chgHeight(this,1,'MALE_HEIGHT','1')"/>厘米</span>
										</td>
										<td class="edit-data-value" colspan="2">
											<span id="tb_sqsy_en_FEMALE_HEIGHT_INCH" style="display: none">
												<BZ:input field="FEMALE_FEET" id="tb_sqsy_en_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'FEMALE_FEET','2')"/>英尺
												<BZ:input field="FEMALE_INCH" id="tb_sqsy_en_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'FEMALE_INCH','2')"/>英寸
											</span>
											<span id="tb_sqsy_en_FEMALE_HEIGHT_METRE"><BZ:input field="FEMALE_HEIGHT" id="tb_sqsy_en_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" onchange="_chgHeight(this,1,'FEMALE_HEIGHT','2')"/>厘米</span>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">体重</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_WEIGHT" id="tb_sqsy_en_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number"  onchange="_chgWeight(this,1,'MALE_WEIGHT','1')" maxlength="50" size="36"/><span id="tb_sqsy_en_MALE_WEIGHT_POUNDS" style="display: none">磅</span><span id="tb_sqsy_en_MALE_WEIGHT_KILOGRAM">千克(Kilogram)</span>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_WEIGHT" id="tb_sqsy_en_FEMALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onchange="_chgWeight(this,1,'FEMALE_WEIGHT','2')" maxlength="50" size="36"/><span id="tb_sqsy_en_FEMALE_WEIGHT_POUNDS" style="display: none">磅</span><span id="tb_sqsy_en_FEMALE_WEIGHT_KILOGRAM">千克(Kilogram)</span>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">体重指数</td>
										<td class="edit-data-value" colspan="2">
											<div id="tb_sqsy_en_MALE_BMI" style="font-size:14px">&nbsp;</div>
										</td>
										<td class="edit-data-value" colspan="2">
											<div id="tb_sqsy_en_FEMALE_BMI" style="font-size:14px">&nbsp;</div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">违法行为及刑事处罚</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG0" value="0">无
											<input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG1" value="1">有
											<BZ:input field="MALE_PUNISHMENT_EN" id="tb_sqsy_en_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_EN')"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0" value="0">无
											<input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1" value="1">有
											<BZ:input field="FEMALE_PUNISHMENT_EN" id="tb_sqsy_en_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">有无不良嗜好</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">无
											<input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">有
											<BZ:input field="MALE_ILLEGALACT_EN" id="tb_sqsy_en_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_EN')"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">无
											<input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">有
											<BZ:input field="FEMALE_ILLEGALACT_EN" id="tb_sqsy_en_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">宗教信仰</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_RELIGION_EN" id="tb_sqsy_en_MALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'MALE_RELIGION_EN')" size="36"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_RELIGION_EN" id="tb_sqsy_en_FEMALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'FEMALE_RELIGION_EN')" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title" >婚姻状况</td>
										<td class="edit-data-value" colspan="4">已婚</td>
									</tr>
										<td class="edit-data-title" >结婚日期</td>
										<td class="edit-data-value">
											<BZ:input field="MARRY_DATE" id="tb_sqsy_en_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,1,'MARRY_DATE')"/>
										</td>
										<td class="edit-data-title" >婚姻时长（年）</td>
										<td class="edit-data-value" colspan="2">
											<div id="tb_sqsy_en_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">前婚次数</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_MARRY_TIMES" id="tb_sqsy_en_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'MALE_MARRY_TIMES')" size="36"/>次
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_MARRY_TIMES" id="tb_sqsy_en_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'FEMALE_MARRY_TIMES')" size="36"/>次
										</td>
									</tr> 
									
									<tr>
										<td class="edit-data-title">货币单位</td>
										<td class="edit-data-value" colspan="4">
											<BZ:select field="CURRENCY" id="tb_sqsy_en_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ" notnull="" width="170px" onchange="_chgValue(this,1,'CURRENCY')" width="245px"></BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">年收入</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_YEAR_INCOME" id="tb_sqsy_en_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'MALE_YEAR_INCOME')" maxlength="22" size="36"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_YEAR_INCOME" id="tb_sqsy_en_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'FEMALE_YEAR_INCOME')" maxlength="22" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">家庭总资产</td>
										<td class="edit-data-value">
											<BZ:input field="TOTAL_ASSET" id="tb_sqsy_en_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,1,'TOTAL_ASSET')"/>
										</td>
									
										<td class="edit-data-title">家庭总债务</td>
										<td class="edit-data-value"  colspan="2">
											<BZ:input  field="TOTAL_DEBT" id="tb_sqsy_en_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,1,'TOTAL_DEBT')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">家庭净资产</td>
										<td class="edit-data-value" colspan="4">
											<div id="tb_sqsy_en_TOTAL_MANNY"></div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">18周岁以下子女数量</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="UNDERAGE_NUM" id="tb_sqsy_en_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'UNDERAGE_NUM')"/>个
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">子女数量及情况</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="CHILD_CONDITION_EN" id="tb_sqsy_en_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">家庭住址</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="ADDRESS" id="tb_sqsy_en_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,1,'ADDRESS')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title" width="15%">收养要求</td>
										<td class="edit-data-value" colspan="4">
											<BZ:input field="ADOPT_REQUEST_EN" id="tb_sqsy_en_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_EN')"/>
										</td>
									</tr>
								</table>
								<table class="specialtable">
									<tr>
										<td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
									</tr>
									<tr>
										<td class="edit-data-title">完成家调组织名称</td>
										<td class="edit-data-value" colspan="5">
											<BZ:input field="HOMESTUDY_ORG_NAME" id="tb_sqsy_en_HOMESTUDY_ORG_NAME" formTitle="" defaultValue="" style="width:80%" onchange="_chgValue(this,1,'HOMESTUDY_ORG_NAME')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">家庭报告完成日期</td>
										<td class="edit-data-value">
											<BZ:input field="FINISH_DATE" id="tb_sqsy_en_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,1,'FINISH_DATE')"/>
										</td>
										<td class="edit-data-title">会见次数（次）</td>
										<td class="edit-data-value">
											<BZ:input field="INTERVIEW_TIMES" id="tb_sqsy_en_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,1,'INTERVIEW_TIMES')"/>
										</td>
										<td class="edit-data-title">推荐信（封）</td>
										<td class="edit-data-value">
											<BZ:input field="RECOMMENDATION_NUM" id="tb_sqsy_en_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,1,'RECOMMENDATION_NUM')"/></td>
									</tr>
									<tr>
										<td class="edit-data-title">心理评估报告</td>
										<td class="edit-data-value">
											<BZ:select field="HEART_REPORT" id="tb_sqsy_en_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT" notnull="" width="70%" onchange="_chgValue(this,1,'HEART_REPORT')">
												<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-title">收养动机</td>
										<td class="edit-data-value">
											<BZ:select field="ADOPT_MOTIVATION" id="tb_sqsy_en_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,1,'ADOPT_MOTIVATION')">
												<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
										<td class="edit-data-value">
											<BZ:select field="CHILDREN_ABOVE" id="tb_sqsy_en_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,1,'CHILDREN_ABOVE')">
												<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
									</tr>
									<tr>                                        
										<td class="edit-data-title">有无指定监护人</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_IS_FORMULATE" id="tb_sqsy_en_IS_FORMULATE0" value="0" onchange="_chgRadio(this,1,'IS_FORMULATE')">无
											<input type="radio" name="tb_sqsy_en_IS_FORMULATE" id="tb_sqsy_en_IS_FORMULATE1" value="1" onchange="_chgRadio(this,1,'IS_FORMULATE')">有
										</td>
										<td class="edit-data-title">不遗弃不虐待声明</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_IS_ABUSE_ABANDON" id="tb_sqsy_en_IS_ABUSE_ABANDON0" value="0" onchange="_chgRadio(this,1,'IS_ABUSE_ABANDON')">无
											<input type="radio" name="tb_sqsy_en_IS_ABUSE_ABANDON" id="tb_sqsy_en_IS_ABUSE_ABANDON1" value="1" onchange="_chgRadio(this,1,'IS_ABUSE_ABANDON')">有
										</td>                                    
										<td class="edit-data-title">抚育计划</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_IS_MEDICALRECOVERY" id="tb_sqsy_en_IS_MEDICALRECOVERY0" value="0" onchange="_chgRadio(this,1,'IS_MEDICALRECOVERY')">无
											<input type="radio" name="tb_sqsy_en_IS_MEDICALRECOVERY" id="tb_sqsy_en_IS_MEDICALRECOVERY1" value="1" onchange="_chgRadio(this,1,'IS_MEDICALRECOVERY')">有
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">收养前准备</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_ADOPT_PREPARE" id="tb_sqsy_en_ADOPT_PREPARE0" value="0" onchange="_chgRadio(this,1,'ADOPT_PREPARE')">无
											<input type="radio" name="tb_sqsy_en_ADOPT_PREPARE" id="tb_sqsy_en_ADOPT_PREPARE1" value="1" onchange="_chgRadio(this,1,'ADOPT_PREPARE')">有
										</td>
										<td class="edit-data-title">风险意识</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_RISK_AWARENESS" id="tb_sqsy_en_RISK_AWARENESS0" value="0" onchange="_chgRadio(this,1,'RISK_AWARENESS')">无
											<input type="radio" name="tb_sqsy_en_RISK_AWARENESS" id="tb_sqsy_en_RISK_AWARENESS1" value="1" onchange="_chgRadio(this,1,'RISK_AWARENESS')">有
										</td>                                    
										<td class="edit-data-title">同意递交安置后报告声明</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_IS_SUBMIT_REPORT" id="tb_sqsy_en_IS_SUBMIT_REPORT0" value="0" onchange="_chgRadio(this,1,'IS_SUBMIT_REPORT')">无
											<input type="radio" name="tb_sqsy_en_IS_SUBMIT_REPORT" id="tb_sqsy_en_IS_SUBMIT_REPORT1" value="1" onchange="_chgRadio(this,1,'IS_SUBMIT_REPORT')">有
										</td>
									</tr>
									
									<tr>
										<td class="edit-data-title">育儿经验</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_PARENTING" id="tb_sqsy_en_PARENTING0" value="0" onchange="_chgRadio(this,1,'PARENTING')">无
											<input type="radio" name="tb_sqsy_en_PARENTING" id="tb_sqsy_en_PARENTING1" value="1" onchange="_chgRadio(this,1,'PARENTING')">有
										</td>
										<td class="edit-data-title">社工意见</td>
										<td class="edit-data-value">
											<BZ:select field="SOCIALWORKER" id="tb_sqsy_en_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,1,'SOCIALWORKER')" >
												<BZ:option value="">--请选择--</BZ:option>
												<BZ:option value="1">支持</BZ:option>
												<BZ:option value="2">保留意见</BZ:option>
												<BZ:option value="3">不支持</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-title">&nbsp;</td>
										<td class="edit-data-value">&nbsp;</td>
									</tr>
									<tr>
										<td class="edit-data-title">家中有无其他人同住</td>
										<td class="edit-data-value">
											<input type="radio" name="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG0" value="0" onchange="_chgRadio(this,1,'IS_FAMILY_OTHERS_FLAG')">无
											<input type="radio" name="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG1" value="1" onchange="_chgRadio(this,1,'IS_FAMILY_OTHERS_FLAG')">有
										</td>
										<td class="edit-data-title">家中其他人同住说明</td>
										<td class="edit-data-value" colspan="3">
											<BZ:input field="IS_FAMILY_OTHERS_EN" id="tb_sqsy_en_IS_FAMILY_OTHERS_EN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">家庭需说明的其他事项</td>
										<td class="edit-data-value" colspan="5">
											<BZ:input field="REMARK_EN" id="tb_sqsy_en_REMARK_EN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'REMARK_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title" colspan="6" style="text-align:center"><b>政府批准信息</b></td>
									</tr>
									<tr>
										<td class="edit-data-title">批准日期</td>
										<td class="edit-data-value">
											<BZ:input field="GOVERN_DATE" id="tb_sqsy_en_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,1,'GOVERN_DATE')"/>
										</td>
										

										<td class="edit-data-title">有效期限</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="VALID_PERIOD_TYPE" id="tb_sqsy_en_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_setValidPeriod(this,1,'VALID_PERIOD_TYPE')">
                                                <BZ:option value="1">有效期限</BZ:option>
                                                <BZ:option value="2">长期</BZ:option>
                                            </BZ:select>
											<span id="tb_sqsy_en_VALID_PERIOD0" style="display: none">
                                            <BZ:input field="VALID_PERIOD" id="tb_sqsy_en_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,1,'VALID_PERIOD')"/>月
											</span>
                                        </td>
										<td class="edit-data-title">批准儿童数量</td>
										<td class="edit-data-value" width="19%">
											<BZ:input field="APPROVE_CHILD_NUM" id="tb_sqsy_en_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'APPROVE_CHILD_NUM')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">收养儿童年龄</td>
										<td class="edit-data-value">
											<BZ:input field="AGE_FLOOR" id="tb_sqsy_en_AGE_FLOOR" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,1,'AGE_FLOOR')"/>岁~
											<BZ:input field="AGE_UPPER" id="tb_sqsy_en_AGE_UPPER" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,1,'AGE_UPPER')"/>岁
										</td>
										<td class="edit-data-title">收养儿童性别</td>
										<td class="edit-data-value">
											<BZ:select field="CHILDREN_SEX" id="tb_sqsy_en_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,1,'CHILDREN_SEX')">
												<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-title">收养儿童健康状况</td>
										<td class="edit-data-value" width="19%">
											<BZ:select field="CHILDREN_HEALTH_EN" id="tb_sqsy_en_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%" onchange="_chgValue(this,1,'CHILDREN_HEALTH_EN')">
												<BZ:option value="">--请选择--</BZ:option>
											</BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title" colspan="1" style="text-align:center"></td>
										<td class="edit-data-title" colspan="4" style="text-align:center">
										<b>附件信息</b></td>
										<td class="edit-data-title" colspan="1" style="text-align:center">
										<input type="button" value="附件上传" onclick="_toipload('1',this)" />
										</td>
                                    </tr>
									<tr>
										<td colspan="6">
										<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
                                </table>                                
                            </td>
                        </tr>
					</table>     	
                </div>
                <!--家庭基本情况(外)：end-->                                
			</div>
		</div>
		<!--翻译信息：start-->
		<div id="tab-translation">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="edit-data-title" colspan="2" style="text-align:center"><b>翻译信息</b></td>
                </tr>
                <tr>
					<td  class="edit-data-title" width="15%">翻译说明</td>
					<td  class="edit-data-value">
					<BZ:input prefix="R_" field="TRANSLATION_DESC" id="R_TRANSLATION_DESC" type="textarea" formTitle="翻译说明" defaultValue="" maxlength="500" style="width:80%"/>
					</td>
				</tr>
			</table>
		</div>
		<!--翻译信息：end-->
		<br>
		<!-- 按钮区域:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="保&nbsp;&nbsp;存" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;
				<input type="button" value="提&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
				<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域:end -->
	</BZ:form>
	<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--附件使用：start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=uploadParameter%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='org_id=<BZ:dataValue field="ADOPT_ORG_ID" onlyValue="true"/>,af_id=<BZ:dataValue field="AF_ID" onlyValue="true"/>'/>
		
		<!--附件使用：end-->
	</form>
	</BZ:body>
</BZ:html>
