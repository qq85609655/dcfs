<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:����
 * @author xxx   
 * @date 2014-7-29 10:44:22
 * @version V1.0   
 */
    /******Java���빦������Start******/
 	//�������ݶ���
	Data data = (Data)request.getAttribute("data");
    if(data==null){
        data = new Data();
    }
	request.setAttribute("data",data);
	/******Java���빦������End******/
%>
<BZ:html>
<BZ:head>
	<title>�鿴</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	//});
	
	function _goback(){
		document.srcForm.action = path + "transferinfo/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�鿴</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					<td class="bz-edit-data-title" width="15%">���ӵ����</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONNECT_NO"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">����</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="COPIES"  defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">�ƽ���</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="TRANSFER_USERNAME"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">�ƽ�����</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="TRANSFER_DATE"  defaultValue="" onlyValue="true" type="Date" dateFormat="yyyy-MM-dd"/>
</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">������</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="RECEIVER_USERNAME"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">����ʱ��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="RECEIVER_DATE"  defaultValue="" onlyValue="true" type="Date" dateFormat="yyyy-MM-dd"/>
</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">�ƽ�״̬</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="AT_STATE" codeName="JJDZT" defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
				</table>
				</div>
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>