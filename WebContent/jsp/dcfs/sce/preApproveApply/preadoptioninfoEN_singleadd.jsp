<%
/**   
 * @Title: adoptionpersoninfoEN_singleadd.jsp
 * @Description:  收养人基本信息添加
 * @author yangrt   
 * @date 2014-7-22 上午4:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	Data childdata = (Data)request.getAttribute("childData");
	
	String MALE_PUNISHMENT_FLAG = (String)request.getAttribute("MALE_PUNISHMENT_FLAG");	//男收养人违法行为及刑事处罚标识,0=无，1=有
	String MALE_ILLEGALACT_FLAG = (String)request.getAttribute("MALE_ILLEGALACT_FLAG");	//男收养人有无不良嗜好标识,0=无，1=有
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//女收养人违法行为及刑事处罚标识,0=无，1=有
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//女收养人有无不良嗜好标识,0=无，1=有
	String CONABITA_PARTNERS = (String)request.getAttribute("CONABITA_PARTNERS");
	
	String hour = Long.toString((Long)request.getAttribute("hour"));
	String minute = Long.toString((Long)request.getAttribute("minute"));
	String second = Long.toString((Long)request.getAttribute("second"));
	String djsTime =hour+":"+minute+":"+second;
	
	String ri_id = (String)request.getAttribute("RI_ID");
	String org_id = (String)request.getAttribute("ADOPT_ORG_ID");
	String org_af_id = "org_id=" + org_id + ";af_id=" + ri_id;
%>
<BZ:html>
	<BZ:head language="EN">
		<title>收养人基本信息添加</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true" isAjax="true"/>
		<!--时钟倒计时-->
		<link media="screen" rel="stylesheet" type="text/css" href="<%=path %>/resource/js/epiclock/stylesheet/jquery.epiclock.css"/>
		<link media="screen" rel="stylesheet" type="text/css" href="<%=path %>/resource/js/epiclock/renderers/retro/epiclock.retro.css"/>
		<link media="screen" rel="stylesheet" type="text/css" href="<%=path %>/resource/js/epiclock/renderers/retro-countdown/epiclock.retro-countdown.css"/>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/javascript/jquery.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/javascript/jquery.dateformat.min.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/javascript/jquery.epiclock.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/renderers/retro/epiclock.retro.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/renderers/retro-countdown/epiclock.retro-countdown.js"></script>
		<!--时钟倒计时-->
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		var act = "<%=request.getAttribute("act") %>";
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			
			if(act == "" || act == "null"){
				$("#TendingOpinionInfo").hide();
			}else{
				change(act);
			}
			
			var sex = $("#R_ADOPTER_SEX").val();
			if(sex == "1"){
				$("#femaleinfo").hide();
				//根据出生日期初始化年龄
				var male_briDate = $("#R_MALE_BIRTHDAY").val();	//男收养人的出生日期
				if(male_briDate != ""){
					$("#MALE_AGE").text(_getAge(male_briDate));
				}
				
				//初始化健康状况说明的显示与隐藏
				var male_health = $("#R_MALE_HEALTH").find("option:selected").val();	//男收养人的健康状况
				if(male_health == "2"){
					$("#R_MALE_HEALTH_CONTENT_EN").show();
				}else{
					$("#R_MALE_HEALTH_CONTENT_EN").hide();
				}
				
				//初始化违法行为及刑事处罚说明的显示与隐藏
				var MALE_PUNISHMENT_FLAG = "<%=MALE_PUNISHMENT_FLAG%>";
				if(MALE_PUNISHMENT_FLAG == "1"){
					$("#R_MALE_PUNISHMENT_EN").show();
				}else{
					$("#R_MALE_PUNISHMENT_EN").hide();
				}
				
				//初始化不良嗜好说明的显示与隐藏
				var MALE_ILLEGALACT_FLAG = "<%=MALE_ILLEGALACT_FLAG%>";
				if(MALE_ILLEGALACT_FLAG == "1"){
					$("#R_MALE_ILLEGALACT_EN").show();
				}else{
					$("#R_MALE_ILLEGALACT_EN").hide();
				}
				
				$("#R_FEMALE_YEAR_INCOME").hide();
				$("#R_MALE_NAME").attr("notnull", "Please write the name of adoptive father!");
				$("#R_MALE_BIRTHDAY").attr("notnull", "Please select the DOB of adoptive father!");
				$("#R_MALE_NATION").attr("notnull", "Please select the nationality of adoptive father!");
				$("#R_MALE_EDUCATION").attr("notnull", "Please select the education of adoptive father!");
				$("#R_MALE_JOB_EN").attr("notnull", "请填写男收养人职业！");
				$("#R_MALE_HEALTH").attr("notnull", "Please select the health status of adoptive father!");
				$("#R_MALE_YEAR_INCOME").attr("notnull", "Please write the annual income of adoptive father!");
			}else if(sex == "2"){
				$("#maleinfo").hide();
				//根据出生日期初始化年龄
				var female_briDate = $("#R_FEMALE_BIRTHDAY").val();	//女收养人的出生日期
				if(female_briDate != ""){
					$("#FEMALE_AGE").text(_getAge(female_briDate));
				}
				
				//初始化健康状况说明的显示与隐藏
				var female_health = $("#R_FEMALE_HEALTH").find("option:selected").val();	//女收养人的健康状况
				if(female_health == "2"){
					$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				}else{
					$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				}
				
				//初始化违法行为及刑事处罚说明的显示与隐藏
				var FEMALE_PUNISHMENT_FLAG = "<%=FEMALE_PUNISHMENT_FLAG%>";
				if(FEMALE_PUNISHMENT_FLAG == "1"){
					$("#R_FEMALE_PUNISHMENT_EN").show();
				}else{
					$("#R_FEMALE_PUNISHMENT_EN").hide();
				}
				
				//初始化不良嗜好说明的显示与隐藏
				var FEMALE_ILLEGALACT_FLAG = "<%=FEMALE_ILLEGALACT_FLAG%>";
				if(FEMALE_ILLEGALACT_FLAG == "1"){
					$("#R_FEMALE_ILLEGALACT_EN").show();
				}else{
					$("#R_FEMALE_ILLEGALACT_EN").hide();
				}
				
				$("#R_MALE_YEAR_INCOME").hide();
				$("#R_FEMALE_NAME").attr("notnull", "Please write the name of adoptive mother!");
				$("#R_FEMALE_BIRTHDAY").attr("notnull", "Please select the DOB of adoptive mother!");
				$("#R_FEMALE_NATION").attr("notnull", "Please select the nationality of adoptive mother!");
				$("#R_FEMALE_EDUCATION").attr("notnull", "Please select the education of adoptive mother!");
				$("#R_FEMALE_JOB_EN").attr("notnull", "请填写女收养人职业！");
				$("#R_FEMALE_HEALTH").attr("notnull", "Please select the health status of adoptive mother!");
				$("#R_FEMALE_YEAR_INCOME").attr("notnull", "Please write the annual income of adoptive mother!");
			}
			
			var CONABITA_PARTNERS = "<%=CONABITA_PARTNERS %>";
			if(CONABITA_PARTNERS == "0" || CONABITA_PARTNERS=="null" || CONABITA_PARTNERS==""){
				$("#R_CONABITA_PARTNERS_TIME").attr("disabled","true");
			}else{
				$("#R_CONABITA_PARTNERS_TIME").removeAttr("disabled");
			}
			
			//初始化家庭净资产
			_setTotalManny();
			
		});
		
		//根据男收养人的出生日期获取年龄
		function _setMaleAge(obj){
			var date = obj.value;
			var age = _getAge(date);
			$("#MALE_AGE").text(age);
		}
		
		//根据女收养人的出生日期获取年龄
		function _setFemaleAge(obj){
			var date = obj.value;
			var age = _getAge(date);
			$("#FEMALE_AGE").text(age);
		}
		
		//设置显示、隐藏女收养人的健康状况描述
		function _setFemaleHealthContent(){
			var val = $("#R_FEMALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				$("#R_FEMALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive mother's health condition!");
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				$("#R_FEMALE_HEALTH_CONTENT_EN").val("");
				$("#R_FEMALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//设施女收养人违法行为及刑事处罚输入框的显示与隐藏
		function _setFemalePunishment(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_FEMALE_PUNISHMENT_EN").hide();
				$("#R_FEMALE_PUNISHMENT_EN").val("");
				$("#R_FEMALE_PUNISHMENT_EN").removeAttr("notnull");
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").show();
				$("#R_FEMALE_PUNISHMENT_EN").attr("notnull","Please fill in the adoptive mother's criminal records!");
			}
		}
		
		//设施女收养人不良嗜好输入框的显示与隐藏
		function _setFemaleIllegalact(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_FEMALE_ILLEGALACT_EN").hide();
				$("#R_FEMALE_ILLEGALACT_EN").val("");
				$("#R_FEMALE_ILLEGALACT_EN").removeAttr("notnull");
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").show();
				$("#R_FEMALE_ILLEGALACT_EN").attr("notnull","Please fill in the adoptive father's bad habits.");
			}
		}
		
		//设置显示、隐藏男收养人的健康状况描述
		function _setMaleHealthContent(){
			var val = $("#R_MALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_MALE_HEALTH_CONTENT_EN").show();
				$("#R_MALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive father's health condition!");
			}else{
				$("#R_MALE_HEALTH_CONTENT_EN").hide();
				$("#R_MALE_HEALTH_CONTENT_EN").val("");
				$("#R_MALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//设施男收养人违法行为及刑事处罚输入框的显示与隐藏
		function _setMalePunishment(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_MALE_PUNISHMENT_EN").hide();
				$("#R_MALE_PUNISHMENT_EN").val("");
				$("#R_MALE_PUNISHMENT_EN").removeAttr("notnull");
			}else{
				$("#R_MALE_PUNISHMENT_EN").show();
				$("#R_MALE_PUNISHMENT_EN").attr("notnull","please fill in male adopter's illegal act and criminal penalty!");
			}
		}
		
		//设施男收养人不良嗜好输入框的显示与隐藏
		function _setMaleIllegalact(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_MALE_ILLEGALACT_EN").hide();
				$("#R_MALE_ILLEGALACT_EN").val("");
				$("#R_MALE_ILLEGALACT_EN").removeAttr("notnull");
			}else{
				$("#R_MALE_ILLEGALACT_EN").show();
				$("#R_MALE_ILLEGALACT_EN").attr("notnull","Please fill in the adoptive father's bad habits.");
			}
		}
		
		//设置同居时长是否可编辑
		function _setConabitaPartnersTime(obj){
			var val = obj.value;
			if(val == "0"){
				$("#R_CONABITA_PARTNERS_TIME").attr("disabled","true");
				$("#R_CONABITA_PARTNERS_TIME").val("");
			}else{
				$("#R_CONABITA_PARTNERS_TIME").removeAttr("disabled");
			}
		}
		
		//根据家庭总资产与总债务计算净资产
		function _setTotalManny(){
			var total_asset = $("#R_TOTAL_ASSET").val();	//总资产
			var total_debt = $("#R_TOTAL_DEBT").val();	//总债务
			if(total_asset == ""){
				$("#TOTAL_MANNY").text("");
			}else{
				if(total_debt == ""){
					$("R_TOTAL_DEBT").val(0);
					$("R_TOTAL_DEBT").text(0);
					total_debt = 0;
				}
				$("#TOTAL_MANNY").text(total_asset - total_debt);
			}
		}
		
		//根据出生日期获取周岁年龄
		function _getAge(strBirthday)
		{       
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//同年 则为0岁
		    }else{
		        var ageDiff = nowYear - birthYear ; //年之差
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//日之差
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//月之差
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
		        }
		    }
		    return returnAge;//返回周岁年龄
		}
		
		//Tab页js
		function change(flag){
			act = flag;
			if(flag==1){
				document.getElementById("act1").className="active";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#AdopterInfo").show();
				$("#TendingOpinionInfo").hide();
			}	
			if(flag==2){
				document.getElementById("act1").className="";
				document.getElementById("act2").className="active";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#AdopterInfo").hide();
				$("#TendingOpinionInfo").show();
				$("#TendingENTitle").show();
				$("#TendingENInfo").show();
				$("#TendingCNTitle").hide();
				$("#TendingCNInfo").hide();
				$("#OpinionENTitle").hide();
				$("#OpinionENInfo").hide();
				$("#OpinionCNTitle").hide();
				$("#OpinionCNInfo").hide();
				$(".ENinfo").show();
				$(".CNinfo").hide();
			}
			if(flag==3){
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#AdopterInfo").hide();
				$("#TendingOpinionInfo").show();
				$("#TendingENTitle").hide();
				$("#TendingENInfo").hide();
				$("#TendingCNTitle").show();
				$("#TendingCNInfo").show();
				$("#OpinionENTitle").hide();
				$("#OpinionENInfo").hide();
				$("#OpinionCNTitle").hide();
				$("#OpinionCNInfo").hide();
				$(".ENinfo").hide();
				$(".CNinfo").show();
			}
			if(flag==4){
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="active";
				document.getElementById("act5").className="";
				$("#AdopterInfo").hide();
				$("#TendingOpinionInfo").show();
				$("#TendingENTitle").hide();
				$("#TendingENInfo").hide();
				$("#TendingCNTitle").hide();
				$("#TendingCNInfo").hide();
				$("#OpinionENTitle").show();
				$("#OpinionENInfo").show();
				$("#OpinionCNTitle").hide();
				$("#OpinionCNInfo").hide();
				$(".ENinfo").show();
				$(".CNinfo").hide();
			}
			if(flag==5){
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="active";
				$("#AdopterInfo").hide();
				$("#TendingOpinionInfo").show();
				$("#TendingENTitle").hide();
				$("#TendingENInfo").hide();
				$("#TendingCNTitle").hide();
				$("#TendingCNInfo").hide();
				$("#OpinionENTitle").hide();
				$("#OpinionENInfo").hide();
				$("#OpinionCNTitle").show();
				$("#OpinionCNInfo").show();
				$(".ENinfo").hide();
				$(".CNinfo").show();
			}
		}
		
		//保存/提交预批申请
		function _applySubmit(val){
			$("#R_RI_STATE").val(val);
			if(val == "0"){
				document.srcForm.action = path+"sce/preapproveapply/PreApproveApplySave.action?act=" + act;
				document.srcForm.submit();
			}else if(val == "1"){
				var isSubmit = "true";
				var file_type = $("#R_FILE_TYPE").val();
				if(file_type == "23"){
					isSubmit = getStr("com.dcfs.sce.preApproveApply.PreApproveApplyAjax","type=preApprove&REQ_NO=" + $("#R_PRE_REQ_NO").val());
				}
				if(isSubmit == "true"){
					//页面表单校验
					if (!runFormVerify(document.srcForm, false)) {
						return;
					}else{
						var planEN = $("R_TENDING_EN").val();
						var planCN = $("R_TENDING_CN").val();
						var opinionEN = $("R_OPINION_EN").val();
						var opinionCN = $("R_OPINION_CN").val();
						if(planEN == "" && planCN == ""){
							alert("fill out at least one Chinese version or English version of the Nuture plan !");
							return;
						}else if(opinionEN == "" && opinionCN == ""){
							alert("fill out at least one Chinese version or English version of the Reference letter!");
							return;
						}else if(confirm("Are you sure you want to submit?")){
							document.srcForm.action = path+"sce/preapproveapply/PreApproveApplySave.action";
							document.srcForm.submit();
						}
					}
				}else{
					alert("该预批的之前预批已经递交特需文件，不能提交次预批申请！");
					document.srcForm.action=path+"sce/preapproveapply/PreApproveApplyDelete.action?deleteid=" + $("#R_RI_ID").val();
					document.srcForm.submit();
				}
			}
		}
		
		//返回列表页面
		function _goback(){
			window.location.href=path+"sce/preapproveapply/PreApproveApplyList.action";
		}
		
	</script>
	<BZ:body property="applydata" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;HBBZ;PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PRE_REQ_NO" id="R_PRE_REQ_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PUB_ID" id="R_PUB_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="RI_STATE" id="R_RI_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="LOCK_MODE" id="R_LOCK_MODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_NAME" id="R_MALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="DJSTIME" id="R_DJSTIME" defaultValue="<%=djsTime %>"/>
		<!-- 隐藏区域end -->
		<!-- 倒计时区域begin -->
		<div align="center">
			<table >
				<tr>
					<td align="center" style="font-size:16px" nowrap>
						The deadline for submitting pre-approval applications is in&nbsp;&nbsp;<font color="red" size="5px"><%=request.getAttribute("day")%></font>&nbsp;&nbsp;days, 
					</td>
					<td id="jnkc" style="font-size:24px;color:red" nowrap> 
						<script>setInterval("timeview();",1000);</script>  
					</td>
					<td align="center" style="font-size:16px" nowrap>
						.The system will automatically cancel the application when it has expired. <font color="red" size="5px">&nbsp;</font>
					</td>
				</tr>
				
			</table>
		</div>
		<!-- 倒计时区域end -->
		<!-- Tab标签页begin -->
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
								<a href="javascript:change(1);">收养人基本情况(Adopter basic information)</a>
							</li>
							<li id="act2" class="">
								<a href="javascript:change(2);">抚育计划(Care plan (English))</a>
							</li>
							<li id="act3" class="">
								<a href="javascript:change(3);">抚育计划(Care plan (Chinese))</a>
							</li>
							<li id="act4" class="">
								<a href="javascript:change(4);">组织意见(Agency comments (English))</a>
							</li>
							<li id="act5" class="">
								<a href="javascript:change(5);">组织意见(Agency comments (Chinese))</a>
							</li>
				</ul>
			</div>
		</div>
		<!-- Tab标签页end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" id="AdopterInfo">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养人基本信息(Information about the adoptive parents)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0" id="femaleinfo">
						<tr>
							<td class="bz-edit-data-title" width="15%">外文姓名<br>Name</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="18%">Female</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" name="R_FEMALE_PHOTO" packageId="<%=ri_id%>" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d',lang:'en'" onchange="_setFemaleAge(this)"/>
							</td>
							<td class="bz-edit-data-title">年龄<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="国籍" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>受教育情况<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_EDUCATION" id="R_FEMALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>职业<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>健康状况<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onchange="_setFemaleHealthContent()" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>违法行为及刑事处罚<br>Criminal records</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemalePunishment(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>有无不良嗜好<br>Any bad habits</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemaleIllegalact(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0" id="maleinfo">
						<tr>
							<td class="bz-edit-data-title" width="15%">外文姓名<br>Name</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="18%">Male</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" name="R_MALE_PHOTO" packageId="<%=ri_id%>" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_MALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d',lang:'en'" onchange="_setMaleAge(this)"/>
							</td>
							<td class="bz-edit-data-title">年龄<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="国籍" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>受教育情况<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_EDUCATION" id="R_MALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>职业<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_JOB_EN" id="R_MALE_JOB_EN" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>健康状况<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onchange="_setMaleHealthContent()">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>违法行为及刑事处罚<br>Criminal records</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMALEPunishment(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setMALEPunishment(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>有无不良嗜好<br>Any bad habits</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMaleIllegalact(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setMALEIllegalact(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>婚姻状况<br>Marital status</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select prefix="R_" field="MARRY_CONDITION" id="R_MARRY_CONDITION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" isShowEN="true" notnull="Please select the Marital status!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>同居伙伴<br>Cohabitant partner</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">Yes</BZ:radio>
							</td>
							<td class="bz-edit-data-title" width="15%">同居时长<br>Cohabitation period</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:input prefix="R_" field="CONABITA_PARTNERS_TIME" id="R_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>年(Year)
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>非同性恋声明<br>Non-Homosexual statement</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="1" formTitle="" >Yes</BZ:radio>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>货币单位<br>Currency</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  isShowEN="true" notnull="Please select the Currency Unit!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>年收入<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
								<BZ:input prefix="R_" field="MALE_YEAR_INCOME" id="R_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>家庭总资产<br>Assets</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="Please write the asset of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>家庭总债务<br>Debts</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="Please write the debt of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title">家庭净资产<br>Net assets</td>
							<td class="bz-edit-data-value">
								<span id="TOTAL_MANNY"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>18周岁以下子女数量<br>Number and age of children under 18 years old</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="Please write the number and age of children under 18 years old!" />个
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>子女数量及情况<br>Number of children</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="CHILD_CONDITION_EN" id="R_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="Please write the number of children!" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>家庭住址<br>Address</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ADDRESS" id="R_ADDRESS" formTitle="" defaultValue="" notnull="Please write the family address!" maxlength="500" style="width:80%"/>
							</td>
						</tr>
						<%-- <tr>
							<td class="bz-edit-data-title">收养要求<br>Adoption preference</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ADOPT_REQUEST_EN" id="R_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%"/>
							</td>
						</tr> --%>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域" id="TendingOpinionInfo">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div id="TendingENTitle">特需儿童-抚育计划(SN child-Care plan)</div>
					<div id="TendingCNTitle">特需儿童-抚育计划(SN child-Care plan)</div>
					<div id="OpinionENTitle">特需儿童-组织意见(SN child-Agency comments)</div>
					<div id="OpinionCNTitle">特需儿童-组织意见(SN child-Agency comments)</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%" height="16px">省厅<br>Provincial Civil Affairs Department</td>
							<td class="bz-edit-data-value" width="15%">
								<span class="ENinfo">
									<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue='<%=childdata.getString("PROVINCE_ID","") %>' isShowEN="true" onlyValue="true"/>
								</span>
								<span class="CNinfo">
									<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue='<%=childdata.getString("PROVINCE_ID","") %>' onlyValue="true"/>
								</span>
							</td>
							<td class="bz-edit-data-title" width="10%">福利院<br>SWI</td>
							<td class="bz-edit-data-value" colspan="5">
								<span class="ENinfo">
									<BZ:dataValue field="WELFARE_NAME_EN" defaultValue='<%=childdata.getString("WELFARE_NAME_EN","") %>' onlyValue="true"/>
								</span>
								<span class="CNinfo">
									<BZ:dataValue field="WELFARE_NAME_EN" defaultValue='<%=childdata.getString("WELFARE_NAME_CN","") %>' onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr class="ENinfo">
							<td class="bz-edit-data-title" width="10%">儿童姓名<br>Child name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME_PINYIN" defaultValue='<%=childdata.getString("NAME_PINYIN","") %>' onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue='<%=childdata.getString("SEX","") %>' isShowEN="true" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue='<%=childdata.getString("BIRTHDAY","").substring(0, 10) %>' onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">病残种类<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL" defaultValue='<%=childdata.getString("SN_TYPE","") %>' isShowEN="true" onlyValue="true"/>
							</td>
						</tr>
						<tr class="ENinfo">
							<td class="bz-edit-data-title" width="10%">病残诊断<br>Diagnosis</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="DISEASE_EN" defaultValue='<%=childdata.getString("DISEASE_EN","") %>' onlyValue="true"/>
							</td>
						</tr>
						<tr class="CNinfo">
							<td class="bz-edit-data-title" width="10%">儿童姓名<br>Child name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" defaultValue='<%=childdata.getString("NAME","") %>' onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue='<%=childdata.getString("SEX","") %>' onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue='<%=childdata.getString("BIRTHDAY","").substring(0, 10) %>' onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">病残种类<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL" defaultValue='<%=childdata.getString("SN_TYPE","") %>' onlyValue="true"/>
							</td>
						</tr>
						<tr class="CNinfo">
							<td class="bz-edit-data-title" width="10%">病残诊断<br>Diagnosis</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="DISEASE_CN" defaultValue='<%=childdata.getString("DISEASE_CN","") %>' onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="childList" fordata="childData">
						<tr class="ENinfo">
							<td class="bz-edit-data-title" width="10%">儿童姓名<br>Child name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" isShowEN="true" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">病残种类<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" property="childData" codeName="BCZL" defaultValue="" isShowEN="true" onlyValue="true"/>
							</td>
						</tr>
						<tr class="ENinfo">
							<td class="bz-edit-data-title" width="10%">病残诊断<br>Diagnosis</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr class="CNinfo">
							<td class="bz-edit-data-title" width="10%">儿童姓名<br>Child name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">病残种类<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" property="childData" codeName="BCZL" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr class="CNinfo">
							<td class="bz-edit-data-title" width="10%">病残诊断<br>Diagnosis</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
						<tr id="TendingENInfo">
							<td class="bz-edit-data-value" colspan="8">
								医疗康复及抚育计划（英文）<br>Medical rehabilitation and care plan (Chinese)<br><br>
								<BZ:input prefix="R_" field="TENDING_EN" id="R_TENDING_EN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
							</td>
						</tr>
						<tr id="TendingCNInfo">
							<td class="bz-edit-data-value" colspan="8">
								医疗康复及抚育计划（中文）<br>Medical rehabilitation and care plan (English)<br><br>
								<BZ:input prefix="R_" field="TENDING_CN" id="R_TENDING_CN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
							</td>
						</tr>
						<tr id="OpinionENInfo">
							<td class="bz-edit-data-value" colspan="8">
								组织意见（英文）<br>Agency comments (English)<br><br>
								<BZ:input prefix="R_" field="OPINION_EN" id="R_OPINION_EN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
							</td>
						</tr>
						<tr id="OpinionCNInfo">
							<td class="bz-edit-data-value" colspan="8">
								组织意见（中文）<br>Agency comments (Chinese)<br><br>
								<BZ:input prefix="R_" field="OPINION_CN" id="R_OPINION_CN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 编辑区域end -->
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_applySubmit('0');"/>
				<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_applySubmit('1');"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
		<!-- 编辑区域end -->
	</BZ:body>
	<script>
	//********倒计时功能begin**************//
		Date.prototype.format =function(format){
		var o = {
		"M+" : this.getMonth()+1, //month
		"d+" : this.getDate(), //day
		"h+" : this.getHours(), //hour
		"m+" : this.getMinutes(), //minute
		"s+" : this.getSeconds(), //second
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter
		"S" : this.getMilliseconds() //millisecond
		 }
		if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
		 (this.getFullYear()+"").substr(4- RegExp.$1.length));
		for(var k in o)if(new RegExp("("+ k +")").test(format))
		 format = format.replace(RegExp.$1,
		 RegExp.$1.length==1? o[k] :
		 ("00"+ o[k]).substr((""+ o[k]).length));
		return format;
 	}
 	var djsTime = $("#R_DJSTIME").val();
 	var initDate="1990/01/01 "+djsTime;
	var curDate =new Date(initDate);
	
	function timeview(){ 
		  var date2 =curDate.format('hh:mm:ss');
		  jnkc.innerHTML = date2; 
		  curDate.setSeconds(curDate.getSeconds()-1); 
	} 
	//********倒计时功能end**************//
	</script>
</BZ:html>