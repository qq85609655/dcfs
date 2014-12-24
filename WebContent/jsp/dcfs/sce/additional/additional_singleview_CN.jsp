<%
/**   
 * @Title: additional_singleview_CN.jsp
 * @Description:  预批补充查询查看页面（单亲收养/中文）
 * @author panfeng   
 * @date 2014-9-12 上午10:11:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String maleFlag = (String)request.getAttribute("maleFlag");
	String femaleFlag = (String)request.getAttribute("femaleFlag");
%>
<BZ:html>
	<BZ:head>
		<title>预批补充查询查看页面（单亲收养）</title>
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
			/* 初始化查看页面数据   */
			var maleflag = "<%=maleFlag %>";
			var femaleflag = "<%=femaleFlag %>";
			if(maleflag == "false" && femaleflag == "true"){
				$("#femaleshow").show();	//女收养人信息
				$("#maleshow").hide();	//男收养人信息
				//根据女收养人的出生日期计算其年龄
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
				
				//初始化女健康说明
				var female_health = $("#R_FEMALE_HEALTH").val();
				if(female_health == "2"){
					$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_CN").val());
				}
				
				//女方违法行为及刑事处罚
				var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
				if(female_punishment_flag == "1"){
					$("#R_FEMALE_PUNISHMENT_CN").show();
					$("#R_FEMALE_PUNISHMENT").hide();
				}else{
					$("#R_FEMALE_PUNISHMENT_CN").hide();
					$("#R_FEMALE_PUNISHMENT").show();
				}
				
				//女方不良嗜好
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
				//根据女收养人的出生日期计算其年龄
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
				//初始化男健康说明
				var male_health = $("#R_MALE_HEALTH").val();
				if(male_health == "2"){
					$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_CN").val());
				}
				
				//男方违法行为及刑事处罚
				var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
				if(male_punishment_flag == "1"){
					$("#R_MALE_PUNISHMENT_CN").show();
					$("#R_MALE_PUNISHMENT").hide();
				}else{
					$("#R_MALE_PUNISHMENT_CN").hide();
					$("#R_MALE_PUNISHMENT").show();
				}
				
				//男方不良嗜好
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
			
			//设置附件上传项
			var file_type = $("#R_FILE_TYPE").val();
			if(file_type == "22"){
				$("#tj").show();
				$("#tp_ts").hide();
			}else{
				$("#tp_ts").show();
				$("#tj").hide();
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
	<BZ:body property="infodata" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
		<!-- 隐藏区域end -->
		
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养人基本信息(Information about the adoptive parents)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<%
					if("false".equals(maleFlag) && "true".equals(femaleFlag)){
					%>
					<table class="bz-edit-data-table" border="0" id="femaleshow">
						<tr>
							<td class="bz-edit-data-title" width="15%">外文姓名<br>Name</td>
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
							<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">年龄<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">受教育情况<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">职业<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">健康状况<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
								<span id="FEMALE_HEALTH_CONTENT"></span>
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
							<td class="bz-edit-data-title">有无不良嗜好<br>Any bad habits</td>
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
					<%
					}else if("true".equals(maleFlag) && "false".equals(femaleFlag)){
					%>
					<table class="bz-edit-data-table" border="0" id="maleshow">
						<tr>
							<td class="bz-edit-data-title" width="15%">外文姓名<br>Name</td>
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
							<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">年龄<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">受教育情况<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">职业<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_JOB_CN" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">健康状况<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
								<span id="MALE_HEALTH_CONTENT"></span>
							</td>
							<td class="bz-edit-data-title">违法行为及刑事处罚<br>Criminal records</td>
							<td class="bz-edit-data-value">
								<span id="R_MALE_PUNISHMENT">
									<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
								</span>
								<span id="R_MALE_PUNISHMENT_CN">
									<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>
								</span>
							</td>
							<td class="bz-edit-data-title">有无不良嗜好<br>Any bad habits</td>
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
					<%
					}
					%>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">婚姻状况</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">同居伙伴</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:dataValue field="CONABITA_PARTNERS" checkValue="0=无;1=有;" defaultValue=""/>
								</td>
								<td class="bz-edit-data-title" width="15%">同居时长</td>
								<td class="bz-edit-data-value" width="19%">
									<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue=""/>年
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">非同性恋声明</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="GAY_STATEMENT" checkValue="0=无;1=有;" defaultValue=""/>
								</td>
								<td class="bz-edit-data-title">货币单位</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="CURRENCY" defaultValue="" codeName="HBBZ"/>
								</td>
								<td class="bz-edit-data-title">年收入<br>Annual income</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">家庭总资产<br>Asset</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
								</td>
								<td class="bz-edit-data-title">家庭总债务<br></td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
								</td>
								<td class="bz-edit-data-title">家庭净资产<br>Net assets</td>
								<td class="bz-edit-data-value">
									<span id="TOTAL_MANNY"></span>
							</tr>
							<tr>
								</td>
								<td class="bz-edit-data-title">18周岁以下子女数量<br>Number and age of children under 18 years old</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/>个
								</td>
								<td class="bz-edit-data-title">&nbsp;</td>
								<td class="bz-edit-data-value">&nbsp;</td>
								<td class="bz-edit-data-title">&nbsp;</td>
								<td class="bz-edit-data-value">&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">子女数量及情况<br>Number of children</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">家庭住址<br>Address</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:dataValue field="ADDRESS" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">收养要求<br>Adoption preference</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 查看区域end -->
	</BZ:body>
</BZ:html>