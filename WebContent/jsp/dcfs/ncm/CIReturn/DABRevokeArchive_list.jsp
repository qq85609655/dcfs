<%
/**   
 * @Title: DABRevokeArchive_list.jsp
 * @Description: 档案部撤销档案列表
 * @author xugy
 * @date 2014-12-17下午1:57:32
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
		<title>档案部撤销档案列表</title>
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
			_scroll(1900,1900);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
				area: ['1050px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"childInfoReturn/DABRevokeArchiveList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_ARCHIVE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_ARCHIVE_STATE").value = "";
			document.getElementById("S_CONFIRM_USER").value = "";
			document.getElementById("S_CONFIRM_DATE_START").value = "";
			document.getElementById("S_CONFIRM_DATE_END").value = "";
			document.getElementById("S_APPLY_STATE").value = "";
			document.getElementById("S_NAME").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
		//
		function _confirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					var APPLY_STATE = ids.split(",")[2];
					if(APPLY_STATE != "1"){
						page.alert("请选择待确认的数据");
						return;
					}
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条待确认的数据');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"childInfoReturn/toDABRevokeArchiveAdd.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="childInfoReturn/DABRevokeArchiveList.action">
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
								<td class="bz-search-title">档案号</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="档案号" maxlength="" />
								</td>
								
								<td class="bz-search-title">签批号</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="签批号" maxlength="" />
								</td>
								
								<td class="bz-search-title">签批日期</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始签批日期" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止签批日期" />
								</td>
							</tr>
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
								
								<td class="bz-search-title">儿童姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">文件编号</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="文件编号" maxlength="" />
								</td>
								
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" maxlength="" />
								</td>
								
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="" />
								</td>
								
								<td class="bz-search-title">归档状态</td>
								<td>
									<BZ:select prefix="S_" field="ARCHIVE_STATE" id="S_ARCHIVE_STATE" formTitle="归档状态" width="148px" defaultValue="">
										<option value="">--请选择--</option>
										<option value="0">未归档</option>
										<option value="1">已归档</option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">确认人</td>
								<td>
									<BZ:input prefix="S_" field="CONFIRM_USER" id="S_CONFIRM_USER" defaultValue="" formTitle="确认人" maxlength="" />
								</td>
								
								<td class="bz-search-title">确认日期</td>
								<td>
									<BZ:input prefix="S_" field="CONFIRM_DATE_START" id="S_CONFIRM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始确认日期" />~
									<BZ:input prefix="S_" field="CONFIRM_DATE_END" id="S_CONFIRM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止确认日期" />
								</td>
								
								<td class="bz-search-title">确认状态</td>
								<td>
									<BZ:select prefix="S_" field="APPLY_STATE" id="S_APPLY_STATE" defaultValue="" width="148px" formTitle="确认状态">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">待确认</BZ:option>
										<BZ:option value="2">已确认</BZ:option>
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
					<input type="button" value="确&nbsp;&nbsp;认" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
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
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_NO">档案号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SIGN_NO">签批号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_DATE">签批日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_NO">文件编号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ARCHIVE_STATE">归档状态</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="CONFIRM_USER">确认人</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="CONFIRM_DATE">确认日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="APPLY_STATE">确认状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="NAR_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="APPLY_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue=""/></td>
								<td><BZ:data field="SIGN_NO" defaultValue=""/></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="ARCHIVE_STATE" defaultValue="" checkValue="0=未归档;1=已归档;"/></td>
								<td><BZ:data field="CONFIRM_USER" defaultValue=""/></td>
								<td><BZ:data field="CONFIRM_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="APPLY_STATE" defaultValue="" checkValue="1=待确认;2=已确认;"/></td>
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