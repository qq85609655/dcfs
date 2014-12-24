<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
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
		<title>发布计划列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['920px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/publishPlan/findListForFBJH.action";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PLAN_NO").value = "";
			document.getElementById("S_PLAN_USERNAME").value = "";
			document.getElementById("S_PLAN_DATE_START").value = "";
			document.getElementById("S_PLAN_DATE_END").value = "";
			document.getElementById("S_NOTICE_STATE").value = "";
			document.getElementById("S_NOTE_DATE_START").value = "";
			document.getElementById("S_NOTE_DATE_END").value = "";
			document.getElementById("S_PLAN_STATE").value = "";
			document.getElementById("S_PUB_DATE_START").value = "";
			document.getElementById("S_PUB_DATE_END").value = "";
		}
		
		//业务自定义功能操作JS
		
		//跳转到新增发布计划基本信息页面
		function _toPlanBaseInfoAdd(){
			document.srcForm.action=path+"sce/publishPlan/toPlanBaseInfoAdd.action";
			document.srcForm.submit();
		}
		
		//跳转到修改发布计划基本信息页面
		function _toPlanBaseInfoRevise(){
			var num = 0;
			var plan_id;
			var pub_state;
			var temp;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					temp= arrays[i].value.split(";");
					plan_id = temp[0];
					pub_state = temp[1];
					num++;
				}
				
			}
			
			if(num < 1){
				page.alert('请选择一条发布状态为"制定中"的记录！');
				return;
			}else if(pub_state=='2'||pub_state=='1'){
				page.alert('请选择一条发布状态为"制定中"的记录！');
				return;
			}else{
				$("#H_PLAN_ID").val(plan_id);
				document.srcForm.action=path+"sce/publishPlan/toPlanBaseInfoRevise.action";
				document.srcForm.submit();
			}
		}
		
		//判断是否允许制定新的发布计划
		function _isCanMakeNewPlan(){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishPlan.PublishPlanAjax&method=isCanMakeNewPlan',
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						_toPlanBaseInfoAdd();
					}else{
						page.alert('存在"制定中"或"待发布"的记录，请先发布，再制定新的计划！');
						return false;
					}
				}
			})
		}
		
		//删除发布计划
		function _deletePlan(){
			if(confirm("确定删除该计划吗？")){
				var num = 0;
				var plan_id;
				var pub_state;
				var temp;
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						temp= arrays[i].value.split(";");
						plan_id = temp[0];
						pub_state = temp[1];
						num++;
					}
					
				}
				
				if(num < 1){
					page.alert('请选择一条发布状态为"制定中"或"待发布"的记录！');
					return;
				}else if(pub_state=='2'){
					page.alert('请选择一条发布状态为"制定中"或"待发布"的记录	！');
					return;
				}else{
					$("#H_PLAN_ID").val(plan_id);
					document.srcForm.action=path+"sce/publishPlan/deletePlan.action";
					document.srcForm.submit();
				}
			}
			
		}
		
		//计划发布
		function _planPublish(){
			if(confirm("确定发布该计划吗？")){
				var num = 0;
				var plan_id;
				var pub_state;
				var temp;
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						temp= arrays[i].value.split(";");
						plan_id = temp[0];
						pub_state = temp[1];
						num++;
					}
					
				}
				
				if(num < 1){
					page.alert('请选择一条发布状态为"待发布"的记录！');
					return;
				}else if(pub_state=='0'||pub_state=='2'){
					page.alert('请选择一条发布状态为"待发布"的记录！');
					return;
				}else{
					$("#H_PLAN_ID").val(plan_id);
					
					$.ajax({
						url: path+'AjaxExecute?className=com.dcfs.sce.publishPlan.PublishPlanAjax&method=isCanPublishPlan&PLAN_ID='+plan_id,
						type: 'POST',
						dataType: 'json',
						timeout: 10000,
						success: function(data){
							if(data.FLAG){
								document.srcForm.action=path+"sce/publishPlan/planPublish.action";
								document.srcForm.submit();
							}else{
								page.alert('该计划没有关联儿童，请在【维护】功能中添加儿童！');
								return false;
							}
						}
					})
					
				}
			}
		}
		
		//维护发布计划
		function _toPlanInfoModify(){
			var num = 0;
			var plan_id;
			var pub_state;
			var temp;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					temp= arrays[i].value.split(";");
					plan_id = temp[0];
					pub_state = temp[1];
					num++;
				}
				
			}
			
			if(num < 1){
				page.alert('请选择一条发布状态为"制定中"或"待发布"的记录！');
				return;
			}else if(pub_state=='2'){
				page.alert('请选择一条发布状态为"制定中"或"待发布"的记录！');
				return;
			}else{
				$("#H_PLAN_ID").val(plan_id);
				document.srcForm.action=path+"sce/publishPlan/toModifyPlan.action";
				document.srcForm.submit();
			}
		}
		
		//发布计划打印
		function _print(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split(";")[0];
					num ++;
				}
			}
			if(num != "1"){
				alert('请选择一条数据');
				return;
			}else{
				window.open(path + "sce/publishPlan/printShow.action?showuuid="+showuuid,"window","height=842,width=680,top=100,left=350,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
			}
		}
		
		//选择待发布的儿童列表
		function _toViewPlan(plan_id){
			$.layer({
				type : 2,
				title : "发布计划详细信息查看",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishPlan/toViewPlan.action?PLAN_ID='+plan_id},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
		}
		
		//手动预告
		function _yg(){
			if(confirm("确定手动预告该计划吗？")){
				var num = 0;
				var plan_id;
				var pub_state;
				var notice_state;
				var temp;
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						temp= arrays[i].value.split(";");
						plan_id = temp[0];
						pub_state = temp[1];
						notice_state = temp[2];
						num++;
					}
					
				}
				
				if(num < 1){
					page.alert('请选择一条预告状态为"未预告"且发布状态为"待发布"的记录！');
					return;
				}else if(pub_state=='0'||pub_state=='2'||notice_state=='1'){
					page.alert('请选择一条预告状态为"未预告"且发布状态为"待发布"的记录！');
					return;
				}else{
					$("#H_PLAN_ID").val(plan_id);
					document.srcForm.action=path+"sce/publishPlan/sdyg.action";
					document.srcForm.submit();
					
				}
			}
		}

	</script>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" action="sce/publishPlan/findListForFBJH.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<BZ:input type="hidden" prefix="H_" field="PLAN_ID" id="H_PLAN_ID"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" nowrap width="10%">计划批号</td>
								<td nowrap width="15%">
									<BZ:input prefix="S_" field="PLAN_NO" id="S_PLAN_NO" defaultValue="" formTitle="计划批号" maxlength="9"/>
								</td>
								<td class="bz-search-title" nowrap width="10%">制定人</td>
								<td nowrap width="15%">
									<BZ:input field="PLAN_USERNAME" prefix="S_" id="S_PLAN_USERNAME" formTitle="制定人" defaultValue=""/> 
								</td>
								<td class="bz-search-title" nowrap width="10%">预告状态</td>
								<td nowrap width="15%">
									<BZ:select prefix="S_" field="NOTICE_STATE" id="S_NOTICE_STATE" formTitle="预告状态" defaultValue=""  >
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未预告</BZ:option>
										<BZ:option value="1">已预告</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" nowrap width="10%">发布状态</td>
								<td nowrap width="15%">
									<BZ:select prefix="S_" field="PLAN_STATE" id="S_PLAN_STATE"  formTitle="发布状态" defaultValue="" >
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">制定中</BZ:option>
										<BZ:option value="1">待发布</BZ:option>
										<BZ:option value="2">已发布</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" nowrap>制定日期</td>
								<td nowrap colspan="2">
									<BZ:input prefix="S_" field="PLAN_DATE_START" id="S_PLAN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PLAN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始制定日期" />~
									<BZ:input prefix="S_" field="PLAN_DATE_END" id="S_PLAN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PLAN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止制定日期" />
								</td>
								<td class="bz-search-title" nowrap>预告日期</td>
								<td nowrap colspan="2">
									<BZ:input prefix="S_" field="NOTE_DATE_START" id="S_NOTE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始预告日期" />~
									<BZ:input prefix="S_" field="NOTE_DATE_END" id="S_NOTE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止预告日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" nowrap>发布日期</td>
								<td nowrap colspan="5">
									<BZ:input prefix="S_" field="PUB_DATE_START" id="S_PUB_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始发布日期" />~
									<BZ:input prefix="S_" field="PUB_DATE_END" id="S_PUB_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止发布日期" />
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
					<input type="button" value="制&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_isCanMakeNewPlan()"/>&nbsp;
					<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_toPlanBaseInfoRevise()"/>&nbsp;
					<input type="button" value="维&nbsp;&nbsp;护" class="btn btn-sm btn-primary" onclick="_toPlanInfoModify()"/>&nbsp;
					<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_deletePlan()"/>&nbsp;
					<input type="button" value="手动预告" class="btn btn-sm btn-primary" onclick="_yg()"/>&nbsp;
					<input type="button" value="手动发布" class="btn btn-sm btn-primary" onclick="_planPublish()"/>&nbsp;
					<input type="button" value="打&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print();"/>
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls');"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 1%;">
									<div class="sorting_disabled">
									</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width:9%;">
									<div class="sorting" id="PLAN_NO">计划批号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PLAN_USERNAME">制定人</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PLAN_DATE">制定日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PUB_NUM">儿童总数</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTICE_STATE">预告状态</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTE_DATE">预告日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PLAN_STATE">发布状态</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_DATE">发布日期</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="PLAN_ID" onlyValue="true"/>;<BZ:data field="PLAN_STATE" onlyValue="true"/>;<BZ:data field="NOTICE_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><a href="javascript:void" title="点击查看计划详细信息" onclick="_toViewPlan('<BZ:data field="PLAN_ID" onlyValue="true"/>')"><BZ:data field="PLAN_NO" defaultValue="" onlyValue="true" /></a></td>
								<td><BZ:data field="PLAN_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PLAN_DATE" defaultValue="" type="Date" onlyValue="true" /></td>
								<td><BZ:data field="PUB_NUM" defaultValue=""  onlyValue="true" /></td>
								<td><BZ:data field="NOTICE_STATE" defaultValue="" checkValue="0=未预告;1=已预告" onlyValue="true"/></td>
								<td><BZ:data field="NOTE_DATE" defaultValue=""  type="DateTime" onlyValue="true"/></td>
								<td><BZ:data field="PLAN_STATE" defaultValue="" checkValue="0=制定中;1=待发布;2=已发布" onlyValue="true"/></td>
								<td><BZ:data field="PUB_DATE" defaultValue="" type="DateTime" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="发布计划列表" exportCode="NOTICE_STATE=FLAG,0:未预告&1:已预告;PLAN_STATE=FLAG,0:制定中&1:待发布&2=已发布;PLAN_DATE=DATE;NOTE_DATE=DATE;PUB_DATE=DATE" 
							exportField="PLAN_NO=计划批号,15,20;PLAN_USERNAME=制定人,20;PLAN_DATE=制定日期,15;PUB_NUM=儿童总数,8;NOTICE_STATE=预告状态,15;NOTE_DATE=预告日期,15;PLAN_STATE=发布状态,15;PUB_DATE=发布日期,15;"
							/></td>
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