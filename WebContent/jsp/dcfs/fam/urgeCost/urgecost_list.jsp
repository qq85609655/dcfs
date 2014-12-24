<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: urgecost_list.jsp
 * @Description:  费用催缴列表
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
		<title>费用催缴列表</title>
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
			document.srcForm.action=path+"fam/urgecost/UrgeCostList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_CHILD_NUM").value = "";
			document.getElementById("S_S_CHILD_NUM").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_COST_TYPE").value = "";
			document.getElementById("S_PAR_VALUE").value = "";
			document.getElementById("S_PAY_DATE_START").value = "";
			document.getElementById("S_PAY_DATE_END").value = "";
			document.getElementById("S_ARRIVE_STATE").value = "";
			document.getElementById("S_ARRIVE_VALUE").value = "";
			document.getElementById("S_ARRIVE_DATE_START").value = "";
			document.getElementById("S_ARRIVE_DATE_END").value = "";
			document.getElementById("S_COLLECTION_STATE").value = "";
			document.getElementById("S_NOTICE_STATE").value = "";
		}
		
		//录入
		function _addNotice(){
			document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeShow.action?type=add";
			document.srcForm.submit();
		}
		
		//统计录入
		function _batchAddNotice(){
			document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeBatchAdd.action";
			document.srcForm.submit();
		}
		
		//修改
		function _updateNotice(){
			var num = 0;
			var rm_id = "";	//催缴记录ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "0"){
						rm_id = arrays[i].value;
						num++;
					}else{
						page.alert("请选择一条通知状态为未通知的信息！");
						return;
					}
				}
			}
			if(num != 1){
				page.alert('请选择一条通知状态为未通知的信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeShow.action?type=mod&RM_ID=" + rm_id;
				document.srcForm.submit();
			}
		}
		
		//批量删除
		function _batchDelete(){
			var num = 0;
			var rm_id = [];	//催缴记录ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "0"){
						rm_id[num++] = arrays[i].value;
					}else{
						page.alert("请选择通知状态为未通知的信息！");
						return;
					}
				}
			}
			if(num == 0){
				page.alert('请选择通知状态为未通知的信息！');
				return;
			}else{
				document.getElementById("batchID").value = rm_id.join(";");
				document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeBatchDelete.action";
				document.srcForm.submit();
			}
		}
		
		//通知
		function _batchSubmit(){
			var num = 0;
			var rm_id = [];	//催缴记录ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "0"){
						rm_id[num++] = arrays[i].value;
					}else{
						page.alert("请选择通知状态为未通知的信息！");
						return;
					}
				}
			}
			if(num == 0){
				page.alert('请选择通知状态为未通知的信息！');
				return;
			}else{
				document.getElementById("batchID").value = rm_id.join(";");
				document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeBatchSubmit.action";
				document.srcForm.submit();
			}
		}
		
		//缴费反馈录入
		function _addCostData(){
			var num = 0;
			var rm_id = "";	//催缴记录ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "1"){
						rm_id = arrays[i].value;
						num++;
					}else{
						page.alert("请选择一条通知状态为已通知的信息！");
						return;
					}
				}
			}
			if(num != 1){
				page.alert('请选择一条通知状态为已通知的信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/urgecost/UrgeCostFeedBackAdd.action?RM_ID=" + rm_id;
				document.srcForm.submit();
			}
		}
		
		//到账反馈录入
		function _addReceiveData(){
			var num = 0;
			var CHEQUE_ID = "";	//票据登记ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("ARRIVE_STATE");	//到账状态
					if(state == "0" ){
						CHEQUE_ID = arrays[i].getAttribute("CHEQUE_ID");
						num++;
					}else{
						page.alert("请选择一条缴费状态为待确认的信息！");
						return;
					}
				}
			}
			if(num != 1){
				page.alert('请选择一条缴费状态为待确认的信息！');
				return;
			}else{
				document.srcForm.action=path+"fam/urgecost/UrgeCostReceiveAdd.action?CHEQUE_ID=" + CHEQUE_ID;
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
		<BZ:form name="srcForm" method="post" action="fam/urgecost/UrgeCostList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="batchID" id="batchID" value=""/>
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
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">正常儿童数量</td>
								<td>
									<BZ:input prefix="S_" field="CHILD_NUM" id="S_CHILD_NUM" defaultValue="" formTitle="" restriction="int"/>
								</td>
								
								<td class="bz-search-title">特需儿童数量</td>
								<td>
									<BZ:input prefix="S_" field="S_CHILD_NUM" id="S_S_CHILD_NUM" defaultValue="" formTitle="" restriction="int"/>
								</td>
								
								<td class="bz-search-title">通知日期</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始接收日期" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止接收日期" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">费用类型</td>
								<td>
									<BZ:select prefix="S_" field="COST_TYPE" id="S_COST_TYPE" isCode="true" codeName="FYLB" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">缴费金额</td>
								<td>
									<BZ:input prefix="S_" field="PAR_VALUE" id="S_PAR_VALUE" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>	
								
								<td class="bz-search-title">缴费日期</td>
								<td>
									<BZ:input prefix="S_" field="PAY_DATE_START" id="S_PAY_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PAY_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始接收日期" />~
									<BZ:input prefix="S_" field="PAY_DATE_END" id="S_PAY_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PAY_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止接收日期" />
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
								<td class="bz-search-title">托收状态</td>
								<td>
									<BZ:select prefix="S_" field="COLLECTION_STATE" id="S_COLLECTION_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未托收</BZ:option>
										<BZ:option value="1">已托收</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">通知状态</td>
								<td>
									<BZ:select prefix="S_" field="NOTICE_STATE" id="S_NOTICE_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未通知</BZ:option>
										<BZ:option value="1">已通知</BZ:option>
										<BZ:option value="2">已反馈</BZ:option>
									</BZ:select>
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
					<input type="button" value="录&nbsp;&nbsp;入" class="btn btn-sm btn-primary" onclick="_addNotice()"/>&nbsp;
					<input type="button" value="统计录入" class="btn btn-sm btn-primary" onclick="_batchAddNotice()"/>&nbsp;
					<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_updateNotice()"/>
					<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_batchDelete()"/>&nbsp;
					<input type="button" value="通&nbsp;&nbsp;知" class="btn btn-sm btn-primary" onclick="_batchSubmit()"/>&nbsp;
					<input type="button" value="缴费反馈录入" class="btn btn-sm btn-primary" onclick="_addCostData()"/>&nbsp;
					<input type="button" value="到账反馈录入" class="btn btn-sm btn-primary" onclick="_addReceiveData()"/>&nbsp;
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
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PAID_NO">缴费编号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COST_TYPE">费用类型</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="CHILD_NUM">正常儿童数量</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="S_CHILD_NUM">特需儿童数量</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICE_DATE">通知日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICE_DATE">缴费日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PAR_VALUE">缴费金额</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ARRIVE_DATE">到账日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_VALUE">到账金额</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_STATE">缴费状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COLLECTION_STATE">托收状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NOTICE_STATE">通知状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" 
										value="<BZ:data field="RM_ID" onlyValue="true"/>"
										CHEQUE_ID="<BZ:data field="CHEQUE_ID" onlyValue="true"/>"
									 	NOTICE_STATE="<BZ:data field="NOTICE_STATE" onlyValue="true"/>"
									 	ARRIVE_STATE="<BZ:data field="ARRIVE_STATE" onlyValue="true"/>"
									 	class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COST_TYPE" defaultValue="" codeName="FYLB" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="S_CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_STATE" defaultValue="" checkValue="0=待确认;1=足额;2=不足;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="COLLECTION_STATE" defaultValue="" onlyValue="true" checkValue="0=未托收;1=已托收;"/></td>
								<td class="center"><BZ:data field="NOTICE_STATE" defaultValue="" onlyValue="true" checkValue="0=未通知;1=已通知;2=已反馈;"/></td>
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
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="费用催缴信息" 
									exportCode="COUNTRY_CODE=CODE,GJSY;COST_TYPE=CODE,FYLB;NOTICE_DATE=DATE;ARRIVE_DATE=DATE;ARRIVE_STATE=FLAG,0:待确认&1:足额&2:不足;COLLECTION_STATE=FLAG,0:未托收&1:已托收;NOTICE_STATE=FLAG,0:未通知&1:已通知&2:已反馈;" 
									exportField="PAID_NO=缴费编号,15,20;COST_TYPE=费用类型,15;COUNTRY_CODE=国家,15;NAME_CN=收养组织,15;CHILD_NUM=正常儿童数量,15;S_CHILD_NUM=特需儿童数量,15;NOTICE_DATE=通知日期,15;PAR_VALUE=缴费金额,15;ARRIVE_DATE=到账日期,15;ARRIVE_VALUE=到账金额,15;ARRIVE_STATE=缴费状态,15;COLLECTION_STATE=托收状态,15;NOTICE_STATE=通知状态,15;"/>
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