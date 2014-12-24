<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
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
	Data da = (Data)request.getAttribute("data");
    String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料更新选择列表(中心)</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
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
				area: ['1000px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			//判断输入的更新次数是否有效
			var updateNum=document.getElementById("S_UPDATE_NUM").value;
			var intNum=parseInt(updateNum);
			if(updateNum!=""){
				var r=/^\+?[1-9][0-9]*$/;
				if(!r.test(updateNum)){
					 alert("更新次数输入无效！");
					 return;
					}
				}
			document.srcForm.action=path+"cms/childupdate/updateSelectZX.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_CHECKUP_DATE_START").value = "";
			document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_UPDATE_NUM").value = "";
			document.getElementById("S_PUB_STATE").value = "";
			document.getElementById("S_ADREG_STATE").value = "";
			document.getElementById("S_RI_STATE").value = "";
		}	
		//更新儿童材料
		function _toUpdate(){
			var CI_ID = "";
			var UPDATE_STATE="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					 CI_ID =arrays[i].value.split("#")[0];
					 UPDATE_STATE=arrays[i].value.split("#")[2];
					 break;
				}
			}
			if(CI_ID== ""){
				page.alert("请选择要更新的材料！");
				return;
			}else{
				if(UPDATE_STATE=="<%=ChildStateManager.CHILD_UPDATE_STATE_WTJ%>"||UPDATE_STATE=="<%=ChildStateManager.CHILD_UPDATE_STATE_SDS%>"||UPDATE_STATE=="<%=ChildStateManager.CHILD_UPDATE_STATE_ZXDS%>"){
				  alert("该儿童材料已存在更新申请,请重新选择");
				  return;
				}
				document.srcForm.action=path+"cms/childupdate/toUpdateFLY.action?CI_ID="+CI_ID+"&UPDATE_TYPE=3";
			    document.srcForm.submit();
			}
		}
		//列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
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
		function showChildInfo(obj){
			url = path+"/cms/childManager/showForAZQ.action?UUID="+obj.name;
			_open(url, "儿童材料信息", 1000, 600);
			
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;BCZL;FBZT;YPZT">
		<BZ:form name="srcForm" method="post" action="cms/childupdate/updateSelectZX.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
							    <td class="bz-search-title" style="width: 8%">省份</td>
								<td style="width: 16%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</td>
								<td style="width: 10%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 85%"/>
								</td>
								
								<td class="bz-search-title" style="width: 8%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
								<td style="width: 8%">
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">出生日期</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >福利院</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title">病残种类</td>
								<td>
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title" >特别关注</td>
								<td >
								    <BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
									</BZ:select>
								</td>	
								
								<td class="bz-search-title">体检日期</td>
								<td>
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始体检日期" />~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止体检日期" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">更新次数</td>
								<td>
									<BZ:input prefix="S_" field="UPDATE_NUM" id="S_UPDATE_NUM" defaultValue="" className="inputOne" formTitle="更新次数" />
								</td>
								
								<td class="bz-search-title">发布状态</td>
								<td >
								    <BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" isCode="true" codeName="FBZT" formTitle="发布状态" defaultValue="" width="95%" >
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">登记状态</td>
								<td >
								    <BZ:select prefix="S_" field="ADREG_STATE" id="S_ADREG_STATE"  formTitle="登记状态" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">未登记</BZ:option>
										<BZ:option value="1">已登记</BZ:option>
										<BZ:option value="2">无效登记</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title">申请状态</td>
								<td >
								    <BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" isCode="true" codeName="YPZT" formTitle="申请状态" defaultValue="" width="40%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
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
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="更&nbsp;&nbsp;新" class="btn btn-sm btn-primary" onclick="_toUpdate();"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive" style="overflow-x:auto;">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table" >
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="CHECKUP_DATE">体检日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="UPDATE_NUM">更新次数</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="LAST_UPDATE_DATE">末次更新日期</div>
								</th>
								<th  style="width: 7%;">
									<div class="sorting" id="PUB_STATE">发布状态</div>
								</th>
								<th  style="width: 7%;">
									<div class="sorting" id="RI_STATE">申请状态</div>
								</th>
								<th  style="width: 7%;">
									<div class="sorting" id="ADREG_STATE">登记状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input type="radio" name="xuanze" value='<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="CHILD_TYPE" onlyValue="true"/>#<BZ:data field="UPDATE_STATE" onlyValue="true"/>' />
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><a onclick="showChildInfo(this);" name='<BZ:data field="CI_ID" onlyValue="true"/>'><BZ:data field="NAME" defaultValue="" onlyValue="true"/></a></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHECKUP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_NUM" defaultValue=""  onlyValue="true"/></td>
								<td class="center"><BZ:data field="LAST_UPDATE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PUB_STATE" defaultValue="" codeName="FBZT" onlyValue="true"/></td>
							    <td class="center"><BZ:data field="RI_STATE" defaultValue="" codeName="YPZT" onlyValue="true"/></td>
							    <td class="center"><BZ:data field="ADREG_STATE" defaultValue="" checkValue="0=未登记;1=已登记;2=无效登记" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="超期查询" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHECKUP_DATE=DATE;SN_TYPE=CODE,BCZL;SPECIAL_FOCUS=FLAG,0:否&1:是;LAST_UPDATE_DATE=DATE;PUB_STATE=CODE,FBZT;RI_STATE=CODE,YPZT;ADREG_STATE=FLAG,0:未登记&1:已登记&2:无效登记;" exportField="PROVINCE_ID=省份,15,20;WELFARE_NAME_CN=福利院,18;NAME=姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;CHECKUP_DATE=体检日期,15;SN_TYPE=病残种类,20;SPECIAL_FOCUS=特别关注,10;UPDATE_NUM=更新次数,10;LAST_UPDATE_DATE=末次更新日期,15;PUB_STATE=发布状态,15;RI_STATE=申请状态,15;ADREG_STATE=登记状态,15;"/></td>
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