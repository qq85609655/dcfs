<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="com.dcfs.ffs.transferManager.TransferConstant"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%
  /**   
 * @Description: ���ӹ���-����
 * @author wty
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
	  TRANSFER_TYPE="3";
  }
  String TRANSFER_CODE =(String)request.getAttribute("TRANSFER_CODE");
  if(TRANSFER_CODE==null){
	  TRANSFER_CODE="31";
  }
%>
<BZ:html>
	<BZ:head>
		<title>���ӵ������б�</title>
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
 
	//��ѯ
 	function search(){
     	document.srcForm.action=path+"transferManager/findReceiveList.action";
		document.srcForm.submit();
   	}

	//����
  	function _receive(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('abc').length;i++){
		   	if(document.getElementsByName('abc')[i].checked){
		   		var at_state =document.getElementsByName('abc')[i].value.split("#")[1];
		   		if(at_state!="1"){
			   		alert('��ѡ�������״̬�Ľ��ӵ����н���');
			   		return;
		   		}else{
		   			uuid=document.getElementsByName('abc')[i].value.split("#")[0];
		   		}
		   		sfdj++;
		   	} 
		}
		if(sfdj != "1"){
			page.alert('��ѡ��һ��Ҫ���յ�����');
			return;
		}else{
			var ttype = document.getElementById("TRANSFER_TYPE").value;
			if(ttype==<%=TransferConstant.TRANSFER_TYPE_FILE%>){
				document.srcForm.action=path+"transferManager/receive.action?uuid="+uuid;
				document.srcForm.submit();
			 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_CHILD%>){
				<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
				document.srcForm.action=path+"transferManager/receiveChildMatchinfo.action?uuid="+uuid;
				document.srcForm.submit();
				<%}else{%>
				document.srcForm.action=path+"transferManager/receiveChildinfo.action?uuid="+uuid;
				document.srcForm.submit();
				<%}%> 
		 	}else if(ttype==<%=TransferConstant.TRANSFER_TYPE_CHEQUE%>){
		 		document.srcForm.action=path+"transferManager/receiveCheque.action?uuid="+uuid;
		 		document.srcForm.submit();
			}else if(ttype==<%=TransferConstant.TRANSFER_TYPE_REPORT%>){
		  		document.srcForm.action=path+"transferManager/receiveArchive.action?uuid="+uuid;
			 	document.srcForm.submit();
		 	}				
		}
 	}
  
 
  	//����
  	function _reset(){
    	$("#S_CONNECT_NO").val("");
    	$("#S_COPIES").val("");
    	$("#S_TRANSFER_USERNAME").val("");
    	$("#S_RECEIVER_USERNAME").val("");
    	$("#S_RECEIVER_DATE_START").val("");
    	$("#S_RECEIVER_DATE_END").val("");
    	$("#S_TRANSFER_DATE_START").val("");
    	$("#S_TRANSFER_DATE_END").val("");
    	$("#S_AT_STATE").val("");
  	}

 	//��ϸ��ѯ
  	function _detailView(){
		var ttype = document.getElementById("TRANSFER_TYPE").value;
		var tcode = document.getElementById("TRANSFER_CODE").value;
		if(ttype==<%=TransferConstant.TRANSFER_TYPE_FILE%>){
			window.open(path + "transferManager/detailView.action?OPER_TYPE=2&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"",""); 
	  	 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_CHILD%>){
	  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
	  		window.open(path + "transferManager/detailViewChildMatchinfo.action?OPER_TYPE=<%=TransferConstant.OPER_TYPE_RECEIVE%>&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"","");
			<%}else{%>
			window.open(path + "transferManager/detailViewChildinfo.action?OPER_TYPE=<%=TransferConstant.OPER_TYPE_RECEIVE%>&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"","");
			<%}%> 
				
		  	 
	  	 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_CHEQUE%>){
	  		window.open(path + "transferManager/detailViewCheque.action?OPER_TYPE=2&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"",""); 
		 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_REPORT%>){
			window.open(path + "transferManager/detailViewArchive.action?OPER_TYPE=2&TRANSFER_TYPE="+ttype+"&TRANSFER_CODE="+tcode,"",""); 
		 }	
  	}
  	
	//�鿴
	function _view(){
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
			page.alert('��ѡ��һ��Ҫ�鿴������');
			return;
		}else{
			var ttype = document.getElementById("TRANSFER_TYPE").value;
			if(ttype==<%=TransferConstant.TRANSFER_TYPE_FILE%>){
				document.srcForm.action=path+"transferManager/inRView.action?uuid="+uuid;
			 	document.srcForm.submit();
		  	 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_CHILD%>){
		  		<%if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){%>
		  		document.srcForm.action=path+"transferManager/receiveViewChildMatchinfo.action?uuid="+uuid;
		  		//document.srcForm.action=path+"transferManager/detailViewChildinfo.action?uuid="+uuid;
			 	document.srcForm.submit();
		  		<%}else{%>
				document.srcForm.action=path+"transferManager/receiveViewChildinfo.action?uuid="+uuid;
		  		//document.srcForm.action=path+"transferManager/detailViewChildinfo.action?uuid="+uuid;
			 	document.srcForm.submit();
				<%}%> 
		  	 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_CHEQUE%>){
			  	document.srcForm.action=path+"transferManager/inChequeView.action?uuid="+uuid;
				document.srcForm.submit();
			 }else if(ttype==<%=TransferConstant.TRANSFER_TYPE_REPORT%>){
				document.srcForm.action=path+"transferManager/inArchiveView.action?uuid="+uuid;
				document.srcForm.submit();
			 }			
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

<BZ:body property="data" codeNames="JSZT">
	<BZ:form name="srcForm" method="post" action="transferManager/findReceiveList.action">
	<input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
	<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						<tr>
							<td class="bz-search-title" style="width: 10%"><span title="���ӵ����">���ӵ����</span></td>
							<td style="width: 15%">
								<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="���ӵ����" restriction="hasSpecialChar" maxlength="20"/>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="����">����</span></td>
							<td style="width: 15%">
								<BZ:input prefix="S_" field="COPIES" id="S_COPIES" defaultValue="" formTitle="����" restriction="hasSpecialChar" maxlength="20"/>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="�ƽ���">�ƽ�����</span></td>
							<td style="width: 40%">									
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
								<BZ:select prefix="S_" field="AT_STATE" id="S_AT_STATE" isCode="true" codeName="JSZT" formTitle="�ƽ�״̬" defaultValue="" ><BZ:option value="">--��ѡ��--</BZ:option></BZ:select>
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
	<div class="page-content">
		<div class="wrapper">
	 	<!-- ���ܰ�ť������Start -->
	 	<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_receive()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;			
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
							<div class="sorting" id="RECEIVER_DATE">����ʱ��</div>
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
									<input name="abc" type="checkbox" value="<BZ:data field="TI_ID" onlyValue="true"/>#<BZ:data field="AT_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td style="text-align:center"><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="COPIES"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_USERNAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_USERNAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="AT_STATE" codeName="JSZT" defaultValue="" onlyValue="true"/></td>
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
					exportCode="TRANSFER_DATE=DATE;RECEIVER_DATE=DATE;AT_STATE=CODE,JSZT;" 
					exportField="CONNECT_NO=���ӵ����,20,20;COPIES=����,10;TRANSFER_USERNAME=�ƽ���,10;TRANSFER_DATE=�ƽ�����,15;RECEIVER_USERNAME=������,10;RECEIVER_DATE=��������,15;AT_STATE=�ƽ�״̬,10"/></td>				
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
