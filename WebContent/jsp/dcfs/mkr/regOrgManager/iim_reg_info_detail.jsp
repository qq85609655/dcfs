<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:����
 * @author xxx   
 * @date 2014-9-30 12:23:32
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
		document.srcForm.action = path + "/mkr/regOrgManager/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" codeNames="PROVINCE;SEX">
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����Ǽǻ�����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					<td class="bz-edit-data-title" width="15%">ʡ��</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:dataValue field="PROVINCE_ID"  defaultValue="" codeName="PROVINCE" onlyValue="true"/>
						</td>
					</tr>
					<tr> 
					<td class="bz-edit-data-title" width="15%">��������</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="NAME_CN"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">Ӣ������</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="NAME_EN"  defaultValue="" onlyValue="true"/>
						</td>
					 </tr>
					 <tr>
					 <td class="bz-edit-data-title" width="15%">�Ǽǵص�</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CITY_ADDRESS_CN"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">�Ǽǵص�_Ӣ��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CITY_ADDRESS_EN"  defaultValue="" onlyValue="true"/>
						</td>					
					 </tr>
					 <tr>					 
					<td class="bz-edit-data-title" width="15%">��ַ</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="DEPT_ADDRESS_CN"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">��ַ��Ӣ�ģ�</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="DEPT_ADDRESS_EN"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					<tr>
						<td class="bz-edit-data-title" colspan="4" style="text-align:center"><b>�����ǼǾ�������Ϣ</b></td>
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">����</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_NAME"  defaultValue="" onlyValue="true"/>
						</td> 

					<td class="bz-edit-data-title" width="15%">����ƴ��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_NAMEPY"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">�Ա�</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_SEX" codeName="SEX" defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">���֤��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_CARD"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">ְ��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_JOB"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">��ϵ�绰</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_TEL"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">����</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:dataValue field="CONTACT_MAIL"  defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">������_��ע</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:dataValue field="CONTACT_DESC"  defaultValue="" onlyValue="true"/>
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