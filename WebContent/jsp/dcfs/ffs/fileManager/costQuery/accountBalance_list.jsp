<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: accountBalance_list.jsp
	 * @Description:  账户余额信息列表
	 * @author yangrt   
	 * @date 2014-08-29 15:03:34 
	 * @version V1.0   
	 */
	 //1 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>
	<BZ:head language="EN">
		<title>账户余额信息列表</title>
		<BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','140px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/AccountBalanceList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_OPP_TYPE").value = "";
			document.getElementById("S_SUM").value = "";
			document.getElementById("S_OPP_USERNAME").value = "";
			document.getElementById("S_OPP_DATE_START").value = "";
			document.getElementById("S_OPP_DATE_END").value = "";
		}
		
		//查看文件详细信息
		function _showAccountData(){
			var num = 0;
			var ACCOUNT_LOG_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ACCOUNT_LOG_ID = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				alert("Please select one data!");
				return;
			}else{
				document.srcForm.action=path + "ffs/filemanager/AccountBalanceShow.action?ACCOUNT_LOG_ID=" + ACCOUNT_LOG_ID;
				document.srcForm.submit();
			}
		}
		
		//文件列表导出
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				/* document.srcForm.action=path+"ffs/filemanager/PaymentExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/PaymentList.action"; */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="searchData">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/AccountBalanceList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 15%">缴费编号<br>Bill number</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" defaultValue="" formTitle="" maxlength="14"/>
								</td>
								
								<td class="bz-search-title" style="width: 15%">账单金额<br>Amount</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="SUM" id="S_SUM" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title" style="width: 15%">操作类型<br>Type</td>
								<td style="width: 19%">
									<BZ:select prefix="S_" field="OPP_TYPE" id="S_OPP_TYPE" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">transfer money to</BZ:option>
										<BZ:option value="1">transfer money from</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title">操作人<br>Operator</td>
								<td>
									<BZ:input prefix="S_" field="OPP_USERNAME" id="S_OPP_USERNAME" defaultValue="" formTitle="" maxlength="256"/>
								</td>
								
								<td class="bz-search-title">操作日期<br>Date</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="OPP_DATE_START" id="S_OPP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_OPP_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="OPP_DATE_END" id="S_OPP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_OPP_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="查看区域" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>账户结余信息(Account balance information)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">收养组织<br>Agency</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ADOPT_ORG_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">账户余额<br>Account balance</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">透支额度<br>Credit limit</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="查看区域" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>缴费单明细列表(Transaction details)</div>
				</div>
			</div>
		</div>
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
					<input type="button" value="Check payment bill" class="btn btn-sm btn-primary" onclick="_showAccountData()"/>
					<!-- <input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/> -->
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">&nbsp;</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PAID_NO">缴费编号(Bill number)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_TYPE">操作类型(Type)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SUM">账单金额(Amount)</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="OPP_USERNAME">操作人(Operator)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="OPP_DATE">操作日期(Date)</div>
								</th>
								<th style="width: 30%;">
									<div class="sorting" id="REMARKS">备注(Remarks)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="ACCOUNT_LOG_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/>								</td>
								<td class="center"><BZ:data field="OPP_TYPE" checkValue="0=transfer money to;1=transfer money from;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPP_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="OPP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="REMARKS" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" type="EN" /></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>