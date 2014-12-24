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
	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	String personName = SessionInfo.getCurUser().getPerson().getCName();
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
    
    //������Ŀ
    CodeList FWXMList = (CodeList)request.getAttribute("FWXMList");
%>
<BZ:html>
<BZ:head language="EN">
	<title>����ά��</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	
	//����iframe
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	function _save(){
    	//ҳ���У��
		/* if (!runFormVerify(document.srcFormForThreeLevel, false)) {
			return;
		} */
		document.organForm.action=path+"mkr/orgexpmgr/organModifySubmit.action";
 		document.organForm.submit();
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ZZHZZT;FWXM">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- �����Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- <div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					��֯������Ϣ
				</div>
			</div> -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="ORG_" field="ID" defaultValue='<%=data.getString("ID") %>'/>
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">��������<br>Name in Chinese</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CNAME" onlyValue="true" defaultValue='' />					
						</td>
						<td class="bz-edit-data-title" rowspan="3">��֯��ʶ<br>Agency logo</td>
						<td class="bz-edit-data-value" rowspan="3">
							<up:uploadImage 
								attTypeCode="OTHER"
								id="MKR_LOGO" 
								packageId='<%=data.getString("LOGO") %>'
								name="MKR_LOGO" 
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
						<td class="bz-edit-data-title">Ӣ������<br>Name in English</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENNAME" onlyValue="true" defaultValue='' />					
						</td>
					</tr>
					<!-- <tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<input type="button" value="�鿴" class="btn btn-sm btn-primary" onclick="_look();"/>				
						</td>
					</tr> -->
					<tr>
						<td class="bz-edit-data-title">����<br>Country</td>
						<td class="bz-edit-data-value">
							<BZ:select field="COUNTRY_CODE" width="100px" prefix="MKR_" isCode="true" codeName="GJList" formTitle="" disabled="true"></BZ:select>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��֯����<br>Agency code</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ORG_CODE" defaultValue="" style="width:70%" restriction="number" prefix="ORG_" maxlength="20" readonly="true"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ڵ���<br>Region</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="PLACE_AREA"  defaultValue="" prefix="MKR_" maxlength="20" style="width:70%;"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��֯����ʱ��<br>Date of establishment</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FOUNDED_DATE" style="width:100px" id="MKR_FOUNDED_DATE" dateExtend="lang:'en'"  defaultValue="" type="date" prefix="MKR_" />					
						</td>
						<td class="bz-edit-data-title">��չ�й���Ŀʱ��<br>Starting date of China program</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CNSTART_DATE" style="width:100px" id="MKR_CNSTART_DATE" dateExtend="lang:'en'"  defaultValue="" type="date" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ί�л�Լ��֤��Ч����<br>Accreditation effective date</td>
						<td class="bz-edit-data-value">
							<BZ:input field="LICENSE_STARTVALID" style="width:100px" defaultValue="" id="MKR_LICENSE_STARTVALID" type="date" prefix="MKR_" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_LICENSE_VALID\\')}',readonly:true,lang:'en'" />
						</td>
						<td class="bz-edit-data-title">����ί�л�Լ��֤ʧЧ����<br>Accreditation expiration date</td>
						<td class="bz-edit-data-value">
							<BZ:input field="LICENSE_VALID" id="MKR_LICENSE_VALID" style="width:100px" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_LICENSE_STARTVALID\\')}',readonly:true,lang:'en'" defaultValue="" type="date" prefix="MKR_"/>			
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܲ���ַ<br>Headquarters address</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="HEADQUARTER_ADDRESS"  defaultValue="" prefix="MKR_" style="width:70%;"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʼĵ�ַ<br>Postal address</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="MAILING_ADDRESS" defaultValue="" prefix="MKR_" style="width:70%;"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�绰<br>Telephone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TEL" defaultValue="" style="width:90%" prefix="MKR_" restriction="telephone"/>					
						</td>
						<td class="bz-edit-data-title">����<br>Fax</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" defaultValue="" style="width:90%" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ<br>Website</td>
						<td class="bz-edit-data-value">
							<BZ:input field="WEBSITE" style="width:90%" defaultValue="" prefix="MKR_" />					
						</td>
						<td class="bz-edit-data-title">�����ʼ�<br>Email</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL" style="width:90%" defaultValue="" restriction="email" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ί�л���֤����<br>Entrusting or accreditating authority</td>
						<td class="bz-edit-data-value">
							<BZ:input field="AUTHOR_DEPARTMENT" style="width:90%" defaultValue="" prefix="MKR_" />					
						</td>
						<td class="bz-edit-data-title">������Ŀ<br>Service program type</td>
						<td class="bz-edit-data-value">
							<%
								if(FWXMList != null && FWXMList.size() > 0){
									String ser = data.getString("SERVICE");
									String serv = new String();
									if(ser!=null && !"".equals(ser)){
										serv = ser;
									}
									for(int i = 0; i < FWXMList.size(); i ++){
										Code code = FWXMList.get(i);
							%>
							<input type="checkbox" name="MKR_SERVICE" <%=serv.contains(code.getValue())?"checked='checked'":"" %> value="<%=code.getValue() %>"><%=code.getName() %>
							<%
									}
								}
							%>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������������<br>Other collaborating counties</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="OTHER_COUNTRY" style="width:70%" defaultValue="" prefix="MKR_" />					
						</td>
						<%-- <td class="bz-edit-data-title">��֯����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:select field="STATE" width="100px" formTitle="" prefix="MKR_" isCode="true" codeName="ZZHZZT"></BZ:select>
						</td> --%>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">Ԥ���Ƿ���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="MKR_" field="TRANS_FLAG" id="MKR_TRANS_FLAG" width="150px" formTitle="Ԥ���Ƿ���">
								<BZ:option value="">--Please select--</BZ:option>
	                            <BZ:option value="0">��(NO)</BZ:option>
	                            <BZ:option value="1">��(YES)</BZ:option>
	                        </BZ:select>		
						</td>
					</tr> --%>
					<tr>
						<td class="bz-edit-data-title">��ע<br>Remarks</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_REMARK" rows="4" cols="85%"><%=data.getString("REMARK")!=null&&!"".equals(data.getString("REMARK"))?data.getString("REMARK"):"" %></textarea>		
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
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save();"/>
			<!-- <input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback()"/> -->
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
