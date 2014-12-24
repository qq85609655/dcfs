<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:文件交接打印页面
	 * @author wty   
	 * @date 2014-7-29 10:44:22
	 * @version V1.0   
	 */
	
	//获取数据对象列表
    Data da=(Data)request.getAttribute("transferChildinfo_print_data");
    String tc ="";
    String code=da.getString("TRANSFER_CODE",TransferCode.CHILDINFO_AZB_DAB);
    DataList dlist = (DataList)request.getAttribute("transferChildinfo_print_list");
    int sumTotal = 0;
    int sumSpecial = 0;
    int sumNormal = 0;
    if(dlist!=null){
    	sumTotal = dlist.size();
    }
    for(int j=0;j<dlist.size();j++){
    	if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(dlist.getData(j).getString("CHILD_TYPE"))){
    		sumSpecial++;
    	}else{
    		sumNormal++;
    	}
    }
    
%>
<BZ:html>
<BZ:head>
	<title>材料交接单打印</title>
	<BZ:webScript list="true" edit="true" />
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
</BZ:head>
<script>
	function _close(){
		window.close();
	}
</script>
<BZ:body property="transferChildinfo_print_data" codeNames="WJLX;ETXB;PROVINCE;CHILD_TYPE">	
	<div class="page-content"  style="width:100%">
		<div class="wrapper">
			<div id='PrintArea'>
            	<div align="center"><font size="+2"><span class="title3"><%=TransferCode.getPrintTitle0ByTransferCode(code) %></span></font>
            	</div> 
            	<div align="center"><font size="+1"><span class="title4"><%=TransferCode.getPrintTitleByTransferCode(code) %></span></font></div>

				<div>            	
                <table border="0">
                    <tr height="40px">
                        <td style="width:70%">交接单编号：<BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td>
                        <td style="width:30%">制表日期：<%=DateUtility.getCurrentDate() %></td>
                    </tr>	
                </table>
				</div>
				<!--list:start-->
				<div class="table-responsive">
					<!--查询结果列表区Start -->
						
						<table class="table table-striped table-bordered table-hover dataTable table-print" border="1" adsorb="both" init="true" id="table" width="98%">							
								<thead>
								<tr>
									<th style="width:5%;">序号</th>
									<th style="width:5%;">国家</th>
									<th style="width:10%;">收养组织</th>
									<th style="width:10%;">文件编号</th>
									<th style="width:5%;">文件类型</th>
									<th style="width:10%;">儿童编号</th>
									<th style="width:5%;">省份</th>
									<th style="width:15%;">福利院</th>
									<th style="width:5%;">姓名</th>
									<th style="width:5%;">性别</th>
									<th style="width:12%;">出生日期</th>
									<th style="width:8%;">材料类型</th>
									<th style="width:8%;">特别关注</th>
									<th style="width:10%;">备注</th>
								</tr>
								</thead>
								<BZ:for property="transferChildinfo_print_list">
									<tr class="emptyData">
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="COUNTRY_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data codeName="WJLX" field="FILE_TYPE" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data  field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true" /></td>
										<td style="text-align:center">
										<BZ:data type="date" field="BIRTHDAY" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
										</td>
										<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true"/></td>
										<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
										<td>&nbsp;</td>
									</tr>
								</BZ:for>
						</table>
					<br>
					<p>共<%= sumTotal%>份，其中正常<%= sumNormal%>份，特需<%= sumSpecial%>份</p>
					
					<!--交接单结果列表区End -->                
				</div>			
				<!--list:end-->
	
			<table border="0" style="width:100%">
                <tr>
                    <td style="width:70%;height: 40px">移交人：_________________</td>
                    <td style="width:30%">移交日期：_________________</td>
                </tr>
                <tr>
                    <td style="height: 40px">接收人：_________________</td>
                    <td>接收日期：_________________</td>
                </tr>							
            </table>
			<br>
			<p>
			<%if(TransferCode.CHILDINFO_AZB_FYGS.equals(code)) {%>
			备注：本清单中国儿童福利和收养中心、翻译公司各保留一份
			<%} %>
			<%if(TransferCode.CHILDINFO_AZB_DAB.equals(code)) {%>
			备注：本清单安置部、档案部各存留一份
			<%} %>
			</p>
			</div>
		</div>
		<br>
        <div class="blue-hr" id="print1" style="text-align:center;"> 
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">打印</button>&nbsp;&nbsp;
			<button class="btn btn-sm btn-primary" onclick="_close()">关闭</button>
		</div>
	</div>
   
</BZ:body>
<script>
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>
</BZ:html>
