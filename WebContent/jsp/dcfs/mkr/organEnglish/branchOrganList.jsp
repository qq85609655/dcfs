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
	String id = (String)request.getAttribute("ADOPT_ORG_ID");
%>
<BZ:html>
	<BZ:head>
		<title>��֧����</title>
		<BZ:webScript list="true" edit="true"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['iframe','mainFrame']);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','180px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/SuppleQueryList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
		}
		
		function _modifyBranch(n){
			if(n.checked){
				document.getElementById("iframeWin").style.display = "block";
				document.getElementById("iframeC").src = "<%=path %>/mkr/orgexpmgr/branchModifyEn.action?ADOPT_ORG_ID=<%=id %>&ID="+n.value;
			}
		}
		
		function _create(){
			document.getElementById("iframeWin").style.display = "block";
			document.getElementById("iframeC").src = "<%=path %>/mkr/orgexpmgr/branchModifyEn.action?ADOPT_ORG_ID=<%=id %>";
		}
		
		function _delete(){
			var id = "";
			for(var i=0;i<document.getElementsByName('xuanze').length;i++){
				if(document.getElementsByName('xuanze')[i].checked){
					id=document.getElementsByName('xuanze')[i].value;
					break;
				}
			}
			if(id != ""){
				if(confirm("ȷ��ɾ����")){
					document.srcForm.action = path+"mkr/orgexpmgr/deleteBranchEn.action?ADOPT_ORG_ID=<%=id %>&ID="+id;
					document.srcForm.submit();
					document.srcForm.action = path+"mkr/orgexpmgr/branchOrganListEn.action";
				}
			}else{
				alert("��ѡ����Ҫɾ�������ݣ�");				
			}
		}
	</script>
	<BZ:body>
		<BZ:form name="srcForm" method="post" action="mkr/orgexpmgr/branchOrganListEn.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="ADOPT_ORG_ID" value="<%=id %>"/>
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_create()"/>&nbsp;
					<!-- <input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_modify()"/>&nbsp; -->
					<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_delete()"/>
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
								<th style="width: 7%;">
									<div class="sorting_disabled">���English</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="AREA">���ڵ���</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="HEADER">������</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="TELEPHONE">�绰</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="EMAIL">����</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FAX">����</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="ADDR">��ַ</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dataList">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" onclick="_modifyBranch(this);" value="<BZ:data field="ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center">
									<BZ:data field="AREA" defaultValue="" onlyValue="true"/>
								</td>
								<td class="center"><BZ:data field="HEADER" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TELEPHONE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="EMAIL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FAX" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="dataList"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		<div id="iframeWin" style="width:100%; margin: 0 auto;display: none;">
		 <iframe id="iframeC" scrolling="no" src="<%=path %>/mkr/orgexpmgr/branchModifyEn.action?ADOPT_ORG_ID=<%=id %>" style="border:none; width:100%; height:400px; overflow:hidden; frameborder="0"></iframe>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>