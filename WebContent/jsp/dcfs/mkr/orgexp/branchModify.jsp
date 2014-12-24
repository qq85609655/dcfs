<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    //组织ID
    String ADOPT_ORG_ID = (String)request.getAttribute("ADOPT_ORG_ID");
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
%>
<BZ:html>
<BZ:head language="EN">
	<title>机构维护</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//公共功能，框架元素自适应
	});
	
	function _save(){
		if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/orgexpmgr/branchModifySubmit.action";
	 		document.organForm.submit();
		}
    }
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 审核信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					分支机构信息(Branch office information)
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=ADOPT_ORG_ID %>'/>
				<BZ:input type="hidden" prefix="MKR_" field="ID" defaultValue='<%=data.getString("ID") %>'/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">所在地区<br>Region</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="AREA" defaultValue="" notnull="请输入所在地区" prefix="MKR_" style="width:90%;"/>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">负责人<br>Director</td>
						<td class="bz-edit-data-value">
							<BZ:input field="HEADER" defaultValue="" style="width:90%" notnull="请输入负责人信息" maxlength="20" prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">电话<br>Telephone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE" restriction="telephone" style="width:90%" defaultValue="" prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮件<br>Email</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL" defaultValue="" style="width:90%" restriction="email" prefix="MKR_" />					
						</td>
						<td class="bz-edit-data-title">传真<br>Fax</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" defaultValue="" style="width:90%" prefix="MKR_" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址<br>Address</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" defaultValue="" prefix="MKR_" style="width:90%;"/>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">基本情况介绍<br>Basic information</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_INTRODUCTION_INFO" rows="4" cols="85%"><%=data.getString("INTRODUCTION_INFO")!=null&&!"".equals(data.getString("INTRODUCTION_INFO"))?data.getString("INTRODUCTION_INFO"):"" %></textarea>		
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 审核信息end -->
	
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save();"/>
			<!-- <input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback()"/> -->
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
