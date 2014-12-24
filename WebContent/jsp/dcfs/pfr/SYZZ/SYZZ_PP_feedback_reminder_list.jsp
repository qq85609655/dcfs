<%
/**   
 * @Title: SYZZ_PP_feedback_reminder_list.jsp
 * @Description: 收养组织安置后报告催交列表
 * @author xugy
 * @date 2014-10-23下午2:43:34
 * @version V1.0   
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
		<title>报告催交列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			_scroll(1600,1600);
			dyniframesize(['mainFrame']);
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
				area: ['1050px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"feedback/SYZZPPFeedbackReminderList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_NAME_EN").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_NUM").value = "";
			document.getElementById("S_LIMIT_DATE_START").value = "";
			document.getElementById("S_LIMIT_DATE_END").value = "";
			document.getElementById("S_REMINDERS_DATE_START").value = "";
			document.getElementById("S_REMINDERS_DATE_END").value = "";
		}
		//
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"feedback/SYZZPPFeedbackReminderDetail.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;">
		<BZ:form name="srcForm" method="post" action="feedback/SYZZPPFeedbackReminderList.action">
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
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength=""/>
								</td>
								
								<td class="bz-search-title">签批号<br>Application number</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="签批号" maxlength="" />
								</td>
								
								<td class="bz-search-title">男方<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">女方<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="" />
								</td>
								
								<td class="bz-search-title">省份<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isShowEN="true" isCode="true" codeName="PROVINCE" formTitle="省份" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">福利院<br>SWI</td>
								<td>
									<BZ:input prefix="S_" field="WELFARE_NAME_EN" id="S_WELFARE_NAME_EN" defaultValue="" formTitle="福利院" maxlength="" />
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">姓名拼音<br>Name(EN)</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								
								<td class="bz-search-title">次第数<br>Number</td><!--  of post-placement reports -->
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="次第数" maxlength="" />
								</td>
								
								<td class="bz-search-title"></td>
								<td></td>
							</tr>
							<tr>	
								<td class="bz-search-title">截止日期<br>Deadline</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="LIMIT_DATE_START" id="S_LIMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_LIMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始截止日期" />~
									<BZ:input prefix="S_" field="LIMIT_DATE_END" id="S_LIMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_LIMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止截止日期" />
								</td>
								
								<td class="bz-search-title">催交日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="REMINDERS_DATE_START" id="S_REMINDERS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REMINDERS_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始催交日期" />~
									<BZ:input prefix="S_" field="REMINDERS_DATE_END" id="S_REMINDERS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'REMINDERS_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止催交日期" />
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
								<th style="width: 4%;">
									<div class="sorting_disabled">序号<br>(No.)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">收文编号<br>(Log-in No.)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="SIGN_NO">签批号<br>(Application number)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="MALE_NAME">男方<br>(Adoptive father)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FEMALE_NAME">女方<br>(Adoptive mother)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">省份<br>(Province)</div>
								</th>
								<th style="width: 18%;">
									<div class="sorting" id="WELFARE_NAME_EN">福利院<br>(SWI)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">姓名拼音<br>(Name(EN))</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NUM">次第数<br>(Number)</div><!--  of post-placement reports -->
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="LIMIT_DATE">截止日期<br>(Deadline)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REMINDERS_DATE">催交日期</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="FB_REC_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="FILE_NO" defaultValue="" />
								</td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" isShowEN="true" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue="" /></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" /></td>
								<td><BZ:data field="NUM" defaultValue="" /></td>
								<td><BZ:data field="LIMIT_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="REMINDERS_DATE" defaultValue="" type="date"/></td>
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
							<td><BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="安置后反馈报告催交数据" exportCode="PROVINCE_ID=CODE,PROVINCE;LIMIT_DATE=DATE;REMINDERS_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=收文编号(Log-in No.),15,20;SIGN_NO=签批号(Application number),15;MALE_NAME=男方(Adoptive father),15;FEMALE_NAME=女方(Adoptive mother),15;PROVINCE_ID=省份(Province),15;WELFARE_NAME_EN=福利院(SWI),15;NAME_PINYIN=姓名拼音(Name(EN)),15;NUM=次第数(Number),15;LIMIT_DATE=截止日期(Deadline),15;REMINDERS_DATE=催交日期,15;"/></td>
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