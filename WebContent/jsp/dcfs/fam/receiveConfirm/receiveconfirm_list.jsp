<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: receiveconfirm_list.jsp
 * @Description:  到账确认查询列表
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
		<title>到账确认查询列表</title>
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
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"fam/receiveconfirm/ReceiveConfirmList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_COST_TYPE").value = "";
			document.getElementById("S_PAID_WAY").value = "";
			document.getElementById("S_PAID_SHOULD_NUM").value = "";
			document.getElementById("S_PAR_VALUE").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_RECEIVE_DATE_START").value = "";
			document.getElementById("S_RECEIVE_DATE_END").value = "";
			document.getElementById("S_ARRIVE_STATE").value = "";
			document.getElementById("S_ARRIVE_VALUE").value = "";
			document.getElementById("S_ARRIVE_DATE_START").value = "";
			document.getElementById("S_ARRIVE_DATE_END").value = "";
			document.getElementById("S_ARRIVE_ACCOUNT_VALUE").value = "";
			document.getElementById("S_ACCOUNT_CURR").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//查看
		function _showInfo(){
			var num = 0;
			var CHEQUE_ID = "";	//票据登记id
			var orgid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CHEQUE_ID = arrays[i].value;
					orgid = arrays[i].getAttribute("ORG_ID");
					num++;
				}
			}
			if(num < 1){
				page.alert('请选择一条票据信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/receiveconfirm/ReceiveConfirmShow.action?type=show&CHEQUE_ID="+CHEQUE_ID+"&ORG_ID="+orgid;
				document.srcForm.submit();
			}
		}
		
		//到账确认
		function _receiveConfirm(){
			var num = 0;
			var CHEQUE_ID = "";	//票据登记id
			var orgId = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("ARRIVE_STATE");
					if(state == "0"){
						CHEQUE_ID = arrays[i].value;
						orgId = arrays[i].getAttribute("ORG_ID");
						num++;
					}else{
						page.alert("请选择一条到账状态为待确认的票据信息！");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('请选择一条到账状态为待确认的票据信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/receiveconfirm/ReceiveConfirmShow.action?type=add&CHEQUE_ID="+CHEQUE_ID+"&ORG_ID="+orgId;
				document.srcForm.submit();
			}
		}
		
		//调账
		function _reviseAccount(){
			var num = 0;
			var CHEQUE_ID = "";	//票据登记id
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("ARRIVE_STATE");
					if(state == "2"){
						CHEQUE_ID = arrays[i].value;
						num++;
					}else{
						page.alert("请选择一条到账状态为不足的票据信息！");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('请选择一条到账状态为不足的票据信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/receiveconfirm/ReviseAccountAdd.action?CHEQUE_ID="+CHEQUE_ID;
				document.srcForm.submit();
			}
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
	<BZ:body property="data" codeNames="GJSY;FYLB;JFFS;">
		<BZ:form name="srcForm" method="post" action="fam/receiveconfirm/ReceiveConfirmList.action">
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
								<td class="bz-search-title" style="width: 10%"><span title="缴费编号">缴费编号</span></td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" defaultValue="" formTitle="缴费编号" maxlength="14"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">国家</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="GJSY" width="93%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">
									<span title="收养组织">收养组织</span>
								</td>
								<td style="width: 34%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
									<%-- <BZ:input prefix="S_" field="ADOPT_ORG_NAME" id="S_ADOPT_ORG_NAME" defaultValue="" formTitle="收养组织"/>
									<BZ:input type="hidden" field="ADOPT_ORG_ID" prefix="S_" id="S_ADOPT_ORG_ID" defaultValue="" /> --%>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">费用类型</td>
								<td>
									<BZ:select prefix="S_" field="COST_TYPE" id="S_COST_TYPE" isCode="true" codeName="FYLB" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">缴费方式</td>
								<td>
									<BZ:select prefix="S_" field="PAID_WAY" id="S_PAID_WAY" isCode="true" codeName="JFFS" formTitle="缴费方式" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">应缴金额</td>
								<td>
									<BZ:input prefix="S_" field="PAID_SHOULD_NUM" id="S_PAID_SHOULD_NUM" defaultValue="" formTitle="应缴金额" restriction="number" maxlength="22"/>
								</td>	
								
							</tr>
							<tr>
								<td class="bz-search-title">票面金额</td>
								<td>
									<BZ:input prefix="S_" field="PAR_VALUE" id="S_PAR_VALUE" defaultValue="" formTitle="票面金额" restriction="int" maxlength="22"/>
								</td>
								
								<td class="bz-search-title">收文编号</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle=""/>
								</td>
								
								<td class="bz-search-title">接收日期</td>
								<td>
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始接收日期" />~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止接收日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">到账状态</td>
								<td>
									<BZ:select prefix="S_" field="ARRIVE_STATE" id="S_ARRIVE_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待确认</BZ:option>
										<BZ:option value="1">足额</BZ:option>
										<BZ:option value="2">不足</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">到账金额</td>
								<td>
									<BZ:input prefix="S_" field="ARRIVE_VALUE" id="S_ARRIVE_VALUE" defaultValue="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title">到账日期</td>
								<td>
									<BZ:input prefix="S_" field="ARRIVE_DATE_START" id="S_ARRIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ARRIVE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="ARRIVE_DATE_END" id="S_ARRIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ARRIVE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">结余账户使用金额</td>
								<td>
									<BZ:input prefix="S_" field="ARRIVE_ACCOUNT_VALUE" id="S_ARRIVE_ACCOUNT_VALUE" defaultValue="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title">结余账户总金额</td>
								<td>
									<BZ:input prefix="S_" field="ACCOUNT_CURR" id="S_ACCOUNT_CURR" defaultValue="" restriction="number" maxlength="22"/>
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
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_showInfo()"/>&nbsp;
					<input type="button" value="到账确认" class="btn btn-sm btn-primary" onclick="_receiveConfirm()"/>&nbsp;
					<input type="button" value="调&nbsp;&nbsp;账" class="btn btn-sm btn-primary" onclick="_reviseAccount()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">选择</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PAID_NO">缴费编号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COST_TYPE">费用类型</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PAID_WAY">缴费方式</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PAID_SHOULD_NUM">应缴金额</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PAR_VALUE">票面金额</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RECEIVE_DATE">接收日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_STATE">到账状态</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="ARRIVE_DATE">到账日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_VALUE">到账金额</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_ACCOUNT_VALUE">结余账户使用金额</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ACCOUNT_LMT">结余账户总金额</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" 
										value="<BZ:data field="CHEQUE_ID" defaultValue="" onlyValue="true"/>"
										ORG_ID="<BZ:data field="ORG_ID" defaultValue="" onlyValue="true"/>"
									 	ARRIVE_STATE="<BZ:data field="ARRIVE_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COST_TYPE" defaultValue="" codeName="FYLB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PAID_WAY" defaultValue="" codeName="JFFS" onlyValue="true"/></td>
								<td><BZ:data field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="RECEIVE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_STATE" defaultValue="" checkValue="0=待确认;1=足额;2=不足;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_ACCOUNT_VALUE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/></td>
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
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="到账信息" 
									exportCode="COUNTRY_CODE=CODE,GJSY;COST_TYPE=CODE,FYLB;PAID_WAY=CODE,JFFS;RECEIVE_DATE=DATE;ARRIVE_STATE=FLAG,0:待确认&1:足额&2:不足;ARRIVE_DATE=DATE;" 
									exportField="PAID_NO=缴费编号,15,20;COUNTRY_CODE=国家,15;NAME_CN=收养组织,15;COST_TYPE=费用类型,15;PAID_WAY=缴费方式,15;PAID_SHOULD_NUM=应缴金额,15;PAR_VALUE=票面金额,15;FILE_NO=收文编号,15;RECEIVE_DATE=接收日期,15;ARRIVE_STATE=到账状态,15;ARRIVE_DATE=到账日期,15;ARRIVE_VALUE=到账金额,15;ARRIVE_ACCOUNT_VALUE=结余账户使用金额,15;ACCOUNT_CURR=结余账户总金额,15;"/>
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