<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	* @Title: addTranslationAZB_list.jsp
	* @Description: 安置部预批补翻查询列表
	* @author panfeng   
	* @date 2014-9-19 9:12:01 
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
	String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>预批补翻查询列表</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
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
				area: ['1050px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/addTranslation/addTranslationList.action?type=AZB&page=1";
			document.srcForm.submit();
		}
		 
		function _show(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].getAttribute("TRANSLATION_STATE");
				if(arrays[i].checked){
					if(state == "1" || state == "2"){
						showuuid = arrays[i].value.split("#")[0];
						num += 1;
					}else{
						page.alert("只能选择查看翻译中和已翻译的信息！");
						return;
					}
				}
			}
			if(num != "1"){
				page.alert("请选择一条要查看的数据！");
				return;
			}else{
				url = path+"/sce/addTranslation/addTranslationShow.action?showuuid="+showuuid;
				_open(url, "预批补翻信息", 1000, 460);
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
					aud_state = arrays[i].getAttribute("AUD_STATE2");
					if(aud_state != "1"){
						page.alert("该预批记录已经审核过了，不能重复审核！");
						return
					}else{
						ri_id = arrays[i].getAttribute("RI_ID");
						num++;
					}
				}
			}
			if(num != "1"){
				page.alert("请选择一条要审核的数据！");
				return;
			}else{
				var data = getData('com.dcfs.sce.additional.AdditionalAjax','OperType=AZB&ri_id=' + ri_id);
				var rau_id = data.getString("RAU_ID");
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=AZBadd&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
				document.srcForm.submit();
			}
		}
	
		//预批补翻查询列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
	  
		//检索条件重置
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_COMPLETE_DATE_START").value = "";
			document.getElementById("S_COMPLETE_DATE_END").value = "";
			document.getElementById("S_TRANSLATION_UNITNAME").value = "";
			document.getElementById("S_TRANSLATION_STATE").value = "";
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
		<BZ:form name="srcForm" method="post" action="/sce/addTranslation/addTranslationList.action?type=AZB">
		<BZ:frameDiv property="clueTo" className="kuangjia">
     
	    <!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
		<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="dispatchuuid" id="dispatchuuid" value="" />
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="" />
								</td>	
								
								<td class="bz-search-title" >省份</td>
								<td>
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">福利院</td>
								<td>
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="60%">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					                </BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女方" maxlength="" />
								</td>
								<td class="bz-search-title">翻译状态</td>
								<td>
									<BZ:select prefix="S_" field="TRANSLATION_STATE" id="S_TRANSLATION_STATE" formTitle="翻译状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待翻译</BZ:option>
										<BZ:option value="1">翻译中</BZ:option>
										<BZ:option value="2">已翻译</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">补翻日期</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始补充通知日期" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止补充通知日期" />
								</td>
							</tr>
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
								
								<td class="bz-search-title">完成日期</td>
								<td>
									<BZ:input prefix="S_" field="COMPLETE_DATE_START" id="S_COMPLETE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始反馈日期" />~
									<BZ:input prefix="S_" field="COMPLETE_DATE_END" id="S_COMPLETE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止反馈日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">翻译单位</td>
								<td>
									<BZ:input prefix="S_" field="TRANSLATION_UNITNAME" id="S_TRANSLATION_UNITNAME" defaultValue="" formTitle="翻译单位" maxlength=""/>
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
			<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
			<!-- <input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_addAudit()"/>&nbsp; -->
			<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- 功能按钮操作区End -->
		
		<!--查询结果列表区Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th class="center" style="width:2%;">
							<div>&nbsp;</div>
						</th>
						<th style="width:4%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:12%;">
							<div class="sorting" id="MALE_NAME">男收养人</div>
						</th>
						<th style="width:12%;">
							<div class="sorting" id="FEMALE_NAME">女收养人</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="PROVINCE_ID">省份</div>
						</th>
						<th style="width:13%;">
							<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NAME">儿童姓名</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="SEX">性别</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NOTICE_DATE">补翻日期</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="COMPLETE_DATE">完成日期</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSLATION_UNITNAME">翻译单位</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="TRANSLATION_STATE">翻译状态</div>
						</th>
						<!-- <th style="width:6%;">
							<div class="sorting" id="AUD_STATE2">审核状态</div>
						</th> -->
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" 
										value="<BZ:data field="AT_ID" defaultValue="" onlyValue="true"/>"
										TRANSLATION_STATE="<BZ:data field="TRANSLATION_STATE" onlyValue="true"/>"
										AUD_STATE2="<BZ:data field="AUD_STATE2" defaultValue="" onlyValue="true"/>"
										RI_ID="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>"
									class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID"  codeName="PROVINCE"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME" defaultValue="" onlyValue="true"/>（同胞）
									<%}else{%><BZ:data field="NAME" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td><BZ:data field="SEX"  codeName="ETXB" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COMPLETE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSLATION_UNITNAME"  defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
								<%-- <td><BZ:data field="AUD_STATE2" defaultValue="" checkValue="0=待审核;1=审核中;3=审核通过;2=审核不通过;" onlyValue="true"/></td> --%>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="预批补翻查询信息" 
						exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;NOTICE_DATE=DATE;COMPLETE_DATE=DATE;TRANSLATION_STATE=FLAG,0:待翻译&1:翻译中&2:已翻译;" 
						exportField="MALE_NAME=男方,15;FEMALE_NAME=女方,15;PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,15;NAME=姓名,15;SEX=性别,15;NOTICE_DATE=补翻日期,15;COMPLETE_DATE=完成日期,15;TRANSLATION_UNITNAME=翻译单位,15;TRANSLATION_STATE=翻译状态,15;"/></td>
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
