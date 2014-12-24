<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: 分管主任审批列表
 * @author mayun   
 * @date 2014-8-29
 * @version V1.0   
 */
	String compositor = (String) request.getAttribute("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
	

%>
<BZ:html>
	<BZ:head>
		<title>分管主任审批列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
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
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/jbraudit/findListForThreeLevel.action";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_RECEIVER_DATE_START").value = "";
			document.getElementById("S_RECEIVER_DATE_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_TRANSLATION_QUALITY").value = "";
			document.getElementById("S_AUD_STATE").value = "";
			document.getElementById("S_AA_STATUS").value = "";
			document.getElementById("S_RTRANSLATION_STATE").value = "";
			//document.getElementById("S_OPERATION_STATE").value = "";
		}
		//生成条形码
		function _barcode(){
			var num = 0;
			var codeuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					codeuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条数据');
				return;
			}else{
				window.open(path+"ffs/registration/barCode.action?codeuuid="+codeuuid,'newwindow','height=500,width=480,top=100,left=400,scrollbars=yes');
			}
		}
		//查看
		function _show() {
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条要查看的数据');
				return;
			}else{
				window.open(path+"ffs/registration/show.action?showuuid="+showuuid,'newwindow','height=550,width=1000,top=70,left=180,scrollbars=yes');
				document.srcForm.submit();
			}
		}
		
		//复核列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				//document.srcForm.action=path+"ffs/jbraudit/fileExportForTwoLevel.action";
				//document.srcForm.submit();
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		//业务自定义功能操作JS
		
	
	//是否满足复核操作
	function _isCanAudit(){
		var xuanze = $("input[name='xuanze']:checked").val();
		if(null==xuanze||""==xuanze||"undefined"==xuanze){
			page.alert("请选择一条要审批的数据！");
			return;
		}else{
			var dataArr = xuanze.split(";");
			var AF_ID = dataArr[0];
			//var AU_ID = dataArr[1];
			var AUDIT_STATUS = dataArr[1];
			if("3"!=AUDIT_STATUS){
				page.alert("请选择审核状态为分管主任[待审批]的记录！");
				return;
			}else{
				var AUDIT_LEVEL="2";
				var OPERATION_STATE="'0','1'";
				_audit(AF_ID,AUDIT_LEVEL,OPERATION_STATE);
			}
		}
	}
	
	//审核
	function _audit(AF_ID,AUDIT_LEVEL,OPERATION_STATE){
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.audit.FileAuditAjax&method=getAuditIDForWJSH&AF_ID='+AF_ID+'&AUDIT_LEVEL='+AUDIT_LEVEL+'&OPERATION_STATE='+OPERATION_STATE,
			type: 'POST',
			dataType: 'json',
			timeout: 10000,
			success: function(data){
				var AU_ID=data.AU_ID;
				window.location.href=path+"ffs/jbraudit/toAuditForThreeLevel.action?AF_ID="+AF_ID+"&AU_ID="+AU_ID;
			}
		  });
	}
	
	//查看文件基本信息已经相关审核信息
	function _showFileAndAuditInfo(xuanze){
		var dataArr = xuanze.split(";");
		var AF_ID = dataArr[0];
		var AUDIT_STATUS = dataArr[1];
		var OPERATION_STATE="'0','1','2'";
		var AUDIT_LEVEL;
		if("0"==AUDIT_STATUS||"1"==AUDIT_STATUS||"9"==AUDIT_STATUS){
			AUDIT_LEVEL="0";
		}else if("2"==AUDIT_STATUS||"4"==AUDIT_STATUS||"5"==AUDIT_STATUS){
			AUDIT_LEVEL="1"
		}else{
			AUDIT_LEVEL="2";
		}
		
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.audit.FileAuditAjax&method=getAuditIDForWJSH&AF_ID='+AF_ID+'&AUDIT_LEVEL='+AUDIT_LEVEL+'&OPERATION_STATE='+OPERATION_STATE,
			type: 'POST',
			dataType: 'json',
			timeout: 10000,
			success: function(data){
				var AU_ID=data.AU_ID;
				$.layer({
					type : 2,
					title : "查看文件基本信息和相关审核信息",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					iframe: {src: '<BZ:url/>/ffs/jbraudit/toAuditForThreeLevelView.action?AF_ID='+AF_ID+'&AU_ID='+AU_ID},
					area: ['1150px',($(window).height() - 50) +'px'],
					offset: ['0px' , '0px']
				});
			}
		  });
		
		
	}
	
	

	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;WJLX;SYBMSH;SYZZ;SYS_ADOPT_ORG;SYWJSHZT;WJFYZL;SYJBRSH;SYWJBC;SYWJCF;WJFGZRSP;SYFGSH;WJSHCZZT;SYWJSHZT">
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findListForThreeLevel.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display:none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">
									<span title="收文编号">收文编号</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO"
										defaultValue="" formTitle="收文编号"/>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="文件类型">文件类型</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="FILE_TYPE" formTitle=""
										prefix="S_" isCode="true" codeName="WJLX" width="70%">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="国家">国家</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="收养组织">收养组织</span>
								</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
							<tr>
								
								<td class="bz-search-title" style="width: 10%">
									<span title="男收养人">男收养人</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME"
										defaultValue="" formTitle="男收养人"
										restriction="hasSpecialChar" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="女收养人">女收养人</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME"
										defaultValue="" formTitle="女收养人"
										restriction="hasSpecialChar" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="翻译质量">翻译质量</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="TRANSLATION_QUALITY" formTitle=""
										prefix="S_" isCode="true" codeName="WJFYZL" width="70%">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="审核状态">审核状态</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="AUD_STATE" formTitle=""
										prefix="S_" isCode="true" codeName="SYWJSHZT" width="70%">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
							</tr>
							
							<tr>
								<!-- 
								<td class="bz-search-title" style="width: 10%">
									<span title="补充状态">补充状态</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="AA_STATUS" formTitle=""
										prefix="S_" isCode="true" codeName="SYWJBC" width="70%">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="重翻状态">重翻状态</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="RTRANSLATION_STATE" formTitle=""
										prefix="S_" isCode="true" codeName="SYWJCF" width="70%">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								 
								<td class="bz-search-title" style="width: 10%">
									<span title="操作状态">操作状态</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="OPERATION_STATE" formTitle=""
										prefix="S_" isCode="true" codeName="WJSHCZZT" width="70%">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								-->
								<td class="bz-search-title" style="width: 10%">
									<span title="接收日期">接收日期</span>
								</td>
								<td style="width: 30%" colspan="3">
									<BZ:input prefix="S_" field="RECEIVER_DATE_START" id="S_RECEIVER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始提交日期" />~
									<BZ:input prefix="S_" field="RECEIVER_DATE_END" id="S_RECEIVER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止提交日期" />
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
					<input type="button" value="审&nbsp;&nbsp;批" class="btn btn-sm btn-primary" onclick="_isCanAudit()"/>&nbsp;
					<input type="button" value="条形码扫描" class="btn btn-sm btn-primary" onclick=""/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 1%;">
									<div class="sorting_disabled">
									</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">
										序号
									</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">
										收文编号
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RECEIVER_DATE">
										收文日期
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_TYPE">
										文件类型
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="COUNTRY_CN">
										国家
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">
										收养组织
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">
										男收养人
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">
										女收养人
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">
										接收日期
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUD_STATE">
										审核状态
									</div>
								</th>
								<!-- 
								<th style="width: 5%;">
									<div class="sorting" id="AA_STATUS">
										补充状态
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RTRANSLATION_STATE">
										重翻状态
									</div>
								</th>
								 -->
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_QUALITY">
										翻译质量
									</div>
								</th>
							</tr>
						</thead>
						<tbody id="tbody">
						<BZ:for property="List" fordata="resultData">
							<tr class="emptyData">
								<%
									Data resultData = (Data)pageContext.getAttribute("resultData");
									String is_pause = resultData.getString("IS_PAUSE");//文件暂停标志
									String return_state = resultData.getString("RETURN_STATE");//文件退文标志
								%>
								<td class="center">
								<%
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<input name="xuanze" type="radio" disabled value="<BZ:data field="AF_ID" onlyValue="true"/>;<BZ:data field="AUD_STATE" onlyValue="true"/>" 
									class="ace">
								<% 
									}else {
								%>
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>;<BZ:data field="AUD_STATE" onlyValue="true"/>" 
									class="ace">
								<%  } %>
								</td>
								<td class="center" nowrap>
									<%
									if("1".equals(is_pause)||"1"==is_pause){//暂停标志
									%>
										<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="文件已暂停" width="10px" height="10px">	
									<% 
									}
									if("0".equals(return_state)||"0"==return_state){//退文待确认标志
									%>
										<font size="2px" title="退文待确认" color="red">退</font>
									<%} %>
									<BZ:i/>
								</td>
								<td>
									<a href="javascript:void()" onclick="_showFileAndAuditInfo('<BZ:data field="AF_ID" onlyValue="true"/>;<BZ:data field="AUD_STATE" onlyValue="true"/>')" title="点击查看详细审核信息">
										<BZ:data field="FILE_NO" defaultValue="" onlyValue="true" />
									</a>
								</td>
								<td>
									<BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="FILE_TYPE"  defaultValue="" onlyValue="true" codeName="WJLX" />
								</td>
								<td>
									<BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"  />
								</td>
								<td>
									<BZ:data field="NAME_CN" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true" codeName="SYWJSHZT"/>
								</td>
								<!-- 
								<td>
									<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true" codeName="SYWJBC"/>
								</td>
								<td>
									<BZ:data field="RTRANSLATION_STATE" defaultValue="" onlyValue="true" codeName="SYWJCF"/>
								</td>
								 -->
								<td>
									<BZ:data field="TRANSLATION_QUALITY" defaultValue="" onlyValue="true" codeName="WJFYZL"/>
								</td>
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
							<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="分管主任审批数据" exportCode="FILE_TYPE=CODE,WJLX;COUNTRY_CODE=CODE,GJSY;ADOPT_ORG_ID=CODE,SYS_ADOPT_ORG;AUD_STATE=CODE,SYWJSHZT;SUPPLY_STATE=CODE,SYWJBC;RTRANSLATION_STATE=CODE,SYWJCF;TRANSLATION_QUALITY=CODE,WJFYZL;REGISTER_DATE=DATE;RECEIVER_DATE=DATE" exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=收文日期,15;FILE_TYPE=文件类型,10;COUNTRY_CODE=国家,10;ADOPT_ORG_ID=收养组织,20;MALE_NAME=男收养人,30;FEMALE_NAME=女收养人,30;RECEIVER_DATE=接收日期,15;AUD_STATE=审核状态,15;TRANSLATION_QUALITY=翻译质量,15"/>
							<!--<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="复核审核数据" exportCode="COUNTRY_CODE=CODE,GJSY;ADOPT_ORG_ID=CODE,SYZZ;AUD_STATE=CODE,SYBMSH;SUPPLY_STATE=CODE,SYWJBC;RTRANSLATION_STATE=FLAG,0:待重翻&1:重翻中&2:已重翻;TRANSLATION_QUALITY=CODE,WJFYZL;REGISTER_DATE=DATE;RECEIVER_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=提交日期,15;COUNTRY_CODE=国家,10;ADOPT_ORG_ID=收养组织,20;MALE_NAME=男收养人,30;FEMALE_NAME=女收养人,30;RECEIVER_DATE=接收日期,15;AUD_STATE=审核状态,15;SUPPLY_STATE=补充状态,15;RTRANSLATION_STATE=重翻状态,15;TRANSLATION_QUALITY=翻译质量,15"/>-->
							
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