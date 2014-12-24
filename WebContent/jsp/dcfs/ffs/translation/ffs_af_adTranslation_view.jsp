<%
/**   
 * @Title: ffs_af_adTranslation.jsp
 * @Description:  文件补翻页
 * @author wangz   
 * @date 2014-8-27
 * @version V1.0   
 */
%>

<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data dataItem = (Data)request.getAttribute("data");
	if(dataItem==null){
%>
<html>
	<div class="page-content">无数据！</div>
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="window.close();"/>
		</div>
	</div>
</html>
<%}else{
	String NOTICE_FILEID = dataItem.getString("NOTICE_FILEID","");
	String TRANSLATION_FILEID = dataItem.getString("TRANSLATION_FILEID","");
%>

<BZ:html>
<BZ:head>
    <title>文件补翻查看</title>
    <BZ:webScript edit="true"/>
	<up:uploadResource/>
</BZ:head>
<BZ:body property="data" codeNames="">
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		})

	
	//关闭
	function _close(){
		window.close();
	}
	
	</script>	
	<!--通知信息:start-->
		<div id="tab-retranslation">
			<br>
			<table class="specialtable" align="center" style='width:98%;text-align:center'>
				<tr>
                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>通知信息</b></td>
                </tr>
				<tr>
					<td class="edit-data-title" width="15%">通知人</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">通知日期</td>
					<td class="edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" onlyValue="true" /></td>
					<td class="edit-data-title" width="15%">补翻状态</td>
					<td class="edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE"  onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">补翻原因</td>
					<td class="edit-data-value" colspan="5" width="85%"><BZ:dataValue field="AA_CONTENT" defaultValue="" /></td>
				</tr>
				<tr>
					<td class="edit-data-title" width="15%">补翻附件</td>
					<td class="edit-data-value" colspan="5" width="85%">
					<up:uploadList id="NOTICE_FILEID" firstColWidth="20px" attTypeCode="AF" packageId='<%=NOTICE_FILEID%>'/>
					</td>
				</tr>
			</table>			
		</div>
		<!--通知信息:end-->

	<!--翻译信息：start-->
	<div class='panel-container'>
		<table class="specialtable" align="center" style="width:98%;text-align:center">
			<tr>
				<td class="edit-data-title" colspan="6" style="text-align:center"><b>翻译信息</b></td>
			</tr>
			<tr>
				<td class="edit-data-title">翻译附件</td>
				<td class="edit-data-value" colspan="5" width="85%">
				<up:uploadList id="TRANSLATION_FILEID" firstColWidth="20px" attTypeCode="AF" packageId='<%=TRANSLATION_FILEID%>'/>				
				</td>
			</tr>
			<tr>
				<td  class="edit-data-title">翻译说明</td>
				<td  class="edit-data-value" colspan="5">
				<BZ:dataValue field="TRANSLATION_DESC" defaultValue="" />
				</td>
			</tr>
			<tr>
				<td class="edit-data-title" width="15%">翻译单位</td>
				<td class="edit-data-value" width="18%"><BZ:dataValue field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" /></td>
				<td class="edit-data-title" width="15%">翻译人</td>
				<td class="edit-data-value" width="18%"> <BZ:dataValue field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true" /></td>
				<td class="edit-data-title" width="15%">翻译日期</td>
				<td class="edit-data-value" width="19%"> <BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
			</tr>
		</table>
	</div>
	<!--翻译信息：end-->
	<br>
	<!-- 按钮区域:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
		</div>
	</div>
	<!-- 按钮区域:end -->
	</BZ:body>
</BZ:html>
<%}%>