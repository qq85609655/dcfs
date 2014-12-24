<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: 收养组织预批撤销(未撤销)
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
		<title>收养组织预批申请列表</title>
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
				area: ['1050px','360px'],
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
		//关闭
		function _goback(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		//确定
		function _confirm(){
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
				 document.srcForm.action=path+"info/SYZZREQInfoReason.action?id="+ids;
				 document.srcForm.submit();
			}
		}

		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"info/SYZZREQInfoApplicatList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REMINDERS_STATE").value = "";
			document.getElementById("S_REM_DATE_START").value = "";
			document.getElementById("S_REM_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_LAST_UPDATE_DATE_START").value = "";
			document.getElementById("S_LAST_UPDATE_DATE_END").value = "";
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;YPZT;">
		<BZ:form name="srcForm"  method="post" action="info/SYZZREQInfoApplicatList.action">
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
								<td class="bz-search-title" style="width: 9%;">男方<br>Adoptive father</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">女方<br>Adoptive mother</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								<td class="bz-search-title" style="width: 9%;">儿童姓名<br>Child name</td>
								<td style="width: 27%;">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">性别<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" isShowEN="true" formTitle="性别" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止出生日期" />
								</td>
								<td class="bz-search-title">申请日期<br>Date of application</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止申请日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">收文编号<br>Log-in No.</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								<td class="bz-search-title">收文日期<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止收文日期" />
								</td>
								<td class="bz-search-title">当前文件递交期限<br>Document submission deadline</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="当前文件递交开始日期" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="当前文件递交终止日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">催办状态<br>Reminder status</td>
								<td>
									<BZ:select prefix="S_" field="REMINDERS_STATE" id="S_REMINDERS_STATE" formTitle="Reminder status" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">un-reminded</BZ:option>
										<BZ:option value="1">reminded</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">催办日期<br>Reminder date </td>
								<td>
									<BZ:input prefix="S_" field="REM_DATE_START" id="S_REM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始催办日期" />~
									<BZ:input prefix="S_" field="REM_DATE_END" id="S_REM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止催办日期" />
								</td>
								<td class="bz-search-title">预批状态<br>Pre-approval status</td>
								<td>
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" isCode="true" codeName="YPZT" isShowEN="true" formTitle="预批状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">最后更新日期<br>Last updated</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="LAST_UPDATE_DATE_START" id="S_LAST_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_LAST_UPDATE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="LAST_UPDATE_DATE_END" id="S_LAST_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_LAST_UPDATE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止收文日期" />
								</td>
								<td class="bz-search-title">答复日期<br>Response date</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始答复日期" />~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止答复日期" />
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
					<input type="button" value="Confirm" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<!-- <input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp; -->
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
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
								<th style="width: 4%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="MALE_NAME">男方(Adoptive father)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FEMALE_NAME">女方(Adoptive mother)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">姓名(Child name)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">性别(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期(D.O.B)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="REQ_DATE">申请日期(Date of application)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PASS_DATE">答复日期(Response date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RI_STATE">预批状态(Pre-approval status)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SUBMIT_DATE">当前文件递交期限(Document submission deadline)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REMINDERS_STATE">催办状态(Reminder status)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REM_DATE">催办日期(Reminder date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="LAST_UPDATE_DATE">最后更新日期(Last updated)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="REQ_DATE" defaultValue="" type="date"  onlyValue="true"/></td>
								<td><BZ:data field="PASS_DATE" defaultValue="" type="date"  onlyValue="true"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" codeName="YPZT" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="SUBMIT_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="REMINDERS_STATE" defaultValue="" checkValue="0=un-reminded;1=reminded;"  onlyValue="true"/></td>
								<td><BZ:data field="REM_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="LAST_UPDATE_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
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
								<BZ:page form="srcForm" type="EN" property="List" exportXls="true" exportTitle="撤销申请列表" exportCode="SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;REQ_DATE=DATE;RI_STATE=CODE,YPZT;SUBMIT_DATE=DATE;REMINDERS_STATE=FLAG,0:un-reminded&1:reminded;REM_DATE=DATE;REGISTER_DATE=DATE;LAST_UPDATE_DATE=DATE;"  exportField="MALE_NAME=男方(Adoptive father),15,20;FEMALE_NAME=女方(Adoptive mother),15;NAME=姓名(Child name),15;SEX=性别(Sex),15;BIRTHDAY=出生日期(D.O.B),15;REQ_DATE=申请日期(Date of application),15;RI_STATE=预批状态(Pre-approval status),15;SUBMIT_DATE=当前文件递交期限(Document submission deadline),15;REMINDERS_STATE=催办状态(Reminder status),15;REM_DATE=催办日期(Reminder date),15;REGISTER_DATE=收文日期(Log-in date),15;FILE_NO=收文编号(Log-in No.),15;LAST_UPDATE_DATE=最后更新日期(Last updated),15;"/>
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