<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String state = (String)request.getAttribute("STATE");
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>修改</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	
	//保存
	function _caogao() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			var name = $("#P_NAME").val();
			var type = $("#P_TYPE").val();
			//检查美国公约认证机构信息是否有相同机构名称
			var data = getData('com.dcfs.mkr.USAConvention.CertificationBodyAjax','name='+name+'&type='+type);
			var coa_id = data.getString("COA_ID","");
			var cur_id = $("#P_COA_ID").val();
			if(coa_id != "" && coa_id != cur_id){
				var type_name = $("#P_TYPE").find("option:selected").text();
				alert(type_name+"机构中存在相同机构名称，请重新输入！");
				return;
			}else{
				document.srcForm.action = path + "mkr/USAConvention/saveCerBody.action";
				document.srcForm.submit();
			}
		}
	}
	
	//生效
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			var name = $("#P_NAME").val();
			var type = $("#P_TYPE").val();
			//检查美国公约认证机构信息是否有相同机构名称
			var data = getData('com.dcfs.mkr.USAConvention.CertificationBodyAjax','name='+name+'&type='+type);
			var coa_id = data.getString("COA_ID","");
			var cur_id = $("#P_COA_ID").val();
			if(coa_id != "" && coa_id != cur_id){
				var type_name = $("#P_TYPE").find("option:selected").text();
				alert(type_name+"机构中存在相同机构名称，请重新输入！");
				return;
			}else{
				var state = document.getElementById("P_STATE").value;
				if (state ==1){
					alert("只有草稿信息才可生效！");
				}else{
					if (confirm("确定生效吗？")) {
						document.getElementById("P_STATE").value = 1;
						document.srcForm.action = path + "mkr/USAConvention/saveCerBody.action";
						document.srcForm.submit();
					}
				}
			}
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'mkr/USAConvention/findBodyList.action';
	}
	
	</script>
</BZ:head>

<BZ:body codeNames="GYRZJGLX" property="rzjgData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<input type="hidden" id="P_PAGEACTION" name="P_PAGEACTION" value="update" />
	<BZ:input prefix="P_" field="COA_ID" id="P_COA_ID" type="hidden" />
	<BZ:input prefix="P_" field="STATE" id="P_STATE" type="hidden" />
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
		<!-- 标题区域 begin -->
		<div class="ui-state-default bz-edit-title" desc="标题">
			<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
			<div>修改认证机构信息</div>
		</div>
		<!-- 标题区域 end -->
		<div class="bz-edit-data-content clearfix" desc="内容体">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="20%"><font color="red">*</font>类型</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:select prefix="P_" field="TYPE" isCode="true" codeName="GYRZJGLX" notnull="请输入类型" formTitle="类型" defaultValue="" width="75%">
							<option value="">--请选择--</option>
						</BZ:select>
					</td>
					<td class="bz-edit-data-title" width="20%"><font color="red">*</font>机构名称</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:input field="NAME" id="P_NAME" prefix="P_" type="String"  formTitle="机构名称" notnull="请输入机构名称" defaultValue="" style="width:75%" maxlength="200"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title"><font color="red">*</font>地址</td>
					<td class="bz-edit-data-value">
						<BZ:input field="ADDR" id="P_ADDR" prefix="P_" type="String"  formTitle="地址" notnull="请输入地址" defaultValue="" style="width:75%" maxlength="200"/>
					</td>
					<td class="bz-edit-data-title"><font color="red">*</font>认证时间</td>
					<td class="bz-edit-data-value">
						<BZ:input field="VALID_DATE" id="P_VALID_DATE" notnull="请输入认证时间" prefix="P_" type="date"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title">失效时间</td>
					<td class="bz-edit-data-value">
						<BZ:input field="EXPIRE_DATE" id="P_EXPIRE_DATE" prefix="P_" type="date"/>
					</td>
					<td class="bz-edit-data-title">状态</td>
					<td class="bz-edit-data-value">
						<BZ:dataValue field="STATE" defaultValue="" onlyValue="true" checkValue="0=草稿;1=已生效;"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区" id="print1">
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_caogao();"/>&nbsp;
			<%
			if("1".equals(state)){
			%>
			&nbsp;
			<%
			}else{
			%>
			<input type="button" value="生效" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<%
			}
			%>
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
