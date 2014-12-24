<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:Ʊ�ݽ��ӵ��鿴
	 * @author xugaoyang
	 * @date 2014-11-24
	 * @version V1.0   
	 */
	
	//��ȡ���ݶ����б�
    Data da=(Data)request.getAttribute("transferChequeinfo_print_data");
    String tc ="";
    String code=da.getString("TRANSFER_CODE",null);
    DataList dlist = (DataList)request.getAttribute("transferChequeinfo_print_list");
    int sumTotal = 0;
    int sumSpecial = 0;
    int sumNormal = 0;
    if(dlist!=null){
    	sumTotal = dlist.size();
    }
%>
<BZ:html>
<BZ:head>
	<title>Ʊ�ݽ��ӵ��鿴</title>
	<BZ:webScript list="true" edit="true" />
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
	
</BZ:head>
<script>
	function _close(){
		window.close();
	}
</script>
<BZ:body property="transferChequeinfo_print_data" codeNames="GJSY;JFFS;">	
	<div class="page-content"  style="width:100%">
		<div class="wrapper">

			
            <div align="center"><font size="+2"><span class="title3"><%=TransferCode.getPrintTitle0ByTransferCode(code) %></span></font>
            </div> 
            <div align="center"><font size="+1"><span class="title4"><%=TransferCode.getPrintTitleByTransferCode(code) %></span></font></div>
			
			<!--list:start-->
			<div class="table-responsive">
				<!--��ѯ����б���Start -->
					
					<table class="table table-striped table-bordered table-hover dataTable table-print" border="1" adsorb="both" init="true" id="table" width="98%">							
							<thead>
							<tr>
								<th style="width:5%;">���</th>
								<th style="width:15%;">�ɷѱ��</th>
								<th style="width:10%;">����</th>
								<th style="width:20%;">������֯</th>
								<th style="width:10%;">�ɷѷ�ʽ</th>
								<th style="width:15%;">Ʊ��</th>
								<th style="width:10%;">Ʊ����</th>
								<th style="width:15%;">��ע</th>
							</tr>
							</thead>
							<BZ:for property="transferChequeinfo_print_list">
								<tr class="emptyData">
									<td class="center"><BZ:i /></td>
									<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"/></td>
									<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="PAID_WAY" defaultValue="" onlyValue="true" codeName="JFFS"/></td>
									<td><BZ:data field="BILL_NO" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="REMARKS" defaultValue="" onlyValue="true" /></td>
								</tr>
							</BZ:for>
					</table>
					</div>
					
			</div>
			<!--list:end-->	

		<br>
        <div class="blue-hr" id="print1" style="text-align:center;"> 
			<button class="btn btn-sm btn-primary" onclick="_close()">�ر�</button>
		</div>
	</div>
   
</BZ:body>

</BZ:html>
