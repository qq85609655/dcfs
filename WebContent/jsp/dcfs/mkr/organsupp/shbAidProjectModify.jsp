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
    
    Data data = (Data)request.getAttribute("data");
    String ID = data.getString("ADOPT_ORG_ID","");  //组织机构ID
%>
<BZ:html>
<BZ:head>
	<title>援助或捐赠项目维护</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//公共功能，框架元素自适应
	});
	function _save(){
    	//页面表单校验
    	if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/organSupp/aidProjectModifySubmit.action";
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
					援助和捐助项目信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">项目名称</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ITEM_NAME" defaultValue="" prefix="MKR_" style="width:90%" maxlength="20" notnull="请输入项目名称"/>		
							<BZ:input field="ADOPT_ORG_ID" id="MKR_ADOPT_ORG_ID" type="hidden" defaultValue="" prefix="MKR_"/>
						</td>
						<td class="bz-edit-data-title">项目负责人</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ITEM_HEADER" defaultValue="" prefix="MKR_" maxlength="20" style="width:90%" notnull="请输入项目负责人"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">合作方名称</td>
						<td class="bz-edit-data-value">
							<BZ:input field="COLLABORATION_NAME" style="width:90%" defaultValue="" prefix="MKR_" maxlength="20" notnull="请输入合作方名称"/>	
							<BZ:input field="ID" defaultValue="" id="MKR_ID" prefix="MKR_" type="hidden"/>
						</td>
						<td class="bz-edit-data-title">受益对象</td>
						<td class="bz-edit-data-value">
							<BZ:input field="PROFITOR" style="width:90%"  defaultValue="" prefix="MKR_" maxlength="20"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">开始时间</td>
						<td class="bz-edit-data-value">
							<BZ:input field="BEGIN_TIME" type="date" style="width:100px" id="MKR_BEGIN_TIME" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_END_TIME\\')}',readonly:true" defaultValue="" prefix="MKR_"/>
						</td>
						<td class="bz-edit-data-title">结束时间</td>
						<td class="bz-edit-data-value">
							<BZ:input field="END_TIME" style="width:100px"  type="date" id="MKR_END_TIME"   dateExtend="minDate:'#F{$dp.$D(\\'MKR_BEGIN_TIME\\')}',readonly:true" defaultValue="" prefix="MKR_"/>			
											
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">投入金额</td>
						<td class="bz-edit-data-value">
							<BZ:input field="INVESTED_FUNDS" style="width:100px" defaultValue="" prefix="MKR_" restriction="number" />万元				
						</td>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE" style="width:90%" defaultValue="" prefix="MKR_" restriction="telephone"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮箱</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="EMAIL" style="width:90%" defaultValue="" prefix="MKR_" restriction="email"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">项目所在地</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" style="width:90%" defaultValue="" prefix="MKR_" style="width:80%"/>			
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
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_save();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
