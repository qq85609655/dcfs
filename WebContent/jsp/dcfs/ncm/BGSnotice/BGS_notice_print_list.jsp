<%
/**   
 * @Title: BGS_notice_print_list.jsp
 * @Description: 办公室通知书打印列表
 * @author xugy
 * @date 2014-9-15下午4:59:21
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
		<title>办公室通知书打印列表</title>
		<BZ:webScript list="true" isAjax="true" edit="true"/>
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
			_scroll(2000,2000);
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
				area: ['1050px','290px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"notice/BGSNoticePrintList.action?page=1";
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
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SIGN_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SIGN_SUBMIT_DATE_END").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_NOTICE_SIGN_DATE_START").value = "";
			document.getElementById("S_NOTICE_SIGN_DATE_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_NOTICE_STATE").value = "0";
			
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
		//修改打印
		function _modPrint(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids = id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/BGSNoticePrintMod.action";
				document.srcForm.submit();
			}
		}
		//打印
		function _print(type){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			if(num == 1){
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/toPrintOne.action?type="+type;
				document.srcForm.submit();
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/toPrintAll.action?type="+type;
				document.srcForm.submit();
			}
		}
		
		//寄发
		function _noticeSend(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var NOTICE_STATE = id.split(",")[1];
					if(NOTICE_STATE != "0"){
						page.alert('请选择未寄发的数据');
						return;
					}
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('请选择要寄发的数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				$.layer({
					type : 1,
					title : "通知书寄发",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					page : {dom : '#noticeDIV'},
					area: ['250px','150px'],
					offset: ['40px' , '0px'],
					closeBtn: [0, true]
				});
				
				/* document.srcForm.action=path+"notice/BGSNoticeSend.action";
				document.srcForm.submit(); */
			}
		}
		
		function _ok(){
			if (!runFormVerify(document.noticeForm, false)) {
				return;
			}
			var NOTICE_DATE = document.getElementById("MI_NOTICE_DATE").value;
			document.srcForm.action=path+"notice/BGSNoticeSend.action?NOTICE_DATE="+NOTICE_DATE;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;CHILD_TYPE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="notice/BGSNoticePrintList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
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
								
								<td class="bz-search-title" style="width: 9%;">收文日期</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">国家</td>
								<td style="width: 18%;">
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
								
								<td class="bz-search-title">儿童类型</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" width="148px" formTitle="儿童类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">正常</BZ:option>
										<BZ:option value="2">特需</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">省份</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="省份" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
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
								
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								
								<td class="bz-search-title">报批日期</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_SUBMIT_DATE_START" id="S_SIGN_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始报批日期" />~
									<BZ:input prefix="S_" field="SIGN_SUBMIT_DATE_END" id="S_SIGN_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止报批日期" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">签批日期</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始签批日期" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止签批日期" />
								</td>
								<td class="bz-search-title">落款日期</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_SIGN_DATE_START" id="S_NOTICE_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始落款日期" />~
									<BZ:input prefix="S_" field="NOTICE_SIGN_DATE_END" id="S_NOTICE_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止落款日期" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">寄发日期</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始寄发日期" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止寄发日期" />
								</td>
								
								<td class="bz-search-title">寄发状态</td>
								<td>
									<BZ:select prefix="S_" field="NOTICE_STATE" id="S_NOTICE_STATE" width="148px" formTitle="寄发状态" defaultValue="0">
										<BZ:option value="0">未寄发</BZ:option>
										<BZ:option value="1">已寄发</BZ:option>
										<BZ:option value="9">全部数据</BZ:option>
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
					<input type="button" value="修改打印" class="btn btn-sm btn-primary" onclick="_modPrint()"/>&nbsp;
					<input type="button" value="来华收养通知书打印" class="btn btn-sm btn-primary" onclick="_print('0')"/>&nbsp;
					<input type="button" value="送养通知打印" class="btn btn-sm btn-primary" onclick="_print('1')"/>&nbsp;
					<input type="button" value="寄&nbsp;&nbsp;发" class="btn btn-sm btn-primary" onclick="_noticeSend()"/>&nbsp;
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
								<th style="width: 5%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">收文日期</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="COUNTRY_CN">国家</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="MALE_NAME">男方</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FEMALE_NAME">女方</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="FILE_TYPE">文件类型</div>
								</th>
								
								<th style="width: 4%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_SUBMIT_DATE">报批日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_DATE">签批日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTICE_SIGN_DATE">落款日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NOTICE_PRINT_NUM">打印次数</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTICE_DATE">寄发日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NOTICE_STATE">寄发状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="NOTICE_STATE" defaultValue="" onlyValue="true"/>" class="ace">
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
								
								<td><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								
								<td><BZ:data field="SIGN_SUBMIT_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="NOTICE_SIGN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="NOTICE_PRINT_NUM" defaultValue=""/></td>
								<td><BZ:data field="NOTICE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="NOTICE_STATE" defaultValue="" checkValue="0=未寄发;1=已寄发;"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="办公室打印寄发数据" exportCode="FILE_TYPE=CODE,WJLX;PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;CHILD_TYPE=FLAG,1:正常儿童&2:特需儿童;NOTICE_STATE=FLAG,0:未寄发&1:已寄发;REGISTER_DATE=DATE;BIRTHDAY=DATE;SIGN_SUBMIT_DATE=DATE;SIGN_DATE=DATE;NOTICE_SIGN_DATE=DATE;NOTICE_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=收文日期,15;COUNTRY_CN=国家,15;NAME_CN=收养组织,20;MALE_NAME=男方,15;FEMALE_NAME=女方,15;FILE_TYPE=文件类型,10;CHILD_TYPE=儿童类型,10;PROVINCE_ID=省份,10;WELFARE_NAME_CN=福利院,20;NAME=姓名,10;SEX=性别,10;BIRTHDAY=出生日期,15;SIGN_SUBMIT_DATE=报批日期,15;SIGN_DATE=签批日期,15;NOTICE_SIGN_DATE=落款日期,15;NOTICE_PRINT_NUM=打印次数,10;NOTICE_DATE=寄发日期,15;NOTICE_STATE=寄发状态,10;"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
		<div id="noticeDIV" style="display: none;width: 100%;">
			<BZ:form name="noticeForm" method="post">
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="40%"><font color="red">*</font>寄发日期</td>
									<td class="bz-edit-data-value" width="60%">
										<BZ:input prefix="MI_" field="NOTICE_DATE" id="MI_NOTICE_DATE" defaultValue="" type="date" notnull="寄发日期不能为空"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="按钮区">
						<input type="button" value="确&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_ok()" />
					</div>
				</div>
			</BZ:form>
		</div>
	</BZ:body>
</BZ:html>