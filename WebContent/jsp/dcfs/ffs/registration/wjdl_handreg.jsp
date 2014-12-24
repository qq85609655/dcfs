<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: wjdl_handreg.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-8-7 下午13:57:23
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
	String paidNum = (String)request.getAttribute("paidNum");
	
	//获取附件信息ID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
%>
<BZ:html>

<BZ:head language="CN">
	<title>文件手工登记</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
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
			var infoNum = document.getElementsByName("P_COUNTRY_CODE");
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
			$("#P_PAID_SHOULD_NUM").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			
			//表单提交
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveFileHandReg.action';
			obj.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	
	//删除选择的文件信息
	function _deleteRow() {
		var num = 0;
		var totalCost = $("#P_PAID_SHOULD_NUM").val();
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				var tempCost = arrays[i].value;
				totalCost=Number(totalCost)-Number(tempCost);
				num += 1;
			}
		}
		if(num == 0){
			alert("请选择需要删除的信息！");
			return;
		}
		if(confirm("确定删除本条文件信息吗？")){
			if(arrays.length - num < 1){
				alert("必须留有至少一条文件信息！");
				return;
			}else{
				
				
				$("#P_PAID_SHOULD_NUM").val(totalCost);//动态调整应缴费用
				$(':checkbox[name=xuanze]').each(function(){
					if($(this).attr('checked')){
						$(this).closest('tr').remove();
					}
				});
			}
		}
	}
	
	//根据收养类型，动态对男女姓名、出生日期进行只读和必填项设置
	function _dynamicHide(){
		var optionText = $("#P_FAMILY_TYPE").find("option:selected").text();
		if(optionText=="单亲收养（女）"){
			//动态显示必填符号*
			$("#nf").hide();
			$("#nfcs").hide();
			$("#ff").show();
			$("#ffcs").show();
			//动态设置男女姓名、出生日期只读属性和初始值
			$("#P_MALE_NAME").val("");
			$("#P_MALE_BIRTHDAY").val("");
			$("#P_MALE_NAME").attr("disabled",true);
			$("#P_MALE_BIRTHDAY").attr("disabled",true);
			$("#P_FEMALE_NAME").attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
			//设置女方姓名、出生日期为必填项
			$("#P_FEMALE_NAME").attr("notnull","请输入女方姓名");
			$("#P_FEMALE_BIRTHDAY").attr("notnull","请输入女方出生日期");
			$("#P_MALE_NAME").removeAttr("notnull");
			$("#P_MALE_BIRTHDAY").removeAttr("notnull");
		}else if(optionText=="单亲收养（男）"){
			//动态显示必填符号*
			$("#nf").show();
			$("#nfcs").show();
			$("#ff").hide();
			$("#ffcs").hide();
			//动态设置男女姓名、出生日期只读属性和初始值
			$("#P_FEMALE_BIRTHDAY").val("");
			$("#P_MALE_NAME").attr("disabled",false);
			$("#P_MALE_BIRTHDAY").attr("disabled",false);
			$("#P_FEMALE_NAME").attr("disabled",true);
			$("#P_FEMALE_BIRTHDAY").attr("disabled",true);
			//设置男方姓名、出生日期为必填项
			$("#P_MALE_NAME").attr("notnull","请输入男方姓名");
			$("#P_MALE_BIRTHDAY").attr("notnull","请输入男方出生日期");
			$("#P_FEMALE_NAME").removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY").removeAttr("notnull");
		}else if(optionText=="双亲收养"){
			//动态显示必填符号*
			$("#nf").show();
			$("#nfcs").show();
			$("#ff").show();
			$("#ffcs").show();
			//移除男女方姓名、出生日期为只读属性
			$("#P_MALE_NAME").attr("disabled",false);
			$("#P_MALE_BIRTHDAY").attr("disabled",false);
			$("#P_FEMALE_NAME").attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
			//设置男方姓名、出生日期为必填项
			$("#P_MALE_NAME").attr("notnull","请输入男方姓名");
			$("#P_MALE_BIRTHDAY").attr("notnull","请输入男方出生日期");
			$("#P_FEMALE_NAME").attr("notnull","请输入女方出生日期");
			$("#P_FEMALE_BIRTHDAY").attr("notnull","请输入女方出生日期");
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
</script>

<BZ:body codeNames="GJSY;WJLX_DL;WJLX;FYLB;JFFS;FWF;SYZZ" property="wjdlData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_CN"/>
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_EN"/>
		<BZ:input type="hidden" field="ISPIAOJUVALUE" prefix="P_" id="P_ISPIAOJUVALUE"/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>待登记文件信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" style="text-align: right; border-right:none;">
							</td>
							<td class="bz-edit-data-title" width="75%" style="text-align: right; border-left:none; border-right:none;">
							</td>
							<td class="bz-edit-data-title" width="5%" style="text-align: left; border-left:none;">
								<input type="button" value="移&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_deleteRow()"/>
							</td>
						</tr>
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table table-striped table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
										<tr style="background-color: rgb(180, 180, 249);">
											<th style="width: 3%; text-align: center; border-left: 0;">
												<div class="sorting_disabled">
													<input type="checkbox" class="ace">
												</div>
											</th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="AF_SEQ_NO">流水号</div></th>
											<th style="width: 6%; text-align: center;">
												<div class="sorting_disabled" id="COUNTRY_CODE">国家</div></th>
											<th style="width: 15%; text-align: center;">
												<div class="sorting_disabled" id="ADOPT_ORG_ID">收养组织</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="FILE_TYPE">文件类型</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="FAMILY_TYPE">收养类型</div></th>
											<th style="width: 13%; text-align: center;">
												<div class="sorting_disabled" id="MALE_NAME">男方</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="MALE_BIRTHDAY">男出生日期</div></th>
											<th style="width: 13%; text-align: center;">
												<div class="sorting_disabled" id="FEMALE_NAME">女方</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="FEMALE_BIRTHDAY">女出生日期</div></th>
										</tr>
									</thead>
									<tbody>
										<BZ:for property="List" fordata="fordata">
											<script type="text/javascript">
												<%
												String file_type = ((Data)pageContext.getAttribute("fordata")).getString("FILE_TYPE","");
												String male_name = ((Data)pageContext.getAttribute("fordata")).getString("MALE_NAME","");
												String female_name = ((Data)pageContext.getAttribute("fordata")).getString("FEMALE_NAME","");
												%>
											</script>
											<tr>
												<td class="center">
													<input name="xuanze" type="checkbox" class="ace" value="<BZ:data field="AF_COST" onlyValue="true"/>">
													<BZ:input prefix="P_" field="AF_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="RI_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="CI_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="AF_COST" type="hidden" property="fordata" />
												</td>
												<td><BZ:data field="AF_SEQ_NO" defaultValue="" onlyValue="true"/></td>
												<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/>
													<BZ:input prefix="P_" field="COUNTRY_CODE" type="hidden" property="fordata" /></td>
												<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
													<BZ:input prefix="P_" field="ADOPT_ORG_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="NAME_CN" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="NAME_EN" type="hidden" property="fordata" /></td>
												<%
													if("10".equals(file_type)||"30".equals(file_type)||"31".equals(file_type)||"32".equals(file_type)||"34".equals(file_type)||"35".equals(file_type)){
												%>
												<td>
													<BZ:select field="FILE_TYPE" id="P_FILE_TYPE"  isCode="false" notnull="请输入文件类型" formTitle="" prefix="P_" property="fordata" width="95%">
														<BZ:option value="10">正常</BZ:option>
														<BZ:option value="30">领导特批</BZ:option>
														<BZ:option value="31">华人</BZ:option>
														<BZ:option value="32">在华</BZ:option>
														<BZ:option value="34">亲属收养</BZ:option>
														<BZ:option value="35">华侨</BZ:option>
													</BZ:select>
												</td>
												<%
													}else{
												%>
												<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
												<BZ:input prefix="P_" field="FILE_TYPE" type="hidden" property="fordata" /></td>
												<%
													}
												%>
												<td><BZ:data field="FAMILY_TYPE" defaultValue="" onlyValue="true" checkValue="1=双亲收养;2=单亲收养;"/></td>
												<%
													if(!"".equals(male_name)){
												%>
												<td><BZ:input field="MALE_NAME" id="P_MALE_NAME" prefix="P_" type="String"  formTitle="男方" property="fordata" defaultValue="" style="width:93%" maxlength="150"/></td>
												<td><BZ:input field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" prefix="P_" property="fordata" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/></td>
												<%
													}else{
												%>
												<td><BZ:input prefix="P_" field="MALE_NAME" defaultValue="" type="hidden" property="fordata" /></td>
												<td><BZ:input prefix="P_" field="MALE_BIRTHDAY" defaultValue="" type="hidden" property="fordata" /></td>
												<%
													}
													if(!"".equals(female_name)){
												%>
												<td><BZ:input field="FEMALE_NAME" id="P_FEMALE_NAME" prefix="P_" type="String"  formTitle="女方" property="fordata" defaultValue="" style="width:93%" maxlength="150"/></td>
												<td><BZ:input field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" prefix="P_" property="fordata" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/></td>
												<%
													}else{
												%>
												<td><BZ:input prefix="P_" field="FEMALE_NAME" defaultValue="" type="hidden" property="fordata" /></td>
												<td><BZ:input prefix="P_" field="FEMALE_BIRTHDAY" defaultValue="" type="hidden" property="fordata" /></td>
												<%
													}
												%>
											</tr>
										</BZ:for>
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
								<BZ:input field="PAID_SHOULD_NUM" id="P_PAID_SHOULD_NUM" prefix="P_" formTitle="应缴费用" defaultValue="<%=paidNum%>" style="width:67%"/>
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
