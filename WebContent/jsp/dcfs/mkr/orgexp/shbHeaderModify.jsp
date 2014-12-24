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
    
    String id = (String)request.getAttribute("ID");
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
%>
<BZ:html>
<BZ:head>
	<title>负责人</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	//加载iframe
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
	});
	
	function _save(){
    	//页面表单校验
    	if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/orgexpmgr/headerModifySubmit.action";
	 		document.organForm.submit();
    	}
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="SEX;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 审核信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" prefix="ORG_" field="ID" defaultValue='<%=id %>'/>
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:input field="NAME" defaultValue="" notnull="请输入姓名" style="width:90%" maxlength="20" prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title" rowspan="3">照片</td>
						<td class="bz-edit-data-value" rowspan="3">
							<up:uploadImage 
								attTypeCode="OTHER"
								id="MKR_PHOTO" 
								packageId='<%=data.getString("PHOTO") %>' 
								name="MKR_PHOTO" 
								imageStyle="width:100px;height:100px;"
								autoUpload="true"
								hiddenSelectTitle="true"
								hiddenProcess="false"
								hiddenList="true"
								selectAreaStyle="border:0;width:100px;"
								proContainerStyle="width:100px;line-height:0px;"
								/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value">
							<BZ:select field="SEX" prefix="MKR_" width="100px"  formTitle="" codeName="SEX" isCode="true"></BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:input field="BIRTHDAY"  style="width:100px" defaultValue="" type="date" prefix="MKR_" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职务</td>
						<td class="bz-edit-data-value">
							<BZ:input field="POSITION"  style="width:90%" defaultValue="" prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE"  style="width:90%"  restriction="telephone" defaultValue="" prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" defaultValue=""  style="width:90%"  prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">电子邮件</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL"  style="width:90%"  defaultValue="" restriction="email" prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">简要履历</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_BRIEF_RESUME" rows="4" cols="85%"><%=data.getString("BRIEF_RESUME")!=null&&!"".equals(data.getString("BRIEF_RESUME"))?data.getString("BRIEF_RESUME"):"" %></textarea>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<textarea name="MKR_REMO" rows="4" cols="85%"><%=data.getString("REMO")!=null&&!"".equals(data.getString("REMO"))?data.getString("REMO"):"" %></textarea>		
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
			<!-- <input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback()"/> -->
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
