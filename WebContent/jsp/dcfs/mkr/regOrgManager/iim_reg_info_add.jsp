<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:����
 * @author wangzheng
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
	<title>���</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	//});
	
	function _submit() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "/mkr/regOrgManager/save.action";
			document.srcForm.submit();
		  }
	}
	
	function _goback(){
		document.srcForm.action = path + "/mkr/regOrgManager/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" codeNames="PROVINCE;SEX">
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input prefix="P_" field="RI_ID" type="hidden" defaultValue=""/>
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
					<td class="bz-edit-data-value" colspan="3">
						<BZ:select prefix="P_" field="PROVINCE_ID" id="P_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="ʡ��" defaultValue="" width="245px" notnull="ʡ�ݲ���Ϊ�գ�">
							<BZ:option value="">--��ѡ��--</BZ:option>
						</BZ:select>
						</td> 
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">��������<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="NAME_CN" id="P_NAME_CN" defaultValue="" className="inputOne" formTitle="��������" restriction="hasSpecialChar" notnull="�������Ʋ���Ϊ�գ�" size="50" maxlength="100"/>
						</td> 
					 <td class="bz-edit-data-title" width="15%">Ӣ������<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="NAME_EN" id="P_NAME_EN" defaultValue="" className="inputOne" formTitle="Ӣ������" restriction="hasSpecialChar" notnull="�������Ʋ���Ϊ�գ�" size="50" maxlength="100"/>
						</td>
					 </tr>
					 <tr>
					 <td class="bz-edit-data-title" width="15%">�Ǽǵص�<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CITY_ADDRESS_CN" id="P_CITY_ADDRESS_CN" defaultValue="" className="inputOne" formTitle="�Ǽǵص�_����" notnull="�Ǽǵص㲻��Ϊ�գ�" restriction="hasSpecialChar" size="50"  maxlength="100"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">�Ǽǵص㣨Ӣ�ģ�<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CITY_ADDRESS_EN" id="P_CITY_ADDRESS_EN" defaultValue="" className="inputOne" formTitle="�Ǽǵص�_Ӣ��" notnull="�Ǽǵص㲻��Ϊ�գ�" restriction="hasSpecialChar" size="50"  maxlength="100"/>
						</td> 					
					 </tr>
					 <tr>
					 
					<td class="bz-edit-data-title" width="15%">��ַ</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="DEPT_ADDRESS_CN" id="P_DEPT_ADDRESS_CN" defaultValue="" className="inputOne" formTitle="��ַ_����" restriction="hasSpecialChar" size="50" maxlength="120"/>
						</td> 

					<td class="bz-edit-data-title" width="15%">��ַ��Ӣ�ģ�</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="DEPT_ADDRESS_EN" id="P_DEPT_ADDRESS_EN" defaultValue="" className="inputOne" formTitle="��ַ_Ӣ��" restriction="hasSpecialChar" size="50" maxlength="120"/>
						</td> 
					</tr>
					<tr>
						<td class="bz-edit-data-title" colspan="4" style="text-align:center"><b>�����ǼǾ�������Ϣ</b></td>
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">����<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_NAME" id="P_CONTACT_NAME" defaultValue="" className="inputOne" formTitle="������_����" restriction="hasSpecialChar" notnull="��������������Ϊ�գ�" size="50" maxlength="30"/>
						</td> 

					<td class="bz-edit-data-title" width="15%">����ƴ��<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_NAMEPY" id="P_CONTACT_NAMEPY" defaultValue="" className="inputOne" formTitle="������_����ƴ��" restriction="hasSpecialChar" notnull="����������ƴ������Ϊ�գ�" size="50" maxlength="200"/>
						</td> 
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">�Ա�<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:select prefix="P_" field="CONTACT_SEX" id="P_CONTACT_SEX" isCode="true" codeName="SEX" formTitle="�Ա�" defaultValue="" width="245px" notnull="�Ա���Ϊ�գ�">
							<BZ:option value="">--��ѡ��--</BZ:option>
						</BZ:select>
					 </td>
					 
					<td class="bz-edit-data-title" width="15%">���֤��<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_CARD" id="P_CONTACT_CARD" defaultValue="" className="inputOne" formTitle="������_���֤��" restriction="hasSpecialChar" notnull="���������֤�Ų���Ϊ�գ�" size="50" maxlength="64"/>
						</td>
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">ְ��<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_JOB" id="P_CONTACT_JOB" defaultValue="" className="inputOne" formTitle="������_ְ��" restriction="hasSpecialChar" notnull="������ְ����Ϊ�գ�" size="50"  maxlength="64"/>
						</td> 
					
					<td class="bz-edit-data-title" width="15%">��ϵ�绰<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_TEL" id="P_CONTACT_TEL" defaultValue="" className="inputOne" formTitle="������_��ϵ�绰" restriction="hasSpecialChar" notnull="��������ϵ�绰����Ϊ�գ�" size="50" maxlength="100"/>
						</td> 
						 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">����<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:input prefix="P_" field="CONTACT_MAIL" id="P_CONTACT_MAIL" defaultValue="" className="inputOne" formTitle="������_����"  notnull="���������䲻��Ϊ�գ�" size="50" maxlength="100"/>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">��ע</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:input prefix="P_" field="CONTACT_DESC" id="P_CONTACT_DESC" defaultValue="" className="inputOne" formTitle="������_��ע" restriction="hasSpecialChar" size="120"  maxlength="1000"/>
						</td> 
					 </tr>
				</table>
				</div>
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>