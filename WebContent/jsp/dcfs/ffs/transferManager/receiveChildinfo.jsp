<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	/**   
	 * @Description:儿童材料交接单接收
	 * @author wang
	 * @date 2014-11-26 10:44:22
	 * @version V1.0   
	 */
	/******Java代码功能区域Start******/
	//获取数据对象列表
	DataList dataList = (DataList)request.getAttribute("Receive_datalist");
    int li=0;
    li=dataList.size();
    int tx=0;
    int zc=0;
    for(int i=0;i<li;i++){ 	
    	if("2".equals(dataList.getData(i).getString("CHILD_TYPE").substring(0, 1))){
    	tx++;
    	}else{
    	zc++;
    	}
    }
    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
    String TRANSFER_CODE = (String)request.getAttribute("TRANSFER_CODE");
    
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>交接单接收</title>
	<BZ:webScript list="true" edit="true" tree="false" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	function _showSearch(){
		$.layer({
			type : 1,
			title : "退回原因",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['600px','165px'],
			offset: ['190px' , '160px'],
			closeBtn: [0, true]
		});
	}
	function _Return() {
		
		var TI_ID = document.getElementById("TI_ID").value;
		document.srcForm.action = path + "transferManager/receiveReturn.action?TI_ID="+TI_ID;
		document.srcForm.submit();
		
	}
	function _goback() {
		document.srcForm.action = path + "transferManager/findReceiveList.action";
		document.srcForm.submit();
	}
	function _submit(){
		var TI_ID = document.getElementById("TI_ID").value;
		document.srcForm.action = path + "transferManager/receiveConfirm.action?TI_ID="+TI_ID;
		document.srcForm.submit();
	}
</script>

<BZ:body property="Receive_data" codeNames="ETXB;PROVINCE;CHILD_TYPE">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
		<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	    <div class="page-content">
	    	<div class="page-content" id="searchDiv" style="display: none">
	    	<div class="wrapper">
	    		<!-- 查询条件区Start -->
				<div class="table-row">
					<table cellspacing="0" cellpadding="0">
						<tr>
							<td style="width: 100%;">
								<table>
									  <tr>
											<td style="width: 100%">
												<textarea id="REJECT_DESC" name="REJECT_DESC" rows="5" cols="80"></textarea>
											</td>
									  </tr>
								</table>
							</td>
						</tr>
						<tr style="height: 5px;"></tr>
						<tr>
							<td style="text-align: center;">
								<div class="bz-search-button">
									<input type="button" value="确&nbsp;&nbsp;认" onclick="_Return();" class="btn btn-sm btn-primary">
									
								</div>
							</td>
							<td class="bz-search-right"></td>
						</tr>
					</table>
				</div>
				<!-- 查询条件区End -->
	  		 </div>
	    </div>
		<!-- 隐藏区域begin  property="transfer_data"-->
		<input type="hidden" name="TI_ID" id="TI_ID" value='<BZ:dataValue field="TI_ID" onlyValue="true"/>'>
				
		<!-- 隐藏区域end TRANSFER_TYPE-->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>文件列表</div>
					</div>
					<!--查询结果列表区Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							adsorb="both" init="true" id="table2" name="table2">
							<thead>
								<tr>
									<th style="width:5%;">
										<div class="sorting_disabled">序号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="CHILD_NO">儿童编号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="PROVINCE_ID">省份</div>
									</th>
									<th style="width:20%;">
										<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="NAME">姓名</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="SEX">性别</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="BIRTHDAY">出生日期</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="CHILD_TYPE">材料类型</div>
									</th>								
									<th style="width:10%;">
										<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Receive_datalist">
									<tr class="emptyData">
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data type="date" field="BIRTHDAY" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
										</td>
										<td><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
									</tr>
								</BZ:for>
							</tbody>
						</table>
					</div>
					<!--交接单结果列表区End -->
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>交接单信息</div>
					</div>
					<!--交接单基本信息区-->
					
						<table class="bz-edit-data-table" border="0">
					 		<tr>
								<td class="bz-edit-data-title" width="10%">交接单编号</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">份数</td>
								<td class="bz-edit-data-value" width="15%"><%=li %></td> 
								<td class="bz-edit-data-title" width="10%">正常材料</td>
								<td class="bz-edit-data-value" width="10%"><%=zc %></td> 
								<td class="bz-edit-data-title" width="10%">特需材料</td>
								<td class="bz-edit-data-value" width="15%"><%=tx %></td> 
					 		</tr>
					 		<tr>
								<td class="bz-edit-data-title" width="10%">接收人</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="RECEIVER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">接收日期</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="RECEIVER_DATE" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">移交人</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="TRANSFER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">移交日期</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="TRANSFER_DATE" onlyValue="true"/></td> 
					 		</tr>
					 	</table>
					
					<!--交接单基本信息区End-->
					<!-- 功能按钮操作区Start -->
					<div class="table-row table-btns" style="text-align: center">
						<input type="button" value="确&nbsp;&nbsp;认" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp; 
						<input type="button" value="退&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_showSearch()" />&nbsp; 
						<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
					</div>
					<div class="blue-hr"></div>
					<!-- 功能按钮操作区End -->
				</div>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>