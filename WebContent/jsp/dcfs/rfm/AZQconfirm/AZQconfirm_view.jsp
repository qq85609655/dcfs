<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<BZ:html>
<BZ:head>
	<title>退文详细信息查看页面</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;WJWZ;TWLX;TWCZFS_ALL" property="showdata">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="FAMILY_TYPE" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>文件基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收文编号</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">文件类型</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">男收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">女收养人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">收养组织</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					退文记录信息
				</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">申请人</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_PERSON_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">申请日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">退文类型</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_TYPE" defaultValue="" codeName="TWLX" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">退文处置方式</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">处置人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DUAL_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">处置日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DUAL_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">退文状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" defaultValue="" checkValue="0=待确认;1=已确认;2=待处置;3=已处置;9=取消退文" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">确认人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PERSON_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">确认日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETREAT_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">退文原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="关&nbsp;闭" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
