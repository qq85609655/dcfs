<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	Data d = (Data)request.getAttribute("data");
	String path = request.getContextPath();
	String ID=d.getString("COUNTRY_CODE");
	String CURRENCY=d.getString("CURRENCY");
	
	String m = (String)request.getAttribute("m");
%>
<BZ:html>
<BZ:head>
	<title>国家维护</title>
	<BZ:webScript edit="true" list="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['rightFrame','mainFrame']);
		$('#tab-container').easytabs();
		var m = "<%=m %>";
		if(m == "ok"){
			document.getElementById("govement").click();
		}
		
	});
	function _submit(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"mkr/MAINCountry/reviseCountry.action";
			document.srcForm.submit();
		}
	}
</script>
<BZ:body property="data" codeNames="HBBZ;">
	<BZ:form name="srcForm" action="MAINCountry/reviseCountry.action" method="post">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<div id="tab-container" class='tab-container'>
			<ul class='etabs'>
				<li class='tab'><a href="#tab1">国家基本信息</a></li>
				<li class='tab'><a id="govement" href="<%=path%>/mkr/MAINCountry/findGovement.action?ID=<%=ID%>" data-target="#tab2" >政府部门</a></li>
			</ul>
			
			<div class='panel-container'>
			<!-- 组织基本信息begin -->
				<div id="tab1">
				<div class="bz-edit clearfix" desc="编辑区域" >
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<div class="bz-edit-data-content clearfix" desc="内容体">
					<!-- 编辑区域 开始 -->
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">国家中文名称</td>
							<td class="bz-edit-data-value"  colspan="5">
								<BZ:dataValue field="NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国家英文名称</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="NAME_EN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国家编码</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue   field="COUNTRY_CODE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">币种</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select field="CURRENCY"  prefix="C_"  formTitle="" codeName="HBBZ" isCode="true">
									<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">公约国</td> 
							<td class="bz-edit-data-value" width="18%">
								<BZ:radio field="CONVENTION" value="1" prefix="C_"  formTitle="">是</BZ:radio>
								<BZ:radio field="CONVENTION" value="0" prefix="C_" formTitle="">否</BZ:radio>
							</td>
							<td class="bz-edit-data-title" width="15%">在华居住公约收养</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:radio field="SOLICIT_SUBMISSIONS" value="1" prefix="C_"  formTitle="">是</BZ:radio>
								<BZ:radio field="SOLICIT_SUBMISSIONS" value="0" prefix="C_" formTitle="">否</BZ:radio>
							</td>
							<td class="bz-edit-data-title" width="15%">排序</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:input field="SEQ_NO"  prefix="C_" id="C_SEQ_NO"  defaultValue=""/>
								<BZ:input type="hidden" field="COUNTRY_CODE" prefix="C_" id="C_COUNTRY_CODE"  defaultValue=""/>
							</td>
						</tr>
					</table>
					<!-- 编辑区域 结束 -->
					</div>
					</div>
				</div>
				<!--组织基本信息 end -->
					<!-- 按钮区 开始 -->
					<div class="bz-action-frame">
					<div class="bz-action-edit" desc="按钮区">
						<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>
					</div>
					</div>
					<!-- 按钮区 结束 -->
				</div>
				<div id="tab2"></div>
			</div>
		</div>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		$('#tab-container').easytabs();
	});
</script>
</BZ:html>
