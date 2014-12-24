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
	//收养组织ID
	String id = (String)request.getAttribute("ID");
	
	Data data = (Data)request.getAttribute("data");
	String aidProjectId = "";
	if(data != null){		
		aidProjectId = data.getString("ID");
	}
%>
<BZ:html>
	<BZ:head language="EN">
		<title>援助和捐助项目信息(Sponsorship program information)</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="<%=path %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['iframe','mainFrame']);
			var aidProjectId = "<%=aidProjectId%>";
			var id = "<%=id%>";
			if(aidProjectId != "" && aidProjectId != "null"){
				iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/aidProjectModify.action?aidProjectId="+aidProjectId+"&ID="+id;
			}
		});
		//添加援助或捐赠项目信息
		function _create(){
			document.getElementById("aidProjectDiv").style.display='block';
			var id = "<%=id%>";
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/aidProjectModify.action?ID="+id;
		}

		//修改援助或捐赠项目信息
		function showAidProject(){
			document.getElementById("aidProjectDiv").style.display='block';
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
				}
			}
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/aidProjectModify.action?aidProjectId="+id;
		}

		//删除援助或捐赠项目信息
		function _delete(){
			var num = 0;
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				if(confirm("Are you sure you want to delete? ")){
					document.srcForm.action = path+"mkr/organSupp/deleteAidProject.action?aidProjectId="+id;
					document.srcForm.submit();
				}else{
					return;
				}
			}
			document.location= "<%=request.getContextPath() %>/mkr/organSupp/aidProjectOrganList.action?ID=<%=id%>";
		}
	</script>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" action="mkr/organSupp/aidProjectOrganList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="ID" value="<%=id %>"/>
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Add" class="btn btn-sm btn-primary" onclick="_create()"/>&nbsp;
					<input type="button" value="Delete" class="btn btn-sm btn-primary" onclick="_delete()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 5%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号<br>(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ITEM_NAME">项目名称<br>(Program)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ITEM_HEADER">项目负责人<br>(Program manager)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="COLLABORATION_NAME">合作方名称<br>(Program partner)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PROFITOR">受益对象<br>(Beneficiary)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BEGIN_TIME">开始时间<br>(Date of start)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="END_TIME">结束时间<br>(Date of completion)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="INVESTED_FUNDS"><br>投入金额(Investment amount)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="TELEPHONE">电话<br>(Telephone)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="EMAIL">邮箱<br>(Email)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADDR">项目所在地<br>(Program location)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dataList">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" onclick="showAidProject()" type="radio" value="<BZ:data field="ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ITEM_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ITEM_HEADER"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COLLABORATION_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROFITOR" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="BEGIN_TIME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="END_TIME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="INVESTED_FUNDS" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TELEPHONE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="EMAIL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ADDR" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="dataList" type="EN"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		<div id="aidProjectDiv" style="width:100%; margin: 0 auto;display: none">
		 <iframe id="iframeC" scrolling="no" src="" style="border:none; width:100%; height:900px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>