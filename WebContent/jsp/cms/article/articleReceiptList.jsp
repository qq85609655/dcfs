<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	 //1 ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
%>
<BZ:html>
	<BZ:head>
		<title>֪ͨ�����б�</title>
		<BZ:webScript list="true" isAjax="true"/>
	</BZ:head>
	<script>
	$(document).ready(function(){
		dyniframesize([ 'mainFrame' ]);
	});
	
	function _detail(ID){
		document.srcForm.action = path+"article/receiptAdd.action?ID="+ID;
		document.srcForm.submit();
	}
	</script>
	<BZ:body>
		<BZ:form name="srcForm" method="post" action="article/receiptList.action">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="page-content">
			<div class="wrapper">
				<div class="table-header">
					<h4 class="lighter">֪ͨ�����б�</h4>
					<div class="widget-toolbar">
						<div class="icon-chevron-up"></div>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 7%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 63%;">
									<div id="TITLE" class="sorting">����</div>
								</th>
								<th style="width: 20%;">
									<div id="CREATE_TIME" class="sorting">����ʱ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">����</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<BZ:for property="dl" fordata="mydata">
								<tr class="emptyData">
									<td class="center"><BZ:i /></td>
									<td>
										<%
										String IS_TOP = ((Data) pageContext.getAttribute("mydata")).getString("IS_TOP");
										if("1".equals(IS_TOP)){
										%>
										<img alt="�ö�" src="<%=path %>/jsp/cms/images/top.gif"/>
										<%
										}
										Date createTime = new SimpleDateFormat("yyyy-MM-dd").parse(((Data) pageContext.getAttribute("mydata")).getString("CREATE_TIME"));
										//����ʱ��
										Integer days = ((Data) pageContext.getAttribute("mydata")).getInt("NEW_TIME");
										Calendar createTime_ = Calendar.getInstance();
										createTime_.setTime(createTime);
										createTime_.add(Calendar.DAY_OF_MONTH,days);
										Calendar date = Calendar.getInstance();
										String IS_NEW = ((Data) pageContext.getAttribute("mydata")).getString("IS_NEW");
										if("1".equals(IS_NEW) && createTime_.compareTo(date) > 0){
										%>
										<img alt="����" src="<%=path %>/jsp/cms/images/new.gif"/>
										<%} %>
										<BZ:data field="TITLE" defaultValue="" />
									</td>
									<td><BZ:data field="CREATE_TIME" defaultValue="" type="date"/></td>
									<td style="text-align: center;">
										<a style="cursor: pointer;text-decoration: underline;" onclick="_detail('<BZ:data field="ID" defaultValue="" onlyValue="true"/>')">�鿴</a>
									</td>
								</tr>
							</BZ:for>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>