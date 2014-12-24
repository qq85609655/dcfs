<%
/**   
 * @Title: apply_translation_doubletran.jsp
 * @Description:  双亲收养文件翻译页
 * @author panfeng   
 * @date 2014-10-10 下午1:29:03 
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

	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
%>
<BZ:html>
<script type="text/javascript" src="<%=path%>/resource/js/common.js"/>

<BZ:head>
	<up:uploadResource isImage="true"/>
    <title>文件翻译页（双亲）</title>
    <BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//男收养人的健康状况
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//女收养人的健康状况
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人违法行为及刑事处罚
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人违法行为及刑事处罚
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人有无不良嗜好
		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人有无不良嗜好
		var MARRY_DATE = "<BZ:dataValue type="String" field="MARRY_DATE" defaultValue="" onlyValue="true"/>";			//结婚日期
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//家庭总资产
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";			//家庭总债务
		
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		    $('#tab-container').easytabs();
			//初始化健康状况说明的显示与隐藏
			_setMale_health(male_health);
			_setFemale_health(female_health);
			
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
		

	//设置违法行为及刑事处罚（男）
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
	
	//设置违法行为及刑事处罚（女）
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
	
	//设置有无不良嗜好（男）
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
	
	//设置有无不良嗜好（女）
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
	if (_check(document.srcForm)) {
		document.getElementById("R_TRANSLATION_STATE").value = "1";
		document.srcForm.action = path + "/sce/translation/save.action";
		
		document.srcForm.submit();
	  }
	}
	//翻译完成提交
	function _submit() {
	if (_check(document.srcForm)) {
		document.getElementById("R_TRANSLATION_STATE").value = "2";
		document.srcForm.action = path + "/sce/translation/save.action";
		document.srcForm.submit();
	  }
	}
	//返回列表
	function _goback(){
		document.srcForm.action = path + "/sce/translation/applyTranslationList.action";
		document.srcForm.submit();
	}

	
	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
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
        <BZ:input type="hidden" prefix="P_" field="ADDRESS"				id="P_ADDRESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_CN"	id="P_ADOPT_REQUEST_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_EN"	id="P_ADOPT_REQUEST_EN" defaultValue=""/> 
		
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
                                <BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">收养组织(EN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
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
                                            <input type="text" id="tb_sqsy_cn_MALE_NAME" value="<BZ:dataValue field="MALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,0,'MALE_NAME')" maxlength="150" size="30">
                                        </td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<up:uploadImage attTypeCode="AF" id="P_MALE_PHOTO" packageId="<%=afId%>" name="P_MALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
											hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=AttConstants.AF_MALEPHOTO %>" diskStoreRuleParamValues="<%=strPar%>"/> 
										</td>
                                        <td class="edit-data-value" width="28%">
                                            <input type="text" id="tb_sqsy_cn_FEMALE_NAME" value="<BZ:dataValue field="FEMALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,0,'FEMALE_NAME')" maxlength="150" size="30">
                                        </td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<up:uploadImage attTypeCode="AF" id="P_FEMALE_PHOTO" packageId="<%=afId%>" name="P_FEMALE_PHOTO" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
											hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=AttConstants.AF_FEMALEPHOTO %>" diskStoreRuleParamValues="<%=strPar%>"/> 
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">出生日期</td>
                                        <td class="edit-data-value">
                                            <input onclick="error_onclick(this);"  style="width:238px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="男收养人出生日期"  id="tb_sqsy_cn_MALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,0,'MALE_BIRTHDAY','1')"/>
                                        </td>
                                        <td class="edit-data-value">
                                            <input onclick="error_onclick(this);"  style="width:238px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="女收养人出生日期"  id="tb_sqsy_cn_FEMALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,0,'FEMALE_BIRTHDAY','2')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">年龄</td>
                                    	<td class="edit-data-value">
                                    		<div id="tb_sqsy_cn_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge($("#tb_sqsy_cn_MALE_BIRTHDAY").val()));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" style="font-size:14px">
                                        	<div id="tb_sqsy_cn_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge($("#tb_sqsy_cn_FEMALE_BIRTHDAY").val()));
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
                                        <td class="edit-data-title">前婚次数</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_MARRY_TIMES" id="tb_sqsy_cn_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'MALE_MARRY_TIMES')" size="36"/>次
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_MARRY_TIMES" id="tb_sqsy_cn_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'FEMALE_MARRY_TIMES')" size="36"/>次
                                        </td>
                                    </tr>                                                                       
                                </table>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" width="15%">婚姻状况</td>
                                        <td class="edit-data-value" width="18%">已婚</td>
                                        <td class="edit-data-title" width="15%">结婚日期</td>
                                        <td class="edit-data-value" width="18%">
                                            <BZ:input field="MARRY_DATE" id="tb_sqsy_cn_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,0,'MARRY_DATE')"/>
                                        </td>
                                        <td class="edit-data-title" width="15%">婚姻时长（年）</td>
                                        <td class="edit-data-value" width="19%">
                                            <div id="tb_sqsy_cn_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭总资产</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="TOTAL_ASSET" id="tb_sqsy_cn_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,0,'TOTAL_ASSET')"/>
                                        </td>
                                        <td class="edit-data-title">家庭总债务</td>
                                        <td class="edit-data-value">
                                            <BZ:input  field="TOTAL_DEBT" id="tb_sqsy_cn_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,0,'TOTAL_DEBT')"/>
                                        </td>
                                        <td class="edit-data-title">家庭净资产</td>
                                        <td class="edit-data-value">
                                            <div id="tb_sqsy_cn_TOTAL_MANNY"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">18周岁以下子女数量</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="UNDERAGE_NUM" id="tb_sqsy_cn_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'UNDERAGE_NUM')"/>个
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">子女数量及情况</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="CHILD_CONDITION_CN" id="tb_sqsy_cn_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭住址</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="ADDRESS" id="tb_sqsy_cn_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,0,'ADDRESS')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">收养要求</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="ADOPT_REQUEST_CN" id="tb_sqsy_cn_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_CN')"/>
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
							<td class="edit-data-title" width="15%">Agency(CN)</td>
							<td class="edit-data-value" colspan="5">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="Agency(CN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">Agency(EN)</td>
							<td class="edit-data-value" colspan="5">
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="Agency(EN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
					<!--文件基本信息：end-->
					<!--双亲收养：start-->                            	  
					<table class="specialtable"  id="tb_sqsy_en" style="display:block">
						<tr>
							 <td class="edit-data-title" style="text-align:center"><b>Information about the adoptive parents</b></td>
						</tr>
						<tr>
							<td>
								<table class="specialtable">
									<tr>                                    	
										<td class="edit-data-title" width="15%">&nbsp;</td>
										<td class="edit-data-title" colspan="2" style="text-align:center">Adoptive father</td>
										<td class="edit-data-title" colspan="2" style="text-align:center">Adoptive mother</td>
									</tr>
									<tr>
										<td class="edit-data-title" width="15%">Name</td>
										<td class="edit-data-value" width="27%">
											<input type="text" id="tb_sqsy_en_MALE_NAME" value="<BZ:dataValue field="MALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,1,'MALE_NAME')" maxlength="150" size="30">
										</td>
										<td class="edit-data-value" width="15%" rowspan="5">
											照片<br>(请在中文基本信息页面进行照片的维护)
										</td>
										<td class="edit-data-value" width="28%">
											<input type="text" id="tb_sqsy_en_FEMALE_NAME" value="<BZ:dataValue field="FEMALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,1,'FEMALE_NAME')" maxlength="150" size="30">
										</td>
										<td class="edit-data-value" width="15%" rowspan="5">
											照片<br>(请在中文基本信息页面进行照片的维护)
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">D.O.B</td>
										<td class="edit-data-value">
											<input onclick="error_onclick(this);"  style="width:238px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="男收养人出生日期"  id="tb_sqsy_en_MALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,1,'MALE_BIRTHDAY','1')"/>
										</td>
										<td class="edit-data-value">
											<input onclick="error_onclick(this);"  style="width:238px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="女收养人出生日期"  id="tb_sqsy_en_FEMALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,1,'FEMALE_BIRTHDAY','2')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Age</td>
										<td class="edit-data-value">
											<div id="tb_sqsy_en_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge($("#tb_sqsy_en_MALE_BIRTHDAY").val()));
											</script>
											</div>
										</td>
										<td class="edit-data-value" style="font-size:14px">
											<div id="tb_sqsy_en_FEMALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge($("#tb_sqsy_en_FEMALE_BIRTHDAY").val()));
											</script>
											</div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Nationality</td>
										<td class="edit-data-value">
											<BZ:select field="MALE_NATION" formTitle="Nationality" codeName="GJ" isCode="true" isShowEN="true" defaultValue="" id="tb_sqsy_en_MALE_NATION" onchange="_chgValue(this,1,'MALE_NATION')" width="245px">
											<BZ:option value="">--Please select--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="FEMALE_NATION" formTitle="Nationality" codeName="GJ" isCode="true" isShowEN="true" defaultValue="" id="tb_sqsy_en_FEMALE_NATION" onchange="_chgValue(this,1,'FEMALE_NATION')" width="245px">
											<BZ:option value="">--Please select--</BZ:option>
											</BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Passport No.</td>
										<td class="edit-data-value">
											<BZ:input field="MALE_PASSPORT_NO" id="tb_sqsy_en_MALE_PASSPORT_NO" type="String" formTitle="男收养人护照号码" defaultValue="" size="30" onchange="_chgValue(this,1,'MALE_PASSPORT_NO')" size="36"/>
										</td>
										<td class="edit-data-value">
											<BZ:input field="FEMALE_PASSPORT_NO" id="tb_sqsy_en_FEMALE_PASSPORT_NO" type="String" formTitle="女收养人护照号码" defaultValue="" size="30" onchange="_chgValue(this,1,'FEMALE_PASSPORT_NO')" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Education</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="MALE_EDUCATION" formTitle="男收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" id="tb_sqsy_en_MALE_EDUCATION" onchange="_chgValue(this,1,'MALE_EDUCATION')"  width="245px">
											<BZ:option value="">--Please select--</BZ:option>
											</BZ:select>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="FEMALE_EDUCATION" formTitle="女收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" id="tb_sqsy_en_FEMALE_EDUCATION" onchange="_chgValue(this,1,'FEMALE_EDUCATION')"  width="245px">
											<BZ:option value="">--Please select--</BZ:option>
											</BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Occpation</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_JOB_EN" type="String" formTitle="男收养人职业" defaultValue=""  id="tb_sqsy_en_MALE_JOB_EN" onchange="_chgValue(this,-1,'MALE_JOB_EN')" size="36"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_JOB_EN" prefix="P_" type="String" formTitle="女收养人职业" defaultValue="" id="tb_sqsy_en_FEMALE_JOB_EN" onchange="_chgValue(this,-1,'FEMALE_JOB_EN')" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Health Status</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="MALE_HEALTH" prefix="P_" formTitle="男收养人健康状况" isCode="true"  codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" id="tb_sqsy_en_MALE_HEALTH" onchange="_chgValue(this,1,'MALE_HEALTH')" width="245px">
											<BZ:option value="">--Please select--</BZ:option>
											</BZ:select>
											<textarea style="dispaly:none;height: 40px;width: 90%;" name="P_MALE_HEALTH_CONTENT_EN" id="tb_sqsy_en_MALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_EN')"><BZ:dataValue field="MALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/></textarea>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:select field="FEMALE_HEALTH" prefix="P_" formTitle="女收养人健康状况"  isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" id="tb_sqsy_en_FEMALE_HEALTH" onchange="_chgValue(this,1,'FEMALE_HEALTH')" width="245px">
											<BZ:option value="">--Please select--</BZ:option>
											</BZ:select>
											<textarea style="dispaly:none;height: 40px;width: 90%;" name="P_FEMALE_HEALTH_CONTENT_EN" id="tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'FEMALE_HEALTH_CONTENT_EN')"><BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/></textarea>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Criminal records</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG0" value="0">No
											<input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG1" value="1">Yes
											<BZ:input field="MALE_PUNISHMENT_EN" id="tb_sqsy_en_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_EN')"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0" value="0">No
											<input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1" value="1">Yes
											<BZ:input field="FEMALE_PUNISHMENT_EN" id="tb_sqsy_en_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Any bad habits</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">No
											<input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">Yes
											<BZ:input field="MALE_ILLEGALACT_EN" id="tb_sqsy_en_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_EN')"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">No
											<input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">Yes
											<BZ:input field="FEMALE_ILLEGALACT_EN" id="tb_sqsy_en_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Currency</td>
										<td class="edit-data-value" colspan="4">
											<BZ:select field="CURRENCY" id="tb_sqsy_en_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ" isShowEN="true" notnull="" width="170px" onchange="_chgValue(this,1,'CURRENCY')" width="245px"></BZ:select>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Annual income</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_YEAR_INCOME" id="tb_sqsy_en_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'MALE_YEAR_INCOME')" maxlength="22" size="36"/>
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_YEAR_INCOME" id="tb_sqsy_en_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'FEMALE_YEAR_INCOME')" maxlength="22" size="36"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Number of previous marriages</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="MALE_MARRY_TIMES" id="tb_sqsy_en_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'MALE_MARRY_TIMES')" size="36"/>Time(s)
										</td>
										<td class="edit-data-value" colspan="2">
											<BZ:input field="FEMALE_MARRY_TIMES" id="tb_sqsy_en_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'FEMALE_MARRY_TIMES')" size="36"/>Time(s)
										</td>
									</tr> 
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table class="specialtable">
									<tr>
										<td class="edit-data-title" width="15%">Marital status</td>
										<td class="edit-data-value" width="18%">Married</td>
										<td class="edit-data-title" width="15%">Wedding Date</td>
										<td class="edit-data-value" width="18%">
											<BZ:input field="MARRY_DATE" id="tb_sqsy_en_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,1,'MARRY_DATE')"/>
										</td>
										<td class="edit-data-title" width="15%">Length of the present marriage</td>
										<td class="edit-data-value" width="19%">
											<div id="tb_sqsy_en_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Asset</td>
										<td class="edit-data-value">
											<BZ:input field="TOTAL_ASSET" id="tb_sqsy_en_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,1,'TOTAL_ASSET')"/>
										</td>
										<td class="edit-data-title">Debt</td>
										<td class="edit-data-value">
											<BZ:input  field="TOTAL_DEBT" id="tb_sqsy_en_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,1,'TOTAL_DEBT')"/>
										</td>
										<td class="edit-data-title">NetAsset</td>
										<td class="edit-data-value">
											<div id="tb_sqsy_en_TOTAL_MANNY"></div>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Number and age of children under 18 years old</td>
										<td class="edit-data-value" colspan="5">
											<BZ:input field="UNDERAGE_NUM" id="tb_sqsy_en_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'UNDERAGE_NUM')"/>Number
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Number of children</td>
										<td class="edit-data-value" colspan="5">
											<BZ:input field="CHILD_CONDITION_EN" id="tb_sqsy_en_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_EN')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">Family address</td>
										<td class="edit-data-value" colspan="5">
											<BZ:input field="ADDRESS" id="tb_sqsy_en_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,1,'ADDRESS')"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title" width="15%">Adoption expectation</td>
										<td class="edit-data-value" colspan="5">
											<BZ:input field="ADOPT_REQUEST_EN" id="tb_sqsy_en_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_EN')"/>
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
	</BZ:body>
</BZ:html>
