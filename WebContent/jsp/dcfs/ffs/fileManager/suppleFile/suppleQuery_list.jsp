<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: suppleQuery_list.jsp
	 * @Description:  补充查询列表
	 * @author yangrt   
	 * @date 2014-09-04 下午7:12:34 
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
	<BZ:head language="CN">
		<title>补充查询列表</title>
		<BZ:webScript list="true" isAjax="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
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
				area: ['1000px','240px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/SuppleQueryList.action?type=SHB&page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
		}
		
		//补充明细查看
		function _suppleShow(){
			var arrays = document.getElementsByName("xuanze");
			var num = 0;
			var aa_id = "";		//文件补充记录id
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					aa_id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('请选择一条要查看的数据');
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/SuppleQueryShow.action?AA_ID=" + aa_id;
				document.srcForm.submit();
			}
		}
		
		 //审核
		  function _audit(){
			    var arrays = document.getElementsByName("xuanze");
				var num = 0;
				var aud_state="";	//文件审核状态
				var af_id = "";		//文件id
				var au_id = "";		//审核记录id
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						aud_state=arrays[i].getAttribute("AUD_STATE");
						var aa_state = arrays[i].getAttribute("AA_STATUS"); 
						if(aud_state == "1"){
							af_id=document.getElementsByName('xuanze')[i].getAttribute("AF_ID");
							num += 1;
						}else{
							page.alert('请文件已经审核，选择一条其他要要审核的文件！');
							return;
						}
					}
				}
				if(num != "1"){
					page.alert('请选择一条要审核的数据');
					return;
				}else{	 
					var str_id_state = af_id + ";" + aud_state;
					var data = getData('com.dcfs.ffs.audit.FileAuditAjax','str_id_state=' + str_id_state+"&method=getAuditID");
					au_id = data.getString("AU_ID");
					if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
						document.srcForm.action=path+"ffs/jbraudit/toAuditForOneLevel.action?FLAG=bc&AF_ID="+af_id+"&AU_ID="+au_id;
						document.srcForm.submit();
					}else if(aud_state == "2"){
						document.srcForm.action=path+"ffs/jbraudit/toAuditForTwoLevel.action?FLAG=bc&AF_ID="+af_id+"&AU_ID="+au_id;
						document.srcForm.submit();
					}else if(aud_state == "3"){
						document.srcForm.action=path+"ffs/jbraudit/toAuditForThreeLevel.action?FLAG=bc&AF_ID="+af_id+"&AU_ID="+au_id;
						document.srcForm.submit();
					}else if(aud_state == "4"){
						page.alert("该文件已经审核未通过，不能进行再次审核！");
					}else if(aud_state == "5"){
						page.alert("该文件已经审核通过，不能进行再次审核！");
					}
				 }
		  }
		
		
		
		//进入文件详细信息查看页面
		function _showFileDetail(af_id){
			var url = path + "ffs/filemanager/FileDetailShow.action?type=list&AF_ID=" + af_id;
			//////_open(url, "window", 1000, 600);
			document.srcForm.action=url;
			document.srcForm.submit();
		}
		
		//文件列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				/* document.srcForm.action=path+"ffs/filemanager/SuppleFileExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/SuppleFileList.action"; */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;GJSY;SYJBRSH;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/SuppleQueryList.action?type=SHB">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%"><span title="收文编号">收文编号</span></td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 15%">文件类型</td>
								<td style="width: 10%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="文件类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="国家">国家</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="GJSY" width="148px"
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
							</tr>
							<tr>
								<td class="bz-search-title">收文日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>	
								
								<td class="bz-search-title"><span title="男收养人">男收养人</span></td>
								<td colspan="2">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="150"/>
								</td>
							</tr>	
							<tr>
								<td class="bz-search-title">补充通知日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始提交日期" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止提交日期" />
								</td>
							
								<td class="bz-search-title">反馈日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始提交日期" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止提交日期" />
								</td>
								
								<td class="bz-search-title">补充状态</td>
								<td>
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" formTitle="" defaultValue="" width="70%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">待补充</BZ:option>
										<BZ:option value="1">补充中</BZ:option>
										<BZ:option value="2">已补充</BZ:option>
									</BZ:select>
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
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_suppleShow()"/>&nbsp;
					<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
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
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">收文日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">文件类型</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="ADOPT_ORG_ID">收养组织</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="NOTICE_DATE">补充通知日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FEEDBACK_DATE">反馈日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AA_STATUS">补充状态</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AUD_STATE">审核状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
								<%
									String is_pause = ((Data)pageContext.getAttribute("myData")).getString("IS_PAUSE");//文件暂停标志
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<input name="xuanze" type="radio" value="<BZ:data field="AA_ID" defaultValue="" onlyValue="true"/>" 
										AF_ID="<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>" 
										AUD_STATE="<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true"/>" 
										AA_STATUS="<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>" disabled="disabled" class="ace">
								<%	}else { %>
									<input name="xuanze" type="radio" value="<BZ:data field="AA_ID" defaultValue="" defaultValue="" onlyValue="true"/>" 
										AF_ID="<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>" 
										AUD_STATE="<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true"/>" 
										AA_STATUS="<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>" class="ace">
								<%	} %>
								</td>
								<td class="center">
								<%
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="文件已暂停" width="10px" height="10px">
								<%	} %>
									<BZ:i/>
								</td>
								<td class="center">
									<a href="#" title="查看文件详细信息" onclick="_showFileDetail('<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/>
									</a>
								</td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FEEDBACK_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充;" onlyValue="true"/></td>
								<td><BZ:data field="AUD_STATE" defaultValue="" checkValue="0=经办人待审核;1=经办人审核中;2=部门主任待审核;3=分管主任待审批;4=审核不通过;5=审核通过;9=退回重审;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="补充文件" exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;COUNTRY_CODE=CODE,GJSY;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE;AA_STATUS=FLAG,0:待补充&1:补充中&2:已补充;" exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=收文日期,15;COUNTRY_CODE=国家,15;NAME_CN=收养组织,15;MALE_NAME=男收养人,15;FEMALE_NAME=女收养人,15;FILE_TYPE=文件类型,15;NOTICE_DATE=通知日期,15;FEEDBACK_DATE=反馈日期,15;AA_STATUS=补充状态,15;"/></td>
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