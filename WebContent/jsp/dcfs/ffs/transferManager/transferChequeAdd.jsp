<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.ffs.transferManager.TransferConstant"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
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
	DataList dataList = (DataList)request.getAttribute("Transfer_Detail_DataList");
	int li=dataList.size();
    Data tdata =(Data)request.getAttribute("Edit_Transfer_data");
    String flag = "1";
    if(tdata == null){
        flag = "0";
    }else{
	    if(tdata.isEmpty()){
	        flag = "0";
    	}
    }
    String tI_ID =tdata.getString("TI_ID","");
    String cONNECT_NO=tdata.getString("CONNECT_NO","");
    
    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
	String TRANSFER_CODE = (String)request.getAttribute("TRANSFER_CODE");
	String mannualDeluuid = (String)request.getAttribute("mannualDeluuid");
	if("null".equals(mannualDeluuid) || mannualDeluuid == null){
	    mannualDeluuid = "";
	}
	
	TokenProcessor processor=TokenProcessor.getInstance();
	String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>添加</title>
	<BZ:webScript list="true" edit="true" tree="false" />
</BZ:head>
<script>
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	//});

	function _submit() {
		var arrays = document.getElementsByName("abc");
		if(arrays.length<1){
			page.alert('请选择要交接的文件！');
			return;
		}else if (confirm("是否提交交接单？")){
			var num = 0;
			var chioceuuid = [];
			for(var i=0; i<arrays.length; i++){
				chioceuuid[num] = arrays[i].value;
				num += 1;
			}
			var uuid = chioceuuid.join("#");
			document.getElementById("chioceuuid").value=uuid;
			document.srcForm.action = path + "transferManager/submit.action";
			document.srcForm.submit();
		}
	}

	function _goback() {
		document.srcForm.action = path + "transferManager/findList.action";
		document.srcForm.submit();
	}
	function _save() {
		var arrays = document.getElementsByName("abc");
		if(arrays.length<1){
			page.alert('请选择要交接的文件！');
			return;
		}else if(confirm("是否保存交接单？")){
			var num = 0;
			var chioceuuid = [];
			for(var i=0; i<arrays.length; i++){
				chioceuuid[num] = arrays[i].value;
				num += 1;
			}
			var uuid = chioceuuid.join("#");
			document.getElementById("chioceuuid").value = uuid;
			document.srcForm.action = path + "transferManager/save.action";
			document.srcForm.submit();
		}
	}
	
	function _fileSelect() {
		var TRANSFER_CODE = document.getElementById("TRANSFER_CODE").value;
		var mannualDeluuid = document.getElementById("mannualDeluuid").value;
		mannualDeluuid = encodeURIComponent(mannualDeluuid);
		window.open(path + "transferManager/MannualCheque.action?mannualDeluuid="+mannualDeluuid+"&TRANSFER_CODE="+TRANSFER_CODE,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
	}
	
	function refreshLocalList(uuid){
		var mannualDeluuid = document.getElementById("mannualDeluuid").value;
		if(mannualDeluuid != ""){
			uuid = uuid + "#" + mannualDeluuid;
		}
		document.getElementById("chioceuuid").value = uuid;
		document.srcForm.action=path+"transferManager/editCheque.action?type=refresh";
	 	document.srcForm.submit();
	}
	function _remove(){
		var num = 0;
		var chioceuuid = [];
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				chioceuuid[num] = arrays[i].value;
				num += 1;
			}
		}
	
		if(num < 1){
			page.alert('请选择要从交接单中移除的票据！');
			return;
		}else{
			if (confirm("确定移除这些票据？")){
				var uuid = chioceuuid.join("#");
				document.getElementById("chioceuuid").value=uuid;
				document.srcForm.action = path + "transferManager/removeCheque.action";
				document.srcForm.submit();
			}
		}
	}
</script>

<BZ:body property="Edit_Transfer_data" codeNames="WJLX;GJSY;JFFS">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin  property="transfer_data"-->
		<input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
		<input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
		<input type="hidden" name="TI_ID" id="TI_ID" value="<%=tI_ID%>"/>
		<input type="hidden" name="CONNECT_NO" id="CONNECT_NO" value="<%=cONNECT_NO%>"/>
		<input type="hidden" name="COPIES" id="COPIES" value='<%=li%>'/>
		<input type="hidden" name="OPER_TYPE" id="OPER_TYPE" value="<%=TransferConstant.OPER_TYPE_SEND %>"/>
		<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE %>"/>
		<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE %>"/>
		<!-- 隐藏区域end TRANSFER_TYPE-->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<!-- 功能按钮操作区Start -->
					<div class="table-row table-btns" style="text-align: left">
						<input type="button" value="添&nbsp;&nbsp;&nbsp;&nbsp;加" class="btn btn-sm btn-primary" onclick="_fileSelect() " />&nbsp; 
						<input type="button" value="移&nbsp;&nbsp;&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_remove() " />
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
									<th style="width:15%;">
										<div class="sorting" id="PAID_NO">缴费编号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="COUNTRY_CODE">国家</div>
									</th>
									<th style="width:25%;">
										<div class="sorting" id="NAME_CN">收养组织</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="PAID_WAY">缴费方式</div>
									</th>
									<th style="width:20%;">
										<div class="sorting" id="BILL_NO">票号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="PAR_VALUE">票面金额</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Transfer_Detail_DataList">
									<tr class="emptyData">
										<td class="center"><input name="abc" type="checkbox" value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace"></td>
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"/></td>
										<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PAID_WAY" defaultValue="" onlyValue="true" codeName="JFFS"/></td>
										<td><BZ:data field="BILL_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true" /></td>
									</tr>
								</BZ:for>
							</tbody>
						</table>
					</div>
					<!--查询结果列表区End -->
					<%if("1".equals(flag)){ %>
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>交接单信息</div>
					</div>
					<!--交接单基本信息区-->
						<table class="bz-edit-data-table" border="0">
					 		<tr>
								<td class="bz-edit-data-title" width="10%">交接单编号</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">票据份数</td>
								<td class="bz-edit-data-value" width="15%"><%=li %></td> 
					 		</tr>
					 		<tr>
								<td class="bz-edit-data-title" width="10%">接收人</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="RECEIVER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">接收日期</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="RECEIVER_DATE" onlyValue="true"/></td>
							</tr>
							<tr> 
								<td class=bz-edit-data-title width="10%">移交人</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="TRANSFER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">移交日期</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="TRANSFER_DATE" onlyValue="true"/></td> 
					 		</tr>
					 	</table>
					<!--交接单基本信息区End-->
					<%}else{ %>
					<table class="bz-edit-data-table" border="0">
					<tr>
					<td class="bz-edit-data-title" width="10%">票据份数</td>
					<td class="bz-edit-data-value" width="90%"><%=li %></td>
					</tr>
					</table>
					<%} %>
				</div>
			</div>
		</div>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="保存" class="btn btn-sm btn-primary"
					onclick="_save()" />
				<input type="button" value="提交" class="btn btn-sm btn-primary"
					onclick="_submit()" /> 
				<input type="button" value="返回"
					class="btn btn-sm btn-primary" onclick="_goback();" />
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>