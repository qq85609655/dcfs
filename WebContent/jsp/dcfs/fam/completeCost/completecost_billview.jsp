<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<BZ:html>
<BZ:head>
	<title>票据缴费信息查看</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	/*function _goback(){
		window.history.go(-1);	
	}*/
</script>
</BZ:head>

<BZ:body codeNames="FYLB;JFFS" property="data">
	<BZ:form name="srcForm" method="post">
	
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					缴费票据信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">费用类别</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">应缴金额</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">缴费方式</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">票面金额</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">缴费编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">缴费票号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">缴费日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">缴费备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<button class="btn btn-sm btn-primary" onclick="window.close();">关闭</button>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
