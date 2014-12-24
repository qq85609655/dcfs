<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description:安置部儿童材料代录列表
 * @author wangzheng   
 * @date 2014-10-23
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
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  //列表类型
  String listType=(String)request.getAttribute("listType");
  if(listType==null||"".equals(listType)){
%>
<B>系统功能参数错误！<B>
<%}else{%>
<BZ:html>
	<BZ:head>
		<title>儿童材料代录查询列表（安置部）</title>
        <BZ:webScript list="true" isAjax="true"/>
        <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
  $(document).ready(function() {
 			dyniframesize(['mainFrame']);
 			initProvOrg();
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

 	//检索
	function _search(){
	    document.srcForm.action=path+"/cms/childManager/findList.action?page=1";	     
		if (document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if (document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}
	//执行重置查询条件操作
	function _reset() {
		document.getElementById("S_PROVINCE_ID").value = "";
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_REG_DATE_START").value = "";
		document.getElementById("S_REG_DATE_END").value = "";		
		//document.getElementById("S_REG_USERNAME").value = "";
		document.getElementById("S_CHILD_STATE").value = "-1";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
				
	}
	//录入
	function _add() {		
		document.srcForm.action = path + "cms/childManager/basicadd.action";
		document.srcForm.submit();
	}
	//修改
	function _revise() {
		var arrays = document.getElementsByName("abc");
		var num = 0;
		var showuuid = "";
		var ismod = "true";
		for ( var i = 0; i < arrays.length; i++) {
			if (arrays[i].checked) {
				showuuid = document.getElementsByName('abc')[i].value;
				if ("0" != document.getElementsByName('abc')[i]
						.getAttribute("AUD_STATE")) {
					ismod = "false";
				}
				num += 1;
			}
		}
		if (num != "1") {
			page.alert('请选择一条要修改的记录');
			return;
		} else {
			if (ismod == "false") {
				page.alert('已提交的记录无法修改');
				return;
			}
			//document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
			document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid;
			document.srcForm.submit();
		}
	}
	//删除
	function _delete() {
		var sfdj = 0;
		var uuid = "";
		var isdelete = "true";
		for ( var i = 0; i < document.getElementsByName('abc').length; i++) {
			if (document.getElementsByName('abc')[i].checked) {
				uuid = uuid + "#" + document.getElementsByName('abc')[i].value;
				if ("0" != document.getElementsByName('abc')[i]
						.getAttribute("AUD_STATE")) {
					isdelete = "false";
				}
				sfdj++;
			}
		}
		if (sfdj == "0") {
			alert('请选择要删除的数据');
			return;
		} else {
			if (isdelete == "false") {
				page.alert('已提交的记录无法删除');
				return;
			}
			if (confirm('确认要删除选中信息吗?')) {
				document.getElementById("uuid").value = uuid;
				document.srcForm.action = path
						+ "/cms/childManager/delete.action";
				document.srcForm.submit();
			} else {
				return;
			}
		}
	}
	//提交
	function _submit(_state) {
		var sfdj = 0;
		var uuid = "";
		var issubmit = "true";
		for ( var i = 0; i < document.getElementsByName('abc').length; i++) {
			if (document.getElementsByName('abc')[i].checked) {
				if ("0" == document.getElementsByName('abc')[i]
						.getAttribute("AUD_STATE")) {
					issubmit = "false";
				}
				uuid = uuid + "#" + document.getElementsByName('abc')[i].value;
				sfdj++;
			}
		}
		if (sfdj == "0") {
			alert('请选择要提交的记录');
			return;
		} else {
			if (issubmit == "false") {
				page.alert('未提交的记录无法送翻或送审');
				return;
			}
			if (confirm('确认要提交选中记录吗?')) {
				alert("1");
				document.getElementById("state").value = _state;
				document.getElementById("uuid").value = uuid;
				alert("2");
				document.srcForm.action = path+ "/cms/childManager/azbBatchSubmit.action";
				alert("3");
				document.srcForm.submit();
			} else {
				return;
			}
		}
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
	
	//查询儿童资料导出
	function _export() {
		if (confirm('确认要导出为Excel文件吗?')) {
			_exportFile(document.srcForm, 'xls');
		} else {
			return;
		}
	}
	//省厅福利院查询条件联动所需方法
	function selectWelfare(node){
		var provinceId = node.value;
		//用于回显得福利机构ID
		var selectedId = '<%=WELFARE_ID%>';
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
		}else{
			//清空
			document.getElementById("S_WELFARE_ID").options.length=0;
			document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
		}
	}
	//省厅福利院查询条件联动所需方法
	function initProvOrg(){
		var str = document.getElementById("S_PROVINCE_ID");
	     selectWelfare(str);
	}
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;BCZL" >
<BZ:form name="srcForm" method="post" action="cms/childManager/findList.action">
<input type="hidden" name="listType" value="CMS_AZB_DL_LIST">
<input type="hidden" name="state" id="state" value="">
<!-- 查询条件区Start -->
<div class="table-row" id="searchDiv" style="display: none">
	<table cellspacing="0" cellpadding="0">
		<tr>
			<td style="width: 100%;">
				<table>
					<tr>
						<td class="bz-search-title" style="width: 10%">省份:</td>
						<td style="width: 15%">
						    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="70%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	        <BZ:option value="">--请选择省份--</BZ:option>
					        </BZ:select>
					 	</td>
				    	<td class="bz-search-title" style="width: 10%">福利院:</td>
						<td style="width: 15%">
				 		    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" width="95%" formTitle="福利院" defaultValue="">
						        <BZ:option value="">--请选择福利院--</BZ:option>
					        </BZ:select>
				 		</td>				
						<td class="bz-search-title" style="width: 10%">姓名:</td>
						<td style="width: 15%">
							<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 65%"/>
						</td>				
					    <td class="bz-search-title" style="width: 10%">性别:</td>
						<td style="width: 15%">
						    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="70%">
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
						    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="95%">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>		
		                <td class="bz-search-title" >出生日期:</td>
						<td colspan="3">
							<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />至
							<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
						</td>
					</tr>
					<tr>
						<td class="bz-search-title">体检日期:</td>
						<td colspan="3">
							<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始体检时间" />至
							<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止体检时间" />
						</td>
						<td class="bz-search-title">代录日期:</td>
						<td colspan="3">
							<BZ:input prefix="S_" field="REG_DATE_START" id="S_REG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REG_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始录入时间" />至
							<BZ:input prefix="S_" field="REG_DATE_END" id="S_REG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REG_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止录入时间" />
						</td>
					</tr>
					<tr>
						<td class="bz-search-title">代录状态:</td>
						<td>
							<BZ:select prefix="S_" field="CHILD_STATE" id="S_CHILD_STATE" formTitle="报送状态" defaultValue="" width="70%" >
								<BZ:option value="-1">--请选择--</BZ:option>
								<BZ:option value="0">未提交</BZ:option>
								<BZ:option value="1">已提交</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-search-title"><span title="特殊活动">特殊活动:</span></td>
						<td class="bz-search-value">
							<input type="checkbox" name="S_IS_PLAN" id="S_IS_PLAN" value="" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>明天计划&nbsp;&nbsp;
							<input type="checkbox" name="S_IS_HOPE" id="S_IS_HOPE" value="" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>希望之旅
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
<input type="button" value="代&nbsp;&nbsp;录" class="btn btn-sm btn-primary" onclick="_add()"/>&nbsp;
<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp;
<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp;
<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
<!-- 
<input type="button" value="送&nbsp;&nbsp;翻" class="btn btn-sm btn-primary" onclick="_submit('1')"/>&nbsp;
<input type="button" value="送&nbsp;&nbsp;审" class="btn btn-sm btn-primary" onclick="_submit('2')"/>&nbsp;
 -->
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
				<th style="width:3%;">
					<div class="sorting_disabled">序号</div>
				</th>
				<th style="width:5%;">
					<div class="sorting" id="PROVINCE_ID">省份</div>
				</th>				
				<th style="width:15%;">
					<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
				</th>				
				<th style="width:6%;">
					<div class="sorting" id="NAME">姓名</div>
				</th>				
				<th style="width:4%;">
					<div class="sorting" id="SEX">性别</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="BIRTHDAY">出生日期</div>
				</th>
				<th style="width:6%;">
					<div class="sorting" id="CHILD_TYPE">儿童类型</div>
				</th>
				<th style="width:10%;">
					<div  class="sorting_disabled" id="TCHD">特殊活动</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="SN_TYPE">病残种类</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="CHECKUP_DATE">体检日期</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="REG_DATE">代录日期</div>
				</th>				
				<th style="width:10%;">
					<div class="sorting" id="AUD_STATE">代录状态</div>
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
						<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
						<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="BIRTHDAY" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE"  defaultValue="" onlyValue="true"/></td>
						<td>
							<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=希望之旅"/>
							<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=明天计划"/>
						</td>
						<td align="center"><BZ:data field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="REG_DATE" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
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
			<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="安置部代录儿童资料" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;IS_HOPE=FLAG,0:否&1:是;IS_PLAN=FLAG,0:否&1:是;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;REG_DATE=DATE;AUD_STATE=FLAG,0:未提交&1:已提交&2:已提交&3:已提交&4:已提交&5:已提交&6:已提交&7:已提交&8:已提交&9:已提交" exportField="PROVINCE_ID=省份,10,20;WELFARE_NAME_CN=福利院,20;NAME=姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;CHILD_TYPE=儿童类型,15;IS_PLAN=明天计划,15;IS_HOPE=希望之旅,15;SN_TYPE=病残种类,15;CHECKUP_DATE=体检日期,15;REG_DATE=待录日期,15;AUD_STATE=代录状态,15;"/></td>
		</tr>
	</table>
</div>
<!--分页功能区End -->
</div>
</div>
</BZ:form>
	</BZ:body>
</BZ:html>
<%}%>