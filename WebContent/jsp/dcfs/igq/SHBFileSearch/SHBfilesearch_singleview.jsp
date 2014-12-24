<%
/**   
 * @Title: SHBfilesearch_singleview.jsp
 * @Description:  文件查询详细信息查看页面（单亲收养）
 * @author panfeng   
 * @date 2014-9-29 下午16:19:01 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String package_id = (String)request.getAttribute("PACKAGE_ID");
	String maleFlag = (String)request.getAttribute("maleFlag");
	String femaleFlag = (String)request.getAttribute("femaleFlag");
	String ci_id = (String)request.getAttribute("CI_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
%>
<BZ:html>
	<BZ:head>
		<title>文件查询详细信息查看页面（单亲收养）</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			var maleflag = "<%=maleFlag %>";
			var femaleflag = "<%=femaleFlag %>";
			/* 初始化查看页面数据单位   */
			if($("#R_CONABITA_PARTNERS_TIME").val() != ""){
				$("#CONABITA_LENGTH").show();
			}
			if($("#R_UNDERAGE_NUM").val() != ""){
				$("#UNDERAGE_NUMBER").show();
			}
			if($("#R_INTERVIEW_TIMES").val() != ""){
				$("#MEET_TIMES").show();
			}
			if($("#R_RECOMMENDATION_NUM").val() != ""){
				$("#LETTER_NUM").show();
			}
			if($("#R_APPROVE_CHILD_NUM").val() != ""){
				$("#APPROVE_NUM").show();
			}
			if($("#R_AGE_FLOOR").val() != ""){
				$(".CHILD_AGE").show();
			}
			if(maleflag == "false" && femaleflag == "true"){
				$("#femaleshow").show();	//女收养人信息
				$("#maleshow").hide();	//男收养人信息
				$("#femalereligionshow").show();	//女收养人的宗教信仰
				$("#malereligionshow").hide();	//男收养人的宗教信仰
				//根据女收养人的出生日期计算其年龄
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
				
				//初始化健康说明
				var female_health = $("#R_FEMALE_HEALTH").val();
				if(female_health == "2"){
					$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_CN").val());
				}
				
				//初始化身高体重的显示方式
				var measurement = $("#R_MEASUREMENT").val();
				var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人身高
				if(measurement == "0"){
					$("#FEMALE_HEIGHT_INCH").hide();
					$("#FEMALE_HEIGHT_METRE").show();
					$("#FEMALE_WEIGHT_POUNDS").hide();
					$("#FEMALE_WEIGHT_KILOGRAM").show();
					
				}else if(measurement == "1"){
					$("#FEMALE_HEIGHT_INCH").show();
					$("#FEMALE_HEIGHT_METRE").hide();
					$("#FEMALE_WEIGHT_POUNDS").show();
					$("#FEMALE_WEIGHT_KILOGRAM").hide();
					
					var femaletempfeet = parseInt(female_height) / 30.48 + "";
					var femalefeet = femaletempfeet.split(".")[0];
					var femaleinch = femaletempfeet.split(".")[1] * 12;
					$("#FEMALE_HEIGHT_INCH").text(femalefeet + " 英尺(Feet)" + femaleinch + " 英寸(Inch)");
					
					var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
					$("#R_FEMALE_WEIGHT").text(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
				}
				
				//违法行为及刑事处罚
				var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
				if(female_punishment_flag == "1"){
					$("#R_FEMALE_PUNISHMENT_CN").show();
					$("#R_FEMALE_PUNISHMENT").hide();
				}else{
					$("#R_FEMALE_PUNISHMENT_CN").hide();
					$("#R_FEMALE_PUNISHMENT").show();
				}
				
				//不良嗜好
				var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
				if(female_illegalact_flag == "1"){
					$("#R_FEMALE_ILLEGALACT_CN").show();
					$("#R_FEMALE_ILLEGALACT").hide();
				}else{
					$("#R_FEMALE_ILLEGALACT_CN").hide();
					$("#R_FEMALE_ILLEGALACT").show();
				}
				
			}else if(maleflag == "true" && femaleflag == "false"){
				$("#femaleshow").hide();	//女收养人信息
				$("#maleshow").show();	//男收养人信息
				$("#femalereligionshow").hide();	//女收养人的宗教信仰
				$("#malereligionshow").show();	//男收养人的宗教信仰
				//根据女收养人的出生日期计算其年龄
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
				//初始化健康说明
				var male_health = $("#R_MALE_HEALTH").val();
				if(male_health == "2"){
					$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_CN").val());
				}
				
				//初始化身高体重的显示方式
				var measurement = $("#R_MEASUREMENT").val();
				var male_height = $("#R_MALE_HEIGHT").val();	//女收养人身高
				if(measurement == "0"){
					$("#MALE_HEIGHT_INCH").hide();
					$("#MALE_HEIGHT_METRE").show();
					$("#MALE_WEIGHT_POUNDS").hide();
					$("#MALE_WEIGHT_KILOGRAM").show();
					
				}else if(measurement == "1"){
					$("#MALE_HEIGHT_INCH").show();
					$("#MALE_HEIGHT_METRE").hide();
					$("#MALE_WEIGHT_POUNDS").show();
					$("#MALE_WEIGHT_KILOGRAM").hide();
					
					var maletempfeet = parseInt(male_height) / 30.48 + "";
					var malefeet = maletempfeet.split(".")[0];
					var maleinch = maletempfeet.split(".")[1] * 12;
					$("#MALE_HEIGHT_INCH").text(malefeet + " 英尺(Feet)" + maleinch + " 英寸(Inch)");
					
					var male_weight = $("#R_MALE_WEIGHT").val();	//女收养人体重
					$("#R_MALE_WEIGHT").text(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				}
				
				//违法行为及刑事处罚
				var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
				if(male_punishment_flag == "1"){
					$("#R_MALE_PUNISHMENT_CN").show();
					$("#R_MALE_PUNISHMENT").hide();
				}else{
					$("#R_MALE_PUNISHMENT_CN").hide();
					$("#R_MALE_PUNISHMENT").show();
				}
				
				//不良嗜好
				var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
				if(male_illegalact_flag == "1"){
					$("#R_MALE_ILLEGALACT_CN").show();
					$("#R_MALE_ILLEGALACT").hide();
				}else{
					$("#R_MALE_ILLEGALACT_CN").hide();
					$("#R_MALE_ILLEGALACT").show();
				}
			}
			
			//家庭净资产
			var total_asset = $("#R_TOTAL_ASSET").val();
			var total_debt = $("#R_TOTAL_DEBT").val();
			$("#TOTAL_MANNY").text(total_asset - total_debt);
			
			//有效期限
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1" && valid_period != ""){
				$("#R_PERIOD").text(valid_period + " 月(Month)");
			}else if(valid_period == "-1"){
				$("#R_PERIOD").text("长期");
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
</BZ:html>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;ETXB;BCZL;PROVINCE;CHILD_TYPE;ETSFLX;ETLY;YPZT">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_MARRY_TIMES" id="R_MALE_MARRY_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="INTERVIEW_TIMES" id="R_INTERVIEW_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="RECOMMENDATION_NUM" id="R_RECOMMENDATION_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="APPROVE_CHILD_NUM" id="R_APPROVE_CHILD_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="AGE_FLOOR" id="R_AGE_FLOOR" defaultValue=""/>
	<!-- 隐藏区域end -->
	<!-- 查看区域begin -->
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">收养组织(CN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养组织(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(EN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">文件类型</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">收养类型</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
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
				<div>收养人基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="femaleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">外文姓名</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">性别</td>
						<td class="bz-edit-data-value" width="18%">女</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<img src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">年龄</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">受教育情况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">身高</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=公制;1=英制;" defaultValue=""/>
							<span id="FEMALE_HEIGHT_INCH"></span>
							<span id="FEMALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/>厘米
							</span>
						</td>
						<td class="bz-edit-data-title">体重</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/>
							<span id="FEMALE_WEIGHT_POUNDS" style="display: none;">磅(Pound)</span>
							<span id="FEMALE_WEIGHT_KILOGRAM" style="display: none;">千克</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">体重指数</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">违法行为及刑事处罚<br>Criminal records</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_CN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">有无不良嗜好</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_CN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue=""/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0" id="maleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">外文姓名</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">性别</td>
						<td class="bz-edit-data-value" width="18%">男</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<img src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">年龄</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">受教育情况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_CN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">身高</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=公制;1=英制;" defaultValue=""/>
							<span id="MALE_HEIGHT_INCH"></span>
							<span id="MALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="MALE_HEIGHT" defaultValue=""/>厘米
							</span>
						</td>
						<td class="bz-edit-data-title">体重</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_WEIGHT" defaultValue=""/>
							<span id="MALE_WEIGHT_POUNDS" style="display: none;">磅(Pound)</span>
							<span id="MALE_WEIGHT_KILOGRAM" style="display: none;">千克</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">体重指数</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">违法行为及刑事处罚</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_MALE_PUNISHMENT_CN">
								<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">有无不良嗜好</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_MALE_ILLEGALACT_CN">
								<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue=""/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">宗教信仰</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="femalereligionshow"><BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue=""/></span>
							<span id="malereligionshow"><BZ:dataValue field="MALE_RELIGION_CN" defaultValue=""/></span>
						</td>
						<td class="bz-edit-data-title" width="15%">婚姻状况</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">同居伙伴</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CONABITA_PARTNERS" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">同居时长</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue=""/><span id="CONABITA_LENGTH" style="display: none;">年</span>
						</td>
						<td class="bz-edit-data-title">非同性恋声明</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GAY_STATEMENT" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">货币单位</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">年收入<br>Annual income</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">家庭总资产<br>Asset</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">家庭总债务<br></td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭净资产<br>Net assets</td>
						<td class="bz-edit-data-value">
							<span id="TOTAL_MANNY"></span>
						</td>
						<td class="bz-edit-data-title">18周岁以下子女数量</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/><span id="UNDERAGE_NUMBER" style="display: none;">个</span>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">子女数量及情况</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭住址</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADDRESS" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养要求</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<%
	if(!"".equals(ci_id)){
	%>
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>匹配儿童或关联特需儿童基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
				<BZ:for property="List" fordata="childData">
				<%
					String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
				%>
					<tr>
						<td class="bz-edit-data-title" width="13%">儿童编号</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_NO" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">儿童类型</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">身份证号</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="ID_CARD" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" rowspan="4" width="16%">
							<img src='<up:attDownload attTypeCode="CI" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">省份</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">福利院</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">特别关注</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=否;1=是" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">儿童身份</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">入院日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENTER_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">有无同胞</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=无;1=有" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">送养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SENDER" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">报送日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEND_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">送养人地址</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残种类</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
						</td>
						<td class="bz-edit-data-title">儿童来源</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_SOURCE" property="childData" codeName="ETLY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">儿童户籍地</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残诊断</td>
						<td class="bz-edit-data-value" colspan="6">
							<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue=""/>
						</td>
					</tr>
				</BZ:for>
				</table>
			</div>
		</div>
	</div>
	<%
	}
	if(!"".equals(ri_id)){
	%>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>预批基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<BZ:for property="riList" fordata="preData">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">预批申请编号</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="REQ_NO" property="preData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">预批状态</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="RI_STATE" property="preData" codeName="YPZT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">抚育计划</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="TENDING_CN" property="preData" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">组织意见</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="OPINION_CN" property="preData" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			</BZ:for>
		</div>
	</div>
	<%
	}
	%>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>家庭调查及组织意见信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">完成家调组织名称</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭报告完成日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" type="Date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">会见次数</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/><span id="MEET_TIMES" style="display: none;">次</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">推荐信</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/><span id="LETTER_NUM" style="display: none;">封(Number of letter)</span>
						</td>
						<td class="bz-edit-data-title">心理评估报告</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEART_REPORT" defaultValue="" codeName="ADOPTER_HEART_REPORT"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养动机</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="ADOPT_MOTIVATION" defaultValue="" codeName="ADOPTER_ADOPT_MOTIVATION"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家中10周岁及以上孩子对收养的意见</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILDREN_ABOVE" defaultValue="" codeName="ADOPTER_CHILDREN_ABOVE"/>
						</td>
						<td class="bz-edit-data-title">有无指定监护人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">不遗弃不虐待声明</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">抚育计划</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">收养前准备</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">风险意识</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">同意递交安置后报告声明</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">家中有无其他人同住</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">家中其他人同住说明</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">育儿经验</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PARENTING" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">社工意见</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SOCIALWORKER" checkValue="1=支持;2=保留意见;3=不支持;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭需说明的其他事项</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_CN" defaultValue=""/>
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
				<div>政府批准信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">批准日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">有效期限</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="R_PERIOD"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">批准儿童数量</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/><span id="APPROVE_NUM" style="display: none;">个</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养儿童年龄</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="AGE_FLOOR" defaultValue=""/><span class="CHILD_AGE" style="display: none;">岁~</span>
							<BZ:dataValue field="AGE_UPPER" defaultValue=""/><span class="CHILD_AGE" style="display: none;">岁</span>
						</td>
						<td class="bz-edit-data-title" width="15%">收养儿童性别</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养儿童健康状况</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CHILDREN_HEALTH_CN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH"/>
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
				<div>附件信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">跨国收养申请书</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList id="R_ADOPTION_APPLICATION" attTypeCode="AF" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSY %>"/>
						</td>
						<td class="bz-edit-data-title" width="15%">出生证明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_BIRTH_CERTIFICATE" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_CSZM %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">婚姻状况证明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_MARITAL_STATUS" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_HYZK %>"/>
						</td>
						<td class="bz-edit-data-title" width="15%">职业、经济收入及财政状况证明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_CAREER_PROVE" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_ZJCZM %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">单身声明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_SINGLE_STATEMENT" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_DQSM %>"/>
						</td>
						<td class="bz-edit-data-title" width="15%">非同性恋声明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_NONGAY_STATEMENT" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_FTSM %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">身体健康检查证明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_HEALTH_CHECK" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_STJK %>"/>
						</td>
					
						<td class="bz-edit-data-title" width="15%">有无受过刑事处罚证明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_CRIMINAL_PENALTIES" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_XSCF %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">家庭调查报告</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_HOUSEHOLD_SURVEY" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_JTQK %>"/>
						</td>
					
						<td class="bz-edit-data-title" width="15%">心理评估报告</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_ASSESSMENT_REPORT" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_XLDC %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养申请人所在国主管机关同意其跨国收养子女的证明</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_INTERCOUNTRY_ADOPTION" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSYZM %>"/>
						</td>
					
						<td class="bz-edit-data-title" width="15%">家庭生活照片</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_LIFE_PHOTOS" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_SHZP %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">推荐信</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_RECOMMENDATION_LETTER" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_TJX %>"/>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 查看区域end -->
</BZ:body>