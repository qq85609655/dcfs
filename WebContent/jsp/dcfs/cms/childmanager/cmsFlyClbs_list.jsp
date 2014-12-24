<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: 福利院材料报送列表
 * @author wangzheng   
 * @date 2014-9-3
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
  
  if(listType==null||"".equals(listType)){
%>
<B>系统功能参数错误！<B>
<%}else{%>
<BZ:html>
	<BZ:head>
		<title>材料报送列表（福利院）</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	
<script type="text/javascript">
  	//iFrame高度自动调整
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
			area: ['950px','210px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//检索
	function _search(){
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"/cms/childManager/findList.action?page=1";
		if(document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if(document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}

	//检索条件重置
	function _reset(){
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_CHILD_STATE").value = "-1";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
		document.getElementById("S_UPDATE_NUM_START").value = "";
		document.getElementById("S_UPDATE_NUM_END").value = "";
		document.getElementById("S_SEND_DATE_START").value = "";
		document.getElementById("S_SEND_DATE_END").value = "";
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
	//查看信息
	function _view1(){
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
			url = path+"/cms/childManager/childInfoForAdoption.action?UUID="+showuuid+"&onlyPage=1";
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

	//录入
	function _add(){
		document.srcForm.action=path+"/cms/childManager/basicadd.action";
		document.srcForm.submit();
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
		 //document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
		 document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid;
		 document.srcForm.submit();
		 }
  	}

  //提交
  function _submit(){
	var sfdj=0;
	var uuid="";
	var issubmit = "true"
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
		page.alert('请选择要提交的记录');
	  	return;
	}else{
		if(issubmit == "false"){
			page.alert('已提交的记录无法重复提交');
			return;
		}
		if(confirm('确认要提交选中记录吗?')){	 
			document.getElementById("uuid").value=uuid;
			document.srcForm.action=path+"/cms/childManager/flyBatchSubmit.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
  }

  //删除
  function _delete(){
   var sfdj=0;
	var uuid="";
	var isdelete = "true"
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
		 document.srcForm.action=path+"/cms/childManager/delete.action";
		 document.srcForm.submit();
	  }else{
	  return;
	  }
	}
  }

</script>
	<BZ:body property="data" codeNames="ETSFLX;BCZL;ETXB;CHILD_TYPE">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/findList.action">
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="姓名">姓名</span></td>
								<td style="width:15%">
								<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="性别">性别</span></td>
								<td style="width: 15%">
									<BZ:select prefix="S_" id="S_SEX" field="SEX" isCode="true" codeName="ETXB" formTitle="性别">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title"  style="width: 10%"><span title="出生日期">出生日期</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="儿童类型">儿童类型</span></td>
								<td>
									<BZ:select prefix="S_" id="S_CHILD_TYPE" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>													
								<td class="bz-search-title"><span title="病残种类">病残种类</span></td>
								<td>
									<BZ:select prefix="S_" id="S_SN_TYPE" field="SN_TYPE" isCode="true" codeName="BCZL"  defaultValue="" formTitle="病残种类">
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
								<td class="bz-search-title"><span title="儿童状态">儿童状态</span></td>
								<td>
									<BZ:select prefix="S_"  id="S_CHILD_STATE" field="CHILD_STATE" isCode="false" defaultValue="" formTitle="儿童状态">
										<BZ:option value="-1">--请选择--</BZ:option>
										<BZ:option value="0">未提交</BZ:option>
										<BZ:option value="1">已提交</BZ:option>
									</BZ:select>
								</td>	
								<td class="bz-search-title"><span title="更新次数">更新次数</span></td>
								<td>
									<BZ:input prefix="S_" field="UPDATE_NUM_START" id="S_UPDATE_NUM_START" restriction="int" size="4" maxlength="2" defaultValue=""/>~
									<BZ:input prefix="S_" field="UPDATE_NUM_END" id="S_UPDATE_NUM_END" restriction="int" size="4" maxlength="2" defaultValue=""/>
								</td>
								<td class="bz-search-title"><span title="报送日期">报送日期</span></td>
								<td colspan="5">
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
	<input type="hidden" name="listType" id="listType" value="<%=listType%>"/>
	<div class="page-content">
	<BZ:frameDiv property="clueTo" className="kuangjia">	 
    <div class="wrapper">
		
		<!-- 功能按钮操作区Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="录&nbsp;&nbsp;入" class="btn btn-sm btn-primary" onclick="_add()"/>&nbsp;
			<input type="button" value="提&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;
			<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp;
			<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp;
			<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="儿童材料制作模板下载" class="btn btn-sm btn-primary" onclick="_download()"/>&nbsp;
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
					<th style="width:4%;">
						<div class="sorting_disabled">序号</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="NAME">姓名</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="SEX">性别</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="BIRTHDAY">出生日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHILD_TYPE">儿童类型</div>
					</th>
					<th style="width:15%;">
						<div class="sorting" id="SN_TYPE">病残种类</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="CHECKUP_DATE">体检日期</div>
					</th>
					<th style="width:10%;">
						<div  class="sorting_disabled" id="TCHD">特殊活动</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="UPDATE_NUM">更新次数</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="SEND_DATE">报送日期</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="AUD_STATE">儿童状态</div>
					</th>
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr>
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace" AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>" RETURN_STATE="<BZ:data field="RETURN_STATE" onlyValue="true"/>">
							</td>
							<td class="center">
								<BZ:i/>
							</td>
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
							<td align="center"><BZ:data field="UPDATE_NUM" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEND_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="儿童材料报送数据" exportCode="SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;IS_HOPE=FLAG,0:否&1:是;IS_PLAN=FLAG,0:否&1:是;SEND_DATE=DATE;AUD_STATE=FLAG,0:未提交&1:已提交&2:已提交&3:已提交&4:已提交&5:已提交&6:已提交&7:已提交&8:已提交&9:已提交" exportField="NAME=姓名,15,20;SEX=性别,10;BIRTHDAY=出生日期,15;CHILD_TYPE=儿童类型,10;SN_TYPE=病残种类,25;CHECKUP_DATE=体检日期,15;IS_PLAN=明天计划,10;IS_HOPE=希望之旅,10;UPDATE_NUM=更新次数,10;SEND_DATE=报送日期,15;AUD_STATE=儿童状态,15;"/></td>				
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
	</div>
</div>
<br><br><br><br><br>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>
<%}%>