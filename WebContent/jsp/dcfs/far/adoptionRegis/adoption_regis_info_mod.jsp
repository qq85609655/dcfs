<%
/**   
 * @Title: adoption_regis_info_mod.jsp
 * @Description: �����Ǽ���Ϣ�޸�
 * @author xugy
 * @date 2014-9-23����8:21:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
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

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�����Ǽ���Ϣ�޸�</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//�ύ
function _submit(){
	//ҳ���У��
	/* if (!runFormVerify(document.srcForm, false)) {
		return;
	} */
	document.srcForm.action=path+"adoptionRegis/saveAdoptionRegInfo.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;ETSFLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_MARRYCOND;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="MI_" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="CI_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AF_" field="AF_ID" defaultValue=""/>
<BZ:input type="hidden" field="FILE_TYPE" defaultValue=""/><!-- �ļ����� -->
<BZ:input type="hidden" field="FAMILY_TYPE" defaultValue=""/><!-- �������� -->
<BZ:input type="hidden" field="ADOPTER_SEX" defaultValue=""/><!-- �������Ա� -->
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
							<BZ:select prefix="CI_" field="SEX" isCode="true" codeName="ETXB" defaultValue="" formTitle="�Ա�">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="BIRTHDAY" type="date" defaultValue="" formTitle="��������"/>
						</td>
						<td class="bz-edit-data-title">���֤��</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="ID_CARD" defaultValue="" formTitle="���֤��"/>
							
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="ѡ���ͯ���" treeType="-1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="CHILD_IDENTITY" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����ˣ����ģ�</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="SENDER" defaultValue="" formTitle="������"/>
						</td>
						<td class="bz-edit-data-title">�����ˣ�Ӣ�ģ�</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="SENDER_EN" defaultValue="" formTitle="������"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����˵�ַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="SENDER_ADDR" defaultValue="" formTitle="�����˵�ַ" style="width:98%;"/>
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
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="����" >
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" />
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="" defaultValue="�ѻ�"/>
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
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="����" >
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" />
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="" defaultValue="�ѻ�"/>
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
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="����" >
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="����" >
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ļ��̶�</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" formTitle="�Ļ��̶�">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" formTitle="�Ļ��̶�">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_JOB_CN" defaultValue="" formTitle="ְҵ" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_JOB_CN" defaultValue="" formTitle="ְҵ" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" formTitle="����״��">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" formTitle="����״��">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="�ѻ�"/>
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
							<BZ:input prefix="AF_" field="TOTAL_ASSET" defaultValue="" formTitle="���ʲ�" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ծ��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="TOTAL_DEBT" defaultValue="" formTitle="��ծ��" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="CHILD_CONDITION_CN" type="textarea" defaultValue="" style="width:98%;height:40px;" formTitle="��Ů���������" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��סַ</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="��ͥסַ" />
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
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="����" >
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" />
						</td>
						<td class="bz-edit-data-title">�Ļ��̶�</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" defaultValue="" formTitle="�Ļ��̶�">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_JOB_CN" defaultValue="" formTitle="ְҵ" />
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" formTitle="����״��">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
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
							<BZ:input prefix="AF_" field="TOTAL_ASSET" defaultValue="" formTitle="���ʲ�" />
						</td>
						<td class="bz-edit-data-title">��ծ��</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="TOTAL_DEBT" defaultValue="" formTitle="��ծ��" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="CHILD_CONDITION_CN" type="textarea" defaultValue="" style="width:98%;height:40px;" formTitle="��Ů���������" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="��ͥסַ" />
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
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="����" >
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" />
						</td>
						<td class="bz-edit-data-title">�Ļ��̶�</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" defaultValue="" formTitle="�Ļ��̶�">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_JOB_CN" defaultValue="" formTitle="ְҵ" />
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" formTitle="����״��">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
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
							<BZ:input prefix="AF_" field="TOTAL_ASSET" defaultValue="" formTitle="���ʲ�" />
						</td>
						<td class="bz-edit-data-title">��ծ��</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="TOTAL_DEBT" defaultValue="" formTitle="��ծ��" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="CHILD_CONDITION_CN" type="textarea" defaultValue="" style="width:98%;height:40px;" formTitle="��Ů���������" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="��ͥסַ" />
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
						<td class="bz-edit-data-title">�Ǽ�֤��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADREG_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">�뼮����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="CI_" field="NATION_DATE" type="date" defaultValue="" formTitle="�뼮����"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�����������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="CI_" field="CHILD_NAME_EN" defaultValue="" formTitle="�����������" />
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title">�Ǽ�״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_STATE" defaultValue="" onlyValue="true" checkValue="0=δ�Ǽ�;1=�ѵǼ�;2=��Ч�Ǽ�;3=ע��;"/>
							<BZ:input prefix="MI_" field="ADREG_STATE" type="hidden" defaultValue=""/>
							<BZ:input prefix="MI_" field="SIGN_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="MI_" field="ADREG_DATE" type="date" readonly="readonly" defaultValue="" formTitle="�Ǽ�����"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="MI_" field="ADREG_REMARKS" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="��ע"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
