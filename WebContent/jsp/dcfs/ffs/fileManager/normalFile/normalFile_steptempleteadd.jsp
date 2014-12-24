<%
/**   
 * @Title: normalFile_steptempleteadd.jsp
 * @Description:  继子女收养文件详细信息添加页
 * @author yangrt   
 * @date 2014-7-22 上午4:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@	page import="com.dcfs.ffs.common.FileCommonConstant"%>
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
		<title>继子女收养文件详细信息添加页</title>
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
			dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
			
			var sex = $("#R_ADOPTER_SEX").val();
			if(sex == "1"){
				$(".maleinfo").show();
				$(".femaleinfo").hide();
				$("#R_MALE_NAME").attr("notnull","Please write the name of adoptive father!");
				$("#R_MALE_BIRTHDAY").attr("notnull","Please select DOB of the adoptive father!");
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#R_AGE").text(_getAge(male_birth));
				}
			}else if(sex == "2"){
				$(".maleinfo").hide();
				$(".femaleinfo").show();
				$("#R_MALE_NAME").attr("notnull","Please write the name of adoptive father!");
				$("#R_MALE_BIRTHDAY").attr("notnull","Please select DOB of the adoptive father!");
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#R_AGE").text(_getAge(female_birth));
				}
			}			
			
			//初始化有效期限时限的显示与隐藏
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period == "-1"){
				$("#R_VALID_PERIOD_TYPE").val(2);
				$("#R_PERIOD").hide();
			}else{
				$("#R_VALID_PERIOD_TYPE").val(1);
				$("#R_PERIOD").show();
			}
		});
		
		//新增文件代录信息
		function _submit(val){
			var reg_state = $("#R_REG_STATE").val();
			if(val == "0"){
				if(reg_state != "2"){
					$("#R_REG_STATE").val(val);
				}
				document.srcForm.action = path+'ffs/filemanager/NormalFileSave.action';
				document.srcForm.submit();
			}else if(val == "1"){
				$("#R_REG_STATE").val(val);
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else{
					//定义数组，并初始化数组
					var att_arrays = [];
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
						alert("请上传" + att_name.join("、") + "!");
						return;
					}else if(confirm("Are you sure you want to submit?")){
						//表单提交
						document.srcForm.action = path+'ffs/filemanager/NormalFileSave.action';
						document.srcForm.submit();
						parent._goback();
					}
				}
			}
		}
		//返回递交普通文件列表页面
		function _goback(){
			parent._goback();
		}
		
		//根据男（女）收养人的出生日期获取年龄
		function _setAge(obj){
			var date = obj.value;
			var age = _getAge(date);
			$("#R_AGE").text(age);
		}
		
		//设置有效期限输入框的实现与隐藏
		function _setValidPeriodShow(){
			var val = $("#R_VALID_PERIOD_TYPE").find("option:selected").val();
			if(val == 1){
				$("#R_PERIOD").show();
				$("#R_VALID_PERIOD").val("");
			}else{
				$("#R_PERIOD").hide();
				$("#R_VALID_PERIOD").val("-1");
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
		//***********附件上传处理JS****************************************************
		function getIframeVal(val)  
		{
			//document.getElementById("textareaid").value=urlDecode(val);
			//alert(document.getElementById("frmUpload"));
			//document.getElementById("frmUpload").location.reload();
			if(p=="0"){
				frmUpload.window.location.reload();
			}else{
				frmUpload1.window.location.reload();
			}
		}	
		
		var p = "0";
		//附件上传
		function _toipload(fn,obj){
			p = fn;		
			var packageId,isEn;
			//p=0，上传翻译件
			if(p=="0"){
				packageId = "<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>";
				isEn = "false";
			}else{//p=0，上传原件
				packageId = "<%=af_id%>";
				isEn = "true";
			}

			var y = obj.offsetTop;
			var ch = document.body.clientHeight;
			while(obj=obj.offsetParent) 
			{ 
				y   +=   obj.offsetTop;			
			}

			if((ch-y)<150){
				y = y - (ch-y); 
			}
			popWin.showWinIframe("1000","300","fileframe","附件管理","iframe","#",y);
			document.uploadForm.PACKAGE_ID.value = packageId;
			document.uploadForm.IS_EN.value = isEn;
			document.uploadForm.action="<%=path%>/uploadManager";
			document.uploadForm.target="fileframe";
			document.uploadForm.submit();
		}	
	</script>
	<BZ:body property="data" codeNames="GJ;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="REG_STATE" id="R_REG_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_SEQ_NO" id="R_AF_SEQ_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NAME_CN" id="R_NAME_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NAME_EN" id="R_NAME_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CN" id="R_COUNTRY_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_EN" id="R_COUNTRY_EN" defaultValue=""/>
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
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_NAME" id="R_MALE_NAME" formTitle="外文姓名(男)" defaultValue="" maxlength="150"/>
									</span>
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" formTitle="外文姓名(女)" defaultValue="" maxlength="150"/>
									</span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>性别<br>Sex</td>
								<td class="bz-edit-data-value" width="25%">
									<BZ:dataValue field="ADOPTER_SEX" checkValue="1=Male;2=Female;" defaultValue="" onlyValue="true"/>
								</td>
								<td class="bz-edit-data-value" width="20%" rowspan="4">
									<span class="maleinfo">
										<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" packageId="<%=af_id%>" name="R_MALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_MALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
									<span class="femaleinfo">
										<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" packageId="<%=af_id%>" name="R_FEMALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>	
									</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>出生日期<br>D.O.B</td>
								<td class="bz-edit-data-value">
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" notnull="Please select DOB of the adoptive father!" dateExtend="maxDate:'%y-%M-%d',lang:'en'" onchange="_setAge(this)"/>
									</span>
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d',lang:'en'" onchange="_setAge(this)"/>
									</span>
								</td>
								<td class="bz-edit-data-title">年龄<br>Age</td>
								<td class="bz-edit-data-value">
									<span id="R_AGE"></span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">国籍<br>Nationality</td>
								<td class="bz-edit-data-value">
									<span class="maleinfo">
										<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
									</span>
									<span class="femaleinfo">
										<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
									</span>
								</td>
								<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
								<td class="bz-edit-data-value">
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
									</span>
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>	
									</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">婚姻状况<br>Marital status</td>
								<td class="bz-edit-data-value">Married</td>
								<td class="bz-edit-data-title"><font color="red">*</font>结婚日期<br>Date of the present marriage </td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d',lang:'en'" notnull="Please select the wedding date！" onchange="_setMarryLength()"/>
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
						<div>政府批准信息(Government approval information)</div>
					</div>
					<!-- 标题区域 end -->
					<!-- 内容区域 begin -->
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>批准日期<br>Date of approval</td>
								<td class="bz-edit-data-value" width="35%">
									<BZ:input prefix="R_" field="GOVERN_DATE" id="R_GOVERN_DATE" type="Date" dateExtend="lang:'en'" formTitle="" defaultValue="" notnull="Please select the date of approval!"/>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>有效期限<br>Validity period</td>
								<td class="bz-edit-data-value" width="35%">
									<BZ:select prefix="R_" field="VALID_PERIOD_TYPE" id="R_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="Please select the validity period!" onchange="_setValidPeriodShow()">
										<BZ:option value="1" selected="true">Validity period</BZ:option>
										<BZ:option value="2">Long-term</BZ:option>
									</BZ:select>
									<span id="R_PERIOD"><BZ:input prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="Please write the detail of validity period!" style="width:20%;"/>月(Month)</span>
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
						<div>附件信息(Attachment)&nbsp;&nbsp;
							<input type="button" class="btn btn-sm btn-primary" value="Upload attachment" onclick="_toipload('1',this)" />
						</div>
					</div>
					<!-- 标题区域 end -->
					<!-- 内容区域 begin -->
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-value">
									<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" ></IFRAME>
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
					<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_submit('0')"/>
					<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit('1')"/>
					<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
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