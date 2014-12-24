<%
/**   
 * @Title: apply_translation_revise.jsp
 * @Description:  预批申请翻译页面
 * @author panfeng   
 * @date 2014-10-14 下午17:48:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>预批申请翻译页面</title>
		<BZ:webScript edit="true"/>
		<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
	</BZ:head>
	<script>
	
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			$('#tab-container').easytabs();
			//根据男、女收养人的出生日期计算其年龄
			var male_birth = $("#R_MALE_BIRTHDAY").val();
			var female_birth = $("#R_FEMALE_BIRTHDAY").val();
			if(male_birth != ""){
				$("#MALE_AGE").text(_getAge(male_birth));
			}
			if(female_birth != ""){
				$("#FEMALE_AGE").text(_getAge(female_birth));
			}
			
			//职业
			var male_job_cn = $("#R_MALE_JOB_CN").val();
			var male_job_en = $("#R_MALE_JOB_EN").val();
			var female_job_cn = $("#R_FEMALE_JOB_CN").val();
			var female_job_en = $("#R_FEMALE_JOB_EN").val();
			if(male_job_cn != "" || male_job_en != ""){
				$("#MALE_JOB_AREA").show();
			}else{
				$("#MALE_JOB_AREA").hide();
			}
			if(female_job_cn != "" || female_job_en != ""){
				$("#FEMALE_JOB_AREA").show();
			}else{
				$("#FEMALE_JOB_AREA").hide();
			}
			
			//健康说明
			var male_health = $("#R_MALE_HEALTH").val();
			var female_health = $("#R_FEMALE_HEALTH").val();
			if(male_health == "2"){
				$("#MALE_HEALTH_AREA").show();
				$("#MALE_HEALTH_AREA2").show();
			}else{
				$("#MALE_HEALTH_AREA").hide();
				$("#MALE_HEALTH_AREA2").hide();
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_AREA").show();
				$("#FEMALE_HEALTH_AREA2").show();
			}else{
				$("#FEMALE_HEALTH_AREA").hide();
				$("#FEMALE_HEALTH_AREA2").hide();
			}
			
			//违法行为及刑事处罚
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#MALE_PUNISHMENT_AREA").show();
				$("#MALE_PUNISHMENT_AREA2").show();
			}else{
				$("#MALE_PUNISHMENT_AREA").hide();
				$("#MALE_PUNISHMENT_AREA2").hide();
			}
			if(female_punishment_flag == "1"){
				$("#FEMALE_PUNISHMENT_AREA").show();
				$("#FEMALE_PUNISHMENT_AREA2").show();
			}else{
				$("#FEMALE_PUNISHMENT_AREA").hide();
				$("#FEMALE_PUNISHMENT_AREA2").hide();
			}
			
			//不良嗜好
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#MALE_ILLEGALACT_AREA").show();
				$("#MALE_ILLEGALACT_AREA2").show();
			}else{
				$("#MALE_ILLEGALACT_AREA").hide();
				$("#MALE_ILLEGALACT_AREA2").hide();
			}
			if(female_illegalact_flag == "1"){
				$("#FEMALE_ILLEGALACT_AREA").show();
				$("#FEMALE_ILLEGALACT_AREA2").show();
			}else{
				$("#FEMALE_ILLEGALACT_AREA").hide();
				$("#FEMALE_ILLEGALACT_AREA2").hide();
			}
			
			//子女数量及情况
			var child_condition_cn = $("#R_CHILD_CONDITION_CN").val();
			var child_condition_en = $("#R_CHILD_CONDITION_EN").val();
			if(child_condition_cn != "" || child_condition_en != ""){
				$("#CHILD_CONDITION_AREA").show();
				$("#CHILD_CONDITION_AREA2").show();
			}else{
				$("#CHILD_CONDITION_AREA").hide();
				$("#CHILD_CONDITION_AREA2").hide();
			}
			
			//收养要求
			var adopt_request_cn = $("#R_ADOPT_REQUEST_CN").val();
			var adopt_request_en = $("#R_ADOPT_REQUEST_EN").val();
			if(adopt_request_cn != "" || adopt_request_en != ""){
				$("#ADOPT_REQUEST_AREA").show();
				$("#ADOPT_REQUEST_AREA2").show();
			}else{
				$("#ADOPT_REQUEST_AREA").hide();
				$("#ADOPT_REQUEST_AREA2").hide();
			}
			
			//家中有无其他人同住
			if($("#R_IS_FAMILY_OTHERS_FLAG").val() == "1"){
				$("#IS_FAMILY_OTHERS_AREA").show();
				$("#IS_FAMILY_OTHERS_AREA2").show();
			}else{
				$("#IS_FAMILY_OTHERS_AREA").hide();
				$("#IS_FAMILY_OTHERS_AREA2").hide();
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
		
		//翻译保存
		function _save() {
		if (_check(document.srcForm)) {
			document.getElementById("P_TRANSLATION_STATE").value = "1";
			document.getElementById("R_TRANSLATION_STATE").value = "1";
			document.srcForm.action = path + "/sce/translation/preTranslationSave.action?type=save";
			
			document.srcForm.submit();
		  }
		}
		//翻译完成提交
		function _submit() {
		if (confirm("确定提交吗？提交后翻译信息无法修改！")) {
			document.getElementById("P_TRANSLATION_STATE").value = "2";
			document.getElementById("R_TRANSLATION_STATE").value = "2";
			document.srcForm.action = path + "/sce/translation/preTranslationSave.action?type=submit";
			document.srcForm.submit();
		  }
		}
		//返回列表
		function _goback(){
			document.srcForm.action = path + "/sce/translation/applyTranslationList.action";
			document.srcForm.submit();
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="GJ">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="P_" field="AT_ID"                    id="P_AT_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="P_" field="TRANSLATION_STATE"        id="P_TRANSLATION_STATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"        id="R_TRANSLATION_STATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="RI_ID"              		 id="R_RI_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY"            id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY"          id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH"              id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH"            id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG"     id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG"   id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG"     id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG"   id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="IS_FAMILY_OTHERS_FLAG"    id="R_IS_FAMILY_OTHERS_FLAG" defaultValue=""/>
	<!-- 隐藏区域end -->
	<!-- 编辑区域begin -->
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
            <li class='tab'><a href="#tab1">收养人基本信息</a></li>
            <li class='tab'><a href="#tab2">抚育计划</a></li>
            <li class='tab'><a href="#tab3">组织意见</a></li>
        </ul>
        <div class='panel-container'>
			<div id="tab1">
				<table class="bz-edit-data-table" border="0">
                    <tr>
                        <td class="bz-edit-data-title" width="15%">收养组织(CN)</td>
                        <td class="bz-edit-data-value" colspan="5">
                            <BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="bz-edit-data-title">收养组织(EN)</td>
                        <td class="bz-edit-data-value" colspan="5">
                            <BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
                        </td>
                    </tr>
                </table>
				<table class="bz-edit-data-table" border="0">
					<tr>
                          	<td class="bz-edit-data-title" colspan="6" style="text-align:center"><b>收养人基本信息</b></td>
                      	</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">&nbsp;</td>
						<td class="bz-edit-data-title" width="40%" style="text-align:center">男收养人</td>
						<td class="bz-edit-data-title" width="40%" style="text-align:center">女收养人</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">外文姓名</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue=""  onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">年龄</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="MALE_JOB_EN" id="R_MALE_JOB_EN" type="String" formTitle="男收养人职业" defaultValue="" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" type="String" formTitle="女收养人职业" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业（翻译）</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="MALE_JOB_CN" id="R_MALE_JOB_CN" type="String" formTitle="男收养人职业" defaultValue="" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="FEMALE_JOB_CN" id="R_FEMALE_JOB_CN" type="String" formTitle="女收养人职业" defaultValue="" />
						</td>
					</tr>
					<tr id="MALE_HEALTH_AREA">
						<td class="bz-edit-data-title">男健康说明</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="MALE_HEALTH_AREA2">
						<td class="bz-edit-data-title">男健康说明（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="FEMALE_HEALTH_AREA">
						<td class="bz-edit-data-title">女健康说明</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="FEMALE_HEALTH_AREA2">
						<td class="bz-edit-data-title">女健康说明（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="MALE_PUNISHMENT_AREA">
						<td class="bz-edit-data-title">男违法行为及刑事处罚</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="MALE_PUNISHMENT_AREA2">
						<td class="bz-edit-data-title">男违法行为及刑事处罚（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_PUNISHMENT_CN" id="R_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_PUNISHMENT_AREA">
						<td class="bz-edit-data-title">女违法行为及刑事处罚</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_PUNISHMENT_AREA2">
						<td class="bz-edit-data-title">女违法行为及刑事处罚（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_CN" id="R_FEMALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="MALE_ILLEGALACT_AREA">
						<td class="bz-edit-data-title">男不良嗜好</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="MALE_ILLEGALACT_AREA2">
						<td class="bz-edit-data-title">男不良嗜好（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_ILLEGALACT_CN" id="R_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_ILLEGALACT_AREA">
						<td class="bz-edit-data-title">女不良嗜好</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_ILLEGALACT_AREA2">
						<td class="bz-edit-data-title">女不良嗜好（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_CN" id="R_FEMALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="CHILD_CONDITION_AREA">
						<td class="bz-edit-data-title">子女数量及情况</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="CHILD_CONDITION_EN" id="R_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="CHILD_CONDITION_AREA2">
						<td class="bz-edit-data-title">子女数量及情况（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="CHILD_CONDITION_CN" id="R_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="ADOPT_REQUEST_AREA">
						<td class="bz-edit-data-title">收养要求</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="ADOPT_REQUEST_EN" id="R_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="ADOPT_REQUEST_AREA2">
						<td class="bz-edit-data-title">收养要求（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="ADOPT_REQUEST_CN" id="R_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="IS_FAMILY_OTHERS_AREA">
						<td class="bz-edit-data-title">家中其他人同住说明</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="IS_FAMILY_OTHERS_EN" id="R_IS_FAMILY_OTHERS_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="width:90%" />
						</td>
					</tr>
					<tr id="IS_FAMILY_OTHERS_AREA2">
						<td class="bz-edit-data-title">家中其他人同住说明（翻译）</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="IS_FAMILY_OTHERS_CN" id="R_IS_FAMILY_OTHERS_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="width:90%" />
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 begin -->
			<div id="tab2">
				<table class="bz-edit-data-table" border="0">
					<tr>
                          	<td class="bz-edit-data-title" colspan="2" style="text-align:center"><b>抚育计划</b></td>
                      	</tr>
					<tr>
						<td class="bz-edit-data-title" width="10%">中文(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="TENDING_CN" id="R_TENDING_CN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">外文(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="TENDING_EN" id="R_TENDING_EN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 begin -->
			<div id="tab3">
				<table class="bz-edit-data-table" border="0">
					<tr>
                          	<td class="bz-edit-data-title" colspan="2" style="text-align:center"><b>组织意见</b></td>
                      	</tr>
					<tr>
						<td class="bz-edit-data-title" width="10%">中文(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="OPINION_CN" id="R_OPINION_CN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">外文(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="OPINION_EN" id="R_OPINION_EN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
		<!--翻译信息：start-->
		<div id="tab-translation">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="bz-edit-data-title" colspan="2" style="text-align:center"><b>翻译信息</b></td>
                </tr>
                <tr>
					<td class="bz-edit-data-title" width="16%">翻译说明</td>
					<td class="bz-edit-data-value">
					<BZ:input prefix="P_" field="TRANSLATION_DESC" id="P_TRANSLATION_DESC" type="textarea" formTitle="翻译说明" defaultValue="" maxlength="500" style="width:90%"/>
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
		<!-- 编辑区域end -->
	</BZ:form>
</BZ:body>