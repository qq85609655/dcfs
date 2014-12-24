<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	/**   
	 * @Description:描述
	 * @author xxx   
	 * @date 2014-7-29 10:44:22
	 * @version V1.0   
	 */
	/******Java代码功能区域Start******/
	//获取数据对象列表
	DataList dataList = (DataList)session.getAttribute("Transfer_Detail_DataList");
    int li=dataList.size();
	
%>
<BZ:html>
<BZ:head>
	<title>修改</title>
	<BZ:webScript list="true" edit="true" tree="false" />
</BZ:head>
<script>
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	//});

	function _submit() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "transferinfo/save.action";
			document.srcForm.submit();
		}
	}
	function _save() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "transferinfo/save.action";
			document.srcForm.submit();
		}
	}

	function _goback() {
		document.srcForm.action = path + "transferinfo/findList.action?TRANSFER_CODE=11&OPER_TYPE=1";
		document.srcForm.submit();
	}
	function _fileSelect() {
		window.open(path + "transferManager/MannualFile.action","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
	}
	
	function refreshLocalList(){
		window.location.href = path+"transferManager/add.action";
	}
	function _remove(){
		var num = 0;
		var chioceuuid = [];
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num++] = arrays[i].value;
			num += 1;
		}
		}
	
		if(num < 1){
				page.alert('请选择要从交接单中移除的文件！');
				return;
			}else{
				if (confirm("确定移除这些文件？")){
					var uuid = chioceuuid.join("#");
					document.getElementById("chioceuuid").value=uuid;
					document.srcForm.action = path + "transferManager/remove.action";
					document.srcForm.submit();
				}
			}
	}
</script>

<BZ:body codeNames="WJLX;GJSY;SYZZ" property="transfer_data">
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin  property="transfer_data"-->
		<input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
		<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value='<BZ:dataValue field="TRANSFER_TYPE" onlyValue="true"/>'/>
		<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_TYPE" value='<BZ:dataValue field="TRANSFER_CODE" onlyValue="true"/>'/>
		<input type="hidden" name="COPIES" id="COPIES" value='<%=li%>>'/>
		<input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
		<!-- 隐藏区域end TRANSFER_TYPE-->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>交接单详细</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<!-- 功能按钮操作区Start -->
					<div class="table-row table-btns" style="text-align: left">
						<input type="button" value="手工添加"
							class="btn btn-sm btn-primary" onclick="_fileSelect() " />&nbsp; 
							<input
							type="button" value="扫描添加"
							class="btn btn-sm btn-primary" onclick="_fileSelect() " />
							&nbsp; 
							<input
							type="button" value="移&nbsp;&nbsp;&nbsp;&nbsp;除"
							class="btn btn-sm btn-primary" onclick="_remove() " />
					</div>
					<div class="blue-hr"></div>
					<!-- 功能按钮操作区End -->
					<!--查询结果列表区Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							adsorb="both" init="true" id="table2" name="table2">
							<thead>
								<tr>
									<th class="center" style="width:5%;">
										<div class="sorting_disabled">
											<input name="abcd" type="checkbox" class="ace">
										</div>
									</th>
									<th style="width:5%;">
										<div class="sorting_disabled">序号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="COUNTRY_CN">国家</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="NAME_CN">收养组织</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="REGISTER_DATE">收文日期</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FILE_NO">文件编号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FILE_TYPE">文件类型</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="MALE_NAME">男收养人</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FEMALE_NAME">女收养人</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Transfer_Detail_DataList">
									<tr class="emptyData">
										<td class="center"><input name="abc" type="checkbox"
											value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace">
										</td>
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="COUNTRY_CN"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data type="date" field="REGISTER_DATE"
												dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
										</td>
										<td><BZ:data field="FILE_NO" defaultValue=""
												onlyValue="true" /></td>
										<td><BZ:data field="FILE_TYPE" codeName="WJLX"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="MALE_NAME" defaultValue=""
												onlyValue="true" /></td>
										<td><BZ:data field="FEMALE_NAME" defaultValue=""
												onlyValue="true" /></td>
									</tr>
								</BZ:for>
							</tbody>
						</table>
					</div>
					<!--查询结果列表区End -->
				</div>
			</div>
		</div>



		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="提交" class="btn btn-sm btn-primary"
					onclick="_submit()" /> <input type="button" value="返回"
					class="btn btn-sm btn-primary" onclick="_goback();" />
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>