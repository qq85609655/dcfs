<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String COUNTRY_CODE=(String)request.getAttribute("COUNTRY_CODE");
	DataList goveList = (DataList)request.getAttribute("goveList");
%> 

<%@page import="hx.database.databean.DataList"%><BZ:html>
<BZ:head>
	<title>政府部门信息</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script>
$(document).ready(function() {
	dyniframesize(['downFrame','rightFrame','mainFrame']);
});

//添加政府部门信息
function _submit(){
	if(confirm("确定提交吗？")){
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"mkr/MAINCountry/addGovement.action";
		document.srcForm.submit();
		var country_code = document.getElementById("COUNTRY_CODE").value;
		parent.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action?COUNTRY_CODE="+country_code+"&m=ok";
	}
}
</script>
<BZ:body property="data" codeNames="ZFBMXZ;">
	<BZ:form name="srcForm">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 负责人信息begin -->
	<div class="bz-edit clearfix" style="margin: 0;padding:0;width:100%;"  desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>
						政府部门信息
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<!-- 编辑区域 开始 -->
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">政府名称(CN)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="NAME_CN" prefix="G_" notnull="请输入政府名称(CN)" id="G_NAME_CN" defaultValue="" style="width:70%;"/>
								<input type="hidden" id="COUNTRY_CODE" name="COUNTRY_CODE" value="<%=COUNTRY_CODE %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">政府名称(EN)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="NAME_EN" prefix="G_" notnull="请输入政府名称(EN)" id="G_NAME_EN" defaultValue="" style="width:70%;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">政府性质</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:select field="NATURE"   formTitle="" prefix="G_" isCode="true" codeName="ZFBMXZ">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%">政府职能</td>
							<td class="bz-edit-data-value" colspan="3">
								<!-- 
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS0" value="0" formTitle="">沟通协调</BZ:checkbox>
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS1" value="1" formTitle="">递交文件</BZ:checkbox>
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS2" value="2" formTitle="">特需收养</BZ:checkbox>
								<BZ:checkbox prefix="G_" field="GOVER_FUNCTIONS3" value="3" formTitle="">签署征求意见书</BZ:checkbox>
								 -->
								 <%
									for(int i=0;i<goveList.size();i++){
										Data data =goveList.getData(i);
										String name = data.getString("NAME");
										String value = data.getString("VALUE");
										String a=String.valueOf(i);
										StringBuffer str = new StringBuffer();
								%>
											<input type="checkbox" name="G_GOVER_FUNCTIONS<%=a%>" value="<%=value%>" /> <%=name %>
								<% 
									}
								%>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">负责人姓名</td>
							<td class="bz-edit-data-value">
								<BZ:input field="HEAD_NAME" prefix="G_" notnull="请输入负责人姓名" id="G_HEAD_NAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">负责人电话</td>
							<td class="bz-edit-data-value" >
								<BZ:input  field="HEAD_PHONE" id="G_HEAD_PHONE" prefix="G_" defaultValue="" restriction="mobile"/>
							</td>
							<td class="bz-edit-data-title" width="15%">负责人邮箱</td>
							<td class="bz-edit-data-value" >
								<BZ:input  field="HEAD_EMAIL" id="G_HEAD_EMAIL" prefix="G_"  defaultValue="" restriction="email"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">网址</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="WEBSITE" prefix="G_" id="G_WEBSITE" defaultValue=""  style="width:70%"/>		
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">地址</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="ADDRESS" prefix="G_" id="G_ADDRESS" defaultValue="" style="width:70%"/>		
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">登记日期</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:input field="REG_DATE" prefix="G_" type="date" id="G_REG_DATE" notnull="请输入登记日期" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">最后修改日期</td>
							<td class="bz-edit-data-value" width="15%">
							<!-- 							
								<BZ:input  field="MOD_DATE" id="G_MOD_DATE" type="date" prefix="G_" defaultValue=""/>
							 -->
							</td>
							<td class="bz-edit-data-title" width="15%">排序号</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:input  field="SEQ_NO" id="G_SEQ_NO" prefix="G_"  defaultValue=""/>
							</td>
						</tr>
					</table>
					<!-- 编辑区域 结束 -->
					<!-- 按钮区 开始 -->
					<div class="bz-action-frame">
					<div class="bz-action-edit" desc="按钮区">
						<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>
					</div>
					</div>
					<!-- 按钮区 结束 -->
				</div>
			</div>
		</div>
	<!--负责人信息 end -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
