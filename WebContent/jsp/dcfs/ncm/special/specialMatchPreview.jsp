<%
/**   
 * @Title: specialMatchPreview.jsp
 * @Description: 匹配预览页面
 * @author xugy
 * @date 2014-9-6下午12:02:19
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
String result= (String)request.getAttribute("result");//获取操作结果

String AFid= (String)request.getAttribute("AFid");//收养人文件ID
String CIid= (String)request.getAttribute("CIid");//儿童材料ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>匹配预览页面</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	$(document).ready(function() {
		//dyniframesize(['CIFrame','mainFrame']);
		var result = document.getElementById("result").value;
		if(result == "0" || result == "2"){
			//window.parent._matchResultView(result);
			opener._matchResultView(result);
			window.close();
		}
	});
	//查看同胞信息
	function _viewEtcl(CHILD_NOs){
		$.layer({
			type : 2,
			title : "儿童材料查看",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			//page : {dom : '#planList'},
			iframe: {src: '<BZ:url/>/mormalMatch/showTwinsCI.action?CHILD_NOs='+CHILD_NOs},
			area: ['1050px','580px'],
			offset: ['100px' , '50px']
		});
	}
	//提交匹配结果
	function _submit(){
		if (confirm('确定提交匹配结果？')) {
			document.srcForm.action=path+"specialMatch/saveSpecialMatchResult.action?AFid=<%=AFid%>&CIid=<%=CIid%>";
			document.srcForm.submit();
		}
	}
	//返回儿童匹配列表
	function _goback(){
		if (confirm('匹配结果未保存，确定返回儿童列表？')) {
			document.srcForm.action=path+"specialMatch/CISpecialMatchList.action?AFid=<%=AFid%>";
			document.srcForm.submit();
		}
	}
	//关闭弹出页面
	function _close(){
		if (confirm('匹配结果未保存，确定关闭该页？')) {
			/* var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index); */
			
			window.close();
		}
	}
	</script>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<input type="hidden" id="result" name="result" value="<%=result %>"/>
	<!-- 收养组织ID -->
	<BZ:input type="hidden" field="ADOPT_ORG_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">收养组织（CN）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养组织（EN）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文编号 </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">批准书日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">到期日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养人基本信息</div>
				</div>
				<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AFid%>"></iframe>
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童基本信息</div>
				</div>
				<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFirst.action?CI_ID=<%=CIid%>"></iframe>
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">匹配原因</td>
							<td class="bz-edit-data-value" width="85%">
								<BZ:input field="MATCH_SEASON" defaultValue="" type="textarea" style="width:100%;height:80px;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="_close();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
