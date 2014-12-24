<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: ������֯����Ԥ��(�ѳ���)
 * @author lihf 
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
	<BZ:head language="EN">
		<title>������֯����Ԥ���б�</title>
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
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//����
		function _export(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//�鿴
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
			   document.srcForm.action=path+"info/SYZZREQInfoSearchById.action?id="+ids;
			   document.srcForm.submit();
			}
		}
		//��������
		function _xuanze(){
			$.layer({
				type: 2,
				closeBtn: [0, false],
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {
					src: path+'info/SYZZREQInfoApplicatList.action'
				},
				title: "ѡ��Ҫ������Ԥ������",
				area: ['1100px','600px'],
				offset: ['0px' , '20px']
			});
		}
		
		//��������
		function xuanze2(){
			document.srcForm.action=path+"info/SYZZREQInfoApplicatList.action?type=one";
			document.srcForm.submit();
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"info/SYZZREQInfoList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REVOKE_REQ_DATE_END").value = "";
			document.getElementById("S_REVOKE_CFM_DATE_START").value = "";
			document.getElementById("S_REVOKE_CFM_DATE_END").value = "";
			document.getElementById("S_REVOKE_STATE").value = "";
		}
		
		//�ύԤ��������ˢ���б�
		function _returnYP(result){
			layer.closeAll();
			document.srcForm.action=path+"info/SYZZREQInfoList.action&result="+result;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;DFLX;TXRTFBTHLX">
		<BZ:form name="srcForm"  method="post" action="info/SYZZREQInfoList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="a" value="a"/>
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
								<td class="bz-search-title" style="width: 10%;">�з�<br>Adoptive father</td>
								<td style="width: 13%;">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 10%;">Ů��<br>Adoptive mother</td>
								<td style="width: 29%;">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								<td class="bz-search-title" style="width: 10%;">��ͯ����<br>Child name</td>
								<td style="width: 29%;">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" isShowEN="true" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">���볷������<br>Date of application withdrawal </td>
								<td>
									<BZ:input prefix="S_" field="REVOKE_REQ_DATE_START" id="S_REVOKE_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REVOKE_REQ_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ���볷������" />~
									<BZ:input prefix="S_" field="REVOKE_REQ_DATE_END" id="S_REVOKE_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REVOKE_REQ_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ���볷������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����ȷ������<br>Date of withdrawal confirmation</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="REVOKE_CFM_DATE_START" id="S_REVOKE_CFM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REVOKE_CFM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼȷ�ϳ�������" />~
									<BZ:input prefix="S_" field="REVOKE_CFM_DATE_END" id="S_REVOKE_CFM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REVOKE_CFM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="����ȷ�ϳ�������" />
								</td>
								<td class="bz-search-title">����״̬<br>Withdrawal status</td>
								<td colspan="3">
									<BZ:select prefix="S_" field="REVOKE_STATE" id="S_REVOKE_STATE" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be confirmed</BZ:option>
										<BZ:option value="1">confirmed</BZ:option>
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
					<input type="button" value="Cancel application" class="btn btn-sm btn-primary" onclick="xuanze2()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">�з�(Adoptive father)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů��(Adoptive mother)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME">��ͯ����(Child name)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVOKE_REQ_DATE">���볷������(Date of application withdrawal)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVOKE_CFM_DATE">����ȷ������(Date of withdrawal confirmation)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVOKE_STATE">����״̬(Withdrawal status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" isShowEN="true" codeName="ETXB" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="REVOKE_REQ_DATE" defaultValue="" type="date"  onlyValue="true"/></td>
								<td><BZ:data field="REVOKE_CFM_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="REVOKE_STATE" defaultValue="" checkValue="0=to be confirmed;1=confirmed;"  onlyValue="true"/></td>
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
								<BZ:page form="srcForm" property="List" type="EN" exportXls="true" exportTitle="����Ԥ��" exportCode="SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;REVOKE_REQ_DATE=DATE;REVOKE_CFM_DATE=DATE;REVOKE_STATE=FLAG,0:to be confirmed&1:confirmed;" exportField="MALE_NAME=�з�(Adoptive father),15,20;FEMALE_NAME=Ů��(Adoptive mother),15;NAME=����(Child name),15;SEX=�Ա�(Sex),15;BIRTHDAY=��������(D.O.B),15;REVOKE_REQ_DATE=���볷������(Date of application withdrawal),15;REVOKE_CFM_DATE=����ȷ������(Date of withdrawal confirmation),15;REVOKE_STATE=����״̬(Withdrawal status),15;"/>
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