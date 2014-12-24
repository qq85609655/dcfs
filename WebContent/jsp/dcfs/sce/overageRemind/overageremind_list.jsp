<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: overageremind_list.jsp
	 * @Description:  儿童超龄提醒列表
	 * @author panfeng   
	 * @date 2014-9-16  下午2:39:31 
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
		<title>儿童超龄提醒列表</title>
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
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','180px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/overageRemind/overageRemindList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_NAME_CN").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_CA_STATUS").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
		}
		//查看儿童信息
		function _showDetail(){
			var num = 0;
			var CIids = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					 CIids =arrays[i].value.split("#")[0];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要查看的材料！");
				return;
			}else{
				$.layer({
					type : 2,
					title : "儿童材料查看",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					//page : {dom : '#planList'},
					iframe: {src: '<BZ:url/>/sce/overageRemind/showChildInfo.action?CIids='+CIids},
					area: ['1050px','550px'],
					offset: ['0px' , '50px']
				});
			}
		}

	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;PROVINCE;CHILD_TYPE">
		<BZ:form name="srcForm" method="post" action="sce/overageRemind/overageRemindList.action">
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
							    <td class="bz-search-title" style="width: 10%">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份</td>
								<td style="width: 16%">
								   	<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="省份" defaultValue="" width="100%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								 </td>
								
								<td class="bz-search-title" style="width: 12%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 65%"/>
								</td>
								
	                            <td class="bz-search-title" style="width: 10%">出生日期</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title">儿童类型</td>
								<td>
                                   <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" formTitle="" codeName="CHILD_TYPE" defaultValue="" width="100%" >
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">正常儿童</BZ:option>
										<BZ:option value="1">特需儿童</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
								<td >
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="70%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>

								<td class="bz-search-title">病残诊断</td>
								<td>
									<BZ:input prefix="S_" field="DISEASE_CN" id="S_DISEASE_CN" defaultValue="" formTitle="病残诊断" maxlength="2000" style="width: 75%"/>
								</td>
							</tr>
							<tr>
									
								<td class="bz-search-title">病残种类</td>
								<td >
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="性别" defaultValue="" width="100%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">审核状态</td>
								<td>
									<BZ:select prefix="S_" field="AUD_STATE" id="S_AUD_STATE" formTitle="" defaultValue="" width="70%">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未提交</BZ:option>
										<BZ:option value="1">省待审</BZ:option>
										<BZ:option value="2">省审核中</BZ:option>
										<BZ:option value="3">省不通过</BZ:option>
										<BZ:option value="4">省通过</BZ:option>
										<BZ:option value="5">已寄送</BZ:option>
										<BZ:option value="6">已接收</BZ:option>
										<BZ:option value="7">中心审核中</BZ:option>
										<BZ:option value="8">中心不通过</BZ:option>
										<BZ:option value="9">中心通过</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">发布状态</td>
								<td>
									<BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" formTitle="" defaultValue="" width="75%">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待发布</BZ:option>
										<BZ:option value="1">计划中</BZ:option>
										<BZ:option value="2">已发布</BZ:option>
										<BZ:option value="3">已锁定</BZ:option>
										<BZ:option value="4">已申请</BZ:option>
									</BZ:select>
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
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_showDetail()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									&nbsp;
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting" id="DISEASE_CN">病残诊断</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">超龄日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="IS_OVERAGE">超龄标识</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id=AUD_STATE>审核状态</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PUB_STATE">发布状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<input name="xuanze" type="radio" value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="TWINS_IDS" defaultValue="" onlyValue="true"/>" class="ace">
									<%
									}else{
									%>
									<input name="xuanze" type="radio" value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>" class="ace">
									<%} %>
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td>
									<%
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME" defaultValue="" onlyValue="true"/>（同胞）
									<%}else{%><BZ:data field="NAME" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" checkValue="0=正常儿童;1=特需儿童;" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td><BZ:data field="DISEASE_CN" defaultValue="" /></td>
								<td class="center"><BZ:data field="ADD_MONTHS(BIRTHDAY,12*14)" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="IS_OVERAGE" defaultValue="" checkValue="1=超龄提醒;2=已超龄;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AUD_STATE" defaultValue="" checkValue="0=未提交;1=省待审;2=省审核中;3=省不通过;4=省通过;5=已寄送;6=已接收;7=中心审核中;8=中心不通过;9=中心通过;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PUB_STATE" defaultValue="" checkValue="0=待发布;1=计划中;2=已发布;3=已锁定;4=已申请;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" /></td>
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