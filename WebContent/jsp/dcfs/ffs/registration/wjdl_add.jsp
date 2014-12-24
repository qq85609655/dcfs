<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: wjdl_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-7-14 下午3:00:34 
 * @version V1.0   
 */
   
    /******Java代码功能区域Start******/
 	//构造数据对象
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java代码功能区域End******/
	//获取附件信息ID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
%>
<BZ:html>

<BZ:head language="CN">
	<title>文件代录</title>
	<up:uploadResource/>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		_dynamicHide();
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
			obj.action=path+'ffs/registration/saveFlieRecord.action';
			obj.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	
	//根据收养类型，动态对男女姓名、出生日期进行只读和必填项设置
	function _dynamicHide(){
		var val = $("#P_FAMILY_TYPE_VIEW2").val();//收养类型
		var val2 = $("#P_FILE_TYPE").val();//文件类型
		var val3 = $("#P_ADOPTER_SEX").val();//收养人性别
		if(val=="单亲收养（女）"){
			//动态显示必填符号*
			$("#nf").hide();
			$("#nfcs").hide();
			$("#ff").show();
			$("#ffcs").show();
			$("#syrxb").show();
			$("#syrxb2").show();
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
		}else if(val=="单亲收养（男）"){
			//动态显示必填符号*
			$("#nf").show();
			$("#nfcs").show();
			$("#ff").hide();
			$("#ffcs").hide();
			$("#syrxb").show();
			$("#syrxb2").show();
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
		}else if(val=="双亲收养"){
			if(val2=="33"&&val3=="1"){//如果文件类型为继子女收养，并且收养人性别为男
				$("#P_MALE_NAME").attr("disabled",false);
				$("#P_MALE_BIRTHDAY").attr("disabled",false);
				$("#P_FEMALE_NAME").attr("disabled",true);
				$("#P_FEMALE_BIRTHDAY").attr("disabled",true);
				$("#P_MALE_NAME").attr("notnull","请输入男方姓名");
				$("#P_MALE_BIRTHDAY").attr("notnull","请输入男方出生日期");
				$("#P_FEMALE_NAME").removeAttr("notnull");
				$("#P_FEMALE_BIRTHDAY").removeAttr("notnull");
				$("#syrxb").show();
				$("#nf").show();
				$("#nfcs").show();
				$("#ff").hide();
				$("#ffcs").hide();
				
			}else if(val2=="33"&&val3=="2"){//如果文件类型为继子女收养，并且收养人性别为女
				$("#P_MALE_NAME").attr("disabled",true);
				$("#P_MALE_BIRTHDAY").attr("disabled",true);
				$("#P_FEMALE_NAME").attr("disabled",false);
				$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
				$("#P_FEMALE_NAME").attr("notnull","请输入女方姓名");
				$("#P_FEMALE_BIRTHDAY").attr("notnull","请输入女方出生日期");
				$("#P_MALE_NAME").removeAttr("notnull");
				$("#P_MALE_BIRTHDAY").removeAttr("notnull");
				$("#syrxb").show();
				$("#ff").show();
				$("#ffcs").show();
				$("#nf").hide();
				$("#nfcs").hide();
			}else{
				$("#P_FEMALE_NAME").attr("disabled",false);
				$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
				$("#P_MALE_NAME").attr("disabled",false);
				$("#P_MALE_BIRTHDAY").attr("disabled",false);
				$("#P_FEMALE_NAME").attr("notnull","请输入女方姓名");
				$("#P_FEMALE_BIRTHDAY").attr("notnull","请输入女方出生日期");
				$("#P_MALE_NAME").attr("notnull","请输入男方姓名");
				$("#P_MALE_BIRTHDAY").attr("notnull","请输入男方出生日期");
				$("#syrxb").hide();
				$("#nf").show();
				$("#nfcs").show();
				$("#ff").show();
				$("#ffcs").show();
			}
		}
	}
	
	
	/**
	*选择文件转组织
	*@author:mayun
	*@date:2014-7-17
	*/
	function _chosefile(){
		var temp=document.getElementsByName("P_IS_CHANGE_ORG");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var num = temp[i].value;
				if(num==0){//否
					$("#yswbh").hide();
					$("#yswbh2").hide();
					$("#P_ORIGINAL_FILE_NO").val("");
					$("#P_ORIGINAL_FILE_NO").removeAttr("notnull");
				}else{//是
					$("#yswbh").show();
					$("#yswbh2").show();
					$("#P_ORIGINAL_FILE_NO").attr("notnull","请输入原收文编号");
					//window.open(path+"ffs/registration/toChoseFile.action","",",'height=500,width=800,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
				}
			}
		}
	}
	
	
	function _openchosefile(){
		window.open(path+"ffs/registration/toChoseFile.action","",",'height=500,width=800,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
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
	
	//根据收文编号获取收养文件基本信息，并向页面动态赋值
	function _dySetFileInfo(fileNo){
		if(null!=fileNo&&""!=fileNo){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=getFileInfo&fileNo='+fileNo,
				type: 'POST',
				timeout:1000,
				dataType: 'json',
				success: function(data){
					$("#P_FILE_TYPE").val(data.FILE_TYPE);//文件类型
					$("#P_FAMILY_TYPE").val(data.FAMILY_TYPE);//收养类型
					$("#P_MALE_NAME").val(data.MALE_NAME);//男收养人
					$("#P_MALE_BIRTHDAY").val(data.MALE_BIRTHDAY);//男出生日期
					$("#P_FEMALE_NAME").val(data.FEMALE_NAME);//女收养人
					$("#P_FEMALE_BIRTHDAY").val(data.FEMALE_BIRTHDAY);//女出生日期
					//$("#P_COUNTRY_CODE").val(data.COUNTRY_CODE);//国家
					//$("#P_ADOPT_ORG_ID").val(data.ADOPT_ORG_ID);//收养组织code
					//$("#P_ADOPT_ORG_NAME").val(data.NAME_CN);//收养组织Name
					$("#P_ORIGINAL_FILE_NO").val(data.FILE_NO);//原收文编号
				}
		  	  });
		}
	}
	
	function _goup(){
		var obj = document.forms["srcForm"];
		obj.action=path+"/ffs/registration/toAddFlieRecordChoise.action";
		obj.submit();
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

<BZ:body codeNames="GJSY;SYS_GJSY_CN;WJLX_DL;FYLB;JFFS;FWF" property="wjdlData" >

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_CN"/>
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_EN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_CN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_EN"/>
		<BZ:input type="hidden" prefix="P_" field="AF_COST" id="P_AF_COST"/>
		<BZ:input type="hidden" field="ISPIAOJUVALUE" prefix="P_" id="P_ISPIAOJUVALUE"/>
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
							<td class="bz-edit-data-title" width="20%">文件类型</td>
							<td class="bz-edit-data-value"  width="30%">
								<BZ:dataValue field="FILE_TYPE_VIEW" codeName="WJLX_DL" defaultValue="" onlyValue="true"/>
								<BZ:input type="hidden" field="FILE_TYPE" prefix="P_" id="P_FILE_TYPE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">收养类型</td>
							<td class="bz-edit-data-value"  width="30%">
								<BZ:dataValue field="FAMILY_TYPE_VIEW" defaultValue="" onlyValue="true"/>
								<BZ:input type="hidden" field="FAMILY_TYPE" defaultValue="" prefix="P_"  id="P_FAMILY_TYPE"/>
								<BZ:input type="hidden" field="FAMILY_TYPE_VIEW2" defaultValue="" prefix="P_"  id="P_FAMILY_TYPE_VIEW2"/>
							</td>
						</tr>
						<tr  id="syrxb" style="display:none">
							<td class="bz-edit-data-title" width="20%">收养人性别</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="ADOPTER_SEX_VIEW" defaultValue="" onlyValue="true"/>
								<BZ:input type="hidden" field="ADOPTER_SEX" defaultValue="" prefix="P_"  id="P_ADOPTER_SEX"/>
								<BZ:input type="hidden" field="ADOPTER_SEX_VIEW2" defaultValue="" prefix="P_"  id="P_ADOPTER_SEX_VIEW2"/>
							</td>
							<td class="bz-edit-data-title" width="20%"></td>
							<td class="bz-edit-data-value" width="30%"></td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家</td>
							<td class="bz-edit-data-value">
								<BZ:select field="COUNTRY_CODE" formTitle=""
									prefix="P_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
									onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--请选择--
									</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>收养组织</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
									onchange="_setOrgID('P_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">转&nbsp;&nbsp;组&nbsp;&nbsp;织</td>
							<td class="bz-edit-data-value" >
								<BZ:radio field="IS_CHANGE_ORG" value="0" prefix="P_" formTitle="" defaultChecked="true" onclick="_chosefile()">否</BZ:radio>
								<BZ:radio field="IS_CHANGE_ORG" value="1" prefix="P_" formTitle="" onclick="_chosefile()">是</BZ:radio>
							</td>
							<td class="bz-edit-data-title poptitle" style="display:none" id="yswbh"><font color="red">*</font>原收文编号</td>
							<td class="bz-edit-data-value" style="display:none" id="yswbh2">
								<BZ:input field="ORIGINAL_FILE_NO" id="P_ORIGINAL_FILE_NO" prefix="P_" type="String" formTitle="原收文编号" defaultValue="" maxlength="50" />
								<img src="<%=request.getContextPath() %>/resources/resource1/images/page/edit-find.png" onclick="_openchosefile()" title="点击选择原收文编号">
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red" id="nf">*</font>男收养人</td>
							<td class="bz-edit-data-value">
								<BZ:input field="MALE_NAME" id="P_MALE_NAME" prefix="P_" type="String"  formTitle="男方" defaultValue="" style="width:75%" maxlength="150"/>
							</td>
							<td class="bz-edit-data-title"><font color="red" id="nfcs">*</font>出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:input field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" prefix="P_" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle"><font color="red" id="ff">*</font>女收养人</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="FEMALE_NAME" id="P_FEMALE_NAME" prefix="P_" type="String"  formTitle="女方" defaultValue="" style="width:75%" maxlength="150"/>
							</td>
							<td class="bz-edit-data-title"><font color="red" id="ffcs">*</font>出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:input field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" prefix="P_" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="REG_REMARK" id="P_REG_REMARK" type="textarea" prefix="P_" formTitle="备注" defaultValue=""  style="width:75%" maxlength="500"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">是否录入票据信息</td>
							<td class="bz-edit-data-value" colspan="3">
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
								<BZ:input field="PAID_SHOULD_NUM" id="P_PAID_SHOULD_NUM" prefix="P_" type="String" restriction="number"  formTitle="票面金额" defaultValue="" style="width:67%" />
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
									bigType="FAM"
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
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="上一步" class="btn btn-sm btn-primary" onclick="_goup()"/>
				<input type="button" value="取消" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
