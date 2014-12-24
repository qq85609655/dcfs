<%
/**   
 * @Title: FYGS_PP_feedback_translation.jsp
 * @Description: ���ú󱨸淭��
 * @author xugy
 * @date 2014-10-23����9:27:23
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
String isCN = "1";
String uploadParameterCN1 = (String)request.getAttribute("uploadParameterCN1");
String uploadParameter1 = (String)request.getAttribute("uploadParameter1");
String uploadParameter2 = (String)request.getAttribute("uploadParameter2");
String uploadParameter3 = (String)request.getAttribute("uploadParameter3");
Data data = (Data)request.getAttribute("data");
String FB_REC_ID = data.getString("FB_REC_ID");
String BIRTHDAY = data.getString("BIRTHDAY");
String NUM = data.getString("NUM");

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���ú󱨸淭��</title>
	<BZ:webScript edit="true" tree="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	var ACCIDENT_FLAG = document.getElementById("FR_ACCIDENT_FLAG").value;
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter1").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	if(ACCIDENT_FLAG == "2"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter2").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	if(ACCIDENT_FLAG == "3"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter3").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//
function _changeFlag(ACCIDENT_FLAG){
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter1").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	if(ACCIDENT_FLAG == "2"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter2").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	if(ACCIDENT_FLAG == "3"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter3").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
}
//���ܷ���ֵ
function getIframeVal(val){
	document.getElementById("textareaid").value=urlDecode(val);
	var ACCIDENT_FLAG = document.getElementById("FR_ACCIDENT_FLAG").value;
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	if(ACCIDENT_FLAG == "2"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
	if(ACCIDENT_FLAG == "3"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1";
	}
}
//
function _toipload(fn){
	var FB_REC_ID = document.getElementById("FR_FB_REC_ID").value;
	var ACCIDENT_FLAG = document.getElementById("FR_ACCIDENT_FLAG").value;
	if(fn == "EN"){
		document.uploadForm.PACKAGE_ID.value = FB_REC_ID;
		if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
			document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter1").value;
		}
	}
	if(fn == "CN"){
		document.uploadForm.PACKAGE_ID.value = "F_" + FB_REC_ID;
		if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
			document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameterCN1").value;
		}
	}
	
	document.uploadForm.action="<%=path%>/uploadManager";
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
//����
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"feedback/saveFYGSPPFeedbackTranslation.action";
	document.srcForm.submit();
}
//�ύ
function _submit(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if(confirm('ȷ��Ҫ�ύ�ñ��淭����?')){
		document.srcForm.action=path+"feedback/submitFYGSPPFeedbackTranslation.action";
		document.srcForm.submit();
	}else{
		return;
	}
}
//����
function _goback(){
	document.srcForm.action=path+"feedback/FYGSPPFeedbackTransList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="SYLX;GJSY;ADOPTER_HEALTH;ETXB;PROVINCE;CHILD_TYPE;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden" id="uploadParameterCN1" name="uploadParameterCN1" value="<%=uploadParameterCN1  %>" />
<input type="hidden" id="uploadParameter1" name="uploadParameter1" value="<%=uploadParameter1  %>" />
<input type="hidden" id="uploadParameter2" name="uploadParameter2" value="<%=uploadParameter2  %>" />
<input type="hidden" id="uploadParameter3" name="uploadParameter3" value="<%=uploadParameter3  %>" />
<BZ:input type="hidden" prefix="FT_" field="FB_T_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="FR_" field="FB_REC_ID" id="FR_FB_REC_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸淭��</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���ı��</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
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
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>"></iframe>
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
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">���÷�������</td>
						<td class="bz-edit-data-value" colspan="3">
							��<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>��
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>����������֯</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:input prefix="FR_" field="ORG_NAME" defaultValue="" formTitle="����������֯" notnull="��֯����Ϊ��"/>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�繤�ҷ�����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:input prefix="FR_" field="VISIT_DATE" type="date" defaultValue="" formTitle="�繤�ҷ�����" notnull="�ҷ����ڲ���Ϊ��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>������ϵ�����ش���</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="FR_" field="ACCIDENT_FLAG" id="FR_ACCIDENT_FLAG" onchange="_changeFlag(this.value)" formTitle="������ϵ�����ش���" width="135px">
								<BZ:option value="0">��</BZ:option>
								<BZ:option value="1">���ں�</BZ:option>
								<BZ:option value="2">������ͥ</BZ:option>
								<BZ:option value="3">����</BZ:option>
								<BZ:option value="9">����</BZ:option>
							</BZ:select>
							<td class="bz-edit-data-title"><font color="red">*</font>�����������</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="FR_" field="FINISH_DATE" type="date" defaultValue="" formTitle="�����������" notnull="����������ڲ���Ϊ��"/>
							</td>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>������ɷ���������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="FR_" field="IS_PUBLIC" defaultValue="" formTitle="������ɷ���������" width="135px" notnull="��ѡ��ɷ���������">
								<BZ:option value="0">--��ѡ��--</BZ:option>
								<BZ:option value="1">��</BZ:option>
								<BZ:option value="0">��</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����˵��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="FT_" field="TRANSLATION_DESC" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="����˵��" />
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸渽��
					<span><input type="button" value="�ϴ����������ģ�" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					<span><input type="button" value="�ϴ����������ģ�" class="btn btn-sm btn-primary" onclick="_toipload('CN')"/></span>
				</div>
			</div>
			<iframe id="attFrame" name="attFrame" class="attFrame" frameborder=0 style="width: 100%;height: 200px;" src=""></iframe>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
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
