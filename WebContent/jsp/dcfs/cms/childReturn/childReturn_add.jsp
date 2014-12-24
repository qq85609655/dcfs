<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String RETURN_LEVEL = (String)request.getAttribute("RETURN_LEVEL");
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
	String ci_id = (String)data.getString("CI_ID");
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";ci_id=" + ci_id;
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料退材料申请（代录）页面</title>
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
		//提交儿童材料退材料信息
		function _submit(){
            var APPLE_TYPE=document.getElementById('R_APPLE_TYPE').value;
            if(APPLE_TYPE==''){
            	alert('请选择退材料类型');
            	return;
            }
            var RETURN_REASON=document.getElementById('R_RETURN_REASON').value;
            if(RETURN_REASON==''){
            	alert('请填写退材料原因');
            	return;
            }
          //上传附件校验
			var table = document.getElementById('infoTable'+'scfj');
            var trs=table.rows;
       		var trsLen = trs.length;
            if(trsLen == 0){
                alert('请上传附件');
                return;
            }
            if(trsLen > 0){
                var tds = trs[0].cells;
                var succ = tds[2].innerHTML;
                if(succ == '' || succ.indexOf('OK') < 0){
                	alert('请上传附件');
                    return;
                }
            }
	        if(confirm('确定提交吗？')){
				document.srcForm.action = path+'cms/childreturn/saveReturnData.action';
				document.srcForm.submit();
			}
		}
		
		//返回补退材料列表页面
		function _goback(signal){
			if(signal=='1'){
				window.location.href=path+'cms/childreturn/returnListFLY.action';
			}else if(signal=='2'){
				window.location.href=path+'cms/childreturn/returnListST.action';
			}else if(signal=='3'){
				window.location.href=path+'cms/childreturn/returnListZX.action';
			}
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;CHILD_TYPE;BCZL;TCLLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<input name="RETURN_LEVEL" id="RETURN_LEVEL" type="hidden" value="<%=RETURN_LEVEL%>"/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<!-- 隐藏区域end -->
		<br/>
		<!-- 编辑区域begin -->
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童信息</div>
				</div>
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">福利院</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">儿童姓名</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">性别</td>
							<td class="bz-edit-data-value" width="21%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">儿童类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE"  onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL"  onlyValue="true" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;"">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>退材料信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
						    <td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">申请人</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="APPLE_PERSON_NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">申请日期</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="APPLE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">退材料类型<font color=red>*</font></td>
							<td class="bz-edit-data-value" width="21%">
								<BZ:select prefix="R_" field="APPLE_TYPE" id="R_APPLE_TYPE" isCode="true" codeName="TCLLX" formTitle="退材料类型" defaultValue="" width="100%" notnull="请选择退材料类型">
										<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">附件<font color=red>*</font></td>
							<td class="bz-edit-data-value" colspan="5" >
                            <up:uploadBody attTypeCode="CI"
							name="R_UPLOAD_IDS" id="scfj" packageId="<%=affix%>" 
							queueStyle="border: solid 1px #7F9DB9;;width:80%;" autoUpload="true"
									selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;width:80%;" smallType="<%=AttConstants.CI_CLTW %>"  bigType="CI"  diskStoreRuleParamValues="<%=org_af_id %>"></up:uploadBody>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">退材料原因<font color=red>*</font></td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" defaultValue="" maxlength="1000" style="width:80%;" />
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
				<input type="button" value="提 交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="取消" class="btn btn-sm btn-primary" onclick="_goback('<%=RETURN_LEVEL %>')"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>