<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: 儿童材料手工移交列表
 * @author wty 
 * @date 2014-7-30 21:14:53
 * @version V1.0   
 * @ modify by wangzheng
 * @ date 2014-10-22
 * @version V1.1
 */
  String compositor=(String)request.getAttribute("compositor");
  if(compositor==null){
      compositor="";
  }
  String ordertype=(String)request.getAttribute("ordertype");
  if(ordertype==null){
      ordertype="";
  }
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  String TRANSFER_CODE=(String)request.getAttribute("TRANSFER_CODE");  
  //String TI_ID = (String)request.getAttribute("TI_ID");
  String mannualDeluuid = (String)request.getAttribute("mannualDeluuid");
  if("null".equals(mannualDeluuid) || mannualDeluuid == null){
      mannualDeluuid = "";
  }

%>
<BZ:html>
<BZ:head>
	<title>查询列表</title>
	<BZ:webScript list="true" isAjax="true" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/child.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>	
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		initProvOrg("<%=WELFARE_ID%>");
	});
	
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

  /**
  *查询
  */
  function search(){
     document.srcForm.action=path+"transferManager/MannualChildinfo.action";
	 document.srcForm.submit();
  }

  /**
  *选择移交文件
  */
  function _choice(){  	
	var num = 0;
	var chioceuuid = [];
	var arrays = document.getElementsByName("abc");
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num] = arrays[i].value;
			num += 1;
		}
	}
	if(num < 1){
		page.alert('请选择要添加移交的儿童材料！');
		return;
	}else{
		if (confirm("确定移交这些儿童材料？")){
			var uuid = chioceuuid.join("#");
			opener.refreshLocalList(uuid);
			window.close();
			
			
			/*var TI_ID = document.getElementById("TI_ID").value;
			
			var rv = getStr("com.dcfs.ffs.transferManager.TransferManagerAjax", "uuid="+uuid+"&TI_ID="+TI_ID);
			
			if(rv == "1"){
				opener.refreshLocalList();
				window.close();
			}else{
				alert("数据添加失败！");
			}*/
		}
	}
  }

  //查询条件重置
  function _reset(){
	  $("#S_CHILD_NO").val("");
	  $("#S_PROVINCE_ID").val("");
	  $("#S_WELFARE_ID").val("");
	  $("#S_NAME").val("");
	  $("#S_SEX").val("");
	  $("#S_BIRTHDAY_START").val("");
	  $("#S_BIRTHDAY_END").val("");
	  $("#S_CHILD_TYPE").val("");
	  $("#S_SPECIAL_FOCUS").val("");
	}
  
</script>

<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE">
	<BZ:form name="srcForm" method="post" action="/transferManager/MannualChildinfo.action">
	 <input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
		<input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
		<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
				<table>
					<tr>
						<td class="bz-search-title" style="width: 8%">省份</td>
						<td style="width: 15%">
							<BZ:select prefix="S_" id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
			 	                <BZ:option value="">--请选择省份--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title" style="width: 8%">福利院</td>
						<td style="width: 15%">
						    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="200px">
				              <BZ:option value="">--请选择福利院--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title" style="width: 8%">儿童编号</td>
						<td style="width: 40%">
							<BZ:input prefix="S_" field="CHILD_NO" id="S_CHILD_NO" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
						</td>
					</tr> 
					<tr>						
						<td class="bz-search-title">姓名</td>
						<td>
							<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
						</td>
						<td class="bz-search-title">性别</td>
						<td>
							<BZ:select prefix="S_" id="S_SEX" field="SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="">
				              <BZ:option value="">--请选择--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title">出生日期</td>
						<td>
							<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" formTitle="起始提交日期" />~ 
							<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" formTitle="截止提交日期" />
						</td>
					</tr>
					<tr>
						<td class="bz-search-title">儿童类型</td>
						<td>
							<BZ:select prefix="S_" id="S_CHILD_TYPE" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="">
				              <BZ:option value="">--请选择--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title">特别关注</td>
						<td>
							<BZ:select prefix="S_" id="S_SPECIAL_FOCUS" field="SPECIAL_FOCUS" formTitle="特别关注" defaultValue="">
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
				<input type="button" value="搜&nbsp;&nbsp;索" onclick="search();" class="btn btn-sm btn-primary"> 
				<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
				</div>
				</td>
				<td class="bz-search-right"></td>
			</tr>
		</table>
		</div>
		<!-- 查询条件区End -->
		<div class="wrapper"><!-- 功能按钮操作区Start -->
		<div class="table-row table-btns" style="text-align: left"><input
			type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary"
			onclick="_showSearch()" />&nbsp; <input type="button"
			value="选&nbsp;&nbsp;择" class="btn btn-sm btn-primary"
			onclick="_choice()" /></div>
		<div class="blue-hr"></div>
		<!-- 功能按钮操作区End --> <!--查询结果列表区Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr>
					<th class="center" style="width: 2%;">
					<div class="sorting_disabled"><input name="abcd"
						type="checkbox" class="ace"></div>
					</th>
					<th style="width: 5%;">
					<div class="sorting_disabled">序号</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="CHILD_NO">儿童编号</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="PROVINCE_ID">省份</div>
					</th>
					<th style="width: 20%;">
					<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="NAME">姓名</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="SEX">性别</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="BIRTHDAY">出生日期</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="CHILD_TYPE">材料类型</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
					</th>
				</tr>
			</thead>
			<tbody>
				<BZ:for property="List">
					<tr class="emptyData">
						<td class="center"><input name="abc" type="checkbox" value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace">
						</td>
						<td class="center"><BZ:i /></td>
						<td><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
						<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true" /></td>
						<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
						<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data type="date" field="BIRTHDAY" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是" /></td>
					</tr>
				</BZ:for>
			</tbody>
		</table>
		</div>
		<!--查询结果列表区End --> <!--分页功能区Start -->
		<div class="footer-frame">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
				<td><BZ:page form="srcForm" property="List" /></td>
			</tr>
		</table>
		</div>
		<!--分页功能区End --></div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>
