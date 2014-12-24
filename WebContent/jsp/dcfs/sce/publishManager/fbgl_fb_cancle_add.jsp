<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title:fbgl_fb_cancle_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
 * @version V1.0   
 */
   
    /******Java代码功能区域Start******/
    //发布记录主键ID
	String pubid= (String)request.getAttribute("pubid");
	Data rtfbData= (Data)request.getAttribute("rtfbData");
	String IS_TWINS = rtfbData.getString("IS_TWINS");
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java代码功能区域End******/
	
%>
<BZ:html>

<BZ:head>
	<title>儿童撤销发布页面</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" tree="true"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID');
	});
	
	
	
	
	//撤销发布提交
	function _submit(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			//只读下拉列表重置为可编辑，目的为了后台获得此数据
			$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
			$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
			$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
			$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
			$("#P_REVOKE_DATE").attr("disabled",false);
			$("#P_REVOKE_USERNAME").attr("disabled",false);
			//表单提交
			var obj = document.forms["srcForm"];
			obj.action=path+'sce/publishManager/saveCxfbInfo.action';
			obj.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.history.back();
	}
	
	//根据点发、群发动态展现相关区域
	function _dynamicFblx(){
		$("#P_COUNTRY_CODE").val("");
		$("#P_ADOPT_ORG_NAME").val("");
		$("#P_PUB_ORGID").val("");
		$("#M_PUB_ORGID").val("");
		$("#PUB_ORGID").val("");
		$("#P_PUB_MODE").val("");
		$("#M_PUB_MODE").val("");
		$("#P_SETTLE_DATE_NORMAL").val("");
		$("#P_SETTLE_DATE_SPECIAL").val("");
		$("#M_SETTLE_DATE_NORMAL").val("");
		$("#M_SETTLE_DATE_SPECIAL").val("");
		$("#P_PUB_REMARKS").val("");
		var optionValue = $("#P_PUB_TYPE").find("option:selected").val();
		if(optionValue=="1"){//点发
			$("#P_COUNTRY_CODE").attr("notnull","请输入国家");
			$("#P_ADOPT_ORG_NAME").attr("notnull","请输入发布组织");
			$("#P_PUB_MODE").attr("notnull","请输入点发类型");
			$("#PUB_ORGID").removeAttr("notnull");
			
			$("#dfzz").show();
			$("#dflx").show();
			$("#dfbz").show();
			$("#qfzz").hide();
			$("#qflx").hide();
		}else{//群发
			$("#PUB_ORGID").attr("notnull","请选择发布组织");
			$("#P_COUNTRY_CODE").removeAttr("notnull");
			$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
			$("#P_PUB_MODE").removeAttr("notnull");
			
			$("#dfzz").hide();
			$("#dflx").hide();
			$("#dfbz").hide();
			$("#qfzz").show();
			$("#qflx").show();
		}
		
	}
	
	//获得安置期限
	function _getAzqxForFb(){
		var is_df = $("#P_PUB_TYPE").find("option:selected").val();//发布类型  1：点发  2：群发
		var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//点发类型  
		
		if(""==pub_mode){
			pub_mode=null;
		}
		
		if("1"==is_df && (""==pub_mode||null==pub_mode)){
			return;
		}else{
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getAZQXInfo&IS_DF='+is_df+'&PUB_MODE='+pub_mode,
				type: 'POST',
				dataType: 'json',
				timeout: 1000,
				success: function(data){
					var two_type1 = data[0].TWO_TYPE;//是否特别关注  0:否  1：是
					var settle_months1 = data[0].SETTLE_MONTHS;
					var two_type2 = data[1].TWO_TYPE;//是否特别关注  0:否  1：是
					var settle_months2 = data[1].SETTLE_MONTHS;
					if("1"==is_df){//点发类型
						if("0"==two_type1){//非特别关注
							$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
							$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
						}else {//特别关注
							$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
							$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
						}
					}else {//群发类型
						if("0"==two_type1){//非特别关注
							$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
							$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
						}else {//特别关注
							$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
							$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
						}
					}
				}
			})
		}
		
		
		
	}
	
	//是否直接发布
	function _isShowFB(){
		
		var is_df = $("#S_IS_FB").find("option:selected").val();//是否直接发布  0：否  1：是
		if("1"==is_df){//直接发布
			$("#fbArea").show();
			_dynamicFblx();
		}else{
			$("#fbArea").hide();
			$("#PUB_ORGID").removeAttr("notnull");
			$("#P_COUNTRY_CODE").removeAttr("notnull");
			$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
			$("#P_PUB_MODE").removeAttr("notnull");
		}
	
	}
	
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;SYZZ;PROVINCE;BCZL;DFLX;SYS_ADOPT_ORG" property="rtfbData" onload="_isShowFB();">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="H_" field="PUBID" defaultValue="<%=pubid %>"/>
		<BZ:input type="hidden" prefix="H_" field="CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="H_" field="SPECIAL_FOCUS" defaultValue=""/>
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">省份</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE"  defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">福利院</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">姓名</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" checkValue="1=男;2=女;3=两性"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date" />
							</td>
							
							<td class="bz-edit-data-title"  width="10%">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true" />
							</td>
						</tr>
						<tr>
							
							<td class="bz-edit-data-title" width="10%">特别关注</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">发布类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_TYPE" defaultValue="" onlyValue="true" checkValue="1=点发;2=群发"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">发布日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" defaultValue="" onlyValue="true" type="Date" />
							</td>
							<td class="bz-edit-data-title"  width="10%">锁定状态</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_STATE" defaultValue="" onlyValue="true" checkValue="3=已锁定;2=未锁定;0=未锁定;1=未锁定;4=未锁定;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"  width="10%">安置期限</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SETTLE_DATE" defaultValue="" onlyValue="true" type="Date"/>
							</td>
							<td class="bz-edit-data-title" width="10%">是否多胞胎</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
							</td>
							<td class="bz-edit-data-title" width="10%"><%if("1".equals(IS_TWINS)||"1"==IS_TWINS){ %>同胞姓名<%} %></td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="TB_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td class="bz-edit-data-title"  width="10%">发布组织</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true" codeName="SYS_ADOPT_ORG"  />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- 编辑区域end -->
		<br/>
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>撤销信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>撤销原因</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="REVOKE_REASON" id="P_REVOKE_REASON" type="textarea" prefix="P_" formTitle="撤销原因" defaultValue="" style="width:80%"  maxlength="900" notnull="请输入撤销原因"/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">是否直接发布</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="S_" field="IS_FB" id="S_IS_FB" formTitle="是否直接发布" defaultValue="" onchange="_isShowFB();">
									<BZ:option value="0" selected="true">否</BZ:option>
									<BZ:option value="1">是</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">撤销人</td>
							<td class="bz-edit-data-value">
								<BZ:input  prefix="P_" field="REVOKE_USERNAME" id="P_REVOKE_USERNAME" defaultValue="" formTitle="撤销人"  readonly="true"/>
								<BZ:input type="hidden" field="REVOKE_USERID"  prefix="P_" id="P_REVOKE_USERID"/>
							</td>
							<td class="bz-edit-data-title" width="10%">撤销日期</td>
							<td class="bz-edit-data-value"  >
								<BZ:input type="Date" field="REVOKE_DATE" prefix="P_" readonly="true"/>
							</td>
							
							
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- 编辑区域end -->
		<br/>
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper" id="fbArea" sytle="display:none">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>发布信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布类型</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="请输入发布类型" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()">
									<option value="1">点发</option>
									<option value="2">群发</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布组织</td>
							<td class="bz-edit-data-value" id="dfzz">
								<BZ:select field="COUNTRY_CODE" notnull="请输入发布国家" formTitle="" defaultValue="" prefix="P_" id="P_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN"  width="168px"
								 onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID')">
									<option value="">--请选择--</option>
								</BZ:select> —
								<BZ:select prefix="P_" field="PUB_ORGID" id="P_PUB_ORGID" notnull="请输入收养组织" formTitle="" prefix="P_" width="168px"
									onchange="_setOrgID('P_HIDDEN_PUB_ORGID',this.value)">
									<option value="">--请选择收养组织--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_PUB_ORGID" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>' />
							
							</td>
							<td class="bz-edit-data-value" id="qfzz" style="display:none">
								<BZ:input prefix="M_" field="PUB_ORGID" type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="选择发布组织" treeType="1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="PUB_ORGID" notnull="请选择发布组织" style="height:13px;width:80%"  />
							</td>
						</tr>
						<tr id="dflx">
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>点发类型</td>
							<td class="bz-edit-data-value"  >
								<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="请输入点发类型" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">安置期限</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>日（特别关注）
								<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>日（非特别关注）
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">安置期限</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>日（特别关注）
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>日（非特别关注）
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">点发备注</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="点发备注" defaultValue="" style="width:80%" maxlength="900"/>
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
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
