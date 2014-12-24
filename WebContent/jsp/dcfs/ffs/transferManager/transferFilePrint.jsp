<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ page import="com.hx.framework.util.UtilDate" %>
<%@ page import="com.hx.upload.utils.UtilDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page import="hx.util.DateUtility" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:文件交接打印页面
	 * @author xxx   
	 * @date 2014-7-29 10:44:22
	 * @version V1.0   
	 */
	/******Java代码功能区域Start******/
	//获取数据对象列表
    Data da=(Data)request.getAttribute("transferFile_print_data");
    String tc ="";
    String code=da.getString("TRANSFER_CODE",null);
    if(code!=null){
    	if("11".equals(code)){
    		tc="(办公室-爱之桥)";
    	}else if("12".equals(code)){
    		tc="(爱之桥-审核部)";
    	}else if("13".equals(code)){
    		tc="(审核部-档案部)";
    	}
    }

	String curDate = DateUtility.getCurrentDate();//获得当前日期
    
%>
<BZ:html>
<BZ:head>
	<title>文件交接单打印</title>
	<BZ:webScript list="true" edit="true" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
</BZ:head>

<BZ:body property="transferFile_print_data" codeNames="WJLX;GJSY;SYZZ">
	
	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
				<button class="btn btn-sm btn-primary" id="print_button" onclick="">打印</button>&nbsp;&nbsp;
				<button class="btn btn-sm btn-primary" onclick="window.close();">关闭</button>
			</div>
			<div id='PrintArea'>
            <div align="center"><font size="4px">文件交接单</font>
            </div> 
            <div align="center"><font size="3px"><%=tc %></font></div>

			<div class="table-responsive">            	
                <table cellspacing="0" cellpadding="4" border="0">
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">编号：</td>
                        <td style="width:55%"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td>
                        <td style="width:15%" align="right">制表日期：</td>
                        <td style="width:15%"><%=curDate%></td>
                    </tr>	
                    <tr height="25px"></tr>							
                </table>						
			</div>
			
			<!--list:start-->
			<div class="table-responsive">
				<!--查询结果列表区Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							border="1"
							adsorb="both" init="true" id="table">
							
								<tr>
									<th style="width:5%;" nowrap>
										 序号
									</th>
									<th style="width:10%;" nowrap>
										国家
									</th>
									<th style="width:10%;" nowrap>
										收养组织
									</th>
									<th style="width:10%;" nowrap>
										收文日期
									</th>
									<th style="width:10%;" nowrap>
										文件编号
									</th>
									<th style="width:10%;" nowrap>
										文件类型
									</th>
									<th style="width:10%;" nowrap>
										男收养人
									</th>
									<th style="width:10%;" nowrap>
										女收养人
									</th>
									<%if("13".equals(code)){ %>
									<th style="width:10%;" nowrap>
										特需儿童姓名
									</th>
									<%} %>
									<th style="width:10%;" nowrap>
										备注
									</th>
								</tr>
								
								<BZ:for property="transferFile_print_list">
									<tr class="emptyData">
										<td class="center"><BZ:i />
										</td>
										<td><BZ:data field="COUNTRY_CN"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME_CN"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data type="date" field="REGISTER_DATE"
												dateFormat="yyyy-MM-dd" defaultValue="" 
onlyValue="true" />
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
										<td><BZ:data field="NAME_CN" defaultValue=""
												onlyValue="true" /></td>
										<%} %>
										<td></td>
									</tr>
								</BZ:for>
							
						</table>
					</div>
					<!--交接单结果列表区End -->
                <table cellspacing="0" cellpadding="4" border="0" class="">
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">移交人：</td>
                        <td style="width:45%">_________________</td>
                        <td style="width:15%" align="right">移交日期：</td>
                        <td style="width:25%">_________________</td>
                    </tr>
                    <tr height="25px"></tr>	
                    <tr>
                        <td style="width:15%" align="right">接收人：</td>
                        <td style="width:45%">_________________</td>
                        <td style="width:15%" align="right">接收日期：</td>
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
