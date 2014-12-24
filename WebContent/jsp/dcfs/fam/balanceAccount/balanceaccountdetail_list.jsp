<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: balanceaccountdetail_list.jsp
 * @Description:  收养组织余额账户明细列表
 * @author yangrt
 * @date 2014-10-20 下午14:27:38 
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
	<BZ:head>
		<title>收养组织余额账户明细列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		});
		
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['800px','160px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"fam/balanceaccount/BalanceAccountDetailList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_OPP_DATE_START").value = "";
			document.getElementById("S_OPP_DATE_END").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//返回列表页面
		function _goback(){
			window.location.href=path+"fam/balanceaccount/BalanceAccountList.action";
		}
		
		//导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="fam/balanceaccount/BalanceAccountDetailList.action">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区域begin -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 20%">国家</td>
								<td style="width: 30%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="93%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 20%">
									<span title="收养组织">收养组织</span>
								</td>
								<td style="width: 30%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">账单日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="OPP_DATE_START" id="S_OPP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_OPP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始录入日期" />~
									<BZ:input prefix="S_" field="OPP_DATE_END" id="S_OPP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_OPP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止录入日期" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
					<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADOPT_ORG_NAME">收养组织</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PAID_NO">缴费编号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_TYPE">账单类型</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_DATE">账单日期</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SUM">账单金额</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_USERNAME">操作人</div>
								</th>
								<th style="width: 26%;">
									<div class="sorting_disabled" id="REMARKS">备注</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="OPP_TYPE" defaultValue="" checkValue="0=入账;1=出账;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="OPP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="SUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPP_USERNAME" defaultValue="" onlyValue="true"/></td>
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
							<td>
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="余额账户使用明细信息"
									exportCode="COUNTRY_CODE=CODE,GJSY;OPP_TYPE=FLAG,0:入账&1:出账;"
									exportField="COUNTRY_CODE=国家,15,20;ADOPT_ORG_NAME=收养组织,15;PAID_NO=缴费编号,15;OPP_TYPE=账单类型,15;OPP_DATE=账单日期,15;SUM=账单金额,15;OPP_USERNAME=操作人,15;REMARKS=备注,30;"/>
							</td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>