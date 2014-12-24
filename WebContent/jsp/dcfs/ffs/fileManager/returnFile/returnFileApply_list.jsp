<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: returnFileApply_list.jsp
	 * @Description:  退文申请列表
	 * @author panfeng   
	 * @date 2014-9-2 下午5:22:13 
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
		<title>退文申请列表</title>
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
				area: ['1120px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/ReturnApplyList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_PAUSE_DATE_START").value = "";
			document.getElementById("S_PAUSE_DATE_END").value = "";
			document.getElementById("S_RECOVERY_STATE").value = "";
		}
		
		//进入退文申请确认页面
		function _confirm(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				var ci_id = arrays[i].value.split("#")[2];
				var ri_state = arrays[i].value.split("#")[3];
				if(arrays[i].checked){
					if(state!="null"&&ci_id!="null"){
						alert("This file has matched information. Please unlock before performing withdrawal operation!");
						return;
					}else if(ri_state!="9"&&ci_id!="null"){
						alert("This file has pre-approval information, please revoke the pre-approval application before performing withdrawal operation!");
						return;
					}else{
						showuuid = arrays[i].value.split("#")[0];
						num ++;
					}
				}
			}
			if(num != "1"){
				alert('Please select one data');
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/confirmShow.action?showuuid="+showuuid;
				document.srcForm.submit();
			}
		}
		
		//返回退文信息列表
		function _goback(){
			window.location.href=path+'ffs/filemanager/ReturnFileList.action';
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;WJQJZT_SYZZ">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/ReturnApplyList.action">
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
								<td class="bz-search-title" style="width: 12%"><span title="Log-in No.">收文编号<br>Log-in No.</span></td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="Log-in No." maxlength="50" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">收文日期<br>Log-in date</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="Log-in date start" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="Log-in date end" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="Adoptive father">男收养人<br>Adoptive father</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title"><span title="Adoptive mother">女收养人<br>Adoptive mother</span></td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mother" maxlength="150" style="width:270px;"/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">暂停日期<br>Suspension date</td>
								<td>
									<BZ:input prefix="S_" field="PAUSE_DATE_START" id="S_PAUSE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PAUSE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="Suspension date start" />~
									<BZ:input prefix="S_" field="PAUSE_DATE_END" id="S_PAUSE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PAUSE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="Suspension date end" />
								</td>
								
								<td class="bz-search-title">文件类型<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" isShowEN="true" formTitle="Document type" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">暂停状态<br>Suspension status</td>
								<td>
									<BZ:select prefix="S_" field="RECOVERY_STATE" id="S_RECOVERY_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="1">suspeneded</BZ:option>
										<BZ:option value="9">non-suspended</BZ:option>
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
					<input type="button" value="Confirm" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 2%;">&nbsp;</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_TYPE">文件类型(Document type)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PAUSE_DATE">暂停日期(Suspension date)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="RECOVERY_STATE">暂停状态(Suspension status)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AF_GLOBAL_STATE">文件状态(File status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="MATCH_STATE" onlyValue="true"/>#<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="RI_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" isShowEN="true" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PAUSE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="RECOVERY_STATE" defaultValue="" checkValue="1=suspeneded;9=non-suspended" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AF_GLOBAL_STATE" defaultValue="" codeName="WJQJZT_SYZZ" isShowEN="true" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN"/></td>
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