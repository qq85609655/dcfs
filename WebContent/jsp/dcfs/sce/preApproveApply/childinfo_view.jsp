<%
/**   
 * @Title: childinfo_view.jsp
 * @Description:  预锁定儿童基本信息
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head>
		<title>预锁定儿童基本信息</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
			});
		</script>
	</BZ:head>
	<BZ:body property="childdata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批锁定儿童基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">省份</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">福利院</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">姓名</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="NAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">性别</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" rowspan="4" width="16%">
								<input type="image" src='<up:attDownload attTypeCode="CI" packageId='<%=(String)request.getAttribute("MAIN_PHOTO") %>' smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:150px;"/>
							</td>
						</tr>
						<tr>
							
							<td class="bz-edit-data-title">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">特别关注</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=否;1=是" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">有无同胞</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" checkValue="0=无;1=有;" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">文件递交期限</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="VALID_PERIOD" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残诊断</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:dataValue field="DISEASE_CN" defaultValue=""/>
							</td>
						</tr>
					<BZ:for property="childList" fordata="childData">
					<%
						Data data = (Data)pageContext.getAttribute("childData");
						String ci_id = data.getString("CI_ID","");
						String photo_card = data.getString("PHOTO_CARD", ci_id);
					%>
						<tr>
							<td class="bz-edit-data-title" width="20%">姓名</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">性别</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" rowspan="4" width="16%">
								<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=photo_card%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:150px;">
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">出生日期</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">特别关注</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=否;1=是" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">有无同胞</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=无;1=有;" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">文件递交期限</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="VALID_PERIOD" property="childData" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残诊断</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue=""/>
							</td>
						</tr>
					</BZ:for>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
	</BZ:body>
</BZ:html>