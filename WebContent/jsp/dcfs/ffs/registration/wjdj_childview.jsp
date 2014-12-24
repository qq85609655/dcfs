<%
/**   
 * @Title: wjdj_childview.jsp
 * @Description:  儿童基本信息查看页面
 * @author panfeng   
 * @date 2014-12-19 下午13:49:57 
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
		<title>儿童基本信息查看页面</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true" list="true"/>
		<style>
		</style>
	</BZ:head>
</BZ:html>
<BZ:body codeNames="CHILD_TYPE;ETXB;BCZL;PROVINCE;ETSFLX;ETLY">
	<!-- 查看区域begin -->
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>匹配儿童或关联特需儿童基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<BZ:for property="List" fordata="childData">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
				<%
					String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
					if("".equals(photo_card)){
						photo_card = ((Data)pageContext.getAttribute("childData")).getString("CI_ID");
					}
				%>
					<tr>
						<td class="bz-edit-data-title" width="13%">儿童编号</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_NO" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">儿童类型</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">身份证号</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="ID_CARD" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" rowspan="4" width="16%">
							<img src='<up:attDownload attTypeCode="CI" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">省份</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">福利院</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">特别关注</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=否;1=是" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">儿童身份</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">入院日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENTER_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">有无同胞</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=无;1=有" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">送养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SENDER" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">报送日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEND_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">送养人地址</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残种类</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
						</td>
						<td class="bz-edit-data-title">儿童来源</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_SOURCE" property="childData" codeName="ETLY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">儿童户籍地</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">病残诊断</td>
						<td class="bz-edit-data-value" colspan="6">
							<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			</BZ:for>
		</div>
	</div>
	<!-- 查看区域end -->
</BZ:body>