<%
/**   
 * @Title: suppleFile_doubleview.jsp
 * @Description:  双亲收养文件信息查看页面
 * @author yangrt   
 * @date 2014-8-26 14:15:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String packageId = (String)request.getAttribute("PACKAGE_ID");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>双亲收养文件信息查看页面</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			/* 初始化查看页面数据   */
			//根据男、女收养人的出生日期计算其年龄
			var male_birth = $("#R_MALE_BIRTHDAY").val();
			var female_birth = $("#R_FEMALE_BIRTHDAY").val();
			if(male_birth != ""){
				$("#MALE_AGE").text(_getAge(male_birth));
			}
			if(female_birth != ""){
				$("#FEMALE_AGE").text(_getAge(female_birth));
			}
			
			
			//初始化健康说明
			var male_health = $("#R_MALE_HEALTH").val();
			var female_health = $("#R_FEMALE_HEALTH").val();
			if(male_health == "2"){
				$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_EN").val());
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_EN").val());
			}
			
			//初始化身高体重的显示方式
			var measurement = $("#R_MEASUREMENT").val();
			var male_height = $("#R_MALE_HEIGHT").val();	//男收养人身高
			var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人身高
			if(measurement == "0"){
				$("#MALE_HEIGHT_INCH").hide();
				$("#MALE_HEIGHT_METRE").show();
				$("#FEMALE_HEIGHT_INCH").hide();
				$("#FEMALE_HEIGHT_METRE").show();
				$("#MALE_WEIGHT_POUNDS").hide();
				$("#MALE_WEIGHT_KILOGRAM").show();
				$("#FEMALE_WEIGHT_POUNDS").hide();
				$("#FEMALE_WEIGHT_KILOGRAM").show();
				
			}else{
				$("#MALE_HEIGHT_INCH").show();
				$("#MALE_HEIGHT_METRE").hide();
				$("#FEMALE_HEIGHT_INCH").show();
				$("#FEMALE_HEIGHT_METRE").hide();
				$("#MALE_WEIGHT_POUNDS").show();
				$("#MALE_WEIGHT_KILOGRAM").hide();
				$("#FEMALE_WEIGHT_POUNDS").show();
				$("#FEMALE_WEIGHT_KILOGRAM").hide();
				
				var maletempfeet = parseInt(male_height) / 30.48 + "";
				var malefeet = maletempfeet.split(".")[0];
				var maleinch = maletempfeet.split(".")[1] * 12;
				$("#MALE_HEIGHT_INCH").text(malefeet + " 英尺(Feet)" + maleinch + " 英寸(Inch)");
				
				var femaletempfeet = parseInt(female_height) / 30.48 + "";
				var femalefeet = femaletempfeet.split(".")[0];
				var femaleinch = femaletempfeet.split(".")[1] * 12;
				$("#FEMALE_HEIGHT_INCH").text(femalefeet + " 英尺(Feet)" + femaleinch + " 英寸(Inch)");
				
				var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
				$("#R_MALE_WEIGHT").text(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				$("#R_FEMALE_WEIGHT").text(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
			}
			
			//违法行为及刑事处罚
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#R_MALE_PUNISHMENT_EN").show();
				$("#R_MALE_PUNISHMENT").hide();
			}else{
				$("#R_MALE_PUNISHMENT_EN").hide();
				$("#R_MALE_PUNISHMENT").show();
			}
			if(female_punishment_flag == "1"){
				$("#R_FEMALE_PUNISHMENT_EN").show();
				$("#R_FEMALE_PUNISHMENT").hide();
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").hide();
				$("#R_FEMALE_PUNISHMENT").show();
			}
			
			//不良嗜好
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#R_MALE_ILLEGALACT_EN").show();
				$("#R_MALE_ILLEGALACT").hide();
			}else{
				$("#R_MALE_ILLEGALACT_EN").hide();
				$("#R_MALE_ILLEGALACT").show();
			}
			if(female_illegalact_flag == "1"){
				$("#R_FEMALE_ILLEGALACT_EN").show();
				$("#R_FEMALE_ILLEGALACT").hide();
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").hide();
				$("#R_FEMALE_ILLEGALACT").show();
			}
			
			//结婚时长
			var marry_date = $("#R_MARRY_DATE").val();
			$("#MARRY_LENGTH").text(_getAge(marry_date));
			
			//家庭净资产
			var total_asset = $("#R_TOTAL_ASSET").val();
			var total_debt = $("#R_TOTAL_DEBT").val();
			$("#TOTAL_MANNY").text(total_asset - total_debt);
			
			//有效期限
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1" && valid_period != ""){
				$("#R_PERIOD").text(valid_period + " 月(Month)");
			}else if(valid_period == "-1"){
				$("#R_PERIOD").text("长期(Long-term)");
			}
			
			//设置附件上传项
			var file_type = $("#R_FILE_TYPE").val();
			if(file_type == "22"){
				$("#tj").show();
				$("#tp_ts").hide();
			}else{
				$("#tp_ts").show();
				$("#tj").hide();
			}
			
			//设置预锁定儿童信息的显示与隐藏
			if(file_type == "20" || file_type == "21" || file_type == "22" || file_type == "23"){
				$("#pre_approved").show();
			}else{
				$("#pre_approved").hide();
			}
		});
		
		//根据出生日期获取周岁年龄
		function _getAge(strBirthday){       
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
		
	</script>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ETXB;ORG_LIST;BCZL;SGYJ;">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
	<!-- 隐藏区域end -->
	
	<!-- 按钮区域begin -->
	<div class="blue-hr"> 
		<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>&nbsp;&nbsp;
		<button class="btn btn-sm btn-primary" onclick="window.close();">Close</button>
	</div>
	<!-- 按钮区域end -->
	<div id='PrintArea'>
	<!-- 查看区域begin -->
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">收养组织(CN)<br>Agency(CN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养组织(EN)<br>Agency(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">文件类型<br>Document type</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">收养类型<br>Adoption type</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div class="title3" style="height: 35px; padding-top: 5px;">收养人基本信息(Information about the adoptive parents)</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="16%">&nbsp;</td>
						<td class="bz-edit-data-title" colspan="2" style="text-align:center">男收养人(Adoptive father)</td>
						<td class="bz-edit-data-title" colspan="2" style="text-align:center">女收养人(Adoptive mother)</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">外文姓名<br>Name</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="16%">出生日期<br>D.O.B</td>
						<td class="bz-edit-data-value" width="24%">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" width="20%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;">
						</td>
						<td class="bz-edit-data-value" width="24%">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" width="16%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;">
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">年龄<br>Age</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国籍<br>Nationality</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">受教育情况<br>Education</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业<br>Occupation</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况<br>Health condition</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">身高<br>Height</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=Metric system;1=British system;" defaultValue="" onlyValue="true"/>
							<span id="MALE_HEIGHT_INCH"></span>
							<span id="MALE_HEIGHT_METRE">
								<BZ:dataValue field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>厘米(Centimeter)
							</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="FEMALE_HEIGHT_INCH"></span>
							<span id="FEMALE_HEIGHT_METRE">
								<BZ:dataValue field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>厘米(Centimeter)
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">体重<br>Weight</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
							<span id="MALE_WEIGHT_POUNDS" style="display: none">磅(Pound)</span>
							<span id="MALE_WEIGHT_KILOGRAM" style="display: none">千克(Kilogram)</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
							<span id="FEMALE_WEIGHT_POUNDS">磅(Pound)</span>
							<span id="FEMALE_WEIGHT_KILOGRAM">千克(Kilogram)</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">体重指数<br>BMI</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_BMI" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_BMI" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">违法行为及刑事处罚<br>Criminal records</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_MALE_PUNISHMENT_EN">
								<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_EN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">有无不良嗜好<br>Any bad habits</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_MALE_ILLEGALACT_EN">
								<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_EN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">宗教信仰<br>Religious belief</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_RELIGION_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">货币单位<br>Currency</td>
						<td class="bz-edit-data-value" colspan="4">
							<BZ:dataValue field="CURRENCY" codeName="HBBZ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">年收入<br>Annual income</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">前婚次数<br>Number of previous marriages</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>次(Times)
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>次(Times)
						</td>
					</tr>
				</table>
				<h1 style="height: 0px;max-height: 0px">&nbsp;</h1>
				<p></p>
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">婚姻状况<br>Marital status</td>
						<td class="bz-edit-data-value" width="18%">Married</td>
						<td class="bz-edit-data-title" width="15%">结婚日期<br>Date of the present marriage</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">婚姻时长<br>Length of the present marriage</td>
						<td class="bz-edit-data-value" width="19%">
							<span id="MARRY_LENGTH"></span>年(Year)
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">家庭总资产<br>Assets</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭总债务<br>Debts</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭净资产<br>Net assets</td>
						<td class="bz-edit-data-value" width="19%">
							<span id="TOTAL_MANNY"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">18周岁以下子女数量<br>Number and age of children under 18 years old</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>&nbsp;个</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="18%">&nbsp;</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">子女数量及情况<br>Number of children</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">家庭住址<br>Address </td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养要求<br>Adoption preference</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div class="title3" style="height: 35px; padding-top: 5px;">家庭调查及组织意见信息(Home study and agency comments)</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">完成家调组织名称<br>Adoption agency preparing the report</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭报告完成日期<br>Date of completion for home study</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" type="Date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">会见次数<br>Meeting times</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue="" onlyValue="true"/>次(Times)
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">推荐信<br>Recommendation letter</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue="" onlyValue="true"/>封(Number of letter)
						</td>
						<td class="bz-edit-data-title">心理评估报告<br>Psychological assessment</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEART_REPORT" defaultValue="" codeName="ADOPTER_HEART_REPORT" isShowEN="true" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养动机<br>Motive of adoption</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="ADOPT_MOTIVATION" defaultValue="" codeName="ADOPTER_ADOPT_MOTIVATION" isShowEN="true" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家中10周岁及以上孩子对收养的意见<br>Opinion of adoption by children in the family over age 10</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILDREN_ABOVE" defaultValue="" codeName="ADOPTER_CHILDREN_ABOVE" isShowEN="true" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">有无指定监护人<br>Any designated guardian</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">不遗弃不虐待声明<br>Statement of no abandonment and no abuse</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">抚育计划<br>Care plan</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收养前准备<br>Pre-adoption preparation</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">风险意识<br>Risk awareness</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">同意递交安置后报告声明<br>Statement of consent for post-placement reports</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">家中有无其他人同住<br>Anyone else living with the family</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">家中其他人同住说明<br>Description of whether any other people living with the family</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">育儿经验<br>Parenting experience</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PARENTING" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">社工意见<br>Conclusion of social worker</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SOCIALWORKER" codeName="SGYJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭需说明的其他事项<br>Other issues requiring clarification from the adoptive family</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<h1></h1>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div class="title3" style="height: 35px; padding-top: 5px;">政府批准信息(Government approval information)</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">批准日期<br>Date of approval</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">有效期限<br>Validity period</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="R_PERIOD"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">批准儿童数量<br>Number of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>个
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养儿童年龄<br>Age of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="AGE_FLOOR" defaultValue=""/>岁~
							<BZ:dataValue field="AGE_UPPER" defaultValue=""/>岁
						</td>
						<td class="bz-edit-data-title" width="15%">收养儿童性别<br>Gender of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养儿童健康状况<br>Health status of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CHILDREN_HEALTH_EN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH" isShowEN="true" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</div>
	<div class="bz-edit clearfix" desc="编辑区域" id="pre_approved">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>预批锁定儿童基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
				<BZ:for property="List" fordata="childData">
				<%
					String ci_id = ((Data)pageContext.getAttribute("childData")).getString("CI_ID","");
					String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD",ci_id);
				%>
					<tr>
						<td class="bz-edit-data-title" width="13%">省份<br>Province</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="PROVINCE_ID" isShowEN="true" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">福利院<br>SWI</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="WELFARE_NAME_EN" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">姓名<br>Name</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" rowspan="3" width="16%">
							<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=photo_card%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:160px;">
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">性别<br>Sex</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" property="childData" codeName="ETXB" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">特别关注<br>Special focus</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=No;1=Yes" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残种类<br>SN type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL" isShowEN="true" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件递交期限<br>Document submission deadline</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="VALID_PERIOD" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">有无同胞<br>Is Twins</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=No;1=Yes" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残诊断<br>Diagnosis</td>
						<td class="bz-edit-data-value" colspan="6">
							<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</BZ:for>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="编辑区域" id="print2">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>附件信息(Attachment)</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-value">
							<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_PARENTS%>&packageID=<%=packageId %>" frameborder=0 width="100%" ></IFRAME>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 查看区域end -->
<script>
//打印控制语句
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>
</BZ:body>
</BZ:html>