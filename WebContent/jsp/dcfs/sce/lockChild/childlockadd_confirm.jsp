<%
/**   
 * @Title: childlockadd_confirm.jsp
 * @Description:  儿童材料锁定页面
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>儿童材料锁定页面</title>
		<BZ:webScript edit="true" isAjax="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			function _submit(){
				var male_name = $("#R_MALE_NAME").val();
				var female_name = $("#R_FEMALE_NAME").val();
				if(male_name == "" && female_name == ""){
					alert("name of the male and female adopters cannot be both empty, please fill in!");
					return;
				}else{
					if(male_name == "" && female_name != ""){
						$("#R_ADOPTER_SEX").val("2");
					}else if(male_name != "" && female_name == ""){
						$("#R_ADOPTER_SEX").val("1");
					}
					if(confirm("Are you sure to lock this child?")){
						document.srcForm.action=path+"sce/lockchild/InitPreApproveApply.action";
						document.srcForm.submit();
					}
				}
			}
			
			function _goBack(){
				document.srcForm.action=path+"sce/lockchild/LockTypeSelect.action";
				document.srcForm.submit();
			}
		</script>
	</BZ:head>
	<BZ:body property="childdata" codeNames="SDFS;ADOPTER_CHILDREN_SEX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="FILE_TYPE" prefix="R_" id="R_FILE_TYPE" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="LOCK_MODE" prefix="R_" id="R_LOCK_MODE" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="AF_ID" prefix="R_" id="R_AF_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="ADOPTER_SEX" prefix="R_" id="R_ADOPTER_SEX" property="data" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 进度条begin -->
		<div class="stepflex" style="margin-right: 30px;">
	        <dl id="payStepFrist" class="first done">
	            <dt class="s-num">1</dt>
	            <dd class="s-text" style="margin-left: 3px;">第一步：选择锁定方式<br>Step two: Choose the family file or fill in the applicant name</dd>
	        </dl>
	        <dl id="payStepNormal" class="normal done">
	            <dt class="s-num">2</dt>
	            <dd class="s-text" style="margin-left: 3px;">第二步：选择家庭文件<br>Step two: Choose the family file<s></s>
	                <b></b>
	            </dd>
	        </dl>
	        <dl id="payStepLast" class="last doing">
	            <dt class="s-num">3</dt>
	            <dd class="s-text" style="margin-left: 3px;">第三步：锁定<br>Step three: lock <s></s>
	                <b></b>
	            </dd>
	        </dl>
		</div>
		<!-- 进度条end -->
		<div>
			<table cellspacing="0" cellpadding="0">
				<tr style="height: 2px;"></tr>
			</table>
		</div>
		<!-- 锁定的儿童信息begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童信息(Child basic Inf.)</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">姓名<br>Name</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">性别<br>Gender</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">特别关注<br>Special focus</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="attachList" fordata="attachData">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">姓名<br>Name</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="NAME_PINYIN" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="BIRTHDAY" type="Date" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">特别关注<br>Special focus</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=NO;1=YES;" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 锁定的儿童信息end -->
		<!-- 锁定方式begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="margin-top: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>锁定方式(Lock type)</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-value" style="line-height: 20px;">
								<BZ:dataValue field="" codeName="SDFS" defaultValue='<%=(String)data.getString("LOCK_MODE","") %>' onlyValue="true"/><br>
								<BZ:dataValue field="" codeName="SDFS" defaultValue='<%=(String)data.getString("LOCK_MODE","") %>' isShowEN="true" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 锁定方式end -->
		<!-- 收养人信息begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="margin-top: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>锁定确认(Confirm)</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="20%;" >男收养人<br>Adoptive father</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:input prefix="R_" field="MALE_NAME" id="R_MALE_NAME" defaultValue="" maxlength="150"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="20%">女收养人<br>Adoptive mother</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:input prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" defaultValue="" maxlength="150"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 收养人信息end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Confirm" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>