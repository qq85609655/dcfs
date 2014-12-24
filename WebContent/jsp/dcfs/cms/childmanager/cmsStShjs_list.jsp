<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: 省厅材料审核寄送列表
 * @author wangzheng   
 * @date 2014-9-15
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
  String listType=(String)request.getAttribute("listType");
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  String provinceId=da.getString("PROVINCE_ID","");
String path = request.getContextPath();

%>

<BZ:html>
	<BZ:head>
		<title>材料审核寄送列表（省厅）</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
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
			area: ['950px','260px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//检索
	function _search(){
		document.srcForm.action=path+"/cms/childManager/STAuditList.action";
		if(document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if(document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}

	//检索条件重置
	function _reset(){
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_CHILD_STATE").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
		document.getElementById("S_SEND_DATE_START").value = "";
		document.getElementById("S_SEND_DATE_END").value = "";
		document.getElementById("S_AUDIT_DATE_START").value = "";
		document.getElementById("S_AUDIT_DATE_END").value = "";
		document.getElementById("S_POST_DATE_START").value = "";
		document.getElementById("S_POST_DATE_END").value = "";
		document.getElementById("S_RECEIVE_DATE_START").value = "";
		document.getElementById("S_RECEIVE_DATE_END").value = "";
	}
  
	//查看信息
	function _view(){
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
			url = path+"/cms/childManager/show.action?type=show&UUID="+showuuid;
			_open(url, "儿童材料信息", 1000, 600);
		}
	}

    //导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}

//审核
  function _audit(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var uuid="";
	var isaudit = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			uuid=document.getElementsByName('abc')[i].getAttribute("CA_ID");
			if("<%=ChildStateManager.CHILD_AUD_STATE_SDS%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_SSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				isaudit = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条审核状态为待审核或审核中的记录');
		return;
	}else{
	 if(isaudit == "false"){
		page.alert('请选择一条审核状态为待审核或审核中的记录');
		return;
	 }
	 document.srcForm.action=path+"/cms/childManager/childInfoAudit.action?level=<%=ChildInfoConstants.LEVEL_PROVINCE%>&UUID="+uuid;
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/STAuditList.action";
	 }
  }
	
	//修改
  function _revise(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var ismod = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			
			if("<%=ChildStateManager.CHILD_AUD_STATE_SDS%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_SSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") ){
				ismod = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要修改的记录！');
		return;
	}else{
	 if(ismod == "false"){
		page.alert('已寄送的记录无法修改！');
		return;
	 }
	 
	// document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid+"&listType=CMS_ST_SHJS_LIST";
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/STAuditList.action";
	 }
  }

  //寄送
  function _post(){
	var sfdj=0;
	var uuid="";
	var ispost = "true"
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
		   if("<%=ChildStateManager.CHILD_AUD_STATE_STG%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				ispost = "false";
			}
	   uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
	   sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('请选择要寄送的材料！');
	   return;
	  }else{
		  if(ispost == "false"){
			page.alert('请选择审核通过的材料寄送！');
			return;
		 }
	  if(confirm('确定要寄送选中材料吗?')){
		  
		 document.getElementById("uuid").value=uuid;
		 document.srcForm.action=path+"/cms/childManager/stBatchPost.action";
		 document.srcForm.submit();
		 document.srcForm.action=path+"/cms/childManager/STAuditList.action";
	  }else{
	  return;
	  }
	}
  }

  //打印
  function _print(){
   var sfdj=0;
	var uuid="";
	var isprint = "true"
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
		uuid=uuid+"#"+document.getElementsByName('abc')[i].value;	   
		sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('请选择要打印的材料');
	   return;
	  }else{
		  //_open("<BZ:url/>/cms/childManager/postPrint.action", "材料寄送打印", 1000, 600); 
		  
		  openPostWindow("<BZ:url/>/cms/childManager/postPrint.action",uuid,"材料寄送打印");		  
		  //document.getElementById("printid").value=uuid;
		  //_open("<BZ:url/>/cms/childManager/postPrint.action", "材料寄送打印", 1000, 600); 
		  
		  //document.frmprint.fireEvent("onsubmit");
		  //document.frmprint.submit();
		  /*
			$.layer({
			type : 2,
			title : "寄送单打印",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			//page : {dom : '#planList'},
			iframe: {src: '<BZ:url/>/cms/childManager/postPrint.action'},
			area: ['800px','400px'],
			offset: ['0px' , '0px']
		});*/

		 //
		 //document.srcForm.action=path+"/cms/childManager/postPrint.action";
		 //document.srcForm.submit();	  
	}
  }

  function openPostWindow(url,data,name){
	var tempForm = document.createElement("form");    
	tempForm.id="tempForm1";    
	tempForm.method="post";    
	tempForm.action=url;    
	tempForm.target=name;

	var hideInput = document.createElement("input");    
	hideInput.type="hidden";    
	hideInput.name= "printid"  
    hideInput.value= data;
	tempForm.appendChild(hideInput);
	addEvent(tempForm,"onsubmit",function(){ 
		_open("<BZ:url/>/cms/childManager/postPrint.action", "材料寄送打印", 1000, 600); 
	}); 
	document.body.appendChild(tempForm); 
	//tempForm.fireEvent("onsubmit");  
	tempForm.submit();  
	document.body.removeChild(tempForm);  
}  

function addEvent(element,type,handler){
	if(element.attachEvent){
		element.attachEvent("on"+type,handler);
	}else if(element.addEventListener){
		element.addEventListener(type,handler,false);
	
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
	<BZ:body property="data" codeNames="ETSFLX;BCZL;ETXB;CHILD_TYPE;CHILD_STATE">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/STAuditList.action">
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="福利院">福利院</span></td>
								<td colspan="3">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="80%">
					                   <BZ:option value="">--请选择福利院--</BZ:option>
				                    </BZ:select>
								</td>								
								<td class="bz-search-title"  style="width: 10%"><span title="出生日期">出生日期</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="姓名">姓名</span></td>
								<td style="width:15%">
								<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="性别">性别</span></td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title"><span title="体检日期">体检日期</span></td>
								<td colspan="5">
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true"/>
								</td>	
							</tr>
							<tr>
								<td class="bz-search-title"><span title="儿童类型">儿童类型</span></td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="病残种类">病残种类</span></td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE"  id="S_SN_TYPE" isCode="true" codeName="BCZL"  defaultValue="" formTitle="病残种类">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title"><span title="报送日期">报送日期</span></td>
								<td>
									<BZ:input prefix="S_" field="SEND_DATE_START" id="S_SEND_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_SEND_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="SEND_DATE_END" id="S_SEND_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_SEND_DATE_START\\')}',readonly:true"/>
								</td>																				
							</tr>
							<tr>
								<td class="bz-search-title"><span title="特殊活动">特殊活动</span></td>
								<td class="bz-search-value">
									<input type="checkbox" name="S_IS_PLAN" id="S_IS_PLAN" value="" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>明天计划&nbsp;&nbsp;
									<input type="checkbox" name="S_IS_HOPE" id="S_IS_HOPE" value="" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>希望之旅
								</td>
								<td class="bz-search-title"><span title="审核状态">审核状态</span></td>
								<td>
									<BZ:select prefix="S_" field="CHILD_STATE" id="S_CHILD_STATE" isCode="false" defaultValue="" formTitle="审核状态">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">省待审</BZ:option>
										<BZ:option value="2">省审核中</BZ:option>
										<BZ:option value="3">省不通过</BZ:option>
										<BZ:option value="4">省通过</BZ:option>
										<BZ:option value="5">已寄送</BZ:option>
										<BZ:option value="6">已接收</BZ:option>
									</BZ:select>
								</td>	
								<td class="bz-search-title"><span title="审核日期">审核日期</span></td>
								<td>
									<BZ:input prefix="S_" field="AUDIT_DATE_START" id="S_AUDIT_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_AUDIT_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="AUDIT_DATE_END" id="S_AUDIT_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_AUDIT_DATE_START\\')}',readonly:true"/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title"><span title="寄送日期">寄送日期</span></td>
								<td colspan="3">
									<BZ:input prefix="S_" field="POST_DATE_START" id="S_POST_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_POST_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="POST_DATE_END" id="S_POST_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_POST_DATE_START\\')}',readonly:true"/>
								</td>		
								<td class="bz-search-title"><span title="接收日期">接收日期</span></td>
								<td>
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true"/>
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
    <input type="hidden" name="uuid" id="uuid" value="" />	     
	<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<div class="page-content">
	<BZ:frameDiv property="clueTo" className="kuangjia">	 
    <div class="wrapper">
		
		<!-- 功能按钮操作区Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
			<input type="button" value="寄&nbsp;&nbsp;送" class="btn btn-sm btn-primary" onclick="_post()"/>&nbsp;
			<input type="button" value="寄送单打印" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
			<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp
			<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- 功能按钮操作区End -->		
		<!--查询结果列表区Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th class="center" style="width:2%;">
						<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
					</th>
					<th style="width:3%;">
						<div class="sorting_disabled">序号</div>
					</th>
					<th style="width:13%;">
						<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="NAME">姓名</div>
					</th>
					<th style="width:4%;">
						<div class="sorting" id="SEX">性别</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="BIRTHDAY">出生日期</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="CHILD_TYPE">儿童类型</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="SN_TYPE">病残种类</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHECKUP_DATE">体检日期</div>
					</th>
					<th style="width:8%;">
						<div  class="sorting_disabled" id="TCHD">特殊活动</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="SEND_DATE">（福）报送日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="AUDIT_DATE">审核日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="POST_DATE">（省）寄送日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="RECEIVE_DATE">（中）接收日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="AUD_STATE">审核状态</div>
					</th>
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr>
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace" AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>" RETURN_STATE="<BZ:data field="RETURN_STATE" onlyValue="true"/>" CA_ID="<BZ:data field="CA_ID" onlyValue="true"/>">
							</td>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
							<td><BZ:data field="SN_TYPE"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td>
							<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=希望之旅"/>
							<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=明天计划"/>
							</td>
							<td align="center"><BZ:data field="SEND_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="POST_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="RECEIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUD_STATE"  codeName="CHILD_STATE" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="儿童材料审核寄送数据" exportCode="SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;IS_HOPE=FLAG,0:否&1:是;IS_PLAN=FLAG,0:否&1:是;SEND_DATE=DATE;AUDIT_DATE=DATE;POST_DATE=DATE;RECEIVE_DATE=DATE;AUD_STATE=CODE,CHILD_STATE;" exportField="WELFARE_NAME_CN=福利院,30,20;NAME=姓名,15;SEX=性别,10;BIRTHDAY=出生日期,15;CHILD_TYPE=儿童类型,10;SN_TYPE=病残种类,25;CHECKUP_DATE=体检日期,15;IS_PLAN=明天计划,10;IS_HOPE=希望之旅,10;SEND_DATE=（福）报送日期,20;AUDIT_DATE=审核日期,15;POST_DATE=（省）寄送日期,20;RECEIVE_DATE=（中）接收日期,20;AUD_STATE=审核状态,15;"/></td>				
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
	</div>
</div>
<form name="frmprint" method="post" action="<%=path%>/cms/childManager/postPrint.action" target="<%=path%>/cms/childManager/postPrint.action">
	<input type="hidden" id="printid" name="printid">
</form>
<br><br><br><br><br>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>
