<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: 文件明细查询页面
 * @author xxx   
 * @date 2014-7-29 10:44:22
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
  String TRANSFER_TYPE =(String)request.getAttribute("TRANSFER_TYPE");
  if(TRANSFER_TYPE==null){
	  TRANSFER_TYPE="";
  }
  String TRANSFER_CODE =(String)request.getAttribute("TRANSFER_CODE");
  if(TRANSFER_CODE==null){
	  TRANSFER_CODE="";
  }
  String oper_type = (String)request.getAttribute("OPER_TYPE");
  if(oper_type==null){
	  oper_type="1";
  }

	String sbcode = TRANSFER_CODE.substring(0,1);
	boolean tw_flag = false ;
	if(sbcode!=null&&"5".equals(sbcode)){
		tw_flag = true;
	}
%>
<BZ:html>
	<BZ:head>
		<title>文件交接明细查询</title>
        <BZ:webScript list="true"/>
        <script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
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
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"transferManager/detailView.action";
	 document.srcForm.submit();
  }
  
  //重置方法自由定义
  function _reset(){
  	$("#S_COUNTRY_CODE").val("");
  	$("#S_ADOPT_ORG_ID").val("");
  	$("#S_REGISTER_DATE_START").val("");
  	$("#S_REGISTER_DATE_END").val("");
  	$("#S_MALE_NAME").val("");
  	$("#S_FEMALE_NAME").val("");
  	$("#S_TRANSFER_DATE_START").val("");
  	$("#S_TRANSFER_DATE_END").val("");
  	$("#S_FILE_NO").val("");
  	$("#S_CONNECT_NO").val("");
  	$("#S_FILE_TYPE").val("");
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
<BZ:body property="data" codeNames="JJMXZT;WJLX;GJSY;JSMXZT;SYS_GJSY_CN;TWCZFS_ALL;TWLX" onload="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');">
     <BZ:form name="srcForm" method="post" action="transferManager/detailView.action">
		 <input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
		 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	 <div class="page-content">
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	 </BZ:frameDiv>
	 <!-- 查询条件区Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
						  <tr>
							<td class="bz-search-title" style="width: 15%">国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家</td>
							<td style="width: 10%">
								<BZ:select field="COUNTRY_CODE" formTitle=""
									prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
									onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--请选择--
									</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="收养组织">收养组织</span></td>
							<td style="width: 10%">
								<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
										onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							
							
							</td>
							<td class="bz-search-title" style="width: 15%"><span title="收文日期">收文日期</span></td>
							<td style="width: 40%">									
										<BZ:input prefix="S_" field="REGISTER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
										<BZ:input prefix="S_" field="REGISTER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title" style="width: 15%"><span title="男收养人">男收养人</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 10%"><span title="女收养人">女收养人</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 15%"><span title="移交时间">移交时间</span></td>
							<td style="width: 40%">
										<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
										<BZ:input prefix="S_" field="TRANSFER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title" style="width: 15%"><span title="文件编号">文件编号</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="文件编号" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 10%"><span title="交接单编号">交接单编号</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="交接单编号" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 15%"><span title="接收时间">接收时间</span></td>
							<td style="width: 40%">
										<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="起始提交日期"/>~
										<BZ:input prefix="S_" field="RECEIVER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="截止提交日期"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title" style="width: 15%"><span title="文件类型">文件类型</span></td>
							<td style="width: 10%">
										<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="文件类型" defaultValue="" >
										<BZ:option value="">--请选择--</BZ:option>
										</BZ:select>
										</td>
							<td class="bz-search-title" style="width: 10%"><span title="移交状态">移交状态</span></td>
							<td style="width: 10%">
								<BZ:select prefix="S_"  field="TRANSFER_STATE"  size="1" formTitle="移交状态" id="S_TRANSFER_STATE">
									<%if("1".equals(oper_type)){ %>
									<option value="" selected>--请选择--</option>
									<option value="'0'" title="未移交">未移交</option>
									<option value="'1'" title="拟移交">拟移交</option>
									<option value="'2'" title="已移交">已移交</option>
									<option value="'3'" title="已接收">已接收</option>
									<%} else if("2".equals(oper_type)){ %>
									<option value="" selected>--请选择--</option>
									<option value="'2'" title="待接收" >待接收</option>
									<option value="'3'" title="已接收" >已接收</option>
									<%} %>
								</BZ:select>
							</td>
										
							<td class="bz-search-title" style="width: 15%"><span title="接收时间"></span></td>
							<td style="width: 40%">
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
						<th class="center" style="width:2%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:3%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="COUNTRY_CN">国家</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="NAME_CN">收养组织</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="FILE_NO">文件编号</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="REGISTER_DATE">收文日期</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="MALE_NAME">男收养人</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="FEMALE_NAME">女收养人</div>
						</th>
						<%if(tw_flag){ %>
						<th style="width:5%;">
							<div class="sorting" id="APPLE_TYPE">退文类型</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="HANDLE_TYPE">退文处置方式</div>
						</th>
						<%}%>
						<th style="width:10%;">
							<div class="sorting" id="CONNECT_NO">交接单编号</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="TRANSFER_DATE">移交日期</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="RECEIVER_DATE">接收日期</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="TRANSFER_STATE">移交状态</div>
						</th>
					</tr>
					</thead>
					<tbody>
						<%if("1".equals(oper_type)){ %>	
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="TI_ID" onlyValue="true"/>#<BZ:data field="AT_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<%if(tw_flag){ %>
								<td><BZ:data field="APPLE_TYPE"  defaultValue="" codeName="TWLX" onlyValue="true"/></td>
								<td><BZ:data field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" onlyValue="true"/></td>
								<%}%>
								<td><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_STATE" codeName="JJMXZT" defaultValue="" onlyValue="true"/></td>
								
							</tr>
						</BZ:for>
						<%}else { %>
							<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="TI_ID" onlyValue="true"/>#<BZ:data field="AT_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<%if(tw_flag){ %>
								<td><BZ:data field="APPLE_TYPE"  defaultValue="" codeName="TWLX" onlyValue="true"/></td>
								<td><BZ:data field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" onlyValue="true"/></td>
								<%}%>
								<td><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
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
					<td>
					<BZ:page form="srcForm" property="List"exportXls="true" exportTitle="文件交接明细" 
					exportCode="TRANSFER_STATE=CODE,JSMXZT;" 
					exportField="COUNTRY_CN=国家,15,20;NAME_CN=收养组织,25;FILE_NO=文件编号,15;REGISTER_DATE=收文日期,25;MALE_NAME=男收养人,25;FEMALE_NAME=女收养人,25;CONNECT_NO=交接单编号,20;TRANSFER_DATE=移交日期,25;CONNECT_NO=交接单编号,20;TRANSFER_DATE=移交日期,25;RECEIVER_DATE=接收日期,25;TRANSFER_STATE=移交状态,15"/>
					</td>
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
		</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>
