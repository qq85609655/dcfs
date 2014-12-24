<%
/**   
 * @Title: SYZZ_PP_feedback_additonal_into.jsp
 * @Description: 收养组织安置后报告补充录入
 * @author xugy
 * @date 2014-10-22下午2:25:23
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
	<title>安置后报告补充</title>
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
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//接受返回值
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
//
function _mod(){
	var FB_REC_ID = document.getElementById("FR_FB_REC_ID").value;
	$.layer({
		type : 2,
		title : "报告修改",
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
//保存
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	
	document.srcForm.action=path+"feedback/saveSYZZPPFeedbackAdditonal.action";
	document.srcForm.submit();
}
//提交
function _submit(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if(confirm('确认要提交该报告补充吗?')){
		document.srcForm.action=path+"feedback/submitSYZZPPFeedbackAdditonal.action";
		document.srcForm.submit();
	}else{
	  return;
	}
}
//返回
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
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>文件基本信息</div>
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
						<td class="bz-edit-data-title">文件类型<br>Document type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">档案编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收养类型<br>Adoption type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX" isShowEN="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人情况</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 376px;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>&LANG=EN"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>被收养人情况</div>
			</div>
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
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告情况</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">安置反馈次数</td>
						<td class="bz-edit-data-value" width="35%">
							第<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>次
						</td>
						<td class="bz-edit-data-title" width="15%">上次安置反馈日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="LAST_REPORT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">报告提交日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REPORT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">报告接收日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECEIVE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">制作报告组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">社工家访日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="VISIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养关系有无重大变故</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ACCIDENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=不融合;2=更换家庭;3=死亡;9=其他;"/>
						</td>
						<td class="bz-edit-data-title">报告完成日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">本报告可否用于宣传</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PUBLIC" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告附件
					<%
					if("".equals(isCN)){
					%>
					<span><input type="button" value="下载附件（原文）" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					<span><input type="button" value="下载附件（中文）" class="btn btn-sm btn-primary" onclick="_toipload('CN')"/></span>
					<%
					}else{
					%>
					<span><input type="button" value="下载附件" class="btn btn-sm btn-primary" onclick="_toipload('EN')"/></span>
					
					<%} %>
				</div>
			</div>
			<iframe id="attFrame" name="attFrame" class="attFrame" frameborder=0 style="width: 100%;" src=""></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>被收养儿童国外生活成长状况评估</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收养人感受</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEELING_CN" defaultValue="" onlyValue="true" codeName="SYRGS" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">融合情况</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FUSION_CN" defaultValue="" onlyValue="true" codeName="RHQK" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况<br>Health condition</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEALTHY_CN" defaultValue="" onlyValue="true" codeName="JKZK_AZHBG" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title">社工评价</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EVALUATION_CN" defaultValue="" onlyValue="true" codeName="SGPJ" isShowEN="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告补充</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">通知人</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="SEND_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">通知日期<br>Date of notification</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">补充原因</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">补充附件</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadBody attTypeCode="AR" name="FADD_UPLOAD_IDS" id="FADD_UPLOAD_IDS" packageId="<%=UPLOAD_IDS%>"  queueStyle="border: solid 1px #7F9DB9;" selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" />
						</td>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">补充附件（中文）</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadBody attTypeCode="AR" name="FADD_UPLOAD_IDS_CN" id="FADD_UPLOAD_IDS_CN" packageId="<%=UPLOAD_IDS_CN%>"  queueStyle="border: solid 1px #7F9DB9;" selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" />
						</td>
					</tr> --%>
					<tr>
						<td class="bz-edit-data-title">补充说明</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="FADD_" field="ADD_CONTENT_EN" type="textarea" defaultValue="" style="width:99%;height:60px;" formTitle="补充说明"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
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
