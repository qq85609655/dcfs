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
    Data temp = (Data)request.getAttribute("temp");
    String pro_code = (String)temp.getString("pro_code");
    String type = (String)temp.getString("type");
    String ID = (String)temp.getString("ID");
    
%>
<BZ:html>
<BZ:head>
	<title>����������Ϣ�޸�</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	//�ύ����������Ϣ
	function _save(){
		//�����˱�ע
		var desc = document.getElementById("MKR_CONTACT_DESC").value;
		if(desc==""){
			alert("�����뾭���˱�ע��Ϣ");
			return false;
		}else{
			//if (_check(document.organForm)) {
				//ҳ���У��
				document.organForm.action=path+"mkr/organSupp/welfareModifySubmit.action?pro_code=<%=pro_code%>&type=<%=type%>&ID=<%=ID%>";
		 		document.organForm.submit();
			//}
		}
    }
	//����
	function _goback(){
		parent._goback();
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
					������Ϣά��
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-value" rowspan="6">
							��λ������Ϣ
						</td>
						<td class="bz-edit-data-title">��������</td>
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
							<BZ:input field="PRINCIPAL" defaultValue="" prefix="MKR_" maxlength="20" style="width:90%;"/>		
							<BZ:input field="INSTIT_ID" type="hidden" id="MKR_INSTIT_ID" defaultValue="" prefix="MKR_" />
							<BZ:input field="ID" type="hidden" id="MKR_ID" defaultValue="" prefix="MKR_" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="DEPT_ADDRESS_CN" defaultValue="" prefix="MKR_" maxlength="50" style="width:90%;"/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʱ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="DEPT_POST"  defaultValue=""  prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_TEL"  defaultValue="" restriction="telephone"  prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_FAX"  defaultValue=""  prefix="MKR_" />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-value" rowspan="4">
							������
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_NAME" style="width:90%;" notnull="�����뾭��������" defaultValue="" prefix="MKR_" maxlength="20"/>			
						</td>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="CONTACT_SEX" id="MKR_CONTACT_SEX" notnull="��ѡ�񾭰����Ա�" width="100px" isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="�Ա�" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���֤����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_CARD" notnull="�����뾭�������֤��" style="width:90%;" restriction="number" defaultValue="" prefix="MKR_"/>						
						</td>
						<td class="bz-edit-data-title">ְ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_JOB" style="width:90%;" notnull="�����뾭����ְ��" maxlength="50" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ϵ�绰</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_TEL" style="width:90%;" notnull="�����뾭������ϵ�绰" restriction="mobile" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_MAIL" style="width:90%;" notnull="�����뾭��������" restriction="email" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_CONTACT_DESC" id="MKR_CONTACT_DESC"  rows="4" cols="85%"><%=data.getString("CONTACT_DESC")!=null&&!"".equals(data.getString("CONTACT_DESC"))?data.getString("CONTACT_DESC"):""%></textarea>		
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
							<BZ:select disabled="true" field="PROVINCE_ID"  width="100px"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
							<BZ:input field="PROVINCE_ID" type="hidden" id="MKR_PROVINCE_ID" defaultValue="" prefix="MKR_" />
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="PRINCIPAL" defaultValue="" prefix="MKR_" maxlength="20" style="width:90%;"/>		
							<BZ:input field="INSTIT_ID" type="hidden" id="MKR_INSTIT_ID" defaultValue="" prefix="MKR_" />
							<BZ:input field="ID" type="hidden" id="MKR_ID" defaultValue="" prefix="MKR_" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ǽǵص�(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CITY_ADDRESS_CN" style="width:90%;" notnull="������Ǽǵص�" maxlength="50" defaultValue="" prefix="MKR_" id="MKR_CITY_ADDRESS_CN"/>					
						</td>
						<td class="bz-edit-data-title">�Ǽǵص�(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CITY_ADDRESS_EN" style="width:90%;" notnull="������Ǽǵص�" defaultValue="" prefix="MKR_" id="MKR_CITY_ADDRESS_EN"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_ADDRESS_CN" defaultValue="" prefix="MKR_" maxlength="50" style="width:90%;"/>				
						</td>
						<td class="bz-edit-data-title">��ַ(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_ADDRESS_EN" defaultValue="" prefix="MKR_"  style="width:90%;"/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʱ�</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_POST"  defaultValue=""  prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="DEPT_TEL"  defaultValue="" restriction="telephone"  prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_FAX"  defaultValue=""  prefix="MKR_" />			
						</td>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_NAME" style="width:90%;" notnull="�����뾭��������" defaultValue="" prefix="MKR_" maxlength="20"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����������ƴ��</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_NAMEPY" style="width:90%;" notnull="�����뾭��������ƴ��" defaultValue="" prefix="MKR_" maxlength="50"/>						
						</td>
						<td class="bz-edit-data-title">�������Ա�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="MKR_" field="CONTACT_SEX" id="MKR_CONTACT_SEX" notnull="��ѡ�񾭰����Ա�" width="100px" isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="�Ա�" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���������֤��</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_CARD" notnull="�����뾭�������֤��" style="width:90%;" restriction="number" defaultValue="" prefix="MKR_"/>						
						</td>
						<td class="bz-edit-data-title">������ְ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_JOB" style="width:90%;" notnull="�����뾭����ְ��" maxlength="50" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������ϵ�绰</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_TEL" style="width:90%;" notnull="�����뾭������ϵ�绰" restriction="mobile" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_MAIL" style="width:90%;" notnull="�����뾭��������" restriction="email" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����˱�ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_CONTACT_DESC" id="MKR_CONTACT_DESC"  rows="4" cols="85%"><%=data.getString("CONTACT_DESC")!=null&&!"".equals(data.getString("CONTACT_DESC"))?data.getString("CONTACT_DESC"):""%></textarea>		
						</td>
					</tr>

					<!-- 
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
						<td class="bz-edit-data-title">��ͣ������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PAUSE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					 
					<tr>
						<td class="bz-edit-data-title">�Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">�Ǽ�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CANCLE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>

					<tr>
						<td class="bz-edit-data-title">����޸�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MODIFY_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">����޸�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="MODIFY_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					 
					<tr>
						<td class="bz-edit-data-title">״̬</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="STATE" checkValue="0=����;1=��Ч;9=��ͣ;" onlyValue="true" defaultValue=''/>						
						</td>
					</tr>
					-->
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
