<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: 描述
 * @author xxx   
 * @date 2014-9-30 12:23:32
 * @version V1.0   
 */
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
		<title>查询列表</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
  //$(document).ready(function() {
  //			dyniframesize(['mainFrame']);
  //		});
 
 //显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"/mkr/regOrgManager/findList.action";
	 document.srcForm.submit();
  }
  
  function add(){
     document.srcForm.action=path+"/mkr/regOrgManager/add.action";
	 document.srcForm.submit();
  }

  function _update(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要查看的数据');
		return;
	}else{
	 document.srcForm.action=path+"/mkr/regOrgManager/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.submit();
	 }
  }
  
  function chakan(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要查看的数据');
		return;
	}else{
		 document.srcForm.action=path+"/mkr/regOrgManager/show.action?type=show&UUID="+showuuid;
		 document.srcForm.submit();
    }
  }

  function _delete(){
   var sfdj=0;
	var uuid="";
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
	   uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
	   sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('请选择要删除的数据');
	   return;
	  }else{
	  if(confirm('确认要删除选中信息吗?')){
		 document.getElementById("deleteuuid").value=uuid;
		 document.srcForm.action=path+"/mkr/regOrgManager/delete.action";
		 document.srcForm.submit();
	  }else{
	  return;
	  }
	}
  }
  //重置方法自由定义
  function _reset(){
    page.alert("重置方法未定义");
  }
  

  </script>
<BZ:body property="data"  codeNames="PROVINCE">
     <BZ:form name="srcForm" method="post" action="/mkr/regOrgManager/findList.action">
     <input type="hidden" name="deleteuuid" id="deleteuuid" value="" />
     <!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <div class="page-content">
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	 </BZ:frameDiv>
     <div class="wrapper">
	 <!-- 功能按钮操作区Start -->
	 <div class="table-row table-btns" style="text-align: left">
		<!-- input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/-->&nbsp;
		<input type="button" value="添&nbsp;&nbsp;加" class="btn btn-sm btn-primary" onclick="add()"/>&nbsp;
		<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="chakan()"/>&nbsp;
		<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_update()"/>&nbsp;
		<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_delete()"/>	
	</div>
	<div class="blue-hr"></div>
	<!-- 功能按钮操作区End -->
	<!-- 查询条件区Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						  <tr>
						  </tr>
						  <tr>
						  </tr>
						  <tr>
						  </tr>
						  <tr>
						  </tr>
						  <tr>
						  </tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		
		<!--查询结果列表区Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr class="emptyData">
						<th class="center" style="width:5%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:5%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="PROVINCE_ID">省份</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="NAME_CN">机关名称</div>
						</th>
						<!-- th style="width:10%;">
							<div class="sorting" id="CITY_ADDRESS_EN">登记地点_英文</div>
						</th-->
						<th style="width:10%;">
							<div class="sorting" id="CITY_ADDRESS_CN">登记地点</div>
						</th>
						<!-- th style="width:10%;">
							<div class="sorting" id="NAME_EN">英文名称</div>
						</th-->
						<th style="width:10%;">
							<div class="sorting" id="DEPT_ADDRESS_CN">地址</div>
						</th>
						<!-- th style="width:10%;">
							<div class="sorting" id="DEPT_ADDRESS_EN">地址_英文</div>
						</th-->
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_NAME">经办人_姓名</div>
						</th>
						<!-- th style="width:10%;">
							<div class="sorting" id="CONTACT_NAMEPY">经办人_姓名拼音</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_SEX">经办人_性别</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_CARD">经办人_身份证号</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_JOB">经办人_职务</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_TEL">经办人_联系电话</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_MAIL">经办人_邮箱</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="CONTACT_DESC">经办人_备注</div>
						</th-->
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List">
							<tr class="odd">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="RI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID"  codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<!-- td><BZ:data field="CITY_ADDRESS_EN"  defaultValue="" onlyValue="true"/></td-->
								<td><BZ:data field="CITY_ADDRESS_CN"  defaultValue="" onlyValue="true"/></td>
								<!-- td><BZ:data field="NAME_EN"  defaultValue="" onlyValue="true"/></td-->
								<td><BZ:data field="DEPT_ADDRESS_CN"  defaultValue="" onlyValue="true"/></td>
								<!-- td><BZ:data field="DEPT_ADDRESS_EN"  defaultValue="" onlyValue="true"/></td-->
								<td><BZ:data field="CONTACT_NAME"  defaultValue="" onlyValue="true"/></td>
								<!-- td><BZ:data field="CONTACT_NAMEPY"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CONTACT_SEX"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CONTACT_CARD"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CONTACT_JOB"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CONTACT_TEL"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CONTACT_MAIL"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CONTACT_DESC"  defaultValue="" onlyValue="true"/></td-->
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
					<td><BZ:page form="srcForm" property="List"/></td>
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
		</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>
