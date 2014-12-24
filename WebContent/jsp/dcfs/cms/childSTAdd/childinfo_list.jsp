<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description:省厅代录
 * @author xcp   
 * @date 2014-9-25 13:18:18
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
  //构造数据对象
  Data data = (Data)request.getAttribute("data");
  if(data==null){
      data = new Data();
  }
  String WELFARE_ID=data.getString("WELFARE_ID","");
  String provinceId=data.getString("PROVINCE_ID","");
	//request.setAttribute("data",data);
%>
<BZ:html>
	<BZ:head>
		<title>查询列表</title>
        <BZ:webScript list="true" isAjax="true"/>
        <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
  $(document).ready(function() {
 			dyniframesize(['mainFrame']);
 			selectWelfare(<%=provinceId %>);
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
 
	function search(){
	     document.srcForm.action=path+"cms/childstadd/findList.action?page=1";
		 document.srcForm.submit();
	  }
	//执行重置查询条件操作
	function _reset(){
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_REG_USERNAME").value = "";
		document.getElementById("S_AUD_STATE").value = "-1";
		document.getElementById("S_REG_DATE_STRAT").value = "";
		document.getElementById("S_REG_DATE_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
	}	
  //录入
  function add(){
     document.srcForm.action=path+"cms/childstadd/basicinfoadd.action";
	 document.srcForm.submit();
  }
//修改
  function _update(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var ismod = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			if("0"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				ismod = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要修改的记录');
		return;
	}else{
	 if(ismod == "false"){
		page.alert('已提交的记录无法修改');
		return;
	 }
	 //document.srcForm.action=path+"cms/childstadd/show.action?UUID="+showuuid;
	 document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid+"&listType=CMS_ST_DL_LIST";
	 document.srcForm.submit();
	 }
  }
  //删除
  function _delete(){
   var sfdj=0;
	var uuid="";
	var isdelete = "true";
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
	   uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
	   if("0"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				isdelete = "false";
			}
	   sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('请选择要删除的数据');
	   return;
	  }else{
		   if(isdelete == "false"){
			page.alert('已提交的记录无法删除');
			return;
		 }
	  if(confirm('确认要删除选中信息吗?')){
		 document.getElementById("uuid").value=uuid;
		 document.srcForm.action=path+"/cms/childstadd/delete.action";
		 document.srcForm.submit();
	  }else{
	  return;
	  }
	}
  }
//提交
  function _submit(){
	var sfdj=0;
	var uuid="";
	var issubmit = "true";
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
		   if("0"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				issubmit = "false";
			}
	   uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
	   sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('请选择要提交的记录');
	   return;
	  }else{
		  if(issubmit == "false"){
			page.alert('已提交的记录无法重复提交');
			return;
		 }
	  if(confirm('确认要提交选中记录吗?')){
		  
		 document.getElementById("uuid").value=uuid;
		 document.srcForm.action=path+"/cms/childstadd/stBatchSubmit.action";
		 document.srcForm.submit();
	  }else{
	  return;
	  }
	}
  }
	//省厅查询儿童资料导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}
	//根据省厅province_id初始化福利院的下拉选择列表中要显示的内容
	function selectWelfare(provinceId){
		//用于回显的福利机构code
		var selectedId = '<%=WELFARE_ID%>';
		if(provinceId!=null&&provinceId!=""){
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						var option = document.getElementById("S_WELFARE_ID");
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}else{					
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					}
				}
			}
		}
	}
  </script>
<BZ:body property="data" codeNames="ETXB;CHILD_TYPE;BCZL" >
<BZ:form name="srcForm" method="post" action="cms/childstadd/findList.action">
<!-- 查询条件区Start -->
<div class="table-row" id="searchDiv" style="display: none">
	<table cellspacing="0" cellpadding="0">
		<tr>
			<td style="width: 100%;">
				<table>
				<tr>
				 <td class="bz-search-title" style="width: 15%">福利院:</td>
				 <td style="width: 16%">
				    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="100%">
					    <BZ:option value="">--请选择福利院--</BZ:option>
				    </BZ:select>
				 </td>
				
				<td class="bz-search-title" style="width: 10%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</td>
				<td style="width: 16%">
					<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 65%"/>
				</td>
				
			    <td class="bz-search-title">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别:</td>
				<td >
				    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="">
						<BZ:option value="">--请选择--</BZ:option>
					</BZ:select>
				</td>
				</tr>
				
				<tr>
				<td class="bz-search-title" >儿童类型:</td>
				<td >
				    <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="" width="70%">
						<BZ:option value="">--请选择--</BZ:option>
					</BZ:select>
				</td>
				
				<td class="bz-search-title" >病残种类:</td>
				<td >
				    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="70%">
						<BZ:option value="">--请选择--</BZ:option>
					</BZ:select>
				</td>		
                         <td class="bz-search-title" style="width: 10%">出生日期:</td>
				<td style="width: 36%">
					<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />至
					<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
				</td>
			</tr>
			
			<tr>
				<td class="bz-search-title" style="width: 12%">录入人:</td>
				<td style="width: 10%">
					<BZ:input prefix="S_" field="REG_USERNAME" id="S_REG_USERNAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 65%"/>
				</td>
				
				<td class="bz-search-title">报送状态:</td>
				<td>
					<BZ:select prefix="S_" field="AUD_STATE" id="S_AUD_STATE" formTitle="报送状态" defaultValue="" width="70%" >
						<BZ:option value="-1">--请选择--</BZ:option>
						<BZ:option value="0">未提交</BZ:option>
						<BZ:option value="4">已提交</BZ:option>
					</BZ:select>
				</td>
				
				<td class="bz-search-title">录入时间:</td>
				<td>
					<BZ:input prefix="S_" field="REG_DATE_STRAT" id="S_REG_DATE_STRAT" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REG_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始录入时间" />至
					<BZ:input prefix="S_" field="REG_DATE_END" id="S_REG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REG_DATE_STRAT\\')}',readonly:true" defaultValue="" formTitle="截止录入时间" />
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">体检时间:</td>
				<td colspan="5">
					<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始体检时间" />至
					<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止体检时间" />
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
					<input type="button" value="搜&nbsp;&nbsp;索" onclick="search();" class="btn btn-sm btn-primary">
					<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
				</div>
			</td>
			<td class="bz-search-right"></td>
		</tr>
	</table>
</div>
<!-- 查询条件区End -->
<input type="hidden" name="uuid" id="uuid" value="" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
 <div class="page-content">
 <BZ:frameDiv property="clueTo" className="kuangjia"></BZ:frameDiv>
    <div class="wrapper">
 <!-- 功能按钮操作区Start -->
 <div class="table-row table-btns" style="text-align: left">
<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
<input type="button" value="录&nbsp;&nbsp;入" class="btn btn-sm btn-primary" onclick="add()"/>&nbsp;
<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_update()"/>&nbsp;
<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp;
<input type="button" value="提&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;
<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>	
</div>
<div class="blue-hr"></div>
<!-- 功能按钮操作区End -->


<!--查询结果列表区Start -->
<div class="table-responsive">
	<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
		<thead>
			<tr>
				<th class="center" style="width:2%;">
					<div class="sorting_disabled">
						<input  type="checkbox" class="ace">
					</div>
				</th>
				<th style="width:5%;">
					<div class="sorting_disabled">序号</div>
				</th>
				
				<th style="width:13%;">
					<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
				</th>
				
				<th style="width:7%;">
					<div class="sorting" id="NAME">姓名</div>
				</th>
				
				<th style="width:6%;">
					<div class="sorting" id="SEX">性别</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="BIRTHDAY">出生日期</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="CHECKUP_DATE">体检日期</div>
				</th>
				<th style="width:8%;">
					<div class="sorting" id="CHILD_TYPE">儿童类型</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="SN_TYPE">病残种类</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="REG_USERNAME">录入人</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="REG_DATE">录入时间</div>
				</th>
				
				<th style="width:10%;">
					<div class="sorting" id="AUD_STATE">报送状态</div>
				</th>
			</tr>
			</thead>
			<tbody>	
				<BZ:for property="List">
					<tr class="emptyData">
						<td class="center">
							<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace"  AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>">
						</td>
						<td class="center">
							<BZ:i/>
						</td>
						<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="BIRTHDAY" type="Date"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="CHECKUP_DATE" type="Date"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="REG_USERNAME"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="REG_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="AUD_STATE"  defaultValue="" onlyValue="true" checkValue="0=未提交;1=已提交;2=已提交;3=已提交;4=已提交;5=已提交;6=已提交;7=已提交;8=已提交;9=已提交"/></td>
					
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
			<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="省厅代录儿童资料" exportCode="SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;REG_USERNAME;REG_DATE=DATE;AUD_STATE=FLAG,0:未提交&1:已提交&2:已提交&3:已提交&4:已提交&5:已提交&6:已提交&7:已提交&8:已提交&9:已提交" exportField="WELFARE_NAME_CN=福利院,18,20;NAME=姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;CHECKUP_DATE=体检日期,15;CHILD_TYPE=儿童类型,15;SN_TYPE=病残种类,15;REG_USERNAME=录入人,15;REG_DATE=录入时间,15;AUD_STATE=报送状态,15;"/></td>
		</tr>
	</table>
</div>
<!--分页功能区End -->
</div>
</div>
</BZ:form>
	</BZ:body>
</BZ:html>
