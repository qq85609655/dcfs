<%
/**   
 * @Title: supply_translation_view.jsp
 * @Description:  预批补翻信息查看
 * @author panfeng   
 * @date 2014-10-16 
 * @version V1.0   
 */
%>

<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data adData = (Data)request.getAttribute("data");
	
	String UPLOAD_IDS = adData.getString("UPLOAD_IDS","");
	String UPLOAD_IDS_CN = adData.getString("UPLOAD_IDS_CN","");
	String RA_ID = adData.getString("RA_ID","");
%>

<BZ:html>
<BZ:head>
    <title>预批补翻信息查看</title>
    <BZ:webScript edit="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<up:uploadResource/>
</BZ:head>
<BZ:body property="data" codeNames="">
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			$('#tab-container').easytabs();
		})
	
	</script>	
	<!--通知信息:start-->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>补充通知信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">通知人</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">通知日期</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">补翻状态</td>
						<td class="bz-edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE" defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">补充内容</td>
						<td class="bz-edit-data-value" colspan="5" width="85%"><BZ:dataValue field="ADD_CONTENT_EN" defaultValue="" /></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">补充附件</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--通知信息:end-->

	<!--翻译信息：start-->
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>补充翻译信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">翻译内容</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<BZ:dataValue field="ADD_CONTENT_CN" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">翻译附件</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadList id="UPLOAD_IDS_CN" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS_CN%>'/>				
						</td>
					</tr>
					<tr>
						<td  class="bz-edit-data-title">翻译说明</td>
						<td  class="bz-edit-data-value" colspan="5">
						<BZ:dataValue field="TRANSLATION_DESC" defaultValue="" />
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title" width="15%">翻译单位</td>
						<td class="bz-edit-data-value" width="18%"><BZ:dataValue field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">翻译人</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">翻译日期</td>
						<td class="bz-edit-data-value" width="19%"> <BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--翻译信息：end-->
	<br>
	<!-- 按钮区域:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- 按钮区域:end -->
	</BZ:body>
</BZ:html>