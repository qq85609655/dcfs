<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: balanceaccount_list.jsp
 * @Description:  收养组织余额账户查询列表
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
		<title>收养组织余额账户查询列表</title>
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
			document.srcForm.action=path+"fam/balanceaccount/BalanceAccountList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_ADOPT_ORG_NO").value = "";
			document.getElementById("S_ACCOUNT_CURR").value = "";
			document.getElementById("S_ACCOUNT_LMT").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//维护
		function _reviseAccount(){
			var num = 0;
			var ADOPT_ORG_ID = "";	//收养组织code
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ADOPT_ORG_ID = arrays[i].value;
					num++;
				}
			}
			if(num != 1){
				page.alert('请选择一条收养组织信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/balanceaccount/BalanceAccountAdd.action?ADOPT_ORG_ID="+ADOPT_ORG_ID;
				document.srcForm.submit();
			}
		}
		
		//账户明细
		function _showDetail(){
			document.srcForm.action=path+"fam/balanceaccount/BalanceAccountDetailList.action?type=false";
			document.srcForm.submit();
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
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="fam/balanceaccount/BalanceAccountList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 15%">国家</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="88%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 15%">
									<span title="收养组织">收养组织</span>
								</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title" style="width: 15%">收养组织编号</td>
								<td style="width: 19%">
									<BZ:input prefix="S_" field="ADOPT_ORG_NO" id="S_ADOPT_ORG_NO" defaultValue="" formTitle=""/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">当前金额</td>
								<td>
									<BZ:input prefix="S_" field="ACCOUNT_CURR" id="S_ACCOUNT_CURR" defaultValue="" restriction="number" maxlength="22" formTitle=""/>
								</td>
								
								<td class="bz-search-title">透支额度</td>
								<td>
									<BZ:input prefix="S_" field="ACCOUNT_LMT" id="S_ACCOUNT_LMT" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title">&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="维&nbsp;&nbsp;护" class="btn btn-sm btn-primary" onclick="_reviseAccount()"/>&nbsp;
					<input type="button" value="账号明细" class="btn btn-sm btn-primary" onclick="_showDetail()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 4%;">
									<div class="sorting_disabled">选择</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 30%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ADOPT_ORG_NO">收养组织编号</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ACCOUNT_CURR">当前金额</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ACCOUNT_LMT">透支额度</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="ADOPT_ORG_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ADOPT_ORG_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/></td>
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
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="收养组织结余账户信息" 
									exportCode="COUNTRY_CODE=CODE,GJSY;" 
									exportField="COUNTRY_CODE=国家,15,20;NAME_CN=收养组织,15;ADOPT_ORG_NO=收养组织编号,15;ACCOUNT_CURR=当前金额,15;ACCOUNT_LMT=透支额度,15;"/>
							</td>
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