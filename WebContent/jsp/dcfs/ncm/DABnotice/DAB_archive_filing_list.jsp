<%
/**   
 * @Title: DAB_archive_filing_list.jsp
 * @Description: 档案部归档立卷列表
 * @author xugy
 * @date 2014-11-2下午5:32:21
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
		<title>档案部归档立卷列表</title>
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
			_scroll(1700,1700);
			dyniframesize(['mainFrame']);
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
				area: ['1050px','190px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"notice/DABArchiveFilingList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_ARCHIVE_NO_START").value = "";
			document.getElementById("S_ARCHIVE_NO_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_ARCHIVE_USERNAME").value = "";
			document.getElementById("S_ARCHIVE_DATE_START").value = "";
			document.getElementById("S_ARCHIVE_DATE_END").value = "";
			document.getElementById("S_ARCHIVE_STATE").value = "";
			document.getElementById("S_FILING_REMARKS").value = "";
			document.getElementById("S_ARCHIVE_VALID").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		
		//归档
		function _filing(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ARCHIVE_VALID = id.split(",")[2];
					if(ARCHIVE_VALID == "0"){
						alert("该档案已无效");
						return;
					}
					var ARCHIVE_STATE = id.split(",")[1];
					if(ARCHIVE_STATE != "0"){
						alert("请选择未归档的数据");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/toDABArchiveFiling.action";
				document.srcForm.submit();
			}
		}
		//解档
		function _release(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ARCHIVE_STATE = id.split(",")[1];
					if(ARCHIVE_STATE != "2"){
						alert("请选择待解档的数据");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/toDABReleaseFiling.action";
				document.srcForm.submit();
			}
		}
		//目录
		function _catalog(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ARCHIVE_VALID = id.split(",")[2];
					if(ARCHIVE_VALID == "0"){
						alert("该档案已无效");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/DABCatalog.action";
				document.srcForm.submit();
			}
		}
		//批量打印目录（一）
		function _printAll(){
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
			
			if(num < 1){
				page.alert('请选择打印的数据 ');
				return;
			}else{
				ids = encodeURIComponent(ids);
				$.layer({
					type : 2,
					title : false,
					shade : [0.5 , '#D9D9D9' , true],
					border :[0 , 0.3 , '#000', true],
					//page : {dom : '#planList'},
					time:10,
					iframe: {src: "<BZ:url/>/notice/getDABCatalogInfo.action?ids="+ids},
					area: ['300px','100px'],
					closeBtn:[false]
				});
			}
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="notice/DABArchiveFilingList.action">
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
								<td class="bz-search-title">档案号</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_NO_START" id="S_ARCHIVE_NO_START" defaultValue="" restriction="plusInt" formTitle="起始档案号" maxlength="" />~
									<BZ:input prefix="S_" field="ARCHIVE_NO_END" id="S_ARCHIVE_NO_END" defaultValue="" restriction="plusInt" formTitle="结束档案号" maxlength="" />
								</td>
								
								<td class="bz-search-title">收文编号</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title">国家</td>
								<td>
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
								
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
							
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">儿童姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								
								<td class="bz-search-title">归档人</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_USERNAME" id="S_ARCHIVE_USERNAME" defaultValue="" formTitle="归档人" maxlength="" />
								</td>
								
								<td class="bz-search-title">归档日期</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_DATE_START" id="S_ARCHIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ARCHIVE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始归档日期" />~
									<BZ:input prefix="S_" field="ARCHIVE_DATE_END" id="S_ARCHIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ARCHIVE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止归档日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">归档状态</td>
								<td>
									<BZ:select prefix="S_" field="ARCHIVE_STATE" id="S_ARCHIVE_STATE" width="148px" formTitle="归档状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未归档</BZ:option>
										<BZ:option value="1">已归档</BZ:option>
										<BZ:option value="2">待解档</BZ:option>
										<BZ:option value="3">已解档</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">备注</td>
								<td>
									<BZ:input prefix="S_" field="FILING_REMARKS" id="S_FILING_REMARKS" defaultValue="" formTitle="备注" maxlength="" />
								</td>
								
								<td class="bz-search-title">是否有效</td>
								<td>
									<BZ:select prefix="S_" field="ARCHIVE_VALID" id="S_ARCHIVE_VALID" width="148px" formTitle="是否有效" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
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
					<input type="button" value="归&nbsp;&nbsp;档" class="btn btn-sm btn-primary" onclick="_filing()"/>&nbsp;
					<!-- <input type="button" value="解&nbsp;&nbsp;档" class="btn btn-sm btn-primary" onclick="_release()"/>&nbsp; -->
					<input type="button" value="目&nbsp;&nbsp;录" class="btn btn-sm btn-primary" onclick="_catalog()"/>&nbsp;
					<input type="button" value="批量打印目录（一）" class="btn btn-sm btn-primary" onclick="_printAll()"/>&nbsp;
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
									<div class="sorting" id="ARCHIVE_NO">档案号</div>
								</th>
								
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								
								<th style="width: 4%;">
									<div class="sorting" id="ARCHIVE_USERNAME">归档人</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARCHIVE_DATE">归档日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_STATE">归档状态</div>
								</th>
								
								<th style="width: 18%;">
									<div class="sorting" id="FILING_REMARKS">备注</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_VALID">是否有效</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="ARCHIVE_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ARCHIVE_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue=""/></td>
								
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								
								<td><BZ:data field="NAME" defaultValue=""/></td>
								
								<td><BZ:data field="ARCHIVE_USERNAME" defaultValue=""/></td>
								<td><BZ:data field="ARCHIVE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="ARCHIVE_STATE" defaultValue="" checkValue="0=未归档;1=已归档;2=待解档;3=已解档;"/></td>
								<td><BZ:data field="FILING_REMARKS" defaultValue=""/></td>
								<td><BZ:data field="ARCHIVE_VALID" defaultValue="" checkValue="0=否;1=是;"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="档案数据" exportCode="COUNTRY_CODE=CODE,GJSY;ARCHIVE_STATE=FLAG,0:未归档&1:已归档&2:待解档&3:已解档;ARCHIVE_VALID=FLAG,0:否&1:是;ARCHIVE_DATE=DATE,yyyy/MM/dd" exportField="ARCHIVE_NO=档案号,15,20;FILE_NO=收文编号,15;COUNTRY_CODE=国家,15;NAME_CN=收养组织,15;MALE_NAME=男收养人,15;FEMALE_NAME=女收养人,15;NAME=儿童姓名,15;ARCHIVE_USERNAME=归档人,15;ARCHIVE_DATE=归档日期,15;ARCHIVE_STATE=归档状态,15;FILING_REMARKS=备注,15;ARCHIVE_VALID=是否有效,15;"/></td>
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