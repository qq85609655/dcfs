<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: 描述
 * @author xxx   
 * @date 2014-7-30 21:14:53
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
  String TRANSFER_CODE=(String)request.getAttribute("TRANSFER_CODE");
  
  String mannualDeluuid = (String)request.getAttribute("mannualDeluuid");
  if("null".equals(mannualDeluuid) || mannualDeluuid == null){
	    mannualDeluuid = "";
	}
%>
<BZ:html>
	<BZ:head>
		<title>查询列表</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
  $(document).ready(function() {
  //			dyniframesize(['mainFrame']);
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
  });
 
 //显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1100px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function _search(){
     document.srcForm.action=path+"transferManager/MannualArchive.action?page=1";
	 document.srcForm.submit();
  }
  
  function _choice(){
  	
	var num = 0;
	var chioceuuid = [];
	var arrays = document.getElementsByName("abc");
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num] = arrays[i].value;
			num += 1;
		}
	}
	if(num < 1){
		page.alert('请选择要添加移交的文件！');
		return;
	}else{
		if (confirm("确定移交这些文件？")){
			var uuid = chioceuuid.join("#");
			//var TI_ID = document.getElementById("TI_ID").value;
			//var rv = getStr("com.dcfs.ffs.transferManager.TransferManagerAjax", "uuid="+uuid+"&TI_ID="+TI_ID);
			
			opener.refreshLocalList(uuid);
			window.close();
		}
	}
  }

  
  //重置方法自由定义
  function _reset(){
	  document.getElementById("S_COUNTRY_CODE").value = "";
	  document.getElementById("S_ADOPT_ORG_ID").value = "";
	  document.getElementById("S_ARCHIVE_NO").value = "";
	  document.getElementById("S_MALE_NAME").value = "";
	  document.getElementById("S_FEMALE_NAME").value = "";
	  document.getElementById("S_SIGN_DATE_START").value = "";
	  document.getElementById("S_SIGN_DATE_END").value = "";
	  document.getElementById("S_REPORT_DATE_START").value = "";
	  document.getElementById("S_REPORT_DATE_END").value = "";
	  document.getElementById("S_NUM").value = "";
	  
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
  }
  

  </script>
<BZ:body property="data"  codeNames="WJLX;GJSY;SYZZ;AZBGFKCS;SYS_GJSY_CN;">
	<BZ:form name="srcForm" method="post" action="transferManager/MannualArchive.action">
	<input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
	<input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
	<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	<BZ:frameDiv property="clueTo" className="kuangjia">
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								<td class="bz-search-title">档案号</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="档案号" restriction="hasSpecialChar" maxlength="50"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" restriction="hasSpecialChar" maxlength="50"/>
								</td>
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" restriction="hasSpecialChar" maxlength="50"/>
								</td>
								<td class="bz-search-title"></td>
								<td></td>
							</tr>
							<tr>
								<td class="bz-search-title">签批日期</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_SIGN_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" formTitle="起始签批日期"/>~
									<BZ:input prefix="S_" field="SIGN_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_SIGN_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" formTitle="截止签批日期"/>
								</td>
								<td class="bz-search-title">接收日期</td>
								<td>
									<BZ:input prefix="S_" field="REPORT_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REPORT_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REPORT_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
									<BZ:input prefix="S_" field="REPORT_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REPORT_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REPORT_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
								</td>
								<td class="bz-search-title">反馈次数</td>
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="反馈次数" restriction="plusInt" maxlength="50"/>
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
					<input type="button" value="选&nbsp;&nbsp;择" class="btn btn-sm btn-primary" onclick="_choice()"/>	
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width:5%;">
									<div class="sorting_disabled">
										<input name="abcd" type="checkbox" class="ace">
									</div>
								</th>
								<th style="width:5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="ARCHIVE_NO">档案号</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="SIGN_DATE">签批日期</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="REPORT_DATE">报告接收日期</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="NUM">反馈次数</div>
								</th>
							</tr>
						</thead>
						<tbody>	
							<BZ:for property="List">
								<tr class="emptyData">
									<td class="center"><input name="abc" type="checkbox" value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace"></td>
									<td class="center"><BZ:i /></td>
									<td><BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"/></td>
									<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="ARCHIVE_NO" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data type="date" field="SIGN_DATE" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data type="date" field="REPORT_DATE" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="NUM" defaultValue="" onlyValue="true" /></td>
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
							<td><BZ:page form="srcForm" property="List"/></td>
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
