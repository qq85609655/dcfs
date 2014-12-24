<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	/**   
	 * @Description:查看安置后反馈报告交接单信息
	 * @author xugaoyang
	 * @date 2014-11-18
	 * @version V1.0   
	 */
	/******Java代码功能区域Start******/
	//获取数据对象列表
	DataList dataList = (DataList)request.getAttribute("Receive_datalist");
    int li=0;
    li=dataList.size();
    
	String TRANSFER_CODE = (String)request.getAttribute("TRANSFER_CODE");
	String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
    
	
	TokenProcessor processor=TokenProcessor.getInstance();
	String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>交接单查看</title>
	<BZ:webScript list="true" edit="true" tree="false" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	function _goback() {
		document.srcForm.action = path + "transferManager/findReceiveList.action";
		document.srcForm.submit();
	}
</script>

<BZ:body property="Receive_data" codeNames="PROVINCE;ETXB;CHILD_TYPE">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<div class="ui-state-default bz-edit-title" desc="标题">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>材料列表</div>
					</div>
					<!--查询结果列表区Start -->
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="table2" name="table2">
							<thead>
								<tr>
									<th style="width:5%;">序号</th>
									<th style="width:6%;">国家</th>
									<th style="width:15%;">收养组织</th>
									<th style="width:11%;">档案号</th>
									<th style="width:11%;">男收养人</th>
									<th style="width:12%;">女收养人</th>
									<th style="width:8%;">儿童姓名</th>
									<th style="width:12%;">签批日期</th>
									<th style="width:12%;">报告接收日期</th>
									<th style="width:8%;">反馈次数</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Receive_datalist">
									<tr class="emptyData">									
										<td class="center"><BZ:i /></td>
										<td><BZ:data  field="COUNTRY_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="ARCHIVE_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="SIGN_DATE" defaultValue="" type="date" onlyValue="true"/></td>
										<td><BZ:data field="RECEIVE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
										<td><BZ:data field="NUM" defaultValue="" onlyValue="true"/></td>
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
								<td class="bz-edit-data-value" width="10%" colspan="3"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">份数</td>
								<td class="bz-edit-data-value" width="15%" colspan="3"><%=li %></td> 
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