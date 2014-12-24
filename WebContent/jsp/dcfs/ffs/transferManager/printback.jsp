<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:�ļ����Ӵ�ӡҳ��
	 * @author xxx   
	 * @date 2014-7-29 10:44:22
	 * @version V1.0   
	 */
	/******Java���빦������Start******/
	//��ȡ���ݶ����б�
    Data da=(Data)request.getAttribute("transferFile_print_data");
    String tc ="";
    String code=da.getString("TRANSFER_CODE",null);
    if(code!=null){
    	if("11".equals(code)){
    		tc="(�칫��-��֮��)";
    	}else if("12".equals(code)){
    		tc="(��֮��-��˲�)";
    	}else if("13".equals(code)){
    		tc="(��˲�-������)";
    	}
    }
    
%>
<BZ:html>
<BZ:head>
	<title>�ļ����ӵ���ӡ</title>
	<BZ:webScript list="true" edit="true" tree="false" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//-----  �����Ǵ�ӡ�������  ----------
	window.onbeforeprint=beforePrint;
	window.onafterprint=afterPrint;
	//��ӡ֮ǰ���ز����ӡ��������Ϣ
	function beforePrint()
	{
		print1.style.display='none';
	}
	//��ӡ֮�����ص�����Ϣ����ʾ����
	function afterPrint()
	{
		print1.style.display='';
	}
	function doPrint() 
		{ 
		       myDoc = { 
		                documents:document,  // Ҫ��ӡ��div �����ڱ��ĵ��У��ؼ����ӱ��ĵ��е� id Ϊ 'page1' ��div������Ϊ��ҳ��ӡ 
		                copyrights:'�ܴ����ӵ�а�Ȩ  www.jatools.com'
		                
		       }; 
		 
		       jatoolsPrinter.print(myDoc,true);   // ֱ�Ӵ�ӡ����������ӡ�����öԻ���       
		} 
</script>
</BZ:head>

<BZ:body property="transferFile_print_data" codeNames="WJLX;GJSY;SYZZ">
	
	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
                <!-- <button class="btn btn-sm btn-primary" onclick="beforePrint();javascript:window.print();afterPrint();">��ӡ</button> -->
				<button class="btn btn-sm btn-primary" onclick="doPrint()">��ӡ</button>
				<button class="btn btn-sm btn-primary" onclick="window.close();">�ر�</button>
			</div>
			<div id='page1' autoBreakTable='BreakTable'>
            <div align="center"><font size="+2">�����ļ�</font>
            </div> 
            <div align="center"><font size="+1"><%=tc %></font></div>

			<div class="table-responsive">            	
                <table cellspacing="0" cellpadding="4" border="0" class='first-only'>
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">���ӵ���ţ�</td>
                        <td style="width:55%"><BZ:dataValue field="CONNECT_NO" onlyValue="true"/></td>
                        <td style="width:15%" align="right">�Ʊ����ڣ�</td>
                        <td style="width:15%"></td>
                    </tr>	
                    <tr height="25px"></tr>							
                </table>						
			</div>
			
			<!--list:start-->
			<div class="table-responsive">
				<!--��ѯ����б���Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							adsorb="both" init="true" id="BreakTable" name="BreakTable">
							
								<tr>
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
									<%if("13".equals(code)){ %>
									<th style="width:10%;">
										<div class="sorting" id="NAME">�����ͯ����</div>
									</th>
									<%} %>
									<th style="width:10%;">
										<div class="sorting" id="FEMALE_NAME">��ע</div>
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
					<!--���ӵ�����б���End -->
                <table cellspacing="0" cellpadding="4" border="0" class="">
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">�ƽ��ˣ�</td>
                        <td style="width:45%">_________________</td>
                        <td style="width:15%" align="right">�ƽ����ڣ�</td>
                        <td style="width:25%">_________________</td>
                    </tr>
                    <tr height="25px"></tr>	
                    <tr>
                        <td style="width:15%" align="right">�����ˣ�</td>
                        <td style="width:45%">_________________</td>
                        <td style="width:15%" align="right">�������ڣ�</td>
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
