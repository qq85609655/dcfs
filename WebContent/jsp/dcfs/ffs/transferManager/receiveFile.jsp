<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
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
	DataList dataList = (DataList)request.getAttribute("Receive_datalist");
    int li=0;
    li=dataList.size();
    int tx=0;
    int zc=0;
    for(int i=0;i<li;i++){ 	
    	if("2".equals(dataList.getData(i).getString("FILE_TYPE").substring(0, 1))){
    	tx++;
    	}else{
    	zc++;
    	}
    }
    
    String code = (String)request.getAttribute("TRANSFER_CODE");
    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
    String sbcode = code.substring(0,1);
    boolean tw_flag = false ;
    if(sbcode!=null&&"5".equals(sbcode)){
  	  tw_flag = true;
    }
    
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>添加</title>
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

<BZ:body property="Receive_data" codeNames="WJLX;GJSY;TWLX;SYZZ;TWCZFS_ALL">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=code%>"/>
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
									<th style="width:1%;" nowrap>
										<div class="sorting_disabled">序号</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="COUNTRY_CN">国家</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="NAME_CN">收养组织</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="REGISTER_DATE">收文日期</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="FILE_NO">文件编号</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="FILE_TYPE">文件类型</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="MALE_NAME">男收养人</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="FEMALE_NAME">女收养人</div>
									</th>
									<%if(tw_flag){ %>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="APPLE_TYPE">退文类型</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="RETURN_REASON">退文原因</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="HANDLE_TYPE">处置方式</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="RETREAT_DATE">确认日期</div>
									</th>
									<%} %>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Receive_datalist">
									<tr class="emptyData">
									
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
										<%if(tw_flag){ %>
										<td><BZ:data field="APPLE_TYPE"  codeName="TWLX" defaultValue=""  onlyValue="true"/></td>
										<td><BZ:data field="RETURN_REASON" defaultValue=""  onlyValue="true"/></td>
										<td><BZ:data field="HANDLE_TYPE" codeName="TWCZFS_ALL" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="RETREAT_DATE" defaultValue="" type="Date" onlyValue="true" /></td>
										<%} %>
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
								<td class="bz-edit-data-title" width="10%">正常文件</td>
								<td class="bz-edit-data-value" width="10%"><%=zc %></td> 
								<td class="bz-edit-data-title" width="10%">特需文件</td>
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
						<input type="button" value="确&nbsp;&nbsp;认"
							class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp; 
						<input type="button" value="退&nbsp;&nbsp;回"
							class="btn btn-sm btn-primary" onclick="_showSearch()" />&nbsp; 
							<input
							type="button" value="返&nbsp;&nbsp;回"
							class="btn btn-sm btn-primary" onclick="_goback()" />
					</div>
					<div class="blue-hr"></div>
					<!-- 功能按钮操作区End -->
				</div>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>