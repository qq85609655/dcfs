<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	/**   
	 * @Description:�鿴��ͯ���Ͻ��ӵ���Ϣ
	 * @author wangzheng
	 * @date 2014-11-2
	 * @version V1.0   
	 */
	/******Java���빦������Start******/
	//��ȡ���ݶ����б�
	DataList dataList = (DataList)request.getAttribute("Receive_datalist");
    int li=0;
    li=dataList.size();
    int tx=0;
    int zc=0;
    for(int i=0;i<li;i++){ 	
    	if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(dataList.getData(i).getString("CHILD_TYPE"))){//�����ͯ
    		tx++;
    	}else if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(dataList.getData(i).getString("CHILD_TYPE"))){//������ͯ
    		zc++;
    	}
    }
    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
	String TRANSFER_CODE = (String)request.getAttribute("TRANSFER_CODE");
%>
<BZ:html>
<BZ:head>
	<title>���ӵ��鿴</title>
	<BZ:webScript list="true" edit="true" tree="false" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	function _showSearch(){
		$.layer({
			type : 1,
			title : "�˻�ԭ��",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['600px','165px'],
			offset: ['190px' , '160px'],
			closeBtn: [0, true]
		});
	}
	function _goback() {
		document.srcForm.action = path + "transferManager/findReceiveList.action";
		document.srcForm.submit();
	}
</script>

<BZ:body property="Receive_data" codeNames="WJLX;PROVINCE;ETXB;CHILD_TYPE">
	<BZ:form name="srcForm" method="post">
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE %>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE %>"/>
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>�����б�</div>
					</div>
					<!--��ѯ����б���Start -->
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="table2" name="table2">
							<thead>
								<tr>
									<th style="width:5%;">
										<div class="sorting_disabled">���</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id=COUNTRY_CN>����</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id=NAME_CN>������֯</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id=FILE_NO>�ļ����</div>
									</th>
									<th style="width:4%;">
										<div class="sorting" id=FILE_TYPE>�ļ�����</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="CHILD_NO">��ͯ���</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="PROVINCE_ID">ʡ��</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="NAME">����</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="SEX">�Ա�</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="BIRTHDAY">��������</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
									</th>
									<th style="width:5%;">
										<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Receive_datalist">
									<tr class="emptyData">									
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="COUNTRY_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data codeName="WJLX" field="FILE_TYPE" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data codeName="ETXB" field="SEX" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="BIRTHDAY" type="date" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
									</tr>
								</BZ:for>
							</tbody>
						</table>
					</div>
					<!--���ӵ�����б���End -->
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
								<td class="bz-edit-data-title" width="10%">��������</td>
								<td class="bz-edit-data-value" width="10%"><%=zc %></td> 
								<td class="bz-edit-data-title" width="10%">�������</td>
								<td class="bz-edit-data-value" width="15%"><%=tx %></td> 
					 		</tr>
					 		<tr>
								<td class="bz-edit-data-title" width="10%">������</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="RECEIVER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">��������</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="RECEIVER_DATE" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">�ƽ���</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="TRANSFER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">�ƽ�����</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="TRANSFER_DATE" onlyValue="true"/></td> 
					 		</tr>
					 	</table>
					
					<!--���ӵ�������Ϣ��End-->
					<!-- ���ܰ�ť������Start -->
					<div class="table-row table-btns" style="text-align: center">
						<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
					</div>
					<div class="blue-hr"></div>
					<!-- ���ܰ�ť������End -->
				</div>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>