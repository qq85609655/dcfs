<%
/**   
 * @Title: AFSpecialMatch_list.jsp
 * @Description: 收养人特需匹配列表
 * @author xugy
 * @date 2014-9-6上午10:33:32
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
%>
<BZ:html>
	<BZ:head>
		<title>特需儿童匹配列表</title>
		<BZ:webScript list="true"/>
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
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
			_scroll(1700,1700);
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
				area: ['1050px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"specialMatch/AFSpecialMatchList.action?page=1";
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
			document.getElementById("S_MATCH_RECEIVEDATE_START").value = "";
			document.getElementById("S_MATCH_RECEIVEDATE_END").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_ADOPT_REQUEST_CN").value = "";
			document.getElementById("S_UNDERAGE_NUM").value = "";
			document.getElementById("S_MATCH_NUM").value = "";
			document.getElementById("S_MATCH_STATE").value = "0";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		//特需儿童匹配
		function _match(){
			var num = 0;
			var AFid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids=document.getElementsByName('xuanze')[i].value;
					var MATCH_STATE = ids.split(",")[1];
					if(MATCH_STATE != "0"){
						page.alert("请选择待匹配的数据");
						return;
					}
					AFid = ids.split(",")[0];
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条数据匹配 ');
				return;
			}else{
				/* var w = document.body.clientWidth-20+'px';
				var h = window.screen.availHeight-170+'px';
				$.layer({
					type : 2,
					title : "匹配儿童",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					//page : {dom : '#planList'},
					iframe: {src: '<BZ:url/>/specialMatch/CISpecialMatchList.action?AFid='+AFid},
					area: [w,h],
					offset: ['0px' , '0px']
				}); */
				
				window.open(path + "specialMatch/CISpecialMatchList.action?AFid="+AFid,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
			}
		}
		//保存匹配结果后，刷新列表
		function _matchResultView(result){
			//layer.closeAll();
			document.srcForm.action=path+"specialMatch/AFSpecialMatchList.action?page=1&result="+result;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="specialMatch/AFSpecialMatchList.action">
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
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 8%;">收文日期</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
								
								<td class="bz-search-title" style="width: 8%;">国家</td>
								<td style="width: 20%;">
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
								<td class="bz-search-title">接收日期</td>
								<td>
									<BZ:input prefix="S_" field="MATCH_RECEIVEDATE_START" id="S_MATCH_RECEIVEDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_MATCH_RECEIVEDATE_END\\')}',readonly:true" defaultValue="" formTitle="起始接收日期" />~
									<BZ:input prefix="S_" field="MATCH_RECEIVEDATE_END" id="S_MATCH_RECEIVEDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_MATCH_RECEIVEDATE_START\\')}',readonly:true" defaultValue="" formTitle="截止接收日期" />
								</td>
								
								<td class="bz-search-title">文件类型</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" width="148px" formTitle="文件类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">收养要求</td>
								<td>
									<BZ:input prefix="S_" field="ADOPT_REQUEST_CN" id="S_ADOPT_REQUEST_CN" defaultValue="" formTitle="收养要求" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">子女数量</td>
								<td>
									<BZ:input prefix="S_" field="UNDERAGE_NUM" id="S_UNDERAGE_NUM" defaultValue="" formTitle="子女数量" maxlength="" />
								</td>
								<td class="bz-search-title">匹配次数</td>
								<td>
									<BZ:input prefix="S_" field="MATCH_NUM" id="S_MATCH_NUM" defaultValue="" formTitle="匹配次数" maxlength="" />
								</td>
								<td class="bz-search-title">匹配状态</td>
								<td>
									<BZ:select prefix="S_" field="MATCH_STATE" id="S_MATCH_STATE" width="148px" formTitle="匹配状态" defaultValue="0">
										<BZ:option value="0">待匹配</BZ:option>
										<BZ:option value="1">已匹配</BZ:option>
										<BZ:option value="9">全部</BZ:option>
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
					<input type="button" value="匹&nbsp;&nbsp;配" class="btn btn-sm btn-primary" onclick="_match()"/>
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
								<th style="width: 6%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REGISTER_DATE">收文日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="COUNTRY_CN">国家</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="GOVERN_DATE">批准书日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="EXPIRE_DATE">到期日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="MATCH_RECEIVEDATE">接收日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_TYPE">文件类型</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="ADOPT_REQUEST_CN">收养要求</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="UNDERAGE_NUM">子女数量</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="MATCH_NUM">匹配次数</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="MATCH_STATE">匹配状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="MATCH_STATE" defaultValue="" onlyValue="true"/>" class="ace">
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
								<td><BZ:data field="GOVERN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="EXPIRE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="MATCH_RECEIVEDATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
								<td><BZ:data field="ADOPT_REQUEST_CN" defaultValue=""/></td>
								<td><BZ:data field="UNDERAGE_NUM" defaultValue=""/></td>
								<td><BZ:data field="MATCH_NUM" defaultValue=""/></td>
								<td><BZ:data field="MATCH_STATE" defaultValue="" checkValue="0=待匹配;1=已匹配;"/></td>
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