<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: 儿童材料明细查询页面
 * @author wty   
 * @date 2014-7-29 10:44:22
 * @version V1.0  
 * modify by kings 2014-10-31
 */
  String compositor=(String)request.getAttribute("compositor");
  if(compositor==null){
      compositor="";
  }
  String ordertype=(String)request.getAttribute("ordertype");
  if(ordertype==null){
      ordertype="";
  }
  String TRANSFER_TYPE =(String)request.getAttribute("TRANSFER_TYPE");
  if(TRANSFER_TYPE==null){
	  TRANSFER_TYPE="";
  }
  String TRANSFER_CODE =(String)request.getAttribute("TRANSFER_CODE");
  if(TRANSFER_CODE==null){
	  TRANSFER_CODE="";
  }
  String OPER_TYPE = (String)request.getAttribute("OPER_TYPE");
  if(OPER_TYPE==null){
	  OPER_TYPE="1";
  }
  
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>材料交接明细查询</title>
        <BZ:webScript list="true" isAjax="true" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/child.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
  $(document).ready(function() {
  	//dyniframesize(['mainFrame']);
	  initProvOrg("<%=WELFARE_ID%>");
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
				offset: ['40px' , '10px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"transferManager/detailViewChildinfo.action";
	 document.srcForm.submit();
  }
  
  //重置查询
  function _reset(){
    $("#S_PROVINCE_ID").val("");
    $("#S_WELFARE_ID").val("");
    $("#S_CHILD_NO").val("");
    $("#S_NAME").val("");
    $("#S_SEX").val("");
    $("#S_BIRTHDAY_START").val("");
    $("#S_BIRTHDAY_END").val("");
    $("#S_CHILD_TYPE").val("");
    $("#S_SPECIAL_FOCUS").val("");
    $("#S_TRANSFER_DATE_START").val("");
    $("#S_TRANSFER_DATE_END").val("");
    $("#S_CONNECT_NO").val("");
    $("#S_TRANSFER_STATE").val("");
    $("#S_RECEIVER_DATE_START").val("");
    $("#S_RECEIVER_DATE_END").val("");
  } 

  
  //导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls')
		}else{
			return;
		}
	}	
  </script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;JJMXZT;JSMXZT">
     <BZ:form name="srcForm" method="post" action="transferManager/detailViewChildinfo.action">
     <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	 <input type="hidden" name="OPER_TYPE" id="OPER_TYPE" value="<%=OPER_TYPE%>"/>
	 <div class="page-content">
	 <!-- 查询条件区Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td class="bz-search-title" style="width: 10%">省份</td>
				<td style="width: 15%">
					<BZ:select prefix="S_" id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="150px"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
	 	                <BZ:option value="">--请选择省份--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title" style="width: 10%">福利院</td>
				<td style="width: 15%">
				    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="200px">
		              <BZ:option value="">--请选择福利院--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title" style="width: 10%">儿童编号</td>
				<td style="width: 40%">
					<BZ:input prefix="S_" field="CHILD_NO" id="S_CHILD_NO" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
				</td>
			</tr> 
			<tr>						
				<td class="bz-search-title">姓名</td>
				<td>
					<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
				</td>
				<td class="bz-search-title">性别</td>
				<td>
					<BZ:select prefix="S_" id="S_SEX" field="SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="">
		              <BZ:option value="">--请选择--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title">出生日期</td>
				<td>
					<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" formTitle="起始提交日期" />~ 
					<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" formTitle="截止提交日期" />
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">儿童类型</td>
				<td>
					<BZ:select prefix="S_" id="S_CHILD_TYPE" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="">
		              <BZ:option value="">--请选择--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title">特别关注</td>
				<td>
					<BZ:select prefix="S_" id="S_SPECIAL_FOCUS" field="SPECIAL_FOCUS" formTitle="特别关注" defaultValue="">
		              <BZ:option value="">--请选择--</BZ:option>
		              <BZ:option value="0">否</BZ:option>
		              <BZ:option value="1">是</BZ:option>				              
	                </BZ:select>
				</td>
				<td class="bz-search-title">移交日期</td>
				<td>
					<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
					<BZ:input prefix="S_" field="TRANSFER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">交接单编号</td>
				<td>
					<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="交接单编号" restriction="hasSpecialChar" maxlength="256"/>
				</td>
				<td class="bz-search-title" style="width: 10%"><span title="移交状态">移交状态</span></td>
				<td>
					<%if("1".equals(OPER_TYPE)){ %>
					<BZ:select prefix="S_" id="S_TRANSFER_STATE" field="TRANSFER_STATE" isCode="true" codeName="JJMXZT" formTitle="移交状态" defaultValue="">
		              <BZ:option value="">--请选择--</BZ:option>
	                </BZ:select>
						
					<%} else if("2".equals(OPER_TYPE)){ %>
					<BZ:select prefix="S_" id="S_TRANSFER_STATE" field="TRANSFER_STATE" isCode="true" codeName="JSMXZT" formTitle="移交状态" defaultValue="">
		              <BZ:option value="">--请选择--</BZ:option>
	                </BZ:select>
					<%} %>
				</td>
				<td class="bz-search-title">接收日期</td>
				<td>
					<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
					<BZ:input prefix="S_" field="RECEIVER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
				</td>
			</tr>
			<tr style="height: 5px;"></tr>
			<tr>
				<td style="text-align: center;" colspan="6">
					<div class="bz-search-button">
						<input type="button" value="搜&nbsp;&nbsp;索" onclick="search();" class="btn btn-sm btn-primary">
						<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
					</div>
				</td>				
			</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
     <div class="wrapper">
     <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <!-- 功能按钮操作区Start -->
	 <div class="table-row table-btns" style="text-align: left">
		<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
		<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="window.close()"/>&nbsp;			
	</div>
	<div class="blue-hr"></div>
	<!-- 功能按钮操作区End -->
	
		
		<!--查询结果列表区Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th style="width:3%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="CHILD_NO">儿童编号</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="PROVINCE_ID">省份</div>
						</th>
						<th style="width:15%;">
							<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NAME">姓名</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="SEX">性别</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="BIRTHDAY">出生日期</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="CHILD_TYPE">儿童类型</div>
						</th>								
						<th style="width:5%;">
							<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
						</th>
						<th>
							<div class="sorting" id="CONNECT_NO">交接单编号</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="TRANSFER_DATE">移交日期</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="RECEIVER_DATE">接收日期</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="TRANSFER_STATE">移交状态</div>
						</th>
					</tr>
					</thead>
					<tbody>
						<%if("1".equals(OPER_TYPE)){ %>	
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="CHILD_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="ETXB" field="SEX"  defaultValue="" onlyValue="true"/></td>								
								<td style="text-align:center"><BZ:data field="BIRTHDAY" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS"  defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
								<td style="text-align:center"><BZ:data field="CONNECT_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data codeName="JJMXZT" field="TRANSFER_STATE" defaultValue="" onlyValue="true"/></td>								
							</tr>
						</BZ:for>
						<%}else { %>
							<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="CHILD_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="ETXB" field="SEX"  defaultValue="" onlyValue="true"/></td>								
								<td style="text-align:center"><BZ:data field="BIRTHDAY" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS"  defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
								<td style="text-align:center"><BZ:data field="CONNECT_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_STATE" codeName="JSMXZT" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						<%} %>
					</tbody>
				</table>
			</div>
		<!--查询结果列表区End -->
		<!--分页功能区Start -->
		<div class="footer-frame">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="材料交接明细" 
					exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SPECIAL_FOCUS=FLAG,0:否&1:是;TRANSFER_DATE=DATE;RECEIVER_DATE=DATE;TRANSFER_STATE=CODE,JJMXZT;" 
					exportField="CHILD_NO=儿童编号,15,20;PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,30;NAME=姓名,15;SEX=性别,10;BIRTHDAY=出生日期,10;CHILD_TYPE=儿童类型,10;SPECIAL_FOCUS=特别关注,15;CONNECT_NO=交接单编号,15;TRANSFER_DATE=移交日期,15;RECEIVER_DATE=接收日期,15;TRANSFER_STATE=移交状态,10"/></td>				
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
		</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>
