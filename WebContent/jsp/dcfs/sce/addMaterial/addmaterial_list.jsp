<%
/**   
 * @Title: addmaterial_list.jsp
 * @Description: 补充预批资料列表
 * @author panfeng
 * @date 2014-9-14下午3:43:13 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
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
	<BZ:head language="EN">
		<title>补充预批资料列表</title>
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
				title : "查询条件(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/addMaterial/findMaterialList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_ADD_TYPE").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
		}
		
		//查看补充通知详细信息操作
		function _detail(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split("#")[0];
					num ++;
				}
			}
			if(num != "1"){
				alert("Please select one data!");
				return;
			}else{
				url = path+"sce/addMaterial/showMaterialDetail.action?showuuid="+showuuid;
				_open(url, "预批补充通知信息", 1000, 520);
			}
		}
		
		//补充操作
		function _supplement(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "0" || state == "1"){
						showuuid = arrays[i].value.split("#")[0];
						num += 1;
					}else{
						alert("You may only select information 'to be supplemented' or 'in process of supplementation'!");
						return;
					}
				}
			}
			if(num != "1"){
				alert("Please select a data for supplementing!");
				return;
			}else{
				document.srcForm.action = path+"sce/addMaterial/addMaterialShow.action?showuuid=" + showuuid;
				document.srcForm.submit();
			}
		}
		
		//提交操作
		function _submit(){
			var num = 0;
			var subuuid = "";
			var ri_id = "";
			var add_type = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "1"){
						subuuid = arrays[i].value.split("#")[0];
						ri_id = arrays[i].value.split("#")[2];
						add_type = arrays[i].value.split("#")[3];
						num += 1;
					}else{
						alert("You may only submit information 'in process of supplementation'");
						return;
					}
				}
			}
			if(num != "1"){
				alert("Please select one information with status as 'in process of supplementing'!");
				return;
			}else{
				if (confirm("Are you sure you want to submit? You cannot continue to add new information to the pre-approval application after submitting.")){
					document.srcForm.action = path+"sce/addMaterial/materialSubmit.action?subuuid="+subuuid+"&ri_id="+ri_id+"&add_type="+add_type;
					document.srcForm.submit();
				}
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;">
		<BZ:form name="srcForm" method="post" action="sce/addMaterial/findMaterialList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">儿童姓名<br>Child name</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" isShowEN="true" formTitle="性别" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>	
								<td>
								&nbsp;
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">男收养人<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
								<td class="bz-search-title">省份<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" isShowEN="true" formTitle="省份" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">女收养人<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								<td class="bz-search-title">特别关注<br>Special focus</td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="特别关注" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">No</BZ:option>
										<BZ:option value="1">Yes</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">通知日期<br>Date of notification</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始补充通知日期" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止补充通知日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">来源<br>Source</td>
								<td>
									<BZ:select prefix="S_" field="ADD_TYPE" id="S_ADD_TYPE" formTitle="补充部门" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="1">Audit Department</BZ:option>
										<BZ:option value="2">Resettlement Department</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">补充状态<br>Supplement status</td>
								<td>
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" formTitle="补充状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be added</BZ:option>
										<BZ:option value="1">in process of adding</BZ:option>
										<BZ:option value="2">added</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">反馈日期<br>Date of feedback </td>
								<td>
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始反馈日期" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止反馈日期" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Check document supplement notice" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="Supplement" class="btn btn-sm btn-primary" onclick="_supplement()"/>&nbsp;
					<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份(Province)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NAME">姓名(Child name)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">性别(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期(D.O.B)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注(Special focus)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="ADD_TYPE">来源(Source)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NOTICE_DATE">通知日期(Date of notification)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEEDBACK_DATE">反馈日期(Date of feedback )</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="AA_STATUS">补充状态(Supplement status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="RA_ID" defaultValue="" onlyValue="true"/>#<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>#<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>#<BZ:data field="ADD_TYPE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true" onlyValue="true"/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/>(Siblings)
									<%}else{%><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=No;1=Yes;" onlyValue="true"/></td>
								<td><BZ:data field="ADD_TYPE" defaultValue="" checkValue="1=Audit Department;2=Resettlement Department;" onlyValue="true"/></td>
								<td><BZ:data field="NOTICE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="FEEDBACK_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=to be added;1=in process of adding;2=added;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN" /></td>
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