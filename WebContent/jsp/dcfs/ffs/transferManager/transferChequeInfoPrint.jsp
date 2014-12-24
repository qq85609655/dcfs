<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:Ʊ�ݽ��Ӵ�ӡҳ��
	 * @author wty   
	 * @date 2014-11-24 14:14:22
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
	<title>���ú󱨸潻�ӵ���ӡ</title>
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
			<div id='PrintArea'>
            	<div align="center"><font size="+2"><span class="title3"><%=TransferCode.getPrintTitle0ByTransferCode(code) %></span></font>
            	</div> 
            	<div align="center"><font size="+1"><span class="title4"><%=TransferCode.getPrintTitleByTransferCode(code) %></span></font></div>

				<div>            	
                <table border="0">
                    <tr height="40px">
                        <td style="width:70%">���ӵ���ţ�<BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td>
                        <td style="width:30%">�Ʊ����ڣ�<%=DateUtility.getCurrentDate() %></td>
                    </tr>	
                </table>
				</div>
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
					<br>
					<%-- <p>��<%= sumTotal%>��</p> --%>
					
					<!--���ӵ�����б���End -->                
				</div>			
				<!--list:end-->
	
			<table border="0" style="width:100%">
                <tr>
                    <td style="width:70%;height: 40px">�ƽ��ˣ�_________________</td>
                    <td style="width:30%">�ƽ����ڣ�_________________</td>
                </tr>
                <tr>
                    <td style="height: 40px">�����ˣ�_________________</td>
                    <td>�������ڣ�_________________</td>
                </tr>							
            </table>
			<br>
			<p>��ע�����嵥�칫�ҡ����񲿸�����һ��</p>
			</div>
		</div>
		<br>
        <div class="blue-hr" id="print1" style="text-align:center;"> 
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">��ӡ</button>&nbsp;&nbsp;
			<button class="btn btn-sm btn-primary" onclick="_close()">�ر�</button>
		</div>
	</div>
   
</BZ:body>
<script>
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>
</BZ:html>