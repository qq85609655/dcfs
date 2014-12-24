<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
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
    
%>
<BZ:html>
<BZ:head>
	<title>文件交接单打印</title>
	<BZ:webScript list="true" edit="true" tree="false" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//-----  下面是打印控制语句  ----------
	window.onbeforeprint=beforePrint;
	window.onafterprint=afterPrint;
	//打印之前隐藏不想打印出来的信息
	function beforePrint()
	{
		print1.style.display='none';
	}
	//打印之后将隐藏掉的信息再显示出来
	function afterPrint()
	{
		print1.style.display='';
	}
	function doPrint() 
		{ 
		       myDoc = { 
		                documents:document,  // 要打印的div 对象在本文档中，控件将从本文档中的 id 为 'page1' 的div对象，作为首页打印 
		                copyrights:'杰创软件拥有版权  www.jatools.com'
		                
		       }; 
		 
		       jatoolsPrinter.print(myDoc,true);   // 直接打印，不弹出打印机设置对话框       
		} 
</script>
</BZ:head>

<BZ:body property="transferFile_print_data" codeNames="WJLX;GJSY;SYZZ">
	
	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
                <!-- <button class="btn btn-sm btn-primary" onclick="beforePrint();javascript:window.print();afterPrint();">打印</button> -->
				<button class="btn btn-sm btn-primary" onclick="doPrint()">打印</button>
				<button class="btn btn-sm btn-primary" onclick="window.close();">关闭</button>
			</div>
			<div id='page1' autoBreakTable='BreakTable'>
            <div align="center"><font size="+2">交接文件</font>
            </div> 
            <div align="center"><font size="+1"><%=tc %></font></div>

			<div class="table-responsive">            	
                <table cellspacing="0" cellpadding="4" border="0" class='first-only'>
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">交接单编号：</td>
                        <td style="width:55%"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td>
                        <td style="width:15%" align="right">制表日期：</td>
                        <td style="width:15%"></td>
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
							adsorb="both" init="true" id="BreakTable" name="BreakTable">
							
								<tr>
									<th style="width:5%;">
										<div class="sorting_disabled">序号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="COUNTRY_CN">国家</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="NAME_CN">收养组织</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="REGISTER_DATE">收文日期</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FILE_NO">文件编号</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FILE_TYPE">文件类型</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="MALE_NAME">男收养人</div>
									</th>
									<th style="width:10%;">
										<div class="sorting" id="FEMALE_NAME">女收养人</div>
									</th>
									<%if("13".equals(code)){ %>
									<th style="width:10%;">
										<div class="sorting" id="NAME">特需儿童姓名</div>
									</th>
									<%} %>
									<th style="width:10%;">
										<div class="sorting" id="FEMALE_NAME">备注</div>
									</th>
								</tr>
							
								<BZ:for property="transferFile_print_list">
									<tr class="odd">
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
										<td><BZ:data field="NAME" defaultValue=""
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
   </div>
   <OBJECT ID="jatoolsPrinter" CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255" codebase="jp/jatoolsPrinter.cab#version=5,7,0,0"></OBJECT>
</BZ:body>
</BZ:html>
