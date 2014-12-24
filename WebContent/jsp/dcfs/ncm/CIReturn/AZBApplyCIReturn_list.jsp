<%
/**   
 * @Title: AZBApplyCIReturn_list.jsp
 * @Description: 安置部材料申请退回列表
 * @author xugy
 * @date 2014-12-16下午8:00:32
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
		<title>材料申请退回列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
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
				area: ['1050px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"childInfoReturn/AZBApplyCIReturnList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_APPLY_USER").value = "";
			document.getElementById("S_APPLY_DATE_START").value = "";
			document.getElementById("S_APPLY_DATE_END").value = "";
			document.getElementById("S_CONFIRM_DATE_START").value = "";
			document.getElementById("S_CONFIRM_DATE_END").value = "";
			document.getElementById("S_APPLY_STATE").value = "";
			document.getElementById("S_CONFIRM_STATE").value = "";
		}
		
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
		//申请
		function _apply(){
			window.open(path + "childInfoReturn/AZBSelectDABCIList.action","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		}
		//
		function _addApply(ids){
			document.getElementById("ids").value = ids;
			document.srcForm.action=path+"childInfoReturn/toAZBApplyCIReturnAdd.action";
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;BCZL;">
		<BZ:form name="srcForm" method="post" action="childInfoReturn/AZBApplyCIReturnList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">省份</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="省份" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">福利院</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="福利院">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" defaultValue="" width="148px" formTitle="性别">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							
								<td class="bz-search-title">儿童类型</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" defaultValue="" width="148px" formTitle="儿童类型">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">病残种类</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" defaultValue="" width="148px" formTitle="病残种类">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">申请人</td>
								<td>
									<BZ:input prefix="S_" field="APPLY_USER" id="S_APPLY_USER" defaultValue="" formTitle="申请人" maxlength="" />
								</td>
								
								<td class="bz-search-title">申请日期</td>
								<td>
									<BZ:input prefix="S_" field="APPLY_DATE_START" id="S_APPLY_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_APPLY_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="APPLY_DATE_END" id="S_APPLY_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_APPLY_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止申请日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">确认日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="CONFIRM_DATE_START" id="S_CONFIRM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始确认日期" />~
									<BZ:input prefix="S_" field="CONFIRM_DATE_END" id="S_CONFIRM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止确认日期" />
								</td>
								
								<td class="bz-search-title">申请状态</td>
								<td>
									<BZ:select prefix="S_" field="APPLY_STATE" id="S_APPLY_STATE" defaultValue="" width="148px" formTitle="申请状态">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">待确认</BZ:option>
										<BZ:option value="2">已确认</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">确认结果</td>
								<td>
									<BZ:select prefix="S_" field="CONFIRM_STATE" id="S_CONFIRM_STATE" width="148px" formTitle="确认结果" defaultValue="0">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">同意</BZ:option>
										<BZ:option value="2">不同意</BZ:option>
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
					<input type="button" value="申&nbsp;&nbsp;请" class="btn btn-sm btn-primary" onclick="_apply()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<!-- <th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th> -->
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="APPLY_USER">申请人</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="APPLY_DATE">申请日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="CONFIRM_DATE">确认日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="APPLY_STATE">申请状态</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="CONFIRM_STATE">确认结果</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<%-- <td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="" defaultValue="" onlyValue="true"/>" class="ace">
								</td> --%>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL"/></td>
								<td><BZ:data field="APPLY_USER" defaultValue=""/></td>
								<td><BZ:data field="APPLY_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="CONFIRM_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="APPLY_STATE" defaultValue="" checkValue="1=待确认;2=已确认;"/></td>
								<td><BZ:data field="CONFIRM_STATE" defaultValue="" checkValue="1=同意;2=不同意;"/></td>
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
							<td><BZ:page form="srcForm" property="List"/></td>
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