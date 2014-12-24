<%
/**   
 * @Title: specialFile_singletempleteadd.jsp
 * @Description:  单亲收养文件详细信息添加页
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
	String MALE_PUNISHMENT_FLAG = (String)request.getAttribute("MALE_PUNISHMENT_FLAG");		//男收养人违法行为及刑事处罚标识,0=无，1=有
	String MALE_ILLEGALACT_FLAG = (String)request.getAttribute("MALE_ILLEGALACT_FLAG");		//男收养人有无不良嗜好标识,0=无，1=有
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//女收养人违法行为及刑事处罚标识,0=无，1=有
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//女收养人有无不良嗜好标识,0=无，1=有
	String IS_FAMILY_OTHERS_FLAG = (String)request.getAttribute("IS_FAMILY_OTHERS_FLAG");	//家中有无其他人同住,0=无，1=有
	
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	String af_id = (String)request.getAttribute("AF_ID");
	String org_id = (String)request.getAttribute("ADOPT_ORG_ID");
	String org_af_id = "org_id=" + org_id + ";af_id=" + af_id;
	String strPar = "org_id=" + org_id + ",af_id=" + af_id;
	
	String flag = (String)request.getAttribute("FLAG");
	//完成家调组织输入框时候显示
	String isShowOrgName = (String)request.getAttribute("isShowOrgName");
	String reg_state = (String)request.getAttribute("REG_STATE");
	String str_ci_id = (String)request.getAttribute("CI_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>单亲收养文件详细信息添加页</title>
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
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			
			var sex = $("#R_ADOPTER_SEX").val();	//收养人性别
			//如果收养人性别是男（sex==1）
			if(sex == "1"){
				$(".maleinfo").show();
				$(".femaleinfo").hide();
				$("#R_MALE_NATION").attr("notnull","Please select the nationality of adoptive father!");
				$("#R_MALE_EDUCATION").attr("notnull","Please select the education of adoptive father!");
				$("#R_MALE_JOB_EN").attr("notnull","请填写男收养人职业！");
				$("#R_MALE_HEALTH").attr("notnull","Please select the health status of adoptive father!");
				$("#R_MALE_WEIGHT").attr("notnull","Please write the weight of adoptive father!");
				$("#R_MALE_YEAR_INCOME").attr("notnull","Please write the annual income of adoptive father!");
				$("#FEMALE_HEIGHT_METRE").hide();
				
				//根据出生日期初始化年龄
				var male_briDate = $("#R_MALE_BIRTHDAY").val();	//男收养人的出生日期
				if(male_briDate != ""){
					$("#ADOPTER_AGE").text(_getAge(male_briDate));
				}
				
				//初始化健康状况说明的显示与隐藏
				var male_health = $("#R_MALE_HEALTH").find("option:selected").val();	//男收养人的健康状况
				if(male_health == "2"){
					$("#R_MALE_HEALTH_CONTENT_EN").show();
				}else{
					$("#R_MALE_HEALTH_CONTENT_EN").hide();
				}
				
				//初始化身高、体重的显示方式（公制、英制）
				var measurement = $("#R_MEASUREMENT").find("option:selected").val();	//身高计量标准
				var male_height = $("#R_MALE_HEIGHT").val();	//男收养人身高
				if(measurement == "0"){
					$("#MALE_HEIGHT_INCH").hide();
					$("#MALE_HEIGHT_METRE").show();
					$("#WEIGHT_POUNDS").hide();
					$("#WEIGHT_KILOGRAM").show();
					
				}else{
					$("#MALE_HEIGHT_INCH").show();
					$("#MALE_HEIGHT_METRE").hide();
					$("#WEIGHT_POUNDS").show();
					$("#WEIGHT_KILOGRAM").hide();
					
					var maletempfeet = parseInt(male_height) / 30.48 + "";
					var malefeet = maletempfeet.split(".")[0];
					var maleinch = (maletempfeet - malefeet) * 12;
					$("#R_MALE_FEET").val(malefeet);
					$("#R_MALE_INCH").val(maleinch.toFixed(2));
					
					var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
					$("#R_MALE_WEIGHT").val(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				}
				
				//设置男收养人的身体指数
				_setMaleBMI();
				
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
			}else if(sex == "2"){	//如果收养人性别是女（sex==2）
				$(".maleinfo").hide();
				$(".femaleinfo").show();
				$("#R_FEMALE_NATION").attr("notnull","Please select the nationality of adoptive mother!");
				$("#R_FEMALE_EDUCATION").attr("notnull","Please select the education of adoptive mother!");
				$("#R_FEMALE_JOB_EN").attr("notnull","请填写女收养人职业！");
				$("#R_FEMALE_HEALTH").attr("notnull","Please select the health status of adoptive mother!");
				$("#R_FEMALE_WEIGHT").attr("notnull","Please write the weight of adoptive mother!");
				$("#R_FEMALE_YEAR_INCOME").attr("notnull","Please write the annual income of adoptive mother!");
				$("#MALE_HEIGHT_METRE").hide();
				
				//根据出生日期初始化年龄
				var female_briDate = $("#R_FEMALE_BIRTHDAY").val();	//女收养人的出生日期
				if(female_briDate != ""){
					$("#ADOPTER_AGE").text(_getAge(female_briDate));
				}
				
				//初始化健康状况说明的显示与隐藏
				var female_health = $("#R_FEMALE_HEALTH").find("option:selected").val();	//女收养人的健康状况
				if(female_health == "2"){
					$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				}else{
					$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				}
				
				//初始化身高、体重的显示方式（公制、英制）
				var measurement = $("#R_MEASUREMENT").find("option:selected").val();	//身高计量标准
				var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人身高
				if(measurement == "0"){
					$("#FEMALE_HEIGHT_INCH").hide();
					$("#FEMALE_HEIGHT_METRE").show();
					$("#WEIGHT_POUNDS").hide();
					$("#WEIGHT_KILOGRAM").show();
					
				}else{
					$("#FEMALE_HEIGHT_INCH").show();
					$("#FEMALE_HEIGHT_METRE").hide();
					$("#WEIGHT_POUNDS").show();
					$("#WEIGHT_KILOGRAM").hide();
					
					var femaletempfeet = parseInt(female_height) / 30.48 + "";
					var femalefeet = femaletempfeet.split(".")[0];
					var femaleinch = (femaletempfeet - femalefeet) * 12;
					$("#R_FEMALE_FEET").val(femalefeet);
					$("#R_FEMALE_INCH").val(femaleinch.toFixed(2));
					
					var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
					$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
				}
				
				//设置女收养人的身体指数
				_setFemaleBMI();
				
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
			}
			
			//初始化家庭净资产
			_setTotalManny();
			
			//初始化有效期限时限的显示与隐藏
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period == "-1"){
				$("#R_VALID_PERIOD_TYPE").val(2);
				$("#R_PERIOD").hide();
			}else{
				$("#R_VALID_PERIOD_TYPE").val(1);
				$("#R_PERIOD").show();
			}
			
			//设置完成家调组织名称的录入方式（下拉、输入）
			var country_code = $("#R_COUNTRY_CODE").val();
			if(country_code == "21"){	//21:美国
				var isShowOrgName = "<%=isShowOrgName %>";
				if(isShowOrgName == "true"){
					//当前组织所属国家为美国时，完成家调组织名称为下拉框显示
					$("#R_HOMESTUDY_ORG_DROP").show();
					$("#R_HOMESTUDY_ORG_DROP").attr("notnull","Please select the adoption agency of completion for home study!");
					
					$("#R_HOMESTUDY_ORG_INPUT").show();
					$("#R_HOMESTUDY_ORG_INPUT").attr("notnull","Please write the adoption agency of completion for home study!");
				}else{
					//当前组织所属国家为美国时，完成家调组织名称为下拉框显示
					$("#R_HOMESTUDY_ORG_DROP").show();
					$("#R_HOMESTUDY_ORG_DROP").attr("notnull","Please select the adoption agency of completion for home study!");
					
					$("#R_HOMESTUDY_ORG_INPUT").hide();
					$("#R_HOMESTUDY_ORG_INPUT").removeAttr("notnull");
				}
			}else{
				$("#R_HOMESTUDY_ORG_INPUT").show();
				$("#R_HOMESTUDY_ORG_INPUT").attr("notnull","Please write the adoption agency of completion for home study!");
				
				$("#R_HOMESTUDY_ORG_DROP").hide();
				$("#R_HOMESTUDY_ORG_DROP").removeAttr("notnull");
			}
			
			//家中有无其他人同住
			var IS_FAMILY_OTHERS_FLAG = "<%=IS_FAMILY_OTHERS_FLAG %>";
			if(IS_FAMILY_OTHERS_FLAG == "1"){
				$("#R_IS_FAMILY_OTHERS_EN").removeAttr("disabled");
			}
			
		});
		
		//新增文件代录信息
		function _submit(val){
			var operType = "<%=flag %>";
			var isSubmit = "true";
			if(operType != "mod"){
				isSubmit = getStr("com.dcfs.ffs.fileManager.FileManagerAjax","method=getSceReqRiState&ri_id=<%=ri_id %>");
			}
			if(isSubmit == "true"){
				var reg_state =	$("#R_REG_STATE").val();
				var typeval = $("#R_MEASUREMENT").find("option:selected").val();
				var att_arrays = new Array();	//定义附件ID和名称数组
				var sex = $("#R_ADOPTER_SEX").val();	//收养人性别
				if(sex == "1"){
					//将英制单位转化为公制进行保存
					if(typeval == 1){
						var malefeetval = $("#R_MALE_FEET").val();
						var maleinchval = $("#R_MALE_INCH").val();
						
						//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
						var maleheightval = parseInt(malefeetval) * 30.48 + parseInt(maleinchval) * 2.54;
						$("#R_MALE_HEIGHT").val(maleheightval);
						//将英制体重转化为公制体重,1磅=0.45359237千克
						var maleweightval = parseInt($("#R_MALE_WEIGHT").val()) * 0.45359237;
						$("#R_MALE_WEIGHT").val(maleweightval);
					}
					att_arrays = ["R_MALE_PHOTO","男收养人照片"];
				}else if(sex == "2"){
					//将英制单位转化为公制进行保存
					if(typeval == 1){
						var femalefeetval = $("#R_FEMALE_FEET").val();
						var femaleinchval = $("#R_FEMALE_INCH").val();
						
						//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
						var femaleheightval = parseInt(femalefeetval) * 30.48 + parseInt(femaleinchval) * 2.54;
						$("#R_FEMALE_HEIGHT").val(femaleheightval);
						//将英制体重转化为公制体重,1磅=0.45359237千克
						var femaleweightval = parseInt($("#R_FEMALE_WEIGHT").val()) * 0.45359237;
						$("#R_FEMALE_WEIGHT").val(femaleweightval);
					}
					att_arrays = ["R_FEMALE_PHOTO","女收养人照片"];
				}
				
				if(val == "0"){
					if(reg_state != "2"){
						$("#R_REG_STATE").val(val);
					}
					document.srcForm.action = path+"ffs/filemanager/SpecialFileSave.action?FLAG=" + "<%=flag %>";
					document.srcForm.submit();
				}else if(val == "1"){
					$("#R_REG_STATE").val(val);
					$("#R_RI_STATE").val("5");
					//页面表单校验
					if (!runFormVerify(document.srcForm, false)) {
						alert("有必填项未填写，请完善之后再进行提交！");
						return;
					}else{
						//验证附件是否上传
						var att_name = [];		//定义未上传的附件名称数组
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
							document.srcForm.action = path+"ffs/filemanager/SpecialFileSave.action?FLAG=" + "<%=flag %>";
							document.srcForm.submit();
						}
					}
				}
			}else{
				alert("该预批申请已经提交文件，不能再次递交文件！");
				document.srcForm.action=path+"ffs/filemanager/SpecialFileSelectList.action";
				document.srcForm.submit();
			}
		}
		//返回递交普通文件列表页面
		function _goback(){
			window.location.href=path+'ffs/filemanager/SpecialFileList.action';
		}
		
		//设置显示、隐藏女收养人的健康状况描述
		function _setFemaleHealthContent(){
			var val = $("#R_FEMALE_HEALTH").find("option:selected").val();
			if(val == "2"){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				$("#R_FEMALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive mother's health condition!");
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				$("#R_FEMALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//设置显示、隐藏女收养人的健康状况描述
		function _setMaleHealthContent(){
			var val = $("#R_MALE_HEALTH").find("option:selected").val();
			if(val == "2"){
				$("#R_MALE_HEALTH_CONTENT_EN").show();
				$("#R_MALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive father's health condition!");
			}else{
				$("#R_MALE_HEALTH_CONTENT_EN").hide();
				$("#R_MALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//设置身高与体重的计量方式
		function _setHeightWeight(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			var sex = $("#R_ADOPTER_SEX").val();	//收养人性别
			if(sex == "1"){
				if(typeval == 1){	//当选择英制时
					var male_height = $("#R_MALE_HEIGHT").val();	//男收养人公制身高
					if(male_height != ""){
						var maletempfeet = parseInt(male_height) / 30.48 + "";
						var malefeet = maletempfeet.split(".")[0];
						var maleinch = (maletempfeet - malefeet) * 12;
						$("#R_MALE_FEET").val(malefeet);
						$("#R_MALE_INCH").val(maleinch.toFixed(2));
					}
					$("#MALE_HEIGHT_INCH").show();
					$("#MALE_HEIGHT_METRE").hide();
					$("#R_MALE_FEET").attr("notnull","This cannot be empty!");
					$("#R_MALE_INCH").attr("notnull","This cannot be empty!");
					$("#R_MALE_HEIGHT").removeAttr("notnull");
					
					//将公制体重转化为英制体重,1磅=0.45359237千克
					var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
					if(male_weight != ""){
						$("#R_MALE_WEIGHT").val(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));	
					}
					$("#WEIGHT_POUNDS").show();
					$("#WEIGHT_KILOGRAM").hide();
				}else{
					var male_height = $("#R_MALE_HEIGHT").val();	//男收养人公制身高
					if(male_height == ""){
						var male_feet = $("#R_MALE_FEET").val();
						var male_inch = $("#R_MALE_INCH").val();
						if(male_feet != "" || male_inch != ""){
							//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
							$("#R_MALE_HEIGHT").val(parseInt(male_feet) * 30.48 + parseInt(male_inch) * 2.54);
						}
					}
					$("#MALE_HEIGHT_INCH").hide();
					$("#MALE_HEIGHT_METRE").show();
					$("#R_MALE_HEIGHT").attr("notnull","This cannot be empty!");
					$("#R_MALE_FEET").removeAttr("notnull");
					$("#R_MALE_INCH").removeAttr("notnull");
					
					var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
					if(male_weight != ""){
						$("#R_MALE_WEIGHT").val(parseFloat(parseInt(male_weight) * 0.45359237).toFixed(2));	
					}
					$("#WEIGHT_POUNDS").hide();
					$("#WEIGHT_KILOGRAM").show();
				}
			}else if(sex == "2"){
				if(typeval == 1){	//当选择英制时
					var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人公制身高
					if(female_height != ""){
						var femaletempfeet = parseInt(female_height) / 30.48 + "";
						var femalefeet = femaletempfeet.split(".")[0];
						var femaleinch = (femaletempfeet - femalefeet) * 12;
						$("#R_FEMALE_FEET").val(femalefeet);
						$("#R_FEMALE_INCH").val(femaleinch.toFixed(2));
					}
					$("#FEMALE_HEIGHT_INCH").show();
					$("#FEMALE_HEIGHT_METRE").hide();
					$("#R_FEMALE_FEET").attr("notnull","This cannot be empty!");
					$("#R_FEMALE_INCH").attr("notnull","This cannot be empty!");
					$("#R_FEMALE_HEIGHT").removeAttr("notnull");
					
					//将公制体重转化为英制体重,1磅=0.45359237千克
					var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
					if(female_weight != ""){
						$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));	
					}
					$("#WEIGHT_POUNDS").show();
					$("#WEIGHT_KILOGRAM").hide();
				}else{
					var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人公制身高
					if(female_height == ""){
						var female_feet = $("#R_FEMALE_FEET").val();
						var female_inch = $("#R_FEMALE_INCH").val();
						if(female_feet != "" || female_inch != ""){
							//将英制身高转化为公制身高,1英尺=0.3048米，1英寸=0.0254米
							$("#R_FEMALE_HEIGHT").val(parseInt(female_feet) * 30.48 + parseInt(female_inch) * 2.54);
						}
					}
					$("#FEMALE_HEIGHT_INCH").hide();
					$("#FEMALE_HEIGHT_METRE").show();
					$("#R_FEMALE_HEIGHT").attr("notnull","This cannot be empty!");
					$("#R_FEMALE_FEET").removeAttr("notnull");
					$("#R_FEMALE_INCH").removeAttr("notnull");
					
					var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
					if(female_weight != ""){
						$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) * 0.45359237).toFixed(2));	
					}
					$("#WEIGHT_POUNDS").hide();
					$("#WEIGHT_KILOGRAM").show();
				}
			}
			
		}
		
		//自动计算女收养人的体重指数
		function _setFemaleBMI(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			var weight = $("#R_FEMALE_WEIGHT").val();
			if(weight != ""){
				if(typeval == 1){
					var feetval = $("#R_FEMALE_FEET").val();
					var inchval = $("#R_FEMALE_INCH").val();
					if(feetval != "" && inchval != ""){
						/* page.alert("请先填写女收养人身高信息，再填写体重信息！");
						$("#R_FEMALE_WEIGHT").val("");
						$("#R_FEMALE_WEIGHT").text("");
						return;
					}else{ */
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
					if($("#R_FEMALE_HEIGHT").val() != ""){
						/* page.alert("请先填写女收养人身高信息，再填写体重信息！");
						$("#R_FEMALE_WEIGHT").val("");
						$("#R_FEMALE_WEIGHT").text("");
						return;
					}else{ */
						var heightval = parseInt($("#R_FEMALE_HEIGHT").val()) / 100;
						var weightval = $("#R_FEMALE_WEIGHT").val();
						var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
						$("#R_FEMALE_BMI").val(weightindex);
						$("#FEMALE_BMI_SHOW").text(weightindex);
					}
				}
			}
		}
		
		//自动计算男收养人的体重指数
		function _setMaleBMI(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			var weight = $("#R_MALE_WEIGHT").val();
			if(weight != ""){
				if(typeval == 1){
					var feetval = $("#R_MALE_FEET").val();
					var inchval = $("#R_MALE_INCH").val();
					if(feetval != "" && inchval != ""){
						/* page.alert("请先填写男收养人身高信息，再填写体重信息！");
						$("#R_MALE_WEIGHT").val("");
						$("#R_MALE_WEIGHT").text("");
						return;
					}else{ */
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
					if($("#R_MALE_HEIGHT").val() != ""){
						/* page.alert("请先填写男收养人身高信息，再填写体重信息！");
						$("#R_MALE_WEIGHT").val("");
						$("#R_MALE_WEIGHT").text("");
						return;
					}else{ */
						var heightval = parseInt($("#R_MALE_HEIGHT").val()) / 100;
						var weightval = $("#R_MALE_WEIGHT").val();
						var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
						$("#R_MALE_BMI").val(weightindex);
						$("#MALE_BMI_SHOW").text(weightindex);
					}
				}
			}
		}
		
		//设置女收养人违法行为及刑事处罚输入框的显示与隐藏
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
		
		//设置男收养人违法行为及刑事处罚输入框的显示与隐藏
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
				$("#R_FEMALE_ILLEGALACT_EN").attr("notnull","please fill in female adopter's bad habits");
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
			var total_debt = $("#R_TOTAL_DEBT").val();		//总债务
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
		
		//设置家中其他人同住说明是否可用
		function _setFamilyOthersDis(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_IS_FAMILY_OTHERS_EN").attr("disabled","true");
				$("#R_IS_FAMILY_OTHERS_EN").val("");
			}else {
				$("#R_IS_FAMILY_OTHERS_EN").removeAttr("disabled");
			}
		}
		
		//下拉选择完成家调组织名称
		function _setOrgNameDrop(){
			var org_name = $("#R_HOMESTUDY_ORG_DROP").find("option:selected").val();
			if(org_name == "Other"){
				$("#R_HOMESTUDY_ORG_INPUT").show();
				$("#R_HOMESTUDY_ORG_INPUT").val("");
			}else{
				$("#R_HOMESTUDY_ORG_INPUT").hide();
				$("#R_HOMESTUDY_ORG_NAME").val(org_name);
			}
		}
		
		//直接录入完成家调组织名称
		function _setOrgNameInput(){
			var org_name = $("#R_HOMESTUDY_ORG_INPUT").val();
			$("#R_HOMESTUDY_ORG_NAME").val(org_name);
		}
		
		//检测会见次数，不能小于4次
		function _checkMeetingTimes(obj){
			var times = obj.value;
			if(times < 4){
				alert("Meeting times cannot be less than 4 times!");
				$("#R_INTERVIEW_TIMES").val("");
			}
		}
		
		//检测推荐信，不能小于3封
		function _checkLetterValue(obj){
			var letter = obj.value;
			if(letter < 3){
				alert("Recommendation letter cannot be less than 3!");
				$("#R_RECOMMENDATION_NUM").val("");
			}
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

			if((ch-y)<300){
				y = y - (ch-y); 
			}
			
			popWin.showWinIframe("1000","600","fileframe","Upload attachment","iframe","#",y);
			document.uploadForm.PACKAGE_ID.value = packageId;
			document.uploadForm.IS_EN.value = isEn;
			document.uploadForm.action="<%=path%>/uploadManager";
			document.uploadForm.target="fileframe";
			document.uploadForm.submit();
		}	
	</script>
	<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;SYLX;BCZL;SGYJ;PROVINCE;ETXB;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="RI_STATE" id="R_RI_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="REG_STATE" id="R_REG_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NAME_CN" id="R_NAME_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NAME_EN" id="R_NAME_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CN" id="R_COUNTRY_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_EN" id="R_COUNTRY_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_NAME" id="R_MALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BMI" id="R_MALE_BMI" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BMI" id="R_FEMALE_BMI" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="HOMESTUDY_ORG_NAME" id="R_HOMESTUDY_ORG_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="IS_CONVENTION_ADOPT" id="R_IS_CONVENTION_ADOPT" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 进度条begin -->
		<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 98%;margin-left:auto;margin-right:auto;">
			<div class="stepflex" style="margin-right: 30px;">
		        <dl id="payStepFrist" class="first done">
		            <dt class="s-num">1</dt>
		            <dd class="s-text" style="margin-left: 3px;">第一步：选择预批文件<br>Step 1: Choose an application for pre-approval</dd>
		        </dl>
		        <dl id="payStepNormal" class="last doing">
		            <dt class="s-num">2</dt>
		            <dd class="s-text" style="margin-left: 3px;">第二步：录入详细信息<br>Step 2: Input detailed information<s></s>
		                <b></b>
		            </dd>
		        </dl>
			</div>
		</div>
		<!-- 进度条end -->
		<!-- 编辑区域begin -->
			<div class="bz-edit clearfix" desc="编辑区域">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<!-- 内容区域 begin -->
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="20%" height="16px">收养组织(CN)<br>Agency(CN)</td>
								<td class="bz-edit-data-value" colspan="3">
									<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="20%">收养组织(EN)<br>Agency(EN)</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="20%">文件类型<br>Document type</td>
								<td class="bz-edit-data-value" width="30%">Special needs</td>
								<td class="bz-edit-data-title" width="20%">收养类型<br>Adoption type</td>
								<td class="bz-edit-data-value" width="30%">
									<BZ:dataValue field="FAMILY_TYPE" defaultValue="" codeName="SYLX" isShowEN="true" onlyValue="true"/>
								</td>
							</tr>
						</table>
					</div>
					<!-- 内容区域 end -->
				</div>
			</div>
			<%
				if(reg_state.equals(FileCommonConstant.DJZT_DXG)){
			%>
			<div class="bz-edit clearfix" desc="编辑区域">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<!-- 标题begin -->
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>退回信息</div>
					</div>
					<!-- 标题end -->
					<!-- 内容区域 begin -->
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="20%">退回日期<br>Return date</td>
								<td class="bz-edit-data-value" width="80%">
									<BZ:dataValue field="REG_RETURN_DATE" type="Date" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="20%">退回原因<br>Reason for return</td>
								<td class="bz-edit-data-value" width="80%">
									<BZ:dataValue field="REG_RETURN_REASON" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">退回说明<br>Note on return</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="REG_RETURN_DESC" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
						</table>
					</div>
					<!-- 内容区域 end -->
				</div>
			</div>
			<%	} %>
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
								<td class="bz-edit-data-title" width="15%">外文姓名<br>Name</td>
								<td class="bz-edit-data-value" width="18%">
									<span class="femaleinfo">
										<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
									</span>
									<span class="maleinfo">
										<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
									</span>
									
								</td>
								<td class="bz-edit-data-title" width="15%">性别<br>Sex</td>
								<td class="bz-edit-data-value" width="18%">
									<span class="femaleinfo">Female</span>
									<span class="maleinfo">Male</span>
								</td>
								<td class="bz-edit-data-title" width="15%">&nbsp;</td>
								<td class="bz-edit-data-value" width="19%" rowspan="4">
									<span class="femaleinfo">
										<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" packageId="<%=af_id%>" name="R_FEMALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
									<span class="maleinfo">
										<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" packageId="<%=af_id%>" name="R_MALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_MALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
									</span>
									<span class="maleinfo">
										<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
									</span>
								</td>
								<td class="bz-edit-data-title">年龄<br>Age</td>
								<td class="bz-edit-data-value">
									<span id="ADOPTER_AGE"></span>
									<span id="MALE_AGE"></span>
								</td>
								<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>国籍<br>Nationality</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" width="70%">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
									</span>
									<span>
										<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" width="70%">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
									</span>
								</td>
								<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
									</span>
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
									</span>
								</td>
								<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>受教育情况<br>Education</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:select prefix="R_" field="FEMALE_EDUCATION" id="R_FEMALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" width="70%">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
									</span>
									<span class="maleinfo">
										<BZ:select prefix="R_" field="MALE_EDUCATION" id="R_MALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" width="70%">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
									</span>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>职业<br>Occupation</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" formTitle="" defaultValue="" maxlength="100"/>
									</span>
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_JOB_EN" id="R_MALE_JOB_EN" formTitle="" defaultValue="" maxlength="100"/>
									</span>
								</td>
								<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>健康状况<br>Health condition</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:select prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onchange="_setFemaleHealthContent()">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
										<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
									</span>
									<span class="maleinfo">
										<BZ:select prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onchange="_setMaleHealthContent()">
											<BZ:option value="">--Please select--</BZ:option>
										</BZ:select>
										<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
									</span>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>身高<br>Height</td>
								<td class="bz-edit-data-value">
									<BZ:select prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" formTitle="" defaultValue="" notnull="Please select the type of height and weight!" onchange="_setHeightWeight()">
										<BZ:option value="0" selected="true">Metric system</BZ:option>
										<BZ:option value="1">British system</BZ:option>
									</BZ:select>
									<span id="FEMALE_HEIGHT_INCH" style="display: none">
										<BZ:input prefix="R_" field="FEMALE_FEET" id="R_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>英尺(Feet)
										<BZ:input prefix="R_" field="FEMALE_INCH" id="R_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>英寸(Inch)
									</span>
									<span id="FEMALE_HEIGHT_METRE"><BZ:input prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:40%"/>厘米(Centimeter)</span>
									
									<span id="MALE_HEIGHT_INCH" style="display: none">
										<BZ:input prefix="R_" field="MALE_FEET" id="R_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>英尺(Feet)
										<BZ:input prefix="R_" field="MALE_INCH" id="R_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>英寸(Inch)
									</span>
									<span id="MALE_HEIGHT_METRE"><BZ:input prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:40%"/>厘米(Centimeter)</span>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>体重<br>Weight</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" formTitle="" defaultValue="" restriction="number" onblur="_setFemaleBMI()" maxlength="50" style="width:20%"/>
									</span>
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" formTitle="" defaultValue="" restriction="number" onblur="_setMaleBMI()" maxlength="50" style="width:20%"/>
									</span>
									<span id="WEIGHT_POUNDS" style="display: none">磅(Pound)</span>
									<span id="WEIGHT_KILOGRAM">千克(Kilogram)</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">体重指数<br>BMI</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:dataValue field="FEMALE_BMI" defaultValue="" onlyValue="true"/>
									</span>
									<span class="maleinfo">
										<BZ:dataValue field="MALE_BMI" defaultValue="" onlyValue="true"/>
									</span>
									<span id="FEMALE_BMI_SHOW"></span>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>违法行为及刑事处罚<br>Criminal records</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" onclick="_setFemalePunishment(this)">No</BZ:radio>
										<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">Yes</BZ:radio>
										<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
									</span>
									<span class="maleinfo">
										<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="0" formTitle="" onclick="_setMalePunishment(this)">No</BZ:radio>
										<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setMalePunishment(this)">Yes</BZ:radio>
										<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
									</span>
									
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>有无不良嗜好<br>Any bad habits</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" onclick="_setFemaleIllegalact(this)">No</BZ:radio>
										<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">Yes</BZ:radio>
										<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
									</span>
									<span class="maleinfo">
										<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="0" formTitle="" onclick="_setMaleIllegalact(this)">No</BZ:radio>
										<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setMaleIllegalact(this)">Yes</BZ:radio>
										<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
									</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">宗教信仰<br>Religious belief</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_RELIGION_EN" id="R_FEMALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500"/>
									</span>
									<span class="maleinfo">
										<BZ:input prefix="R_" field="MALE_RELIGION_EN" id="R_MALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500"/>
									</span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>婚姻状况<br>Marital status</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:select prefix="R_" field="MARRY_CONDITION" id="R_MARRY_CONDITION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" isShowEN="true" notnull="Please select the Marital status!" width="72%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>同居伙伴<br>Cohabitant partner</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">No</BZ:radio>
									<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">Yes</BZ:radio>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">同居时长<br>Cohabitation period</td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="CONABITA_PARTNERS_TIME" id="R_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" disabled="true"/>年(Year)
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>非同性恋声明<br>Non-Homosexual statement</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="GAY_STATEMENT" value="1" formTitle="" >Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>货币单位<br>Currency</td>
								<td class="bz-edit-data-value" colspan="4">
									<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  isShowEN="true" notnull="Please select the Currency Unit!" width="72%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>年收入<br>Annual income</td>
								<td class="bz-edit-data-value">
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
									</span>
									<span class="femaleinfo">
										<BZ:input prefix="R_" field="MALE_YEAR_INCOME" id="R_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
									</span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>家庭总资产<br>Assets</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:input prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" formTitle="" defaultValue="" restriction="number" notnull="Please write the asset of family!" onblur="_setTotalManny()"/>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>家庭总债务<br>Debts</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:input prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" formTitle="" defaultValue="" restriction="number" notnull="Please write the debt of family!" onblur="_setTotalManny()"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">家庭净资产<br>Net assets</td>
								<td class="bz-edit-data-value" width="19%">
									<span id="TOTAL_MANNY"></span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>18周岁以下子女数量<br>Number and age of children under 18 years old</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:input prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="Please write the number and age of children under 18 years old!" />个
								</td>
								<td class="bz-edit-data-title" width="15%">&nbsp;</td>
								<td class="bz-edit-data-value" width="18%">&nbsp;</td>
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
									<BZ:input prefix="R_" field="ADOPT_REQUEST_EN" id="R_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%"/>
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
						<div>家庭调查及组织意见信息(Home study and agency comments)</div>
					</div>
					<!-- 标题区域 end -->
					<!-- 内容区域 begin -->
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>完成家调组织名称<br>Adoption agency preparing the report</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:select prefix="R_" field="HOMESTUDY_ORG_DROP" id="R_HOMESTUDY_ORG_DROP" formTitle="" defaultValue="" isCode="true" codeName="ORGCOA_LIST" isShowEN="true" onchange="_setOrgNameDrop()">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
									<BZ:input prefix="R_" field="HOMESTUDY_ORG_INPUT" id="R_HOMESTUDY_ORG_INPUT" formTitle="" defaultValue="" maxlength="200" onblur="_setOrgNameInput()"/>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>家庭报告完成日期<br>Date of completion for home study</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:input prefix="R_" field="FINISH_DATE" dateExtend="lang:'en'" id="R_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="Please select the date of completion for home study!"/>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>会见次数<br>Meeting times</td>
								<td class="bz-edit-data-value" width="19%">
									<BZ:input prefix="R_" field="INTERVIEW_TIMES" id="R_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="Please write the meeting times!" onblur="_checkMeetingTimes(this)"/>次(Times)
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>推荐信<br>Recommendation letter</td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="RECOMMENDATION_NUM" id="R_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="Please write the number of recommendation letter!" onblur="_checkLetterValue(this);"/>封(Number of letter)
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>心理评估报告<br>Psychological assessment</td>
								<td class="bz-edit-data-value">
									<BZ:select prefix="R_" field="HEART_REPORT" id="R_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT" isShowEN="true" notnull="Please select the psychological evalustion report!" width="70%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>收养动机<br>Motive of adoption</td>
								<td class="bz-edit-data-value" width="19%">
									<BZ:select prefix="R_" field="ADOPT_MOTIVATION" id="R_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" isShowEN="true" notnull="Please select the adoption motive!" width="70%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>家中10周岁及以上孩子对收养的意见<br>Opinion of adoption by children in the family over age 10</td>
								<td class="bz-edit-data-value">
									<BZ:select prefix="R_" field="CHILDREN_ABOVE" id="R_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" isShowEN="true" notnull="Please select opinion of children above 10 years towards adoption!" width="70%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>有无指定监护人<br>Any designated guardian</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="IS_FORMULATE" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="IS_FORMULATE" value="1" formTitle="">Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>不遗弃不虐待声明<br>Statement of no abandonment and no abuse</td>
								<td class="bz-edit-data-value" width="19%">
									<BZ:radio prefix="R_" field="IS_ABUSE_ABANDON" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="IS_ABUSE_ABANDON" value="1" formTitle="">Yes</BZ:radio>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>抚育计划<br>Care plan </td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="IS_MEDICALRECOVERY" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="IS_MEDICALRECOVERY" value="1" formTitle="">Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>收养前准备<br>Pre-adoption preparation</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="ADOPT_PREPARE" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="ADOPT_PREPARE" value="1" formTitle="">Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>风险意识<br>Risk awareness</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="RISK_AWARENESS" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="RISK_AWARENESS" value="1" formTitle="">Yes</BZ:radio>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>同意递交安置后报告声明<br>Statement of consent for post-placement reports</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="IS_SUBMIT_REPORT" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="IS_SUBMIT_REPORT" value="1" formTitle="">Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>家中有无其他人同住<br>Anyone else living with the family</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="IS_FAMILY_OTHERS_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFamilyOthersDis(this)">No</BZ:radio>
									<BZ:radio prefix="R_" field="IS_FAMILY_OTHERS_FLAG" value="1" formTitle="" onclick="_setFamilyOthersDis(this)">Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title">&nbsp;</td>
								<td class="bz-edit-data-value">&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">家中其他人同住说明<br>Description of whether any other people living with the family</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input prefix="R_" field="IS_FAMILY_OTHERS_EN" id="R_IS_FAMILY_OTHERS_EN" type="textarea" formTitle="" defaultValue="" maxlength="500" disabled="true" style="width:96%;height:50px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>育儿经验<br>Parenting experience</td>
								<td class="bz-edit-data-value">
									<BZ:radio prefix="R_" field="PARENTING" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
									<BZ:radio prefix="R_" field="PARENTING" value="1" formTitle="">Yes</BZ:radio>
								</td>
								<td class="bz-edit-data-title"><font color="red">*</font>社工意见<br>Conclusion of social worker</td>
								<td class="bz-edit-data-value">
									<BZ:select prefix="R_" field="SOCIALWORKER" id="R_SOCIALWORKER" isCode="true" codeName="SGYJ" isShowEN="true" formTitle="" defaultValue="" notnull="Please select the social worker's recommendation!" width="70%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<%-- <td class="bz-edit-data-title">是否公约收养<br>Hague/Non-Hague adoption</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
								</td> --%>
								<td class="bz-edit-data-title">&nbsp;</td>
								<td class="bz-edit-data-value">&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">家庭需说明的其他事项<br>Other issues requiring clarification from the adoptive family </td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input prefix="R_" field="REMARK_EN" id="R_REMARK_EN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%"/>
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
								<td class="bz-edit-data-value" width="18%">
									<BZ:input prefix="R_" field="GOVERN_DATE" id="R_GOVERN_DATE" dateExtend="lang:'en'" type="Date" formTitle="" defaultValue="" notnull="Please select the date of approval!"/>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>有效期限<br>Validity period</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:select prefix="R_" field="VALID_PERIOD_TYPE" id="R_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="Please select the type of validity period!" onchange="_setValidPeriodShow()">
										<BZ:option value="1" selected="true">Validity period</BZ:option>
										<BZ:option value="2">Long-term</BZ:option>
									</BZ:select>
									<span id="R_PERIOD"><BZ:input prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="Please write the validity period!" style="width:20%"/>月(Month)</span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>批准儿童数量<br>Number of children approved</td>
								<td class="bz-edit-data-value" width="19%">
									<BZ:input prefix="R_" field="APPROVE_CHILD_NUM" id="R_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="number" maxlength="22" notnull="Please write the number of children approved!"/>个
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">收养儿童年龄<br>Age of children approved to be adopted</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:input prefix="R_" field="AGE_FLOOR" id="R_AGE_FLOOR" formTitle="" defaultValue="" restriction="number" maxlength="22" style="width:30%"/>岁~
									<BZ:input prefix="R_" field="AGE_UPPER" id="R_AGE_UPPER" formTitle="" defaultValue="" restriction="number" maxlength="22" style="width:30%"/>岁
								</td>
								<td class="bz-edit-data-title" width="15%">收养儿童性别<br>Gender of children approved to be adopted</td>
								<td class="bz-edit-data-value" width="18%">
									<BZ:select prefix="R_" field="CHILDREN_SEX" id="R_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" width="70%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title" width="15%">收养儿童健康状况<br>Health status of children approved to be adopted </td>
								<td class="bz-edit-data-value" width="19%">
									<BZ:select prefix="R_" field="CHILDREN_HEALTH_EN" id="R_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" isShowEN="true" width="70%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
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
									<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" property="childData" defaultValue="" onlyValue="true"/>
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
									<BZ:dataValue field="SUBMIT_DATE" property="childData" defaultValue="" onlyValue="true"/>
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
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<%=af_id %>" frameborder=0 width="100%" ></IFRAME>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 编辑区域end -->
			<br/>
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