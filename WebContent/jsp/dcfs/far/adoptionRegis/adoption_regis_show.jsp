<%
/**   
 * @Title: adoption_regis_show.jsp
 * @Description: �����Ǽǲ鿴
 * @author xugy
 * @date 2014-9-23����9:25:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");
//�ļ�����
String FILE_TYPE = data.getString("FILE_TYPE");
//��������
String FAMILY_TYPE = data.getString("FAMILY_TYPE");
//�������Ա�
String ADOPTER_SEX = data.getString("ADOPTER_SEX");
%>
<BZ:html>
<BZ:head>
	<title>�����Ǽǲ鿴</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;ETSFLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_MARRYCOND;">
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���֤��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ID_CARD" defaultValue="" onlyValue="true"/>
							
						</td>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����˵�ַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<%
					if("33".equals(FILE_TYPE)){//����Ů����
					    if("1".equals(ADOPTER_SEX)){//��������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="��" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="" defaultValue="�ѻ�" onlyValue="true"/>
						</td>
					</tr>
					<%
					    }
					    if("2".equals(ADOPTER_SEX)){//Ů������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="Ů" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="" defaultValue="�ѻ�" onlyValue="true"/>
						</td>
					</tr>
					<%        
					    }
					}else{//�Ǽ���Ů����
					    if("1".equals(FAMILY_TYPE)){//˫������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%"></td>
						<td class="bz-edit-data-title" width="40%" style="text-align: center;"><b>��������</b></td>
						<td class="bz-edit-data-title" width="40%" style="text-align: center;"><b>Ů������</b></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ļ��̶�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="�ѻ�" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ҵ�λ</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ʲ�</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ծ��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��סַ</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%
					    }
						if("2".equals(FAMILY_TYPE)){//��������
						    if("1".equals(ADOPTER_SEX)){//��������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ļ��̶�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MARRY_CONDITION" defaultValue="" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
						</td>
						<td class="bz-edit-data-title">���ҵ�λ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ʲ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ծ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%	        
						    }
							if("2".equals(ADOPTER_SEX)){//Ů������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="��" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ļ��̶�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MARRY_CONDITION" defaultValue="" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
						</td>
						<td class="bz-edit-data-title">���ҵ�λ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ʲ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ծ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%		    
							}
						}
					}
					%>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����Ǽ���Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%">�Ǽ�֤��</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ADREG_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�����������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="CHILD_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%
					String ADREG_STATE = data.getString("ADREG_STATE", "");
					if("2".equals(ADREG_STATE)){
					%>
					<tr>
						<td class="bz-edit-data-title">�Ǽ�״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_STATE" defaultValue="" onlyValue="true" checkValue="2=��Ч�Ǽ�"/>
						</td>
						<td class="bz-edit-data-title">��ͥ������������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DEAL_TYPE" defaultValue="" onlyValue="true" checkValue="0=������������;1=��ͥ�˳�����;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ч�Ǽ�ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADREG_INVALID_REASON" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%    
					}else{
					%>
					<tr>
						<td class="bz-edit-data-title">�Ǽ�״̬</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADREG_STATE" defaultValue="" onlyValue="true" checkValue="0=δ�Ǽ�;1=�ѵǼ�;"/>
						</td>
					</tr>
					<%    
					}
					%>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADREG_REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
