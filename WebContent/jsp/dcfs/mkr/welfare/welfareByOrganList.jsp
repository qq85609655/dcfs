<%
/**   
 * @Title: recordStateOrganList.jsp
 * @Description:���������б�
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 // ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	String ID = (String)request.getAttribute("ID");  //ʡ��ID
%>

<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%><BZ:html>
	<BZ:head>
		<title>���������б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['welfare','mainFrame']);
		});
		
		//�������
		function record_confirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
			   document.srcForm.action=path+"mkr/organSupp/organRecordConfirm.action?ID="+ids;
			   document.srcForm.submit();
			}
		}
		//��ת���޸�ҳ��
		function _modif(){
			var id="";
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('��ѡ��һ������ ');
				return;
			}else{
				document.srcForm.action=path+"mkr/organSupp/provinceListMessage.action?ID="+id+"&pro_code=<%=ID%>&type=modif";
			    document.srcForm.submit();
			}
			    document.srcForm.action=path+"mkr/organSupp/findWelfareByOrgan.action";
		}
		//��ת���鿴ҳ��
		function _detail(){
			var id="";
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('��ѡ��һ������ ');
				return;
			}else{
				document.srcForm.action=path+"mkr/organSupp/toWelfareModif.action?ID="+id+"&pro_code=<%=ID%>&type=detail";
			    document.srcForm.submit();
			}
			    document.srcForm.action=path+"mkr/organSupp/findWelfareByOrgan.action";
		}
		//ɾ������������Ϣ
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
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				if(confirm('ȷ��Ҫɾ����')){
					document.srcForm.action=path+"mkr/organSupp/toWelfareDel.action?INSTER_ID="+id+"&pro_code=<%=ID%>";
				    document.srcForm.submit();
				}
			}
		}
		function a(){
			 window.location.href=path+"jsp/dcfs/mkr/welfare/provinceAndWelfare.jsp";
		}
	</script>
	<BZ:body codeNames="PROVINCE;">
		<BZ:form name="srcForm"  method="post" action="mkr/organSupp/findWelfareByOrgan.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="ID"  value='<%=ID %>'/>
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_modif()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<!-- <input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp; -->
					<input type="button" value="ʡ�ݸ���������������" class="btn btn-sm btn-primary" onclick="a()"/>&nbsp;
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
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="CNAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PRINCIPAL">����</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="DEPT_ADDRESS_CN">��ַ</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="DEPT_TEL">�绰</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="DEPT_FAX">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="STATE">״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<BZ:for property="dataList">
								<tr class="emptyData">
									<td class="center">
										<input name="xuanze" type="radio" value="<BZ:data field="ID" defaultValue="" onlyValue="true"/>" class="ace">
									</td>
									<td class="center">
										<BZ:i/>
									</td>
									<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
									<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="PRINCIPAL" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="DEPT_ADDRESS_CN" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="DEPT_TEL" defaultValue=""  onlyValue="true"/></td>
									<td><BZ:data field="DEPT_FAX" defaultValue=""  onlyValue="true"/></td>
									<td><BZ:data field="STATE" defaultValue="" checkValue="0=����;1=��Ч;9=��ͣ;"  onlyValue="true"/></td>
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
							<td>
								<BZ:page form="srcForm" property="dataList"/>
							</td>
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