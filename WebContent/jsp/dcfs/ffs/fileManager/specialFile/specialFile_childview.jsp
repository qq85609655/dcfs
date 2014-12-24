<%
/**   
 * @Title: specialFile_childview.jsp
 * @Description:  儿童基本信息查看页面
 * @author yangrt   
 * @date 2014-8-14 下午16:20:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head language="EN">
		<title>儿童基本信息查看页面</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true" list="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
</BZ:html>
<BZ:body codeNames="ETXB;BCZL;PROVINCE;">
	<!-- 查看区域begin -->
	<div class="bz-edit clearfix" desc="查看区域">
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
				<BZ:for property="List" fordata="childData">
				<%
					String ci_id = ((Data)pageContext.getAttribute("childData")).getString("CI_ID","");
					String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD",ci_id);
				%>
					<tr>
						<td class="bz-edit-data-title" width="13%">省份<br>Province</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">福利院<br>SWI</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="WELFARE_NAME_EN" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">姓名<br>Name</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" rowspan="3" width="16%">
							<input type="image" src='<up:attDownload attTypeCode="CI" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:160px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">性别<br>Sex</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" property="childData" codeName="ETXB" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">特别关注<br>Special focus</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=No;1=Yes" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残种类<br>SN type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL" isShowEN="true" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件递交期限<br>Document submission deadline</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUBMIT_DATE" property="childData" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">有无同胞<br>Is Twins</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=No;1=Yes" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残诊断<br>Diagnosis</td>
						<td class="bz-edit-data-value" colspan="6">
							<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr class="blue-hr" style="background-color:#f5f5f5;"><td colspan="7">&nbsp;</td></tr>
				</BZ:for>
				</table>
			</div>
		</div>
	</div>
	<!-- 查看区域end -->
</BZ:body>