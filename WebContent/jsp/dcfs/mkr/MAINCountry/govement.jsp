<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.DataList"%><BZ:html>
<%
	String path = request.getContextPath();
	DataList contactList = (DataList)request.getAttribute("contactList");
	String GOV_ID = (String)request.getAttribute("GOV_ID");
	String COUNTRY_CODE=(String)request.getAttribute("COUNTRY_CODE");
	DataList goveList = (DataList)request.getAttribute("goveList");
	Data govData = (Data)request.getAttribute("govementData");
%>
<BZ:head>
	<title>政府部门信息</title>
	<BZ:webScript edit="true" list="true" />
</BZ:head>
<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['downFrame','rightFrame','mainFrame']);
	});
	
	//修改政府部门信息
	function _submit(){
		if(confirm("确定提交吗？")){	
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			var country_code = document.getElementById("COUNTRY_CODE").value;
			document.srcForm.action=path+"mkr/MAINCountry/reviseGovement.action?COUNTRY_CODE="+country_code;
			document.srcForm.submit();
			parent.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action?COUNTRY_CODE="+country_code+"&m=ok";
		}
	}
	
	//动态添加一行联系人信息
	function add(){
			seqNum++;
			var rowCount = info.rows.length;
			var newTr=$("<tr>");
			newTr.html("<td class='center'><input name='xuanze' class='ace' type='checkbox' /></td>"
				+ "<td><input name='C_CONTACT_NAME" + seqNum + "' id='C_CONTACT_NAME" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' notnull='请输入联系人姓名'/></td>"
				+ "<td><input name='C_CONTACT_POSITION" + seqNum + "' id='C_CONTACT_POSITION" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text'/></td>"
				+ "<td><input name='C_CONTACT_TEL" + seqNum + "' id='C_CONTACT_TEL" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text' /></td>"
				+ "<td><input name='C_CONTACT_EMAIL" + seqNum + "' id='C_CONTACT_EMAIL" + seqNum + "' class='inputText' style='width: 93%' onkeyup='_check_one(this);' type='text'/></td>"
				+"<td></td>");
			$("#info").append(newTr);
	}

	//动态删除联系人信息
	function _deleteRow() {
		var num = 0;
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				num += 1;
			}
		}
		$(':checkbox[name=xuanze]').each(function(){
			if($(this).attr('checked')){
				$(this).closest('tr').remove();
			}
		}); 
	}
	//提交联系人信息
	function _submitContact(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.linkFrom, false)) {
				return;
			}
			var i=0;
			for(i=1;i<seqNum;i++){
				//判断联系人信息是否为空
				var infoNum = document.getElementsByName("C_CONTACT_NAME"+i);
				if (infoNum.length < 1){
					alert("必须输入至少一条文件信息！");
					return;
				}
			}
			//表单提交
			var obj = document.forms["linkFrom"];
			var gov_id = document.getElementById("C_GOV_ID").value;
			var country_code = document.getElementById("COUNTRY_CODE").value;
			obj.action=path+'mkr/MAINCountry/addContact.action?rowNum=' + seqNum+"&COUNTRY_CODE="+country_code+"&GOV_ID="+gov_id;
			obj.submit();
		}
	}

	//删除联系人信息
	function _delContact(ID){
		var gov_id = document.getElementById("C_GOV_ID").value;
		var country_code = document.getElementById("COUNTRY_CODE").value;
		document.linkFrom.action=path+"mkr/MAINCountry/delContact.action?ID="+ID+"&COUNTRY_CODE="+country_code+"&GOV_ID="+gov_id;
		document.linkFrom.submit();
	}
</script>
<BZ:body property="govementData" codeNames="ZFBMXZ;">
	<BZ:form name="srcForm">
			<div class="bz-edit clearfix" style="margin: 0;padding:0;width: 100%" desc="编辑区域">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>政府部门信息</div>
					</div>
					<div class="bz-edit-data-content clearfix" desc="内容体">
						<!-- 编辑区域 开始 -->
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="15%">政府名称(CN)</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input field="NAME_CN" prefix="G_" notnull="请输入政府名称(CN)" id="G_NAME_CN" defaultValue="" style="width:70%;" />
									<input type="hidden" id="COUNTRY_CODE" name="COUNTRY_CODE" value="<%=COUNTRY_CODE %>" /></td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">政府名称(EN)</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input field="NAME_EN" prefix="G_" id="G_NAME_EN" notnull="请输入政府名称(EN)" defaultValue="" style="width:70%;" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">政府性质</td>
								<td class="bz-edit-data-value" width="30%">
									<BZ:select field="NATURE" formTitle="" prefix="G_" isCode="true" codeName="ZFBMXZ">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title" width="15%">政府职能</td>
								<td class="bz-edit-data-value" colspan="3">
									<!-- 
									<BZ:checkbox field="GOVER_FUNCTIONS0" prefix="G_" value="0" formTitle="">沟通协调</BZ:checkbox>
									<BZ:checkbox field="GOVER_FUNCTIONS1" prefix="G_" value="1" formTitle="">递交文件</BZ:checkbox>
								    <BZ:checkbox field="GOVER_FUNCTIONS2" prefix="G_" value="2" formTitle="">特需收养</BZ:checkbox>
									<BZ:checkbox field="GOVER_FUNCTIONS3" prefix="G_" value="3" formTitle="">签署征求意见书</BZ:checkbox>
									 -->
									 <%
										for(int i=0;i<goveList.size();i++){
											Data data =goveList.getData(i);
											String name = data.getString("NAME");
											String value = data.getString("VALUE");
											String a=String.valueOf(i);
											StringBuffer str = new StringBuffer();
											String num = str.append(a).toString();
											num = govData.getString("GOVER_FUNCTIONS"+i,"");
											if(""!=num){
									%>
												<input type="checkbox" name="G_GOVER_FUNCTIONS<%=a%>" value="<%=value%>" checked="checked"/> <%=name %>
									<% 
											}else{
									%>
												<input type="checkbox" name="G_GOVER_FUNCTIONS<%=a%>" value="<%=value%>"/> <%=name %>	
									<%								
											}
										}
									%>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">负责人姓名</td>
								<td class="bz-edit-data-value">
									<BZ:input field="HEAD_NAME" prefix="G_" id="G_HEAD_NAME" notnull="请输入负责人姓名" defaultValue="" />
								</td>
								<td class="bz-edit-data-title" width="15%">负责人电话</td>
								<td class="bz-edit-data-value">
									<BZ:input field="HEAD_PHONE" id="G_HEAD_PHONE" prefix="G_" defaultValue="" restriction="mobile" />
								</td>
								<td class="bz-edit-data-title" width="15%">负责人邮箱</td>
								<td class="bz-edit-data-value">
									<BZ:input field="HEAD_EMAIL" id="G_HEAD_EMAIL" prefix="G_" defaultValue="" restriction="email" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">网址</td>
								<td class="bz-edit-data-value" colspan="5">
									<BZ:input field="WEBSITE" prefix="G_" id="G_WEBSITE" defaultValue="" style="width:70%" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">地址</td>
								<td class="bz-edit-data-value" width="30%" colspan="5">
									<BZ:input field="ADDRESS" prefix="G_" id="G_ADDRESS" defaultValue="" style="width:70%" />
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title" width="15%">登记日期</td>
								<td class="bz-edit-data-value">
									<BZ:input field="REG_DATE" prefix="G_" type="Date" notnull="请输入登记日期" id="G_REG_DATE" defaultValue="" />
								</td>
								<td class="bz-edit-data-title" width="15%">最后修改日期</td>
								<td class="bz-edit-data-value">
									<BZ:dataValue field="MOD_DATE" type="Date" onlyValue="true" defaultValue=""/>
								</td>
								<td class="bz-edit-data-title" width="15%">排序号</td>
								<td class="bz-edit-data-value">
									<BZ:input field="SEQ_NO" id="G_SEQ_NO" prefix="G_" defaultValue="" />
									<BZ:input type="hidden" field="GOV_ID" id="G_GOV_ID" prefix="G_" defaultValue="" />
								</td>
							</tr>
						</table>
						<!-- 编辑区域 结束 -->
						<!-- 按钮区 开始 -->
						<div class="bz-action-frame">
							<div class="bz-action-edit" desc="按钮区">
								<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();" />
							</div>
						</div>
						<!-- 按钮区 结束 -->
					</div>
				</div>
			</div>
	</BZ:form>	
	<BZ:form name="linkFrom">	
			<!-- 联系人信息begin -->
			<div class="bz-edit clearfix" style="margin: 0;padding:0; width:100%;" desc="编辑区域">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>政府部门信息</div>
					</div>
					<!-- 功能按钮操作区Start -->
					<div class="table-row table-btns" style="text-align: left">
						<input type="button" value="新&nbsp;&nbsp;增" class="btn btn-sm btn-primary" onclick="add()" />
						<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_deleteRow()" />
					</div>
					<div class="blue-hr"></div>
					<!-- 功能按钮操作区End -->
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="info">
							<thead>
								<tr>
									<!-- 						
									<th class="center" style="width: 3%;"></th>
									 -->
									<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_NAME">联系人姓名</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_POSITION">联系人职位</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_TEL">联系人电话</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_EMAIL">联系人邮箱</div>
									</th>
									<th style="width: 10%;">
									<div class="sorting" id="CONTACT_EMAIL">操作</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="contactList">
									<tr class="emptyData">
										<!-- 
											<td class="center">
												<input name="xuanze" type="checkbox" value="<BZ:data field="GOV_ID" defaultValue="" onlyValue="true"/>" class="ace">
											</td>
										 -->
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="CONTACT_NAME" defaultValue=""
											onlyValue="true" /></td>
										<td><BZ:data field="CONTACT_POSITION" defaultValue=""
											onlyValue="true" /></td>
										<td><BZ:data field="CONTACT_TEL" defaultValue=""
											onlyValue="true" /></td>
										<td><BZ:data field="CONTACT_EMAIL" defaultValue=""
											onlyValue="true" /></td>
										<td>
											<input type="button" value="删除" class="btn btn-sm btn-primary" onclick="_delContact('<BZ:data field="ID" onlyValue="true"/>')"/>
										</td>
									</tr>
								</BZ:for>
								<input type="hidden" name="C_GOV_ID" id="C_GOV_ID" value="<%=GOV_ID %>" />
							</tbody>
						</table>
					</div>
					<!-- 按钮区 开始 -->
					<div class="bz-action-frame">
						<div class="bz-action-edit" desc="按钮区">
							<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_submitContact();" />
						</div>
					</div>
				<!-- 按钮区 结束 -->
				</div>
			</div>
			<!--联系人信息 end -->
	</BZ:form>
</BZ:body>
</BZ:html>
