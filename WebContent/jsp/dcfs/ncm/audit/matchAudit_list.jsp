<%
/**   
 * @Title: matchAudit_list.jsp
 * @Description: 匹配审核列表
 * @author xugy
 * @date 2014-9-6下午3:42:31
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
		<title>匹配审核列表</title>
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
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
				area: ['1050px','270px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"matchAudit/matchAuditList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_MATCH_NUM").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			//document.getElementById("S_OPERATION_STATE").value = "";
			document.getElementById("S_MATCH_STATE").value = "0";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		//
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
		//审核信息添加
		function _auditAdd(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					var MATCH_STATE = ids.split(",")[5];
					if(MATCH_STATE != "0"){
						page.alert("请选择经办人待审核的数据");
						return;
					}
					num += 1;//OPERATION_STATE
				}
			}
			if(num != "1"){
				page.alert('请选择一条经办人待审核的数据');
				return;
			}else{
				document.srcForm.action=path+"matchAudit/toMatchAuditAdd.action?ids="+ids;
				document.srcForm.submit();
			}
		}
		//解除匹配
		function _relieveMatch(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					var MATCH_STATE = ids.split(",")[5];
					if(MATCH_STATE != "3"){
						page.alert("该数据不能执行解除匹配");
						return;
					}
					var CI_ID = ids.split(",")[3];
					var rv = getStr("com.dcfs.ncm.audit.AjaxJudgeCIPosition","CI_ID="+CI_ID);
					//alert(rv);
					if(rv == "0"){
						page.alert("该匹配信息的儿童材料（或同胞）不在安置部，不能执行解除匹配");
						return;
					}
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条审核通过的数据');
				return;
			}else{
				document.srcForm.action=path+"matchAudit/toRelieveMatch.action?ids="+ids;
				document.srcForm.submit();
			}
		}
		//
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条数据');
				return;
			}else{
				document.srcForm.action=path+"matchAudit/matchAuditDetail.action?ids="+ids;
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;CHILD_TYPE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="matchAudit/matchAuditList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
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
								<td class="bz-search-title" style="width: 8%;">收文编号</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">收文日期</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">国家</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
								<td class="bz-search-title">男方</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
							
								<td class="bz-search-title">女方</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">文件类型</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" width="148px" formTitle="文件类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">匹配次数</td>
								<td>
									<BZ:input prefix="S_" field="MATCH_NUM" id="S_MATCH_NUM" defaultValue="" formTitle="匹配次数" maxlength="" />
								</td>
								<td class="bz-search-title">儿童类型</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" width="148px" formTitle="儿童类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">正常</BZ:option>
										<BZ:option value="2">特需</BZ:option>
									</BZ:select>
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
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px;" formTitle="福利院">
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
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								<%-- <td class="bz-search-title">操作状态</td>
								<td>
									<BZ:select prefix="S_" field="OPERATION_STATE" id="S_OPERATION_STATE" width="148px" formTitle="操作状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待处理</BZ:option>
										<BZ:option value="1">处理中</BZ:option>
										<BZ:option value="2">已处理</BZ:option>
									</BZ:select>
								</td> --%>
								<td class="bz-search-title">匹配状态</td>
								<td>
									<BZ:select prefix="S_" field="MATCH_STATE" id="S_MATCH_STATE" width="148px" formTitle="匹配状态" defaultValue="0">
										<BZ:option value="0">经办人待审核</BZ:option>
										<BZ:option value="1">部门主任待审核</BZ:option>
										<BZ:option value="3">审核通过</BZ:option>
										<BZ:option value="4">审核不通过</BZ:option>
										<BZ:option value="9">无效</BZ:option>
										<BZ:option value="99">全部数据</BZ:option>
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
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_auditAdd()"/>&nbsp;
					<input type="button" value="解除匹配" class="btn btn-sm btn-primary" onclick="_relieveMatch()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">收文日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">国家</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="MALE_NAME">男方</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FEMALE_NAME">女方</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="FILE_TYPE">文件类型</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="MATCH_NUM">匹配次数</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="MATCH_STATE">匹配状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dl" fordata="mydata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MAU_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="OPERATION_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="MATCH_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="FILE_TYPE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
								<td><BZ:data field="MATCH_NUM" defaultValue=""/></td>
								
								<td><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="MATCH_STATE" defaultValue="" checkValue="0=经办人待审核;1=部门主任待审核;3=审核通过;4=审核不通过;9=无效;"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="经办人审核数据" exportCode="FILE_TYPE=CODE,WJLX;PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;CHILD_TYPE=CODE,CHILD_TYPE;OPERATION_STATE=FLAG,0:待处理&1:处理中&2:已处理;MATCH_STATE=FLAG,0:经办人待审核&1:部门主任待审核&3:审核通过&4:审核不通过&9:无效;REGISTER_DATE=DATE;BIRTHDAY=DATE,yyyy/MM/dd" exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=收文日期,15;COUNTRY_CN=国家,15;NAME_CN=收养组织,20;MALE_NAME=男方,15;FEMALE_NAME=女方,15;FILE_TYPE=文件类型,10;MATCH_NUM=匹配次数,10;CHILD_TYPE=儿童类型,10;PROVINCE_ID=省份,10;WELFARE_NAME_CN=福利院,20;NAME=姓名,15;SEX=性别,10;BIRTHDAY=出生日期,15;MATCH_STATE=匹配状态,20;"/></td>
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