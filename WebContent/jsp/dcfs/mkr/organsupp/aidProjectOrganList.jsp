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
	//������֯ID
	String id = (String)request.getAttribute("ID");
	
	Data data = (Data)request.getAttribute("data");
	String aidProjectId = "";
	if(data != null){		
		aidProjectId = data.getString("ID");
	}
%>
<BZ:html>
	<BZ:head language="EN">
		<title>Ԯ���;�����Ŀ��Ϣ(Sponsorship program information)</title>
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
		//���Ԯ���������Ŀ��Ϣ
		function _create(){
			document.getElementById("aidProjectDiv").style.display='block';
			var id = "<%=id%>";
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/aidProjectModify.action?ID="+id;
		}

		//�޸�Ԯ���������Ŀ��Ϣ
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

		//ɾ��Ԯ���������Ŀ��Ϣ
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
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="ID" value="<%=id %>"/>
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Add" class="btn btn-sm btn-primary" onclick="_create()"/>&nbsp;
					<input type="button" value="Delete" class="btn btn-sm btn-primary" onclick="_delete()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
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
									<div class="sorting_disabled">���<br>(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ITEM_NAME">��Ŀ����<br>(Program)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ITEM_HEADER">��Ŀ������<br>(Program manager)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="COLLABORATION_NAME">����������<br>(Program partner)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PROFITOR">�������<br>(Beneficiary)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BEGIN_TIME">��ʼʱ��<br>(Date of start)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="END_TIME">����ʱ��<br>(Date of completion)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="INVESTED_FUNDS"><br>Ͷ����(Investment amount)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="TELEPHONE">�绰<br>(Telephone)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="EMAIL">����<br>(Email)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADDR">��Ŀ���ڵ�<br>(Program location)</div>
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
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="dataList" type="EN"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		<div id="aidProjectDiv" style="width:100%; margin: 0 auto;display: none">
		 <iframe id="iframeC" scrolling="no" src="" style="border:none; width:100%; height:900px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>