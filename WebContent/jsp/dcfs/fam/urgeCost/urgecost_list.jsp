<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: urgecost_list.jsp
 * @Description:  ���ô߽��б�
 * @author yangrt
 * @date 2014-10-20 ����14:27:38 
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
	<BZ:head>
		<title>���ô߽��б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"fam/urgecost/UrgeCostList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_CHILD_NUM").value = "";
			document.getElementById("S_S_CHILD_NUM").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_COST_TYPE").value = "";
			document.getElementById("S_PAR_VALUE").value = "";
			document.getElementById("S_PAY_DATE_START").value = "";
			document.getElementById("S_PAY_DATE_END").value = "";
			document.getElementById("S_ARRIVE_STATE").value = "";
			document.getElementById("S_ARRIVE_VALUE").value = "";
			document.getElementById("S_ARRIVE_DATE_START").value = "";
			document.getElementById("S_ARRIVE_DATE_END").value = "";
			document.getElementById("S_COLLECTION_STATE").value = "";
			document.getElementById("S_NOTICE_STATE").value = "";
		}
		
		//¼��
		function _addNotice(){
			document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeShow.action?type=add";
			document.srcForm.submit();
		}
		
		//ͳ��¼��
		function _batchAddNotice(){
			document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeBatchAdd.action";
			document.srcForm.submit();
		}
		
		//�޸�
		function _updateNotice(){
			var num = 0;
			var rm_id = "";	//�߽ɼ�¼ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "0"){
						rm_id = arrays[i].value;
						num++;
					}else{
						page.alert("��ѡ��һ��֪ͨ״̬Ϊδ֪ͨ����Ϣ��");
						return;
					}
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ��֪ͨ״̬Ϊδ֪ͨ����Ϣ��');
				return;
			}else{
				document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeShow.action?type=mod&RM_ID=" + rm_id;
				document.srcForm.submit();
			}
		}
		
		//����ɾ��
		function _batchDelete(){
			var num = 0;
			var rm_id = [];	//�߽ɼ�¼ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "0"){
						rm_id[num++] = arrays[i].value;
					}else{
						page.alert("��ѡ��֪ͨ״̬Ϊδ֪ͨ����Ϣ��");
						return;
					}
				}
			}
			if(num == 0){
				page.alert('��ѡ��֪ͨ״̬Ϊδ֪ͨ����Ϣ��');
				return;
			}else{
				document.getElementById("batchID").value = rm_id.join(";");
				document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeBatchDelete.action";
				document.srcForm.submit();
			}
		}
		
		//֪ͨ
		function _batchSubmit(){
			var num = 0;
			var rm_id = [];	//�߽ɼ�¼ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "0"){
						rm_id[num++] = arrays[i].value;
					}else{
						page.alert("��ѡ��֪ͨ״̬Ϊδ֪ͨ����Ϣ��");
						return;
					}
				}
			}
			if(num == 0){
				page.alert('��ѡ��֪ͨ״̬Ϊδ֪ͨ����Ϣ��');
				return;
			}else{
				document.getElementById("batchID").value = rm_id.join(";");
				document.srcForm.action=path+"fam/urgecost/UrgeCostNoticeBatchSubmit.action";
				document.srcForm.submit();
			}
		}
		
		//�ɷѷ���¼��
		function _addCostData(){
			var num = 0;
			var rm_id = "";	//�߽ɼ�¼ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("NOTICE_STATE");
					if(state == "1"){
						rm_id = arrays[i].value;
						num++;
					}else{
						page.alert("��ѡ��һ��֪ͨ״̬Ϊ��֪ͨ����Ϣ��");
						return;
					}
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ��֪ͨ״̬Ϊ��֪ͨ����Ϣ��');
				return;
			}else{
				document.srcForm.action=path+"fam/urgecost/UrgeCostFeedBackAdd.action?RM_ID=" + rm_id;
				document.srcForm.submit();
			}
		}
		
		//���˷���¼��
		function _addReceiveData(){
			var num = 0;
			var CHEQUE_ID = "";	//Ʊ�ݵǼ�ID
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("ARRIVE_STATE");	//����״̬
					if(state == "0" ){
						CHEQUE_ID = arrays[i].getAttribute("CHEQUE_ID");
						num++;
					}else{
						page.alert("��ѡ��һ���ɷ�״̬Ϊ��ȷ�ϵ���Ϣ��");
						return;
					}
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ���ɷ�״̬Ϊ��ȷ�ϵ���Ϣ��');
				return;
			}else{
				document.srcForm.action=path+"fam/urgecost/UrgeCostReceiveAdd.action?CHEQUE_ID=" + CHEQUE_ID;
				document.srcForm.submit();
			}
		}
		
		//����
		function _reviseAccount(){
			var num = 0;
			var CHEQUE_ID = "";	//Ʊ�ݵǼ�id
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("ARRIVE_STATE");
					if(state == "2"){
						CHEQUE_ID = arrays[i].value;
						num++;
					}else{
						page.alert("��ѡ��һ������״̬Ϊ�����Ʊ����Ϣ��");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('��ѡ��һ������״̬Ϊ�����Ʊ����Ϣ��');
				return;
			}else{
				document.srcForm.action=path+"fam/receiveconfirm/ReviseAccountAdd.action?CHEQUE_ID="+CHEQUE_ID;
				document.srcForm.submit();
			}
		}

		//����
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;FYLB;JFFS;">
		<BZ:form name="srcForm" method="post" action="fam/urgecost/UrgeCostList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="batchID" id="batchID" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="�ɷѱ��">�ɷѱ��</span></td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" defaultValue="" formTitle="�ɷѱ��" maxlength="14"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">����</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="GJSY" width="93%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 34%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">������ͯ����</td>
								<td>
									<BZ:input prefix="S_" field="CHILD_NUM" id="S_CHILD_NUM" defaultValue="" formTitle="" restriction="int"/>
								</td>
								
								<td class="bz-search-title">�����ͯ����</td>
								<td>
									<BZ:input prefix="S_" field="S_CHILD_NUM" id="S_S_CHILD_NUM" defaultValue="" formTitle="" restriction="int"/>
								</td>
								
								<td class="bz-search-title">֪ͨ����</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="COST_TYPE" id="S_COST_TYPE" isCode="true" codeName="FYLB" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�ɷѽ��</td>
								<td>
									<BZ:input prefix="S_" field="PAR_VALUE" id="S_PAR_VALUE" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>	
								
								<td class="bz-search-title">�ɷ�����</td>
								<td>
									<BZ:input prefix="S_" field="PAY_DATE_START" id="S_PAY_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PAY_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="PAY_DATE_END" id="S_PAY_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PAY_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="ARRIVE_STATE" id="S_ARRIVE_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��ȷ��</BZ:option>
										<BZ:option value="1">���</BZ:option>
										<BZ:option value="2">����</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">���˽��</td>
								<td>
									<BZ:input prefix="S_" field="ARRIVE_VALUE" id="S_ARRIVE_VALUE" defaultValue="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="ARRIVE_DATE_START" id="S_ARRIVE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ARRIVE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="ARRIVE_DATE_END" id="S_ARRIVE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ARRIVE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="COLLECTION_STATE" id="S_COLLECTION_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ����</BZ:option>
										<BZ:option value="1">������</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">֪ͨ״̬</td>
								<td>
									<BZ:select prefix="S_" field="NOTICE_STATE" id="S_NOTICE_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ֪ͨ</BZ:option>
										<BZ:option value="1">��֪ͨ</BZ:option>
										<BZ:option value="2">�ѷ���</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="¼&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_addNotice()"/>&nbsp;
					<input type="button" value="ͳ��¼��" class="btn btn-sm btn-primary" onclick="_batchAddNotice()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_updateNotice()"/>
					<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_batchDelete()"/>&nbsp;
					<input type="button" value="ͨ&nbsp;&nbsp;֪" class="btn btn-sm btn-primary" onclick="_batchSubmit()"/>&nbsp;
					<input type="button" value="�ɷѷ���¼��" class="btn btn-sm btn-primary" onclick="_addCostData()"/>&nbsp;
					<input type="button" value="���˷���¼��" class="btn btn-sm btn-primary" onclick="_addReceiveData()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
								<th style="width: 2%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PAID_NO">�ɷѱ��</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COST_TYPE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="CHILD_NUM">������ͯ����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="S_CHILD_NUM">�����ͯ����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICE_DATE">֪ͨ����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICE_DATE">�ɷ�����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PAR_VALUE">�ɷѽ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ARRIVE_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_VALUE">���˽��</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ARRIVE_STATE">�ɷ�״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COLLECTION_STATE">����״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NOTICE_STATE">֪ͨ״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" 
										value="<BZ:data field="RM_ID" onlyValue="true"/>"
										CHEQUE_ID="<BZ:data field="CHEQUE_ID" onlyValue="true"/>"
									 	NOTICE_STATE="<BZ:data field="NOTICE_STATE" onlyValue="true"/>"
									 	ARRIVE_STATE="<BZ:data field="ARRIVE_STATE" onlyValue="true"/>"
									 	class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COST_TYPE" defaultValue="" codeName="FYLB" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="S_CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ARRIVE_STATE" defaultValue="" checkValue="0=��ȷ��;1=���;2=����;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="COLLECTION_STATE" defaultValue="" onlyValue="true" checkValue="0=δ����;1=������;"/></td>
								<td class="center"><BZ:data field="NOTICE_STATE" defaultValue="" onlyValue="true" checkValue="0=δ֪ͨ;1=��֪ͨ;2=�ѷ���;"/></td>
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
							<td>
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="���ô߽���Ϣ" 
									exportCode="COUNTRY_CODE=CODE,GJSY;COST_TYPE=CODE,FYLB;NOTICE_DATE=DATE;ARRIVE_DATE=DATE;ARRIVE_STATE=FLAG,0:��ȷ��&1:���&2:����;COLLECTION_STATE=FLAG,0:δ����&1:������;NOTICE_STATE=FLAG,0:δ֪ͨ&1:��֪ͨ&2:�ѷ���;" 
									exportField="PAID_NO=�ɷѱ��,15,20;COST_TYPE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,15;CHILD_NUM=������ͯ����,15;S_CHILD_NUM=�����ͯ����,15;NOTICE_DATE=֪ͨ����,15;PAR_VALUE=�ɷѽ��,15;ARRIVE_DATE=��������,15;ARRIVE_VALUE=���˽��,15;ARRIVE_STATE=�ɷ�״̬,15;COLLECTION_STATE=����״̬,15;NOTICE_STATE=֪ͨ״̬,15;"/>
							</td>
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