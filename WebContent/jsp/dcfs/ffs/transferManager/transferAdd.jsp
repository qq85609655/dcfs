<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	/**   
	 * @Description:����
	 * @author xxx   
	 * @date 2014-7-29 10:44:22
	 * @version V1.0   
	 */
	/******Java���빦������Start******/
	//��ȡ���ݶ����б�
	DataList dataList = (DataList)request.getAttribute("Transfer_Detail_DataList");
	int li=0;
	int zc=0;
	int tx=0;
	if(dataList!=null){
    	li=dataList.size();
    	for(int i=0;i<dataList.size();i++){
    		if("2".equals(dataList.getData(i).getString("FILE_TYPE").substring(0, 1))){
    	    	tx++;
    	    	}else{
    	    	zc++;
    	    	}
    	}
    	
	}
	String flag = "1";
    Data tdata =(Data)request.getAttribute("Edit_Transfer_data");
   if(tdata == null){
        flag = "0";
    }else{
	    if(tdata.isEmpty()){
	        flag = "0";
    	}
    }
    
    String tI_ID=tdata.getString("TI_ID","");
    String cONNECT_NO=tdata.getString("CONNECT_NO","");
    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
   	String code = (String)request.getAttribute("TRANSFER_CODE");
   	
   	String mannualDeluuid = (String)request.getAttribute("mannualDeluuid");
	if("null".equals(mannualDeluuid) || mannualDeluuid == null){
	    mannualDeluuid = "";
	}
   	
    String sbcode = code.substring(0,1);
    boolean tw_flag = false ;
    if(sbcode!=null&&"5".equals(sbcode)){
  	  tw_flag = true;
    }
%>
<BZ:html>
<BZ:head>
	<title>���</title>
	<BZ:webScript list="true" edit="true" tree="false" />
</BZ:head>
<script>
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	//});

	function _submit() {
		var arrays = document.getElementsByName("abc");
		if(arrays.length<1){
			page.alert('��ѡ��Ҫ���ӵ��ļ���');
			return;
		}else if (confirm("�Ƿ�ֱ���ύ���ӵ���")){
			var num = 0;
			var chioceuuid = [];
			for(var i=0; i<arrays.length; i++){
				chioceuuid[num] = arrays[i].value;
				num += 1;
			}
			var uuid = chioceuuid.join("#");
			document.getElementById("chioceuuid").value = uuid;
			
			document.srcForm.action = path + "transferManager/submit.action";
			document.srcForm.submit();
		}
	}

	function _goback() {
		document.srcForm.action = path + "transferManager/findList.action";
		document.srcForm.submit();
	}
	function _save() {
		var arrays = document.getElementsByName("abc");
		if(arrays.length<1){
			page.alert('��ѡ��Ҫ���ӵ��ļ���');
			return;
		}else if(confirm("�Ƿ񱣴潻�ӵ���")){
		
			var num = 0;
			var chioceuuid = [];
			for(var i=0; i<arrays.length; i++){
				chioceuuid[num] = arrays[i].value;
				num += 1;
			}
			var uuid = chioceuuid.join("#");
			document.getElementById("chioceuuid").value = uuid;
		
			document.srcForm.action = path + "transferManager/save.action";
			document.srcForm.submit();
		}
	}
	function _fileSelect() {
		var mannualDeluuid = document.getElementById("mannualDeluuid").value;
		mannualDeluuid = encodeURIComponent(mannualDeluuid);
		
		window.open(path + "transferManager/MannualFile.action?mannualDeluuid="+mannualDeluuid+"&TRANSFER_CODE=<%=code%>","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		//window.open(path + "transferManager/MannualFile.action?TI_ID=<%=tI_ID%>&TRANSFER_CODE=<%=code%>","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
	}
	
	function refreshLocalList(uuid){
	
		var mannualDeluuid = document.getElementById("mannualDeluuid").value;
		if(mannualDeluuid != ""){
			uuid = uuid + "#" + mannualDeluuid;
		}
		document.getElementById("chioceuuid").value = uuid;
		document.srcForm.action=path+"transferManager/edit.action?type=refresh";
	 	document.srcForm.submit();
		
	
		//window.location.href = path+"transferManager/add.action";
		//document.srcForm.action=path+"transferManager/edit.action";
	 	//document.srcForm.submit();
		
	}
	function _remove(){
		var num = 0;
		var chioceuuid = [];
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num] = arrays[i].value;
			num += 1;
		}
		}
	
		if(num < 1){
				page.alert('��ѡ��Ҫ�ӽ��ӵ����Ƴ����ļ���');
				return;
			}else{
				if (confirm("ȷ���Ƴ���Щ�ļ���")){
					var uuid = chioceuuid.join("#");
					document.getElementById("chioceuuid").value=uuid;
					document.srcForm.action = path + "transferManager/remove.action";
					document.srcForm.submit();
				}
			}
	}
</script>

<BZ:body property="Edit_Transfer_data" codeNames="WJLX;GJSY;SYZZ;TWCZFS_ALL;TWLX">
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin  property="transfer_data"-->
		<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE %>"/>
		<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=code %>"/>
		<input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
		<input type="hidden" name="TI_ID" id="TI_ID" value="<%=tI_ID%>"/>
		<input type="hidden" name="CONNECT_NO" id="CONNECT_NO" value="<%=cONNECT_NO%>"/>
		<input type="hidden" name="COPIES" id="COPIES" value='<%=li%>'/>
		<input type="hidden" name="OPER_TYPE" id="OPER_TYPE" value='1'/>
		<input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
		<!-- ��������end TRANSFER_TYPE-->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<!-- ���ܰ�ť������Start -->
					<div class="table-row table-btns" style="text-align: left">
						<input type="button" value="�ֹ����"
							class="btn btn-sm btn-primary" onclick="_fileSelect() " />&nbsp; 
							<input
							type="button" value="ɨ�����"
							class="btn btn-sm btn-primary" onclick="_fileSelect() " />
							&nbsp; 
							<input
							type="button" value="��&nbsp;&nbsp;&nbsp;&nbsp;��"
							class="btn btn-sm btn-primary" onclick="_remove() " />
					</div>
					<div class="blue-hr"></div>
					<!-- ���ܰ�ť������End -->
					<!--��ѯ����б���Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							adsorb="both" init="true" id="table2" name="table2">
							<thead>
								<tr>
									<th class="center" style="width:5%;">
										<div class="sorting_disabled">
											<input name="abcd" type="checkbox" class="ace">
										</div>
									</th>
									<th style="width:2%;" nowrap>
										<div class="sorting_disabled">���</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="COUNTRY_CN">����</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="NAME_CN">������֯</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="REGISTER_DATE">��������</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="FILE_NO">�ļ����</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="FILE_TYPE">�ļ�����</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="MALE_NAME">��������</div>
									</th>
									<th style="width:10%;" nowrap>
										<div class="sorting" id="FEMALE_NAME">Ů������</div>
									</th>
									<%if("13".equals(code)){ %>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="NAME">�����ͯ����</div>
									</th>
									<%} %>
									<%if(tw_flag){ %>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="HANDLE_TYPE">���÷�ʽ</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="APPLE_TYPE">��������</div>
									</th>
									<th style="width:5%;" nowrap>
										<div class="sorting" id="RETREAT_DATE">ȷ������</div>
									</th>
									<%} %>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Transfer_Detail_DataList">
									<tr class="emptyData">
										<td class="center"><input name="abc" type="checkbox"
											value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace">
										</td>
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="COUNTRY_CN"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data type="date" field="REGISTER_DATE"
												dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
										</td>
										<td><BZ:data field="FILE_NO" defaultValue=""
												onlyValue="true" /></td>
										<td><BZ:data field="FILE_TYPE" codeName="WJLX"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="MALE_NAME" defaultValue=""
												onlyValue="true" /></td>
										<td><BZ:data field="FEMALE_NAME" defaultValue=""
												onlyValue="true" /></td>
										<%if("13".equals(code)){ %>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
										<%} %>
										<%if(tw_flag){ %>
										<td><BZ:data field="HANDLE_TYPE" codeName="TWCZFS_ALL" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="APPLE_TYPE" codeName="TWLX" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="RETREAT_DATE" dateFormat="yyyy-MM-dd" defaultValue="" type="date" onlyValue="true"/></td>
										<%} %>
									</tr>
								</BZ:for>
							</tbody>
						</table>
					</div>
					<!--��ѯ����б���End -->
					<%if("1".equals(flag)){ %>
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>���ӵ���Ϣ</div>
					</div>
					<!--���ӵ�������Ϣ��-->
						<table class="bz-edit-data-table" border="0">
					 		<tr>
								<td class="bz-edit-data-title" width="10%">���ӵ����</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">����</td>
								<td class="bz-edit-data-value" width="15%"><%=li %></td> 
								<td class="bz-edit-data-title" width="10%">�����ļ�</td>
								<td class="bz-edit-data-value" width="10%"><%=zc %></td> 
								<td class="bz-edit-data-title" width="10%">�����ļ�</td>
								<td class="bz-edit-data-value" width="15%"><%=tx %></td> 
					 		</tr>
					 		<tr>
								<td class="bz-edit-data-title" width="10%">������</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="RECEIVER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">��������</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="RECEIVER_DATE" onlyValue="true"/></td> 
								<td class=bz-edit-data-title width="10%">�ƽ���</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="TRANSFER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">�ƽ�����</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="TRANSFER_DATE" onlyValue="true"/></td> 
					 		</tr>
					 	</table>
					<!--���ӵ�������Ϣ��End-->
						<%}else{ %>
						<table class="bz-edit-data-table" border="0">
						<tr>
						<td class="bz-edit-data-title" width="10%">�ļ�����</td>
						<td class="bz-edit-data-value" width="90%"><%=li %></td>
						</tr>
						</table>
						<%} %>
				</div>
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="����" class="btn btn-sm btn-primary"
					onclick="_save()" /> 
				<input type="button" value="�ύ" class="btn btn-sm btn-primary"
					onclick="_submit()" /> 
				<input type="button" value="����"
					class="btn btn-sm btn-primary" onclick="_goback();" />
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>