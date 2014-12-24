<%
/**   
 * @Title: addmaterial_supplement.jsp
 * @Description:  补充预批材料页面
 * @author panfeng   
 * @date 2014-9-14下午3:43:13 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	//生成token串
	//TokenProcessor processor=TokenProcessor.getInstance();
	//String token=processor.getToken(request);
	
	//获取附件信息ID
	String ra_id = (String)request.getAttribute("RA_ID");
	String user_org_id = "org_id=" + (String)request.getAttribute("ORG_ID") + ";ra_id=" + ra_id;
%>
<BZ:html>
	<BZ:head language="EN">
		<title>补充预批申请材料</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
		
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		});
		
		//保存操作
		function _save() {
			document.getElementById("R_AA_STATUS").value = 1;
			document.srcForm.action = path + "sce/addMaterial/addMaterialSave.action?type=save";
			document.srcForm.submit();
		}
		//提交操作
		function _submit() {
			if(confirm("Are you sure you want to submit?")){
				document.getElementById("R_AA_STATUS").value = 2;
				document.srcForm.action = path + "sce/addMaterial/addMaterialSave.action?type=submit";
				document.srcForm.submit();
			}
		}
		
		//修改基本信息
		function _modInfo() {
			var ri_id = document.getElementById("R_RI_ID").value;
			//document.srcForm.action = path + "sce/addMaterial/modInfoPO.action?type=info&ri_id="+ri_id;
			//document.srcForm.submit();
			var url = path + "sce/addMaterial/modInfoPO.action?type=info&ri_id="+ri_id;
			//window.open(url,this,'height=600,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			_open(url, "window", 1000, 600);
		}
		
		//修改抚育计划和组织意见
		function _modPlanOrOpinion() {
			var ri_id = document.getElementById("R_RI_ID").value;
			//document.srcForm.action = path + "sce/addMaterial/modInfoPO.action?type=PO&ri_id="+ri_id;
			//document.srcForm.submit();
			var url = path + "sce/addMaterial/modInfoPO.action?type=PO&ri_id="+ri_id;
			_open(url, "window", 1000, 600);
		}
		
		//页面返回
		function _goback(){
			window.location.href=path+'sce/addMaterial/findMaterialList.action';
		}
		</script>
	</BZ:head>
	<script>
	</script>
</BZ:html>
<BZ:body property="supdata">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="RA_ID" id="R_RA_ID" type="hidden" />
	<BZ:input prefix="R_" field="RI_ID" id="R_RI_ID" type="hidden" />
	<BZ:input prefix="R_" field="AA_STATUS" id="R_AA_STATUS" type="hidden" />
	<BZ:input prefix="R_" field="IS_ADDATTACH" id="R_IS_ADDATTACH" type="hidden" defaultValue=""/>
	<!-- 编辑区域begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>补充通知回复(SUPPLEMENTARY NOTICE REPLY)</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">通知人<br>NOTICE PERSON</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="SEND_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">通知日期<br>Date of notification</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" type="Date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">通知部门<br>NOTICE DEPARTMENT</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="ADD_TYPE" defaultValue="" checkValue="1=Audit Department;2=Resettlement Department;"/>
							<BZ:input prefix="R_" field="ADD_TYPE" id="R_ADD_TYPE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">通知内容<br>NOTICE CONTENT</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NOTICE_CONTENT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">回复日期<br>Date of reply</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" type="Date"/>
							<BZ:input prefix="R_" field="FEEDBACK_DATE" id="R_FEEDBACK_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">补充状态<br>Supplement status</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AA_STATUS" defaultValue="" checkValue="0=to be added;1=in process of adding;2=added"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">回复内容<br>REPLY CONTENT</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="ADD_CONTENT_EN" id="R_ADD_CONTENT_EN" type="textarea" prefix="R_" formTitle="补充说明" defaultValue=""  style="width:70%;height:200px" maxlength="4000"/>
						</td>
					</tr>
					<tr id="isapply_attach">
						<td class="bz-edit-data-title">回复附件<br>REPLY MATERIAL</td>
						<td class="bz-edit-data-value" colspan="5">
							<up:uploadBody 
									attTypeCode="AF" 
									bigType="<%=AttConstants.AF %>"
									smallType="<%=AttConstants.AF_YPBCFJ %>"
									id="R_UPLOAD_IDS"
									name="R_UPLOAD_IDS"
									packageId="<%=ra_id %>"
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="<%=user_org_id %>"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
								/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 编辑区域end -->
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save();"/>&nbsp;
			<%
			Data supdata = (Data)request.getAttribute("supdata");
			String is_modify = supdata.getString("IS_MODIFY","");
			String add_type = supdata.getString("ADD_TYPE","");
			if("1".equals(is_modify) && "1".equals(add_type)){
			%>
			<input type="button" value="Modify basic information" class="btn btn-sm btn-primary" onclick="_modInfo();"/>&nbsp;
			<%
			}else if("1".equals(is_modify) && "2".equals(add_type)){
			%>
			<input type="button" value="Modify care plan and agency comments" class="btn btn-sm btn-primary" onclick="_modPlanOrOpinion();"/>&nbsp;
			<%
			}else{
			%>&nbsp;<%} %>
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>