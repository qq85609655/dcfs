<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: 特需儿童材料审核列表（安置部）
 * @author wangzheng   
 * @date 2014-9-21
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
  Data da = (Data)request.getAttribute("data");
  String CHILD_TYPE = da.getString("CHILD_TYPE");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  String path = request.getContextPath();
%>

<BZ:html>
	<BZ:head>
		<title>特需儿童材料审核列表（安置部）</title>
        <BZ:webScript list="true" isAjax="true"/>
        <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	
<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		initProvOrg();
		_scroll(1400,1400);
	});
 
	//显示查询条件
	function _showSearch(){
		$.layer({
			type : 1,
			title : "查询条件",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['950px','250px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//检索
	function _search(){
		document.srcForm.action=path+"/cms/childManager/azbAuditList.action";
		if(document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if(document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}

	//检索条件重置
	function _reset(){
		document.getElementById("S_PROVINCE_ID").value = "";
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_RECEIVE_DATE_START").value = "";
		document.getElementById("S_RECEIVE_DATE_END").value = "";
		document.getElementById("S_AUD_STATE").value = "";
		document.getElementById("S_MATCH_STATE").value = "";
		
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_DISEASE_CN").value = "";
		document.getElementById("S_HAVE_VIDEO").value = "";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
		document.getElementById("S_SPECIAL_FOCUS").value = "";	
		document.getElementById("S_PUB_STATE").value = "";	

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
			if("<%=ChildStateManager.CHILD_AUD_STATE_YJIES%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_ZXSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				isaudit = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条审核状态为待审核或审核中的记录！');
		return;
	}else{
	 if(isaudit == "false"){
		page.alert('请选择一条审核状态为待审核或审核中的记录！');
		return;
	 }
	 document.srcForm.action=path+"/cms/childManager/childInfoAudit.action?level=<%=ChildInfoConstants.LEVEL_CCCWA%>&UUID="+uuid;
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/azbAuditList.action";
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
			if("<%=ChildStateManager.CHILD_AUD_STATE_YJIES%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_ZXSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") ){
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
		page.alert('已审核的记录无法修改！');
		return;
	 }
	 //document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid+"&listType=CMS_AZB_TXSH_LIST";
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/azbAuditList.action";
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
	//查看该儿童历次发布信息
	function _showFbHistory(ciid){
		$.layer({
			type : 2,
			title : "儿童历次发布详细信息",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			iframe: {src: '<BZ:url/>/sce/publishManager/showFbHistory.action?ciid='+ciid},
			area: ['1150px','990px'],
			offset: ['0px' , '0px']
		});
	}
  
</script>
	<BZ:body property="data" codeNames="PROVINCE;ETSFLX;BCZL;ETXB;CHILD_TYPE;CHILD_STATE;ZXCLSHZT;FBZT;FYZT">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/azbAuditList.action">
     <BZ:frameDiv property="clueTo" className="kuangjia">
		<input type="hidden" name="CHILD_TYPE" id="CHILD_TYPE" value="<%=CHILD_TYPE%>">
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">省份</td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="福利院">福利院</span></td>
								<td style="width: 15%">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					               </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="接收日期">接收日期</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true"/>
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
								<td class="bz-search-title"  style="width: 10%"><span title="出生日期">出生日期</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="审核状态">审核状态</span></td>
								<td>
									<BZ:select prefix="S_" field="AUD_STATE" id="S_AUD_STATE" isCode="true" codeName="ZXCLSHZT" defaultValue="" formTitle="审核状态">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="匹配状态">匹配状态</span></td>
								<td>
									<BZ:select prefix="S_" field="MATCH_STATE" id="S_MATCH_STATE" isCode="false" defaultValue="" formTitle="安置状态">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待匹配</BZ:option>
										<BZ:option value="1">已匹配</BZ:option>
									</BZ:select>
								</td>									
								<td class="bz-search-title"><span title="体检日期">体检日期</span></td>
								<td>
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true"/>
								</td>															
							</tr>
							<tr>
								<td class="bz-search-title"><span title="视频">视频</span></td>
								<td>
									<BZ:select prefix="S_" field="HAVE_VIDEO"  id="S_HAVE_VIDEO"  isCode="false" defaultValue="" formTitle="视频">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">无</BZ:option>
										<BZ:option value="1">有</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="病残种类">病残种类</span></td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" defaultValue="" formTitle="病残种类">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="病残诊断">病残诊断</span></td>
								<td>
									<BZ:input prefix="S_" field="DISEASE_CN" id="S_DISEASE_CN" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="特别关注">特别关注</span></td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS"  isCode="false" defaultValue="" formTitle="特别关注">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
									</BZ:select>
								</td>								
								<td class="bz-search-title"><span title="发布状态">发布状态</span></td>
								<td>
									<BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" isCode="true" codeName="FBZT" defaultValue="" formTitle="发布状态">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
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
	<div class="page-content">
    <div class="wrapper" >
		
		<!-- 功能按钮操作区Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
			<input type="button" value="修&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp
			<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- 功能按钮操作区End -->		
		<!--查询结果列表区Start -->
		<div class="table-responsive" style="overflow-x:scroll;">
		 <div id="scrollDiv">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr class="emptyData">
						<th class="center" style="width:2%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:3%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="PROVINCE_ID">省份</div>
						</th>
						<th style="width:9%;">
							<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="NAME">姓名</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="SEX">性别</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="BIRTHDAY">出生日期</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="CHECKUP_DATE">体检日期</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="SN_TYPE">病残种类</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="DISEASE_CN">病残诊断</div>
						</th>
						<th style="width:3%;">
							<div class="sorting" id="HAVE_VIDEO">视频</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
						</th>
						<th style="width:7%;">
							<div class="sorting_disabled" id="TCHD">特殊活动</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="RECEIVE_DATE">接收日期</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="PUB_STATE">发布状态</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="AUD_STATE">审核状态</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="PUB_NUM">发布次数</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="TRANSLATION_STATE">翻译状态</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="MATCH_STATE">匹配状态</div>
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
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="DISEASE_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="HAVE_VIDEO" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
								<td>
								<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=希望之旅"/>
								<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=明天计划"/>
								</td>
								<td align="center"><BZ:data field="RECEIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="PUB_STATE"  codeName="FBZT" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="AUD_STATE"  codeName="ZXCLSHZT" defaultValue="" onlyValue="true"/></td>
								<td align="center"><a href="javascript:_showFbHistory('<BZ:data field="CI_ID" onlyValue="true" />')" title="点击查看该儿童历次发布信息" ><BZ:data field="PUB_NUM"  defaultValue="" onlyValue="true"/></a></td>
								<td align="center"><BZ:data field="TRANSLATION_STATE"  codeName="FYZT" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="MATCH_STATE"  defaultValue="" onlyValue="true" checkValue="0=未匹配;1=已匹配"/></td>
							</tr>
						</BZ:for>
					</tbody>
				</table>
			</div>
		</div>
		<!--查询结果列表区End -->
		<!--分页功能区Start -->
		<div class="footer-frame">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="特需儿童材料审核数据" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHECKUP_DATE=DATE;SN_TYPE=CODE,BCZL;HAVE_VIDEO=FLAG,0:无&1:有;SPECIAL_FOCUS=FLAG,0:否&1:是;IS_HOPE=FLAG,0:否&1:是;IS_PLAN=FLAG,0:否&1:是;RECEIVE_DATE=DATE;PUB_STATE=CODE,FBZT;AUD_STATE=CODE,ZXCLSHZT;TRANSLATION_STATE=CODE,FYZT;MATCH_STATE=FLAG,0:未匹配&1:已匹配;" exportField="PROVINCE_ID=省份,15,20;WELFARE_NAME_CN=福利院,25;NAME=姓名,15;SEX=性别,10;BIRTHDAY=出生日期,15;CHECKUP_DATE=体检日期,15;SN_TYPE=病残种类,25;DISEASE_CN=病残诊断,30;HAVE_VIDEO=视频,8;SPECIAL_FOCUS=特别关注,10;IS_PLAN=明天计划,10;IS_HOPE=希望之旅,10;RECEIVE_DATE=接收日期,15;PUB_STATE=发布状态,15;AUD_STATE=审核状态,15;PUB_NUM=发布次数,15;TRANSLATION_STATE=翻译状态,15;MATCH_STATE=匹配状态,15;"/></td>				
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
