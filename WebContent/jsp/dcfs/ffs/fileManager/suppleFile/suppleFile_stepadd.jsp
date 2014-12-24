<%
/**   
 * @Title: suppleFile_stepadd.jsp
 * @Description:  继子女收养文件信息修改页
 * @author yangrt   
 * @date 2014-7-22 17:41:34 
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
	String xmlstr = (String)request.getAttribute("xmlstr");
	String af_id = (String)request.getAttribute("AF_ID");
	String org_id = (String)request.getAttribute("ADOPT_ORG_ID");
	String org_af_id = "org_id=" + org_id + ";af_id=" + af_id;
	String strPar = "org_id=" + org_id + ",af_id=" + af_id;
%>
<BZ:html>
	<BZ:head language="EN">
		<title>继子女收养文件信息修改页</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		
		$(document).ready(function() {
			//根据收养人性别，设置显示与隐藏项
			$("#R_ADOPTER_SEX").val();
			if(val == 1){
				//显示男收养人信息
				$(".male_info").show();
				//隐藏女收养人信息
				$(".female_info").hide();
				//显示男收养人国籍
				$("#R_MALE_NATION").show();
				//隐藏女收养人国籍，并清空
				$("#R_FEMALE_NATION").hide();
				$("#R_FEMALE_NATION").val("");
				//显示男收养人护照号码
				$("#R_MALE_PASSPORT_NO").show();
				//隐藏女收养人护照号码，并清空
				$("#R_FEMALE_PASSPORT_NO").hide();
				$("#R_FEMALE_PASSPORT_NO").val("");
				//显示男收养人照片上传
				$("#ATT_MALE_PHOTO").show();
				//隐藏女收养人照片上传
				$("#ATT_FEMALE_PHOTO").hide();
				$("#R_FEMALE_PHOTO").attr("packageId","");
				
				//设置年龄显示
				$("#R_AGE").text(_getAge($("#R_MALE_BIRTHDAY").val()));
			}else{
				//隐藏男收养人信息
				$(".male_info").hide();
				//显示女收养人名称输入框，加非空验证
				$(".female_info").show();
				//隐藏男收养人国籍，并清空
				$("#R_MALE_NATION").hide();
				$("#R_MALE_NATION").val("");
				//显示女收养人国籍
				$("#R_FEMALE_NATION").show();
				//隐藏男收养人护照号码，并清空
				$("#R_MALE_PASSPORT_NO").hide();
				$("#R_MALE_PASSPORT_NO").val("");
				//显示女收养人护照号码
				$("#R_FEMALE_PASSPORT_NO").show();
				//隐藏男收养人照片上传
				$("#ATT_MALE_PHOTO").hide();
				$("#R_MALE_PHOTO").attr("packageId","");
				//显示女收养人照片上传
				$("#ATT_FEMALE_PHOTO").show();
				
				//设置年龄显示
				$("#R_AGE").text(_getAge($("#R_FEMALE_BIRTHDAY").val()));
			}
			
		});
		
		//新增文件代录信息
		function _submit(){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else{
				//定义数组，并初始化数组
				var att_arrays = new Array();
				var sex = $("#R_ADOPTER_SEX").val();
				if(sex == "1"){
					//如果性别选择男
					att_arrays[0] = "R_MALE_PHOTO";
					att_arrays[1] = "男收养人照片";
				}else{
					//如果性别选择男
					att_arrays[0] = "R_FEMALE_PHOTO";
					att_arrays[1] = "女收养人照片";
				}
				//验证附件是否上传
				var att_name = [];	//定义未上传的附件名称数组
				var name_length = 0;	//未上传附件的种类数
				for(var i = 0; i < att_arrays.length; i+=2){
					var table = document.getElementById("infoTable" + att_arrays[i]);
					var trslen = table.rows.length;
					if(trslen == 0){
						//将未上传的附件种类名称放入数组att_name中，并记录未上传的附件种类数
						att_name[name_length++] = att_arrays[i+1];
					}
				}
				if(name_length > 0){
					//page.alert("请上传" + att_name.join("、") + "!");
					alert("请上传" + att_name.join("、") + "!");
					return;
				}else if(confirm("Are you sure you want to submit?")){
					//表单提交
					
					document.srcForm.action = path+'ffs/filemanager/BasicInfoSave.action';
					document.srcForm.submit();
					window.close();
				}
			}
			
		}
		//返回递交普通文件列表页面
		function _close(){
			window.close();
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
	<BZ:body property="data" codeNames="GJ;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue="1"/>
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
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>外文姓名<br>Name</td>
								<td class="bz-edit-data-value" width="25%">
									<span class="male_info"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span>
									<span class="female_info"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>性别<br>Sex</td>
								<td class="bz-edit-data-value" width="25%">
									<BZ:dataValue field="ADOPTER_SEX" checkValue="1=Male;2=Female;" defaultValue="" onlyValue="true"/>
								</td>
								<td class="bz-edit-data-value" width="20%" rowspan="4">
									<span class="male_info">
										<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" packageId="<%=af_id%>" name="R_MALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_MALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
									<span class="female_info">
										<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" packageId="<%=af_id%>" name="R_FEMALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>出生日期<br>D.O.B</td>
								<td class="bz-edit-data-value">
									<span class="male_info"><BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></span>
									<span class="female_info"><BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></span>
								</td>
								<td class="bz-edit-data-title">年龄<br>Age</td>
								<td class="bz-edit-data-value">
									<span id="R_AGE"></span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">国籍<br>Nationality</td>
								<td class="bz-edit-data-value">
									<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
									<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
									<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100" style="display:none"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">婚姻状况<br>Marital status</td>
								<td class="bz-edit-data-value">Married</td>
								<td class="bz-edit-data-title"><font color="red">*</font>结婚日期<br>Date of the present marriage</td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="Please select the wedding date！" onchange="_setMarryLength()"/>
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
						<div>附件信息(Attachment)</div>
					</div>
					<!-- 内容区域 begin -->
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-value">
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_PARENTS%>&packageID=<%=af_id %>" frameborder=0 width="100%" ></IFRAME>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 编辑区域end -->
			<!-- 按钮区域begin -->
			<div class="bz-action-frame">
				<div class="bz-action-edit" desc="按钮区">
					<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_submit()"/>
					<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_close();"/>
				</div>
			</div>
			<!-- 按钮区域end -->
		</BZ:form>
		<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
		<!--附件使用：start-->
			<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
			<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value="<%=af_id %>"/>
			<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=xmlstr%>'/>
			<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
			<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
			<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
			<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
			<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='<%=strPar%>'/>		
		<!--附件使用：end-->
		</form>
	</BZ:body>
</BZ:html>