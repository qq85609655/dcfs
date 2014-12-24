<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: checkcollection_print.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-10-20 ����14:27:38 
 * @version V1.0   
 */
 
%>
<BZ:html>

<BZ:head language="CN">
	<title>�ļ��ɷ�֪ͨ����ӡ</title>
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
				<button class="btn btn-sm btn-primary" id="print_button" onclick="">��ӡ</button>&nbsp;
				<button class="btn btn-sm btn-primary" onclick="window.close();">�ر�</button>
			</div>
			<div id='PrintArea'>
            <div align="center"><font size="+2">�ļ��ɷ�֪ͨ��</font>
            </div> 
            <div align="center"><font size="+1">&nbsp;</font></div>

			<!--list:start-->
			<div class="table-responsive">
				<!--֪ͨ������б���Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							border="1"
							adsorb="both" init="true" id="table">
								<tr>
									<td width="15%" height="15px" align="right">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
									</td>
									<td align="right" width="15%">������֯</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">�ɷѷ�ʽ</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true" />
									</td>
									<td align="right">Ʊ����</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">�ɷѱ��</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true" />
									</td>
									<td align="right">�ɷ�Ʊ��</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">�߽ɱ��</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="R_PAID_NO" defaultValue="" onlyValue="true" />
									</td>
									<td align="right">�߽ɽ��</td>
									<td class="bz-edit-data-value" colspan="2">
										<BZ:dataValue field="R_PAID_SHOULD_NUM" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td height="15px" align="right">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										 ���
									</th>
									<th style="width:30%; text-align: center; vertical-align: middle;">
										�ļ����
									</th>
									<th style="width:15%; text-align: center; vertical-align: middle;">
										�Ǽ�����
									</th>
									<th style="width:20%; text-align: center; vertical-align: middle;">
										�ļ�����
									</th>
									<th style="width:20%; text-align: center; vertical-align: middle;">
										Ӧ�ɽ��
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
										<font size="2px"><strong>С��</strong></font>
									</td>
									<td class="bz-edit-data-value" style="border-top:none;">
										<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
						</table>
					</div>
					<!--֪ͨ������б���End -->
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
