<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_jh_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 Data data= (Data)request.getAttribute("data");
 String pub_type = data.getString("PUB_TYPE");//发布类型
 String pub_mode = data.getString("PUB_MODE");//点发类型
 String pub_orgid = data.getString("PUB_ORGID");//点发组织ID
 String country_code = data.getString("COUNTRY_CODE");//点发国家
 String adopt_org_name = data.getString("ADOPT_ORG_NAME");//点发组织名称
 String tmp_tmp_pub_orgid_name = data.getString("TMP_TMP_PUB_ORGID_NAME");//群发组织名称
 String pub_remarks = data.getString("PUB_REMARKS");//点发备注
%>
<BZ:html>
	<BZ:head>
		<title>发布类型选择页面</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<BZ:resourcePath/>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			_dynamicFblx();
			_getAzqxForFb();
			_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID');
			dyniframesize(['mainFrame']);
		});
		
		function _close(){
			window.history.back();
		}
		
	
		
		//儿童发布计划提交
		function _submit(){
			if(confirm("确定提交吗？")){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}
				//只读下拉列表重置为可编辑，目的为了后台获得此数据
				$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
				$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
				//表单提交
				var obj = document.forms["srcForm"];
				obj.action=path+'sce/publishPlan/saveFBJHInfo.action';
				obj.submit();
				//var plan_id = $("H_PLAN_ID").val();
				//_close();
				//parent.loaction.href=path+'sce/publishPlan/toModifyPlan.action?PLAN_ID='+plan_id;
			}
		}
		
		
		//根据点发、群发动态展现相关区域
		function _dynamicFblx(){
			$("#P_COUNTRY_CODE").val("");
			$("#P_PUB_ORGID").val("");
			$("#M_PUB_ORGID").val("");
			$("#PUB_ORGID").val("");
			$("#P_PUB_MODE").val("");
			$("#M_PUB_MODE").val("");
			$("#P_SETTLE_DATE_NORMAL").val("");
			$("#P_SETTLE_DATE_SPECIAL").val("");
			$("#M_SETTLE_DATE_NORMAL").val("");
			$("#M_SETTLE_DATE_SPECIAL").val("");
			$("#P_PUB_REMARKS").val("");
			
			var optionValue = $("#P_PUB_TYPE").find("option:selected").val();
			if(optionValue=="1"){//点发
				$("#P_COUNTRY_CODE").attr("notnull","请输入国家");
				$("#P_ADOPT_ORG_NAME").attr("notnull","请输入发布组织");
				$("#P_PUB_MODE").attr("notnull","请输入点发类型");
				$("#PUB_ORGID").removeAttr("notnull");
				
				$("#dfzz").show();
				$("#dflx").show();
				$("#dfbz").show();
				$("#qfzz").hide();
				$("#qflx").hide();
			}else{//群发
				$("#PUB_ORGID").attr("notnull","请选择发布组织");
				$("#P_COUNTRY_CODE").removeAttr("notnull");
				$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
				$("#P_PUB_MODE").removeAttr("notnull");
				
				$("#dfzz").hide();
				$("#dflx").hide();
				$("#dfbz").hide();
				$("#qfzz").show();
				$("#qflx").show();
			}
			
		}
	
		//获得安置期限
		function _getAzqxForFb(){
			var is_df = $("#P_PUB_TYPE").find("option:selected").val();//发布类型  1：点发  2：群发
			var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//点发类型  
			
			if(""==pub_mode){
				pub_mode=null;
			}
			
			if("1"==is_df && (""==pub_mode||null==pub_mode)){
				return;
			}else{
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getAZQXInfo&IS_DF='+is_df+'&PUB_MODE='+pub_mode,
					type: 'POST',
					dataType: 'json',
					timeout: 1000,
					success: function(data){
						var two_type1 = data[0].TWO_TYPE;//是否特别关注  0:否  1：是
						var settle_months1 = data[0].SETTLE_MONTHS;
						var two_type2 = data[1].TWO_TYPE;//是否特别关注  0:否  1：是
						var settle_months2 = data[1].SETTLE_MONTHS;
						if("1"==is_df){//点发类型
							if("0"==two_type1){//非特别关注
								$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
								$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
							}else {//特别关注
								$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
								$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
							}
						}else {//群发类型
							if("0"==two_type1){//非特别关注
								$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
								$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
							}else {//特别关注
								$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
								$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
							}
						}
					}
				})
			}
		
		}
		
		
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<BZ:input type="hidden" field="PLAN_ID" prefix="H_" id="H_PLAN_ID"/>
		<BZ:input type="hidden" field="CIIDS" id="H_CIIDS" defaultValue="" prefix="H_" />
		
		<div class="page-content">
			<div class="wrapper">
				
				<!-- 编辑区域begin -->
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>发布信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布类型</td>
									<td class="bz-edit-data-value">
										<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="请输入发布类型" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()">
											<option value="1">点发</option>
											<option value="2">群发</option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布组织</td>
									<td class="bz-edit-data-value" id="dfzz">
										<BZ:select field="COUNTRY_CODE" id="P_COUNTRY_CODE" notnull="请输入国家" formTitle="" prefix="P_" isCode="true" width="168px"
											codeName="SYS_GJSY_CN"  onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID')">
											<option value="">--请选择--</option>
										</BZ:select> —
										<BZ:select prefix="P_" field="PUB_ORGID" id="P_PUB_ORGID" notnull="请输入收养组织" formTitle="" prefix="P_" width="168px"
											onchange="_setOrgID('P_HIDDEN_PUB_ORGID',this.value)">
											<option value="">--请选择--</option>
										</BZ:select>
										<input type="hidden" id="P_HIDDEN_PUB_ORGID" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>'>
									</td>
									<td class="bz-edit-data-value" id="qfzz" style="display:none">
										<BZ:input prefix="M_" field="PUB_ORGID"  type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="选择发布组织" treeType="1" helperSync="true" showParent="false" defaultShowValue="" defaultValue="<%=pub_orgid %>" showFieldId="PUB_ORGID" notnull="请选择发布组织" style="height:13px;width:80%"  />
									</td>
								</tr>
								<tr id="dflx">
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>点发类型</td>
									<td class="bz-edit-data-value"  >
										<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="请输入点发类型" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
											<option value="">--请选择--</option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title" width="10%">安置期限</td>
									<td class="bz-edit-data-value" >
										<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>天（特别关注）
										<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>天（非特别关注）
									</td>
								</tr>
								<tr id="qflx" style="display:none">
									<td class="bz-edit-data-title" width="10%">安置期限</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>天（特别关注）
										<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>天（非特别关注）
									</td>
									
								</tr>
								<tr id="dfbz">
									<td class="bz-edit-data-title poptitle">点发备注</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="点发备注" defaultValue="" style="width:80%"  maxlength="900"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- 编辑区域end -->
				<br/>
				
			
				<!-- 按钮区 开始 -->
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="按钮区">
						<a href="###" >
							<input type="button" value="确定" class="btn btn-sm btn-primary" onclick="_submit()"/>
						</a>
						<a href="###" >
							<input type="button" value="取消" class="btn btn-sm btn-primary" onclick="_close()"/>
						</a>
					</div>
				</div>
				<!-- 按钮区 结束 -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>