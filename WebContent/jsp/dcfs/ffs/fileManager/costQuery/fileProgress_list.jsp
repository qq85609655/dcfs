<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: fileProgress_list.jsp
	 * @Description:  文件办理进度列表
	 * @author yangrt   
	 * @date 2014-08-29 14:33:34 
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
		<title>文件办理进度列表</title>
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
				area: ['1000px','380px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/FileProgressList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_AF_COST_PAID").value = "";
			document.getElementById("S_AF_COST").value = "";
			document.getElementById("S_FEEDBACK_NUM").value = "";
			document.getElementById("S_IS_PAUSE").value = "";
			document.getElementById("S_AF_GLOBAL_STATE").value = "";
			document.getElementById("S_IS_FINISH").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_START").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_END").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_ADREG_DATE_START").value = "";
			document.getElementById("S_ADREG_DATE_END").value = "";
		}
		
		//查看
		function _showFileData(){
			var num = 0;
			var af_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					af_id = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				alert("Please select one data!");
				return;
			}else{
				document.srcForm.action=path + "ffs/filemanager/FileProgressShow.action?AF_ID=" + af_id;
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
	<BZ:body property="data" codeNames="WJLX;ADOPTER_CHILDREN_HEALTH;WJQJZT_SYZZ;PROVINCE;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/FileProgressList.action">
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
								<td class="bz-search-title" style="width: 10%">收文编号<br>Log-in No.</td>
								<td style="width: 15%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="" maxlength="50"/>
								</td>
								<td class="bz-search-title" style="width: 10%">男收养人<br>Adoptive father</td>
								<td style="width: 15%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">女收养人<br>Adoptive mother</td>
								<td style="width: 15%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								<td class="bz-search-title" style="width: 10%">文件类型<br>Document type</td>
								<td style="width: 15%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" isShowEN="true" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">收养类型<br>Adoption type</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" isShowEN="true" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">缴费编号<br>Bill number</td>
								<td>
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" formTitle="" defaultValue=""/>
								</td>
								
								<td class="bz-search-title">缴费状态<br>Payment status</td>
								<td>
									<BZ:select prefix="S_" field="AF_COST_PAID" id="S_AF_COST_PAID" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">unpaid</BZ:option>
										<BZ:option value="1">paid</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">应缴金额<br>Amount payable</td>
								<td>
									<BZ:input prefix="S_" field="AF_COST" id="S_AF_COST" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">反馈报告次数<br>Number of post-placement reports</td>
								<td>
									<BZ:input prefix="S_" field="FEEDBACK_NUM" id="S_FEEDBACK_NUM" defaultValue="" formTitle="" restriction="int"/>
								</td>
								<td class="bz-search-title">暂停状态<br>Suspension status</td>
								<td>
									<BZ:select prefix="S_" field="IS_PAUSE" id="S_IS_PAUSE" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">non-suspended</BZ:option>
										<BZ:option value="1">suspended</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">办理状态<br>Check state</td>
								<td>
									<BZ:select prefix="S_" field="AF_GLOBAL_STATE" isCode="true" codeName="WJQJZT_SYZZ" isShowEN="true" id="S_AF_GLOBAL_STATE" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">办结状态<br>Completion status</td>
								<td>
									<BZ:select prefix="S_" field="IS_FINISH" id="S_IS_FINISH" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">incompleted</BZ:option>
										<BZ:option value="1">completed</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">收文日期<br>Log-in date</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
								<td class="bz-search-title">征求意见日期<br>Comments date</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_START" id="S_ADVICE_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_END" id="S_ADVICE_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">签批日期<br>Date of approval</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								<td class="bz-search-title">收养登记日期<br>Adoption registration date</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="ADREG_DATE_START" id="S_ADREG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ADREG_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="ADREG_DATE_END" id="S_ADREG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ADREG_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
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
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_showFileData()"/>&nbsp;
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
								<th style="width: 5%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_TYPE">文件类型(Document type)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份(Province)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">儿童姓名(Child name)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="CHILD_TYPE">收养类型(Adoption type)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ADVICE_NOTICE_DATE">征求意见日期(Comments date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_DATE">签批日期(Date of approval)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ADREG_DATE">收养登记日期(Adoption registration date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FEEDBACK_NUM">反馈报告次数(Number of post-placement reports)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AF_COST">应缴金额(Amount payable)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PAID_NO">缴费编号(Bill number)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AF_COST_PAID">缴费状态(Payment status)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="IS_PAUSE">暂停状态(Suspension status)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AF_GLOBAL_STATE">办理状态(Check state)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="IS_FINISH">办结状态(Completion status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHILD_TYPE" codeName="ADOPTER_CHILDREN_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ADVICE_NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SIGN_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ADREG_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEEDBACK_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AF_COST_PAID" checkValue="0=unpaid;1=paid;2=partly paid" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="IS_PAUSE" checkValue="0=non-suspended;1=suspended;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_GLOBAL_STATE" codeName="WJQJZT_SYZZ" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="IS_FINISH" checkValue="0=incompleted;1=completed;" defaultValue="0" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN" exportXls="true" exportTitle="文件进度及缴费信息"
							 exportCode="REGISTER_DATE=DATE;FILE_TYPE=COED,WJLX;CHILD_TYPE=CODE,ADOPTER_CHILDREN_HEALTH;DATE;ADVICE_NOTICE_DATE=DATE;SIGN_DATE=DATE;ADREG_DATE=DATE;AF_COST_PAID=FLAG,0:unpaid&1=paid;IS_PAUSE=FLAG,0:non-suspended&1:suspended;AF_GLOBAL_STATE=CODE,WJQJZT_SYZZ;IS_FINISH=FLAG,0:incompleted&1:completed;"
							 exportField="FILE_NO=收文编号(Log-in No.),15,20;REGISTER_DATE=收文日期(Log-in date),15;MALE_NAME=男收养人(Adoptive father),15;FEMALE_NAME=女收养人(Adoptive mother),15;FILE_TYPE=文件类型(Document type),15;PROVINCE_ID=省份(Province),15;NAME=儿童姓名(Child name),15;CHILD_TYPE=收养类型(Adoption type),15;ADVICE_NOTICE_DATE=征求意见日期(Comments date),15;SIGN_DATE=签批日期(Date of approval),15;ADREG_DATE=收养登记日期(Adoption registration date),15;FEEDBACK_NUM=反馈报告次数(Number of post-placement reports),15;AF_COST=应缴金额(Amount payable),15;PAID_NO=缴费编号(Bill number),15;AF_COST_PAID=缴费状态(Payment status),15;IS_PAUSE=暂停状态(Suspension status),15;AF_GLOBAL_STATE=办理状态(Check state),15;IS_FINISH=办结状态(Completion status),15;"/></td>
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