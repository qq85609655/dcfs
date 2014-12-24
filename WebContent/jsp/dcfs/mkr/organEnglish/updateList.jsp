<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head>
		<title>更新纪录</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="<%=path %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['iframe','mainFrame']);
		});
	</script>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" action="mkr/organSupp/organUpdateListEn.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<input type="hidden" name="ID" value="<%=data.getString("CUI_ID") %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号English</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="IP_ADDR">行为者IP</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="OPERATOR">更新人</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="CNAME">收养组织</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPERATE_TIME">更新时间</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPERATE_RESULT">操作结果</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dataList">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="IP_ADDR"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPERATOR" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPERATE_TIME" type="date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPERATE_RESULT" defaultValue="" checkValue="0=更新失败;1=更新成功;"  onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="dataList" /></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>