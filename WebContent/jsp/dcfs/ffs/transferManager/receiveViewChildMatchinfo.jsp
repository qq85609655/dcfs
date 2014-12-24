<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	/**   
	 * @Description:查看儿童材料交接单信息
	 * @author wangzheng
	 * @date 2014-11-2
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
    	if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(dataList.getData(i).getString("CHILD_TYPE"))){//特需儿童
    		tx++;
    	}else if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(dataList.getData(i).getString("CHILD_TYPE"))){//正常儿童
    		zc++;
    	}
    }
    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
	String TRANSFER_CODE = (String)request.getAttribute("TRANSFER_CODE");
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
	function _goback() {
		document.srcForm.action = path + "transferManager/findReceiveList.action";
		document.srcForm.submit();
	}
</script>

<BZ:body property="Receive_data" codeNames="WJLX;PROVINCE;ETXB;CHILD_TYPE">
	<BZ:form name="srcForm" method="post">
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE %>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE %>"/>
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
									<th style="width:5%;">
										<div class="sorting_disabled">序号</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id=COUNTRY_CN>国家</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id=NAME_CN>收养组织</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id=FILE_NO>文件编号</div>
									</th>
									<th style="width:4%;">
										<div class="sorting" id=FILE_TYPE>文件类型</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="CHILD_NO">儿童编号</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="PROVINCE_ID">省份</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="NAME">姓名</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="SEX">性别</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="BIRTHDAY">出生日期</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="CHILD_TYPE">儿童类型</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Receive_datalist">
									<tr class="emptyData">									
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="COUNTRY_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data codeName="WJLX" field="FILE_TYPE" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data codeName="ETXB" field="SEX" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="BIRTHDAY" type="date" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
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