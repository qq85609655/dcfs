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
		<title>���¼�¼</title>
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
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<input type="hidden" name="ID" value="<%=data.getString("CUI_ID") %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">���English</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="IP_ADDR">��Ϊ��IP</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="OPERATOR">������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="CNAME">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPERATE_TIME">����ʱ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPERATE_RESULT">�������</div>
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
								<td><BZ:data field="OPERATE_RESULT" defaultValue="" checkValue="0=����ʧ��;1=���³ɹ�;"  onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="dataList" /></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>