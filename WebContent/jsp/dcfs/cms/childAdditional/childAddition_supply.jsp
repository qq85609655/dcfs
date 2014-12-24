<%
/**   
 * @Title: childAddition_supply.jsp
 * @Description:  儿童材料信息补充页面
 * @author furx   
 * @date 2014-9-9 下午14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String signal = (String)request.getAttribute("signal");
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
	String isModify=(String)data.getString("IS_MODIFY");
	String ci_id = (String)data.getString("CI_ID");
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";ci_id=" + ci_id;
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料信息补充页</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
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

		//保存儿童材料补充信息
		function _save(){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else if(confirm("确定保存吗？")){
					document.getElementById("R_CA_STATUS").value = "1";
				document.srcForm.action = path+"cms/childaddition/childSupplySave.action";
				document.srcForm.submit();
			}
		}
		
		//提交儿童材料补充信息
		function _submit(){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else if(confirm("确定提交吗？")){
					document.getElementById("R_CA_STATUS").value = "2";
				document.srcForm.action = path+"cms/childaddition/childSupplySave.action";
				document.srcForm.submit();
			}
		}
		
		//返回补充文件列表页面
		function _goback(signal){
			if(signal=='1'){
				window.location.href=path+'cms/childaddition/findListFLY.action';
				}else if(signal=='2'){
					window.location.href=path+'cms/childaddition/findListST.action';
					}
		}
		
		function _close(){
			window.close();
		}
		
		//进入儿童材料基本信息修改页面
		function _toMofify(){
			var CI_ID =document.getElementById("R_CI_ID").value;
			var url = path + "/cms/childManager/toChildInfoModify.action?CI_ID=" + CI_ID;
			_open(url, "window", 1100, 700);
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<input name="signal" id="signal" type="hidden" value="<%=signal%>"/>
		<BZ:input type="hidden" prefix="R_" field="CA_ID" id="R_CA_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CA_STATUS" id="R_CA_STATUS" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="SOURCE" id="R_SOURCE" defaultValue=""/>
		<br/>		
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<!--<div class="bz-edit clearfix">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童材料信息</div>
				</div>
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">编号</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="CHILD_NO" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">姓名</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">性别</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">省份</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">福利院</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">儿童类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE"  onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		-->
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>通知信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
					    <tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知来源</td>
							<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="SOURCE" onlyValue="true" defaultValue="" checkValue="2=省厅;3=中心;"/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知人</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEND_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知日期</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="NOTICE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">通知内容</td>
							<td class="bz-edit-data-value" colspan="5" width="85%">
								<BZ:dataValue field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- bz-edit  -->
		<div class="clearfix"  style="margin-left: 11px;margin-right: 11px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>补充信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充单位</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_ORGNAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充人</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="FEEDBACK_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充日期</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充状态</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="CA_STATUS" onlyValue="true" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充;"/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充附件</td>
							<td class="bz-edit-data-value" colspan="2" >
                            <up:uploadBody attTypeCode="CI"
							name="R_UPLOAD_IDS" id="scfj" packageId="<%=affix%>" 
							queueStyle="border: solid 1px #7F9DB9;;" autoUpload="true"
									selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" smallType="<%=AttConstants.CI_BCCL %>"  bigType="CI"   diskStoreRuleParamValues="<%=org_af_id %>"></up:uploadBody>
							</td>
							<td class="bz-edit-data-value" width="35%">
							<%if("1".equals(isModify)){ %>
							<input type="button" value="修改材料信息" class="btn btn-sm btn-primary" onclick="_toMofify();"/>
							<% }%>
							</td>

						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">补充内容</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="R_" field="ADD_CONTENT" id="R_ADD_CONTENT" type="textarea" defaultValue="" maxlength="1000" style="width:90%;"/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" >
				<input type="button" value="保 存" class="btn btn-sm btn-primary" onclick="_save()"/>
				<input type="button" value="提 交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="取消" class="btn btn-sm btn-primary" onclick="_goback('<%=signal %>')"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>