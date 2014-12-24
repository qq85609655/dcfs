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
	<title>文件缴费通知单打印</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
</BZ:head>

<script>
	
</script>

<BZ:body codeNames="GJSY;JFFS;WJLX" property="data">

	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
				<button class="btn btn-sm btn-primary" id="print_button" onclick="">打印</button>&nbsp;
				<button class="btn btn-sm btn-primary" onclick="window.close();">关闭</button>
			</div>
			<div id='PrintArea'>
            <div align="center"><font size="+2">文件缴费通知单</font>
            </div> 
            <div align="center"><font size="+1">&nbsp;</font></div>

			<!--list:start-->
			<div class="table-responsive">
				<!--通知单结果列表区Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							border="1"
							adsorb="both" init="true" id="table">
								<tr>
									<td width="15%" height="15px" align="right">国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
									</td>
									<td align="right" width="15%">收养组织</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">缴费方式</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true" />
									</td>
									<td align="right">票面金额</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">缴费编号</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true" />
									</td>
									<td align="right">缴费票号</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">催缴编号</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="R_PAID_NO" defaultValue="" onlyValue="true" />
									</td>
									<td align="right">催缴金额</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="R_PAID_SHOULD_NUM" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										 序号
									</th>
									<th style="width:30%; text-align: center; vertical-align: middle;">
										文件编号
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										登记日期
									</th>
									<th style="width:20%; text-align: center; vertical-align: middle;">
										文件类型
									</th>
									<th style="width:20%; text-align: center; vertical-align: middle;">
										应缴金额
									</th>
								</tr>
								
								<BZ:for property="fileList">
									<tr class="emptyData">
										<td class="center"><BZ:i /></td>
										<td class="center"><BZ:data field="FILE_NO"
												defaultValue="" onlyValue="true" /></td>
										<td class="center"><BZ:data field="REG_DATE" type="Date"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="FILE_TYPE" codeName="WJLX"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="AF_COST"
												defaultValue="" onlyValue="true" /></td>
									</tr>
								</BZ:for>
								<tr>
									<td class="bz-edit-data-value" colspan="4" style="text-align: center; border-top:none; height:35px;">
										<font size="2px"><strong>小计</strong></font>
									</td>
									<td class="bz-edit-data-value" style="border-top:none;">
										<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
						</table>
					</div>
					<!--通知单结果列表区End -->
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
