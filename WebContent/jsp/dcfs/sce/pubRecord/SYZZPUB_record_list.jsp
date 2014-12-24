<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: 收养组织点发退回查看列表
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

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
		<title>点发退回列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
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
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//导出
		function _export(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//查看
		function _detail(){
			var num = 0;
			var ids="";
			var id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					id=ids.split(",")[0];
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				$.layer({
					type: 2,
					closeBtn: [0, true],
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					iframe: {
						src: path+'record/SYZZPUBRecordDetail.action?PUB_ID='+id+'&type=show'
					},
					title: "点发退回查看(Check agency-specific files returned )",
					area: ['1000px','400px'],
					offset: ['50px' , '50px']
				});
			}
		}


		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"record/SYZZPUBRecordList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("C_PROVINCE_ID").value = "";
			document.getElementById("C_NAME_PINYIN").value = "";
			document.getElementById("C_SEX").value = "";
			document.getElementById("C_SN_TYPE").value = "";
			document.getElementById("C_BIRTHDAY_START").value = "";
			document.getElementById("C_BIRTHDAY_END").value = "";
			document.getElementById("C_RETURN_STATE").value = "";
			document.getElementById("C_RETURN_DATE_START").value = "";
			document.getElementById("C_RETURN_DATE_END").value = "";
			document.getElementById("C_PUB_DATE_START").value = "";
			document.getElementById("C_PUB_DATE_END").value = "";
			document.getElementById("C_SETTLE_DATE_START").value = "";
			document.getElementById("C_SETTLE_DATE_END").value = "";
			document.getElementById("C_RETURN_CFM_DATE_START").value = "";
			document.getElementById("C_RETURN_CFM_DATE_END").value = "";
		}
		//委托退回
		function _syzzReturn(){
			var num = 0;
			var ids="";
			var id = "";
			var state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					id=ids.split(",")[0];
					state = ids.split(",")[1];
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				if(state!=0){
					alert('请选择尚未退回的儿童记录');
					return ;
				}else{					
					document.srcForm.action=path+"record/SYZZPUBRecordDetail.action?PUB_ID="+id+"&type=revise";
					document.srcForm.submit();
				}
			}
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;PROVINCE;">
		<BZ:form name="srcForm"  method="post" action="record/SYZZPUBRecordList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">省份<br>Province</td>
								<td>
									<BZ:select prefix="C_" field="PROVINCE_ID" id="C_PROVINCE_ID" isCode="true" codeName="PROVINCE" isShowEN="true" formTitle="省份" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">姓名<br>Child name</td>
								<td>
									<BZ:input prefix="C_" field="NAME_PINYIN" id="C_NAME_PINYIN" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别<br>Sex</td>
								<td>
									<BZ:select prefix="C_" field="SEX" id="C_SEX" isCode="true" codeName="ETXB" isShowEN="true" formTitle="性别" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">病残种类<br>SN type</td>
								<td>
									<BZ:select prefix="C_" field="SN_TYPE" id="C_SN_TYPE" isCode="true" codeName="BCZL" isShowEN="true" formTitle="病残种类" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期<br>D.O.B</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="BIRTHDAY_START" id="C_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="C_" field="BIRTHDAY_END" id="C_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">发布日期<br>Released date</td>
								<td>
									<BZ:input prefix="C_" field="PUB_DATE_START" id="C_PUB_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_PUB_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始发布日期" />~
									<BZ:input prefix="C_" field="PUB_DATE_END" id="C_PUB_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_PUB_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止发布日期" />
								</td>
								<td class="bz-search-title">安置期限<br>Deadline of placement</td>
								<td>
									<BZ:input prefix="C_" field="SETTLE_DATE_START" id="C_SETTLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_SETTLE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始安置日期" />~
									<BZ:input prefix="C_" field="SETTLE_DATE_END" id="C_SETTLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_SETTLE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止安置日期" />
								</td>
								<td class="bz-search-title">退回日期<br>Return date</td>
								<td>
									<BZ:input prefix="C_" field="RETURN_DATE_START" id="C_RETURN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始退回日期" />~
									<BZ:input prefix="C_" field="RETURN_DATE_END" id="C_RETURN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止退回日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">确认日期<br>Confirmation date</td>
								<td>
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_START" id="C_RETURN_CFM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始退确认回日期" />~
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_END" id="C_RETURN_CFM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止退回确认日期" />
								</td>
								<td class="bz-search-title">退回状态<br>Return status</td>
								<td>
									<BZ:select prefix="C_" field="RETURN_STATE" id="C_RETURN_STATE" formTitle="退回状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be confirmed</BZ:option>
										<BZ:option value="1">confirmed</BZ:option>
									</BZ:select>
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
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_export()"/>
					<input type="button" value="Return entrusted file" class="btn btn-sm btn-primary" onclick="_syzzReturn()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份(Province)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME_PINYIN">姓名(Child name)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期(D.O.B)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SN_TYPE">病残种类(SN type)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PUB_DATE">发布日期(Released date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SETTLE_DATE">安置期限(Deadline of placement)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_DATE">退回日期(Return date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_CFM_DATE">确认日期(Confirmation date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RETURN_STATE">退回状态(Return status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="PUB_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=待确认;1=已确认;" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="PUB_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SETTLE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_CFM_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=to be confirmed;1=confirmed;" onlyValue="true"/></td>
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
								<BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="收养组织点发退回记录" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;SN_TYPE=CODE,BCZL;PUB_DATE=DATE;SETTLE_DATE=DATE;RETURN_DATE=DATE;RETURN_CFM_DATE=DATE;RETURN_STATE=FLAG,0:to be confirmed&1:confirmed;" exportField="PROVINCE_ID=省份(Province),15,20;NAME=姓名(Child name),15;SEX=性别(Sex),15;BIRTHDAY=出生日期(D.O.B),15;SN_TYPE=病残种类(SN type),15;PUB_DATE=发布日期(Released date),15;SETTLE_DATE=安置期限(Deadline of placement),15;RETURN_DATE=退回日期(Return date),15;RETURN_CFM_DATE=确认日期(Confirmation date),15;RETURN_STATE=退回状态(Return status),15;"/>
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