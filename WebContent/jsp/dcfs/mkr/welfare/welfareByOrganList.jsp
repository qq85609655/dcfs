<%
/**   
 * @Title: recordStateOrganList.jsp
 * @Description:机构备案列表
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 // 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	String ID = (String)request.getAttribute("ID");  //省份ID
%>

<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%><BZ:html>
	<BZ:head>
		<title>机构备案列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['welfare','mainFrame']);
		});
		
		//备案审核
		function record_confirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
			   document.srcForm.action=path+"mkr/organSupp/organRecordConfirm.action?ID="+ids;
			   document.srcForm.submit();
			}
		}
		//跳转到修改页面
		function _modif(){
			var id="";
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('请选择一条数据 ');
				return;
			}else{
				document.srcForm.action=path+"mkr/organSupp/provinceListMessage.action?ID="+id+"&pro_code=<%=ID%>&type=modif";
			    document.srcForm.submit();
			}
			    document.srcForm.action=path+"mkr/organSupp/findWelfareByOrgan.action";
		}
		//跳转到查看页面
		function _detail(){
			var id="";
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('请选择一条数据 ');
				return;
			}else{
				document.srcForm.action=path+"mkr/organSupp/toWelfareModif.action?ID="+id+"&pro_code=<%=ID%>&type=detail";
			    document.srcForm.submit();
			}
			    document.srcForm.action=path+"mkr/organSupp/findWelfareByOrgan.action";
		}
		//删除福利机构信息
		function _delete(){
			var num = 0;
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				if(confirm('确定要删除吗？')){
					document.srcForm.action=path+"mkr/organSupp/toWelfareDel.action?INSTER_ID="+id+"&pro_code=<%=ID%>";
				    document.srcForm.submit();
				}
			}
		}
		function a(){
			 window.location.href=path+"jsp/dcfs/mkr/welfare/provinceAndWelfare.jsp";
		}
	</script>
	<BZ:body codeNames="PROVINCE;">
		<BZ:form name="srcForm"  method="post" action="mkr/organSupp/findWelfareByOrgan.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="ID"  value='<%=ID %>'/>
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_modif()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<!-- <input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp; -->
					<input type="button" value="省份福利机构二级联动" class="btn btn-sm btn-primary" onclick="a()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="CNAME">机构名称</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PRINCIPAL">法人</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="DEPT_ADDRESS_CN">地址</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="DEPT_TEL">电话</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="DEPT_FAX">传真</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="STATE">状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<BZ:for property="dataList">
								<tr class="emptyData">
									<td class="center">
										<input name="xuanze" type="radio" value="<BZ:data field="ID" defaultValue="" onlyValue="true"/>" class="ace">
									</td>
									<td class="center">
										<BZ:i/>
									</td>
									<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
									<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="PRINCIPAL" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="DEPT_ADDRESS_CN" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="DEPT_TEL" defaultValue=""  onlyValue="true"/></td>
									<td><BZ:data field="DEPT_FAX" defaultValue=""  onlyValue="true"/></td>
									<td><BZ:data field="STATE" defaultValue="" checkValue="0=撤销;1=有效;9=暂停;"  onlyValue="true"/></td>
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
								<BZ:page form="srcForm" property="dataList"/>
							</td>
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