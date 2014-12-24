<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>到账确认页面</title>
		<BZ:webScript edit="true" list="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
				$("#accountinfo").hide();
				$("#R_ACOUNT_REMARKS").val("");
			});
			
			//设置使用余额账户信息的显示与隐藏
			function _setAccountShow(obj){
				var val = obj.value;
				var arriveVal = $("#R_ARRIVE_VALUE").val();	//到账金额
				if(arriveVal == ""){
					alert("请填写到账金额！");
					$("#P_IS_USED").val("O");
					return;
				}else{
					if(val == "0"){
						$("#accountinfo").hide();
						$("#R_ARRIVE_ACCOUNT_VALUE").val("");
						$("#R_ACOUNT_REMARKS").val("");
						$("#R_ARRIVE_ACCOUNT_VALUE").removeAttr("notnull");
					}else if(val == "1"){
						var shouldVal = $("#R_PAID_SHOULD_NUM").val();	//应缴金额
						if(arriveVal >= shouldVal){
							alert("到账金额已足额，不需要使用余额账户的金额！");
							$("#P_IS_USED").val("O");
							return;
						}else{
							$("#accountinfo").show();
							$("#R_ARRIVE_ACCOUNT_VALUE").attr("notnull","本次使用金额不能为空！");
						}
					}
				}
				
			}
			
			//根据使用金额设置账户余额
			function _setAccountCurr(obj){
				var val = obj.value;	//本次使用金额
				var curr = $("#P_ACCOUNT_CURR").val();	//账户余额
				var bzVal = $("#R_PAID_SHOULD_NUM").val() - $("#R_ARRIVE_VALUE").val();	//不足金额
				if(val != ""){
					if(val > bzVal){
						alert("本次使用" + bzVal + "金额就可以完费，本次使用金额不能超过" + bzVal + "！");
						$("#R_ARRIVE_ACCOUNT_VALUE").val("");
						return;
					}else{
						if(curr >= val){	//如果账户余额（curr）大于等于本次使用金额（val）
							//判断是否完费
							if(val == bzVal){
								$("#R_ARRIVE_STATE").val("1");
							}else{
								$("#R_ARRIVE_STATE").val("2");
							}
						}else{	//如果余额账户不足，则透支余额账户金额
							var limt = $("#R_ACCOUNT_LMT").val();
							if(val - curr <= limt){
								//判断是否完费
								if(val == bzVal){
									$("#R_ARRIVE_STATE").val("1");
								}else{
									$("#R_ARRIVE_STATE").val("2");
								}
							}else{
								alert("本次使用金额已超出该账户的限额！");
								$("#R_ARRIVE_ACCOUNT_VALUE").val("");
								return;
							}
						}
					}
				}
			}
			
			//提交预批申请审核
			function _submit(){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					var yjVal = $("#R_PAID_SHOULD_NUM").val();	//应缴金额
					var dzVal = $("#R_ARRIVE_VALUE").val();	//到账金额
					var zhVal = $("#P_ACCOUNT_CURR").val();	//账户余额
					var isUsed = $("#P_IS_USED").val();
					if(isUsed == "1"){
						var bcsyVal = $("#R_ARRIVE_ACCOUNT_VALUE").val();	//本次使用金额
						$("#P_ACCOUNT_CURR").val(zhVal - bcsyVal);
						$("#L_OPP_TYPE").val("1");	//操作类型(1：出账)
						$("#L_SUM").val(bcsyVal);	//账单金额
						$("#L_REMARKS").val($("#R_ACOUNT_REMARKS").val());	//操作记录备注
					}else{
						if(parseFloat(dzVal) > parseFloat(yjVal)){
							$("#P_ACCOUNT_CURR").val(parseFloat(zhVal) + parseFloat(dzVal) - parseFloat(yjVal));
							$("#L_OPP_TYPE").val("0");	//操作类型(0：入账)
							$("#L_SUM").val(dzVal - yjVal);	//账单金额
							$("#R_ARRIVE_STATE").val("1");
						}else if(dzVal == yjVal){
							$("#R_ARRIVE_STATE").val("1");
						}else{
							$("#R_ARRIVE_STATE").val("2");
						}
					}
					
					//表单提交
					document.srcForm.action = path+"fam/receiveconfirm/ReceiveConfirmSave.action";
					document.srcForm.submit();
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/receiveconfirm/ReceiveConfirmList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="JFFS;FYLB;WJLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="CHEQUE_ID" id="R_CHEQUE_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_NO" id="R_FILE_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_STATE" id="R_ARRIVE_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PAID_SHOULD_NUM" id="R_PAID_SHOULD_NUM" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_LMT" id="R_ACCOUNT_LMT" defaultValue=""/>
		<!-- 收养组织余额账户 -->
		<BZ:input type="hidden" prefix="P_" field="ORG_ID" id="R_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="P_" field="ACCOUNT_CURR" id="P_ACCOUNT_CURR" defaultValue=""/>
		<!-- 余额账户使用记录 -->
		<BZ:input type="hidden" prefix="L_" field="COUNTRY_CODE" id="L_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="PAID_NO" id="L_PAID_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="BILL_NO" id="L_BILL_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="OPP_TYPE" id="L_OPP_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="SUM" id="L_SUM" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="REMARKS" id="L_REMARKS" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
			<div class="wrapper">
				<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>票据信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="15%">缴费编号</td>
									<td class="bz-edit-data-value" width="18%">
										<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="15%">缴费方式</td>
									<td class="bz-edit-data-value" width="18%"> 
										<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="15%">费用类型</td>
									<td class="bz-edit-data-value" width="19%">
										<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">应缴金额</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">票面金额</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">&nbsp;</td>
									<td class="bz-edit-data-value">&nbsp;</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!--列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">收文编号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">文件类型</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">男收养人</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">女收养人</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">儿童姓名</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--列表区End -->
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>到账确认信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>到账日期</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="ARRIVE_DATE" id="R_ARRIVE_DATE" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="到账日期不能为空！" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>到账金额</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:input prefix="R_" field="ARRIVE_VALUE" id="R_ARRIVE_VALUE" defaultValue="" restriction="number" maxlength="22" notnull="到账金额不能为空！"/>
							</td>
							<td class="bz-edit-data-title" width="15%">是否需要使用结余账户</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:select prefix="P" field="IS_USED" id="P_IS_USED" formTitle="" width="60%" onchange="_setAccountShow(this)">
									<BZ:option value="0" selected="true">否</BZ:option>
									<BZ:option value="1">是</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">收款摘要</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ARRIVE_REMARKS" id="R_ARRIVE_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" id="accountinfo">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">当前账户余额</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">结余账户使用上限</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>本次使用金额</td>
							<td class="bz-edit-data-value" width="19%"> 
								<BZ:input prefix="R_" field="ARRIVE_ACCOUNT_VALUE" id="R_ARRIVE_ACCOUNT_VALUE" defaultValue="" restriction="number" maxlength="22" onblur="_setAccountCurr(this)"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">结余账户使用备注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ACOUNT_REMARKS" id="R_ACOUNT_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="提 交" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="返 回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>