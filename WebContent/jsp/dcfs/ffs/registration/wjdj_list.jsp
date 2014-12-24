<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: wjdj_list.jsp
 * @Description:  
 * @author yangrt   
 * @date 2014-7-14 下午3:00:34 
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
		<title>文件登记列表</title>
		<BZ:webScript list="true" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1500,1500);
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
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/registration/findList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_AF_SEQ_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_AF_COST").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_REG_STATE").value = "'1','2','3'";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
		}
		//手工登记
		function _hand_reg(){
			var num = 0;
			var reguuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "1"){
						reguuid[num++] = arrays[i].value.split("#")[0];
					}else{
						page.alert("只能选择待登记的文件信息！");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('请选择手工登记的文件！');
				return;
			}else{
				document.getElementById("reguuid").value = reguuid.join("#");
				document.srcForm.action=path+"ffs/registration/FileHandReg.action?reguuid="+reguuid;
				document.srcForm.submit();
			}
		}
		
		//批量打印条形码
		function _barcode(){
			var num = 0;
			var codeuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					codeuuid[num++] = arrays[i].value.split("#")[0];
				}
			}
			if(num < 1){
				page.alert('请选择一条或多条记录打印条形码！');
				return;
			}else{
				document.getElementById("codeuuid").value = codeuuid.join("#");
				//window.open(path+"ffs/registration/barCodeList.action?codeuuid="+codeuuid,'newwindow','height=500,width=480,top=100,left=400,scrollbars=yes');
				document.srcForm.action=path+"ffs/registration/barCodeList.action?type=direct&codeuuid="+codeuuid;
				document.srcForm.submit();
			}
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
			}
		}
		//点击儿童姓名查看预批信息
		function _showChildData(str_ci_id){
			//var url = path + "ffs/filemanager/ChildDataShow.action?ci_id=" + str_ci_id;
			//window.open(url,this,'height=600,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			//_open(url, "window", 900, 600);
			window.open(path+"ffs/registration/ChildDataShow.action?ci_id=" + str_ci_id,"newwindow","height=600,width=900,top=70,left=180,scrollbars=yes");
		}
		
		//业务自定义功能操作JS
		
 		//文件代录新增
		function _wjdlAdd(){
			window.location.href=path+"ffs/registration/toAddFlieRecordChoise.action";
		}
 		//批量文件代录
		function _batchAdd(){
			window.location.href=path+"ffs/registration/batchAddFlieRecord.action";
		}
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

		//文件登记列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		


	</script>
	<BZ:body property="data" codeNames="WJLX_DL;WJLX;GJSY;SYZZ;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="ffs/registration/findList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="reguuid" name="reguuid" value=""/>
		<input type="hidden" id="codeuuid" name="codeuuid" value=""/>
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
								<td class="bz-search-title" style="width: 10%"><span title="流水号">流水号</span></td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="AF_SEQ_NO" id="S_AF_SEQ_NO" defaultValue="" formTitle="流水号" maxlength="50"/>
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
								
								<td class="bz-search-title" style="width: 10%"><span title="男收养人">男收养人</span></td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%">收文编号</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="50"/>
								</td>	
								
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								
								</td>
								
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">应缴金额</td>
								<td>
									<BZ:input prefix="S_" field="AF_COST" id="S_AF_COST" defaultValue="" formTitle="应缴金额" restriction="int" maxlength="4"/>
								</td>
								
								<td class="bz-search-title">文件类型</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="文件类型" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">收文日期</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								
								<td class="bz-search-title">登记状态</td>
								<td>
									<BZ:select prefix="S_" field="REG_STATE" id="S_REG_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="'1','2','3'">--请选择--</BZ:option>
										<BZ:option value="'1'">待登记</BZ:option>
										<BZ:option value="'2'">待修改</BZ:option>
										<BZ:option value="'3'">已登记</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">提交日期</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始提交日期" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止提交日期" />
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
					<input type="button" value="登&nbsp;&nbsp;记" class="btn btn-sm btn-primary" onclick="_hand_reg()"/>&nbsp;
					<input type="button" value="条形码打印" class="btn btn-sm btn-primary" onclick="_barcode()"/>&nbsp;
					<input type="button" value="退&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_wjthAdd()"/>&nbsp;
					<input type="button" value="文件代录" class="btn btn-sm btn-primary" onclick="_wjdlAdd()"/>&nbsp;
					<input type="button" value="批量代录" class="btn btn-sm btn-primary" onclick="_batchAdd()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				
				
				<!--查询结果列表区Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AF_SEQ_NO">流水号</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REGISTER_DATE">收文日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="NAME">儿童姓名</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">文件类型</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AF_COST">应缴金额</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PAID_NO">缴费编号</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REG_DATE">提交日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REG_STATE">登记状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="resultData">
							<tr class="emptyData">
							<%
									Data resultData = (Data)pageContext.getAttribute("resultData");
									String is_pause = resultData.getString("IS_PAUSE");//文件暂停标志
							%>
								<td class="center">
									<%
									if("1".equals(is_pause)||"1"==is_pause){
									%>
										<input name="xuanze" type="checkbox" disabled value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>#<BZ:data field="FILE_NO" onlyValue="true"/>" class="ace">
									<% 
									}else {
									%>
										<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>#<BZ:data field="FILE_NO" onlyValue="true"/>" class="ace">
									<% 
									}
									%>
								</td>
								<td class="center">
									<%
									if("1".equals(is_pause)||"1"==is_pause){
									%>
										<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="文件已暂停" width="10px" height="10px">	
									<% 
									}
									%>
									<BZ:i/>
								</td>
								<td><BZ:data field="AF_SEQ_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<%
								String str_ci_id = resultData.getString("CI_ID","");
								if("".equals(str_ci_id)){
								%>	
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<%
									}else{
								%>
								<td><a href="#" onclick="_showChildData('<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>');return false;" title="点击查看该儿童预批信息"><BZ:data field="NAME" defaultValue="Mulity" onlyValue="true" /></a></td>
								<%  } %>
								<td><BZ:data field="FILE_TYPE" defaultValue=""  codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUBMIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REG_STATE" defaultValue="" onlyValue="true" checkValue="1=待登记;2=待修改;3=已登记;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--查询结果列表区End -->
				
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page isShowEN="false" form="srcForm" property="List" exportXls="true" exportTitle="文件登记信息" exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;FILE_TYPE=CODE,WJLX;SUBMIT_DATE=DATE;REG_STATE=FLAG,1:待登记&2:待修改&3:已登记;" 
								exportField="AF_SEQ_NO=流水号,15,20;FILE_NO=收文编号,15;REGISTER_DATE=收文日期,15;COUNTRY_CODE=国家,15;NAME_CN=收养组织,25;MALE_NAME=男收养人,30;FEMALE_NAME=女收养人,30;NAME=儿童姓名,15;FILE_TYPE=文件类型,15;AF_COST=应缴金额,15;PAID_NO=缴费编号,15;SUBMIT_DATE=提交日期,15;REG_STATE=登记状态,15;"/></td>
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