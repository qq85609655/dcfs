<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapprovesupplerecords_view.jsp
 * @Description: Ԥ�������¼�鿴 
 * @author yangrt
 * @date 2014-10-13
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������¼�鿴</title>
		<BZ:webScript list="true" edit="true"/>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
		</script>
	</BZ:head>
	<BZ:body>
		<%
	        DataList dl=(DataList)request.getAttribute("List");
	        if(dl.size()==0){%>
		          <br/>
		          <center><font color="red" size="2px">û�в����¼��</font></center>
       	<% 	}%>
		<BZ:for property="List" fordata="myData">
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div style="text-align: left;">
						<BZ:i/>��
						����֪ͨ�ˣ�<BZ:dataValue field="SEND_USERNAME" property="myData" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
						 ����֪ͨ���ڣ�<BZ:dataValue field="NOTICE_DATE" type="Date" property="myData" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
						����֪ͨ��Դ��<BZ:dataValue field="ADD_TYPE" property="myData" checkValue="1=��˲�;2=���ò�;" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">֪ͨ����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NOTICE_CONTENT" property="myData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">�ظ���</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="FEEDBACK_USERNAME" property="myData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�ظ�����</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="FEEDBACK_DATE" type="Date" property="myData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">����״̬</td>
							<td class="bz-edit-data-value" width="19%"> 
								<BZ:dataValue field="AA_STATUS" defaultValue="" property="myData" onlyValue="true" checkValue="0=������;1=������;2=�Ѳ���;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ظ�����(��)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADD_CONTENT_CN" defaultValue="" property="myData" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ظ�����(��)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADD_CONTENT_EN" defaultValue="" property="myData" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		</BZ:for>
	</BZ:body>
</BZ:html>