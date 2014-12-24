<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: cmsAzbCljs_print.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-10-26 ����15:56:21 
 * @version V1.0   
 */
 
%>
<BZ:html>

<BZ:head language="CN">
	<title>�����ӡ</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
</BZ:head>

<script>
	
</script>

<BZ:body codeNames="ETXB;PROVINCE">

	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
				<button class="btn btn-sm btn-primary" id="print_button" onclick="">��ӡ</button>&nbsp;
				<button class="btn btn-sm btn-primary" onclick="window.close();">�ر�</button>
			</div>
			<div id='PrintArea'>
            <div align="center"><font size="+2">����Ԥ��</font>
            </div> 
            <div align="center"><font size="+1">&nbsp;</font></div>

			<!--list:start-->
			<div class="table-responsive">
				<!--��ͯ��Ϣ����б���Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							border="1"
							adsorb="both" init="true" id="table">
							
								<tr>
									<th style="width:5%; text-align: center; vertical-align: middle;">
										 ���
									</th>
									<th style="width:8%; text-align: center; vertical-align: middle;">
										ʡ��
									</th>
									<th style="width:17%; text-align: center; vertical-align: middle;">
										����Ժ
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										����
									</th>
									<th style="width:10%; text-align: center; vertical-align: middle;">
										�Ա�
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										��������
									</th>
									<th style="width:10%; text-align: center; vertical-align: middle;">
										�Ƿ�����ƻ�
									</th>
									<th style="width:20%; text-align: center; vertical-align: middle;">
										����
									</th>
								</tr>
								
								<BZ:for property="list" fordata="fordata">
									<script type="text/javascript">
										<%
										String child_no = ((Data)pageContext.getAttribute("fordata")).getString("CHILD_NO","");
										%>
									</script>
									<tr class="emptyData">
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="WELFARE_NAME_CN" 
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="NAME" 
												defaultValue="" onlyValue="true" /></td>
										<td class="center"><BZ:data field="SEX" codeName="ETXB"
												defaultValue="" onlyValue="true" /></td>
										<td class="center"><BZ:data field="BIRTHDAY" type="date"
												defaultValue="" onlyValue="true" /></td>
										<td class="center"><BZ:data field="IS_PLAN" checkValue="0=��;1=��;"
												defaultValue="" onlyValue="true" /></td>
										<td><img src="<%=request.getContextPath() %>/barcode?msg=<%=child_no %>" height="60px" width=115px/></td>
									</tr>
								</BZ:for>
						</table>
					</div>
					<!--��ͯ��Ϣ����б���End -->
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
