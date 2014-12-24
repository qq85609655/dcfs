<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="hx.util.DateUtility"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: pauseFile_listSYZZ.jsp
	 * @Description:  文件暂停信息列表
	 * @author panfeng   
	 * @date 2014-12-4 下午1:19:21 
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
	//获取当前时间
	String curDate = DateUtility.getCurrentDate();
%>
<BZ:html>
	<BZ:head language="EN">
		<title>文件暂停信息列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1500,1500);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1080px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/pause/pauseSearchList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_PAUSE_UNITNAME").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_RECOVERY_STATE").value = "";
			document.getElementById("S_PAUSE_DATE_START").value = "";
			document.getElementById("S_PAUSE_DATE_END").value = "";
			document.getElementById("S_RECOVERY_DATE_START").value = "";
			document.getElementById("S_RECOVERY_DATE_END").value = "";
			document.getElementById("S_AF_POSITION").value = "";
		}
		
		//文件超期提醒页面
		function _remindShow(id){
			var url = path + "ffs/pause/remindShow.action?AP_ID=" + id;
			modalDialog(url, this, 650, 350);
		}
		
		//查看暂停信息
		function _view(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid=arrays[i].value.split("#")[0];
					num += 1;
				}
			}
			if(num != "1"){
				alert('Please select one data!');
				return;
			}else{
				window.open(path + "ffs/pause/pauseSearchShow.action?type=SYZZ&showuuid=" + showuuid,"window","width=950,height=450,top=160,left=200,scrollbars=yes");
			}
		}
		
		//文件暂停列表导出
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		
	</script>
	<BZ:body property="data" codeNames="GJSY;SYZZ;WJWZ">
		<BZ:form name="srcForm" method="post" action="ffs/pause/pauseSearchList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="recuuid" name="recuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%"><span title="Log-in No.">收文编号<br>Log-in No.</span></td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="Log-in No." maxlength="50" style="width:200px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 8%">暂停部门</td>
								<td style="width: 12%">
									<BZ:select prefix="S_" field="PAUSE_UNITNAME" id="S_PAUSE_UNITNAME" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="办公室">办公室</BZ:option>
										<BZ:option value="安置部">安置部</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 12%">收文日期<br>Log-in date</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title"><span title="Adoptive father">男收养人<br>Adoptive father</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:200px;"/>
								</td>
								
								<td class="bz-search-title">暂停状态<br>Suspension status</td>
								<td>
									<BZ:select prefix="S_" field="RECOVERY_STATE" id="S_RECOVERY_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="1">suspeneded</BZ:option>
										<BZ:option value="9">non-suspended</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">暂停日期<br>Suspension date</td>
								<td>
									<BZ:input prefix="S_" field="PAUSE_DATE_START" id="S_PAUSE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PAUSE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始暂停日期" />~
									<BZ:input prefix="S_" field="PAUSE_DATE_END" id="S_PAUSE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PAUSE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止暂停日期" />
								</td>	
								
							</tr>
							<tr>
								
								<td class="bz-search-title"><span title="Adoptive mother">女收养人<br>Adoptive mother</span></td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mother" maxlength="150" style="width:200px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 8%">文件位置</td>
								<td style="width: 12%">
									<BZ:select prefix="S_" field="AF_POSITION" id="S_AF_POSITION" isCode="true" codeName="WJWZ" isShowEN="true" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">取消暂停日期</td>
								<td>
									<BZ:input prefix="S_" field="RECOVERY_DATE_START" id="S_RECOVERY_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECOVERY_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始取消暂停日期" />~
									<BZ:input prefix="S_" field="RECOVERY_DATE_END" id="S_RECOVERY_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RECOVERY_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止取消暂停日期" />
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
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
									&nbsp;
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AF_POSITION">文件位置</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PAUSE_UNITNAME">暂停部门</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="PAUSE_DATE">暂停日期(Suspension date)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="END_DATE">暂停期限</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="IS_OVER_DATE">是否超期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RECOVERY_DATE">取消暂停日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RECOVERY_STATE">暂停状态(Suspension status)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled">提醒标识</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<script type="text/javascript">
							<%
							String end_date = ((Data)pageContext.getAttribute("fordata")).getString("END_DATE","");
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							%>
							</script>
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AP_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAUSE_UNITNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PAUSE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="END_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<%
								if(sdf.parse(end_date).getTime() < sdf.parse(curDate).getTime()){
								%>
								<td>Yes</td>
								<%
								}else{
								%>
								<td>No</td>
								<%
								}
								%>
								<td class="center"><BZ:data field="RECOVERY_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="RECOVERY_STATE" defaultValue="" checkValue="1=suspeneded;9=non-suspended;" onlyValue="true"/></td>
								<%
								Calendar cal = Calendar.getInstance();
								cal.setTime(sdf.parse(end_date));
								cal.add(Calendar.MONTH, -1);
								if((sdf.parse(sdf.format(cal.getTime())).getTime() < sdf.parse(curDate).getTime()) && (sdf.parse(curDate).getTime() < sdf.parse(end_date).getTime())){
								%>
								<td><a href="#" onclick="_remindShow('<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>');return false;">已提醒</td>
								<%
								}else{
								%>
								<td>未提醒</td>
								<%
								}
								%>
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
							<td><BZ:page form="srcForm" isShowEN="true" property="List" type="EN" exportXls="true" exportTitle="文件暂停" exportCode="REGISTER_DATE=DATE;AF_POSITION=CODE,WJWZ;PAUSE_DATE=DATE;END_DATE=DATE;RECOVERY_DATE=DATE;RECOVERY_DATE=DATE;RECOVERY_STATE=FLAG,1:suspeneded&9:non-suspended;IS_PAUSE=FLAG,1:YES&0:NO;" exportField="FILE_NO=收文编号(Log-in No.),15,20;REGISTER_DATE=收文日期(Log-in date),15;MALE_NAME=男收养人(Adoptive father),15;FEMALE_NAME=女收养人(Adoptive mother),15;AF_POSITION=文件位置,15;PAUSE_UNITNAME=暂停部门,15;PAUSE_DATE=暂停日期(Suspension date),15;END_DATE=暂停期限,15;IS_PAUSE=是否超期,15;RECOVERY_DATE=取消暂停日期,15;RECOVERY_STATE=暂停状态(Suspension status),15;IS_PAUSE=提醒标识,15;"/></td>
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