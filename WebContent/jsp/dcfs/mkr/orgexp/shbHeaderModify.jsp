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
    
    String id = (String)request.getAttribute("ID");
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
%>
<BZ:html>
<BZ:head>
	<title>������</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	//����iframe
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	function _save(){
    	//ҳ���У��
    	if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/orgexpmgr/headerModifySubmit.action";
	 		document.organForm.submit();
    	}
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="SEX;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- �����Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="ORG_" field="ID" defaultValue='<%=id %>'/>
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="NAME" defaultValue="" notnull="����������" style="width:90%" maxlength="20" prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title" rowspan="3">��Ƭ</td>
						<td class="bz-edit-data-value" rowspan="3">
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
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value">
							<BZ:select field="SEX" prefix="MKR_" width="100px"  formTitle="" codeName="SEX" isCode="true"></BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="BIRTHDAY"  style="width:100px" defaultValue="" type="date" prefix="MKR_" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְ��</td>
						<td class="bz-edit-data-value">
							<BZ:input field="POSITION"  style="width:90%" defaultValue="" prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE"  style="width:90%"  restriction="telephone" defaultValue="" prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" defaultValue=""  style="width:90%"  prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">�����ʼ�</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL"  style="width:90%"  defaultValue="" restriction="email" prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ҫ����</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_BRIEF_RESUME" rows="4" cols="85%"><%=data.getString("BRIEF_RESUME")!=null&&!"".equals(data.getString("BRIEF_RESUME"))?data.getString("BRIEF_RESUME"):"" %></textarea>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_REMO" rows="4" cols="85%"><%=data.getString("REMO")!=null&&!"".equals(data.getString("REMO"))?data.getString("REMO"):"" %></textarea>		
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
			<!-- <input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback()"/> -->
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
