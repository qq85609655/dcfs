<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapproveauditSHB_oneLevel_list.jsp
 * @Description: 审核部预批申请初审列表 
 * @author yangrt
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
		<title>审核部预批申请初审列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	<script>
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
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditListSHB.action?Level=one&page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_ADOPT_ORG_NAME_CN").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_NAME_CN").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_AUD_STATE2").value = "";
			document.getElementById("S_AUD_STATE1").value = "";
			document.getElementById("S_LAST_STATE").value = "";
			document.getElementById("S_ATRANSLATION_STATE").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_PASS_DATE_START").value = "";
			document.getElementById("S_PASS_DATE_END").value = "";
		}
		 
		//审核
		function _audit(){
			var num = 0;
			var ri_id = "";	//预批申请记录id
			var is_focus = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var aud_state = arrays[i].getAttribute("AUD_STATE1");
					var ri_state = arrays[i].getAttribute("RI_STATE");
					if(ri_state == "1" || ri_state == "2"){
						if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
							ri_id = arrays[i].value;
							is_focus = arrays[i].getAttribute("SPECIAL_FOCUS");
							num++;
						}else{
							page.alert('请选择一条审核部状态为经办人待审核或审核中的数据！');
							return;
						}
					}else{
						page.alert('请选择一条预批状态为已提交或审核中的数据！');
						return;
					}
				}
			}
			if(num != "1"){
				page.alert('请选择一条数据！');
				return;
			}else{
				var rau_id = getStr('com.dcfs.sce.preApproveAudit.PreApproveAuditAjax','AUDIT_TYPE=1&AUDIT_LEVEL=0&RI_ID=' + ri_id);
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=0&RI_ID=" + ri_id + "&RAU_ID=" + rau_id + "&SPECIAL_FOCUS=" + is_focus;
				document.srcForm.submit();
			}
		}
		
		//查看
		function _show(type){
			var num = 0;
			var ri_id = "";	//预批申请记录id
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ri_id = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				page.alert('请选择一条数据！');
				return;
			}else{
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?Level=one&RI_ID=" + ri_id + "&type=" + type;
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

	</script>
	<BZ:body property="data" codeNames="PROVINCE;">
		<BZ:form name="srcForm" method="post" action="sce/preapproveaudit/PreApproveAuditListSHB.action?Level=one">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
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
								<td class="bz-search-title" style="width: 12%">收养组织</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:input prefix="S_" field="ADOPT_ORG_NAME_CN" id="S_ADOPT_ORG_NAME_CN" defaultValue="" formTitle="" maxlength="256"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">男收养人</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">女收养人</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">省份</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" defaultValue="" formTitle="" isCode="true" codeName="PROVINCE">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">福利院</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="WELFARE_NAME_CN" id="S_WELFARE_NAME_CN" defaultValue="" formTitle="" maxlength="200"/>
								</td>
								
								<td class="bz-search-title">儿童姓名</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">出生日期</td>
								<td class="bz-search-value" colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								
								<td class="bz-search-title">性别</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">男</BZ:option>
										<BZ:option value="2">女</BZ:option>
										<BZ:option value="3">两性</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">特别关注</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">申请日期</td>
								<td class="bz-search-value" colspan="3">
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">安置部状态</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="AUD_STATE2" id="S_AUD_STATE2" formTitle="" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待审核</BZ:option>
										<BZ:option value="2">审核通过</BZ:option>
										<BZ:option value="3">审核不通过</BZ:option>
										<BZ:option value="4">审核中</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">审核部状态</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="AUD_STATE1" id="S_AUD_STATE1" formTitle="" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">经办人待审核</BZ:option>
										<BZ:option value="1">经办人审核中</BZ:option>
										<BZ:option value="2">部门主任待审核</BZ:option>
										<BZ:option value="3">分管主任待审批</BZ:option>
										<BZ:option value="4">审核不通过</BZ:option>
										<BZ:option value="5">审核通过</BZ:option>
										<BZ:option value="9">退回重审</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">补充状态</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="LAST_STATE" id="S_LAST_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待补充</BZ:option>
										<BZ:option value="1">补充中</BZ:option>
										<BZ:option value="2">已补充</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">补翻状态</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="ATRANSLATION_STATE" id="S_ATRANSLATION_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待翻译</BZ:option>
										<BZ:option value="1">翻译中</BZ:option>
										<BZ:option value="2">已翻译</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">预批状态</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">待审核</BZ:option>
										<BZ:option value="2">审核中</BZ:option>
										<BZ:option value="3">审核不通过</BZ:option>
										<BZ:option value="4">审核通过</BZ:option>
										<BZ:option value="5">未启动</BZ:option>
										<BZ:option value="6">已启动</BZ:option>
										<BZ:option value="7">已匹配</BZ:option>
										<BZ:option value="9">无效</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">通过日期</td>
								<td class="bz-search-value" colspan="3">
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
								
								<td style="text-align: center;" colspan="2">
									<div class="bz-search-button">
										<input type="button" value="搜&nbsp;&nbsp;索" onclick="_search();" class="btn btn-sm btn-primary">
										<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_show('SHBshow')"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">选择</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ADOPT_ORG_NAME_CN">收养组织</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REQ_DATE">申请日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AUD_STATE2">安置部状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AUD_STATE1">审核部状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="LAST_STATE">补充状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ATRANSLATION_STATE">补翻状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RI_STATE">预批状态</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PASS_DATE">通过日期</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
								<%	
									String revoke_state = ((Data)pageContext.getAttribute("myData")).getString("REVOKE_STATE","");
									if("".equals(revoke_state)){
								%>
									<input name="xuanze" type="radio" 
										value="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>" 
										RI_STATE="<BZ:data field="RI_STATE" defaultValue="" onlyValue="true"/>" 
										AUD_STATE1="<BZ:data field="AUD_STATE1" defaultValue="" onlyValue="true"/>" 
										SPECIAL_FOCUS="<BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true"/>"
									class="ace">
								<%	}else{ %>
									<font color="red">撤</font>
								<%	} %>
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true" checkValue="1=男;2=女;3=两性"/></td>
								<td><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/></td>
								<td><BZ:data field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUD_STATE2" defaultValue="" onlyValue="true" checkValue="0=待审核;2=审核通过;3=审核不通过;4=审核中;"/></td>
								<td><BZ:data field="AUD_STATE1" defaultValue="" onlyValue="true" checkValue="0=经办人待审核;1=经办人审核中;2=部门主任待审核;3=分管主任待审批;4=审核不通过;5=审核通过;9=退回重审;"/></td>
								<td><BZ:data field="LAST_STATE" defaultValue="" onlyValue="true" checkValue="0=待补充;1=补充中;2=已补充;"/></td>
								<td><BZ:data field="ATRANSLATION_STATE" defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译;"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" onlyValue="true" checkValue="1=待审核;2=审核中;3=审核不通过;4=审核通过;5=未启动;6=已启动;7=已匹配;9=无效;"/></td>
								<td><BZ:data field="PASS_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page
								form="srcForm" 
								property="List" 
								exportXls="true" 
								exportTitle="预批申请记录"
								exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=FLAG,1:男&2:女&3:两性;BIRTHDAY=DATE;SPECIAL_FOCUS=FLAG,0:否&1:是;REQ_DATE=DATE;AUD_STATE2=FLAG,0:待审核&2:审核通过&3:审核不通过&4:审核中;AUD_STATE1=FLAG,0:经办人待审核&1:经办人审核中&2:部门主任待审核&3:分管主任待审批&4:审核不通过&5:审核通过&9:退回重审;LAST_STATE=FLAG,0:待补充&1:补充中&2:已补充;ATRANSLATION_STATE=FLAG,0:待翻译&1:翻译中&2:已翻译;RI_STATE=FLAG,1:待审核&2:审核中&3:审核不通过&4:审核通过&5:未启动&6:已启动&7:已匹配&9:无效;PASS_DATE=DATE;"
								exportField="ADOPT_ORG_NAME_CN=收养组织,15,20;MALE_NAME=男收养人,15;FEMALE_NAME=女收养人,15;PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,15;NAME=儿童姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;SPECIAL_FOCUS=特别关注,15;REQ_DATE=申请日期,15;AUD_STATE2=安置部状态,15;AUD_STATE1=审核部状态,15;LAST_STATE=补充状态,15;ATRANSLATION_STATE=补翻状态,15;RI_STATE=预批状态,15;PASS_DATE=通过日期,15;"/>
							</td>
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