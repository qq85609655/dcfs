<%
/**   
 * @Title: advice_feedback_confirm.jsp
 * @Description: 安置部征求意见反馈确认
 * @author xugy
 * @date 2014-9-12上午10:15:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");
String CI_ID = data.getString("CI_ID");//儿童材料ID
String AF_ID = data.getString("AF_ID");//收养人文件ID
%>
<BZ:html>
<BZ:head>
	<title>安置部征求意见反馈确认</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//返回
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;ETSFLX;SYS_COUNTRY_GOVMENT_CN_ALL;WJLX;SYLX;">
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收养组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文编号 </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">批准书日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">到期日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人家庭信息</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 498px;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>儿童信息</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 157px;" src="<%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>征求意见信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="13%">公约收养</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/>
						</td>
						<td class="bz-edit-data-title" width="14%">通知日期</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="13%">反馈结果</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="ADVICE_FEEDBACK_RESULT" defaultValue="" onlyValue="true" checkValue="1=同意;2=暂停;3=重新匹配;4=退文;"/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">确认人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_CFM_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">确认日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_CFM_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养国中央机关</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADVICE_GOV_ID" defaultValue="" onlyValue="true" codeName="SYS_COUNTRY_GOVMENT_CN_ALL"/>
						</td>
						<td class="bz-edit-data-title">签署日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_FEEDBACK_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADVICE_FEEDBACK_REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
