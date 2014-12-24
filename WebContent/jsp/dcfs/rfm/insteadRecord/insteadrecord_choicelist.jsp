<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: insteadrecord_choicelist.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-9-23 上午9:03:08 
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
		<title>退文代录选择文件列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','180px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"rfm/insteadRecord/returnChoiceList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_AF_POSITION").value = "";
			document.getElementById("S_AF_GLOBAL_STATE").value = "";
			document.getElementById("S_MATCH_STATE").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
		}
		
		//进入退文代录确认页面
		function _confirm(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				var ci_id = arrays[i].value.split("#")[2];
				var ri_state = arrays[i].value.split("#")[3];
				if(arrays[i].checked){
					if(state!="null"&&ci_id!="null"){
						alert("该文件已有匹配信息，请先解除匹配，再进行退文操作！");
						return;
					}else if(ri_state!="9"&&ci_id!="null"){
						alert("该文件已有预批信息，请先撤销预批，再进行退文操作！");
						return;
					}else{
						showuuid = arrays[i].value.split("#")[0];
						num ++;
					}
				}
			}
			if(num != "1"){
				alert('请选择一条数据');
				return;
			}else{
				document.srcForm.action=path+"rfm/insteadRecord/confirmShow.action?showuuid="+showuuid;
				document.srcForm.submit();
			}
		}
		
		
		
		//返回退文信息列表
		function _goback(){
			window.location.href=path+'rfm/insteadRecord/insteadRecordList.action';
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;SYZZ;WJWZ;WJQJZT_ZX">
		<BZ:form name="srcForm" method="post" action="rfm/insteadRecord/returnChoiceList.action">
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
								<td class="bz-search-title" style="width: 10%">收文编号</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">文件类型</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="文件类型" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">收文日期</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">文件位置</td>
								<td>
									<BZ:select prefix="S_" field="AF_POSITION" id="S_AF_POSITION" isCode="true" codeName="WJWZ" formTitle="" defaultValue="" width="84%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">文件状态</td>
								<td>
									<BZ:select prefix="S_" field="AF_GLOBAL_STATE" id="S_AF_GLOBAL_STATE" isCode="true" codeName="WJQJZT_ZX" formTitle="" defaultValue="" width="84%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">选配状态</td>
								<td>
									<BZ:select prefix="S_" field="MATCH_STATE" id="S_MATCH_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待匹配</BZ:option>
										<BZ:option value="1">已匹配</BZ:option>
									</BZ:select>
								</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
					<font color="red">注：文件已匹配孩子的，需先解除匹配，再进行退文操作！</font>
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
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="REGISTER_DATE">收文日期</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ADOPT_ORG_ID">收养组织</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_TYPE">文件类型</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="AF_POSITION">文件位置</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REG_STATE">文件状态</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MATCH_STATE">选配状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="MATCH_STATE" onlyValue="true"/>#<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="RI_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" defaultValue="" codeName="WJWZ" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AF_GLOBAL_STATE" defaultValue="" codeName="WJQJZT_ZX" onlyValue="true"/></td>
								<td class="center"><BZ:data field="MATCH_STATE" defaultValue="" onlyValue="true" checkValue="0=待匹配;1=已匹配;"/></td>
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
							<td><BZ:page form="srcForm" property="List" /></td>
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