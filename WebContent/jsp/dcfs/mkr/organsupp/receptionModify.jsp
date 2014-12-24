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
<BZ:head language="EN">
	<title>在华旅行接待信息维护(Tour reception in China)</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//公共功能，框架元素自适应
	});
	
	//提交联系人信息
	function _save(){
    	//页面表单校验
    	if (_check(document.organForm)) {
			document.organForm.action=path+"mkr/organSupp/receptionModifySubmit.action";
	 		document.organForm.submit();
    	}
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="JDFLX;FZRLB;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!--在华旅行接待信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					在华旅行接待情况信息(Tour reception in China information)
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
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
						<td class="bz-edit-data-title">接待方类型<br>Recipient</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="RECEIVE_TYPE" id="MKR_RECEIVE_TYPE" width="170px" isCode="true" codeName="JDFLX" isShowEN="true" formTitle="接待方类型" notnull="请输入接待方类型" defaultValue="">
								<BZ:option value="">--Please select--</BZ:option>
							</BZ:select>	
							<BZ:input field="ADOPT_ORG_ID" id="MKR_ADOPT_ORG_ID" type="hidden" defaultValue="" prefix="MKR_"/>
						</td>
						<td class="bz-edit-data-title">负责人类别<br>Person in charge</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="HEADER_TYPE" width="170px" id="MKR_HEADER_TYPE" isCode="true" codeName="FZRLB" isShowEN="true" notnull="请输入负责人类别" formTitle="负责人类别" defaultValue="">
								<BZ:option value="">--Please select--</BZ:option>
							</BZ:select>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">姓名<br>Name</td>
						<td class="bz-edit-data-value">
							<BZ:input field="NAME"  defaultValue="" prefix="MKR_" style="width:90%" maxlength="20" notnull="请输入姓名"/>	
							<BZ:input field="ID" defaultValue="" id="MKR_ID" prefix="MKR_" type="hidden"/>
						</td>
						<td class="bz-edit-data-title">身份证号码<br>ID number</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ID_NUMBER"  defaultValue="" style="width:90%" prefix="MKR_" restriction="number" notnull="请输入身份证号码"  maxlength="20"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">电话号码<br>Telephone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE"  defaultValue="" style="width:90%" prefix="MKR_" restriction="telephone"/>				
						</td>
						<td class="bz-edit-data-title">手机号码<br>Cellphone</td>
						<td class="bz-edit-data-value">
							<BZ:input field="MOBEL" defaultValue="" style="width:90%" prefix="MKR_" restriction="mobile"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">传真<br>Fax</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX"  defaultValue="" style="width:90%" prefix="MKR_" />				
						</td>
						<td class="bz-edit-data-title">邮箱<br>Email</td>
						<td class="bz-edit-data-value">
							<BZ:input field="EMAIL" defaultValue="" style="width:90%" prefix="MKR_" restriction="email"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">工作单位<br>Organization/Company</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="WORK_UNIT" defaultValue="" prefix="MKR_" style="width:80%"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址<br>Address</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" defaultValue="" prefix="MKR_" style="width:80%"/>			
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
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
