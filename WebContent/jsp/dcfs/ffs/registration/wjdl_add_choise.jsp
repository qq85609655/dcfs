<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: wjdl_add_choise.jsp
	 * @Description:  文件代录选择文件类型及收养类型
	 * @author mayun   
	 * @date 2014年11月24日
	 * @version V1.0   
	 */
	 
	 //获取附件信息ID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
	
%>
<BZ:html>
	<BZ:head>
		<title>文件代录选择文件类型及收养类型页面</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		//下一步
		function _next(){
		
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			var FAMILY_TYPE_VIEW = $("#P_FAMILY_TYPE").find("option:selected").text();
			var ADOPTER_SEX_VIEW = $("#P_ADOPTER_SEX").find("option:selected").text();
			$("#P_FAMILY_TYPE_VIEW").val(FAMILY_TYPE_VIEW);
			$("#P_ADOPTER_SEX_VIEW").val(ADOPTER_SEX_VIEW);
			
			var obj = document.forms["srcForm"];
			obj.action=path+"/ffs/registration/toAddFlieRecord.action";
			obj.submit();
		}
		
		//根据收养类型动态向收养人性别赋值
		function _dySetSyrxb(){
			var sylx = $("#P_FAMILY_TYPE").find("option:selected").text();
			if(sylx=="单亲收养（女）"){
				$("#P_ADOPTER_SEX")[0].selectedIndex = 2; 
			}else if(sylx=="单亲收养（男）"){
				$("#P_ADOPTER_SEX")[0].selectedIndex = 1; 
			}else{
				$("#P_ADOPTER_SEX")[0].selectedIndex = 0; 
			}
		}
		
		/**
		*文件类型为继子女收养时，收养类型下拉列表只能选择男收养或女收养
		*@author:mayun
		*@date:2014-7-17
		*/
		function _dynamicJznsy(){
			var sylx = $("#P_FILE_TYPE").find("option:selected").text();
			if(sylx=="继子女收养"){
				//设置收养类型为双亲收养，并置灰
				$("#P_FAMILY_TYPE")[0].selectedIndex = 1; 
				$("#P_FAMILY_TYPE").attr("disabled",true);
				$("#syrxb").show();
				$("#syrxb2").show();
				$("#P_ADOPTER_SEX").attr("notnull","请输入收养人性别");
			}else{
				$("#P_FAMILY_TYPE")[0].selectedIndex = 0; 
				$("#P_FAMILY_TYPE").attr("disabled",false);   
				$("#syrxb").hide();
				$("#syrxb2").hide();
				$("#P_ADOPTER_SEX").removeAttr("notnull");
			}
		}
		
	</script>
	<BZ:body property="wjdlData" codeNames="WJLX_DL">
		<BZ:form name="srcForm" method="post" action="">
		<BZ:input type="hidden" field="FAMILY_TYPE_VIEW" prefix="P_" id="P_FAMILY_TYPE_VIEW" defaultValue="" />
		<BZ:input type="hidden" field="ADOPTER_SEX_VIEW" prefix="P_" id="P_ADOPTER_SEX_VIEW" defaultValue="" />
		<!-- 进度条begin -->
		<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 98%;margin-left:auto;margin-right:auto;">
			<div class="stepflex" style="margin-right: 30px;">
		        <dl id="payStepFrist" class="first doing">
		            <dt class="s-num">1</dt>
		            <dd class="s-text" style="margin-left: 3px;">第一步：选择文件和收养类型</dd>
		        </dl>
		        <dl id="payStepNormal" class="last">
		            <dt class="s-num">2</dt>
		            <dd class="s-text" style="margin-left: 3px;">第二步：录入文件和费用信息<s></s>
		                <b></b>
		            </dd>
		        </dl>
			</div>
		</div>
		<!-- 进度条end -->
		
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>选择文件概要信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>文件类型</td>
							<td class="bz-edit-data-value" cols="2" width="20%">
								<BZ:select field="FILE_TYPE" id="P_FILE_TYPE" notnull="请输入文件类型" formTitle="" prefix="P_" isCode="true" codeName="WJLX_DL" onchange="_dySetSyrxb()" width="70%">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>收养类型</td>
							<td class="bz-edit-data-value" cols="2" width="20%">
								<BZ:select field="FAMILY_TYPE" id="P_FAMILY_TYPE" notnull="请输入收养类型" formTitle="" prefix="P_" isCode="false" width="70%" onchange="_dySetSyrxb()">
									<option value="">--请选择--</option>
									<option value="1">双亲收养</option>
									<option value="2">单亲收养（女）</option>
									<option value="2">单亲收养（男）</option>
								</BZ:select>
							</td>
							<!-- 
							<td class="bz-edit-data-title" width="10%" id="syrxb" style="display:none"><font color="red">*</font>收养人性别</td>
							<td class="bz-edit-data-value" cols="2" width="20%" id="syrxb2" style="display:none">
								<BZ:select field="ADOPTER_SEX" id="P_ADOPTER_SEX" notnull="请输入收养人性别" formTitle="" prefix="P_" isCode="false" width="70%">
									<option value="">--请选择--</option>
									<option value="1">男</option>
									<option value="2">女</option>
								</BZ:select>
							</td>
							 -->
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- 编辑区域end -->
		
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="下一步" class="btn btn-sm btn-primary" onclick="_next()"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		
		
		</BZ:form>
	</BZ:body>
</BZ:html>