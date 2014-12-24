<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: ������˽���б�
 * @author wangzheng   
 * @date 2014-9-19
 * @version V1.0   
 */
  String path = request.getContextPath();
%>

<BZ:html>
	<BZ:head>
		<title>������˽���б�</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	
<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
 
</script>
	<BZ:body codeNames="ETCLSHJG_ALL">
    
    <div class="wrapper">		
		<div class="blue-hr"></div>
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th style="width:5%;">���</th>
					<th style="width:10%;">��˼���</th>
					<th style="width:10%;">�����</th>
					<th style="width:10%;">�������</th>
					<th style="width:10%;">��˽��</th>
					<th style="width:30%;">������</th>
					<th style="width:25%;">��ע</th>
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr>
							<td class="center">
								<BZ:i/>
							</td>
							<td align="center"><BZ:data field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="2=ʡ��;3=����"/></td>
							<td><BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUDIT_OPTION" codeName="ETCLSHJG_ALL" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUDIT_CONTENT" defaultValue=""/></td>
							<td align="center"><BZ:data field="AUDIT_REMARKS" defaultValue=""/></td>							
						</tr>
					</BZ:for>
				</tbody>
			</table>
		</div>		
	</div>

</BZ:body>
</BZ:html>
