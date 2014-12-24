<%
/**   
 * @Title: govementMessage.jsp
 * @Description: 政府部门信息
 * @author lihf 
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
	String COUNTRY_CODE = (String)request.getAttribute("COUNTRY_CODE");
%>
<BZ:html>
	<BZ:head>
		<title>政府部门列表</title>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['rightFrame','mainFrame']);
			var num = 0;
			var ids = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num==1){
				showGovement();
			}
		});
		
		function showGovement(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			var country_code = document.getElementById("COUNTRY_CODE").value;
			if(num != 1){
				downFrame.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findGovementAndContact.action?COUNTRY_CODE="+country_code;
			}else{
				downFrame.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findGovementAndContact.action?GOV_ID="+ids+"&COUNTRY_CODE="+country_code;
			}
		}
		
		function add(){
			var country_code = document.getElementById("COUNTRY_CODE").value;
			downFrame.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findGovementAndContact.action?COUNTRY_CODE="+country_code;
		}

		function del(){
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[0].value;
					var country_code = document.getElementById("COUNTRY_CODE").value;
					document.location = "<%=request.getContextPath() %>/mkr/MAINCountry/delGovement.action?ID="+id+"&COUNTRY_CODE="+country_code+"&m=ok";
				}
			}
		}
	</script>
<BZ:body codeNames="ZFBMXZ;ZFZN;">
<BZ:form name="srcForm" id="srcForm"  method="post" action="mkr/MAINCountry/findGovement.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<table width="100%" height="100%">
	<tr height="50%">
		<td width="100%" valign="top" height="50%">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" id="COUNTRY_CODE" name="COUNTRY_CODE" value="<%=COUNTRY_CODE %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="新&nbsp;&nbsp;增" class="btn btn-sm btn-primary" onclick="add()"/>&nbsp;
					<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="del()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_EN">
										名称(EN)
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">
										名称(CN)
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NATURE">
										性质
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="GOVER_FUNCTIONS">
										职能
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="HEAD_NAME">
										负责人姓名
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="HEAD_PHONE">
										负责人电话
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="HEAD_EMAIL">
										负责人邮箱
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="WEBSITE">
										网址
									</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ADDRESS">
										地址
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze"  onclick="showGovement()" type="radio" value="<BZ:data field="GOV_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="NAME_EN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NATURE" defaultValue="" codeName="ZFBMXZ" onlyValue="true"/></td>
								<td><BZ:data field="GOVER_FUNCTIONS" codeName="ZFZN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="HEAD_NAME" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="HEAD_PHONE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="HEAD_EMAIL" defaultValue=""  onlyValue="true"/></td>
								<td><BZ:data field="WEBSITE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ADDRESS" defaultValue=""  onlyValue="true"/></td>
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
							<td>	
								<BZ:page form="srcForm" property="List"/>
							</td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</td>
	</tr>
	<tr height="50%" >
		<td width="100%" valign="top" height="50%">
			<iframe align="top"  width="100%" height="700px" src="" id="downFrame" name="downFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
		</td>
	</tr>
</table>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>