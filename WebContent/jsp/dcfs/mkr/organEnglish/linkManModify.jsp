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
    String ID = data.getString("ADOPT_ORG_ID","");  //��֯����ID
%>
<BZ:html>
<BZ:head>
	<title>��ϵ��ά��</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	//�ύ��ϵ����Ϣ
	function _save(){
		if (_check(document.organForm)) {
	    	//ҳ���У��
			document.organForm.action=path+"mkr/organSupp/linkManModifySubmitEn.action";
	 		document.organForm.submit();
		}
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX;GJ;ADOPTER_EDU;CARD_CODE;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- �����Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					��ϵ����ϢEnglish
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
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
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="NAME" defaultValue="" prefix="MKR_" maxlength="20" notnull="��������ϵ������" style="width:90%;"/>		
							<BZ:input field="ADOPT_ORG_ID" id="MKR_ADOPT_ORG_ID" type="hidden" defaultValue="" prefix="MKR_" maxlength="20" />
						</td>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="SEX" id="MKR_SEX" width="100px" isCode="true" notnull="��ѡ���Ա�" codeName="ADOPTER_CHILDREN_SEX" formTitle="�Ա�" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>				
						</td>
						<td colspan="2" rowspan="3">
							<up:uploadImage 
								attTypeCode="OTHER"
								id="MKR_PHOTO" 
								packageId='<%=data.getString("PHOTO") %>'
								name="MKR_PHOTO" 
								imageStyle="width:100px;height:100px;"
								autoUpload="true"
								hiddenSelectTitle="true"
								hiddenProcess="false"
								hiddenList="true"
								selectAreaStyle="border:0;width:100px;"
								proContainerStyle="width:100px;line-height:0px;"
								/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="BIRTHDAY" type="date" defaultValue="" style="width:100px;" prefix="MKR_" notnull="�������������" />	
							<BZ:input field="ID" defaultValue="" id="MKR_ID" prefix="MKR_" type="hidden"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_"  width="100px;"  field="COUNTRY_ID" id="MKR_COUNTRY_ID" isCode="true" codeName="GJ" formTitle="����" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���֤������</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" width="100px;" field="ID_TYPE" id="MKR_ID_TYPE" isCode="true" codeName="CARD_CODE" formTitle="���֤������" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>				
						</td>
						<td class="bz-edit-data-title">���֤������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ID_NUMBER" style="width:90%;" defaultValue="" prefix="MKR_" id="MKR_ID_NUMBER" restriction="number" maxlength="20"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ѧ��</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" width="100px;" field="EDUCATION" id="MKR_EDUCATION" isCode="true" codeName="ADOPTER_EDU" formTitle="ѧ��" defaultValue="">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>				
						</td>
						<td class="bz-edit-data-title">��ѧרҵ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="PROFESSIONAL" style="width:90%;" defaultValue="" prefix="MKR_" maxlength="20"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ҵԺУ</td>
						<td class="bz-edit-data-value">
							<BZ:input field="SCHOOL" style="width:90%;" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">��ϵ��ַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" style="width:90%;" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE" style="width:90%;" defaultValue="" prefix="MKR_" restriction="telephone"/>						
						</td>
						<td class="bz-edit-data-title">�ֻ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="MOBEL" style="width:90%;" defaultValue="" prefix="MKR_" restriction="mobile"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" style="width:90%;" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">�����ʼ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="EMAIL" style="width:90%;" defaultValue="" prefix="MKR_" restriction="email"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ��ְ</td>
						<td class="bz-edit-data-value">
							<BZ:select field="IS_TEMP_JOB" formTitle="" prefix="MKR_" width="100px;">
								<BZ:option value="">--��ѡ��--</BZ:option>
								<BZ:option value="0">��</BZ:option>
								<BZ:option value="1">��</BZ:option>
							</BZ:select>						
						</td>
						<td class="bz-edit-data-title">������λ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="WORK_UNIT" style="width:90%;" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ί������</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="COMMITMENT_BEGIN" style="width:100px;" type="date" id="MKR_COMMITMENT_BEGIN" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_COMMITMENT_END\\')}',readonly:true" defaultValue="" prefix="MKR_"/>
							~<BZ:input field="COMMITMENT_END"  style="width:100px;"  type="date" id="MKR_COMMITMENT_END"   dateExtend="minDate:'#F{$dp.$D(\\'MKR_COMMITMENT_BEGIN\\')}',readonly:true" defaultValue="" prefix="MKR_"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ί������</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_COMMITMENT_ITEM"  rows="4" cols="85%"><%=data.getString("COMMITMENT_ITEM")!=null&&!"".equals(data.getString("COMMITMENT_ITEM"))?data.getString("COMMITMENT_ITEM"):""%></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���˼���</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_PER_RESUME"  rows="4" cols="85%"><%=data.getString("PER_RESUME")!=null&&!"".equals(data.getString("PER_RESUME"))?data.getString("PER_RESUME"):""%></textarea>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_MEMO"  rows="4" cols="85%"><%=data.getString("MEMO")!=null&&!"".equals(data.getString("MEMO"))?data.getString("MEMO"):""%></textarea>		
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- �����Ϣend -->
	
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_save();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
