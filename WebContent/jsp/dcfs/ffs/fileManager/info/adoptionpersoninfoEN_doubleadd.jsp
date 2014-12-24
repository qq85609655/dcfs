<%
/**   
 * @Title: adoptionpersoninfoEN_doubleadd.jsp
 * @Description:  收养人基本信息添加
 * @author yangrt   
 * @date 2014-8-25 15:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String MALE_PUNISHMENT_FLAG = (String)request.getAttribute("MALE_PUNISHMENT_FLAG");	//男收养人违法行为及刑事处罚标识,0=无，1=有
	String MALE_ILLEGALACT_FLAG = (String)request.getAttribute("MALE_ILLEGALACT_FLAG");	//男收养人有无不良嗜好标识,0=无，1=有
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//女收养人违法行为及刑事处罚标识,0=无，1=有
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//女收养人有无不良嗜好标识,0=无，1=有
%>
<BZ:html>
	<BZ:head>
		<title>收养人基本信息添加</title>
		<up:uploadResource isImage="true"/>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-ui-1.10.3.min.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//根据出生日期初始化年龄
			var male_briDate = $("#R_MALE_BIRTHDAY").val();	//男收养人的出生日期
			var female_briDate = $("#R_FEMALE_BIRTHDAY").val();	//女收养人的出生日期
			if(male_briDate != ""){
				$("#MALE_AGE").text(_getAge(male_briDate));
			}
			if(female_briDate != ""){
				$("#FEMALE_AGE").text(_getAge(male_briDate));
			}
			
			//初始化健康状况说明的显示与隐藏
			var male_health = $("#R_MALE_HEALTH").find("option:selected").text();	//男收养人的健康状况
			var female_health = $("#R_FEMALE_HEALTH").find("option:selected").text();	//女收养人的健康状况
			if(male_health == "患病/手术/残障/服药等"){
				$("#R_MALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#R_MALE_HEALTH_CONTENT_EN").hide();
			}
			if(female_health == "患病/手术/残障/服药等"){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
			}
			
			//设置身高、体重的显示方式（公制、英制）
			var measurement = $("#R_MEASUREMENT").find("option:selected").val();
			var male_height = $("#R_MALE_HEIGHT").val();	//男收养人身高
			var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人身高
			if(measurement == "0"){	//0:公制
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
				
				//将公制身高转化为英制身高,1英尺=0.3048米，1英寸=0.0254米
				var maletempfeet = parseInt(male_height) / 30.48 + "";
				var malefeet = maletempfeet.split(".")[0];
				var maleinch = (maletempfeet - malefeet) * 12;
				$("#R_MALE_FEET").val(malefeet);
				$("#R_MALE_INCH").val(maleinch.toFixed(2));
				
				var femaletempfeet = parseInt(female_height) / 30.48 + "";
				var femalefeet = femaletempfeet.split(".")[0];
				var femaleinch = (femaletempfeet - femalefeet) * 12;
				$("#R_FEMALE_FEET").val(femalefeet);
				$("#R_FEMALE_INCH").val(femaleinch.toFixed(2));
				
				//将公制体重转化为英制体重,1磅=0.45359237千克
				var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
				$("#R_MALE_WEIGHT").val(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
			}
			
			//初始化体重指数
			$("#MALE_BMI_SHOW").text($("#R_MALE_BMI").val());
			$("#FEMALE_BMI_SHOW").text($("#R_FEMALE_BMI").val());
			
			//初始化违法行为及刑事处罚说明的显示与隐藏
			var MALE_PUNISHMENT_FLAG = "<%=MALE_PUNISHMENT_FLAG%>";
			var FEMALE_PUNISHMENT_FLAG = "<%=FEMALE_PUNISHMENT_FLAG%>";
			if(MALE_PUNISHMENT_FLAG == "1"){
				$("#R_MALE_PUNISHMENT_EN").show();
			}else{
				$("#R_MALE_PUNISHMENT_EN").hide();
			}
			if(FEMALE_PUNISHMENT_FLAG == "1"){
				$("#R_FEMALE_PUNISHMENT_EN").show();
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").hide();
			}
			
			//初始化不良嗜好说明的显示与隐藏
			var MALE_ILLEGALACT_FLAG = "<%=MALE_ILLEGALACT_FLAG%>";
			var FEMALE_ILLEGALACT_FLAG = "<%=FEMALE_ILLEGALACT_FLAG%>";
			if(MALE_ILLEGALACT_FLAG == "1"){
				$("#R_MALE_ILLEGALACT_EN").show();
			}else{
				$("#R_MALE_ILLEGALACT_EN").hide();
			}
			if(FEMALE_ILLEGALACT_FLAG == "1"){
				$("#R_FEMALE_ILLEGALACT_EN").show();
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").hide();
			}
			
			//根据结婚日期初始化结婚时长
			var marry_date = $("#R_MARRY_DATE").val();
			if(marry_date != ""){
				_setMarryLength();
			}
			
			//初始化货币单位
			
			//初始化家庭净资产
			_setTotalManny();
			
		});
		
		//设置显示、隐藏男收养人的健康状况描述
		function _setMaleHealthContent(){
			var val = $("#R_MALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_MALE_HEALTH_CONTENT_EN").show();
				$("#R_MALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive father's health condition!");
			}else{
				$("#R_MALE_HEALTH_CONTENT_EN").hide();
				$("#R_MALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//设置显示、隐藏女收养人的健康状况描述
		function _setFemaleHealthContent(){
			var val = $("#R_FEMALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				$("#R_FEMALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive mother's health condition!");
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				$("#R_FEMALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//设置身高与体重的计量方式
		function _setHeightWeight(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			if(typeval == "1"){	//当选择英制时
				var male_height = $("#R_MALE_HEIGHT").val();	//男收养人公制身高
				var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人公制身高
				if(male_height != ""){
					//将公制身高转化为英制身高,1英尺=0.3048米，1英寸=0.0254米
					var maletempfeet = parseInt(male_height) / 30.48 + "";
					var malefeet = maletempfeet.split(".")[0];
					var maleinch = (maletempfeet - malefeet) * 12;
					$("#R_MALE_FEET").val(malefeet);
					alert($("#R_MALE_FEET").val());
					$("#R_MALE_INCH").val(maleinch.toFixed(2));
				}
				if(female_height != ""){
					var femaletempfeet = parseInt(female_height) / 30.48 + "";
					var femalefeet = femaletempfeet.split(".")[0];
					var femaleinch = (femaletempfeet - femalefeet) * 12;
					$("#R_FEMALE_FEET").val(femalefeet);
					$("#R_FEMALE_INCH").val(femaleinch.toFixed(2));
				}
				$("#MALE_HEIGHT_INCH").show();
				$("#MALE_HEIGHT_METRE").hide();
				$("#FEMALE_HEIGHT_INCH").show();
				$("#FEMALE_HEIGHT_METRE").hide();
				$("#R_MALE_FEET").attr("notnull","This cannot be empty!");
				$("#R_MALE_INCH").attr("notnull","This cannot be empty!");
				$("#R_FEMALE_FEET").attr("notnull","This cannot be empty!");
				$("#R_FEMALE_INCH").attr("notnull","This cannot be empty!");
				$("#R_MALE_HEIGHT").removeAttr("notnull");
				$("#R_FEMALE_HEIGHT").removeAttr("notnull");
				
				//将公制体重转化为英制体重,1磅=0.45359237千克
				var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
				if(male_weight != ""){
					$("#R_MALE_WEIGHT").val(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				}
				if(female_weight != ""){
					$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));	
				}
				$("#MALE_WEIGHT_POUNDS").show();
				$("#MALE_WEIGHT_KILOGRAM").hide();
				$("#FEMALE_WEIGHT_POUNDS").show();
				$("#FEMALE_WEIGHT_KILOGRAM").hide();
			}else{
				var male_height = $("#R_MALE_HEIGHT").val();	//男收养人公制身高
				var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人公制身高
				if(male_height == ""){
					var male_feet = $("#R_MALE_FEET").val();
					var male_inch = $("#R_MALE_INCH").val();
					if(male_feet != "" || male_inch != ""){
						//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
						$("#R_MALE_HEIGHT").val(parseInt(male_feet) * 30.48 + parseInt(male_inch) * 2.54);
					}
				}
				if(female_height == ""){
					var female_feet = $("#R_FEMALE_FEET").val();
					var female_inch = $("#R_FEMALE_INCH").val();
					if(female_feet != "" || female_inch != ""){
						//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
						$("#R_FEMALE_HEIGHT").val(parseInt(female_feet) * 30.48 + parseInt(female_inch) * 2.54);
					}
				}
				$("#MALE_HEIGHT_INCH").hide();
				$("#MALE_HEIGHT_METRE").show();
				$("#FEMALE_HEIGHT_INCH").hide();
				$("#FEMALE_HEIGHT_METRE").show();
				$("#R_MALE_HEIGHT").attr("notnull","This cannot be empty!");
				$("#R_FEMALE_HEIGHT").attr("notnull","This cannot be empty!");
				$("#R_MALE_FEET").removeAttr("notnull");
				$("#R_MALE_INCH").removeAttr("notnull");
				$("#R_FEMALE_FEET").removeAttr("notnull");
				$("#R_FEMALE_INCH").removeAttr("notnull");
				
				var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
				if(male_weight != ""){
					$("#R_MALE_WEIGHT").val(parseFloat(parseInt(male_weight) * 0.45359237).toFixed(2));
				}
				if(female_weight != ""){
					$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) * 0.45359237).toFixed(2));	
				}
				$("#MALE_WEIGHT_POUNDS").hide();
				$("#MALE_WEIGHT_KILOGRAM").show();
				$("#FEMALE_WEIGHT_POUNDS").hide();
				$("#FEMALE_WEIGHT_KILOGRAM").show();
			}
		}
		
		//自动计算男收养人的体重指数
		function _setMaleBMI(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			if(typeval == 1){
				var feetval = $("#R_MALE_FEET").val();
				var inchval = $("#R_MALE_INCH").val();
				if(feetval == "" || inchval == ""){
					page.alert("请先填写男收养人身高信息，再填写体重信息！");
					$("#R_MALE_WEIGHT").val("");
					$("#R_MALE_WEIGHT").text("");
					return;
				}else{
					//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
					var heightval = parseInt(feetval) * 0.3048 + parseInt(inchval) * 0.0254;
					//将英制体重转化为公制体重,1磅=0.45359237千克
					var weightval = parseInt($("#R_MALE_WEIGHT").val()) * 0.45359237;
					//计算体重指数
					var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
					$("#R_MALE_BMI").val(weightindex);
					$("#MALE_BMI_SHOW").text(weightindex);
				}
				
			}else{
				if($("#R_MALE_HEIGHT").val() == ""){
					page.alert("请先填写男收养人身高信息，再填写体重信息！");
					$("#R_MALE_WEIGHT").val("");
					$("#R_MALE_WEIGHT").text("");
					return;
				}else{
					var heightval = parseInt($("#R_MALE_HEIGHT").val()) / 100;
					
					var weightval = $("#R_MALE_WEIGHT").val();
					var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
					$("#R_MALE_BMI").val(weightindex);
					$("#MALE_BMI_SHOW").text(weightindex);
				}
				
			}
		}
		
		//自动计算女收养人的体重指数
		function _setFemaleBMI(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			if(typeval == 1){
				var feetval = $("#R_FEMALE_FEET").val();
				var inchval = $("#R_FEMALE_INCH").val();
				if(feetval == "" || inchval == ""){
					page.alert("请先填写女收养人身高信息，再填写体重信息！");
					$("#R_FEMALE_WEIGHT").val("");
					$("#R_FEMALE_WEIGHT").text("");
					return;
				}else{
					//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
					var heightval = parseInt(feetval) * 0.3048 + parseInt(inchval) * 0.0254;
					//将英制体重转化为公制体重,1磅=0.45359237千克
					var weightval = parseInt($("#R_FEMALE_WEIGHT").val()) * 0.45359237;
					//计算体重指数
					var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
					$("#R_FEMALE_BMI").val(weightindex);
					$("#FEMALE_BMI_SHOW").text(weightindex);
				}
			}else{
				if($("#R_FEMALE_HEIGHT").val() == ""){
					page.alert("请先填写女收养人身高信息，再填写体重信息！");
					$("#R_FEMALE_WEIGHT").val("");
					$("#R_FEMALE_WEIGHT").text("");
					return;
				}else{
					var heightval = parseInt($("#R_FEMALE_HEIGHT").val()) / 100;
					var weightval = $("#R_FEMALE_WEIGHT").val();
					var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
					$("#R_FEMALE_BMI").val(weightindex);
					$("#FEMALE_BMI_SHOW").text(weightindex);
				}
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
				$("#R_MALE_PUNISHMENT_EN").attr("notnull","Please write the criminal records of adoptive father!");
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
				$("#R_FEMALE_PUNISHMENT_EN").attr("notnull","Please write the criminal records of adoptive mother!");
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
				$("#R_MALE_ILLEGALACT_EN").attr("notnull","Please write the bad habits of adoptive father!");
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
				$("#R_FEMALE_ILLEGALACT_EN").attr("notnull","Please write the bad habits of adoptive father!");
			}
		}
		
		//根据结婚日期获取结婚时长
		function _setMarryLength(){
			var date = $("#R_MARRY_DATE").val();
			$("#MARRY_LENGTH").text(_getAge(date) + " 年(Year)");
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
		
		//提交保存收养人基本信息
		function _submit(val){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else{
				//将英制单位转化为公制进行保存
				var typeval = $("#R_MEASUREMENT").find("option:selected").val();
				if(typeval == 1){
					var malefeetval = $("#R_MALE_FEET").val();
					var maleinchval = $("#R_MALE_INCH").val();
					var femalefeetval = $("#R_FEMALE_FEET").val();
					var femaleinchval = $("#R_FEMALE_INCH").val();
					
					//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
					var maleheightval = parseInt(malefeetval) * 30.48 + parseInt(maleinchval) * 2.54;
					var femaleheightval = parseInt(femalefeetval) * 30.48 + parseInt(femaleinchval) * 2.54;
					$("#R_MALE_HEIGHT").val(maleheightval);
					$("#R_FEMALE_HEIGHT").val(femaleheightval);
					//将英制体重转化为公制体重,1磅=0.45359237千克
					var maleweightval = parseInt($("#R_MALE_WEIGHT").val()) * 0.45359237;
					var femaleweightval = parseInt($("#R_FEMALE_WEIGHT").val()) * 0.45359237;
					$("#R_MALE_WEIGHT").val(maleweightval);
					$("#R_FEMALE_WEIGHT").val(femaleweightval);
				}
				
				if(val == "保存"){
					document.getElementById("R_REG_STATE").value = "0";
				}else{
					document.getElementById("R_REG_STATE").value = "1";
				}
				
				//表单提交
				document.srcForm.action = path+"ffs/filemanager/BasicInfoSave.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="GJ;SYLX;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;">
		<BZ:form name="adoptionForm" method="post">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="REG_STATE" id="R_REG_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BMI" id="R_MALE_BMI" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BMI" id="R_FEMALE_BMI" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养人基本信息(Information about the adoptive parents)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
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
							<td class="bz-edit-data-value" width="26%">
								<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="16%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" name="R_MALE_PHOTO" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' autoUpload="true" imageStyle="width:100%;height:100%" hiddenProcess="false" proContainerStyle="width:50%;" hiddenList="true" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>
							</td>
							
							<td class="bz-edit-data-value" width="26%">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" width="16%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" name="R_FEMALE_PHOTO" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' autoUpload="true" imageStyle="width:100%;height:100%" hiddenProcess="false" proContainerStyle="width:50%;" hiddenList="true" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>
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
							<td class="bz-edit-data-title"><font color="red">*</font>国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="国籍" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" notnull="Please select the nationality of adoptive father!" width="52%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="国籍" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" notnull="Please select the nationality of adoptive mother!" width="52%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>受教育情况<br>Education</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select prefix="R_" field="MALE_EDUCATION" id="R_MALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" notnull="Please select the education of adoptive father!" width="32%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select prefix="R_" field="FEMALE_EDUCATION" id="R_FEMALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" notnull="Please select the education of adoptive mother!" width="32%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>职业<br>Occupation</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="MALE_JOB_EN" id="R_MALE_JOB_EN" formTitle="" defaultValue="" notnull="Please write the occupation of adoptive father!" maxlength="100"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" formTitle="" defaultValue="" notnull="Please write the occupation of adoptive mother!" maxlength="100"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>健康状况<br>Health condition</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" notnull="Please select the health status of adoptive father!" onchange="_setMaleHealthContent()" >
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" notnull="Please select the health status of adoptive mother!" onchange="_setFemaleHealthContent()">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>身高<br>Height</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" formTitle=""  defaultValue="" notnull="Please select the type of height and weight!" onchange="_setHeightWeight()">
									<BZ:option value="0" selected="true">公制</BZ:option>
									<BZ:option value="1">英制</BZ:option>
								</BZ:select>
								<span id="MALE_HEIGHT_INCH">
									<BZ:input prefix="R_" field="MALE_FEET" id="R_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%"/>英尺(Feet)
									<BZ:input prefix="R_" field="MALE_INCH" id="R_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%"/>英寸(Inch)
								</span>
								<span id="MALE_HEIGHT_METRE"><BZ:input prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength=""/>厘米</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="FEMALE_HEIGHT_INCH">
									<BZ:input prefix="R_" field="FEMALE_FEET" id="R_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%"/>英尺(Feet)
									<BZ:input prefix="R_" field="FEMALE_INCH" id="R_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%"/>英寸(Inch)
								</span>
								<span id="FEMALE_HEIGHT_METRE"><BZ:input prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength=""/>厘米</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>体重<br>Weight</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" formTitle="" defaultValue="" notnull="Please write the weight of adoptive father!" restriction="number" onblur="_setMaleBMI()" maxlength="50"/><span id="MALE_WEIGHT_POUNDS" style="display: none">磅(Pound)</span><span id="MALE_WEIGHT_KILOGRAM">千克(Kilogram)</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" formTitle="" defaultValue="" notnull="Please write the weight of adoptive mother!" restriction="number" onblur="_setFemaleBMI()" maxlength="50"/><span id="FEMALE_WEIGHT_POUNDS" style="display: none">磅(Pound)</span><span id="FEMALE_WEIGHT_KILOGRAM">千克(Kilogram)</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">体重指数<br>BMI</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="MALE_BMI_SHOW"><BZ:dataValue field="MALE_BMI" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="FEMALE_BMI_SHOW"><BZ:dataValue field="FEMALE_BMI" defaultValue=""/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>违法行为及刑事处罚<br>Criminal records</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMalePunishment(this)">无</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setMalePunishment(this)">有</BZ:radio>
								<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemalePunishment(this)">无</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">有</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>有无不良嗜好<br>Any bad habits</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMaleIllegalact(this)">无</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setMaleIllegalact(this)">有</BZ:radio>
								<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemaleIllegalact(this)">无</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">有</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">宗教信仰<br>Religious belief</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="MALE_RELIGION_EN" id="R_MALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_RELIGION_EN" id="R_FEMALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>前婚次数<br>Number of previous marriages</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="MALE_MARRY_TIMES" id="R_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="Please write the number of adoptive father previous marriages!"/>次
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_MARRY_TIMES" id="R_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="Please write the number of adoptive mother previous marriages!"/>次
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">婚姻状况<br>Marital status</td>
							<td class="bz-edit-data-value" width="18%">已婚</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>结婚日期<br>Date of the present marriage</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="Please select the wedding date!" onchange="_setMarryLength()"/>
							</td>
							<td class="bz-edit-data-title" width="15%">婚姻时长<br>Length of the present marriage</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="MARRY_LENGTH">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>货币单位<br>Currency Unit</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ" isShowEN="true" notnull="Please write the Currency Unit!" width="16%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>男收养人年收入<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_YEAR_INCOME" id="R_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="Please write the annual income of adoptive father!" maxlength="22"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>女收养人年收入<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="Please write the annual income of adoptive mother!" maxlength="22"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>家庭总资产<br>Asset</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="Please write the asset of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>家庭总债务<br>Debt</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="Please write the debt of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title" width="15%">家庭净资产<br>Net assets</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="TOTAL_MANNY"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>18周岁以下子女数量<br>Number and age of children under 18 years old</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="Please write the number and age of children under 18 years old!" />个
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="18%">&nbsp;</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>子女数量及情况<br>Number of children</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="CHILD_CONDITION_EN" id="R_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="Please write the number of children!" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>家庭住址<br>Address</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ADDRESS" id="R_ADDRESS" formTitle="" defaultValue="" notnull="Please write the family address!" maxlength="500" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">收养要求<br>Adoption preference</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="" defaultValue=""/>
								<BZ:input prefix="R_" field="ADOPT_REQUEST_EN" id="R_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" notnull="Please write the adoption expectation!" maxlength="500" style="width:80%"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 编辑区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>