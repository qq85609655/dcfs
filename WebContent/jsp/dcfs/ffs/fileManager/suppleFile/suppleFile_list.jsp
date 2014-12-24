<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: suppleFile_list.jsp
	 * @Description:  �����ļ��б�
	 * @author yangrt   
	 * @date 2014-8-22 ����4:02:34 
	 * @version V1.0   
	 */
	 //1 ��ȡ�����ֶΡ���������(ASC DESC)
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
		<title>�����ļ��б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/SuppleFileList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
		}
		//ִ���ļ���������
		function _fileAdd(){
			var num = 0;
			var AA_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked && arrays[i].value.split("#")[1] != "2"){
					AA_ID = arrays[i].value.split("#")[0];
					num++;
				}
			}
			if(num != "1"){
				alert("Please select one additional document!");
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/SuppleFileAdd.action?AA_ID=" + AA_ID;
				document.srcForm.submit();
			}
		}
		
		//�鿴�ļ���ϸ��Ϣ
		function _showFileData(af_id){
			var url = path + "ffs/filemanager/SuppleFileShow.action?type=show&AF_ID=" + af_id;
			//window.open(url,this,'height=600,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			_open(url, "window", 1000, 600);
		}
		
		//������ϸ�鿴
		function _suppleShow(){
			var arrays = document.getElementsByName("xuanze");
			var num = 0;
			var aa_id = "";		//�ļ������¼id
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					aa_id = arrays[i].value.split("#")[0];
					num += 1;
				}
			}
			if(num != "1"){
				alert('Please select one document��');
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/SuppleQueryShow.action?Flag=suppleList&AA_ID=" + aa_id;
				document.srcForm.submit();
			}
		}
		
		//�����ύ�ļ�
		function _fileSubmit(){
			var num = 0;
			var subuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state != "2"){
						subuuid[num++] = arrays[i].value.split("#")[0];
					}else{
						alert("You may only submit documents with 'to be completed' or 'in process of completing' status");
						return;
					}
				}
			}
			if(num < 1){
				alert('Please select document for submission!');
				return;
			}else{
				if (confirm("Are you sure you want to submit?")){
					document.getElementById("subuuid").value = subuuid.join("#");
					document.srcForm.action=path+"ffs/filemanager/SuppleBatchSubmit.action";
					document.srcForm.submit();
				}
			}
		}
		
		//�ļ��б���
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				/* document.srcForm.action=path+"ffs/filemanager/SuppleFileExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/SuppleFileList.action"; */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/SuppleFileList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%"><span title="Adoptive father">��������<br>Adoptive father</span></td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">Ů������<br>Adoptive mother</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mother" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%"><span title="Log-in No.">���ı��<br>Log-in No.</span></td>
								<td style="width: 10%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="Log-in No." maxlength="50"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="Log-in date start" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="Log-in date end" />
								</td>	
								
								<td class="bz-search-title">����֪ͨ����<br>Date of supplement notification</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="Date of supplement notification statr" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="Date of supplement notification end" />
								</td>
							
								<td class="bz-search-title">�ļ�����<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" isShowEN="true" formTitle="Document type" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�ظ�����<br>Date of reply</td>
								<td>
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true" defaultValue="" formTitle="Date of reply start" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true" defaultValue="" formTitle="Date of reply end" />
								</td>
								
								<td class="bz-search-title">����״̬<br>Supplement status</td>
								<td>
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" formTitle="" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">To-be added</BZ:option>
										<BZ:option value="1">in process of adding</BZ:option>
										<BZ:option value="2">added</BZ:option>
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
		<!-- ��ѯ������End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Supplement" class="btn btn-sm btn-primary" onclick="_fileAdd()"/>&nbsp;
					<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_fileSubmit()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_suppleShow()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
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
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��(Log-in No.)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">��������(Log-in date)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="MALE_NAME">��������(Adoptive father)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="FEMALE_NAME">Ů������(Adoptive mother)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����(Document type)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled" id="NOTICE_DATE">����֪ͨ����(Date of supplement notification)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEEDBACK_DATE">�ظ�����(Date of reply)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AA_STATUS">����״̬(Supplement status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
								<%
									String is_pause = ((Data)pageContext.getAttribute("myData")).getString("IS_PAUSE");//�ļ���ͣ��־
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<input name="xuanze" type="checkbox" value="<BZ:data field="AA_ID" onlyValue="true"/>#<BZ:data field="AA_STATUS" onlyValue="true"/>" disabled="disabled" class="ace">
								<%	}else { %>
									<input name="xuanze" type="checkbox" value="<BZ:data field="AA_ID" onlyValue="true"/>#<BZ:data field="AA_STATUS" onlyValue="true"/>" class="ace">
								<%	} %>
								</td>
								<td class="center">
								<%
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="�ļ�����ͣ" width="10px" height="10px">
								<%	} %>
									<BZ:i/>
								</td>
								<td class="center">
									<a href="#" title="�鿴�ļ���ϸ��Ϣ" onclick="_showFileData('<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/>
									</a>
								</td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" isShowEN="true" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FEEDBACK_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=To-be added;1=in process of adding;2=added;" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" isShowEN="true" property="List" type="EN" exportXls="true" exportTitle="�����ļ�" exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE;AA_STATUS=FLAG,0:To-be added&1:in process of adding&2:added;" exportField="FILE_NO=���ı��(Log-in No.),15,20;REGISTER_DATE=��������(Log-in date),15;MALE_NAME=��������(Adoptive father),15;FEMALE_NAME=Ů������(Adoptive mother),15;FILE_TYPE=�ļ�����(Document type),15;NOTICE_DATE=֪ͨ����(Date of notification),15;FEEDBACK_DATE=�ظ�����(Date of reply),15;AA_STATUS=����״̬(Supplement status),15;"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>