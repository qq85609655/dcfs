<%
/**   
 * @Title: addmaterial_revise_doubleinfo.jsp
 * @Description:  预批基本信息修改（双亲收养）
 * @author panfeng   
 * @date 2014-11-4 15:41:15 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	String MALE_PUNISHMENT_FLAG = (String)request.getAttribute("MALE_PUNISHMENT_FLAG");	//男收养人违法行为及刑事处罚标识,0=无，1=有
	String MALE_ILLEGALACT_FLAG = (String)request.getAttribute("MALE_ILLEGALACT_FLAG");	//男收养人有无不良嗜好标识,0=无，1=有
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//女收养人违法行为及刑事处罚标识,0=无，1=有
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//女收养人有无不良嗜好标识,0=无，1=有
	String IS_FAMILY_OTHERS_FLAG = (String)request.getAttribute("IS_FAMILY_OTHERS_FLAG");	//家中有无其他人同住标识,0=无，1=有
%>
<BZ:html>
	<BZ:head language="EN">
		<title>预批基本信息修改（双亲收养）</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
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
			var male_health = $("#R_MALE_HEALTH").find("option:selected").val();	//男收养人的健康状况
			var female_health = $("#R_FEMALE_HEALTH").find("option:selected").val();	//女收养人的健康状况
			if(male_health == "2"){
				$("#R_MALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#R_MALE_HEALTH_CONTENT_EN").hide();
			}
			if(female_health == "2"){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
			}
			
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
			
			//初始化家中有无其他人同住说明的显示与隐藏
			var IS_FAMILY_OTHERS_FLAG = "<%=IS_FAMILY_OTHERS_FLAG%>";
			if(IS_FAMILY_OTHERS_FLAG == "1"){
				$("#R_IS_FAMILY_OTHERS_EN").show();
			}else{
				$("#R_IS_FAMILY_OTHERS_EN").hide();
			}
			
			//根据结婚日期初始化结婚时长
			var marry_date = $("#R_MARRY_DATE").val();
			if(marry_date != ""){
				_setMarryLength();
			}
			
			//初始化家庭净资产
			_setTotalManny();
			
		});
		
		//保存操作
		function _save() {
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else{
				if (confirm("确定保存吗？")) {
					document.srcForm.action = path + "sce/addMaterial/modInfoSave.action?type=info";
					document.srcForm.submit();
					window.close();
				}
			}
		}
		
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
		
		//设置家中有无其他人同住说明的显示与隐藏
		function _setFamilyOther(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_IS_FAMILY_OTHERS_EN").hide();
				$("#R_IS_FAMILY_OTHERS_EN").val("");
				$("#R_IS_FAMILY_OTHERS_EN").removeAttr("notnull");
			}else{
				$("#R_IS_FAMILY_OTHERS_EN").show();
				$("#R_IS_FAMILY_OTHERS_EN").attr("notnull","");
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
		
	</script>
	<BZ:body property="data" codeNames="GJ;SYLX;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<BZ:input prefix="R_" field="RI_ID" type="hidden" defaultValue="" />
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
								<BZ:input prefix="R_" field="MALE_NAME" id="R_MALE_NAME" formTitle="外文姓名(男)" defaultValue="" notnull="Please write the name of adoptive father!" maxlength="150"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" formTitle="外文姓名(女)" defaultValue="" notnull="Please write the name of adoptive mother!" maxlength="150"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="16%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="26%">
								<BZ:input prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d'" notnull="Please select the DOB of adoptive father!" onchange="_setMaleAge(this)"/>
							</td>
							<td class="bz-edit-data-value" width="16%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" name="R_MALE_PHOTO" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' autoUpload="true" imageStyle="width:100%;height:100%" hiddenProcess="false" proContainerStyle="width:50%;" hiddenList="true" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>
							</td>
							
							<td class="bz-edit-data-value" width="26%">
								<BZ:input prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d'" notnull="Please select the DOB of adoptive mother!" onchange="_setFemaleAge(this)"/>
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
								<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
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
							<td class="bz-edit-data-title"><font color="red">*</font>违法行为及刑事处罚<br>Criminal records</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMalePunishment(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setMalePunishment(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemalePunishment(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>有无不良嗜好<br>Any bad habits</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMaleIllegalact(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setMaleIllegalact(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemaleIllegalact(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>货币单位<br>Currency</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ" isShowEN="true" notnull="Please write the Currency Unit!" width="16%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>年收入<br>Annual income</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="MALE_YEAR_INCOME" id="R_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="Please write the annual income of adoptive father!" maxlength="22"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="Please write the annual income of adoptive mother!" maxlength="22"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>前婚次数<br>Number of previous marriages</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="MALE_MARRY_TIMES" id="R_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="Please write the number of adoptive father previous marriages!"/>次(Times)
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:input prefix="R_" field="FEMALE_MARRY_TIMES" id="R_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="Please write the number of adoptive mother previous marriages!"/>次(Times)
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">婚姻状况<br>Marital status</td>
							<td class="bz-edit-data-value" width="18%">Married</td>
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
							<td class="bz-edit-data-title"><font color="red">*</font>家中有无其他人同住<br>Anyone else living with the family</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="IS_FAMILY_OTHERS_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFamilyOther(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="IS_FAMILY_OTHERS_FLAG" value="1" formTitle="" onclick="_setFamilyOther(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="IS_FAMILY_OTHERS_EN" id="R_IS_FAMILY_OTHERS_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%"/>
							</td>
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
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 编辑区域end -->
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save()"/>
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="window.close();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>