<%
/**   
 * @Title: relieve_match_add.jsp
 * @Description: ���ƥ��
 * @author xugy
 * @date 2014-9-4����5:38:06
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="hx.util.InfoClueTo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String AF_ID = data.getString("AF_ID");//�������ļ�ID
String CI_ID = data.getString("CI_ID");//��ͯ����ID
String FILE_TYPE = data.getString("FILE_TYPE");//�ļ�����

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���ƥ��</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
	//
	function _submit(){
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"matchAudit/relieveMatchSave.action";
		document.srcForm.submit();
	}
	//���ض�ͯƥ���б�
	function _goback(){
		document.srcForm.action=path+"matchAudit/matchAuditList.action";
		document.srcForm.submit();
	}
	//
	function _changeAfterRelieve(REVOKE_MATCH_TYPE){
		var tab = document.getElementById("tab");
		var id = tab.rows[2].id;
		if(REVOKE_MATCH_TYPE == "1"){//ֻ����
			if(id == "returnReason"){
				tab.deleteRow(document.getElementById("returnReason").rowIndex);
			}
			var newTr = tab.insertRow(2);
			newTr.id="returnReason";
			var newTd1 = newTr.insertCell();
			newTd1.className="bz-edit-data-title";
			var newTd2 = newTr.insertCell();
			newTd2.className="bz-edit-data-value";
			newTd2.colSpan="3";
			
			var af_relieve_title=document.getElementById("af_relieve_title").innerHTML;
			newTd1.innerHTML=af_relieve_title;
			var af_relieve_value=document.getElementById("af_relieve_value").innerHTML;
			newTd2.innerHTML=af_relieve_value;
		}
		if(REVOKE_MATCH_TYPE == "2"){//ֻ�˲���
			if(id == "returnReason"){
				tab.deleteRow(document.getElementById("returnReason").rowIndex);
			}
			var newTr = tab.insertRow(2);
			newTr.id="returnReason";
			var newTd1 = newTr.insertCell();
			newTd1.className="bz-edit-data-title";
			var newTd2 = newTr.insertCell();
			newTd2.className="bz-edit-data-value";
			newTd2.colSpan="3";
			
			var ci_relieve_title=document.getElementById("ci_relieve_title").innerHTML;
			newTd1.innerHTML=ci_relieve_title;
			var ci_relieve_value=document.getElementById("ci_relieve_value").innerHTML;
			newTd2.innerHTML=ci_relieve_value;
		}
		if(REVOKE_MATCH_TYPE == "3"){//����ƥ��
			tab.deleteRow(2);
		}
		if(REVOKE_MATCH_TYPE == "4"){//�����˲���
			if(id == "returnReason"){
				tab.deleteRow(document.getElementById("returnReason").rowIndex);
			}
			var newTr = tab.insertRow(2);
			newTr.id="returnReason";
			var newTd1 = newTr.insertCell();
			newTd1.className="bz-edit-data-title";
			var newTd2 = newTr.insertCell();
			newTd2.className="bz-edit-data-value";
			var newTd3 = newTr.insertCell();
			newTd3.className="bz-edit-data-title";
			var newTd4 = newTr.insertCell();
			newTd4.className="bz-edit-data-value";
			
			var af_relieve_title=document.getElementById("af_relieve_title").innerHTML;
			newTd1.innerHTML=af_relieve_title;
			var af_relieve_value=document.getElementById("af_relieve_value").innerHTML;
			newTd2.innerHTML=af_relieve_value;
			var ci_relieve_title=document.getElementById("ci_relieve_title").innerHTML;
			newTd3.innerHTML=ci_relieve_title;
			var ci_relieve_value=document.getElementById("ci_relieve_value").innerHTML;
			newTd4.innerHTML=ci_relieve_value;
		}
		
	}
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
	</script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;">
<div id="af_relieve_title" style="display: none;">
	<font color="red">*</font>����ԭ��
</div>
<div id="af_relieve_value" style="display: none;">
	<BZ:input field="AF_RETURN_REASON" type="textarea" defaultValue="" formTitle="����ԭ��" style="width:99%;height:40px;" notnull="����ԭ����Ϊ��"/>
</div>
<div id="ci_relieve_title" style="display: none;">
	<font color="red">*</font>�˲���ԭ��
</div>
<div id="ci_relieve_value" style="display: none;">
	<BZ:input field="CI_RETURN_REASON" type="textarea" defaultValue="" formTitle="�˲���ԭ��" style="width:99%;height:40px;" notnull="�˲���ԭ����Ϊ��"/>
</div>
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="MI_" field="MI_ID" defaultValue="" type="hidden"/>
	<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
	<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����˻�����Ϣ</div>
				</div>
				<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ������Ϣ</div>
				</div>
				<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFirst.action?CI_ID=<%=CI_ID%>"></iframe>
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>���ƥ����Ϣ</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0" id="tab">
						<tr>
							<td class="bz-edit-data-title" width="20%">�������</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REVOKE_MATCH_DATE" defaultValue="" onlyValue="true" type="date"/>
							</td>
							<td class="bz-edit-data-title" width="20%">�����</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REVOKE_MATCH_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<%
							if("23".equals(FILE_TYPE)){
							%>
							<td class="bz-edit-data-value" colspan="4" style="font-size: 14pt;font-weight: bold;color: red;">
								���ļ����ļ�����Ϊ����˫�������ƥ����ļ�תΪ�����ա�����Ҫ���Ļ�����ƥ�䣬���ļ�תΪ�����ա����ٽ��д��á�
							</td>
							<%    
							}else{
							%>
							<td class="bz-edit-data-title"><font color="red">*</font>���ƥ������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:select prefix="MI_" field="REVOKE_MATCH_TYPE" onchange="_changeAfterRelieve(this.value)" defaultValue="3" formTitle="���ƥ������">
									<BZ:option value="1">����</BZ:option>
									<%-- <BZ:option value="2">�˲���</BZ:option> --%>
									<BZ:option value="3">����ƥ��</BZ:option>
									<%-- <BZ:option value="4">�����˲���</BZ:option> --%>
								</BZ:select>
							</td>
							<%} %>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>���ƥ��ԭ��</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="MI_" field="REVOKE_MATCH_REASON" type="textarea" defaultValue="" style="width:99%;height:60px;" notnull="���ƥ��ԭ����Ϊ��"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
