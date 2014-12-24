<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapproveauditrecords_list.jsp
 * @Description: Ԥ��������˼�¼�б� 
 * @author yangrt
 * @date 2014-10-13
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ��������˼�¼�б�</title>
		<BZ:webScript list="true"/>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
		</script>
	</BZ:head>
	<BZ:body>
		<div class="page-content">
			<div class="wrapper">
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="AUDIT_TYPE">�������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="AUDIT_LEVEL">��˼���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AUDIT_USERNAME">�����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AUDIT_DATE">�������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AUDIT_OPTION">��˽��</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled" id="AUDIT_CONTENT_CN">������</div>
								</th>
								<th style="width: 30%;">
									<div class="sorting_disabled" id="AUDIT_REMARKS">��ע</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="AUDIT_TYPE" checkValue="1=��˲�;2=���ò�;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_LEVEL" checkValue="0=���������;1=�����������;2=�ֹ���������;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<%
								String type = ((Data)pageContext.getAttribute("myData")).getString("AUDIT_TYPE","");
								if("1".equals(type)){
							%>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="1=�ϱ�;2=ͨ��;3=��ͨ��;4=������Ϣ;7=�˻�����;8=�˻ؾ�����;"/></td>
							<%	}else{ %>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="2=���ͨ��;3=��˲�ͨ��;4=������Ϣ;"/></td>
							<%	} %>
								
								<td><BZ:data field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_REMARKS" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</BZ:body>
</BZ:html>