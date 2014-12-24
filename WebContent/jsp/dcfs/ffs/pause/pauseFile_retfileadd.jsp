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
	<title>退文申请确认页面</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	//退文确认提交
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("确定提交吗？提交后退文确认信息不可修改！")) {
				document.srcForm.action = path + "ffs/pause/returnFileSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//返回文件暂停信息列表
	function _goback(){
		window.location.href=path+'ffs/pause/pauseFileList.action';
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;TWCZFS_SYZZ" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="FAMILY_TYPE" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
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
							<BZ:input prefix="R_" field="FILE_NO" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
							<BZ:input prefix="R_" field="REGISTER_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
							<BZ:input prefix="R_" field="FILE_TYPE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
							<BZ:input prefix="R_" field="COUNTRY_CODE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">收养组织</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="ADOPT_ORG_ID" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">男收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="MALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">女收养人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FEMALE_NAME" type="hidden" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					退文申请信息
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
							<BZ:input prefix="R_" field="APPLE_PERSON_ID" type="hidden"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">申请日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>退文处置方式</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:select field="HANDLE_TYPE" id="R_HANDLE_TYPE" notnull="请输入退文处置方式" formTitle="" prefix="R_" isCode="true" codeName="TWCZFS_SYZZ" width="70%">
								<option value="">--请选择--</option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle"><font color="red">*</font>退文原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" prefix="R_" formTitle="退文原因" defaultValue=""  style="width:75%" maxlength="1000"/>
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
			<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
