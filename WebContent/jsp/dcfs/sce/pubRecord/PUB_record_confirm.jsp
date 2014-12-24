<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:点发退回信息确认页面
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data= (Data)request.getAttribute("Data");
String pub_type = data.getString("PUB_TYPE");//发布类型
String pub_mode = data.getString("PUB_MODE");//点发类型
String pub_orgid = data.getString("PUB_ORGID");//点发组织ID
String country_code = data.getString("COUNTRY_CODE");//点发国家
String adopt_org_name = data.getString("ADOPT_ORG_NAME");//点发组织名称
String tmp_tmp_pub_orgid_name = data.getString("TMP_TMP_PUB_ORGID_NAME");//群发组织名称
String pub_remarks = data.getString("PUB_REMARKS");//点发备注
String newStr = (String)request.getAttribute("newStr");   //批量提交ID

TokenProcessor processor = TokenProcessor.getInstance();
String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>点发退回信息确认</title>
	<BZ:webScript edit="true" list="true"/>
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
		/* $("#c_COUNTRY_CODE").val("");
		$("#c_ADOPT_ORG_NAME").val("");
		$("#c_PUB_ORGID").val(""); */
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
			var id = '<%=newStr%>';
			document.srcForm.action=path+"record/PUBReturn.action?id="+id;
			document.srcForm.submit();
		}
	}
	
	//返回点发退回列表
	function _goback(){
		document.srcForm.action=path+"record/PUBRecordList.action";
		document.srcForm.submit();
	}
	
	function checkReturnType(id){
		 var url = path+"record/returnTypeCheck.action?id="+id+"&type=child";
		 _open(url,"点发退回详细信息",800,500);
	}
	function checkReturnMessage(id){
		 var url = path+"record/returnTypeCheck.action?id="+id+"&type=returnShow";
		 _open(url,"退回详细信息",800,500);
	}
	</script>
</BZ:head>
<BZ:body property="Data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;GJSY;SYS_GJSY_CN;SYS_ADOPT_ORG;SYZZ;">
	<BZ:form name="srcForm" method="post" token="<%=token %>" action="record/PUBRecordList.action">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<BZ:input field="CI_ID" prefix="H_" type="hidden"/>
	<BZ:input field="SPECIAL_FOCUS" prefix="H_" type="hidden"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>点发信息</div>
			</div>
		</div>
	</div>
	<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
		<div class="wrapper">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;"  adsorb="both" init="true" id="sample-table">
					<thead>
						<tr>
							<th style="width: 3%;">
								<div class="sorting_disabled">序号</div>
							</th>
							<th style="width: 3%;">
								<div class="sorting" id="PROVINCE_ID">省份</div>
							</th>
							<th style="width: 6%;">
								<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="NAME">姓名</div>
							</th>
							<th style="width: 3%;">
								<div class="sorting" id="SEX">性别</div>
							</th>
							<th style="width: 9%;">
								<div class="sorting" id="BIRTHDAY">出生日期</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="CNAME">发布组织</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="SETTLE_DATE">安置期限</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="PUB_FIRSTDATE">首次发布日期</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="PUB_LASTDATE">末次发布日期</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="PUBLISHER_NAME">发布人</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="RETURN_TYPE">退回类型</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="RETURN_USERNAME">退回人</div>
							</th>
							<th style="width: 5%;">
								<div class="sorting" id="RETURN_DATE">退回日期</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<BZ:for property="List">
						<tr class="emptyData">
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><a href="#" onclick='checkReturnType("<BZ:data field='PUB_ID' onlyValue='true'/>")'><BZ:data field="NAME" defaultValue="" onlyValue="true"/></a></td>
							<td><BZ:data field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" onlyValue="true"/></td>
							<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
							<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是;" onlyValue="true"/></td>
							<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="SETTLE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
							<td><BZ:data field="PUB_FIRSTDATE" defaultValue=""  type="date" onlyValue="true"/></td>
							<td><BZ:data field="PUB_LASTDATE" defaultValue="" type="date" onlyValue="true"/></td>
							<td><BZ:data field="PUBLISHER_NAME" defaultValue=""  onlyValue="true"/></td>
							<td><BZ:data field="RETURN_TYPE" defaultValue="" codeName="TXRTFBTHLX" onlyValue="true"/></td>
							<td><BZ:data field="RETURN_USERNAME" defaultValue="" onlyValue="true"/></td>
							<td><a href="#" onclick='checkReturnMessage("<BZ:data field='PUB_ID' onlyValue='true'/>")'><BZ:data field="RETURN_DATE"  defaultValue="" type="date" onlyValue="true"/></a></td>
						</tr>
						</BZ:for>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>退回信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" style="width: 20%">是否继续发布<font style="vertical-align: middle;" color="red">*</font></td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="c_" field="isPublish" formTitle="是否继续发布" width="150px;" onchange="isPublish(this)">
								<BZ:option value="1">是</BZ:option>
								<BZ:option value="2">否</BZ:option>
							</BZ:select>
						</td>
					</tr>
				</table>
			</div>
			<div id="fbxx" style="background-color: red">
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
								<BZ:input prefix="M_" field="PUB_ORGID" id="M_PUB_ORGID" type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="选择发布组织" treeType="1" helperSync="true" showParent="false" defaultShowValue="" defaultValue="<%=pub_orgid %>" showFieldId="M_PUB_ORGID" style="height:13px;width:80%"  />
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
