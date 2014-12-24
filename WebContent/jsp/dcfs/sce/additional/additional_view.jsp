<%
/**   
 * @Title: additional_view.jsp
 * @Description:  预批补充查询查看页面
 * @author panfeng   
 * @date 2014-9-12 上午10:11:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String ri_id = (String)request.getAttribute("RI_ID");
	String ra_id = (String)request.getAttribute("RA_ID");
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>预批补充查询查看页面</title>
		<BZ:webScript edit="true" list="true"/>
		<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//dyniframesize(['mainFrame']);
			$('#tab-container').easytabs();
		});
		
		//返回预批补充查询列表
		function _goback(){
			//window.location.href=path+'sce/additional/findAddList.action';
			document.srcForm.action = path+"sce/additional/findAddList.action";
			document.srcForm.submit();
		}
		
	</script>
	<BZ:body property="infodata" codeNames="WJLX;SYLX;">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#tab-container').easytabs();
			});
		</script>
		<div class="bz-edit clearfix" desc="编辑区域" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>
						预批补充概要信息(PRE-APPROVED SUPPLEMENTAL SUMMARY INFORMATION)
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="内容体" id="ggarea">
					<!-- 编辑区域 开始 -->
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">收养组织(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">收养组织(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">文件类型<br>File type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">收养类型<br>Adoption type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
							</td>
						</tr>
					</table>
					<!-- 编辑区域 结束 -->
				</div>
			</div>
		</div>
		<div id="tab-container" class='tab-container'>
			<ul class='etabs'>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowInfoDetail.action?type=CN&RI_ID=<%=ri_id %>" data-target="#tab1">收养人基本信息(中文)</a></li>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowInfoDetail.action?type=EN&RI_ID=<%=ri_id %>" data-target="#tab2">收养人基本信息(英文)</a></li>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowNoticeDetail.action?type=CN&RA_ID=<%=ra_id %>" data-target="#tab3">补充通知信息(中文)</a></li>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowNoticeDetail.action?type=EN&RA_ID=<%=ra_id %>" data-target="#tab3">补充通知信息(英文)</a></li>
			</ul>
			<div class='panel-container'>
				<div id="tab1">
				</div>	
				<div id="tab2">
				</div>
				<div id="tab3">
				</div>
				<div id="tab4">
				</div>
			</div>
		</div>
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:body>
</BZ:html>