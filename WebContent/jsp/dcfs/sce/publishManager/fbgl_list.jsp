<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="org.jaxen.Context"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
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
		<title>发布管理列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
			_findSyzzNameListForNew('S_COUNTRY_CODE2','S_ADOPT_ORG_ID2','S_HIDDEN_ADOPT_ORG_ID2')
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','350px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/publishManager/findListForFBGL.action";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_PUB_TYPE").value = "";
			document.getElementById("S_PUB_MODE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_PUB_STATE").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_LOCK_NUM").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_PUB_ORGID").value = "";
			document.getElementById("S_COUNTRY_CODE2").value = "";
			document.getElementById("S_ADOPT_ORG_ID2").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_PUB_FIRSTDATE_START").value = "";
			document.getElementById("S_PUB_FIRSTDATE_END").value = "";
			document.getElementById("S_SETTLE_DATE_START").value = "";
			document.getElementById("S_SETTLE_DATE_END").value = "";
			document.getElementById("S_PUB_LASTDATE_START").value = "";
			document.getElementById("S_PUB_LASTDATE_END").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_DISEASE_CN").value = "";
			
			
		}
		
		 
		//发布撤销
		function _fbcx(){
			var num = 0;
			var pub_id;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					pub_id = arrays[i].value;
					num++;
				}
				
			}
			if(num < 1){
				page.alert('请选择一条发布状态为"已发布"的记录！');
				return;
			}else{
				_isFB(pub_id);
			}
		}
		
		//判断发布记录的发布状态是否为已发布 true:是  false:否
		function _isFB(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=isFB&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						_isTH(pub_id);
					}else{
						page.alert('请选择一条发布状态为"已发布"的记录！');
						return false;
					}
				}
			})
		}
		
		//判断发布记录的发布状态是否进行申请了退回 true:是  false:否
		function _isTH(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=isTH&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						page.alert('该记录已进行了点发退回，不允许进行发布撤销操作！');
						return false;
					}else{
						_isCanFBCX(pub_id);
					}
				}
			})
		}
		
		//是否可进行撤销发布操作
		function _isCanFBCX(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getFbjlAndEtInfo&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if("1"==data.MATCH_STATE){
						page.alert('已匹配该儿童，请先进行解除匹配操作！');
						return false;
					}else if("3"==data.PUB_STATE_FBRECORD){
						page.alert('已锁定该儿童，请先进行解除锁定操作！');
						return false;
					}else if("4"==data.PUB_STATE_FBRECORD){
						page.alert('已递交预批，请先进行预批撤销操作！');
						return false;
					}else{
						document.srcForm.action=path+"sce/publishManager/toCancleFB.action?pubid="+pub_id;
						document.srcForm.submit();
					}
				}
			})
		}
		
		
		//解除锁定
		function _jcsd(){
			var num = 0;
			var pub_id;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					pub_id = arrays[i].value;
					num++;
				}
				
			}
			if(num < 1){
				page.alert('请选择一条发布状态为"已锁定"且预批状态为"未递交"的记录！');
				return;
			}else{
				_isSD(pub_id);
			}
		}
		
		//判断发布记录的发布状态是否进行申请了退回 true:是  false:否
		function _isSD(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=isSD&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						document.srcForm.action=path+"sce/publishManager/toUnlockFB.action?pubid="+pub_id;
						document.srcForm.submit();
					}else{
						page.alert('请选择一条发布状态为"已锁定"且预批状态为"未递交"的记录！');
						return false;
					}
				}
			})
		}
		
		
		
		//查看
		function _show() {
			var num = 0;
			var showuuid="";
			var fileno="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					//showuuid=document.getElementsByName('xuanze')[i].value;
					showuuid=arrays[i].value.split("#")[0];
					fileno = arrays[i].value.split("#")[2];
					num += 1;
				}
			}
			if(num != "1"){
				alert('请选择一条要查看的数据');
				return;
			}else{
			    window.open(path+"ffs/registration/show.action?showuuid="+showuuid+"&fileno="+fileno,"newwindow","height=550,width=1000,top=70,left=180,scrollbars=yes");
				document.srcForm.submit();
			}
		}
		
		
		//业务自定义功能操作JS
		
		//文件退回新增
		function _wjthAdd(){
			var num = 0;
			var AF_ID="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "1"){
						AF_ID=document.getElementsByName('xuanze')[i].value;
						num += 1;
					}else{
						page.alert("只能选择待登记的文件信息！");
						return;
					}
				}
			}
			if(num != "1"){
				alert('请选择一条要退回的数据');
				return;
			}else{
				document.srcForm.action=path+"ffs/registration/toAddFlieReturnReason.action?AF_ID="+AF_ID;
				document.srcForm.submit();
			}
		}
		
		//跳转到待发布儿童选择页面
		function _toChoseETForFB(){
			_reset();
			document.srcForm.action=path+"sce/publishManager/toChoseETForFB.action";
			document.srcForm.submit();
		}
		
		//查看该儿童历次锁定信息
		function _showLockHistory(ciid){
			$.layer({
				type : 2,
				title : "历次锁定详细信息",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/showLockHistory.action?ciid='+ciid},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
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
		
		//省厅福利院查询条件联动所需方法
	function selectWelfare(node){
		var provinceId = node.value;
		//用于回显得福利机构ID
		var selectedId;
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
	
	
	//查看该发布记录发布组织列表
		function _showFbOrgList(pub_id){
			$.layer({
				type : 2,
				title : "本次发布组织列表",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/findListForFBORG.action?pub_id='+pub_id},
				area: ['1150px','800px'],
				offset: ['0px' , '0px']
			});
		}

	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;BCZL;DFLX_ALL;FBZT;SYS_ADOPT_ORG;PROVINCE;YPZT">
		<BZ:form name="srcForm" method="post" action="sce/publishManager/findListForFBGL.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="reguuid" name="reguuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" width="10%">省份</td>
								<td width="15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="77%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="" >
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" width="10%">福利院</td>
								<td width="15%">
								   <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="77%">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					               </BZ:select>
								</td>
								
								<td class="bz-search-title">发布类型</td>
								<td>
									<BZ:select prefix="S_" field="PUB_TYPE" id="S_PUB_TYPE" formTitle="发布类型" defaultValue="" width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">点发</BZ:option>
										<BZ:option value="2">群发</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">点发类型</td>
								<td>
									<BZ:select prefix="S_" field="PUB_MODE" id="S_PUB_MODE" isCode="true" codeName="DFLX_ALL" formTitle="点发类型" defaultValue=""  width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">病残种类</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">特别关注</td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="特别关注" defaultValue=""  width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" width="10%">姓名</td>
								<td width="15%">
									<BZ:input style="width:100px;height:10px" prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150"/>
								</td>
								<td class="bz-search-title" width="10%">性别</td>
								<td width="15%">
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="性别" defaultValue=""  width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">男</BZ:option>
										<BZ:option value="2">女</BZ:option>
										<BZ:option value="3">两性</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">发布状态</td>
								<td>
									<BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" formTitle="" defaultValue=""  width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="2">已发布</BZ:option>
										<BZ:option value="3">已锁定</BZ:option>
										<BZ:option value="4">已申请</BZ:option>
										
									</BZ:select>
								</td>
								<td class="bz-search-title">预批状态</td>
								<td>
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" formTitle="" defaultValue="" codeName="YPZT" isCode="true" width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">锁定次数</td>
								<td>
									<BZ:input style="width:100px;height:10px" field="LOCK_NUM" prefix="S_" id="S_LOCK_NUM" formTitle="锁定次数" defaultValue=""/> 
								</td>
								<td class="bz-search-title">病残诊断</td>
								<td>
									<BZ:input style="width:100px;height:10px" field="DISEASE_CN" prefix="S_" id="S_DISEASE_CN" formTitle="病残诊断" defaultValue=""/> 
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">发布国家</td>
								<td>
									<BZ:select field="COUNTRY_CODE" notnull="请输入发布国家" formTitle="" defaultValue="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN"  width="168px"
									 onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_PUB_ORGID','S_HIDDEN_PUB_ORGID')">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title">发布组织</td>
								<td>
									<BZ:select prefix="S_" field="PUB_ORGID" id="S_PUB_ORGID" notnull="请输入发布组织" formTitle="" width="168px"
											onchange="_setOrgID('S_HIDDEN_PUB_ORGID',this.value)">
											<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_PUB_ORGID" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>'>
								</td>
								<td class="bz-search-title">锁定国家</td>
								<td>
									<BZ:select field="COUNTRY_CODE2" notnull="请输入锁定国家" formTitle="" defaultValue="" prefix="S_" isCode="true" id="S_COUNTRY_CODE2" codeName="SYS_GJSY_CN"  width="77%;" 
									onchange="_findSyzzNameListForNew('S_COUNTRY_CODE2','S_ADOPT_ORG_ID2','S_HIDDEN_ADOPT_ORG_ID2')">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title">锁定组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID2" id="S_ADOPT_ORG_ID2" notnull="请输入锁定组织" formTitle="" 
											onchange="_setOrgID('S_ADOPT_ORG_ID2',this.value)">
											<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID2" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">出生日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />-
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								<td class="bz-search-title">首次发布日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_START" id="S_PUB_FIRSTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_END\\')}',readonly:true" defaultValue="" formTitle="首次发布日期" />-
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_END" id="S_PUB_FIRSTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_START\\')}',readonly:true" defaultValue="" formTitle="首次发布日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">安置期限</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="SETTLE_DATE_START" id="S_SETTLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SETTLE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="安置期限" />-
									<BZ:input prefix="S_" field="SETTLE_DATE_END" id="S_SETTLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SETTLE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="安置期限" />
								</td>
								<td class="bz-search-title">末次发布日期</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="PUB_LASTDATE_START" id="S_PUB_LASTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_END\\')}',readonly:true" defaultValue="" formTitle="末次发布日期" />-
									<BZ:input prefix="S_" field="PUB_LASTDATE_END" id="S_PUB_LASTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_START\\')}',readonly:true" defaultValue="" formTitle="末次发布日期" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">递交期限</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />-
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
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
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="发&nbsp;&nbsp;布" class="btn btn-sm btn-primary" onclick="_toChoseETForFB()"/>&nbsp;
					<input type="button" value="发布撤销" class="btn btn-sm btn-primary" onclick="_fbcx()"/>&nbsp;
					<input type="button" value="解除锁定" class="btn btn-sm btn-primary" onclick="_jcsd()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls');"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 0.5%;">
									<div class="sorting_disabled">
									</div>
								</th>
								<th style="width: 1%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width:5%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="DISEASE_CN">病残诊断</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="PUB_NUM">发布次数</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_FIRSTDATE">首次发布日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_LASTDATE">末次发布日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_TYPE">发布类型</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="PUB_ORGID">发布组织</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_MODE">点发类型</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SETTLE_DATE">安置期限</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_STATE">发布状态</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ADOPT_ORG_ID">锁定组织</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="LOCK_NUM">锁定次数</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SUBMIT_DATE">递交期限</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RI_STATE">预批状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="resultData" >
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="PUB_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" /></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue=""  onlyValue="true" checkValue="1=男;2=女;3=两性"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL"  length="10"/></td>
								<td><BZ:data field="DISEASE_CN" defaultValue="" length="10"/></td>
								<td><a href="javascript:_showFbHistory('<BZ:data field="CI_ID" defaultValue="" onlyValue="true" />')" title="点击查看该儿童历次发布信息"><BZ:data field="PUB_NUM" defaultValue="" onlyValue="true"/></a></td>
								<td><BZ:data field="PUB_FIRSTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_LASTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_TYPE" defaultValue="" checkValue="1=点发;2=群发" onlyValue="true"/></td>
								<td>
									
										<%
										   Data resultData=(Data)pageContext.getAttribute("resultData");
										   String pubOrgId = resultData.getString("PUB_ORGID");
										  // System.out.println("pub-->"+pubOrgId);
										   if(null!=pubOrgId && !"".equals(pubOrgId)&& pubOrgId.indexOf(",")>0){
										 %>	
										 <a href="javascript:_showFbOrgList('<BZ:data field="PUB_ID" defaultValue="" onlyValue="true" />')" title="点击查看发布组织信息">
										 	群发
										 </a>
										 <%
										   }else{
										 %>
										 	<BZ:data field="PUB_ORGID" defaultValue=""  codeName="SYS_ADOPT_ORG" length="30"/>
										 <% 
										   }
										 %>
									
								</td>
								<td><BZ:data field="PUB_MODE" defaultValue=""  codeName="DFLX_ALL" onlyValue="true"/></td>
								<td><BZ:data field="SETTLE_DATE" defaultValue="" type="Date" onlyValue="true" /></td>
								<td><BZ:data field="PUB_STATE" defaultValue="" onlyValue="true" codeName="FBZT"/></td>
								<td><BZ:data field="ADOPT_ORG_ID" defaultValue="" codeName="SYS_ADOPT_ORG"  onlyValue="true"/></td>
								<td><a href="javascript:_showLockHistory('<BZ:data field="CI_ID" defaultValue="" onlyValue="true" />')" title="点击查看历次锁定记录"><BZ:data field="LOCK_NUM" defaultValue="" onlyValue="true" /></a></td>
								<td><BZ:data field="SUBMIT_DATE" defaultValue="" onlyValue="true" type="Date"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" codeName="YPZT" onlyValue="true" /></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="特需儿童发布列表" exportCode="PROVINCE_ID=CODE,PROVINCE;SN_TYPE=CODE,BCZL;PUB_ORGID=CODE,SYS_ADOPT_ORG;PUB_MODE=CODE,DFLX_ALL;SEX=FLAG,1:男&2:女&3:两性;SPECIAL_FOCUS=FLAG,0:否&1:是;PUB_TYPE=FLAG,1:点发&2:群发;PUB_STATE=CODE,FBZT;PUB_FIRSTDATE=DATE;PUB_LASTDATE=DATE;SETTLE_DATE=DATE;SUBMIT_DATE=DATE" 
							exportField="PROVINCE_ID=省份,15,20;WELFARE_NAME_CN=福利院,20;NAME=儿童姓名,15;SEX=性别,8;SPECIAL_FOCUS=是否特别关注,18;SN_TYPE=病残种类,15;PUB_FIRSTDATE=首次发布日期,18;PUB_LASTDATE=末次发布日期,18;PUB_TYPE=发布类型,15;PUB_ORGID=发布组织,40;PUB_MODE=点发类型,15;SETTLE_DATE=安置期限,15;PUB_STATE=发布状态,15;ADOPT_ORG_ID=锁定组织,25;LOCK_NUM=锁定次数,15;SUBMIT_DATE=递交期限,15;"
							/></td>
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