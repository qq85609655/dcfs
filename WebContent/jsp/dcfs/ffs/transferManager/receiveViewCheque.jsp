<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
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
	DataList dataList = (DataList)request.getAttribute("Receive_datalist");
    int li=0;
    li=dataList.size();
    int tx=0;
    int zc=0;

    String TRANSFER_TYPE = (String)request.getAttribute("TRANSFER_TYPE");
	String TRANSFER_CODE = (String)request.getAttribute("TRANSFER_CODE");
	
	TokenProcessor processor=TokenProcessor.getInstance();
	String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���</title>
	<BZ:webScript list="true" edit="true" tree="false" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	function _goback() {
		document.srcForm.action = path + "transferManager/findReceiveList.action";
		document.srcForm.submit();
	}
</script>

<BZ:body property="Receive_data" codeNames="WJLX;GJSY;JFFS;">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE %>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE %>"/>
	    <div class="page-content">
	    	<div class="wrapper">
	    </div>
	    </div>
		<!-- ��������begin  property="transfer_data"-->
		<input type="hidden" name="TI_ID" id="TI_ID" value='<BZ:dataValue field="TI_ID" onlyValue="true"/>'>
				
		<!-- ��������end TRANSFER_TYPE-->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>�ļ��б�</div>
					</div>
					<!--��ѯ����б���Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							adsorb="both" init="true" id="table2" name="table2">
							<thead>
								<tr>
									<th style="width:5%;">
										<div class="sorting_disabled">���</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="PAID_NO">�ɷѱ��</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="COUNTRY_CODE">����</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="NAME_CN">������֯</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="PAID_WAY">�ɷѷ�ʽ</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="BILL_NO">Ʊ��</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="PAR_VALUE">Ʊ����</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<BZ:for property="Receive_datalist">
									<tr class="emptyData">
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="PAID_NO"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="COUNTRY_CODE"
												defaultValue="" onlyValue="true" codeName="GJSY"/></td>
										<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PAID_WAY" defaultValue="" onlyValue="true" codeName="JFFS"/></td>
										<td><BZ:data field="BILL_NO"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PAR_VALUE" defaultValue=""
												onlyValue="true" /></td>
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
								<td class="bz-edit-data-title" width="10%">Ʊ�ݷ���</td>
								<td class="bz-edit-data-value" width="15%"><%=li %></td> 
					 		</tr>
					 		<tr>
								<td class="bz-edit-data-title" width="10%">������</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="RECEIVER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">��������</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="RECEIVER_DATE" onlyValue="true"/></td>
							</tr>
							<tr> 
								<td class=bz-edit-data-title width="10%">�ƽ���</td>
								<td class="bz-edit-data-value" width="10%"><BZ:dataValue field="TRANSFER_USERNAME" defaultValue="" onlyValue="true"/></td> 
								<td class="bz-edit-data-title" width="10%">�ƽ�����</td>
								<td class="bz-edit-data-value" width="15%"><BZ:dataValue type="Date" field="TRANSFER_DATE" onlyValue="true"/></td> 
					 		</tr>
					 	</table>
					
					<!--���ӵ�������Ϣ��End-->
					<!-- ���ܰ�ť������Start -->
					<div class="table-row table-btns" style="text-align: center">
							<input
							type="button" value="��&nbsp;&nbsp;��"
							class="btn btn-sm btn-primary" onclick="_goback()" />
					</div>
					<div class="blue-hr"></div>
					<!-- ���ܰ�ť������End -->
				</div>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>