<%
/**   
 * @Title: childAddition_supply.jsp
 * @Description:  儿童材料信息补充页面
 * @author furx   
 * @date 2014-9-9 下午14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料信息补充查看页面</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script type="text/javascript">
  	
		function _close(){
			window.close();
		}
	
    </script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<!--<div class="bz-edit clearfix" style="">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童材料信息</div>
				</div>
				
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">编号</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="CHILD_NO" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">姓名</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">性别</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">省份</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">福利院</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">儿童类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE"  codeName="CHILD_TYPE" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>-->
		<div class="clearfix" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>通知信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
					    <tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知来源</td>
							<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="SOURCE" onlyValue="true" defaultValue="" checkValue="2=省厅;3=中心;"/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知人</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEND_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知日期</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="NOTICE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知内容</td>
							<td class="bz-edit-data-value" colspan="5" width="85%">
								<BZ:dataValue field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title">
				    <div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>补充信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充单位</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_ORGNAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充人</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="FEEDBACK_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充日期</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充状态</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="CA_STATUS" onlyValue="true" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充内容</td>
							<td class="bz-edit-data-value" colspan="3">
							    <BZ:dataValue field="ADD_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充附件</td>
							<td class="bz-edit-data-value" colspan="3" >
							<up:uploadList name="AFFIX" id="AFFIX" attTypeCode="CI" smallType="<%=AttConstants.CI_BCCL %>" 
							 packageId="<%=affix%>" secondColWidth="100%"/>
							</td>
						</tr>
						
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		</BZ:form>
		<div class="bz-action-frame" style="text-align:center">
		    <div class="bz-action-edit" desc="按钮区">		
				<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
			 </div>
        </div>
<!-- 按钮区域:end -->
	</BZ:body>
</BZ:html>