<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: ���ӹ���-�ƽ�
 * @author xxx   
 * @date 2014-7-29 10:44:22
 * @version V1.0   
 */
  String compositor=(String)request.getAttribute("compositor");
  if(compositor==null){
      compositor="";
  }
  String ordertype=(String)request.getAttribute("ordertype");
  if(ordertype==null){
      ordertype="";
  }
  String TRANSFER_TYPE =(String)request.getAttribute("TRANSFER_TYPE");
  if(TRANSFER_TYPE==null){
	  TRANSFER_TYPE="";
  }
  String TRANSFER_CODE =(String)request.getAttribute("TRANSFER_CODE");
  if(TRANSFER_CODE==null){
	  TRANSFER_CODE="";
  }

	String sbcode = TRANSFER_CODE.substring(0,1);
	boolean tw_flag = false ;
	if(sbcode!=null&&"5".equals(sbcode)){
		tw_flag = true;
	}
%>
<BZ:html>
	<BZ:head>
		<title>��ѯ�б�</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
  $(document).ready(function() {
  			dyniframesize(['mainFrame']);
  });
 
 //��ʾ��ѯ����
	function _showSearch(){
		$.layer({
			type : 1,
			title : "��ѯ����",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['900px','157px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
 
  function search(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	} 
     document.srcForm.action=path+"transferManager/findList.action";
	 document.srcForm.submit();
  }
  
  function add(){
	 var ttype = document.getElementById("TRANSFER_TYPE").value;
	 if(ttype==1){
     	document.srcForm.action=path+"transferManager/add.action?init=1";
	 	document.srcForm.submit();
  	 }else if(ttype==2){
  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
  		document.srcForm.action=path+"transferManager/addchildMatchinfo.action?init=1";
	 	document.srcForm.submit();
  		<%}else{%>
  		document.srcForm.action=path+"transferManager/addchildinfo.action?init=1";
	 	document.srcForm.submit();
	 	<%}%>
  	 }else if(ttype==3){
  		document.srcForm.action=path+"transferManager/addcheque.action?init=1";
	 	document.srcForm.submit();
  	 }
  	else if(ttype==4){
  		document.srcForm.action=path+"transferManager/addarchive.action?init=1";
	 	document.srcForm.submit();
  	 }
  }

  function _update(){
	    var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('abc').length;i++){
		   if(document.getElementsByName('abc')[i].checked){
			   var at_state =document.getElementsByName('abc')[i].value.split("#")[1];
			   if(at_state!="0"){
				   alert('��ѡ�����ƽ�״̬�Ľ��ӵ������޸�');
				   return;
			   }
			   uuid=document.getElementsByName('abc')[i].value.split("#")[0];
			   sfdj++;
		   }
		}
		  if(sfdj>1||sfdj<1){
		   alert('��ѡ��һ����Ҫ�޸ĵ�����');
		   return;
		  }else{
			var ttype = document.getElementById("TRANSFER_TYPE").value;
	 		if(ttype==1){
	 			document.srcForm.action=path+"transferManager/edit.action?TI_ID="+uuid;
	 		 	document.srcForm.submit();
	 	  	 }else if(ttype==2){
	 	  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
	 	  		document.srcForm.action=path+"transferManager/editChildMatchinfo.action?TI_ID="+uuid;
	 		 	document.srcForm.submit();
	 	  		<%}else{%>
	 	  		document.srcForm.action=path+"transferManager/editChildinfo.action?TI_ID="+uuid;
	 		 	document.srcForm.submit();
	 		 	<%}%>
	 	  	 }else if(ttype==3){
	 	  		document.srcForm.action=path+"transferManager/editCheque.action?TI_ID="+uuid;
	 		 	document.srcForm.submit();
	 	  	 }
	 	  	else if(ttype==4){
	 	  		document.srcForm.action=path+"transferManager/editArchive.action?TI_ID="+uuid;
	 		 	document.srcForm.submit();
	 	  	 }
	 }
  }
  
  function _print(){
	  var ttype = document.getElementById("TRANSFER_TYPE").value;
	  var tcode = document.getElementById("TRANSFER_CODE").value;
	  var arrays = document.getElementsByName("abc");
		var num = 0;
		var uuid="";
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				uuid=document.getElementsByName('abc')[i].value;
				num += 1;
			}
		}
		if(num != "1"){
			page.alert('��ѡ��һ��Ҫ��ӡ���ƽ���');
			return;
		}else{
			var ttype = document.getElementById("TRANSFER_TYPE").value;
	 		if(ttype==1){
	 			 window.open(path + "transferManager/inprint.action?TRANSFER_CODE="+tcode+"&TRANSFER_TYPE="+ttype+"&UUID="+uuid,"","height=842,width=680,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
	 	  	 }else if(ttype==2){

	 	  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
	 	  		window.open(path + "transferManager/inChildMatchinfoPrint.action?UUID="+uuid,"","height=700,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
	 	  		<%}else{%>
	 	  		window.open(path + "transferManager/inChildinfoPrint.action?UUID="+uuid,"","height=700,width=800,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
	 		 	<%}%>	
	 	  		
	 	  	 }else if(ttype==3){
	 	  		window.open(path + "transferManager/inChequeinfoPrint.action?UUID="+uuid,"","height=700,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
	 	  	 }else if(ttype==4){
	 	  		window.open(path + "transferManager/inArchiveinfoPrint.action?UUID="+uuid,"","height=700,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
	 	  	 }
		 }
  }

  function _printTW(){
	  var ttype = document.getElementById("TRANSFER_TYPE").value;
	  var tcode = document.getElementById("TRANSFER_CODE").value;
	  var arrays = document.getElementsByName("abc");
	  var num = 0;
	  var uuid="";
	  for(var i=0; i<arrays.length; i++){
		  if(arrays[i].checked){
			  uuid=document.getElementsByName('abc')[i].value;
			  num += 1;
		  }
	  }
	  if(num != "1"){
		  page.alert('��ѡ��һ��Ҫ��ӡ���ƽ���');
		  return;
	  }else{
		  var ttype = document.getElementById("TRANSFER_TYPE").value;
		  if(ttype==1){
			  window.open(path + "transferManager/inprintTW.action?TRANSFER_CODE="+tcode+"&TRANSFER_TYPE="+ttype+"&UUID="+uuid,"","height=842,width=680,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
		  }
	  }
  }

  function _view(uuid){
	  var ttype = document.getElementById("TRANSFER_TYPE").value;
	  var tcode = document.getElementById("TRANSFER_CODE").value;
		if(ttype==1){
			 window.open(path + "transferManager/inprint.action?UUID="+uuid+"&TRANSFER_CODE="+tcode+"&TRANSFER_TYPE="+ttype,"","height=842,width=680,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
	  	 }else if(ttype==2){
	  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
 	  		window.open(path + "transferManager/InTransferChildMatchinfoView.action?UUID="+uuid,"","height=700,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
 	  		<%}else{%>
 	  		window.open(path + "transferManager/InTransferChildinfoView.action?UUID="+uuid,"","height=700,width=800,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
 		 	<%}%>
	  		
	  	 }else if(ttype==3){
	  		window.open(path + "transferManager/InTransferChequeInfoView.action?UUID="+uuid+"&tcode="+tcode,"","height=700,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
	  	 }else if(ttype==4){
	  		window.open(path + "transferManager/InTransferArchiveInfoView.action?UUID="+uuid+"&tcode="+tcode,"","height=700,width=1000,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no, status=no");
	  	 }
  }

  function _viewTW(uuid){
	  var ttype = document.getElementById("TRANSFER_TYPE").value;
	  var tcode = document.getElementById("TRANSFER_CODE").value;
	  if(ttype==1){
		  window.open(path + "transferManager/inprintTW.action?UUID="+uuid+"&TRANSFER_CODE="+tcode+"&TRANSFER_TYPE="+ttype,"","height=842,width=680,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
	  }
  }

  function _fileSelect() {
		window.open(path + "transferManager/MannualFile.action","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
	}

  function _delete(){
	  var sfdj=0;
		var uuid="";
		   for(var i=0;i<document.getElementsByName('abc').length;i++){
		   if(document.getElementsByName('abc')[i].checked){
		   var at_state =document.getElementsByName('abc')[i].value.split("#")[1];
		   if(at_state!="0"){
			   alert('��ѡ�����ƽ�״̬�Ľ��ӵ�����ɾ��');
			   return;
		   }
		   uuid=uuid+"#"+document.getElementsByName('abc')[i].value.split("#")[0];
		   sfdj++;
		   }
		}
		  if(sfdj=="0"){
		   alert('��ѡ��Ҫ����ɾ���Ľ��ӵ�');
		   return;
		  }else{
		  if(confirm('ȷ��Ҫɾ��ѡ�еĽ��ӵ���?')){
			 document.getElementById("chioceuuid").value=uuid;
			 document.srcForm.action=path+"transferManager/delete.action";
			 document.srcForm.submit();
		  }else{
		  return;
		  }
		}  
  }
  //���ò�ѯ
  function _reset(){
   $("#TRANSFER_USERNAME").val("");
    $("#S_TRANSFER_DATE_START").val("");
    $("#S_TRANSFER_DATE_END").val("");
    $("#S_CONNECT_NO").val("");
    $("#S_AT_STATE").val("");
    $("#S_RECEIVER_DATE_START").val("");
    $("#S_RECEIVER_DATE_END").val("");
    $("#S_TRANSFER_USERNAME").val("");
    $("#S_RECEIVER_USERNAME").val("");
    $("#S_COPIES").val("");
    
  } 
function _batchSubmit(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('abc').length;i++){
		if(document.getElementsByName('abc')[i].checked){
			var at_state =document.getElementsByName('abc')[i].value.split("#")[1];
			if(at_state!="0"){
				alert('��ѡ�����ƽ�״̬�Ľ��ӵ������ύ');
				return;
			}
			var COPIES =document.getElementsByName('abc')[i].value.split("#")[2];
			if(COPIES=="0"){
				alert('ѡ��Ľ��ӵ�û�н����ļ���������ѡ��');
				return;
			}
			uuid=uuid+"#"+document.getElementsByName('abc')[i].value.split("#")[0];
			sfdj++;
		}
	}
	if(sfdj=="0"){
		alert('��ѡ��Ҫ�����ύ�Ľ��ӵ�');
		return;
	}else{
		if(confirm('ȷ��Ҫ�ύѡ�еĽ��ӵ���?')){
			document.getElementById("chioceuuid").value=uuid;
			document.srcForm.action=path+"transferManager/batchsubmit.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
}

  //��ϸ��ѯ
  function _detailView(){
	  var ttype = document.getElementById("TRANSFER_TYPE").value;
	  var tcode = document.getElementById("TRANSFER_CODE").value;
		if(ttype==1){
			window.open(path + "transferManager/detailView.action?OPER_TYPE=1&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"",""); 
	  	 }else if(ttype==2){
	  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
	  		window.open(path + "transferManager/detailViewChildMatchinfo.action?OPER_TYPE=1&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"","");
 	  		<%}else{%>
 	  		window.open(path + "transferManager/detailViewChildinfo.action?OPER_TYPE=1&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"","");
 		 	<%}%> 
	  		 
	  	 }else if(ttype==3){
	  		window.open(path + "transferManager/detailViewCheque.action?OPER_TYPE=1&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"",""); 
	  	 }else if(ttype==4){
	  		window.open(path + "transferManager/detailViewArchive.action?OPER_TYPE=1&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"",""); 
	  	 }
	  
  }
  //����
	function _export(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}
  </script>
<BZ:body property="data" codeNames="JJDZT">
     <BZ:form name="srcForm" method="post" action="transferManager/findList.action">
     <input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
     <!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	 <div class="page-content">
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	 </BZ:frameDiv>
	 <!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						  <tr>
							<td class="bz-search-title"><span title="���ӵ����">���ӵ����</span></td>
							<td>
										<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="���ӵ����" restriction="hasSpecialChar" maxlength="20"/>
										</td>
							<td class="bz-search-title"><span title="����">����</span></td>
							<td>
										<BZ:input prefix="S_" field="COPIES" id="S_COPIES" defaultValue="" formTitle="����" restriction="int" maxlength="20"/>
										</td>
							<td class="bz-search-title"><span title="�ƽ���">�ƽ�����</span></td>
							<td>									
										<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
										<BZ:input prefix="S_" field="TRANSFER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title"><span title="�ƽ�����">�ƽ���</span></td>
							<td>
										<BZ:input prefix="S_" field="TRANSFER_USERNAME" id="S_TRANSFER_USERNAME" defaultValue="" formTitle="�ƽ���" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title"><span title="������">������</span></td>
							<td>
										<BZ:input prefix="S_" field="RECEIVER_USERNAME" id="S_RECEIVER_USERNAME" defaultValue="" formTitle="������" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title"><span title="����ʱ��">����ʱ��</span></td>
							<td>
										<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
										<BZ:input prefix="S_" field="RECEIVER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title"><span title="�ƽ�״̬">�ƽ�״̬</span></td>
							<td>
									<BZ:select prefix="S_" field="AT_STATE" id="S_AT_STATE" isCode="true" codeName="JJDZT" formTitle="�ƽ�״̬" defaultValue="" >
									<BZ:option value="">--��ѡ��--</BZ:option></BZ:select>
									</td>
						  </tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="search();" class="btn btn-sm btn-primary">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������End -->
     <div class="wrapper">
	 <!-- ���ܰ�ť������Start -->
	 <div class="table-row table-btns" style="text-align: left">
		<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="add()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_update()"/>&nbsp;		
		<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_batchSubmit()"/>&nbsp;
		 <%if(tw_flag){ %>
		 <input type="button" value="���ӵ���ӡ" class="btn btn-sm btn-primary" onclick="_printTW()"/>&nbsp;
		 <%} else{%>
		<input type="button" value="���ӵ���ӡ" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
		 <%}%>
		<input type="button" value="��ϸ��ѯ" class="btn btn-sm btn-primary" onclick="_detailView()"/>&nbsp;	
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;	
	</div>
	<div class="blue-hr"></div>
	<!-- ���ܰ�ť������End -->
	
		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th class="center" style="width:5%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:5%;">
							<div class="sorting_disabled">���</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONNECT_NO">���ӵ����</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="COPIES">����</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSFER_USERNAME">�ƽ���</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSFER_DATE">�ƽ�����</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="RECEIVER_USERNAME">������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="RECEIVER_DATE">��������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="AT_STATE">�ƽ�״̬</div>
						</th>
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="TI_ID" onlyValue="true"/>#<BZ:data field="AT_STATE" onlyValue="true"/>#<BZ:data field="COPIES" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center">
									<%if(tw_flag){ %>
									<a href='#' onclick='javascript:_viewTW("<BZ:data field="TI_ID" onlyValue="true"/>")'>
										<BZ:data field="COPIES"  defaultValue="" onlyValue="true"/>
									</a>
									<%}else{%>
									<a href='#' onclick='javascript:_view("<BZ:data field="TI_ID" onlyValue="true"/>")'>
										<BZ:data field="COPIES"  defaultValue="" onlyValue="true"/>
									</a>
									<%}%>

								</td>
								<td><BZ:data field="TRANSFER_USERNAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="TRANSFER_DATE" type="Date"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_USERNAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="RECEIVER_DATE" type="Date"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="AT_STATE" codeName="JJDZT" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="���ӵ�" 
					exportCode="TRANSFER_DATE=DATE;RECEIVER_DATE=DATE;AT_STATE=CODE,JJDZT;" 
					exportField="CONNECT_NO=���ӵ����,20,20;COPIES=����,10;TRANSFER_USERNAME=�ƽ���,10;TRANSFER_DATE=�ƽ�����,15;RECEIVER_USERNAME=������,10;RECEIVER_DATE=��������,15;AT_STATE=�ƽ�״̬,10"/></td>				
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
		</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>
