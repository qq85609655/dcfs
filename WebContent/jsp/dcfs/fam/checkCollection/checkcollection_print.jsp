<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: checkcollection_print.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-10-20 下午14:27:38 
 * @version V1.0   
 */
 
%>
<BZ:html>

<BZ:head language="CN">
	<title>托收单打印</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
</BZ:head>

<script>
	
</script>

<BZ:body codeNames="GJSY" property="data">

	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
				<button class="btn btn-sm btn-primary" id="print_button" onclick="">打印</button>&nbsp;
				<button class="btn btn-sm btn-primary" onclick="window.close();">关闭</button>
			</div>
			<div id='PrintArea'>
            <div align="center"><font size="+2">支票托收表</font>
            </div> 
            <div align="center"><font size="+1">&nbsp;</font></div>

			<div class="table-responsive">            	
                <table cellspacing="0" cellpadding="4" border="0">
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">托收人：</td>
                        <td style="width:45%"><BZ:dataValue field="COL_USERNAME" onlyValue="true"/></td>
                        <td style="width:20%" align="right">托收日期：</td>
                        <td style="width:20%"><BZ:dataValue field="COL_DATE" onlyValue="true" type="date"/></td></td>
                    </tr>	
                    <tr height="25px"></tr>							
                </table>						
			</div>
			
			<!--list:start-->
			<div class="table-responsive">
				<!--托收单结果列表区Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							border="1"
							adsorb="both" init="true" id="table">
							
								<tr>
									<th style="width:5%; text-align: center; vertical-align: middle;">
										 序号
									</th>
									<th style="width:8%; text-align: center; vertical-align: middle;">
										国家
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										收养组织
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										缴费编号
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										支票票号
									</th>
									<th style="width:12%; text-align: center; vertical-align: middle;">
										票面金额
									</th>
									<th style="width:30%; text-align: center; vertical-align: middle;">
										备注
									</th>
								</tr>
								
								<BZ:for property="List">
									<tr class="emptyData">
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="COUNTRY_CODE" codeName="GJSY"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN" 
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PAID_NO" 
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="BILL_NO"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="PAR_VALUE" 
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="COLLECTION_REMARKS" 
												defaultValue="" onlyValue="true" /></td>
									</tr>
								</BZ:for>
								<tr>
									<td class="bz-edit-data-value" colspan="5" style="text-align: center; border-top:none; height:35px;">
										<font size="2px"><strong>合计</strong></font>
									</td>
									<td class="bz-edit-data-value" style="border-top:none;">
										<BZ:dataValue field="SUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-value" style="border-top:none;">
									</td>
								</tr>
						</table>
					</div>
					<!--托收单结果列表区End -->
                <table cellspacing="0" cellpadding="4" border="0" class="">
                	<tr height="25px"></tr>
                	<tr>&nbsp;</tr>
                    <tr>
                        <td style="width:15%" align="right">制表人：</td>
                        <td style="width:45%">_________________</td>
                        <td style="width:15%" align="right">制表日期：</td>
                        <td style="width:25%">_________________</td>
                    </tr>
                </table>
			</div>
			<!--list:end-->	
			</div>
		</div>
	</div>
</BZ:body>
<script>
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>
</BZ:html>
