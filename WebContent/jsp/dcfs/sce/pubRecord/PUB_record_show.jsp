<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:点发退回信息确认页面
 * @author lihf
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data d = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
	<title>点发退回信息确认</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//返回点发退回列表
	function _goback(){
		document.srcForm.action=path+"record/PUBRecordList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;GJSY;">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>点发信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">省份</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">福利院</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">姓名</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">性别</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
							</td>
							<td class="bz-edit-data-title">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" />
							</td>
							<td class="bz-edit-data-title">特别关注</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">特殊活动</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="IS_PLAN" defaultValue="" checkValue="0=no;1=yes;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残诊断</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DISEASE_CN" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国家</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="COUNTRY_COD" defaultValue="" codeName="GJSY"/>
							</td>
							<td class="bz-edit-data-title">发布组织</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CNAME" defaultValue="" />
							</td>
							<td class="bz-edit-data-title">点发类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_MOD" defaultValue=""  codeName="DFLX"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">安置期限</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SETTLE_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">首次发布日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_FIRSTDATE" defaultValue="" type="date" />
							</td>
							<td class="bz-edit-data-title">末次发布日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" defaultValue=""  type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">发布人</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PUBLISHER_NAME" defaultValue=""/>
							</td>
						</tr>
					</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>退回信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">退回人</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">退回日期</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="RETURN_DATE" onlyValue="true" defaultValue="" type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">确认人</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_CFM_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">确认日期</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="RETURN_CFM_DATE" onlyValue="true" defaultValue="" type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">退回原因</td>
							<td class="bz-edit-data-value" width="85%" colspan="5">
								<BZ:dataValue field="RETURN_REASON" defaultValue="" />
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
