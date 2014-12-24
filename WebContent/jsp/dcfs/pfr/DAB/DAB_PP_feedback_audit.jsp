<%
/**   
 * @Title: DAB_PP_feedback_audit.jsp
 * @Description: ������֯���ú󱨸����
 * @author xugy
 * @date 2014-10-16����3:13:23
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
String isCN = (String)request.getAttribute("isCN");
Data data = (Data)request.getAttribute("data");
String FB_REC_ID = data.getString("FB_REC_ID");
String BIRTHDAY = data.getString("BIRTHDAY");
String NUM = data.getString("NUM");

String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG");
String uploadParameterCN = "";
if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
    uploadParameterCN = (String)request.getAttribute("uploadParameterCN");
}
String uploadParameter = (String)request.getAttribute("uploadParameter");

String AUDIT_OPTION = data.getString("AUDIT_OPTION");

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");
String FEEDBACK_ID = data.getString("FEEDBACK_ID");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���ú󱨸����</title>
	<BZ:webScript edit="true" tree="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	var ACCIDENT_FLAG = "<%=ACCIDENT_FLAG %>";
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=1&isEdit=0";
	}
	if(ACCIDENT_FLAG == "2"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=1&isEdit=0";
	}
	if(ACCIDENT_FLAG == "3"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=1&isEdit=0";
	}
	var AUDIT_OPTION = "<%=AUDIT_OPTION %>";
	if(AUDIT_OPTION == "3"){
		document.getElementById("isModTitle").innerHTML = "<font color=\"red\">*</font>�Ƿ������޸�ԭ�ļ�";
		var isMod=document.getElementById("isMod").innerHTML;
		document.getElementById("isModValue").innerHTML = isMod;
		
		var noticeContent=document.getElementById("noticeContent").innerHTML;
		document.getElementById("noticeContentValue").innerHTML = noticeContent;
		document.getElementById("addNoticeContent").style.display = "";
	}
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//
function _toipload(fn){
	var FB_REC_ID = document.getElementById("FR_FB_REC_ID").value;
	var ACCIDENT_FLAG = "<%=ACCIDENT_FLAG %>";
	if(fn == "EN"){
		document.uploadForm.PACKAGE_ID.value = FB_REC_ID;
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter").value;
	}
	if(fn == "CN"){
		document.uploadForm.PACKAGE_ID.value = "F_" + FB_REC_ID;
		if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
			document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameterCN").value;
		}else{
			document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter").value;
		}
	}
	
	document.uploadForm.action="<%=path%>/uploadManager?type=show";
	popWin.showWinIframe("1000","600","fileframe","��������","iframe","#");
	document.uploadForm.submit();
}
//
function _showPhoto(path){
	$("#layer_show .preview_img").prop("src", path);
	var obj = document.createElement('img');
	obj.src = document.getElementById('preview_img').src;
	obj.onload = function(){
		var w = this.width;
		var h = this.height;
		var x = w > h ? w : h;
		document.getElementById('img_tab').style.width = x+'px';
		document.getElementById('img_tab').style.height = x+'px';
		document.getElementById('img').style.transform="none";
		$.layer({
			type : 1,
			shadeClose: true,
			fix : true,
			title: 'ͼƬ�鿴',
			moveOut :true,
			bgcolor: '',
			area : ['auto', 'auto'],
			page : {dom : '#layer_show'},
			closeBtn : [1 , true]
		});
	};
}
//
function _changeOpinion(opinion){
	if(opinion == "3"){
		document.getElementById("isModTitle").innerHTML = "<font color=\"red\">*</font>�Ƿ������޸�ԭ�ļ�";
		var isMod=document.getElementById("isMod").innerHTML;
		document.getElementById("isModValue").innerHTML = isMod;
		
		var noticeContent=document.getElementById("noticeContent").innerHTML;
		document.getElementById("noticeContentValue").innerHTML = noticeContent;
		document.getElementById("addNoticeContent").style.display = "";
		
	}else{
		document.getElementById("isModTitle").innerHTML = "";
		document.getElementById("isModValue").innerHTML = "";
		document.getElementById("addNoticeContent").style.display = "none";
		document.getElementById("noticeContentValue").innerHTML = "";
	}
}
//�ύ
function _submit(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if(confirm('ȷ��Ҫ�ύ�ñ��������?')){
		document.srcForm.action=path+"feedback/submitDABPPFeedbackAudit.action";
		document.srcForm.submit();
	}else{
		return;
	}
}
//����
function _save(){
	document.srcForm.action=path+"feedback/saveDABPPFeedbackAudit.action";
	document.srcForm.submit();
}
//
function _allFeedbackDetail(){
	window.open(path+"feedback/getAllFeedbackDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>");
}
//����
function _goback(){
	document.srcForm.action=path+"feedback/DABPPFeedbackAuditList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="SYLX;GJSY;ADOPTER_HEALTH;ETXB;PROVINCE;CHILD_TYPE;WJLX;ETSFLX;SYRGS;RHQK;JKZK_AZHBG;SGPJ;">
<div id="isMod" style="display: none;">
	<BZ:select prefix="FADD_" field="IS_MODIFY" formTitle="�Ƿ������޸�ԭ�ļ�" width="135px">
		<BZ:option value="1">��</BZ:option>
		<BZ:option value="0">��</BZ:option>
	</BZ:select>
</div>
<div id="noticeContent" style="display: none;">
	<BZ:input prefix="FADD_" field="NOTICE_CONTENT" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="����ԭ��" notnull="����ԭ����Ϊ��"/>
</div>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden" id="uploadParameterCN" name="uploadParameterCN" value="<%=uploadParameterCN  %>" />
<input type="hidden" id="uploadParameter" name="uploadParameter" value="<%=uploadParameter  %>" />
<BZ:input type="hidden" prefix="FA_" field="FB_A_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="FADD_" field="FB_ADD_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="FADD_" field="NUM" defaultValue=""/>
<BZ:input type="hidden" prefix="FR_" field="FB_REC_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="FI_" field="FEEDBACK_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="CI_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AF_" field="AF_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ�������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">������֯</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ı��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������֪ͨ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ǩ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���������</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>"></iframe>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����������</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�뼮����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="CHILD_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%"></td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/feedback/CIInfoShow.action?CI_ID=<%=CI_ID%>"></iframe>
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
						<td class="bz-edit-data-title"><font color="red">*</font>������ɷ���������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="FR_" field="IS_PUBLIC" formTitle="������ɷ���������" width="135px" notnull="��ѡ��ɷ���������">
								<BZ:option value="">--��ѡ��--</BZ:option>
								<BZ:option value="1">��</BZ:option>
								<BZ:option value="0">��</BZ:option>
							</BZ:select>
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
				<div>���ú󱨸渽��
					<span><input type="button" value="���ظ��������ģ�" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					<span><input type="button" value="���ظ��������ģ�" class="btn btn-sm btn-primary" onclick="_toipload('CN')"/></span>
				</div>
			</div>
			<iframe id="attFrame" name="attFrame" class="attFrame" frameborder=0 style="width: 100%;" src=""></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��������ͯ��������ɳ�״������</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�����˸���</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:select prefix="FR_" field="FEELING_CN" defaultValue="" isCode="true" codeName="SYRGS" formTitle="�����˸���" width="135px" notnull="��ѡ�������˸���">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�ں����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:select prefix="FR_" field="FUSION_CN" defaultValue="" isCode="true" codeName="RHQK" formTitle="�ں����" width="135px" notnull="��ѡ���ں����">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>����״��</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="FR_" field="HEALTHY_CN" defaultValue="" isCode="true" codeName="JKZK_AZHBG" formTitle="����״��" width="135px" notnull="��ѡ�񽡿�״��">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>�繤����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="FR_" field="EVALUATION_CN" defaultValue="" isCode="true" codeName="SGPJ" formTitle="�繤����" width="135px" notnull="��ѡ���繤����">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
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
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�Ƿ�ͬ��ʡ��������Ժ�������ı���</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:select prefix="FR_" field="IS_SHOW" defaultValue="1" formTitle="�Ƿ�ͬ��ʡ��������Ժ�������ı���" width="135px">
								<BZ:option value="1">��</BZ:option>
								<BZ:option value="0">��</BZ:option>
							</BZ:select>
						</td>
						<%
						if("0".equals(isCN)){
						%>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�Ƿ�������֯�鿴����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:select prefix="FR_" field="IS_SHOW_TRAN" defaultValue="0" formTitle="�Ƿ�������֯�鿴����" width="135px">
								<BZ:option value="1">��</BZ:option>
								<BZ:option value="0">��</BZ:option>
							</BZ:select>
						</td>
						<%
						}else{
						%>
						<td class="bz-edit-data-title" width="15%"></td>
						<td class="bz-edit-data-value" width="35%"></td>
						<%} %>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>������</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="FA_" field="AUDIT_OPTION" onchange="_changeOpinion(this.value)" defaultValue="0" formTitle="������" width="135px">
								<BZ:option value="0">��������</BZ:option>
								<BZ:option value="1">�ص����</BZ:option>
								<BZ:option value="2">��������</BZ:option>
								<BZ:option value="3">�����ļ�</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title" id="isModTitle"></td>
						<td class="bz-edit-data-value" id="isModValue"></td>
					</tr>
					<tr id="addNoticeContent" style="display: none;">
						<td class="bz-edit-data-title"><font color="red">*</font>����ԭ��</td>
						<td class="bz-edit-data-value" colspan="3" id="noticeContentValue"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="FA_" field="AUDIT_CONTENT_CN" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="�����������ģ�"/>
						</td>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">��������Ӣ�ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="FA_" field="AUDIT_CONTENT_EN" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="��������Ӣ�ģ�"/>
						</td>
					</tr> --%>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="FA_" field="AUDIT_REMARKS" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="��ע"/>
						</td>
					</tr>
				</table>
			</div>
			<%
			String FB_ADD_ID = data.getString("FB_ADD_ID", "");
			if(!"".equals(FB_ADD_ID)){
			%>
			<iframe id="FADDFrame" name="FADDFrame" class="FADDFrame" frameborder=0 style="width: 100%;height: 200px;" src="<%=path%>/feedback/feedbackAdditonalShow.action?FB_ADD_ID=<%=FB_ADD_ID%>"></iframe>
			<%} %>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="���α����ѯ" class="btn btn-sm btn-primary" onclick="_allFeedbackDetail()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
<input type="hidden" id="PACKAGE_ID" name="PACKAGE_ID" value=""/>
<input type="hidden" id="SMALL_TYPE" name="SMALL_TYPE" value=""/>
<input type="hidden" id="ENTITY_NAME" name="ENTITY_NAME" value="ATT_AR"/>
<input type="hidden" id="BIG_TYPE" name="BIG_TYPE" value="AR"/>
<input type="hidden" id="IS_EN" name="IS_EN" value="false"/>
<input type="hidden" id="CREATE_USER" name="CREATE_USER" value=""/>
<input type="hidden" id="PATH_ARGS" name="PATH_ARGS" value="ar_id=1212133,ar_class=1212232"/>
<textarea rows="5" cols="" style="width:600px;display: none;" id="textareaid"></textarea>
</form>
<div id="layer_show" style="display:none;">
	<table border="0" id="img_tab" style="text-align: center;">
		<tr>
			<td id="img">
				<img class="preview_img" id="preview_img" src=''>
			</td>
		</tr>
	</table>
	<table width="400px">
		<tr>
			<td align="center">
				<input type="button" value="����ת" onclick="_rotate(-90)">
				<input type="button" value="����ת" onclick="_rotate(90)">
			</td>
		</tr>
	</table>
	<script type="text/javascript">
	var ttt = 0;
	function _rotate(s){
		ttt += s;
		var s = "rotate("+ttt+"deg)";
		document.getElementById('img').style.transform=s;
	}
	</script>
</div>
</BZ:body>
</BZ:html>