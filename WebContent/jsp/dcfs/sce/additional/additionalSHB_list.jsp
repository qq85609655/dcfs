<%
/**   
 * @Title: additionalSHB_list.jsp
 * @Description: 审核部预批补充查询列表
 * @author yangrt
 * @date 2014-9-11下午5:02:21
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
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
		<title>预批补充查询列表</title>
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
				area: ['1050px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/additional/findAddList.action?type=SHB&page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
		}
		
		//查看预批补充明细
		function _addShow(){
			var num = 0;
			var ra_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ra_id = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要查看的数据！");
				return;
			}else{
				window.open(path+"sce/additional/showNotice.action?showuuid=" + ra_id,"newwindow","height=350,width=1000,top=150,left=180,scrollbars=yes");
			}
		}
		
		//审核
		function _addAudit(){
			var num = 0;
			var ri_id = "";
			var aud_state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("AA_STATUS");	//预批补充状态
					if(state == "2"){
						aud_state = arrays[i].getAttribute("AUD_STATE1");
						if(aud_state != "2"){
							page.alert("该预批记录已经审核过了，不能重复审核！");
							return
						}else{
							var TRANS_FLAG = arrays[i].getAttribute("TRANS_FLAG");
							if(TRANS_FLAG != "1"){
								ri_id = arrays[i].getAttribute("RI_ID");
								num++;
							}else{
								page.alert("该预批补充记录翻译之后才能进行预批审核！");
								return
							}
						}
					}else{
						page.alert("请选择补充状态为已补充的进行审核！");
						return;
					}
				}
			}
			if(num != "1"){
				page.alert("请选择一条要审核的数据！");
				return;
			}else{
				var data = getData('com.dcfs.sce.additional.AdditionalAjax','OperType=SHB&ri_id=' + ri_id + "&aud_state=" + aud_state);
				var rau_id = data.getString("RAU_ID");
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=0&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
				document.srcForm.submit();
				/* if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
					document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=0&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
					document.srcForm.submit();
				}else if(aud_state == "2"){
					document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=1&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
					document.srcForm.submit();
				}else if(aud_state == "3"){
					document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=2&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
					document.srcForm.submit();
				}else if(aud_state == "4"){
					page.alert("该文件已经审核未通过，不能进行再次审核！");
				}else if(aud_state == "5"){
					page.alert("该文件已经审核通过，不能进行再次审核！");
				} */
			}
		}
		
		//预批补充查询列表导出
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
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;">
		<BZ:form name="srcForm" method="post" action="sce/additional/findAddList.action?type=SHB">
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
								<td class="bz-search-title">姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" >省份</td>
								<td>
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="" width="148px">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">福利院</td>
								<td>
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="60%">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">通知日期</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始补充通知日期" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止补充通知日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								
								<td class="bz-search-title">反馈日期</td>
								<td>
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始反馈日期" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止反馈日期" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">补充状态</td>
								<td>
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" formTitle="补充状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待补充</BZ:option>
										<BZ:option value="1">补充中</BZ:option>
										<BZ:option value="2">已补充</BZ:option>
									</BZ:select>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td class="bz-search-title">申请日期</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止申请日期" />
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
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_addShow()"/>&nbsp;
					<!-- <input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_addAudit()"/>&nbsp; -->
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									&nbsp;
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="ADOPT_ORG_NAME_CN">收养组织</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">男方</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">女方</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REQ_DATE">申请日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICE_DATE">通知日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FEEDBACK_DATE">反馈日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AA_STATUS">补充状态</div>
								</th>
								<!-- <th style="width: 6%;">
									<div class="sorting" id="AUD_STATE1">审核状态</div>
								</th> -->
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" 
										value="<BZ:data field="RA_ID" defaultValue="" onlyValue="true"/>" 
										AA_STATUS="<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>"
										AUD_STATE1="<BZ:data field="AUD_STATE1" defaultValue="" onlyValue="true"/>"
									 	RI_ID="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>"
									 	TRANS_FLAG="<BZ:data field="TRANS_FLAG" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME" defaultValue="" onlyValue="true"/>（同胞）
									<%}else{%><BZ:data field="NAME" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REQ_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FEEDBACK_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充;" onlyValue="true"/></td>
								<%-- <td><BZ:data field="AUD_STATE1" defaultValue="" checkValue="0=经办人待审核;1=经办人审核中;2=部门主任待审核;3=分管主任待审批;4=审核不通过;5=审核通过;9=退回重审;" onlyValue="true"/></td> --%>
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
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="预批补充查询信息" 
									exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;REQ_DATE=DATE;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE;AA_STATUS=FLAG,0:待补充&1:补充中&2:已补充;" 
									exportField="PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,15;NAME=姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;ADOPT_ORG_NAME_CN=收养组织,15;MALE_NAME=男方,15;FEMALE_NAME=女方,15;REQ_DATE=申请日期,15;NOTICE_DATE=通知日期,15;FEEDBACK_DATE=反馈日期,15;AA_STATUS=补充状态,15;"/></td>
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