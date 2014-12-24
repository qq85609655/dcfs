<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: checkcollection_colsearch.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-10-21 下午13:11:16 
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
		<title>托收单查询列表</title>
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
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','160px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"fam/checkCollection/colSearchList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_COL_DATE_START").value = "";
			document.getElementById("S_COL_DATE_END").value = "";
			document.getElementById("S_COL_USERNAME").value = "";
			document.getElementById("S_SUM_MIN").value = "";
			document.getElementById("S_SUM_MAX").value = "";
			document.getElementById("S_NUM").value = "";
		}
		
		//托收单打印
		function _print(){
			var num = 0;
			var coluuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					coluuid = arrays[i].value.split("#")[0];
					num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条托收单信息！");
				return;
			}else{
				window.open(path + "fam/checkCollection/checkCollectionPrint.action?coluuid="+coluuid,"newwindow","height=842,width=680,top=100,left=350,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
				//document.srcForm.action=path+"fam/checkCollection/checkCollectionPrint.action?coluuid="+coluuid;
				//document.srcForm.submit();
			}
		}
		
		//页面返回
		function _goback(){
			window.location.href=path+'fam/checkCollection/checkCollectionList.action';
		}
		

	</script>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" action="fam/checkCollection/colSearchList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="checkuuid" name="checkuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 15%">托收日期</td>
								<td style="width: 35%">
									<BZ:input prefix="S_" field="COL_DATE_START" id="S_COL_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_COL_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始托收日期" />~
									<BZ:input prefix="S_" field="COL_DATE_END" id="S_COL_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_COL_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止托收日期" />
								</td>
							
								<td class="bz-search-title" style="width: 15%"><span title="托收人">托收人</span></td>
								<td style="width: 35%">
									<BZ:input prefix="S_" field="COL_USERNAME" id="S_COL_USERNAME" defaultValue="" formTitle="托收人" maxlength="256"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">托收单总金额</td>
								<td>
									<BZ:input prefix="S_" field="SUM_MIN" id="S_SUM_MIN" defaultValue="" formTitle="最小总金额" maxlength="22"/>~
									<BZ:input prefix="S_" field="SUM_MAX" id="S_SUM_MAX" defaultValue="" formTitle="最大总金额" maxlength="22"/>
								</td>	
								
								<td class="bz-search-title">支票数量</td>
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="支票数量" maxlength="5"/>
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
					<input type="button" value="托收单打印" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
					<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 5%;">
									<div class="sorting_disabled">
										&nbsp;
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 25%;">
									<div class="sorting" id="COL_DATE">托收日期</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="COL_USERNAME">托收人</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="NUM">支票数量</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="SUM">托收单总金额</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="CHEQUE_COL_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="COL_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="COL_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NUM" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUM" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" /></td>
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