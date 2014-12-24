<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: specialFile_list.jsp
	 * @Description:  �ݽ������ļ��б�
	 * @author yangrt   
	 * @date 2014-7-21 ����6:33:34 
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
		<title>�ݽ������ļ��б�</title>
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
				area: ['1050px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/SpecialFileList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_AF_COST").value = "";
			/* document.getElementById("S_NAME").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SEX").value = ""; */
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_REG_STATE").value = "";
		}
		//ִ���ļ���������
		function _fileSelect(){
			document.srcForm.action=path+"ffs/filemanager/SpecialFileSelectList.action?type=select";
			document.srcForm.submit();
		}
		
		//�鿴�ļ���ϸ��Ϣ
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
				var url = path + "ffs/filemanager/SpecialFileShow.action?AF_ID=" + AF_ID;
				_open(url, "window", 1000, 600);
			}
		}
		
		function _showChildData(str_ci_id,ri_id){
			var url = path + "ffs/filemanager/ChildDataShow.action?ci_id=" + str_ci_id + "&RI_ID=" + ri_id;
			_open(url, "window", 900, 600);
		}
		
		//�޸�δ�ύ����޸ĵ��ļ���Ϣ
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
				alert("Please select one document for modification��");
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/SpecialFileRevise.action?AF_ID="+AF_ID;
				document.srcForm.submit();
			}
		}
		
		//ɾ��δ�ύ���ļ���Ϣ
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
						alert("You may only delete  information that haven't been submitted!");
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
					document.srcForm.action=path+"ffs/filemanager/FileDelete.action?type=special";
					document.srcForm.submit();
				}
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
					if(state == "0" ||state == "2"){
						subuuid[num++] = arrays[i].value.split("#")[0];
					}else{
						alert("You may only submit documents 'unsubmitted' or 'to be modified' . ");
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
					document.srcForm.action=path+"ffs/filemanager/FileBatchSubmit.action?type=special";
					document.srcForm.submit();
				}
			}
		}
		
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
				var url = path+"ffs/filemanager/seqNoPrint.action?type=special&printuuid=" + printuuid;
				_open(url, "window", 600, 400);
			}
		}
		
		//��ͨ�ļ��б���
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				document.srcForm.action=path+"ffs/filemanager/SpecialFileExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/SpecialFileList.action";
				//_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="TXWJLX;ETXB;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/SpecialFileList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
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
								<td class="bz-search-title">�ύ����<br>Submission date</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Submission date start" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Submission date end" />
								</td>
								
								<td class="bz-search-title">��������<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Log-in date start" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="Log-in date end" />
								</td>
							
								<td class="bz-search-title">Ӧ�ɽ��<br>Amount payable</td>
								<td>
									<BZ:input prefix="S_" field="AF_COST" id="S_AF_COST" defaultValue="" formTitle="Amount payable" restriction="int" maxlength="4"/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�ļ�����<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="TXWJLX" isShowEN="true" formTitle="Document type" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�ļ��Ǽ�״̬<br>Log-in status</td>
								<td>
									<BZ:select prefix="S_" field="REG_STATE" id="S_REG_STATE" formTitle="" defaultValue="" width="70%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">unsubmitted</BZ:option>
										<BZ:option value="1">to be registered</BZ:option>
										<BZ:option value="2">to be modified</BZ:option>
										<BZ:option value="3">registered</BZ:option>
									</BZ:select>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<%-- <tr>	
								<td class="bz-search-title">��ͯ����<br>Child name</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="��ͯ����" maxlength="200" style="width:270px;"/>
									
								</td>
							
								<td class="bz-search-title">��������<br>BIRTHDAY</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue=""/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue=""/>
								</td>
								
								<td class="bz-search-title">�Ա�<br>SEX</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="" isCode="true" codeName="ETXB" defaultValue="" width="80%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr> --%>
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
					<input type="button" value="I want to submit pre-approved special needs document" class="btn btn-sm btn-primary" onclick="_fileSelect()"/>&nbsp;
					<input type="button" value="Modify" class="btn btn-sm btn-primary" onclick="_fileUpdate()"/>&nbsp;
					<input type="button" value="Delete" class="btn btn-sm btn-primary" onclick="_fileDelete()"/>&nbsp;
					<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_fileSubmit()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_showFileData()"/>&nbsp;
					<input type="button" value="Serial number printing" class="btn btn-sm btn-primary" onclick="_seqNoPrint()"/>&nbsp;
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
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">��������(Adoptive father)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������(Adoptive mother)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��(Log-in No.)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">��������(Log-in date)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����(Document type)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AF_COST">Ӧ�ɽ��(Amount payable)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="NAME">��ͯ����(Child name)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SUBMIT_DATE">�ύ����(Submission date)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REG_STATE">�Ǽ�״̬(Log-in status)</div>
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
									<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>" disabled="disabled" class="ace">
								<%	}else { %>
									<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>" class="ace">
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
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="" defaultValue="Special needs" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
							<%
								String str_ci_id = ((Data)pageContext.getAttribute("myData")).getString("CI_ID","");
								if("".equals(str_ci_id)){
							%>	
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
							<%
								}else{
							%>
								<td><a href="#" onclick="_showChildData('<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>','<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>');return false;"><BZ:data field="NAME_PINYIN" defaultValue="Mulity" onlyValue="true" /></a></td>
							<%  } %>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUBMIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REG_STATE" defaultValue="" checkValue="0=unsubmitted;1=to be registered;2=to be modified;3=registered;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN"/></td>
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