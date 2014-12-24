<%
/**   
 * @Title: childbaseinfo_view.jsp
 * @Description:  儿童基本信息
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
<%
	String path = request.getContextPath();
	String ciId = (String)request.getAttribute("CI_ID");
	String packId = (String)request.getAttribute("PackId");
%>
<BZ:html>
	<BZ:head>
		<title>儿童基本信息</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
	</BZ:head>
	<BZ:body property="childdata" codeNames="PROVINCE;ETXB;BCZL;">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="13%" style="line-height: 20px;">编号<br>Child_ID</td>
							<td class="bz-edit-data-value" width="15%" style="line-height: 20px;">
								<BZ:dataValue field="CHILD_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="13%" style="line-height: 20px;">类型<br>Type</td>
							<td class="bz-edit-data-value" width="15%" style="line-height: 20px;">
								<BZ:dataValue field="CHILD_TYPE" checkValue="1=正常;2=特需;9=其他;" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="13%" style="line-height: 20px;">省份<br>Province</td>
							<td class="bz-edit-data-value" width="15%" style="line-height: 20px;">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" rowspan="4" width="16%">
								<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=ciId%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:175px;"/>
								<%-- <img src='<up:attDownload attTypeCode="CMS" packageId='<%=(String)request.getAttribute("PHOTO_CARD") %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/> --%>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">福利院<br>SWI</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">姓名<br>Name(CN)</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">姓名拼音<br>Name(EN)</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">性别<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">体检日期<br>Date of physical exam</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">双胞胎<br>Multiple Birth</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" checkValue="0=no;1=yes" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">最后更新日期<br>Last updated</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="LAST_UPDATE_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">更新次数<br>Updated times</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="UPDATE_NUM" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">特别关注<br>Special focus</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">发布日期<br>Released date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">安置期限<br>Deadline of placement</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SETTLE_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">病残种类<br>SN type</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/>
							</td>
							<%-- <td class="bz-edit-data-title">文件递交期限<br>Submission Deadline</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="VALID_PERIOD" defaultValue="" onlyValue="true"/>
							</td> --%>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">病残诊断(中)<br>Diagnosis(CN)</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">病残诊断(英)<br>Diagnosis(EN)</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="DISEASE_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">备注<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
					<br/>
					<BZ:for property="childList" fordata="childData">
					<table class="bz-edit-data-table" border="0">
					<%
						//String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
						String attachCiId = ((Data)pageContext.getAttribute("childData")).getString("CI_ID","");
					%>
						<tr>
							<td class="bz-edit-data-title" width="13%" style="line-height: 20px;">编号<br>Child_ID</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="CHILD_NO" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="13%" style="line-height: 20px;">类型<br>Type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="CHILD_TYPE" property="childData" checkValue="1=正常;2=特需;9=其他;" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="13%" style="line-height: 20px;">省份<br>Province</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="PROVINCE_ID" property="childData" codeName="PROVINCE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" rowspan="4" width="16%">
								<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=attachCiId%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:175px;"/>
								<%-- <img src='<up:attDownload attTypeCode="CMS" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/> --%>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">福利院<br>SWI</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_EN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">姓名<br>Name(CN)</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">姓名拼音<br>Name(EN)</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">性别<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">体检日期<br>Date of physical exam</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHECKUP_DATE" property="childData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">双胞胎<br>Multiple Birth</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=no;1=yes" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">特别关注<br>Special focus</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="line-height: 20px;">病残种类<br>SN type</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">病残诊断(中)<br>Diagnosis(CN)</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">病残诊断(英)<br>Diagnosis(EN)</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="line-height: 20px;">备注<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="REMARKS" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
					</BZ:for>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童附件信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td colspan="5">
								<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=CI&IS_EN=true&packID=<%=packId%>&packageID=<BZ:dataValue field="FILE_CODE" onlyValue="true"/>" frameborder=0 width="100%"></IFRAME> 
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
	</BZ:body>
</BZ:html>