<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: ������֯Ԥ������(δ����)
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
		<title>������֯Ԥ�������б�</title>
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
				area: ['1050px','360px'],
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
		//�ر�
		function _goback(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		//ȷ��
		function _confirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				 document.srcForm.action=path+"info/SYZZREQInfoReason.action?id="+ids;
				 document.srcForm.submit();
			}
		}

		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"info/SYZZREQInfoApplicatList.action?page=1";
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
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REMINDERS_STATE").value = "";
			document.getElementById("S_REM_DATE_START").value = "";
			document.getElementById("S_REM_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_LAST_UPDATE_DATE_START").value = "";
			document.getElementById("S_LAST_UPDATE_DATE_END").value = "";
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;YPZT;">
		<BZ:form name="srcForm"  method="post" action="info/SYZZREQInfoApplicatList.action">
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
								<td class="bz-search-title" style="width: 9%;">�з�<br>Adoptive father</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">Ů��<br>Adoptive mother</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								<td class="bz-search-title" style="width: 9%;">��ͯ����<br>Child name</td>
								<td style="width: 27%;">
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
								<td class="bz-search-title">��������<br>Date of application</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">���ı��<br>Log-in No.</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								<td class="bz-search-title">��������<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">��ǰ�ļ��ݽ�����<br>Document submission deadline</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ǰ�ļ��ݽ���ʼ����" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ǰ�ļ��ݽ���ֹ����" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�߰�״̬<br>Reminder status</td>
								<td>
									<BZ:select prefix="S_" field="REMINDERS_STATE" id="S_REMINDERS_STATE" formTitle="Reminder status" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">un-reminded</BZ:option>
										<BZ:option value="1">reminded</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�߰�����<br>Reminder date </td>
								<td>
									<BZ:input prefix="S_" field="REM_DATE_START" id="S_REM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ�߰�����" />~
									<BZ:input prefix="S_" field="REM_DATE_END" id="S_REM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�߰�����" />
								</td>
								<td class="bz-search-title">Ԥ��״̬<br>Pre-approval status</td>
								<td>
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" isCode="true" codeName="YPZT" isShowEN="true" formTitle="Ԥ��״̬" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����������<br>Last updated</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="LAST_UPDATE_DATE_START" id="S_LAST_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_LAST_UPDATE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="LAST_UPDATE_DATE_END" id="S_LAST_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_LAST_UPDATE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">������<br>Response date</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ������" />~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ������" />
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
					<input type="button" value="Confirm" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<!-- <input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp; -->
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
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
								<th style="width: 6%;">
									<div class="sorting" id="MALE_NAME">�з�(Adoptive father)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FEMALE_NAME">Ů��(Adoptive mother)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">����(Child name)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="REQ_DATE">��������(Date of application)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PASS_DATE">������(Response date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RI_STATE">Ԥ��״̬(Pre-approval status)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SUBMIT_DATE">��ǰ�ļ��ݽ�����(Document submission deadline)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REMINDERS_STATE">�߰�״̬(Reminder status)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REM_DATE">�߰�����(Reminder date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">��������(Log-in date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">���ı��(Log-in No.)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="LAST_UPDATE_DATE">����������(Last updated)</div>
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
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="REQ_DATE" defaultValue="" type="date"  onlyValue="true"/></td>
								<td><BZ:data field="PASS_DATE" defaultValue="" type="date"  onlyValue="true"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" codeName="YPZT" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="SUBMIT_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="REMINDERS_STATE" defaultValue="" checkValue="0=un-reminded;1=reminded;"  onlyValue="true"/></td>
								<td><BZ:data field="REM_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="LAST_UPDATE_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
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
								<BZ:page form="srcForm" type="EN" property="List" exportXls="true" exportTitle="���������б�" exportCode="SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;REQ_DATE=DATE;RI_STATE=CODE,YPZT;SUBMIT_DATE=DATE;REMINDERS_STATE=FLAG,0:un-reminded&1:reminded;REM_DATE=DATE;REGISTER_DATE=DATE;LAST_UPDATE_DATE=DATE;"  exportField="MALE_NAME=�з�(Adoptive father),15,20;FEMALE_NAME=Ů��(Adoptive mother),15;NAME=����(Child name),15;SEX=�Ա�(Sex),15;BIRTHDAY=��������(D.O.B),15;REQ_DATE=��������(Date of application),15;RI_STATE=Ԥ��״̬(Pre-approval status),15;SUBMIT_DATE=��ǰ�ļ��ݽ�����(Document submission deadline),15;REMINDERS_STATE=�߰�״̬(Reminder status),15;REM_DATE=�߰�����(Reminder date),15;REGISTER_DATE=��������(Log-in date),15;FILE_NO=���ı��(Log-in No.),15;LAST_UPDATE_DATE=����������(Last updated),15;"/>
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