<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: returnFile_list.jsp
	 * @Description:  退文信息列表
	 * @author panfeng   
	 * @date 2014-9-2 下午3:01:44 
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
		<title>退文信息列表</title>
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
				area: ['1120px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/ReturnFileList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_APPLE_DATE_START").value = "";
			document.getElementById("S_APPLE_DATE_END").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_DUAL_USERNAME").value = "";
			document.getElementById("S_DUAL_DATE_START").value = "";
			document.getElementById("S_DUAL_DATE_END").value = "";
			document.getElementById("S_RETURN_STATE").value = "";
			document.getElementById("S_HANDLE_TYPE").value = "";
		}
		
		//跳转到退文申请列表
		function _showReturnFile(){
			window.location.href=path+"ffs/filemanager/ReturnApplyList.action";
		}
		
		//退文列表导出
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;TWCZFS_ALL;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/ReturnFileList.action">
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
								<td class="bz-search-title" style="width: 12%"><span title="Adoptive father">男收养人<br>Adoptive father</span></td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">女收养人<br>Adoptive mother</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mather" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%"><span title="Log-in No.">收文编号<br>Log-in No.</span></td>
								<td style="width: 10%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="Log-in No." maxlength="50"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">收文日期<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="Log-in date start" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="Log-in date end" />
								</td>	
								
								<td class="bz-search-title">申请日期<br>Date of application</td>
								<td>
									<BZ:input prefix="S_" field="APPLE_DATE_START" id="S_APPLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_APPLE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="APPLE_DATE_END" id="S_APPLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_APPLE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止申请日期" />
								</td>
							
								<td class="bz-search-title">文件类型<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" isShowEN="true" formTitle="Document type" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 12%">处置人<br>Handled by</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="DUAL_USERNAME" id="S_DUAL_USERNAME" defaultValue="" formTitle="Handled by" maxlength="256" style="width:270px;"/>
								</td>
									
								<td class="bz-search-title">处置日期<br>Date</td>
								<td>
									<BZ:input prefix="S_" field="DUAL_DATE_START" id="S_DUAL_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_DUAL_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始处置日期" />~
									<BZ:input prefix="S_" field="DUAL_DATE_END" id="S_DUAL_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_DUAL_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止处置日期" />
								</td>
								
								<td class="bz-search-title">退文状态<br>Withdrawal status</td>
								<td>
									<BZ:select prefix="S_" field="RETURN_STATE" id="S_RETURN_STATE" formTitle="" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">To-be-comfired</BZ:option>
										<BZ:option value="1">comfired</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">退文处置方式<br>Treatment of withdrawal</td>
								<td>
									<BZ:select prefix="S_" field="HANDLE_TYPE" id="S_HANDLE_TYPE" isCode="true" codeName="TWCZFS_ALL" isShowEN="true" formTitle="Treatment of withdrawal" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
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
					<input type="button" value="Withdraw" class="btn btn-sm btn-primary" onclick="_showReturnFile()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">文件类型(Document type)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="APPLE_DATE">申请日期(Date of application)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="DUAL_USERNAME">处置人(Handled by)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="DUAL_DATE">处置日期(Date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RETURN_STATE">退文状态(Withdrawal status)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="HANDLE_TYPE">退文处置方式(Treatment of withdrawal)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" isShowEN="true" onlyValue="true"/></td>
								<td class="center"><BZ:data field="APPLE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="DUAL_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="DUAL_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=待确认;1=已确认;2=待处置;3=已处置;9=取消退文" onlyValue="true"/></td>
								<td><BZ:data field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" isShowEN="true" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" isShowEN="true" property="List" type="EN" exportXls="true" exportTitle="退文信息" exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;APPLE_DATE=DATE;DUAL_DATE=DATE;RETURN_STATE=FLAG,0:To-be-comfired&1:comfired;HANDLE_TYPE=CODE,TWCZFS_ALL;" exportField="FILE_NO=收文编号(Log-in No.),15,20;REGISTER_DATE=收文日期(Log-in date),15;MALE_NAME=男收养人(Adoptive father),15;FEMALE_NAME=女收养人(Adoptive mother),15;FILE_TYPE=文件类型(Document type),15;APPLE_DATE=申请日期(Date of application),15;DUAL_USERNAME=处置人(Handled by),15;DUAL_DATE=处置日期(Date),15;RETURN_STATE=退文状态(Withdrawal status),15;HANDLE_TYPE=退文处置方式(Treatment of withdrawal),15;"/></td>
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