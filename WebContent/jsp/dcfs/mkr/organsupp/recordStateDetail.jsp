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
	
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
    
    //������Ŀ
    CodeList FWXMList = (CodeList)request.getAttribute("FWXMList");
%>
<BZ:html>
<BZ:head>
	<title>����ά��</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	
	//����iframe
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	//������֯���������б�
	function _goback(){
		document.organForm.action=path+"mkr/organSupp/organRecordStateList.action";
		document.organForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ZZHZZT;FWXM;ZZBASHZT">
	<BZ:form name="organForm" method="post">
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
						<td class="bz-edit-data-title">��������(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CNAME" onlyValue="true" defaultValue='' />					
						</td>
						<td class="bz-edit-data-title">Ӣ������(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENNAME" onlyValue="true" defaultValue='' />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORG_CODE" defaultValue=""/>					
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE"  defaultValue="" codeName="GJList" />		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ڵ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PLACE_AREA" defaultValue=""/>					
						</td>
						<td class="bz-edit-data-title">��֤��Ч����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="LICENSE_STARTVALID" defaultValue="" type="date" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��֤ʧЧ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="LICENSE_VALID" defaultValue="" type="date"/>			
						</td>
						<td class="bz-edit-data-title">��֯����ʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FOUNDED_DATE" defaultValue="" type="date" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��չ�й���Ŀʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CNSTART_DATE" defaultValue="" type="date"/>			
						</td>
						<td class="bz-edit-data-title">�ܲ���ַ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEADQUARTER_ADDRESS" defaultValue=""/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ʼĵ�ַ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MAILING_ADDRESS" defaultValue=""/>					
						</td>
						<td class="bz-edit-data-title">�绰</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TEL" defaultValue="" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAX" defaultValue=""/>			
						</td>
						<td class="bz-edit-data-title">��ַ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WEBSITE" defaultValue=""/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����ʼ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EMAIL" defaultValue="" />			
						</td>
						<td class="bz-edit-data-title">ί�л���֤����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUTHOR_DEPARTMENT" defaultValue="" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������Ŀ</td>
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
										if(serv.contains(code.getValue())){
								%>
									<%=code.getName() %>
								<%
										}
									}
								}
							%>
						</td>
						<td class="bz-edit-data-title">������������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="OTHER_COUNTRY" defaultValue="" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��֯����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="STATE" codeName="ZZHZZT" defaultValue="" />		
						</td>
						<td class="bz-edit-data-title">����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECORD_STATE" codeName="ZZBASHZT" defaultValue=""/>	
						</td>
					</tr>
					<tr>
						
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
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
