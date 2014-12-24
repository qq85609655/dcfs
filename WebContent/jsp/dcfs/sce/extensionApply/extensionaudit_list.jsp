<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: extensionaudit_list.jsp
 * @Description: 交文延期审核列表
 * @author yangrt
 * @date 2014-9-28
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
		<title>交文延期审核列表</title>
		<BZ:webScript list="true" isAjax="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/extensionapply/ExtensionAuditList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_AUDIT_STATE").value = "";
			document.getElementById("S_REQ_SUBMIT_DATE_START").value = "";
			document.getElementById("S_REQ_SUBMIT_DATE_END").value = "";
			document.getElementById("S_AUDIT_DATE_START").value = "";
			document.getElementById("S_AUDIT_DATE_END").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//审核页面跳转
		function _audit(){
			var num = 0;
			var def_id = "";
			var state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					state = arrays[i].getAttribute("AUDIT_STATE");
					if(state == "0"){
						def_id = arrays[i].value;
						num += 1;
					}else{
						page.alert('请选择一条申请状态为待审核的数据！');
						return;
					}
					
				}
			}
			if(num != "1"){
				page.alert('请选择一条申请状态为待审核的数据！');
				return;
			}else{
				document.srcForm.action=path+"sce/extensionapply/ExtensionAuditAdd.action?DEF_ID=" + def_id;
				document.srcForm.submit();
			}
		}
		
		//查看页面跳转
		function _show(){
			var num = 0;
			var def_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					def_id = arrays[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条数据！');
				return;
			}else{
				document.srcForm.action= path +"sce/extensionapply/ExtensionApplyShow.action?type=audit&DEF_ID=" + def_id;
				document.srcForm.submit();
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

	</script>
	<BZ:body property="data" codeNames="GJSY;ETXB;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="sce/extensionapply/ExtensionAuditList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
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
								<td class="bz-search-title" style="width: 10%">
									<span title="国家">国家</span>
								</td>
								<td style="width: 15%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="88%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 12%">
									<span title="收养组织">收养组织</span>
								</td>
								<td style="width: 15%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title" style="width: 12%">申请日期</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">文件递交日期</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">儿童姓名</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="88%" >
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">申请状态</td>
								<td>
									<BZ:select prefix="S_" field="AUDIT_STATE" id="S_AUDIT_STATE" formTitle="" defaultValue="" width="88%" >
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待审核</BZ:option>
										<BZ:option value="1">通过</BZ:option>
										<BZ:option value="2">不通过</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">延时递交日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="REQ_SUBMIT_DATE_START" id="S_REQ_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REQ_SUBMIT_DATE_END" id="S_REQ_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">审核日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="AUDIT_DATE_START" id="S_AUDIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_AUDIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="AUDIT_DATE_END" id="S_AUDIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_AUDIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
								
								<td style="text-align: center;" colspan="2">
									<div class="bz-search-button">
										<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
										<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
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
									<div class="sorting_disabled">选择</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADOPT_ORG_NAME_CN">收养组织</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REQ_DATE">申请日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SUBMIT_DATE">文件递交期限</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REQ_SUBMIT_DATE">延时递交限期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AUDIT_DATE">审核日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AUDIT_STATE">申请状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="DEF_ID" onlyValue="true"/>" AUDIT_STATE="<BZ:data field="AUDIT_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REQ_SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_STATE" defaultValue="" onlyValue="true" checkValue="0=待审核;1=通过;2=不通过;"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="交文延期申请信息" 
							exportCode="COUNTRY_CODE=CODE,GJSY;SEX=CODE,ETXB;BIRTHDAY=DATE;REQ_DATE=DATE;SUBMIT_DATE=DATE;REQ_SUBMIT_DATE=DATE;AUDIT_DATE=DATE;AUDIT_STATE=FLAG,0:待审核&1:通过&2:不通过;"
							exportField="COUNTRY_CODE=国家,15,20;ADOPT_ORG_NAME_CN=收养组织,15;MALE_NAME=男收养人,15;FEMALE_NAME=女收养人,15;NAME=儿童姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;REQ_DATE=申请日期,15;SUBMIT_DATE=文件递交日期,15;REQ_SUBMIT_DATE=延时递交日期,15;AUDIT_DATE=审核日期,15;AUDIT_STATE=申请状态,15;"/></td>
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