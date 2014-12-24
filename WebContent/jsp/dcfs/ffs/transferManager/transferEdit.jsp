<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
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
	DataList dataList = (DataList)session.getAttribute("Transfer_Detail_DataList");
    int li=dataList.size();
	
%>
<BZ:html>
<BZ:head>
	<title>�޸�</title>
	<BZ:webScript list="true" edit="true" tree="false" />
</BZ:head>
<script>
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	//});

	function _submit() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "transferinfo/save.action";
			document.srcForm.submit();
		}
	}
	function _save() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "transferinfo/save.action";
			document.srcForm.submit();
		}
	}

	function _goback() {
		document.srcForm.action = path + "transferinfo/findList.action?TRANSFER_CODE=11&OPER_TYPE=1";
		document.srcForm.submit();
	}
	function _fileSelect() {
		window.open(path + "transferManager/MannualFile.action","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
	}
	
	function refreshLocalList(){
		window.location.href = path+"transferManager/add.action";
	}
	function _remove(){
		var num = 0;
		var chioceuuid = [];
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num++] = arrays[i].value;
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

<BZ:body codeNames="WJLX;GJSY;SYZZ" property="transfer_data">
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin  property="transfer_data"-->
		<input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
		<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value='<BZ:dataValue field="TRANSFER_TYPE" onlyValue="true"/>'/>
		<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_TYPE" value='<BZ:dataValue field="TRANSFER_CODE" onlyValue="true"/>'/>
		<input type="hidden" name="COPIES" id="COPIES" value='<%=li%>>'/>
		<input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
		<!-- ��������end TRANSFER_TYPE-->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>���ӵ���ϸ</div>
				</div>
				<!-- �������� end -->
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
									<th style="width:5%;">
										<div class="sorting_disabled">���</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="COUNTRY_CN">����</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="NAME_CN">������֯</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="REGISTER_DATE">��������</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FILE_NO">�ļ����</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FILE_TYPE">�ļ�����</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="MALE_NAME">��������</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FEMALE_NAME">Ů������</div>
									</th>
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
									</tr>
								</BZ:for>
							</tbody>
						</table>
					</div>
					<!--��ѯ����б���End -->
				</div>
			</div>
		</div>



		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�ύ" class="btn btn-sm btn-primary"
					onclick="_submit()" /> <input type="button" value="����"
					class="btn btn-sm btn-primary" onclick="_goback();" />
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>