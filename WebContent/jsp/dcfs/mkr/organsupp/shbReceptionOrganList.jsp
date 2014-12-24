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
	String receptionId = "";
	if(data != null){		
		receptionId = data.getString("ID");
	}
%>
<BZ:html>
	<BZ:head>
		<title>在华旅行接待信息(Tour reception in China)</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="<%=path %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['iframe','mainFrame']);
			var receptionId = "<%=receptionId%>";
			var id = "<%=id%>";
			if(receptionId != "" && receptionId != "null"){
				iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/receptionModify.action?receptionId="+receptionId+"&ID="+id;
			}
		});
		//添加在华旅行接待信息
		function _create(){
			document.getElementById("receptionDiv").style.display='block';
			var id = "<%=id%>";
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/receptionModify.action?ID="+id+"&type=shb";
		}

		//修改在华旅行接待信息
		function showReception(){
			document.getElementById("receptionDiv").style.display='block';
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
				}
			}
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/receptionModify.action?receptionId="+id+"&type=shb";
		}

		//删除在华旅行接待信息
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
				page.alert('Tour reception in China ');
				return;
			}else{
				if(confirm("确认要删除选中信息吗? ")){
					document.srcForm.action = path+"mkr/organSupp/deleteReception.action?receptionId="+id;
					document.srcForm.submit();
				}else{
					return;
				}
			}
			document.location= "<%=request.getContextPath() %>/mkr/organSupp/receptionOrganList.action?ID=<%=id%>&type=shb";
		}
	</script>
	<BZ:body property="data" codeNames="JDFLX;FZRLB;">
		<BZ:form name="srcForm" method="post" action="mkr/organSupp/receptionOrganList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="ID" value="<%=id %>"/>
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="新增" class="btn btn-sm btn-primary" onclick="_create()"/>&nbsp;
					<input type="button" value="删除" class="btn btn-sm btn-primary" onclick="_delete()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="RECEIVE_TYPE">接待方类型</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="HEADER_TYPE">负责人类别</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ID_NUMBER">身份证号码</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WORK_UNIT">工作单位</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="TELEPHONE">电话号码</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="MOBEL">手机号码</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FAX">传真</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="EMAIL">邮箱</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ADDR">地址</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dataList">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" onclick="showReception()" type="radio" value="<BZ:data field="ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="RECEIVE_TYPE" codeName="JDFLX" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="HEADER_TYPE"  codeName="FZRLB" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ID_NUMBER" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WORK_UNIT" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TELEPHONE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MOBEL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FAX" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="dataList"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		<div id="receptionDiv" style="width:100%; margin: 0 auto;display: none">
		 <iframe id="iframeC" scrolling="no" src="" style="border:none; width:100%; height:900px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>