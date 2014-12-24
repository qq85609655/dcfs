<%
/**   
 * @Title: SYZZ_PP_feedback_additonal_into.jsp
 * @Description: ������֯���ú󱨸油��¼��
 * @author xugy
 * @date 2014-10-22����2:25:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data = (Data)request.getAttribute("data");
String isCN = (String)request.getAttribute("isCN");
String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG");
String uploadParameterCN = "";
if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
    uploadParameterCN = (String)request.getAttribute("uploadParameterCN");
}
String uploadParameter = (String)request.getAttribute("uploadParameter");

String FB_REC_ID = data.getString("FB_REC_ID");
String BIRTHDAY = data.getString("BIRTHDAY");
String NUM = data.getString("NUM");

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");

String UPLOAD_IDS = data.getString("UPLOAD_IDS");
String UPLOAD_IDS_CN = data.getString("UPLOAD_IDS_CN");

String IS_MODIFY = data.getString("IS_MODIFY");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head language="EN">
	<title>���ú󱨸油��</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource cancelJquerySupport="true" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	var ACCIDENT_FLAG = "<%=ACCIDENT_FLAG %>";
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=0&LANG=EN";
	}
	if(ACCIDENT_FLAG == "2"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=0&LANG=EN";
	}
	if(ACCIDENT_FLAG == "3"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=0&LANG=EN";
	}
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//���ܷ���ֵ
function getIframeVal(val){
	document.getElementById("textareaid").value=urlDecode(val);
}
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
//
function _mod(){
	var FB_REC_ID = document.getElementById("FR_FB_REC_ID").value;
	$.layer({
		type : 2,
		title : "�����޸�",
		shade : [0.5 , '#D9D9D9' , true],
		border :[2 , 0.3 , '#000', true],
		//page : {dom : '#planList'},
		iframe: {src: '<BZ:url/>/feedback/toSYZZPPFeedbackAdditonalMod.action?FB_REC_ID='+FB_REC_ID},
		area: ['1150px','2050px'],
		offset: ['0px' , '0px']
	});
}
//
function _refresh(){
	layer.closeAll();
	var ids = document.getElementById("FADD_FB_ADD_ID").value;
	document.srcForm.action=path+"feedback/toSYZZPPFeedbackAdditonal.action?ids="+ids;
	document.srcForm.submit();
}
//����
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	
	document.srcForm.action=path+"feedback/saveSYZZPPFeedbackAdditonal.action";
	document.srcForm.submit();
}
//�ύ
function _submit(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if(confirm('ȷ��Ҫ�ύ�ñ��油����?')){
		document.srcForm.action=path+"feedback/submitSYZZPPFeedbackAdditonal.action";
		document.srcForm.submit();
	}else{
	  return;
	}
}
//����
function _goback(){
	document.srcForm.action=path+"feedback/SYZZPPFeedbackAdditonalList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="SYLX;GJSY;ADOPTER_HEALTH;ETXB;PROVINCE;CHILD_TYPE;WJLX;ETSFLX;SYRGS;RHQK;JKZK_AZHBG;SGPJ;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden" id="uploadParameterCN" name="uploadParameterCN1" value="<%=uploadParameterCN  %>" />
<input type="hidden" id="uploadParameter" name="uploadParameter1" value="<%=uploadParameter  %>" />
<BZ:input type="hidden" prefix="FR_" field="FB_REC_ID" id="FR_FB_REC_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="FADD_" field="FB_ADD_ID" id="FADD_FB_ADD_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ�������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���ı��<br>Log-in No.</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������<br>Log-in date</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������֪ͨ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ǩ������<br>Issuing date</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">�ļ�����<br>Document type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������<br>Adoption type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX" isShowEN="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���������</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 376px;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>&LANG=EN"></iframe>
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
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 302px;" src="<%=path%>/feedback/CIInfoShow.action?CI_ID=<%=CI_ID%>&LANG=EN"></iframe>
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
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PUBLIC" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸渽��
					<%
					if("".equals(isCN)){
					%>
					<span><input type="button" value="���ظ�����ԭ�ģ�" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					<span><input type="button" value="���ظ��������ģ�" class="btn btn-sm btn-primary" onclick="_toipload('CN')"/></span>
					<%
					}else{
					%>
					<span><input type="button" value="���ظ���" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					
					<%} %>
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
						<td class="bz-edit-data-title" width="15%">�����˸���</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEELING_CN" defaultValue="" onlyValue="true" codeName="SYRGS" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ں����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FUSION_CN" defaultValue="" onlyValue="true" codeName="RHQK" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��<br>Health condition</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEALTHY_CN" defaultValue="" onlyValue="true" codeName="JKZK_AZHBG" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title">�繤����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EVALUATION_CN" defaultValue="" onlyValue="true" codeName="SGPJ" isShowEN="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���ú󱨸油��</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">֪ͨ��</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="SEND_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">֪ͨ����<br>Date of notification</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���丽��</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadBody attTypeCode="AR" name="FADD_UPLOAD_IDS" id="FADD_UPLOAD_IDS" packageId="<%=UPLOAD_IDS%>"  queueStyle="border: solid 1px #7F9DB9;" selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" />
						</td>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">���丽�������ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadBody attTypeCode="AR" name="FADD_UPLOAD_IDS_CN" id="FADD_UPLOAD_IDS_CN" packageId="<%=UPLOAD_IDS_CN%>"  queueStyle="border: solid 1px #7F9DB9;" selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" />
						</td>
					</tr> --%>
					<tr>
						<td class="bz-edit-data-title">����˵��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="FADD_" field="ADD_CONTENT_EN" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="����˵��"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<%
			if("1".equals(IS_MODIFY)){
			%>
			<input type="button" value="Modify report" class="btn btn-sm btn-primary" onclick="_mod()"/>&nbsp;
			<%} %>
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
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
				<input type="button" value="Rotate left" onclick="_rotate(-90)">
				<input type="button" value="Rotate right" onclick="_rotate(90)">
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
