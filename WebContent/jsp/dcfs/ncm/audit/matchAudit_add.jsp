<%
/**   
 * @Title: matchAudit_add.jsp
 * @Description: ƥ�������Ϣ���
 * @author xugy
 * @date 2014-9-9����1:00:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String AF_ID = data.getString("AF_ID");//�������ļ�ID
String CI_ID = data.getString("CI_ID");//��ͯ����ID
String MAIN_CI_ID = data.getString("MAIN_CI_ID");//��ͯ������ID
String RI_ID = data.getString("RI_ID","");//Ԥ��ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);

%>
<BZ:html>
<script type="text/javascript" src="<%=path %>/resource/js/common.js"/>
<BZ:head>
	<title>��ͯ��Ϣ�鿴</title>
	<BZ:webScript edit="true" tree="true"/>
	<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;ETXB;WJLX;SYLX;">
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	$('#tab-container').easytabs();
	
	$("#MAU_AUDIT_OPTION").change(function(){
		if($("#MAU_AUDIT_OPTION").val() == "0"){
			$("#MAU_AUDIT_CONTENT").val("ͨ��");
		}else{
			$("#MAU_AUDIT_CONTENT").val("��ͨ��");
		}
	}); 
	
	
});
var path = "<%=path %>/";
//�鿴ͬ����Ϣ
function _viewEtcl(CHILD_NOs){
	$.layer({
		type : 2,
		title : "��ͯ���ϲ鿴",
		shade : [0.5 , '#D9D9D9' , true],
		border :[2 , 0.3 , '#000', true],
		//page : {dom : '#planList'},
		iframe: {src: '<BZ:url/>/mormalMatch/showTwinsCI.action?CHILD_NOs='+CHILD_NOs},
		area: ['1050px','580px'],
		offset: ['100px' , '50px']
	});
}
//�ϱ������������
function _submit(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"matchAudit/auditSubmit.action";
	document.srcForm.submit();
}
//����
function _save(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"matchAudit/auditSave.action";
	document.srcForm.submit();
}
//�����б�
function _goback(){
	document.srcForm.action=path+"matchAudit/matchAuditList.action";
	document.srcForm.submit();
}
</script>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="MAU_" field="MAU_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="MI_" field="MI_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div id="tab-container" class='tab-container'>
		<ul class="etabs">
			<li class="tab"><a href="#tab1">ƥ����Ϣ</a></li>
			<li class="tab"><a href="#tab2">����������ƥ����ϸ</a></li>
			<li class="tab"><a href="#tab3">��ͯ����ƥ����ϸ</a></li>
			<%
			String CHILD_TYPE = data.getString("CHILD_TYPE");
			if("2".equals(CHILD_TYPE)){
			    if(!"".equals(RI_ID)){
			%>
			<li class="tab"><a href="#tab4">�����ƻ������ģ�</a></li>
			<li class="tab"><a href="#tab5">�����ƻ���Ӣ�ģ�</a></li>
			<li class="tab"><a href="#tab6">��֯��������ģ�</a></li>
			<li class="tab"><a href="#tab7">��֯�����Ӣ�ģ�</a></li>
			<%      
			    }
			}
			%>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<table class="specialtable">
					<tr>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						<td class="edit-data-title">������֯</td>
						<td class="edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">��������</td>
						<td class="edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="edit-data-title" width="15%">���ı�� </td>
						<td class="edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">�ļ�����</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��׼������</td>
						<td class="edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center" colspan="4"><b>�����˻�����Ϣ</b></td>
					</tr>
					<tr>
						<td colspan="4">
							<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center" colspan="4"><b>��ͯ������Ϣ</b></td>
					</tr>
					<tr>
						<td colspan="4">
							<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFirst.action?CI_ID=<%=CI_ID%>"></iframe>
						</td>
					</tr>
				</table>
			</div>
			<div id="tab2">
				<%
				int i=0;
				%>
				<BZ:for property="allAFMatchdl" fordata="AFMatchdata">
					<table class="specialtable">
						<tr>
							<td class="edit-data-value" rowspan="8" width="5%">��<%=i+1 %>��ƥ��</td>
							<td class="edit-data-title" rowspan="2" width="5%">��ͯ��Ϣ</td>
							<td class="edit-data-title" width="10%">ʡ��</td>
							<td class="edit-data-value" width="10%">
								<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">����Ժ</td>
							<td class="edit-data-value" width="20%">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">����</td>
							<td class="edit-data-value" width="10%">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">�Ա�</td>
							<td class="edit-data-value" width="10%">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">��ͯ����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" checkValue="1=������ͯ;2=�����ͯ;" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">ƥ������</td>
							<td class="edit-data-value" colspan="3">
								<BZ:dataValue field="MATCH_DATE" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" rowspan="6">�����Ϣ</td>
							<td class="edit-data-title">��˼���</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=���������;1=�����������;" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">�����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_USERNAME" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">�������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">��˽��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=ͨ��;1=��ͨ��;" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_CONTENT" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ע</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_REMARKS" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��˼���</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=���������;1=�����������;" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">�����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">�������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">��˽��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=ͨ��;1=��ͨ��;" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ע</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
					</table>
				<%
				i++;
				%>
				</BZ:for>
				<%
				if(i == 0){
				%>
				<div style="text-align: center;font-size: 20px;">��ƥ���¼</div>
				<%} %>
			</div>
			<div id="tab3">
				<%
				int k=0;
				%>
				<BZ:for property="allCIMatchdl" fordata="CIMatchdata">
					<table class="specialtable">
						<tr>
							<td class="edit-data-value" rowspan="8" width="5%">��<%=k+1 %>��ƥ��</td>
							<td class="edit-data-title" rowspan="2" width="5%">��������Ϣ</td>
							<td class="edit-data-title" width="10%">�з�</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">��������</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">Ů��</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">��������</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">������֯</td>
							<td class="edit-data-value">
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">�ļ�����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">ƥ������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="MATCH_DATE" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" rowspan="6">�����Ϣ</td>
							<td class="edit-data-title">��˼���</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=���������;1=�����������;" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">�����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_USERNAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">�������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">��˽��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=ͨ��;1=��ͨ��;" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_CONTENT" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ע</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_REMARKS" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��˼���</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=���������;1=�����������;" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">�����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">�������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">��˽��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=ͨ��;1=��ͨ��;" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ע</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
					</table>
				<%
				k++;
				%>
				</BZ:for>
				<%
				if(k == 0){
				%>
				<div style="text-align: center;font-size: 20px;">��ƥ���¼</div>
				<%} %>
			</div>
			<%
			if("2".equals(CHILD_TYPE)){
			    if(!"".equals(RI_ID)){
			%>
			<div id="tab4">
				<iframe id="TOFrame4" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=4"></iframe>
			</div>
			<div id="tab5">
				<iframe id="TOFrame5" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=5"></iframe>
			</div>
			<div id="tab6">
				<iframe id="TOFrame6" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=6"></iframe>
			</div>
			<div id="tab7">
				<iframe id="TOFrame7" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=7"></iframe>
			</div>
			<%
			    }
			}
			%>
		</div>
		<div class='panel-container'>
			<table class="specialtable">
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>���¼����Ϣ</b></td>
				</tr>
				<tr>
					<td>
						<table class="specialtable">
							<tr>
								<td class="edit-data-title" width="10%">�������</td>
								<td class="edit-data-value" width="23%">
									<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true"/>
								</td>
								<td class="edit-data-title" width="10%">�����</td>
								<td class="edit-data-value" width="23%">
									<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
								</td>
								<td class="edit-data-title" width="10%"><font color="red">*</font>��˽��</td>
								<td class="edit-data-value" width="24%">
									<BZ:select prefix="MAU_" field="AUDIT_OPTION" id="MAU_AUDIT_OPTION" formTitle="��˽��">
										<BZ:option value="0">ͨ��</BZ:option>
										<BZ:option value="1">��ͨ��</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="edit-data-title">������</td>
								<td class="edit-data-value" colspan="5">
									<BZ:input prefix="MAU_" field="AUDIT_CONTENT" id="MAU_AUDIT_CONTENT" defaultValue="ͨ��" type="textarea" style="width:98%;height:60px;"/>
								</td>
							</tr>
							<tr>
								<td class="edit-data-title">��ע</td>
								<td class="edit-data-value" colspan="5">
									<BZ:input prefix="MAU_" field="AUDIT_REMARKS" defaultValue="" type="textarea" style="width:98%;height:60px;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>
