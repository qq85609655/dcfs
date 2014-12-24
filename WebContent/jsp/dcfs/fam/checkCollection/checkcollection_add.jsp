<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: checkcollection_add.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-10-20 下午14:27:38 
 * @version V1.0   
 */
 
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
%>
<BZ:html>

<BZ:head language="CN">
	<title>支票托收</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	
	//提交
	function _submit(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action = path + "fam/checkCollection/checkCollectionSave.action";
			document.srcForm.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'fam/checkCollection/checkCollectionList.action';
	}
	
</script>

<BZ:body codeNames="GJSY" property="data">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input prefix="R_" field="NUM" type="hidden" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>支票托收表</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: center; border-right:none;">
								<font size="2px"><strong>托收人：
									<BZ:dataValue field="COLLECTION_USERNAME" defaultValue="" onlyValue="true"/>
									<BZ:input prefix="R_" field="COLLECTION_USERNAME" type="hidden" defaultValue=""/></strong>
								</font>
							</td>
							<td class="bz-edit-data-title" width="55%" style="text-align: right; border-left:none; border-right:none;">
							</td>
							<td class="bz-edit-data-title" width="40%" style="text-align: right; border-left:none;">
								<font size="2px"><strong><font color="red">*</font>托收日期：</strong>
									<BZ:input field="COLLECTION_DATE" id="R_COLLECTION_DATE" prefix="R_" type="date" notnull="请输入托收日期"/>
								</font>
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table table-striped table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
										<tr style="background-color: rgb(180, 180, 249);">
											<th style="width: 5%; text-align: center;">
												<div class="sorting_disabled">序号</div></th>
											<th style="width: 8%; text-align: center;">
												<div class="sorting_disabled" id="COUNTRY_CODE">国家</div></th>
											<th style="width: 15%; text-align: center;">
												<div class="sorting_disabled" id="NAME_CN">收养组织</div></th>
											<th style="width: 12%; text-align: center;">
												<div class="sorting_disabled" id="PAID_NO">缴费编号</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="BILL_NO">支票票号</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="PAR_VALUE">票面金额</div></th>
											<th style="width: 40%; text-align: center;">
												<div class="sorting_disabled" id="COLLECTION_REMARKS">备注</div></th>
										</tr>
									</thead>
									<tbody>
										<BZ:for property="List" fordata="fordata">
											<tr>
												<td class="center" style="vertical-align:middle;">
													<BZ:i/>
													<BZ:input prefix="P_" field="CHEQUE_ID" type="hidden" property="fordata" />
												</td>
												<td class="center" style="vertical-align:middle;"><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/>
												<td style="vertical-align:middle;"><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
												<td class="center" style="vertical-align:middle;"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
												<td class="center" style="vertical-align:middle;"><BZ:data field="BILL_NO" defaultValue="" onlyValue="true"/></td>
												<td style="vertical-align:middle;"><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true"/></td>
												<td><BZ:input field="COLLECTION_REMARKS" id="P_COLLECTION_REMARKS" prefix="P_" type="textarea"  formTitle="托收备注" property="fordata" defaultValue="" style="width:98%" maxlength="1000"/></td>
											</tr>
										</BZ:for>
									</tbody>
								</table>
								<table class="bz-edit-data-table" border="0">
									<tr>
										<td class="bz-edit-data-title" width="50%" style="text-align: center; border-top:none;">
											<font size="2px"><strong>合计</strong></font>
										</td>
										<td class="bz-edit-data-value" width="10%" style="border-top:none;">
											<BZ:dataValue field="SUM" defaultValue="" onlyValue="true"/>
											<BZ:input prefix="R_" field="SUM" type="hidden" defaultValue=""/>
										</td>
										<td class="bz-edit-data-value" width="40%" style="border-top:none;">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td class="bz-edit-data-value" width="15%" height="50px" style="text-align: center; border-right:none;">
							</td>
							<td class="bz-edit-data-value" width="65%" style="text-align: right; border-left:none; border-right:none;">
							</td>
							<td class="bz-edit-data-value" width="30%" style="text-align: center; border-left:none;">
								<font size="2px"><strong>制表日期：
									<BZ:dataValue field="COLLECTION_DATE" type="date" defaultValue="" onlyValue="true"/></strong>
								</font>
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
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
