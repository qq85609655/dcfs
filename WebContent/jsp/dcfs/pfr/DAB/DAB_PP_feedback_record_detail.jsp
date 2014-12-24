<%
/**   
 * @Title: DAB_PP_feedback_record_detail.jsp
 * @Description: ���ΰ��ú󱨸�鿴
 * @author xugy
 * @date 2014-11-4����6:05:23
 * @version V1.0
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data = (Data)request.getAttribute("data");
DataList dl = (DataList)request.getAttribute("dl");
Data photoData = (Data)request.getAttribute("photoData");

String ADUIT_STATE = data.getString("ADUIT_STATE","");
%>
<BZ:html>
<BZ:head>
	<title>���ΰ��ú󱨸�鿴</title>
	<BZ:webScript edit="true" tree="true"/>
	
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});

function _show(path){
	parent._showPhoto(path);
}
</script>
<BZ:body property="data" codeNames="SYRGS;RHQK;JKZK_AZHBG;SGPJ;">
	<%
	if(!"".equals(ADUIT_STATE)){
	%>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸����</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���÷�������</td>
						<td class="bz-edit-data-value" width="35%">
							��<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>��
						</td>
						<td class="bz-edit-data-title" width="15%">�ϴΰ��÷�������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="LAST_REPORT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����ύ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REPORT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">�����������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECEIVE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�繤�ҷ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="VISIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������ϵ�����ش���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ACCIDENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=���ں�;2=������ͥ;3=����;9=����;"/>
						</td>
						<td class="bz-edit-data-title">�����������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������ɷ���������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="IS_PUBLIC" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���淭�뵥λ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TRANSLATION_COMPANY" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TRANSLATION_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸渽��</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="45%" />
						<col width="45%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-title" style="text-align: center;">ԭ��</td>
						<td class="bz-edit-data-title" style="text-align: center;">����</td>
					</tr>
					<%
					for(int i=0;i<dl.size();i++){
					    String CNAME = dl.getData(i).getString("CNAME");
					    DataList ATTDL = (DataList)dl.getData(i).get("ATTDL");
					%>
					<tr>
						<td class="bz-edit-data-title">
							<%=CNAME %>
						</td>
						<td class="bz-edit-data-value">
						<%
						if(ATTDL.size()>0){
						%>
							<table class="attlisttable">
						<%
						    for(int j=0;j<ATTDL.size();j++){
						        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
						        String ID = ATTDL.getData(j).getString("ID");
						        String ATT_TYPE = ATTDL.getData(j).getString("ATT_TYPE");
						        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
						%>
								<tr>
									<td width="5%"><%=j+1%>.</td>
									<td width="70%"><%=ATT_NAME%></td>
									<td width="25%">&nbsp;
										<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
										<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
									</td>
								</tr>
						<%
							}
						%>
							</table>
						<%
						}
						%>
						</td>
						<td class="bz-edit-data-value">
						<%
						    DataList ATTCNDL = (DataList)dl.getData(i).get("ATTCNDL");
						    if(ATTCNDL.size()>0){
						%>
								<table class="attlisttable">
						<%
							    for(int j=0;j<ATTCNDL.size();j++){
							        String ATT_NAME = ATTCNDL.getData(j).getString("ATT_NAME");
							        String ID = ATTCNDL.getData(j).getString("ID");
							        String ATT_TYPE = ATTCNDL.getData(j).getString("ATT_TYPE");
							        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
						%>
								<tr>
									<td width="5%"><%=j+1%>.</td>
									<td width="70%"><%=ATT_NAME%></td>
									<td width="25%">&nbsp;
										<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
										<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
									</td>
								</tr>
						<%
							    }
						%>
							</table>
						<%
						    }
						%>
						</td>
					</tr>
					<%
					}
					if(!photoData.isEmpty()){
					    String CNAME = photoData.getString("CNAME");
					    DataList ATTDL = (DataList)photoData.get("ATTDL");
					%>
					<tr>
						<td class="bz-edit-data-title">
							<%=CNAME %>
						</td>
						<td class="bz-edit-data-value" colspan="2">
						<%
						if(ATTDL.size()>0){
						    for(int j=0;j<ATTDL.size();j++){
						        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
						        String ID = ATTDL.getData(j).getString("ID");
						        String DES_EN = ATTDL.getData(j).getString("DES_EN","");
						        String DES_CN = ATTDL.getData(j).getString("DES_CN","");
						        
						%>
							<div style="width: 275px;float: left;margin: 5px;text-align: center;">
								<img alt="<%= ATT_NAME %>" style="cursor: pointer;text-align: center;" src="<%= path %>/feedback/showThumbnail.action?ATT_TABLE=ATT_AR&ID=<%= ID %>" onclick="_show('<%= path %>/feedback/showPicture.action?ATT_TABLE=ATT_AR&ID=<%= ID %>')">
								<table class="bz-edit-data-table" style="border-right: 1px #ddd solid;">
									<tr>
										<td class="bz-edit-data-title" width="35%">��Ƭ����</td>
										<td class="bz-edit-data-value" width="65%">
											<%= DES_EN %>
										</td>
									</tr>
									<tr>
										<td class="bz-edit-data-title">��������</td>
										<td class="bz-edit-data-value">
											<%= DES_CN %>
										</td>
									</tr>
								</table>
							</div>
						<%
							}
						}
						%>
						</td>
					</tr>
					<%} %>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��������ͯ��������ɳ�״������</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�����˸���</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEELING_CN" defaultValue="" onlyValue="true" codeName="SYRGS"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ں����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FUSION_CN" defaultValue="" onlyValue="true" codeName="RHQK"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEALTHY_CN" defaultValue="" onlyValue="true" codeName="JKZK_AZHBG"/>
						</td>
						<td class="bz-edit-data-title">�繤����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EVALUATION_CN" defaultValue="" onlyValue="true" codeName="SGPJ"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸�����</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=��������;1=�ص����;2=��������;3=�����ļ�;"/>
						</td>
						<td class="bz-edit-data-title" width="15%"></td>
						<td class="bz-edit-data-value" width="35%"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">��������Ӣ�ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_CONTENT_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr> --%>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<%  
	}else{
	%>
	<div style="text-align: center;"><font size="20"><b>û����ΰ��ú󱨸����Ϣ</b></font></div>
	<%} %>
</BZ:body>
</BZ:html>
