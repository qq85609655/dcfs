<%
/**   
 * @Title: normalFile_addFirst.jsp
 * @Description:  收养组织递交普通文件第一步操作页面
 * @author yangrt   
 * @date 2014-7-22 上午11:13:34 
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
%>
<BZ:html>
	<BZ:head language="EN">
		<title>新增普通文件第一步操作页面</title>
		<BZ:webScript edit="true" isAjax="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		});
		
		//新增文件代录信息
		function _submit(){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			//获取收养组织code
			var adopt_org = $("#R_ADOPT_ORG_ID").val();
			//文件类型code
			var file_type = $("#R_FILE_TYPE").val();
			//获取男收养人姓名
			var malename = $("#R_MALE_NAME").val();
			//获取女收养人姓名
			var femalename = $("#R_FEMALE_NAME").val();
			//将收养组织code、男收养人姓名、女收养人姓名拼串
			var strname = adopt_org + "#" + malename + "#" + femalename + "#" + file_type;
			
			//将strname编码
			var name = encodeURI(strname);
			//检查该收养组织中是否已存在相同男收养人、女收养人的家庭文件
			var data = getData('com.dcfs.ffs.fileManager.FileManagerAjax','method=getFileData&name=' + name);
			//获取文件ID
			var file_id = data.getString("AF_ID","");
			if(file_id != ""){
				if(confirm("Your agency has unsubmitted adoption applications of families with the same name. Are you sure to fill in a new application?")){
					//表单提交
					$("#R_FAMILY_TYPE").attr("disabled",false);
					var obj = document.forms["srcForm"];
					obj.action=path+'ffs/filemanager/NormalFileSaveFirst.action?AF_ID=' + file_id;
					obj.submit();
				}
			}else if(confirm("Are you sure you want to continue to the next step?")){
				//表单提交
				$("#R_FAMILY_TYPE").attr("disabled",false);
				var obj = document.forms["srcForm"];
				obj.action=path+'ffs/filemanager/NormalFileSaveFirst.action';
				obj.submit();
			}
			
		}
		
		//返回递交普通文件列表页面
		function _goback(){
			window.location.href=path+'ffs/filemanager/NormalFileList.action';
		}
		
		//文件类型为继子女收养时，收养类型下拉列表只能选择男收养或女收养
		function _dynamicJznsy(){
			var sylx = $("#R_FILE_TYPE").find("option:selected").val();
			if(sylx=="33"){
				//设置收养类型为双亲收养，并置灰
				$("#R_FAMILY_TYPE")[0].selectedIndex = 2; 
				$("#R_FAMILY_TYPE").attr("disabled",true);
				$("#AdopterSex").show();
				$("#R_SEX").attr("notnull","please input adopter's sex!");
			}else{
				$("#R_FAMILY_TYPE")[0].selectedIndex = 0; 
				$("#R_FAMILY_TYPE").attr("disabled",false);   
				$("#R_ADOPTER_SEX").val("");
				$("#AdopterSex").hide();
				$("#R_SEX").removeAttr("notnull");
				$("#R_SEX").val("");
			}
			$("#MaleInfo").hide();
			$("#R_MALE_NAME").removeAttr("notnull");
			$("#R_MALE_NAME").val("");
			$("#FemaleInfo").hide();
			$("#R_FEMALE_NAME").removeAttr("notnull");
			$("#R_FEMALE_NAME").val("");
		}
		
		//根据收养类型，动态对男女姓名、出生日期进行只读和必填项设置
		function _dynamicHide(){
			var file_type = $("#R_FILE_TYPE").find("option:selected").val();
			var optionText = $("#R_FAMILY_TYPE").find("option:selected").val();
			if(optionText=="2"){
				if(file_type == "34"){
					$("#AdopterSex").show();
					$("#R_SEX").attr("notnull","please input adopter's sex!");
					$("#MaleInfo").hide();
					$("#R_MALE_NAME").removeAttr("notnull");
					$("#R_MALE_NAME").val("");
					$("#FemaleInfo").hide();
					$("#R_FEMALE_NAME").removeAttr("notnull");
					$("#R_FEMALE_NAME").val("");
				}else{
					$("#R_ADOPTER_SEX").val(optionText);
					$("#MaleInfo").hide();
					$("#R_MALE_NAME").removeAttr("notnull");
					$("#FemaleInfo").show();
					$("#R_FEMALE_NAME").attr("notnull","please input female adopter's name!");
				}
			}else if(optionText=="1"){
				$("#AdopterSex").hide();
				$("#R_SEX").removeAttr("notnull");
				$("#MaleInfo").show();
				$("#FemaleInfo").show();
				$("#R_MALE_NAME").attr("notnull","please input male adopter's name!");
				$("#R_FEMALE_NAME").attr("notnull","please input female adopter's name!");
			}
		}
		
		//设置收养人性别
		function _setAdopterSex(){
			var val = $("#R_SEX").find("option:selected").val();
			$("#R_ADOPTER_SEX").val(val);
			if(val=="2"){
				//$("#R_MALE_NAME").css({background: "rgb(240, 240, 240)" });
				
				$("#MaleInfo").hide();
				$("#R_MALE_NAME").removeAttr("notnull");
				$("#R_MALE_NAME").val("");
				$("#FemaleInfo").show();
				$("#R_FEMALE_NAME").attr("notnull","please input female adopter's name!");
			}else if(val=="1"){
				$("#MaleInfo").show();
				$("#R_MALE_NAME").attr("notnull","please input male adopter's name!");
				$("#FemaleInfo").hide();
				$("#R_FEMALE_NAME").removeAttr("notnull");
				$("#R_FEMALE_NAME").val("");
			}
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="ZCWJLX;">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="NAME_CN" id="R_NAME_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="NAME_EN" id="R_NAME_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="COUNTRY_CN" id="R_COUNTRY_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="COUNTRY_EN" id="R_COUNTRY_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
	<!-- 隐藏区域end -->
	<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 60%;margin-left: auto;margin-right: auot;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">收养组织(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">收养组织(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>文件类型<br>Document type</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" isShowEN="true" formTitle="Document type" isCode="true" codeName="ZCWJLX" notnull="请选择文件类型" onchange="_dynamicJznsy()" width="50%">
									<option value="">--Please select--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>收养类型<br>Adoption type</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" formTitle="Adoption type" isCode="false" notnull="请选择收养类型" onchange="_dynamicHide()" width="50%">
									<option value="">--Please select--</option>
									<option value="1">Two parents</option>
									<option value="2">Single parent</option>
								</BZ:select>
							</td>
						</tr>
						<tr id="AdopterSex" style="display:none">
							<td class="bz-edit-data-title"><font color="red">*</font>收养人性别</td>
							<td class="bz-edit-data-value">
								<BZ:select field="SEX" id="R_SEX" formTitle="" prefix="R_" isCode="false" width="50%" onchange="_setAdopterSex()">
									<option value="">--Please select--</option>
									<option value="1">Male</option>
									<option value="2">Female</option>
								</BZ:select>
							</td>
						</tr>
						<tr id="MaleInfo" style="display:none">
							<td class="bz-edit-data-title"><font color="red">*</font>男收养人<br>Adoptive father</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_NAME" id="R_MALE_NAME" type="String" notnull="sdfafasd"  formTitle="Adoptive father" defaultValue="" style="width:75%;" maxlength="150"/>
							</td>
						</tr>
						<tr id="FemaleInfo" style="display:none">
							<td class="bz-edit-data-title poptitle"><font color="red">*</font>女收养人<br>Adoptive mother</td>
							<td class="bz-edit-data-value" >
								<BZ:input prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" type="String"  formTitle="Adoptive mother" defaultValue="" style="width:75%" maxlength="150"/>
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
				<input type="button" value="Next step" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>