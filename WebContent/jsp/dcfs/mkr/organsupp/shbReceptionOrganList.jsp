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
	String receptionId = "";
	if(data != null){		
		receptionId = data.getString("ID");
	}
%>
<BZ:html>
	<BZ:head>
		<title>�ڻ����нӴ���Ϣ(Tour reception in China)</title>
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
		//����ڻ����нӴ���Ϣ
		function _create(){
			document.getElementById("receptionDiv").style.display='block';
			var id = "<%=id%>";
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/receptionModify.action?ID="+id+"&type=shb";
		}

		//�޸��ڻ����нӴ���Ϣ
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

		//ɾ���ڻ����нӴ���Ϣ
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
				if(confirm("ȷ��Ҫɾ��ѡ����Ϣ��? ")){
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
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="ID" value="<%=id %>"/>
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_create()"/>&nbsp;
					<input type="button" value="ɾ��" class="btn btn-sm btn-primary" onclick="_delete()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
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
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="RECEIVE_TYPE">�Ӵ�������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="HEADER_TYPE">���������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ID_NUMBER">���֤����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WORK_UNIT">������λ</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="TELEPHONE">�绰����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="MOBEL">�ֻ�����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FAX">����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="EMAIL">����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ADDR">��ַ</div>
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
		<div id="receptionDiv" style="width:100%; margin: 0 auto;display: none">
		 <iframe id="iframeC" scrolling="no" src="" style="border:none; width:100%; height:900px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>