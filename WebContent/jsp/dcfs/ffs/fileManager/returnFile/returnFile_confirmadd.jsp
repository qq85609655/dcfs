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
<BZ:head language="EN">
	<title>退文申请确认页面</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
		.base .bz-edit-data-title{
			line-height:20px;
		}
	</style>
	<script>
	
	//退文申请确认提交
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("Are you sure to submit? You are not allowed to modify once submitted!")) {
				document.srcForm.action = path + "ffs/filemanager/ReturnFileSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//返回退文申请列表
	function _goback(){
		window.location.href=path+'ffs/filemanager/ReturnApplyList.action';
	}
	
	//返回退文信息列表
	function _cancel(){
		if (confirm("Are you sure you want to cancel withdrawal application? ")){
			window.location.href=path+'ffs/filemanager/ReturnFileList.action';
		}
	}
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;TWCZFS_SYZZ;WJQJZT_SYZZ" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="FAMILY_TYPE" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="COUNTRY_CODE" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="ADOPT_ORG_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>文件基本信息(INFORMATION ABOUT THE FILE)</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收文编号<br>Log-in No.</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FILE_NO" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文日期<br>Log-in date</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
							<BZ:input prefix="R_" field="REGISTER_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">文件类型<br>Document type</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true" />
							<BZ:input prefix="R_" field="FILE_TYPE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">男收养人<br>Adoptive father</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="MALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">女收养人<br>Adoptive mother</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FEMALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">文件状态<br>File status</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_GLOBAL_STATE" codeName="WJQJZT_SYZZ" isShowEN="true" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">暂停状态<br>Suspension status</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOVERY_STATE" defaultValue="" checkValue="1=suspeneded;9=non-suspended" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">暂停日期<br>Suspension date</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PAUSE_DATE" defaultValue="" type="date" onlyValue="true"/>
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
					退文申请信息(RETURN FILE APPLICATION INFORMATION)
				</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">申请人<br>Applicant</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_PERSON_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_ID" type="hidden"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">申请日期<br>Date of application</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>退文处置方式<br>Treatment of withdrawal</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:select field="HANDLE_TYPE" id="R_HANDLE_TYPE" notnull="please input treatment of withdrawal" formTitle="" prefix="R_" isCode="true" codeName="TWCZFS_SYZZ" isShowEN="true" width="70%">
								<option value="">--Please select--</option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle"><font color="red">*</font>退文原因<br>Reason for withdrawal</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" prefix="R_" formTitle="Reason for withdrawal" defaultValue=""  style="width:75%" maxlength="1000"/>
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
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="Last step" class="btn btn-sm btn-primary" onclick="_goback();"/>&nbsp;
			<input type="button" value="Cancel" class="btn btn-sm btn-primary" onclick="_cancel();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
