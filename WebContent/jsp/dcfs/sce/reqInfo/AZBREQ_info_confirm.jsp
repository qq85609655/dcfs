<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:预批撤销信息确认页面
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data= (Data)request.getAttribute("data");
String pub_type = data.getString("PUB_TYPE");//发布类型
String pub_mode = data.getString("PUB_MODE");//点发类型
String pub_orgid = data.getString("PUB_ORGID");//点发组织ID
String country_code = data.getString("COUNTRY_CODE");//点发国家
String adopt_org_name = data.getString("ADOPT_ORG_NAME");//点发组织名称
String tmp_tmp_pub_orgid_name = data.getString("TMP_TMP_PUB_ORGID_NAME");//群发组织名称
String pub_remarks = data.getString("PUB_REMARKS");//点发备注
%>
<BZ:html>
<BZ:head>
	<title>撤销申请信息</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		_findSyzzNameListForNew('c_COUNTRY_CODE','c_ADOPT_ORG_ID','c_PUB_ORGID');
	});
	//根据点发、群发动态展现相关区域
	function _dynamicFblx(){
		_findSyzzNameListForNew('c_COUNTRY_CODE','c_ADOPT_ORG_ID','c_PUB_ORGID');
		$("#M_PUB_ORGID").val("");
		$("#PUB_ORGID").val("");
		$("#c_PUB_MODE").val("");
		$("#M_PUB_MODE").val("");
		$("#c_SETTLE_DATE_NORMAL").val("");
		$("#c_SETTLE_DATE_SPECIAL").val("");
		$("#M_SETTLE_DATE_NORMAL").val("");
		$("#M_SETTLE_DATE_SPECIAL").val("");
		$("#c_PUB_REMARKS").val("");
		
		var optionValue = $("#c_PUB_TYPE").find("option:selected").val();
		if(optionValue=="1"){//点发
			$("#c_COUNTRY_CODE").attr("notnull","请输入国家");
			$("#c_ADOPT_ORG_ID").attr("notnull","请输入发布组织");
			$("#c_PUB_MODE").attr("notnull","请输入点发类型");
			$("#M_PUB_ORGID").removeAttr("notnull");
			
			$("#dfzz").show();
			$("#dflx").show();
			$("#dfbz").show();
			$("#qfzz").hide();
			$("#qflx").hide();
		}else{//群发
			$("#M_PUB_ORGID").attr("notnull","请选择发布组织");
			$("#c_COUNTRY_CODE").removeAttr("notnull");
			$("#c_ADOPT_ORG_ID").removeAttr("notnull");
			$("#c_PUB_MODE").removeAttr("notnull");
			
			$("#dfzz").hide();
			$("#dflx").hide();
			$("#dfbz").hide();
			$("#qfzz").show();
			$("#qflx").show();
		}
		
	}

	//获得安置期限
	function _getAzqxForFb(){
		var is_df = $("#c_PUB_TYPE").find("option:selected").val();//发布类型  1：点发  2：群发
		var pub_mode = $("#c_PUB_MODE").find("option:selected").val();//点发类型  
		
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
							$("#c_SETTLE_DATE_NORMAL").val(settle_months1);
							$("#c_SETTLE_DATE_SPECIAL").val(settle_months2);
						}else {//特别关注
							$("#c_SETTLE_DATE_NORMAL").val(settle_months2);
							$("#c_SETTLE_DATE_SPECIAL").val(settle_months1);
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
	
	function isPublish(obj){
		var V = obj.value;
		if(V == "1"){
			var pub_type=document.getElementById("c_PUB_TYPE").value;
			if(pub_type=="1"){
				$("#c_COUNTRY_CODE").attr("notnull","请输入国家");
				$("#c_ADOPT_ORG_ID").attr("notnull","请输入发布组织");
				$("#c_PUB_MODE").attr("notnull","请输入点发类型");
			}else{
				$("#M_PUB_ORGID").attr("notnull","请选择发布组织");
			}
			$("#fbxx").show();
		}else{
			$("#c_PUB_TYPE").removeAttr("notnull");
			$("#c_COUNTRY_CODE").removeAttr("notnull");
			$("#c_ADOPT_ORG_ID").removeAttr("notnull");
			$("#c_PUB_MODE").removeAttr("notnull");
			$("#M_PUB_ORGID").removeAttr("notnull");
			$("#fbxx").hide();
			
		}
	}
	
	function pubType(obj){
		var V = obj.value;
		if(V == "1"){
			$("#dflx").show();
		}else{
			$("#dflx").hide();
		}
	}
	
	function _submit(){
		if (!runFormVerify(document.srcForm, false)) {
			alert("有必填项未填写，请完善之后再进行提交！");
			return;
		}else{
			var RI_ID = document.getElementById("RI_ID").value;
			document.srcForm.action=path+"info/AZBReqInfoconfirm.action?RI_ID="+RI_ID;
			document.srcForm.submit();
		}
	}
	
	//返回预批撤销列表
	function _goback(){
		document.srcForm.action=path+"info/AZBREQInfoList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;GJSY;DFLX;SYS_ADOPT_ORG;SYS_GJSY_CN">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<BZ:input field="RI_ID" type="hidden" id="RI_ID"/>
	<BZ:input field="CI_ID" prefix="H_" type="hidden"/>
	<BZ:input field="AF_ID" prefix="H_" type="hidden"/>
	<BZ:input field="SPECIAL_FOCUS" prefix="H_" type="hidden"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>撤销申请信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">国家</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="COUNTRY_CODE_NAME" codeName="GJSY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养组织</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">男收养人</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="MALE_NAME"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">女收养人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">省厅</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">福利院</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">姓名</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">性别</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">出生日期</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">申请日期</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="REVOKE_REQ_DATE" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">申请状态</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REVOKE_STATE" checkValue="0=待确认;1=已确认;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">申请撤销原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REVOKE_REASON" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否继续发布<font style="vertical-align: middle;" color="red">*</font></td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:select prefix="c_" field="isPublish" id="c_isPublish" formTitle="是否继续发布" width="150px;" onchange="isPublish(this)">
	                            <BZ:option value="1">是</BZ:option>
	                            <BZ:option value="2">否</BZ:option>
	                        </BZ:select>
						</td>
					</tr>
				</table>
			</div>
			<div id="fbxx">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>发布信息</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布类型</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PUB_TYPE" id="c_PUB_TYPE" notnull="请输入发布类型" formTitle="" prefix="c_" onchange="_dynamicFblx();_getAzqxForFb()">
									<option value="1">点发</option>
									<option value="2">群发</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布组织</td>
							<td class="bz-edit-data-value" id="dfzz">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="c_" id="c_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="150px" onchange="_findSyzzNameListForNew('c_COUNTRY_CODE','c_ADOPT_ORG_ID','c_PUB_ORGID')">
									<option value="">--请选择--</option>
								</BZ:select> — 
								<BZ:select prefix="c_" field="ADOPT_ORG_ID" id="c_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="260px" onchange="_setOrgID('c_PUB_ORGID',this.value)">
									<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="c_PUB_ORGID" name="c_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
							<td class="bz-edit-data-value" id="qfzz" style="display:none">
								<BZ:input prefix="M_" field="PUB_ORGID" id="M_PUB_ORGID"  type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="选择发布组织" treeType="1" helperSync="true" showParent="false" defaultShowValue="" defaultValue="<%=pub_orgid %>" showFieldId="M_PUB_ORGID"  style="height:13px;width:80%"  />
							</td>
						</tr>
						<tr id="dflx">
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>点发类型</td>
							<td class="bz-edit-data-value"  >
								<BZ:select field="PUB_MODE" id="c_PUB_MODE" notnull="请输入点发类型" formTitle="" prefix="c_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">安置期限</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="SETTLE_DATE_SPECIAL" id="c_SETTLE_DATE_SPECIAL" prefix="c_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（特别关注）
								<BZ:input field="SETTLE_DATE_NORMAL" id="c_SETTLE_DATE_NORMAL" prefix="c_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（非特别关注）
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">安置期限</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（特别关注）
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（非特别关注）
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">点发备注</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="c_PUB_REMARKS" type="textarea" prefix="c_" formTitle="点发备注" defaultValue="" style="width:80%"  maxlength="900"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
