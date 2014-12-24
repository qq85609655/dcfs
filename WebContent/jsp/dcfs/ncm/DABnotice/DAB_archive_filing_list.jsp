<%
/**   
 * @Title: DAB_archive_filing_list.jsp
 * @Description: �������鵵�����б�
 * @author xugy
 * @date 2014-11-2����5:32:21
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

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
	<BZ:head>
		<title>�������鵵�����б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			_scroll(1700,1700);
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','190px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"notice/DABArchiveFilingList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_ARCHIVE_NO_START").value = "";
			document.getElementById("S_ARCHIVE_NO_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_ARCHIVE_USERNAME").value = "";
			document.getElementById("S_ARCHIVE_DATE_START").value = "";
			document.getElementById("S_ARCHIVE_DATE_END").value = "";
			document.getElementById("S_ARCHIVE_STATE").value = "";
			document.getElementById("S_FILING_REMARKS").value = "";
			document.getElementById("S_ARCHIVE_VALID").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		
		//�鵵
		function _filing(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ARCHIVE_VALID = id.split(",")[2];
					if(ARCHIVE_VALID == "0"){
						alert("�õ�������Ч");
						return;
					}
					var ARCHIVE_STATE = id.split(",")[1];
					if(ARCHIVE_STATE != "0"){
						alert("��ѡ��δ�鵵������");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/toDABArchiveFiling.action";
				document.srcForm.submit();
			}
		}
		//�⵵
		function _release(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ARCHIVE_STATE = id.split(",")[1];
					if(ARCHIVE_STATE != "2"){
						alert("��ѡ����⵵������");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/toDABReleaseFiling.action";
				document.srcForm.submit();
			}
		}
		//Ŀ¼
		function _catalog(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ARCHIVE_VALID = id.split(",")[2];
					if(ARCHIVE_VALID == "0"){
						alert("�õ�������Ч");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/DABCatalog.action";
				document.srcForm.submit();
			}
		}
		//������ӡĿ¼��һ��
		function _printAll(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('��ѡ���ӡ������ ');
				return;
			}else{
				ids = encodeURIComponent(ids);
				$.layer({
					type : 2,
					title : false,
					shade : [0.5 , '#D9D9D9' , true],
					border :[0 , 0.3 , '#000', true],
					//page : {dom : '#planList'},
					time:10,
					iframe: {src: "<BZ:url/>/notice/getDABCatalogInfo.action?ids="+ids},
					area: ['300px','100px'],
					closeBtn:[false]
				});
			}
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="notice/DABArchiveFilingList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
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
								<td class="bz-search-title">������</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_NO_START" id="S_ARCHIVE_NO_START" defaultValue="" restriction="plusInt" formTitle="��ʼ������" maxlength="" />~
									<BZ:input prefix="S_" field="ARCHIVE_NO_END" id="S_ARCHIVE_NO_END" defaultValue="" restriction="plusInt" formTitle="����������" maxlength="" />
								</td>
								
								<td class="bz-search-title">���ı��</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
							
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��ͯ����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
								
								<td class="bz-search-title">�鵵��</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_USERNAME" id="S_ARCHIVE_USERNAME" defaultValue="" formTitle="�鵵��" maxlength="" />
								</td>
								
								<td class="bz-search-title">�鵵����</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_DATE_START" id="S_ARCHIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ARCHIVE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�鵵����" />~
									<BZ:input prefix="S_" field="ARCHIVE_DATE_END" id="S_ARCHIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ARCHIVE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�鵵����" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�鵵״̬</td>
								<td>
									<BZ:select prefix="S_" field="ARCHIVE_STATE" id="S_ARCHIVE_STATE" width="148px" formTitle="�鵵״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ�鵵</BZ:option>
										<BZ:option value="1">�ѹ鵵</BZ:option>
										<BZ:option value="2">���⵵</BZ:option>
										<BZ:option value="3">�ѽ⵵</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��ע</td>
								<td>
									<BZ:input prefix="S_" field="FILING_REMARKS" id="S_FILING_REMARKS" defaultValue="" formTitle="��ע" maxlength="" />
								</td>
								
								<td class="bz-search-title">�Ƿ���Ч</td>
								<td>
									<BZ:select prefix="S_" field="ARCHIVE_VALID" id="S_ARCHIVE_VALID" width="148px" formTitle="�Ƿ���Ч" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
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
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_filing()"/>&nbsp;
					<!-- <input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_release()"/>&nbsp; -->
					<input type="button" value="Ŀ&nbsp;&nbsp;¼" class="btn btn-sm btn-primary" onclick="_catalog()"/>&nbsp;
					<input type="button" value="������ӡĿ¼��һ��" class="btn btn-sm btn-primary" onclick="_printAll()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
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
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_NO">������</div>
								</th>
								
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								
								<th style="width: 4%;">
									<div class="sorting" id="ARCHIVE_USERNAME">�鵵��</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARCHIVE_DATE">�鵵����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_STATE">�鵵״̬</div>
								</th>
								
								<th style="width: 18%;">
									<div class="sorting" id="FILING_REMARKS">��ע</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_VALID">�Ƿ���Ч</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="ARCHIVE_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ARCHIVE_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue=""/></td>
								
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								
								<td><BZ:data field="NAME" defaultValue=""/></td>
								
								<td><BZ:data field="ARCHIVE_USERNAME" defaultValue=""/></td>
								<td><BZ:data field="ARCHIVE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="ARCHIVE_STATE" defaultValue="" checkValue="0=δ�鵵;1=�ѹ鵵;2=���⵵;3=�ѽ⵵;"/></td>
								<td><BZ:data field="FILING_REMARKS" defaultValue=""/></td>
								<td><BZ:data field="ARCHIVE_VALID" defaultValue="" checkValue="0=��;1=��;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="��������" exportCode="COUNTRY_CODE=CODE,GJSY;ARCHIVE_STATE=FLAG,0:δ�鵵&1:�ѹ鵵&2:���⵵&3:�ѽ⵵;ARCHIVE_VALID=FLAG,0:��&1:��;ARCHIVE_DATE=DATE,yyyy/MM/dd" exportField="ARCHIVE_NO=������,15,20;FILE_NO=���ı��,15;COUNTRY_CODE=����,15;NAME_CN=������֯,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;NAME=��ͯ����,15;ARCHIVE_USERNAME=�鵵��,15;ARCHIVE_DATE=�鵵����,15;ARCHIVE_STATE=�鵵״̬,15;FILING_REMARKS=��ע,15;ARCHIVE_VALID=�Ƿ���Ч,15;"/></td>
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