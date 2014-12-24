<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: normalFile_list.jsp
	 * @Description:  递交普通文件列表
	 * @author yangrt   
	 * @date 2014-7-21 下午6:33:34 
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
	<BZ:head language="EN">
		<title>递交普通文件列表</title>
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
				title : "查询条件(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','230px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/NormalFileList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_AF_COST").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_REG_STATE").value = "";
		}
		//执行文件新增操作
		function _fileAdd(){
			document.srcForm.action=path+"ffs/filemanager/NormalFileAddFirst.action";
			document.srcForm.submit();
		}
		
		//查看文件详细信息
		function _showFileData(){
			var num = 0;
			var AF_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					AF_ID = arrays[i].value.split("#")[0];
					num++;
				}
			}
			if(num != "1"){
				alert("Please select one document!");
				return;
			}else{
				var url = path + "ffs/filemanager/NormalFileShow.action?AF_ID=" + AF_ID;
				//window.open(url,this,'height=600,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
				_open(url, "window", 1000, 600);
			}
		}
		
		//修改未提交或待修改的文件信息
		function _fileUpdate(){
			var num = 0;
			var AF_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state != "0" && state != "2"){
						alert("You may only modify documents 'unsubmitted' or 'to be modified' .");
						return;
					}else{
						AF_ID = arrays[i].value.split("#")[0];
						num++;
					}
				}
			}
			if(num != "1"){
				alert("Please select one document for modification!");
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/NormalFileRevise.action?AF_ID="+AF_ID;
				document.srcForm.submit();
			}
		}
		
		//删除未提交的文件信息
		function _fileDelete(){
			var num = 0;
			var deleteuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "0"){
						deleteuuid[num++] = arrays[i].value.split("#")[0];
					}else{
						alert("You may only delete  information that haven't been submitted！");
						return;
					}
				}
			}
			if(num < 1){
				alert('Please select one or more documents to delete!');
				return;
			}else{
				if (confirm("Are you sure you want to delete? ")){
					document.getElementById("deleteuuid").value = deleteuuid.join("#");
					document.srcForm.action=path+"ffs/filemanager/FileDelete.action?type=normal";
					document.srcForm.submit();
				}
			}
		}
		
		//批量提交文件
		function _fileSubmit(){
			var num = 0;
			var subuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "0" ||state == "2"){
						subuuid[num++] = arrays[i].value.split("#")[0];
					}else{
						alert("You may only submit documents 'unsubmitted' or 'to be modified' .");
						return;
					}
				}
			}
			if(num < 1){
				alert('Please select document for submission!');
				return;
			}else{
				if (confirm("Please select document for submission!")){
					document.getElementById("subuuid").value = subuuid.join("#");
					document.srcForm.action=path+"ffs/filemanager/FileBatchSubmit.action?type=normal";
					document.srcForm.submit();
				}
			}
		}
		
		//流水号打印
		function _seqNoPrint(){
			var num = 0;
			var printuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					printuuid[num++] = arrays[i].value.split("#")[0];
				}
			}
			if(num < 1){
				alert('Please select data for printing serial number!');
				return;
			}else{
				document.getElementById("printuuid").value = printuuid.join("#");
				window.open(path+"ffs/filemanager/seqNoPrint.action?type=normal&printuuid="+printuuid,'newwindow','height=400,width=550,top=100,left=400,scrollbars=yes');
			}
		}
		
		//普通文件列表导出
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				/* document.srcForm.action=path+"ffs/filemanager/NormalFileExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/NormalFileList.action"; */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="ZCWJLX;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/NormalFileList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
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
								<td class="bz-search-title" style="width: 12%"><span title="Adoptive father">男收养人<br>Adoptive father</span></td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">女收养人<br>Adoptive mother</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mother" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%"><span title="Log-in No.">收文编号<br>Log-in No.</span></td>
								<td style="width: 10%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="Log-in No." maxlength="50"/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">提交日期<br>Submission date</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date"  dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Submission date start" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Submission date end" />
								</td>
								
								<td class="bz-search-title">收文日期<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Log-in Date start" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Log-in Date end" />
								</td>
							
								<td class="bz-search-title">应缴金额<br>Amount payable</td>
								<td>
									<BZ:input prefix="S_" field="AF_COST" id="S_AF_COST" defaultValue="" formTitle="Amount payable" restriction="int" maxlength="4"/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">文件类型<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" isShowEN="true" codeName="ZCWJLX" formTitle="Document type" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">文件登记状态<br>Log-in status</td>
								<td>
									<BZ:select prefix="S_" field="REG_STATE" id="S_REG_STATE" formTitle="" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">unsubmitted</BZ:option>
										<BZ:option value="1">to be registered </BZ:option>
										<BZ:option value="2">to be modified</BZ:option>
										<BZ:option value="3">registered</BZ:option>
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
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Upload new documents" class="btn btn-sm btn-primary" onclick="_fileAdd()"/>&nbsp;
					<input type="button" value="Modify" class="btn btn-sm btn-primary" onclick="_fileUpdate()"/>&nbsp;
					<input type="button" value="Delete" class="btn btn-sm btn-primary" onclick="_fileDelete()"/>&nbsp;
					<!-- <input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_fileSubmit()"/>&nbsp; -->
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_showFileData()"/>&nbsp;
					<input type="button" value="Serial number printing" class="btn btn-sm btn-primary" onclick="_seqNoPrint()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<!-- <th style="width: 6%;">
									<div class="sorting" id="AF_SEQ_NO">流水号</div>
								</th> -->
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">收文编号(Log-in No.)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">收文日期(Log-in date)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">文件类型(Document type)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AF_COST">应缴金额(Amount payable)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SUBMIT_DATE">提交日期(Submission date)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REG_STATE">文件登记状态(Log-in status)</div>
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
									<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>" disabled="disabled" class="ace">
								<%	}else { %>
									<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>" class="ace">
								<%	} %>
								</td>
								<td class="center">
								<%
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="file postponed" width="10px" height="10px">
								<%	} %>
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FILE_TYPE" defaultValue="" isShowEN="true" codeName="ZCWJLX" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUBMIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REG_STATE" defaultValue="" checkValue="0=unsubmitted;1=to be registered ;2=to be modified;3=registered;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" isShowEN="true" property="List" type="EN" exportXls="true" exportTitle="normal file" exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;SUBMIT_DATE=DATE;REG_STATE=FLAG,0:unsubmitted&1:to be registered&2:to be modified&3:registered;" exportField="MALE_NAME=男收养人(Adoptive father),15,20;FEMALE_NAME=女收养人(Adoptive mother),15;FILE_NO=收文编号(Log-in No.),15;REGISTER_DATE=收文日期(Log-in date),15;FILE_TYPE=文件类型(Document type),15;AF_COST=应缴金额(Amount payable),15;SUBMIT_DATE=提交日期(Submission date),15;REG_STATE=登记状态(Log-in status),15;"/></td>
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