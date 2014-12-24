<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: wjdl_batchadd.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-8-5 下午13:57:23
 * @version V1.0   
 */
   
    /******Java代码功能区域Start******/
 	//构造数据对象
	Data wjdlData = new Data();
	request.setAttribute("wjdlData",wjdlData);
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java代码功能区域End******/
	
	//获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	//获取附件信息ID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
%>
<BZ:html>

<BZ:head language="CN">
	<title>批量文件代录</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
</BZ:head>

<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		_getAfCost();
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID');
	});
	
	
	//新增文件代录信息
	function _submit(){
		if(confirm("确定提交吗？")){
			//是否录入费用信息
			_dyShowPjInfo();
			
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//判断文件信息是否为空
			var infoNum = document.getElementsByName("P_FILE_TYPE");
			if (infoNum.length < 1){
				alert("必须输入至少一条文件信息！");
				return;
			}
			
			//通过下拉列表选项，向隐藏字段赋值
			var temp1 = $("#P_COUNTRY_CODE").find("option:selected").text();
			var temp2 = $("#P_ADOPT_ORG_ID").find("option:selected").text();
			$("#P_COUNTRY_CN").val(temp1);//国家CN
			$("#P_NAME_CN").val(temp2);//组织CN
			
			//只读下拉列表重置为可编辑，目的为了后台获得此数据
			$("#P_FAMILY_TYPE").attr("disabled",false);
			$("#P_PAID_SHOULD_NUM").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			
			//表单提交
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveBatchFlieRecord.action?rowNum=' + seqNum ;
			obj.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	//动态添加一行文件信息
	function _addRow() {
		var af_cost=$("#P_AF_COST").val();
		var temp_sum_cost=$("#P_PAID_SHOULD_NUM").val();
		var sum_af_cost=Number(af_cost)+Number(temp_sum_cost);
		$("#P_PAID_SHOULD_NUM").val(sum_af_cost);
		
		seqNum++;
		var rowCount = info.rows.length;
		var newTr=$("<tr>");
		newTr.html("<td class='center'><input name='xuanze' class='ace' type='checkbox' /></td>"
			+ "<td><select name='P_FILE_TYPE" + seqNum + "' id='P_FILE_TYPE" + seqNum + "' onchange='_dynamicJznsy(" + seqNum + ")' type='text' style='height:22px; font-size:12px; width: 95%' notnull='请选择文件类型'><option value=''>--请选择--</option><option value='10'>正常</option><option value='30'>领导特批</option><option value='31'>在华</option><option value='32'>华人</option><option value='33'>继子女收养</option><option value='34'>亲属收养</option><option value='35'>华侨</option></select></td>"
			+ "<td><select name='P_FAMILY_TYPE" + seqNum + "' id='P_FAMILY_TYPE" + seqNum + "' onchange='_dynamicHide(" + seqNum + ");_dySetSyrxb(" + seqNum + ")' type='text' style='height:22px; font-size:12px; width: 95%' formTitle='null' notnull='请选择文件类型'><option value=''>--请选择--</option><option value='1'>双亲收养</option><option value='2'>单亲收养（女）</option><option value='2'>单亲收养（男）</option></select><br/><span id='syrxb" + seqNum + "' style='display:none;'><select name='P_ADOPTER_SEX" + seqNum + "' id='P_ADOPTER_SEX" + seqNum + "' onchange='_dynamic2Hide(" + seqNum + ")' type='text' style='height:22px; font-size:12px; width: 95%' formTitle='null' notnull='请选择收养人性别'><option value=''>--请选择--</option><option value='1'>男</option><option value='2'>女</option></select></span></td>"
			+ "<td><input name='P_MALE_NAME" + seqNum + "' id='P_MALE_NAME" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' notnull='请输入男方'/></td>"
			+ "<td><input name='P_MALE_BIRTHDAY" + seqNum + "' id='P_MALE_BIRTHDAY" + seqNum + "' class='Wdate' style='padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;' onclick='error_onclick(this);' onfocus='WdatePicker({dateFmt:&quot;yyyy-MM-dd&quot;,maxDate:&quot;%y-%M-%d&quot;})' type='text' notnull='请选择男出生日期'/></td>"
			+ "<td><input name='P_FEMALE_NAME" + seqNum + "' id='P_FEMALE_NAME" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' notnull='请输入女方'/></td>"
			+ "<td><input name='P_FEMALE_BIRTHDAY" + seqNum + "' id='P_FEMALE_BIRTHDAY" + seqNum + "' class='Wdate' style='padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;' onclick='error_onclick(this);' onfocus='WdatePicker({dateFmt:&quot;yyyy-MM-dd&quot;,maxDate:&quot;%y-%M-%d&quot;})' type='text' notnull='请选择女出生日期'/></td>"
			+ "<td><input name='P_REG_REMARK" + seqNum + "' id='P_REG_REMARK" + seqNum + "' class='inputText' style='width: 97%' type='text'/></td>");
		/* newTr.html("<td class=\"center\">"+
					"<input name=\"xuanze\" class=\"ace\" onclick=\"error_onclick(this);\" type=\"checkbox\" />"+
						"</td>"+
						"<td>"+
							"<select name=\"P_FILE_TYPE\" onkeyup=\"_check_one(this);\" onchange=\"_dynamicJznsy()\" type=\"text\" style=\"height:22px; font-size:12px; width: 95%\" formTitle=\"null\" notnull=\"请选择文件类型\"><option value=\"\">--请选择--</option><option value=\"10\">正常</option><option value=\"30\">领导特批</option><option value=\"31\">在华</option><option value=\"32\">华人</option><option value=\"33\">继子女收养</option><option value=\"34\">亲属收养</option><option value=\"35\">华侨</option></select>"+
						"</td>"+
						"<td>"+
							"<select name=\"P_FAMILY_TYPE\" onkeyup=\"_check_one(this);\" onchange=\"_dynamicHide()\" type=\"text\" style=\"height:22px; font-size:12px; width: 95%\" formTitle=\"null\" notnull=\"请选择文件类型\"><option value=\"\">--请选择--</option><option value=\"1\">双亲收养</option><option value=\"2\">单亲收养（女）</option><option value=\"2\">单亲收养（男）</option></select>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_MALE_NAME\" class=\"inputText\" style=\"width: 93%\" onkeyup=\"_check_one(this);\" onchange=\"\" type=\"text\" formTitle=\"null\" notnull=\"请输入男方\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_MALE_BIRTHDAY\" class=\"Wdate\" style=\"padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;\" onclick=\"error_onclick(this);\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})\" type=\"text\" formTitle=\"null\" notnull=\"请选择男出生日期\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_FEMALE_NAME\" class=\"inputText\" style=\"width: 93%\" onkeyup=\"_check_one(this);\" onchange=\"\" type=\"text\" formTitle=\"null\" notnull=\"请输入女方\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_FEMALE_BIRTHDAY\" class=\"Wdate\" style=\"padding-left: 2px; width: 92%; height: 18px; font-size: 12px; padding-top: 4px;\" onclick=\"error_onclick(this);\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})\" type=\"text\" formTitle=\"null\" notnull=\"请选择女出生日期\"/>"+
						"</td>"+
						"<td>"+
							"<input name=\"P_REG_REMARK\" class=\"inputText\" style=\"width: 97%\" onkeyup=\"_check_one(this);\" onchange=\"\" type=\"text\"/>"+
						"</td>"); */
		$("#info").append(newTr);
		
	}
	//删除选择的文件信息
	function _deleteRow() {
		var af_cost=$("#P_AF_COST").val();
		
		var num = 0;
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				num += 1;
			}
		}
		var totalNum = (arrays.length+1-num)*af_cost;
		$("#P_PAID_SHOULD_NUM").val(totalNum);//动态调整应缴费用
		$(':checkbox[name=xuanze]').each(function(){
			if($(this).attr('checked')){
				$(this).closest('tr').remove();
			}
		}); 
	}
	
	//根据收养类型，动态对男女姓名、出生日期进行只读和必填项设置
	function _dynamicHide(obj){
		var optionText = $("#P_FAMILY_TYPE" + obj).find("option:selected").text();
		if(optionText=="单亲收养（女）"){
			//动态设置男女姓名、出生日期只读属性和初始值
			$("#P_MALE_NAME" + obj).val("");
			$("#P_MALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",true);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",true);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//设置女方姓名、出生日期为必填项
			$("#P_FEMALE_NAME" + obj).attr("notnull","请输入女方姓名");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","请输入女方出生日期");
			$("#P_MALE_NAME" + obj).removeAttr("notnull");
			$("#P_MALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else if(optionText=="单亲收养（男）"){
			//动态设置男女姓名、出生日期只读属性和初始值
			$("#P_FEMALE_NAME" + obj).val("");
			$("#P_FEMALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",true);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",true);
			//设置男方姓名、出生日期为必填项
			$("#P_MALE_NAME" + obj).attr("notnull","请输入男方姓名");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","请输入男方出生日期");
			$("#P_FEMALE_NAME" + obj).removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else if(optionText=="双亲收养"){
			//移除男女方姓名、出生日期为只读属性
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//设置男方姓名、出生日期为必填项
			$("#P_MALE_NAME" + obj).attr("notnull","请输入男方姓名");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","请输入男方出生日期");
			$("#P_FEMALE_NAME" + obj).attr("notnull","请输入女方出生日期");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","请输入女方出生日期");
		}
	}
	
	//根据收养人性别，动态对男女姓名、出生日期进行只读和必填项设置
	function _dynamic2Hide(obj){
		var optionText = $("#P_ADOPTER_SEX" + obj).find("option:selected").text();
		if(optionText=="女"){
			//动态设置男女姓名、出生日期只读属性和初始值
			$("#P_MALE_NAME" + obj).val("");
			$("#P_MALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",true);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",true);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//设置女方姓名、出生日期为必填项
			$("#P_FEMALE_NAME" + obj).attr("notnull","请输入女方姓名");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","请输入女方出生日期");
			$("#P_MALE_NAME" + obj).removeAttr("notnull");
			$("#P_MALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else if(optionText=="男"){
			//动态设置男女姓名、出生日期只读属性和初始值
			$("#P_FEMALE_NAME" + obj).val("");
			$("#P_FEMALE_BIRTHDAY" + obj).val("");
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",true);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",true);
			//设置男方姓名、出生日期为必填项
			$("#P_MALE_NAME" + obj).attr("notnull","请输入男方姓名");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","请输入男方出生日期");
			$("#P_FEMALE_NAME" + obj).removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY" + obj).removeAttr("notnull");
		}else{
			//移除男女方姓名、出生日期为只读属性
			$("#P_MALE_NAME" + obj).attr("disabled",false);
			$("#P_MALE_BIRTHDAY" + obj).attr("disabled",false);
			$("#P_FEMALE_NAME" + obj).attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY" + obj).attr("disabled",false);
			//设置男方姓名、出生日期为必填项
			$("#P_MALE_NAME" + obj).attr("notnull","请输入男方姓名");
			$("#P_MALE_BIRTHDAY" + obj).attr("notnull","请输入男方出生日期");
			$("#P_FEMALE_NAME" + obj).attr("notnull","请输入女方出生日期");
			$("#P_FEMALE_BIRTHDAY" + obj).attr("notnull","请输入女方出生日期");
		}
	}
	
	
	/**
	*文件类型为继子女收养时，收养类型下拉列表只能选择男收养或女收养
	*@author:mayun
	*@date:2014-7-17
	*/
	function _dynamicJznsy(obj){
		var sylx = $("#P_FILE_TYPE" + obj).find("option:selected").val();
		if(sylx=="33"){
			//设置收养类型为双亲收养，并置灰
			$("#P_FAMILY_TYPE" + obj)[0].selectedIndex = 1; 
			$("#P_FAMILY_TYPE" + obj).attr("disabled",true);
			$("#syrxb" + obj).show();
			$("#P_ADOPTER_SEX" + obj).attr("notnull","请输入收养人性别");
			//去除男女姓名、出生日期必填限制
			$("#P_MALE_NAME" + obj).removeAttr("notnull");
			$("#P_MALE_BIRTHDAY" + obj).removeAttr("notnull");
			$("#P_FEMALE_NAME" + obj).removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY" + obj).removeAttr("notnull"); 
		}else{
			$("#P_FAMILY_TYPE" + obj)[0].selectedIndex = 0; 
			$("#P_FAMILY_TYPE" + obj).attr("disabled",false); 
			$("#syrxb" + obj).hide();
			$("#P_ADOPTER_SEX" + obj).removeAttr("notnull");
		}
	}
	
	//根据收养类型动态向收养人性别赋值
	function _dySetSyrxb(obj){
		var sylx = $("#P_FAMILY_TYPE" + obj).find("option:selected").text();
		if(sylx=="单亲收养（女）"){
			$("#P_ADOPTER_SEX" + obj)[0].selectedIndex = 2; 
		}else if(sylx=="单亲收养（男）"){
			$("#P_ADOPTER_SEX" + obj)[0].selectedIndex = 1; 
		}else{
			$("#P_ADOPTER_SEX" + obj)[0].selectedIndex = 0; 
		}
	}
	
	
	
	
	//动态显示票据录入信息
	function _dyShowPjInfo(){
		var temp=document.getElementsByName("P_ISPIAOJU");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var num = temp[i].value;
				$("#P_ISPIAOJUVALUE").val(num);
				if(num==0){//否
					$("#pjInfo").hide();
					$("#P_PAID_WAY").val("");
					$("#P_PAR_VALUE").val("");
					$("#P_PAID_WAY").removeAttr("notnull");
					$("#P_PAR_VALUE").removeAttr("notnull");
				}else{//是
					$("#pjInfo").show();
					$("#P_PAID_WAY").attr("notnull","请输入缴费方式");
					$("#P_PAR_VALUE").attr("notnull","请输入票面金额");
				}
			}
		}
	}
	
	
	
	//获取应缴金额
	function _getAfCost(){
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=getAfCost&file_type=ZCWJFWF',
			type: 'POST',
			timeout:1000,
			dataType: 'json',
			success: function(data){
				$("#P_AF_COST").val(data.VALUE1);
				$("#P_PAID_SHOULD_NUM").val(data.VALUE1);
			}
	  	  });
	}
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;WJLX_DL;FYLB;JFFS;FWF" property="wjdlData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_CN"/>
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_EN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_CN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_EN"/>
		<BZ:input type="hidden" field="ISPIAOJUVALUE" prefix="P_" id="P_ISPIAOJUVALUE"/>
		<BZ:input type="hidden" prefix="P_" field="AF_COST" id="P_AF_COST"/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>文件基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:select field="COUNTRY_CODE" formTitle="" notnull="请输入国家"
									prefix="P_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
									onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--请选择--
									</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>收养组织</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
									onchange="_setOrgID('P_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
							<td class="bz-edit-data-title" width="20%" style="text-align: center;">
								<input type="button" value="添加" class="btn btn-sm btn-primary" onclick="_addRow()"/>
								<input type="button" value="移除" class="btn btn-sm btn-primary" onclick="_deleteRow()"/>
							</td>
						</tr>
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
									<tr style="background-color: rgb(180, 180, 249);">
										<th style="width: 3%; text-align: center; border-left: 0;">
											<div class="sorting_disabled">
												<input type="checkbox" class="ace">
											</div>
										</th>
										<th style="width: 12%; text-align: center;">
											<div class="sorting_disabled" id="FILE_TYPE">文件类型</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="FAMILY_TYPE">收养类型</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="MALE_NAME">男方</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="MALE_BIRTHDAY">男出生日期</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_NAME">女方</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_BIRTHDAY">女出生日期</div></th>
										<th style="width: 25%; text-align: center;">
											<div class="sorting_disabled" id="REG_REMARK">备注</div></th>
									</tr>
									</thead>
									<tbody>
									<tr class="emptyData">
										<td class="center">
										</td>
										<td>
											<BZ:select field="FILE_TYPE" id="P_FILE_TYPE" notnull="请输入文件类型" formTitle="" prefix="P_" isCode="true" codeName="WJLX_DL" onchange="_dynamicJznsy('')" width="95%">
												<option value="">--请选择--</option>
											</BZ:select>
										</td>
										<td>
											<BZ:select field="FAMILY_TYPE" id="P_FAMILY_TYPE" notnull="请输入收养类型" formTitle="" prefix="P_" isCode="false" onchange="_dynamicHide('');_dySetSyrxb('')" width="95%">
												<option value="">--请选择--</option>
												<option value="1">双亲收养</option>
												<option value="2">单亲收养（女）</option>
												<option value="2">单亲收养（男）</option>
											</BZ:select>
											<br/>
											<span id="syrxb" style="display:none">
											<BZ:select field="ADOPTER_SEX" id="P_ADOPTER_SEX" notnull="请输入收养人性别" formTitle="" prefix="P_" isCode="false" onchange="_dynamic2Hide('')" width="95%">
												<option value="">--请选择--</option>
												<option value="1">男</option>
												<option value="2">女</option>
											</BZ:select>
											</span>
										</td>
										<td>
											<BZ:input field="MALE_NAME" id="P_MALE_NAME" prefix="P_" type="String"  formTitle="男方" defaultValue="" notnull="请输入男方" style="width:93%" maxlength="150"/>
										</td>
										<td>
											<BZ:input field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" prefix="P_" notnull="请选择男出生日期" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
										</td>
										<td>
											<BZ:input field="FEMALE_NAME" id="P_FEMALE_NAME" prefix="P_" type="String"  formTitle="女方" defaultValue="" notnull="请输入女方" style="width:93%" maxlength="150"/>
										</td>
										<td>
											<BZ:input field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" prefix="P_" notnull="请选择女出生日期" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
										</td>
										<td>
											<BZ:input field="REG_REMARK" id="P_REG_REMARK" type="String" prefix="P_" formTitle="备注" defaultValue=""  style="width:97%" maxlength="500"/>
										</td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">是否录入票据信息</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:radio field="ISPIAOJU"  prefix="P_" formTitle="是否录入票据信息" value="0" defaultChecked="true" onclick="_dyShowPjInfo()"/>否
								<BZ:radio field="ISPIAOJU"  prefix="P_" formTitle="是否录入票据信息" value="1" onclick="_dyShowPjInfo()"/>是
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" id="pjInfo" style="display:none">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>票据信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>费用类别</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="COST_TYPE" formTitle="" prefix="P_" isCode="true" codeName="FYLB" defaultValue="10" disabled="true" width="70%">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>应缴费用</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input field="PAID_SHOULD_NUM" id="P_PAID_SHOULD_NUM" prefix="P_" formTitle="应缴费用"  style="width:67%"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>缴费方式</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="PAID_WAY"  formTitle="" prefix="P_" isCode="true" codeName="JFFS" width="70%">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>票面金额</td>
							<td class="bz-edit-data-value">
								<BZ:input field="PAR_VALUE" id="P_PAR_VALUE" prefix="P_" type="String" restriction="number"  formTitle="票面金额" defaultValue="" style="width:67%"/>
							</td>
							<td class="bz-edit-data-title">缴费票号</td>
							<td class="bz-edit-data-value">
								<BZ:input field="BILL_NO" prefix="P_" type="String"  formTitle="缴费票号" defaultValue="" style="width:67%"/>
							</td>
							<td class="bz-edit-data-title">缴费凭据</td>
							<td class="bz-edit-data-value">
								<up:uploadBody 
									attTypeCode="OTHER" 
									bigType="<%=AttConstants.FAM %>"
									smallType="<%=AttConstants.FAW_JFPJ %>"
									id="P_FILE_CODE" 
									name="P_FILE_CODE"
									packageId="<%=cheque_id %>" 
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="class_code=FAM"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
									/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">缴费备注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="REMARKS" id="P_REMARKS" type="textarea" prefix="P_" formTitle="缴费备注" maxlength="500" style="width:80%" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="登记" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
