<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: wjth_add.jsp
 * @Description:  
 * @author yangrt   
 * @date 2014-7-21 上午10:40:34 
 * @version V1.0   
 */
 	//构造数据对象
	Data wjdlData = new Data();
	request.setAttribute("wjdlData",wjdlData);
%>
<BZ:html>

<BZ:head language="CN">
	<title>文件退回</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	
	
	//新增文件代录信息
	function _submit(){
		if(confirm("确定将此文件退回吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//表单提交
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveFlieReturnReason.action';
			obj.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	
</script>

<BZ:body codeNames="GJSY;WJLX;WJLX_DL;SYZZ;WJDJTHYY" property="fileData">
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="REG_USERID" id="R_REG_USERID" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="REG_USERNAME" id="R_REG_USERNAME" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="REG_RETURN_DATE" id="R_REG_RETURN_DATE" defaultValue="" />
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>文件基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容显示区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">国家</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="15%">收养组织</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME_CN" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">流水号</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="AF_SEQ_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">男收养人</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">出生日期（男）</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">文件类型</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">女收养人</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">出生日期（女）</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">收文编号</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REG_REMARK" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 显示区域end -->
		<br/>
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 end -->
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>退回原因</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>退回原因</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select prefix="R_" field="REG_RETURN_REASON" isCode="true" codeName="WJDJTHYY" formTitle="退回原因" notnull="退回原因不能为空" defaultValue="" width="70%">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%">操作人</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="REG_USERNAME" hrefTitle="操作人" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">操作日期</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="REG_RETURN_DATE" type="Date" hrefTitle="操作日期" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">退回说明</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="REG_RETURN_DESC" id="R_REG_RETURN_DESC" type="textarea" formTitle="退回说明" maxlength="500" style="width:80%" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="确定" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
