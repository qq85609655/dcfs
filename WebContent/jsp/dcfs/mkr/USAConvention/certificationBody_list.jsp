<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="hx.util.DateUtility"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: certificationBody_list.jsp
	 * @Description:  
	 * @author    panfeng
	 * @date 2014-8-20 ����4:59:32 
	 * @version V1.0   
	 */
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
		<title>��֤�����б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
	
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
	
		//��������
		function _bodyAdd(){
			window.location.href=path+"mkr/USAConvention/toBodyAdd.action";
		}
		
		//�޸Ĳݸ塢����Ч�ļ�¼
		function _bodyUpdate(){
			var num = 0;
			var uuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state != "0" && state != "1"){
						page.alert("ֻ���޸Ĳݸ������Ч�ļ�¼��");
						return;
					}else{
						uuid = arrays[i].value.split("#")[0];
						num++;
					}
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�޸ĵļ�¼��");
				return;
			}else{
				document.srcForm.action=path+"mkr/USAConvention/showCerBody.action?uuid="+uuid;
				document.srcForm.submit();
			}
		}
		
		//����ɾ���ݸ��¼
		function _bodyDel(){
			var num = 0;
			var deleteuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "0"){
						deleteuuid[num++] = arrays[i].value.split("#")[0];
					}else{
						page.alert("ֻ��ɾ���ݸ��¼��");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('��ѡ��Ҫɾ���ļ�¼��');
				return;
			}else{
				if (confirm("ȷ��ɾ����¼��")){
					document.getElementById("deleteuuid").value = deleteuuid.join("#");
					document.srcForm.action=path+"mkr/USAConvention/bodyDelete.action";
					document.srcForm.submit();
				}
			}
		}
		
		//ʧЧ��¼
		function _bodyFail(){
			var num = 0;
			var op_uuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state != "1"){
						page.alert("ֻ��ʧЧ����Ч�ļ�¼��");
						return;
					}else{
						op_uuid=arrays[i].value.split("#")[0];
						num++;
					}
				}
			}
			if(num != "1"){
				alert('��ѡ��һ������');
				return;
			}else{
				if (confirm("ȷ��ʧЧ�ü�¼��")){
					document.srcForm.action=path+"mkr/USAConvention/changeFail.action?type=fail&op_uuid="+op_uuid;
					document.srcForm.submit();
				}
			}
		}
		
		//�ָ��ٴ���Ч��¼
		function _bodyRecovery(){
			var num = 0;
			var op_uuid="";
			var expire_date="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state != "2"){
						page.alert("ֻ�ָܻ���ʧЧ�ļ�¼��");
						return;
					}else{
						op_uuid=arrays[i].value.split("#")[0];
						expire_date=arrays[i].value.split("#")[2];
						num++;
					}
				}
			}
			if(num != "1"){
				alert('��ѡ��һ������');
				return;
			}else{
				if (confirm("ȷ���ָ���Ч�ü�¼��")){
					//�޸ĵ�ǰʱ���ʽ
					var d = new Date();
					var str = d.getFullYear()+"-0"+(d.getMonth()+1)+"-0"+d.getDate();
					var carr = str.split("-");
					var curdate=new Date(carr[0],carr[1],carr[2]);
					var curdates=curdate.getTime();
					//�޸�ʧЧʱ���ʽ
					var earr = expire_date.split("-");
					var expireDate=new Date(earr[0],earr[1],earr[2]);
					var expireDates=expireDate.getTime();
					if(curdates < expireDates){
						document.srcForm.action=path+"mkr/USAConvention/changeFail.action?type=recovery&op_uuid="+op_uuid;
						document.srcForm.submit();
					}else{
						window.open(path + "mkr/USAConvention/modExpireDate.action?op_uuid=" + op_uuid,"window","width=250,height=210,top=220,left=550");
					}
				}
			}
		}
		function mod_tijiao(){
			document.srcForm.action = path +"mkr/USAConvention/findBodyList.action";
			document.srcForm.submit();
		}
		
		
	</script>
	<BZ:body codeNames="GYRZJGLX">
		<BZ:form name="srcForm" method="post" action="mkr/USAConvention/findBodyList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="op_uuid" name="op_uuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��������" class="btn btn-sm btn-primary" onclick="_bodyAdd()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_bodyUpdate()"/>&nbsp;
					<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_bodyDel()"/>&nbsp;
					<input type="button" value="ʧ&nbsp;&nbsp;Ч" class="btn btn-sm btn-primary" onclick="_bodyFail()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" title="����˰�ť�ɽ����ٴ���Ч����" onclick="_bodyRecovery()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--�б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="NAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="TYPE">����</div>
								</th>
								<th style="width: 22%;">
									<div class="sorting_disabled" id="ADDR">��ַ</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="VALID_DATE">��֤ʱ��</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="EXPIRE_DATE">ʧЧʱ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="STATE">״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="COA_ID" onlyValue="true"/>#<BZ:data field="STATE" onlyValue="true"/>#<BZ:data field="EXPIRE_DATE" type="date" onlyValue="true"/>" class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TYPE" defaultValue="" codeName="GYRZJGLX" onlyValue="true"/></td>
								<td><BZ:data field="ADDR" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="VALID_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="EXPIRE_DATE" defaultValue="" type="date" onlyValue="true" /></td>
								<td><BZ:data field="STATE" defaultValue="" onlyValue="true" checkValue="0=�ݸ�;1=����Ч;2=��ʧЧ" /></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--�б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>