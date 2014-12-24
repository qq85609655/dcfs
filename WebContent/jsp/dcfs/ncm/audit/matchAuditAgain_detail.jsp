<%
/**   
 * @Title: matchAuditAgain_detail.jsp
 * @Description: ƥ�������Ϣ�鿴
 * @author xugy
 * @date 2014-12-15����6:30:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String AF_ID = data.getString("AF_ID");//�������ļ�ID
String CI_ID = data.getString("CI_ID");//��ͯ����ID
String MAIN_CI_ID = data.getString("MAIN_CI_ID");//��ͯ����ID

%>
<BZ:html>
<BZ:head>
	<title>��ͯ��Ϣ�鿴</title>
	<BZ:webScript edit="true" tree="true"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;ETXB;WJLX;SYLX;">
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
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
//�����б�
function _goback(){
	document.srcForm.action=path+"matchAudit/matchAuditAgainList.action";
	document.srcForm.submit();
}
</script>
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">���ı�� </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��׼������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˼�ͥ��Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 498px;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��ͯ��Ϣ</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 157px;" src="<%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="15%">�������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��˽��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=ͨ��;1=��ͨ��;"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true" />
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
