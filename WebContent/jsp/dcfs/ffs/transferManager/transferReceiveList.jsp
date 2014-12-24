<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="com.dcfs.ffs.transferManager.TransferConstant"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%
  /**   
 * @Description: 交接管理-接收
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
		<title>交接单接收列表</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
<script type="text/javascript">
  //iFrame高度自动调整
 	 $(document).ready(function() {
  			dyniframesize(['mainFrame']);
  		});

 	//显示查询条件
	function _showSearch(){
		$.layer({
			type : 1,
			title : "查询条件",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['900px','157px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
 
	//查询
 	function search(){
     	document.srcForm.action=path+"transferManager/findReceiveList.action";
		document.srcForm.submit();
   	}

	//接收
  	function _receive(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('abc').length;i++){
		   	if(document.getElementsByName('abc')[i].checked){
		   		var at_state =document.getElementsByName('abc')[i].value.split("#")[1];
		   		if(at_state!="1"){
			   		alert('请选择待接收状态的交接单进行接收');
			   		return;
		   		}else{
		   			uuid=document.getElementsByName('abc')[i].value.split("#")[0];
		   		}
		   		sfdj++;
		   	} 
		}
		if(sfdj != "1"){
			page.alert('请选择一条要接收的数据');
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
  
 
  	//重置
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

 	//明细查询
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
  	
	//查看
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
			page.alert('请选择一条要查看的数据');
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

	  //导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}
</script>

<BZ:body property="data" codeNames="JSZT">
	<BZ:form name="srcForm" method="post" action="transferManager/findReceiveList.action">
	<input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
	<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 查询条件区Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						<tr>
							<td class="bz-search-title" style="width: 10%"><span title="交接单编号">交接单编号</span></td>
							<td style="width: 15%">
								<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="交接单编号" restriction="hasSpecialChar" maxlength="20"/>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="份数">份数</span></td>
							<td style="width: 15%">
								<BZ:input prefix="S_" field="COPIES" id="S_COPIES" defaultValue="" formTitle="份数" restriction="hasSpecialChar" maxlength="20"/>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="移交人">移交日期</span></td>
							<td style="width: 40%">									
								<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
								<BZ:input prefix="S_" field="TRANSFER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
							</td>
						  </tr>
						  <tr>
							<td class="bz-search-title"><span title="移交日期">移交人</span></td>
							<td>
								<BZ:input prefix="S_" field="TRANSFER_USERNAME" id="S_TRANSFER_USERNAME" defaultValue="" formTitle="移交人" restriction="hasSpecialChar" maxlength="256"/>
							</td>
							<td class="bz-search-title"><span title="接收人">接收人</span></td>
							<td>
								<BZ:input prefix="S_" field="RECEIVER_USERNAME" id="S_RECEIVER_USERNAME" defaultValue="" formTitle="接收人" restriction="hasSpecialChar" maxlength="256"/>
							</td>
							<td class="bz-search-title"><span title="接收时间">接收时间</span></td>
							<td>
								<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
								<BZ:input prefix="S_" field="RECEIVER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
							</td>
						  </tr>
						  <tr>
							<td class="bz-search-title"><span title="移交状态">移交状态</span></td>
							<td>
								<BZ:select prefix="S_" field="AT_STATE" id="S_AT_STATE" isCode="true" codeName="JSZT" formTitle="移交状态" defaultValue="" ><BZ:option value="">--请选择--</BZ:option></BZ:select>
							</td>
						  </tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
	<div class="page-content">
		<div class="wrapper">
	 	<!-- 功能按钮操作区Start -->
	 	<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
			<input type="button" value="接&nbsp;&nbsp;收" class="btn btn-sm btn-primary" onclick="_receive()"/>&nbsp;
			<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;			
			<input type="button" value="明细查询" class="btn btn-sm btn-primary" onclick="_detailView()"/>&nbsp;	
			<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;	
		</div>
		<div class="blue-hr"></div>
		<!-- 功能按钮操作区End -->
		<!--查询结果列表区Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th class="center" style="width:5%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:5%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONNECT_NO">交接单编号</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="COPIES">份数</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSFER_USERNAME">移交人</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSFER_DATE">移交日期</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="RECEIVER_USERNAME">接收人</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="RECEIVER_DATE">接收时间</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="AT_STATE">移交状态</div>
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
		<!--查询结果列表区End -->
		<!--分页功能区Start -->
		<div class="footer-frame">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="交接单" 
					exportCode="TRANSFER_DATE=DATE;RECEIVER_DATE=DATE;AT_STATE=CODE,JSZT;" 
					exportField="CONNECT_NO=交接单编号,20,20;COPIES=份数,10;TRANSFER_USERNAME=移交人,10;TRANSFER_DATE=移交日期,15;RECEIVER_USERNAME=接收人,10;RECEIVER_DATE=接收日期,15;AT_STATE=移交状态,10"/></td>				
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
		</div>
	</div>
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
