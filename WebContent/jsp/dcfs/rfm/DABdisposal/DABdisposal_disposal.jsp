<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>退文处置页面</title>
	<BZ:webScript list="true" edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	//退文处置提交
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("确定处置该退文信息吗？")) {
				document.srcForm.action = path + "rfm/DABdisposal/DABdisposalSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//返回
	function _goback(){
		window.location.href=path+'rfm/DABdisposal/DABdisposalList.action';
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;WJWZ;TWLX;TWCZFS_ALL" property="disposalData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>退文处置</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td colSpan=7 style="padding: 0;">
							<table class="table table-striped table-bordered dataTable" adsorb="both" init="true" >
								<thead>
									<tr style="background-color: rgb(180, 180, 249);">
										<th style="width: 5%; text-align: center;">
											<div class="sorting_disabled">序号</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="FILE_NO">收文编号</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="REGISTER_DATE">收文日期</div></th>
										<th style="width: 7%; text-align: center;">
											<div class="sorting_disabled" id="COUNTRY_CODE">国家</div></th>
										<th style="width: 14%; text-align: center;">
											<div class="sorting_disabled" id="ADOPT_ORG_ID">收养组织</div></th>
										<th style="width: 13%; text-align: center;">
											<div class="sorting_disabled" id="MALE_NAME">男收养人</div></th>
										<th style="width: 13%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_NAME">女收养人</div></th>
										<th style="width: 8%; text-align: center;">
											<div class="sorting_disabled" id="FILE_TYPE">文件类型</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="APPLE_DATE">申请日期</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="RETREAT_DATE">确认日期</div></th>
									</tr>
								</thead>
								<tbody>
									<BZ:for property="List" fordata="fordata">
										<tr>
											<td class="center">
												<BZ:i/><BZ:input prefix="P_" field="AR_ID" type="hidden" property="fordata" />
												<BZ:input prefix="P_" field="AF_ID" type="hidden" property="fordata" /></td>
											<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
											<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/></td>
											<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
											<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
											<td class="center"><BZ:data field="APPLE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
											<td class="center"><BZ:data field="RETREAT_DATE" defaultValue="" type="date" onlyValue="true"/></td>
										</tr>
									</BZ:for>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">处置人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="DUAL_USERNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="DUAL_USERID" type="hidden" defaultValue=""/>
							<BZ:input prefix="R_" field="DUAL_USERNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">处置日期</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="DUAL_DATE" defaultValue="" type="date" onlyValue="true"/>
							<BZ:input prefix="R_" field="DUAL_DATE" type="hidden" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	</br>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="确&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
