<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    Data data = (Data)request.getAttribute("data");
    String pro_code = (String)request.getAttribute("pro_code");
%>
<BZ:html>
<BZ:head>
	<title>����������Ϣ�޸�</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['welfare','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	//����
	function _goback(){
		document.organForm.action=path+"mkr/organSupp/findWelfareByOrgan.action?ID=<%=pro_code%>";
 		document.organForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX;PROVINCE;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- �����Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					����������Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-value" style="width: 20%" rowspan="6">
							��λ������Ϣ
						</td>
						<td class="bz-edit-data-title" style="width:15%">��������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Ӣ������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ENNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PRINCIPAL" defaultValue=""/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_ADDRESS_CN" defaultValue="" onlyValue="true"/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʱ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_POST"  defaultValue="" onlyValue="true" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_TEL"  defaultValue=""  onlyValue="true"  />	
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_FAX" onlyValue="true" defaultValue=""  />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-value" style="width: 20%" rowspan="4">
							������
						</td>
						<td class="bz-edit-data-title" style="width:15%">����</td>
						<td class="bz-edit-data-value" style="width:20%">
							<BZ:dataValue field="CONTACT_NAME" onlyValue="true" style="width:90%;"  defaultValue="" />			
						</td>
						<td class="bz-edit-data-title" style="width:15%">�Ա�</td>
						<td class="bz-edit-data-value" style="width:20%">
							<BZ:select prefix="MKR_"  field="CONTACT_SEX" id="MKR_CONTACT_SEX" disabled="true"  isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="�Ա�" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���֤����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_CARD" onlyValue="true"  defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">ְ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_JOB" onlyValue="true" style="width:90%;"  defaultValue="" />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ϵ�绰</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_TEL" onlyValue="true" style="width:90%;"  defaultValue="" />						
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_MAIL" onlyValue="true" style="width:90%;"  defaultValue="" />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CONTACT_DESC" onlyValue="true" style="width:90%;"  defaultValue=""/>
						</td>
					</tr>
				</table>
				
			</div>
			
			<%-- <div class="bz-edit-data-content clearfix" desc="������">
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="15%" />
						<col width="20%" />
						<col width="15%" />
						<col width="20%" />
						<col width="15%" />
						<col width="15%"/>
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">��������(CN)</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Ӣ������(EN)</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ENNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ʡ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" />
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PRINCIPAL" defaultValue=""/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ǽǵص�(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CITY_ADDRESS_CN" style="width:90%;"  defaultValue="" />					
						</td>
						<td class="bz-edit-data-title">�Ǽǵص�(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CITY_ADDRESS_EN" style="width:90%;"  defaultValue=""/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_ADDRESS_CN" defaultValue="" />				
						</td>
						<td class="bz-edit-data-title">��ַ(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_ADDRESS_EN" defaultValue=""/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʱ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_POST"  defaultValue=""/>	
						</td>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_TEL"  defaultValue="" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_FAX"  defaultValue="" />			
						</td>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_NAME" style="width:90%;" defaultValue=""/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����������ƴ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_NAMEPY" style="width:90%;" defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">�������Ա�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���������֤��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_CARD" defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">������ְ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_JOB" style="width:90%;" defaultValue=""/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������ϵ�绰</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_TEL" style="width:90%;" defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_MAIL" style="width:90%;" defaultValue=""/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����˱�ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CONTACT_DESC" style="width:90%;"  defaultValue=""/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="STATE" onlyValue="true" checkValue="0=����;1=��Ч;9=��ͣ;" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">��ͣ������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PAUSE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͣ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CANCLE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CANCLE_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">�Ǽ�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CANCLE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">����޸�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="MODIFY_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����޸�����</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="MODIFY_DATE" onlyValue="true" defaultValue=''/>						
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div> --%>
		</div>
	</div>
	<!-- �����Ϣend -->
	
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_save();"/>
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
