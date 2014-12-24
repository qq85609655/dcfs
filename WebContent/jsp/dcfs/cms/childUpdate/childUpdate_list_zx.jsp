<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	Data da = (Data)request.getAttribute("data");
    String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料更新列表(中心)</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			initProvOrg();
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"cms/childupdate/updateListZX.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			//document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_UPDATE_STATE").value = "";
			//document.getElementById("S_CHECKUP_DATE_START").value = "";
			//document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_UPDATE_DATE_START").value = "";
			document.getElementById("S_UPDATE_DATE_END").value = "";
			document.getElementById("S_UPDATE_USERNAME").value = "";
			
		}	
		//修改未提交的更新申请
		function _modify(){
			var num = 0;
			var CUI_ID = "";
			var state="";
			var CI_ID="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CUI_ID =arrays[i].value.split("#")[0];
					state=arrays[i].value.split("#")[1];
					CI_ID=arrays[i].value.split("#")[2];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要修改的更新记录！");
				return;
			}else{
				if(state!="0"){
				   page.alert("只能修改更新状态为未提交的更新记录，请重新选择！");
				   return;
					}
				document.srcForm.action=path+"cms/childupdate/toModify.action?"+"CUI_ID="+CUI_ID+"&CI_ID="+CI_ID+"&UPDATE_TYPE=3";
				document.srcForm.submit();
			}
		}
		//查看补充材料详细信息
		function _showDetail(){
			var num = 0;
			var CUI_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CUI_ID =arrays[i].value.split("#")[0];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要查看更新记录！");
				return;
			}else{
			//	TODO 
			 var url = path + "cms/childupdate/getShowData.action?UUID="+CUI_ID;
				//window.open(url,"window",'height=450,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
				_open(url, "window", 1000, 500);
			}
		}
		//列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//省厅福利院查询条件联动所需方法
		function selectWelfare(node){
			var provinceId = node.value;
			//用于回显得福利机构ID
			var selectedId = '<%=WELFARE_ID%>';
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						var option = document.getElementById("S_WELFARE_ID");
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}else{					
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
			}
		}
		//省厅福利院查询条件联动所需方法
		function initProvOrg(){
			var str = document.getElementById("S_PROVINCE_ID");
		     selectWelfare(str);
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;CHILD_TYPE;PROVINCE;UPDATE_STATE;">
		<BZ:form name="srcForm" method="post" action="cms/childupdate/updateListZX.action">
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
							   <td class="bz-search-title" style="width: 8%">省份</td>
								<td style="width: 16%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</td>
								<td style="width: 10%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 85%"/>
								</td>
								
								<td class="bz-search-title" style="width: 8%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
								<td style="width: 8%">
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">出生日期</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >福利院</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title">病残种类</td>
								<td>
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title" >更新状态</td>
							    <td>
							    	<BZ:select prefix="S_" field="UPDATE_STATE" id="S_UPDATE_STATE" isCode="true" codeName="UPDATE_STATE" formTitle="更新状态" defaultValue="" width="100%" >
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								
								</td>	
								
								<td class="bz-search-title">更新日期</td>
								<td>
									<BZ:input prefix="S_" field="UPDATE_DATE_START" id="S_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_UPDATE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="UPDATE_DATE_END" id="S_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_UPDATE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止申请日期" />
								</td>
							  
							</tr>
							<tr>	
								<td class="bz-search-title">更新人</td>
								<td>
								    <BZ:input prefix="S_" field="UPDATE_USERNAME" id="S_UPDATE_USERNAME" defaultValue="" formTitle="更新人" maxlength="150" style="width: 50%"/>
								</td>
								
								<td class="bz-search-title">&nbsp;</td>
								<td colspan="5">
									&nbsp;
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
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
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_showDetail();"/>&nbsp;
					<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_modify();"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="UPDATE_USERNAME">更新人</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="UPDATE_DATE">更新日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="UPDATE_STATE">更新状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CUI_ID" onlyValue="true"/>#<BZ:data field="UPDATE_STATE" onlyValue="true"/>#<BZ:data field="CI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_USERNAME" defaultValue=""  onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_STATE" defaultValue=""  codeName="UPDATE_STATE" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="儿童材料更新" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;SN_TYPE=CODE,BCZL;UPDATE_DATE=DATE;UPDATE_STATE=CODE,UPDATE_STATE;" exportField="PROVINCE_ID=省份,10,20;WELFARE_NAME_CN=福利院,25;NAME=姓名,15;SEX=性别,10;BIRTHDAY=出生日期,15;SN_TYPE=病残种类,28;UPDATE_USERNAME=更新人,15;UPDATE_DATE=更新日期,15;UPDATE_STATE=更新状态,15;"/></td>
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