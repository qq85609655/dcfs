<%
/**   
 * @Title: AZB_advice_list.jsp
 * @Description: 安置部征求意见列表
 * @author xugy
 * @date 2014-9-11上午9:52:40
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
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
	<BZ:head>
		<title>征求意见列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(2000,2000);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"advice/AZBAdviceList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_MATCH_PASSDATE_START").value = "";
			document.getElementById("S_MATCH_PASSDATE_END").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_START").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_END").value = "";
			document.getElementById("S_ADVICE_PRINT_NUM").value = "";
			document.getElementById("S_ADVICE_STATE").value = "";
			document.getElementById("S_ADVICE_REMINDER_STATE").value = "";
			document.getElementById("S_AF_COST_CLEAR").value = "";
			document.getElementById("S_ADVICE_FEEDBACK_RESULT").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择--",""));
			}
		}
		//打印征求意见书
		function _print(){//未完
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('请选择打印数据 ');
				return;
			}else{
				if(num == 1){
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"advice/toAZBPrintPreview.action";
					document.srcForm.submit();
				}else{
					alert("批量打印");
				}
			}
		}
		//通知收养组织
		function _notice(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_STATE = id.split(",")[1];
					if(ADVICE_STATE != "1"){
						page.alert('请选择未通知的数据');
						return;
					}
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('请选择要通知的数据 ');
				return;
			}else{
				if (confirm('确定通知收养组织吗？')) {
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"advice/AZBnotice.action";
					document.srcForm.submit();
				}
			}
		}
		//反馈确认
		function _feedbackConfirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_STATE = id.split(",")[1];
					if(ADVICE_STATE != "2"){
						page.alert('请选择待反馈的数据');
						return;
					}
					var AF_COST_CLEAR = id.split(",")[2];
					if(AF_COST_CLEAR != "1"){
						page.alert('文件未完费，禁止进行征求意见书反馈');
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/feedbackConfirm.action";
				document.srcForm.submit();
			}
		}
		//
		function _detail(){
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
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/feedbackDetail.action";
				document.srcForm.submit();
			}
		}
		//查看催办通知
		function _reminderDetail(MI_ID){
			$.layer({
				type : 2,
				title : "催办通知查看",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				//page : {dom : '#planList'},
				iframe: {src: '<BZ:url/>/advice/AZBreminderDetail.action?MI_ID='+MI_ID},
				area: ['1050px','450px'],
				offset: ['40px' , '0px']
			});
		}
		//
		function _pdf(){
			document.srcForm.action=path+"advice/createPDF.action";
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="advice/AZBAdviceList.action">
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
								<td class="bz-search-title" style="width: 8%;">收文编号</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">国家</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">收养组织</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
							</tr>
							<tr>	
								
								<td class="bz-search-title">男方</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
							
								<td class="bz-search-title">女方</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								
								<td class="bz-search-title">省份</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="省份" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">福利院</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px;" formTitle="福利院">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">出生日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								<td class="bz-search-title">通过日期</td>
								<td>
									<BZ:input prefix="S_" field="MATCH_PASSDATE_START" id="S_MATCH_PASSDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_MATCH_PASSDATE_END\\')}',readonly:true" defaultValue="" formTitle="起始通过日期" />~
									<BZ:input prefix="S_" field="MATCH_PASSDATE_END" id="S_MATCH_PASSDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_MATCH_PASSDATE_START\\')}',readonly:true" defaultValue="" formTitle="截止通过日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">通知日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_START" id="S_ADVICE_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始通知日期" />~
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_END" id="S_ADVICE_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止通知日期" />
								</td>
								<td class="bz-search-title">打印次数</td>
								<td>
									<BZ:input prefix="S_" field="ADVICE_PRINT_NUM" id="S_ADVICE_PRINT_NUM" defaultValue="" formTitle="打印次数" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">征求状态</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_STATE" id="S_ADVICE_STATE" width="148px" formTitle="征求状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">未通知</BZ:option>
										<BZ:option value="2">待反馈</BZ:option>
										<BZ:option value="3">已反馈</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">催办状态</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_REMINDER_STATE" id="S_ADVICE_REMINDER_STATE" width="148px" formTitle="催办状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未催办</BZ:option>
										<BZ:option value="1">已催办</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">完费状态</td>
								<td>
									<BZ:select prefix="S_" field="AF_COST_CLEAR" id="S_AF_COST_CLEAR" width="148px" formTitle="完费状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未完费</BZ:option>
										<BZ:option value="1">已完费</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">反馈结果</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_FEEDBACK_RESULT" id="S_ADVICE_FEEDBACK_RESULT" width="148px" formTitle="反馈结果" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">同意</BZ:option>
										<BZ:option value="2">暂停</BZ:option>
										<BZ:option value="3">重新匹配</BZ:option>
										<BZ:option value="4">退文</BZ:option>
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
					<input type="button" value="打&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
					<input type="button" value="通&nbsp;&nbsp;知" class="btn btn-sm btn-primary" onclick="_notice()"/>&nbsp;
					<input type="button" value="反馈确认" class="btn btn-sm btn-primary" onclick="_feedbackConfirm()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="生成pdf" class="btn btn-sm btn-primary" onclick="_pdf()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">国家</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">男方</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">女方</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="IS_CONVENTION_ADOPT">公约收养</div>
								</th>
								
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="MATCH_PASSDATE">通过日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_PRINT_NUM">打印次数</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ADVICE_NOTICE_DATE">通知日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="AF_COST_CLEAR">完费状态</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_STATE">征求状态</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_FEEDBACK_RESULT">反馈结果</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_REMINDER_STATE">催办状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="mydata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ADVICE_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="AF_COST_CLEAR" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="IS_CONVENTION_ADOPT" defaultValue="" checkValue="0=否;1=是;"/></td>
								
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								
								<td><BZ:data field="MATCH_PASSDATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="ADVICE_PRINT_NUM" defaultValue=""/></td>
								<td><BZ:data field="ADVICE_NOTICE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="AF_COST_CLEAR" defaultValue="" checkValue="0=未完费;1=已完费;"/></td>
								<td><BZ:data field="ADVICE_STATE" defaultValue="" checkValue="1=未通知;2=待反馈;3=已反馈;"/></td>
								<td><BZ:data field="ADVICE_FEEDBACK_RESULT" defaultValue="" checkValue="1=同意;2=暂停;3=重新匹配;4=退文;"/></td>
								<td>
									<%
									String ADVICE_STATE = ((Data) pageContext.getAttribute("mydata")).getString("ADVICE_STATE");
									String ADVICE_REMINDER_STATE = ((Data) pageContext.getAttribute("mydata")).getString("ADVICE_REMINDER_STATE");
									if("1".equals(ADVICE_REMINDER_STATE)){
									    if("1".equals(ADVICE_STATE)){
									%>
									<a href="javascript:void(0);" onclick="_reminderDetail('<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>')"><font color="red"><BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=未催办;1=已催办;"/></font></a>
									<%
									    }else{
									%>
									<a href="javascript:void(0);" onclick="_reminderDetail('<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>')"><BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=未催办;1=已催办;"/></a>
									<%
									    }
									}else{
									%>
									<BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=未催办;1=已催办;"/>
									<%} %>
								</td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="安置部征求意见数据" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;IS_CONVENTION_ADOPT=FLAG,0:否&1:是;ADVICE_STATE=FLAG,1:未通知&2:待反馈&3:同意&4:重新匹配&5:暂停&6:退文;ADVICE_REMINDER_STATE=FLAG,0:未催办&1:已催办;BIRTHDAY=DATE;MATCH_PASSDATE=DATE;ADVICE_NOTICE_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=收文编号,15,20;COUNTRY_CN=国家,10;NAME_CN=收养组织,15;MALE_NAME=男方,15;FEMALE_NAME=女方,15;IS_CONVENTION_ADOPT=公约收养,15;PROVINCE_ID=省份,10;WELFARE_NAME_CN=福利院,20;NAME=姓名,10;SEX=性别,10;BIRTHDAY=出生日期,15;MATCH_PASSDATE=通过日期,15;ADVICE_PRINT_NUM=打印次数,15;ADVICE_NOTICE_DATE=通知日期,15;ADVICE_STATE=征求状态,15;ADVICE_REMINDER_STATE=催办状态,15;"/></td>
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