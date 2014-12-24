<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: 安置部点发退回列表
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
%>
<BZ:html>
	<BZ:head>
		<title>点发退回列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
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
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//导出
		function _export(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//查看
		function _detail(){
			var num = 0;
			var ids="";
			var id ="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					id=ids.split(",")[0];
					num += 1;
				}
			}
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
			   document.srcForm.action=path+"record/PUBCheck.action?id="+id;
			   document.srcForm.submit();
			}
		}
		//确认
		function _confirm(){
			var num = 0;
			var ids="";
			var id = "" ;
			var state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					id+= ids.split(",")[0]+",";
					state = ids.split(",")[1];
					if(state!=0){
						num+=1;
						page.alert('请选择待确认的数据');
						return ;
					}
				}
			}
			if(num!=0){
				return ;
			}else{
			    document.srcForm.action=path+"record/PUBConfirm.action?id="+id;
			    document.srcForm.submit();
			}
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"record/PUBRecordList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("C_PROVINCE_ID").value = "";
			document.getElementById("C_WELFARE_NAME_CN").value = "";
			document.getElementById("C_NAME").value = "";
			document.getElementById("C_SEX").value = "";
			document.getElementById("C_BIRTHDAY_START").value = "";
			document.getElementById("C_BIRTHDAY_END").value = "";
			document.getElementById("C_SN_TYPE").value = "";
			document.getElementById("C_SPECIAL_FOCUS").value = "";
			document.getElementById("C_PUB_DATE_START").value = "";
			document.getElementById("C_PUB_DATE_END").value = "";
			document.getElementById("C_PUB_MODE").value = "";
			document.getElementById("C_RETURN_TYPE").value = "";
			document.getElementById("C_PUB_ORGID").value = "";
			document.getElementById("C_RETURN_DATE_START").value = "";
			document.getElementById("C_RETURN_DATE_END").value = "";
			document.getElementById("C_RETURN_CFM_DATE_START").value = "";
			document.getElementById("C_RETURN_CFM_DATE_END").value = "";
			document.getElementById("C_RETURN_STATE").value = "";
			document.getElementById("C_PUB_TYPE").value = "";
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;">
		<BZ:form name="srcForm"  method="post" action="record/PUBRecordList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">省份</td>
								<td style="width: 18%;">
									<BZ:select prefix="C_" field="PROVINCE_ID" id="C_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="省份" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">福利院</td>
								<td style="width: 28%;">
									<BZ:input prefix="C_" field="WELFARE_NAME_CN" id="C_WELFARE_NAME_CN" defaultValue="" formTitle="福利院" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">姓名</td>
								<td style="width: 28%;">
									<BZ:input prefix="C_" field="NAME" id="C_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="C_" field="SEX" id="C_SEX" isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">病残种类</td>
								<td>
									<BZ:select prefix="C_" field="SN_TYPE" id="C_SN_TYPE" isCode="true" codeName="BCZL"  formTitle="病残种类" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">特别关注</td>
								<td>
									<BZ:select prefix="C_" field="SPECIAL_FOCUS" id="C_SPECIAL_FOCUS"  formTitle="特别关注" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">点发类型</td>
								<td>
									<BZ:select prefix="C_" field="PUB_MODE" id="C_PUB_MODE" isCode="true" codeName="DFLX"  formTitle="点发类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">退回类型</td>
								<td>
									<BZ:select prefix="C_" field="RETURN_TYPE" id="C_RETURN_TYPE" isCode="true" codeName="TXRTFBTHLX"  formTitle="退回类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">退回组织</td>
								<td>
									<BZ:input prefix="C_" field="PUB_ORGID" id="C_PUB_ORGID" defaultValue="" formTitle="退回组织" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">出生日期</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="BIRTHDAY_START" id="C_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="C_" field="BIRTHDAY_END" id="C_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								<td class="bz-search-title">发布日期</td>
								<td>
									<BZ:input prefix="C_" field="PUB_DATE_START" id="C_PUB_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_PUB_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始发布日期" />~
									<BZ:input prefix="C_" field="PUB_DATE_END" id="C_PUB_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_PUB_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止发布日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">退回日期</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="RETURN_DATE_START" id="C_RETURN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始退回日期" />~
									<BZ:input prefix="C_" field="RETURN_DATE_END" id="C_RETURN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止退回日期" />
								</td>
								<td class="bz-search-title">确认日期</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_START" id="C_RETURN_CFM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始确认日期" />~
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_END" id="C_RETURN_CFM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止确认日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">退回状态</td>
								<td>
									<BZ:select prefix="C_" field="RETURN_STATE" id="C_RETURN_STATE" formTitle="退回状态" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待确认</BZ:option>
										<BZ:option value="1">已确认</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">发布类型</td>
								<td>
									<BZ:select prefix="C_" field="PUB_TYPE" id="C_PUB_TYPE" formTitle="发布类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">点发</BZ:option>
										<BZ:option value="2">群发</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"></td>
								<td></td>
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
					<input type="button" value="确&nbsp;&nbsp;认" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;"  adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PUB_DATE">发布日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PUB_MODE">点发类型</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="RETURN_TYPE">退回类型</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="RETURN_USERNAME">退回组织</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_DATE">退回日期</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_CFM_DATE">确认日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RETURN_STATE">退回状态</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_TYPE">发布类型</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="PUB_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="RETURN_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是;" onlyValue="true"/></td>
								<td><BZ:data field="PUB_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_MODE" defaultValue="" codeName="DFLX" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_TYPE" defaultValue="" codeName="TXRTFBTHLX" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_CFM_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=待确认;1=已确认;" onlyValue="true"/></td>
								<td><BZ:data field="PUB_TYPE" defaultValue="" checkValue="1=点发;2=群发;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="点发退回记录" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;SN_TYPE=CODE,BCZL;SPECIAL_FOCUS=FLAG,0:否&1:是;PUB_DATE=DATE;PUB_MODE=CODE,DFLX;RETURN_TYPE=CODE,TXRTFBTHLX;PUB_ORGID=CODE,SYZZ;RETURN_DATE=DATE;RETURN_CFM_DATE=DATE;RETURN_STATE=FLAG,0:待确认&1:已确认;" exportField="PROVINCE_ID=省份,15,20;WELFARE_NAME_CN=福利院,15;NAME=姓名,15;SEX=性别,15;BIRTHDAY=出生日期,15;SN_TYPE=病残种类,15;SPECIAL_FOCUS=特别关注,15;PUB_DATE=发布日期,15;PUB_MODE=点发类型,15;RETURN_TYPE=退回类型,15;PUB_ORGID=退回组织,15;RETURN_DATE=退回日期,15;RETURN_CFM_DATE=确认日期,15;RETURN_STATE=退回状态,15;"/>
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