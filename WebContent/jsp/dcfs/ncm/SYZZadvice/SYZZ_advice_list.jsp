<%
/**   
 * @Title: SYZZ_advice_list.jsp
 * @Description: 收养组织征求意见列表
 * @author xugy
 * @date 2014-9-11下午4:58:21
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
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
	
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>征求意见列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(2100,2100);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件(Query condition)",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','240px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"advice/SYZZAdviceList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_START").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_END").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_ADVICE_STATE").value = "";
			document.getElementById("S_ADVICE_FEEDBACK_RESULT").value = "";
			document.getElementById("S_ADVICE_REMINDER_STATE").value = "";
			
		}
		//
		function selectWelfare(node){
			var provinceId = node.value;
			//用于回显得福利机构ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("ENNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
			}
		}
		//征求意见书明细查看
		function _adviceDetail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data! ');
				return;
			}else{
				var smallType = "<%=AttConstants.ZQYJSSY%>";
				var data = getData("com.dcfs.ncm.AjaxGetAttInfo","MI_ID="+ids+"&smallType="+smallType);
				var ID = data.getString("ID");
				var ATT_NAME = data.getString("ATT_NAME");
				var ATT_TYPE = data.getString("ATT_TYPE");
				window.open(path + "/jsp/dcfs/common/pdfView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
			}
		}
		//催办明细查看
		function _reminderDetail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_REMINDER_STATE = id.split(",")[1];
					if(ADVICE_REMINDER_STATE == "0"){
						alert("Please select a data with status as 'reminded'.");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data! ');
				return;
			}else{
				/* document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/reminderDetail.action";
				document.srcForm.submit(); */
				window.open(path + "advice/reminderDetail.action?ids="+ids,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
			}
		}
		//征求意见反馈
		function _adviceFeedback(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_STATE = id.split(",")[2];
					if(ADVICE_STATE != "1"){
						alert("please reselect a data if you have submitted the feedback");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/adviceFeedbackAdd.action";
				document.srcForm.submit();
			}
		}
		//
		function _CIDetail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[3];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				url = path+"/cms/childManager/childInfoForAdoption.action?UUID="+ids+"&onlyPage=1";
				_open(url, "儿童基本信息", 1000, 600);
			}
		}
		//反馈确认情况查看
		function _CFMDetail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_STATE = id.split(",")[2];
					if(ADVICE_STATE != "2" && ADVICE_STATE != "3"){
						alert("please reselect a data if you haven't submitted the feedback");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data! ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/CFMDetail.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;CHILD_TYPE;ZCWJLX;">
		<BZ:form name="srcForm" method="post" action="advice/SYZZAdviceList.action">
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
								<td class="bz-search-title">收文编号<br>Log-in No.</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title">文件类型<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="ZCWJLX" isShowEN="true" width="148px" formTitle="文件类型" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="99">Special needs</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">收文日期<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止收文日期" />
								</td>
							</tr>
							<tr>	
								
								<td class="bz-search-title">男方<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
							
								<td class="bz-search-title">女方<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								
								<td class="bz-search-title">通知日期<br>Date of notification</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_START" id="S_ADVICE_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始通知日期" />~
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_END" id="S_ADVICE_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止通知日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">姓名<br>Name</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" isShowEN="true" width="148px" formTitle="性别" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期<br>D.O.B</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">省份<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" isShowEN="true" onchange="selectWelfare(this)" formTitle="省份" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">福利院<br>SWI</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="福利院">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">儿童类型<br>Type of children</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" isShowEN="true" width="148px" formTitle="儿童类型" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">征求状态<br>Confirmation status</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_STATE" id="S_ADVICE_STATE" width="148px" formTitle="征求状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="2">to be confirmed</BZ:option>
										<BZ:option value="3">confirmed</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">反馈结果<br>Results</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_FEEDBACK_RESULT" id="S_ADVICE_FEEDBACK_RESULT" width="148px" formTitle="反馈结果" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="1">approved</BZ:option>
										<BZ:option value="2">suspension</BZ:option>
										<BZ:option value="3">re-matching</BZ:option>
										<BZ:option value="4">withdrawal</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">催办状态<br>Reminder status</td>
								<td> 
									<BZ:select prefix="S_" field="ADVICE_REMINDER_STATE" id="S_ADVICE_REMINDER_STATE" width="148px" formTitle="催办状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">un-reminded</BZ:option>
										<BZ:option value="1">reminded</BZ:option>
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
					<input type="button" value="Check details of letter of seeking confirmation" class="btn btn-sm btn-primary" onclick="_adviceDetail()"/>&nbsp;
					<input type="button" value="Check reminder details" class="btn btn-sm btn-primary" onclick="_reminderDetail()"/>&nbsp;
					<!-- <input type="button" value="征求意见反馈" class="btn btn-sm btn-primary" onclick="_adviceFeedback()"/>&nbsp; -->
					<input type="button" value="Check child files" class="btn btn-sm btn-primary" onclick="_CIDetail()"/>&nbsp;
					<input type="button" value="Check confirmation feedback" class="btn btn-sm btn-primary" onclick="_CFMDetail()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">男方(Adoptive father)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">女方(Adoptive mother)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_TYPE">文件类型(Document type)</div>
								</th>
								
								<th style="width: 4%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型(Type of children)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份(Province)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="WELFARE_NAME_EN">福利院(SWI)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME_PINYIN">姓名(Name)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">性别(Sex)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="BIRTHDAY">出生日期(D.O.B)</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="ADVICE_NOTICE_DATE">通知日期(Date of notification)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="AF_COST_PAID">缴费状态(payment status)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_STATE">征求状态(Confirmation status)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_FEEDBACK_RESULT">反馈结果(Results)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_REMINDER_STATE">催办状态(Reminder status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="mydata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="ADVICE_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<%
									String ADVICE_STATE = ((Data) pageContext.getAttribute("mydata")).getString("ADVICE_STATE");
									String ADVICE_REMINDER_STATE = ((Data) pageContext.getAttribute("mydata")).getString("ADVICE_REMINDER_STATE");
									if("1".equals(ADVICE_REMINDER_STATE)){
									    //if("1".equals(ADVICE_STATE)){
									%>
									<img alt="" src="<BZ:url/>/resource/images/warning.png" style="height: 15px;">
									<%} %>
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="FILE_NO" defaultValue=""/>
								</td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" isShowEN="true"/></td>
								
								<td><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" isShowEN="true"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue=""/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								
								<td><BZ:data field="ADVICE_NOTICE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="AF_COST_PAID" defaultValue="" checkValue="0=unpaid;1=paid;2=partly paid;"/></td>
								<td><BZ:data field="ADVICE_STATE" defaultValue="" checkValue="2=to be confirmed;3=confirmed;"/></td>
								<td><BZ:data field="ADVICE_FEEDBACK_RESULT" defaultValue="" checkValue="1=approved;2=suspension;3=re-matching;4=withdrawal;"/></td>
								<td><BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=un-reminded;1=reminded;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="收养组织征求意见数据" exportCode="FILE_TYPE=CODE,WJLX;PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;CHILD_TYPE=CODE,CHILD_TYPE;AF_COST_PAID=FLAG,0:unpaid&1:paid&2:partly paid;ADVICE_STATE=FLAG,2:to be confirmed&3:confirmed;ADVICE_FEEDBACK_RESULT=FLAG,1:approved&2:suspension&3:re-matching&4:withdrawal;ADVICE_REMINDER_STATE=FLAG,0:un-reminded&1:reminded;REGISTER_DATE=DATE;BIRTHDAY=DATE;ADVICE_NOTICE_DATE=DATE,yyyy/MM/dd" 
							exportField="FILE_NO=收文编号(Log-in No.),15,20;REGISTER_DATE=收文日期(Log-in date),15;MALE_NAME=男方(Adoptive father),15;FEMALE_NAME=女方(Adoptive mother),15;FILE_TYPE=文件类型(Document type),10;CHILD_TYPE=儿童类型(Type of children),10;PROVINCE_ID=省份(Province),10;WELFARE_NAME_EN=福利院(SWI),20;NAME_PINYIN=姓名(Name),10;SEX=性别(Sex),10;BIRTHDAY=出生日期(D.O.B),15;ADVICE_NOTICE_DATE=通知日期(Date of notification ),15;AF_COST_PAID=缴费状态(payment status),15;ADVICE_STATE=征求状态(Confirmation status),10;ADVICE_FEEDBACK_RESULT=反馈结果(Results),10;ADVICE_REMINDER_STATE=催办状态(Reminder status),10;"/></td>
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