<%
/**   
 * @Title: DAB_PP_feedback_receive_list.jsp
 * @Description: 档案部安置后报告反馈接收列表
 * @author xugy
 * @date 2014-10-11下午12:58:34
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
		<title>安置后报告反馈接收列表</title>
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
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"feedback/DABPPFeedbackReceiveList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_ARCHIVE_NO").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_CHILD_NAME_EN").value = "";
			document.getElementById("S_NUM").value = "";
			document.getElementById("S_REPORT_DATE_START").value = "";
			document.getElementById("S_REPORT_DATE_END").value = "";
			document.getElementById("S_RECEIVE_STATE").value = "";
			document.getElementById("S_RECEIVE_USERNAME").value = "";
			document.getElementById("S_RECEIVE_DATE_START").value = "";
			document.getElementById("S_RECEIVE_DATE_END").value = "";
			document.getElementById("S_REPORT_STATE").value = "";
			
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
		//送翻
		function _sendTranslation(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var REPORT_STATE = id.split(",")[1];
					if(REPORT_STATE != "1"){
						page.alert('请选择待接收的数据');
						return;
					}
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('请选择要送翻的数据 ');
				return;
			}else{
				if(confirm('确认要送翻选择的报告吗?')){
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"feedback/DABSendTranslation.action";
					document.srcForm.submit();
				}else{
					return;
				}
			}
		}
		//送审
		function _sendAudit(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var REPORT_STATE = id.split(",")[1];
					if(REPORT_STATE != "1"){
						page.alert('请选择待接收的数据');
						return;
					}
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('请选择要送审的数据 ');
				return;
			}else{
				if(confirm('确认要送审选择的报告吗?')){
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"feedback/DABSendAudit.action";
					document.srcForm.submit();
				}else{
					return;
				}
			}
		}
		//
		function _return(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var REPORT_STATE = id.split(",")[1];
					if(REPORT_STATE != "1"){
						page.alert('请选择待接收的数据');
						return;
					}
					ids= id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"feedback/toDABPPFeedbackReturn.action";
				document.srcForm.submit();
			}
		}
		//打印首页
		function _printHomePage(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				window.open(path+"feedback/PPFeedbackHomePage.action?FB_REC_ID="+ids);
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="feedback/DABPPFeedbackReceiveList.action">
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
								<td class="bz-search-title" style="width: 8%;">档案号</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="档案号" maxlength=""/>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">收文编号</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">签批号</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="签批号" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								<td class="bz-search-title">男方</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">女方</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="" />
								</td>
								
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
							
							</tr>
							<tr>
								<td class="bz-search-title">儿童姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								
								<td class="bz-search-title">姓名拼音</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								
								<td class="bz-search-title">入籍姓名</td>
								<td>
									<BZ:input prefix="S_" field="CHILD_NAME_EN" id="S_CHILD_NAME_EN" defaultValue="" formTitle="入籍姓名" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">次第数</td>
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="次第数" maxlength="" />
								</td>
								
								<td class="bz-search-title">上报日期</td>
								<td>
									<BZ:input prefix="S_" field="REPORT_DATE_START" id="S_REPORT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REPORT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始上报日期" />~
									<BZ:input prefix="S_" field="REPORT_DATE_END" id="S_REPORT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REPORT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止上报日期" />
								</td>
								
								<td class="bz-search-title">接收状态</td>
								<td>
									<BZ:select prefix="S_" field="RECEIVE_STATE" id="S_RECEIVE_STATE" width="148px" formTitle="接收状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待接受</BZ:option>
										<BZ:option value="1">已接受</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">接收人</td>
								<td>
									<BZ:input prefix="S_" field="RECEIVE_USERNAME" id="S_RECEIVE_USERNAME" defaultValue="" formTitle="接收人" maxlength="" />
								</td>
								
								<td class="bz-search-title">接收日期</td>
								<td>
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始接收日期" />~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止接收日期" />
								</td>
								
								<td class="bz-search-title">报告状态</td>
								<td>
									<BZ:select prefix="S_" field="REPORT_STATE" id="S_REPORT_STATE" width="148px" formTitle="报告状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">待接收</BZ:option>
										<BZ:option value="2">已接收</BZ:option>
										<BZ:option value="3">待翻译</BZ:option>
										<BZ:option value="4">翻译中</BZ:option>
										<BZ:option value="5">已翻译</BZ:option>
										<BZ:option value="6">待审核</BZ:option>
										<BZ:option value="7">审核中</BZ:option>
										<BZ:option value="8">已审核</BZ:option>
										<BZ:option value="9">退回</BZ:option>
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
					<input type="button" value="送&nbsp;&nbsp;翻" class="btn btn-sm btn-primary" onclick="_sendTranslation()"/>&nbsp;
					<input type="button" value="送&nbsp;&nbsp;审" class="btn btn-sm btn-primary" onclick="_sendAudit()"/>&nbsp;
					<input type="button" value="扫描接收" class="btn btn-sm btn-primary" onclick="_scanReceive()"/>&nbsp;
					<input type="button" value="打印首页" class="btn btn-sm btn-primary" onclick="_printHomePage()"/>&nbsp;
					<input type="button" value="退&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_return()"/>&nbsp;
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
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ARCHIVE_NO">档案号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SIGN_NO">签批号</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="NUM">次第数</div>
								</th>
								<th style="width: 4%;">
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
								<th style="width: 3%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME_PINYIN">姓名拼音</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="CHILD_NAME_EN">入籍姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REPORT_DATE">上报日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="RECEIVE_USERNAME">接收人</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RECEIVE_DATE">接收日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="RECEIVE_STATE">接收状态</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="REPORT_STATE">报告状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="FB_REC_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="REPORT_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue="" /></td>
								<td><BZ:data field="FILE_NO" defaultValue="" /></td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="NUM" defaultValue="" /></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME" defaultValue="" /></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" /></td>
								<td><BZ:data field="CHILD_NAME_EN" defaultValue="" /></td>
								<td><BZ:data field="REPORT_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="RECEIVE_USERNAME" defaultValue="" /></td>
								<td><BZ:data field="RECEIVE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="RECEIVE_STATE" defaultValue="" checkValue="0=待接受;1=已接收;2=接收退回;"/></td>
								<td><BZ:data field="REPORT_STATE" defaultValue="" checkValue="0=待上报;1=待接收;2=已接收;3=待翻译;4=翻译中;5=已翻译;6=待审核;7=审核中;8=已审核;9=退回;"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="安置后反馈报告数据" exportCode="PROVINCE_ID=CODE,PROVINCE;RECEIVE_STATE=FLAG,0:待接受&1:已接收&2:接收退回;REPORT_STATE=FLAG,0:待上报&1:待接收&2:已接收&3:待翻译&4:翻译中&5:已翻译&6:待审核&7:审核中&8:已审核&9:退回;RECEIVE_DATE=DATE;REPORT_DATE=DATE,yyyy/MM/dd" exportField="ARCHIVE_NO=档案号,15,20;FILE_NO=收文编号,15;SIGN_NO=签批号,15;COUNTRY_CN=国家,15;NAME_CN=收养组织,20;MALE_NAME=男方,15;FEMALE_NAME=女方,15;PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,20;NAME=儿童姓名,15;NAME_PINYIN=姓名拼音,15;CHILD_NAME_EN=入籍姓名,15;NUM=次第数,10;REPORT_DATE=上报日期,15;RECEIVE_USERNAME=接收人,15;RECEIVE_DATE=接收日期,15;RECEIVE_STATE=接收状态,15;REPORT_STATE=报告状态,15;"/></td>
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