<%
/**   
 * @Title: SYZZ_PP_feedback_into.jsp
 * @Description: 收养组织安置后报告反馈录入
 * @author xugy
 * @date 2014-10-10下午2:09:23
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
String uploadParameterCN1 = "";
if("1".equals(isCN)){
	uploadParameterCN1 = (String)request.getAttribute("uploadParameterCN1");
    
}
String uploadParameter1 = (String)request.getAttribute("uploadParameter1");
String uploadParameter2 = (String)request.getAttribute("uploadParameter2");
String uploadParameter3 = (String)request.getAttribute("uploadParameter3");
Data data = (Data)request.getAttribute("data");
String FB_REC_ID = data.getString("FB_REC_ID");
String BIRTHDAY = data.getString("BIRTHDAY");
String NUM = data.getString("NUM");

String REPORT_STATE = data.getString("REPORT_STATE");

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head language="EN">
	<title>安置后报告反馈录入</title>
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
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	if(ACCIDENT_FLAG == "2"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter2").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	if(ACCIDENT_FLAG == "3"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter3").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	
});
//
function _changeFlag(ACCIDENT_FLAG){
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter1").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	if(ACCIDENT_FLAG == "2"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter2").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	if(ACCIDENT_FLAG == "3"){
		document.getElementById("SMALL_TYPE").value = document.getElementById("uploadParameter3").value;
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
}
//接受返回值
function getIframeVal(val){
	document.getElementById("textareaid").value=urlDecode(val);
	var ACCIDENT_FLAG = document.getElementById("FR_ACCIDENT_FLAG").value;
	if(ACCIDENT_FLAG == "0" || ACCIDENT_FLAG == "1" || ACCIDENT_FLAG == "9"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=1&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	if(ACCIDENT_FLAG == "2"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=2&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
	}
	if(ACCIDENT_FLAG == "3"){
		document.attFrame.location = "<%=path%>/feedback/findPPFdeedbackAtt.action?FB_REC_ID=<%=FB_REC_ID%>&ACCIDENT_FLAG=3&BIRTHDAY=<%=BIRTHDAY%>&NUM=<%=NUM%>&isCN=<%=isCN%>&isEdit=1&LANG=EN";
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
	popWin.showWinIframe("1000","600","fileframe","附件管理","iframe","#");
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
			title: '图片查看',
			moveOut :true,
			bgcolor: '',
			area : ['auto', 'auto'],
			page : {dom : '#layer_show'},
			closeBtn : [1 , true]
		});
	};
}
//保存
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	
	document.srcForm.action=path+"feedback/saveSYZZPPFeedbackInto.action";
	document.srcForm.submit();
}
//提交
function _submit(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if(confirm('Are you sure you want to submit?')){
		document.srcForm.action=path+"feedback/submitSYZZPPFeedbackInto.action";
		document.srcForm.submit();
	}else{
	  return;
	}
}
//返回
function _goback(){
	document.srcForm.action=path+"feedback/SYZZPPFeedbackList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="SYLX;GJSY;ADOPTER_HEALTH;ETXB;PROVINCE;CHILD_TYPE;AZHBGTUYY;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden" id="uploadParameterCN1" name="uploadParameterCN1" value="<%=uploadParameterCN1  %>" />
<input type="hidden" id="uploadParameter1" name="uploadParameter1" value="<%=uploadParameter1  %>" />
<input type="hidden" id="uploadParameter2" name="uploadParameter2" value="<%=uploadParameter2  %>" />
<input type="hidden" id="uploadParameter3" name="uploadParameter3" value="<%=uploadParameter3  %>" />
<BZ:input type="hidden" prefix="FR_" field="FB_REC_ID" id="FR_FB_REC_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="FI_" field="FEEDBACK_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告录入</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收文编号<br>Log-in No.</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文日期<br>Log-in date</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">来华领养通知书编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">签发日期<br>Issuing date</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养登记日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">收养类型<br>Adoption type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">档案编号</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 376px;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>&LANG=EN"></iframe>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">入籍姓名</td>
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
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">安置反馈次数</td>
						<td class="bz-edit-data-value" colspan="3">
							第<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>次
						</td>
					</tr>
					<%
					if("9".equals(REPORT_STATE)){
					%>
					<tr>
						<td class="bz-edit-data-title">退回原因<br>Reason for return </td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true" codeName="AZHBGTUYY" isShowEN="true"/>
						</td>
					</tr>
					<%} %>
					<tr>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>制作报告组织</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:input prefix="FR_" field="ORG_NAME" defaultValue="" formTitle="制作报告组织" notnull="组织不能为空"/>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>社工家访日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:input prefix="FR_" field="VISIT_DATE" type="date" defaultValue="" dateExtend="lang:'en'" formTitle="社工家访日期" notnull="家访日期不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>收养关系有无重大变故</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="FR_" field="ACCIDENT_FLAG" id="FR_ACCIDENT_FLAG" onchange="_changeFlag(this.value)" formTitle="收养关系有无重大变故" width="135px">
								<BZ:option value="0">无</BZ:option>
								<BZ:option value="1">不融合</BZ:option>
								<BZ:option value="2">更换家庭</BZ:option>
								<BZ:option value="3">死亡</BZ:option>
								<BZ:option value="9">其他</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>报告完成日期</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="FR_" field="FINISH_DATE" type="date" defaultValue="" dateExtend="lang:'en'" formTitle="报告完成日期" notnull="报告完成日期不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>本报告可否用于宣传</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="FR_" field="IS_PUBLIC" formTitle="本报告可否用于宣传" width="135px" notnull="请选择可否用于宣传">
								<BZ:option value="">--Please select--</BZ:option>
								<BZ:option value="1">Yes</BZ:option>
								<BZ:option value="0">No</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告附件
					<%
					if("1".equals(isCN)){
					%>
					<span><input type="button" value="上传附件（原文）" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					<span><input type="button" value="上传附件（中文）" class="btn btn-sm btn-primary" onclick="_toipload('CN')"/></span>
					<%
					}else{
					%>
					<span><input type="button" value="Upload attachment" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					<%} %>
				</div>
			</div>
			<iframe id="attFrame" name="attFrame" class="attFrame" frameborder=0 style="width: 100%;height: 200px;" src=""></iframe>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
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
