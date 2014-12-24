<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapprovesupplerecords_view.jsp
 * @Description: 预批补充记录查看 
 * @author yangrt
 * @date 2014-10-13
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>预批补充记录查看</title>
		<BZ:webScript list="true" edit="true"/>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
			});
		</script>
	</BZ:head>
	<BZ:body>
		<%
	        DataList dl=(DataList)request.getAttribute("List");
	        if(dl.size()==0){%>
		          <br/>
		          <center><font color="red" size="2px">没有补充记录！</font></center>
       	<% 	}%>
		<BZ:for property="List" fordata="myData">
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div style="text-align: left;">
						<BZ:i/>、
						补充通知人：<BZ:dataValue field="SEND_USERNAME" property="myData" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
						 补充通知日期：<BZ:dataValue field="NOTICE_DATE" type="Date" property="myData" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
						补充通知来源：<BZ:dataValue field="ADD_TYPE" property="myData" checkValue="1=审核部;2=安置部;" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">通知内容</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NOTICE_CONTENT" property="myData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">回复人</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="FEEDBACK_USERNAME" property="myData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">回复日期</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="FEEDBACK_DATE" type="Date" property="myData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">补充状态</td>
							<td class="bz-edit-data-value" width="19%"> 
								<BZ:dataValue field="AA_STATUS" defaultValue="" property="myData" onlyValue="true" checkValue="0=待补充;1=补充中;2=已补充;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复内容(中)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADD_CONTENT_CN" defaultValue="" property="myData" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复内容(外)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADD_CONTENT_EN" defaultValue="" property="myData" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		</BZ:for>
	</BZ:body>
</BZ:html>