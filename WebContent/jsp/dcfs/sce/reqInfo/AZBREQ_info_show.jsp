<%
/**   
 * @Title: AZBREQ_info_show.jsp
 * @Description:预批撤销查看页面
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
	<title>撤销申请信息</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//返回预批撤销列表
	function _goback(){
		document.srcForm.action=path+"info/AZBREQInfoList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;GJSY">
	<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>撤销申请信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">国家</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养组织</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">男收养人</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="MALE_NAME"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">女收养人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">省厅</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">福利院</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">姓名</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">性别</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">出生日期</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">申请日期</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="REVOKE_REQ_DATE" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">申请状态</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REVOKE_STATE" checkValue="0=待确认;1=已确认;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">申请撤销原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REVOKE_REASON" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">确认人</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="REVOKE_CFM_USERNAME"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">确认日期</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REVOKE_CFM_DATE" type="date" defaultValue=""/>
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
