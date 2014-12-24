<%
/**   
 * @Title: DAB_PP_feedback_detail_all.jsp
 * @Description: 历次安置后报告查看
 * @author xugy
 * @date 2014-11-4下午5:06:23
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

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");
String FEEDBACK_ID = data.getString("FEEDBACK_ID");
String BIRTHDAY = data.getString("BIRTHDAY");
%>
<BZ:html>
<script type="text/javascript" src="<%=path %>/resource/js/common.js"/>
<BZ:head>
	<title>历次安置后报告查看</title>
	<BZ:webScript edit="true" tree="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});

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
</script>
<BZ:body property="data" codeNames="SYLX;WJLX;">
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	$('#tab-container').easytabs();
});
</script>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>文件基本信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">国家</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养组织</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收文编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收文日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">来华领养通知书编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">签发日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养登记日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true"  codeName="WJLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">档案编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人信息</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 196px;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>儿童信息</div>
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
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 157px;" src="<%=path%>/feedback/CIInfoShow.action?CI_ID=<%=CI_ID%>"></iframe>
		</div>
	</div>
	<div id="tab-container" class='tab-container'>
		<ul class="etabs">
			<li class="tab"><a href="#tab1">第一次匹配</a></li>
			<li class="tab"><a href="#tab2">第二次匹配</a></li>
			<li class="tab"><a href="#tab3">第三次匹配</a></li>
			<li class="tab"><a href="#tab4">第四次匹配</a></li>
			<li class="tab"><a href="#tab5">第五次匹配</a></li>
			<li class="tab"><a href="#tab6">第六次匹配</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<iframe id="FRFrame1" name="FRFrame1" class="FRFrame1" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=1&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<div id="tab2">
				<iframe id="FRFrame2" name="FRFrame2" class="FRFrame2" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=2&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<div id="tab3">
				<iframe id="FRFrame3" name="FRFrame3" class="FRFrame3" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=3&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<div id="tab4">
				<iframe id="FRFrame4" name="FRFrame4" class="FRFrame4" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=4&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<div id="tab5">
				<iframe id="FRFrame5" name="FRFrame5" class="FRFrame5" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=5&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<div id="tab6">
				<iframe id="FRFrame6" name="FRFrame6" class="FRFrame6" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=6&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
		</div>
	</div>
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
				<input type="button" value="左旋转" onclick="_rotate(-90)">
				<input type="button" value="右旋转" onclick="_rotate(90)">
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
