<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>

<%
	String path = request.getContextPath();
	Data filedata = (Data)request.getAttribute("filedata");
	String file_type = filedata.getString("FILE_TYPE");//文件类型
	Data auditdata = (Data)request.getAttribute("auditdata");
	String afId=filedata.getString("AF_ID");//文件主键
	String aaId=filedata.getString("AA_ID");//文件补充记录主键
	String auId=auditdata.getString("AU_ID");//审核主键
	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	String personName = SessionInfo.getCurUser().getPerson().getCName();
	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
	String curDate = DateUtility.getCurrentDate();
	String flag = (String)request.getAttribute("FLAG");
	if(flag == null || flag.equals("null")){
		flag = "";
	}
	String org_af_id = "org_id=" +deptId+ ";af_id=" + afId;
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>家庭文件经办人审核</title>
	<up:uploadResource/>
	<BZ:webScript edit="true"/>
	<BZ:webScript list="true"/>
	<!-- link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" /-->
	<!--script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/-->
</BZ:head>

<BZ:body property="returnData" codeNames="SYLX;WJLX;WJJBRSH">
<script type="text/javascript">	
	$(document).ready(function() {
		setSigle();
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		_dyGetContent();
		_dyShowArea();
		
		//m by kins //$('#tab-container').easytabs();
		//m by kins //_dyShowHG();
		//m by kins //_dyShowArea();
	});
    function _showInfo(){
    	$('#ggarea').show();
    	$('#img1').show();
    	$('#img2').hide();
    }
    
    function _hideInfo(){
    	$('#ggarea').hide();
    	$('#img1').hide();
    	$('#img2').show();
    }
    
    function _dyShowHG(){
   		var zhiliang = $("input[name='P_TRANSLATION_QUALITY']:checked").val();
    	if(zhiliang=='1'){//合格
    		$('#fanyibuhege').hide();
    		$("#P_UNQUALITIED_REASON").removeAttr("notnull");
    	}else{//不合格
    		$('#fanyibuhege').show();
    		$("#P_UNQUALITIED_REASON").attr("notnull","请输入翻译不合格原因");
    	}
    }
    
    //审核意见保存
    function _save(){
    	
   		//页面表单校验
		//if (!runFormVerify(document.srcFormForOneLevel, false)) {
		//	return;
		//}
		getIframeFileInfo();
		
    	var company_name=$("#P_TRANSLATION_COMPANY").find("option:selected").text();//获取翻译单位Select选择的Text
 		var company_id=$("#P_TRANSLATION_COMPANY").val();  //获取翻译单位Select选择的Value
 		$('#TRA_TRANSLATION_UNIT').val(company_id);
 		$('#TRA_TRANSLATION_UNITNAME').val(company_name);
 		document.srcFormForOneLevel.action=path+"ffs/jbraudit/saveForOneLevel.action?FLAG=<%=flag %>";
 		document.srcFormForOneLevel.submit();
    }
    
    //审核意见提交
    function _submit(){
    	//页面表单校验
		if (!runFormVerify(document.srcFormForOneLevel, false)) {
			return;
		}
		getIframeFileInfo();
    	var audit_option = $('#AUD_AUDIT_OPTION').val();//审核意见
    
   		if(_checkCanSubmitForNew(audit_option)){
    		var company_name=$("#P_TRANSLATION_COMPANY").find("option:selected").text();//获取翻译单位Select选择的Text
	 		var company_id=$("#P_TRANSLATION_COMPANY").val();  //获取翻译单位Select选择的Value
	 		$('#TRA_TRANSLATION_UNIT').val(company_id);
	 		$('#TRA_TRANSLATION_UNITNAME').val(company_name);
	 		document.srcFormForOneLevel.action=path+"ffs/jbraudit/submitForOneLevel.action?FLAG=<%=flag %>";
//	 		if("5"==audit_option){//补充文件翻译
//	 			_isCanBF();
//	 		}else{
//	 			document.srcFormForOneLevel.submit();
//	 		}
			document.srcFormForOneLevel.submit();
	 		
    	}
    	
    	
    }
    
    function _goback(){
    	var flag = "<%=flag %>";
    	if(flag == "bf"){
    		window.location.href=path+"ffs/ffsaftranslation/adTranslationList.action";
    	}else if(flag == "cf"){
    		window.location.href=path+"ffs/ffsaftranslation/reTranslationList.action";
    	}else if(flag == "bc"){
    		window.location.href=path+"ffs/filemanager/SuppleQueryList.action";
    	}else{
    		window.location.href=path+"ffs/jbraudit/findListForOneLevel.action";
    	}
    }
    
    //根据类别、公约类型、审核级别、审核意见动态获得审核意见模板内容
	function _dyGetContent(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//审核意见
		var gy_type = $('#P_IS_CONVENTION_ADOPT').val();//是否公约收养
		if(null!=audit_option&&""!=audit_option){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.audit.OpinionTemAjax&method=getAuditModelContent&TYPE=00&AUDIT_TYPE=0&AUDIT_OPTION='+audit_option+'&GY_TYPE='+gy_type,
				type: 'POST',
				timeout:1000,
				dataType: 'json',
				success: function(data){
					$("#AUD_AUDIT_CONTENT_CN").val(data.AUDIT_MODEL_CONTENT);//审核意见
				}
		  	  });
		}
	}
	
	//根据审核意见动态显示隐藏相关区域
	function _dyShowArea(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//审核意见
		if("4"==audit_option){//补充文件
			$("#WJBCArea").show();
			$("#WJBFArea").hide();
			$("#WJCFArea").hide();
		}else if("5"==audit_option){//补充文件翻译
			$("#WJBCArea").hide();
			$("#WJBFArea").show();
			$("#WJCFArea").hide();
		}else if("6"==audit_option){//重翻
			$("#WJBCArea").hide();
			$("#WJBFArea").hide();
			$("#WJCFArea").show();
		}else{
			$("#WJBCArea").hide();
			$("#WJBFArea").hide();
			$("#WJCFArea").hide();
		}
	}
	
	//检查是否可进行补翻操作
	function _isCanBF(){
		var afID = $("#P_AF_ID").val();//文件主键ID
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.audit.FileAuditAjax&method=isCanBF&AF_ID='+afID,
			type: 'POST',
			timeout:1000,
			dataType: 'json',
			success: function(data){
				var flag= data.FLAG;
				if(flag=="false"||flag==false){
					//alert("不存在补充记录或补充状态为补充中或该文件已处在补翻中，请选择其他审核结果！");
					alert("不存在补充记录或该文件已处在补翻中，请选择其他审核结果！");
					return false;
				}else{
					document.srcFormForOneLevel.submit();
				}

			}
	  	  });
	}
	
	//检查是否满足提交条件
	function _checkCanSubmit(audit_option){
		var flag = true;
		var atranslation_state = $("#P_ATRANSLATION_STATE").val();//补翻状态
		var rtranslation_state = $("#P_RTRANSLATION_STATE").val();//重翻状态
		var supply_state = $("#P_SUPPLY_STATE").val();//末次文件补充状态
		var AA_ID = $("#P_AA_ID").val();//补充ID
		
		if("4"==audit_option){//补充文件
			if("0"==supply_state||"1"==supply_state){//末次文件状态为"待补充"或"补充中"的
				alert("该文件正在补充中，请重新选择【审核结果】！");
				flag = false;
			}else if("0"==atranslation_state||"1"==atranslation_state){
				alert("该文件正在补翻中，请重新选择【审核结果】！");
				flag = false;
			} else if("0"==rtranslation_state||"1"==rtranslation_state){
				alert("该文件正在重翻中，请重新选择【审核结果】！");
				flag = false;
			}
		}else if("5"==audit_option){//补翻
			if(null==AA_ID||""==AA_ID){
				alert("不存在补充文件记录，请先补充文件！");
				flag = false;
			}else{
				if("0"==atranslation_state||"1"==atranslation_state){//补翻状态为"待补翻"或"补翻中"的
					alert("该文件正在补翻中，请重新选择【审核结果】！");
					flag = false;
				}else if("0"==rtranslation_state||"1"==rtranslation_state){
					alert("该文件正在重翻中，请重新选择【审核结果】！");
					flag = false;
				}else if("0"==supply_state||"1"==supply_state){
					alert("该文件正在补充中，请重新选择【审核结果】！");
					flag = false;
				}
			}
			
		}else if("6"==audit_option){//重翻
			if("0"==rtranslation_state||"1"==rtranslation_state){//重翻状态为"待重翻"或"重翻中"的
				alert("该文件正在重翻中，请重新选择【审核结果】！");
				flag = false;
			}else if("0"==atranslation_state||"1"==atranslation_state){
				alert("该文件正在补翻中，请重新选择【审核结果】！");
				flag = false;
			}else if("0"==supply_state||"1"==supply_state){
				alert("该文件正在补充中，请重新选择【审核结果】！");
				flag = false;
			}
		}
		
		return flag;
	}

	//检查是否满足提交条件
	function _checkCanSubmitForNew(audit_option){
		var flag = true;
		var AA_ID = $("#P_AA_ID").val();//补充ID

		 if("5"==audit_option){//补翻
			if(null==AA_ID||""==AA_ID){
				alert("不存在补充文件记录，请先补充文件！");
				flag = false;
			}
		}

		return flag;
	}
	
	var tempFlag=1;
	
	//add by kings
	function change(flag){
		if(tempFlag!=flag){
			document.all("iframe").style.height=document.body.scrollHeight; 
			if(flag==1){//显示文件中文
				document.getElementById("iframe").src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=cn&oper=edit";
				document.getElementById("act1").className="active";
				document.getElementById("act6").className="";
				document.getElementById("act5").className="";
				document.getElementById("act4").className="";
				document.getElementById("act3").className="";
				document.getElementById("act2").className="";
				document.getElementById("act7").className="";
				
				
			}	
			if(flag==2){//显示文件英文
						
				document.getElementById("iframe").src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=en&oper=edit";
				document.getElementById("act2").className="active";
				document.getElementById("act1").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==3){
				
						
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findAuditList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==4){
						
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findBcRecordList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="active";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==5){
						
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findReviseList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="active";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==6){	
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findTranslationList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="active";
				document.getElementById("act7").className="";
			}
			if(flag==7){	
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findYpshAndEtInfoList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="active";
			}
			
			document.all("iframe").style.height=document.body.scrollHeight; 
			
			tempFlag=flag;
		}
		
}

	//获得文件基本信息（中英文）iframe页面隐藏域字段值
	function getIframeFileInfo(){
		//var iframe = document.frames["iframe"];
		//var obj = iframe.document.forms["fileForm"];
		var obj = document.getElementById("iframe").contentWindow;
		 
		var filedNameArray=["FE_AF_ID","FE_ADOPTER_SEX","FE_MALE_NAME","FE_MALE_BIRTHDAY","FE_MALE_PHOTO","FE_MALE_NATION",
							"FE_MALE_PASSPORT_NO","FE_MALE_EDUCATION","FE_MALE_JOB_CN","FE_MALE_JOB_EN","FE_MALE_HEALTH",
							"FE_MALE_HEALTH_CONTENT_CN","FE_MALE_HEALTH_CONTENT_EN","FE_MEASUREMENT","FE_MALE_HEIGHT",
							"FE_MALE_WEIGHT","FE_MALE_BMI","FE_MALE_PUNISHMENT_FLAG","FE_MALE_PUNISHMENT_CN",
							"FE_MALE_PUNISHMENT_EN","FE_MALE_ILLEGALACT_FLAG","FE_MALE_ILLEGALACT_CN","FE_MALE_ILLEGALACT_EN",
							"FE_MALE_RELIGION_CN","FE_MALE_RELIGION_EN","FE_MALE_MARRY_TIMES","FE_MALE_YEAR_INCOME",
							"FE_FEMALE_NAME","FE_FEMALE_BIRTHDAY","FE_FEMALE_PHOTO","FE_FEMALE_NATION","FE_FEMALE_PASSPORT_NO",
							"FE_FEMALE_EDUCATION","FE_FEMALE_JOB_CN","FE_FEMALE_JOB_EN","FE_FEMALE_HEALTH","FE_FEMALE_HEALTH_CONTENT_CN",
							"FE_FEMALE_HEALTH_CONTENT_EN","FE_FEMALE_HEIGHT","FE_FEMALE_WEIGHT","FE_FEMALE_BMI","FE_FEMALE_PUNISHMENT_FLAG",
							"FE_FEMALE_PUNISHMENT_CN","FE_FEMALE_PUNISHMENT_EN","FE_FEMALE_ILLEGALACT_FLAG","FE_FEMALE_ILLEGALACT_CN",
							"FE_FEMALE_ILLEGALACT_EN","FE_FEMALE_RELIGION_CN","FE_FEMALE_RELIGION_EN","FE_FEMALE_MARRY_TIMES",
							"FE_FEMALE_YEAR_INCOME","FE_MARRY_CONDITION","FE_MARRY_DATE","FE_CONABITA_PARTNERS","FE_CONABITA_PARTNERS_TIME",
							"FE_GAY_STATEMENT","FE_CURRENCY","FE_TOTAL_ASSET","FE_TOTAL_DEBT","FE_CHILD_CONDITION_CN","FE_CHILD_CONDITION_EN",
							"FE_UNDERAGE_NUM","FE_ADDRESS","FE_ADOPT_REQUEST_CN","FE_ADOPT_REQUEST_EN","FE_FINISH_DATE",
							"FE_HOMESTUDY_ORG_NAME","FE_RECOMMENDATION_NUM","FE_HEART_REPORT","FE_IS_MEDICALRECOVERY",
							"FE_MEDICALRECOVERY_CN","FE_MEDICALRECOVERY_EN","FE_IS_FORMULATE","FE_ADOPT_PREPARE","FE_RISK_AWARENESS",
							"FE_IS_ABUSE_ABANDON","FE_IS_SUBMIT_REPORT","FE_IS_FAMILY_OTHERS_FLAG","FE_IS_FAMILY_OTHERS_CN",
							"FE_IS_FAMILY_OTHERS_EN","FE_ADOPT_MOTIVATION","FE_CHILDREN_ABOVE","FE_INTERVIEW_TIMES",
							"FE_PARENTING","FE_SOCIALWORKER","FE_REMARK_CN","FE_REMARK_EN","FE_GOVERN_DATE","FE_VALID_PERIOD",
							"FE_EXPIRE_DATE","FE_APPROVE_CHILD_NUM","FE_AGE_FLOOR","FE_AGE_UPPER","FE_CHILDREN_SEX","FE_CHILDREN_HEALTH_CN",
							"FE_CHILDREN_HEALTH_EN","FE_PACKAGE_ID","FE_PACKAGE_ID_CN","FE_IS_CONVENTION_ADOPT"];
		var hiddenStr ="";
		var i=0;
		var length=filedNameArray.length;
		
		for(i=0;i<length;i++){
			var filedId = filedNameArray[i];
			var tempObj = obj.document.getElementById(filedId);
			 //var tempObj = document.frames["iframe"].document.getElementById(filedId);
			
			
			if(tempObj!="null"&&tempObj!=null){
				var tempValue = tempObj.value;
				
				hiddenStr+=" <input type='hidden' name='"+filedId+"' id='"+filedId+"' value='"+tempValue+"'> ";
			}
		}
		
		
		$("#hiddenFormsDiv").append(hiddenStr);

	}
	
	
	
</script>
	<BZ:form name="srcFormForOneLevel" method="post" token="<%=token %>" >
	<div id="hiddenFormsDiv"></div>
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	
	
	<div class="bz-edit clearfix" desc="编辑区域" >
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					文件概要信息
				</div>
				<div style="display:;position:absolute;top:3px;right:25px;">
					<img id="img1" src="<%=path %>/resource/images/bs_blue_icons/caret-down.png"  width="10px" height="10px"  style="display:''" onclick="_hideInfo()"/>
					<img id="img2" src="<%=path %>/resource/images/bs_blue_icons/caret-left.png"  width="10px" height="10px" style="display:none" onclick="_showInfo()"/>
				</div>
				
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体" id="ggarea">
				<BZ:input type="hidden" field="ATRANSLATION_STATE" id="P_ATRANSLATION_STATE" prefix="P_"/><!-- 补翻状态 -->
				<BZ:input type="hidden" field="RTRANSLATION_STATE" id="P_RTRANSLATION_STATE" prefix="P_"/><!-- 重翻状态 -->
				<BZ:input type="hidden" field="SUPPLY_STATE" id="P_SUPPLY_STATE" prefix="P_"/><!-- 末次文件补充状态 -->
				<BZ:input type="hidden" field="IS_CONVENTION_ADOPT" id="P_IS_CONVENTION_ADOPT" prefix="P_"/><!-- 是否公约收养 -->
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="15%" />
						<col width="10%" />
						<col width="15%" />
						<col width="10%" />
						<col width="15%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">收养组织(CN)</td>
						<td class="bz-edit-data-value" colspan="7">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养组织(EN)</td>
						<td class="bz-edit-data-value" colspan="7"> 
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收文编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue=""  onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">收文日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否公约收养</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">是否预警名单</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_ALERT" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">是否转组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value">
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">暂停状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PAUSE" checkValue="0=未暂停;1=已暂停" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">暂停原因</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_REASON" defaultValue="" length="11"/>
						</td>
						<td class="bz-edit-data-title">退文状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" checkValue="0=待确认;1=已确认;2=待处置;3=已处置" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">退文原因</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue=""  length="11"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">原收养组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">之前收文编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">末次补充状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_STATE" checkValue="0=待补充;1=补充中;2=已补充" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件补充次数</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	
	<div class="bz-edit clearfix" desc="编辑区域" >
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">基本信息(中)</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">基本信息(英)</a>
					</li>
					<%
						if(file_type=="20"||"20".equals(file_type)||file_type=="21"||"21".equals(file_type)||file_type=="22"||"22".equals(file_type)||file_type=="23"||"23".equals(file_type)){
					 %>
					<li id="act7" class="">
						<a href="javascript:change(7);">预批审核信息</a>
					</li>
					 <%} %>
					<li id="act7" class="" style="display:none">
						<a href="javascript:change(7);"></a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">审核记录</a>
					</li>
					<li id="act4" class="">
						<a href="javascript:change(4);">补充记录</a>
					</li>
					<li id="act5" class="">
						<a href="javascript:change(5);">修改记录</a>
					</li>
					<li id="act6" class="">
						<a href="javascript:change(6);">翻译记录</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto;">
			<iframe id="iframe" scrolling="no" src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=cn&oper=edit" style="border:none; width:100%; overflow:hidden;text-align: center" frameborder="0" ></iframe>
		</div>
	</div>
	<!-- 审核信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					审核情况
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" prefix="AUD_" field="AU_ID" defaultValue="<%=auId %>"/>
				<BZ:input type="hidden" prefix="AUD_" field="AUDIT_USERID" defaultValue="<%=personId %>"/>
				<BZ:input type="hidden" prefix="TRA_" id="TRA_TRANSLATION_UNIT" field="TRANSLATION_UNIT"/>
				<BZ:input type="hidden" prefix="TRA_" id="TRA_TRANSLATION_UNITNAME" field="TRANSLATION_UNITNAME" />
				<BZ:input type="hidden" prefix="P_" field="AF_ID" id="P_AF_ID" defaultValue="<%=afId %>"/>
				<BZ:input type="hidden" prefix="P_" field="AA_ID" id="P_AA_ID" defaultValue="<%=aaId %>"/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">公认证情况</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="ACCEPTED_CARD" value="1" prefix="P_" formTitle="" defaultChecked="true"></BZ:radio>齐全
				    		<BZ:radio field="ACCEPTED_CARD" value="2" prefix="P_" formTitle=""></BZ:radio>不齐全
						</td>
						<td class="bz-edit-data-title">翻译单位</td>
						<td class="bz-edit-data-value">
							<BZ:select field="TRANSLATION_COMPANY" id="P_TRANSLATION_COMPANY" formTitle="翻译单位" prefix="P_">
								<BZ:option value="9151">爱之桥</BZ:option>
								<BZ:option value="9221">北翻</BZ:option>
							</BZ:select>
							
						</td>
						<td class="bz-edit-data-title">翻译质量</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="TRANSLATION_QUALITY" onclick="_dyShowHG();" prefix="P_" value="1" formTitle="翻译质量" defaultChecked="true"></BZ:radio>合格
				    		<BZ:radio field="TRANSLATION_QUALITY" onclick="_dyShowHG();" prefix="P_" value="2" formTitle="翻译质量"></BZ:radio>不合格
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>审核结果</td>
						<td class="bz-edit-data-value">
							<BZ:select field="AUDIT_OPTION" formTitle="审核结果" prefix="AUD_" id="AUD_AUDIT_OPTION" notnull="请选择审核结果" codeName="WJJBRSH" isCode="true" onchange="_dyGetContent();_dyShowArea();">
								<BZ:option value="" selected="true">-请选择-</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title">审核人</td>
						<td class="bz-edit-data-value">
							<BZ:input field="AUDIT_USERNAME" defaultValue="<%=personName %>" prefix="AUD_" />					
						</td>
						<td class="bz-edit-data-title">审核日期</td>
						<td class="bz-edit-data-value">
							<BZ:input field="AUDIT_DATE" defaultValue="<%=curDate %>" type="date" prefix="AUD_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核意见</td>
						<td class="bz-edit-data-value" colspan="5" >
							<BZ:input type="textarea" field="AUDIT_CONTENT_CN" id="AUD_AUDIT_CONTENT_CN" prefix="AUD_" maxlength="500" defaultValue="" style="width:92%;height:70px"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input type="textarea" field="AUDIT_REMARKS" id="AUD_AUDIT_REMARKS" prefix="AUD_" maxlength="500" defaultValue="" style="width:92%"/>
						</td>
					</tr>
					<tr id="fanyibuhege" style="display:none">
						<td class="bz-edit-data-title"><font color="red">*</font>翻译不合格原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input type="textarea" field="UNQUALITIED_REASON" id="P_UNQUALITIED_REASON" prefix="P_" maxlength="500" defaultValue="" size="20" style="width:92%"/>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 审核信息end -->
	<!-- 文件补充通知信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域" id="WJBCArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					文件补充通知信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" field="SEND_USERID" prefix="ADD_" defaultShowValue="<%=personId %>"/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">补充原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input type="textarea" field="NOTICE_CONTENT" id="ADD_NOTICE_CONTENT" prefix="ADD_" maxlength="1000" defaultValue="" style="width:92%"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否允许修改基本信息</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="IS_MODIFY"  prefix="ADD_" value="0" formTitle="是否允许修改基本信息" defaultChecked="true"></BZ:radio>否
				    		<BZ:radio field="IS_MODIFY"  prefix="ADD_" value="1" formTitle="是否允许修改基本信息"></BZ:radio>是
						</td>
						<td class="bz-edit-data-title">是否允许补充附件</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="IS_ADDATTACH"  prefix="ADD_" value="0" formTitle="是否允许修改附件"></BZ:radio>否
				    		<BZ:radio field="IS_ADDATTACH"  prefix="ADD_" value="1" formTitle="是否允许修改附件" defaultChecked="true"></BZ:radio>是
						</td>
						<td class="bz-edit-data-title">补充通知人</td>
						<td class="bz-edit-data-value">
							<BZ:input field="SEND_USERNAME" defaultValue="<%=personName %>" prefix="ADD_"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">补充通知日期日期</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="NOTICE_DATE" defaultValue="<%=curDate %>" type="date" prefix="ADD_"/>			
						</td>
					</tr>
					
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 文件补充通知信息end -->
	
	<!-- 文件补翻通知信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域" id="WJBFArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					文件补翻通知信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" field="NOTICE_USERID" prefix="TRA_"/>
				<BZ:input type="hidden" field="TRANSLATION_TYPE" prefix="TRA_" defaultValue="1"/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">补翻原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input type="textarea" field="AA_CONTENT" id="TRA_AA_CONTENT" prefix="TRA_" maxlength="1000" defaultValue="" style="width:92%"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">补翻通知附件</td>
							<td class="bz-edit-data-value">
								<up:uploadBody 
									attTypeCode="AF" 
									bigType="AF"
									smallType="<%=AttConstants.AF_BFTZ %>"
									id="TRA_NOTICE_FILEID" 
									name="TRA_NOTICE_FILEID"
									packageId="" 
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="<%=org_af_id %>"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
									/>
							</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">补翻通知人</td>
						<td class="bz-edit-data-value">
							<BZ:input field="SEND_USERNAME" defaultValue="<%=personName %>" prefix="TRA_"/>					
						</td>
						<td class="bz-edit-data-title">补翻通知日期</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="NOTICE_DATE" defaultValue="<%=curDate %>" type="date" prefix="TRA_"/>			
						</td>
					</tr>
					
					
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 文件补翻通知信息end -->
	
	<!-- 文件重翻通知信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域" id="WJCFArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					文件重翻通知信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" field="NOTICE_USERID" prefix="TRAN_"/>
				<BZ:input type="hidden" field="TRANSLATION_TYPE" prefix="TRAN_" defaultValue="2"/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">重翻原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input type="textarea" field="AA_CONTENT" id="TRAN_AA_CONTENT" prefix="TRAN_" maxlength="1000" defaultValue="" style="width:92%"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">重翻通知人</td>
						<td class="bz-edit-data-value">
							<BZ:input field="SEND_USERNAME" defaultValue="<%=personName %>" prefix="TRAN_"/>					
						</td>
						<td class="bz-edit-data-title">重翻通知日期</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="NOTICE_DATE" defaultValue="<%=curDate %>" type="date" prefix="TRAN_"/>			
						</td>
					</tr>
					
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 文件补翻通知信息end -->
	
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<a href="reporter_files_list.html" >
				<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_save();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback()"/>
			</a>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
