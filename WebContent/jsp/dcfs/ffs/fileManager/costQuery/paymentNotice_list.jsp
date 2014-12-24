<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: paymentNotice_list.jsp
	 * @Description:  缴费通知列表
	 * @author yangrt   
	 * @date 2014-08-27 17:33:34 
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
		<title>缴费列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
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
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/PaymentNoticeList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_PAID_SHOULD_NUM").value = "";
			document.getElementById("S_COST_TYPE").value = "";
			document.getElementById("S_CHILD_NUM").value = "";
			document.getElementById("S_S_CHILD_NUM").value = "";
			document.getElementById("S_ARRIVE_VALUE").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("ARRIVE_DATE_START").value = "";
			document.getElementById("ARRIVE_DATE_END").value = "";
		}
		
		//查看文件详细信息
		function _showNoticeData(){
			var num = 0;
			var RM_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					RM_ID = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				alert("Please select one data!");
				return;
			}else{
				document.srcForm.action=path + "ffs/filemanager/PaymentNoticeShow.action?RM_ID=" + RM_ID;
				document.srcForm.submit();
			}
		}
		
		//普通文件列表导出
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				/* document.srcForm.action=path+"ffs/filemanager/PaymentNoticeExport.action";
				document.srcForm.submit(); */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="FYLB;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/PaymentNoticeList.action">
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
								<td class="bz-search-title" style="width: 10%">缴费编号<br>Bill number</td>
								<td style="width: 15%">
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" defaultValue="" formTitle="" maxlength="14"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">应缴金额<br>Amount payable</td>
								<td style="width: 13%">
									<BZ:input prefix="S_" field="PAID_SHOULD_NUM" id="S_PAID_SHOULD_NUM" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">费用类别<br>Payment type</td>
								<td style="width: 15%">
									<BZ:select prefix="S_" field="COST_TYPE" id="S_COST_TYPE" isCode="true" codeName="FYLB" isShowEN="true" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title">正常儿童数量<br>Number of normal children</td>
								<td>
									<BZ:input prefix="S_" field="CHILD_NUM" id="S_CHILD_NUM" defaultValue="" formTitle="" restriction="int"/>
								</td>
								
								<td class="bz-search-title">特需儿童数量<br>Number of special needs children</td>
								<td>
									<BZ:input prefix="S_" field="S_CHILD_NUM" id="S_S_CHILD_NUM" formTitle="" defaultValue="" restriction="int"/>
								</td>
								
								<td class="bz-search-title">到账金额<br>Amount transferred</td>
								<td>
									<BZ:input prefix="S_" field="ARRIVE_VALUE" id="S_ARRIVE_VALUE" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
								</td>
							
							</tr>
							<tr>	
								<td class="bz-search-title">通知日期<br>Date of notification</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
								<td class="bz-search-title">到账日期<br>Transfer date</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="ARRIVE_DATE_START" id="S_ARRIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ARRIVE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="ARRIVE_DATE_END" id="S_ARRIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ARRIVE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
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
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_showNoticeData()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
									<div class="sorting" id="PAID_NO">催缴编号(Reminder number)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COST_TYPE">费用类别(Payment type)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="CHILD_NUM">正常儿童数量(Number of normal children)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="S_CHILD_NUM">特需儿童数量(Number of special needs children)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="PAID_SHOULD_NUM">应缴金额(Amount payable)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NOTICE_DATE">通知日期(Date of notification)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ARRIVE_DATE">到账日期(Transfer date)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ARRIVE_VALUE">到账金额(Amount transferred)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="RM_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COST_TYPE" defaultValue="" codeName="FYLB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="S_CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ARRIVE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="催缴通知" exportCode="COST_TYPE=CODE,FYLB;NOTICE_DATE=DATE;ARRIVE_DATE=DATE;" exportField="PAID_NO=催缴编号(Bill number),15,20;COST_TYPE=费用类别(Payment type),15;CHILD_NUM=正常儿童数量(Number of normal children),15;S_CHILD_NUM=特需儿童数量(Number of special needs children),15;PAID_SHOULD_NUM=应缴金额(Amount payable),15;NOTICE_DATE=通知日期(Date of notification),15;ARRIVE_DATE=到账日期(Transfer date),15;ARRIVE_VALUE=到账金额(Amount transferred),15;"/></td>
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