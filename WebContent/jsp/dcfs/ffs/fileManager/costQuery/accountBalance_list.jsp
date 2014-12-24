<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: accountBalance_list.jsp
	 * @Description:  �˻������Ϣ�б�
	 * @author yangrt   
	 * @date 2014-08-29 15:03:34 
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
		<title>�˻������Ϣ�б�</title>
		<BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
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
				area: ['1000px','140px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/AccountBalanceList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_OPP_TYPE").value = "";
			document.getElementById("S_SUM").value = "";
			document.getElementById("S_OPP_USERNAME").value = "";
			document.getElementById("S_OPP_DATE_START").value = "";
			document.getElementById("S_OPP_DATE_END").value = "";
		}
		
		//�鿴�ļ���ϸ��Ϣ
		function _showAccountData(){
			var num = 0;
			var ACCOUNT_LOG_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ACCOUNT_LOG_ID = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				alert("Please select one data!");
				return;
			}else{
				document.srcForm.action=path + "ffs/filemanager/AccountBalanceShow.action?ACCOUNT_LOG_ID=" + ACCOUNT_LOG_ID;
				document.srcForm.submit();
			}
		}
		
		//�ļ��б���
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				/* document.srcForm.action=path+"ffs/filemanager/PaymentExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/PaymentList.action"; */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="searchData">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/AccountBalanceList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 15%">�ɷѱ��<br>Bill number</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" defaultValue="" formTitle="" maxlength="14"/>
								</td>
								
								<td class="bz-search-title" style="width: 15%">�˵����<br>Amount</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="SUM" id="S_SUM" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
								</td>
								
								<td class="bz-search-title" style="width: 15%">��������<br>Type</td>
								<td style="width: 19%">
									<BZ:select prefix="S_" field="OPP_TYPE" id="S_OPP_TYPE" defaultValue="" formTitle="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">transfer money to</BZ:option>
										<BZ:option value="1">transfer money from</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title">������<br>Operator</td>
								<td>
									<BZ:input prefix="S_" field="OPP_USERNAME" id="S_OPP_USERNAME" defaultValue="" formTitle="" maxlength="256"/>
								</td>
								
								<td class="bz-search-title">��������<br>Date</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="OPP_DATE_START" id="S_OPP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_OPP_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="OPP_DATE_END" id="S_OPP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_OPP_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
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
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�˻�������Ϣ(Account balance information)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">������֯<br>Agency</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ADOPT_ORG_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�˻����<br>Account balance</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">͸֧���<br>Credit limit</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�鿴����" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ɷѵ���ϸ�б�(Transaction details)</div>
				</div>
			</div>
		</div>
		
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
					<input type="button" value="Check payment bill" class="btn btn-sm btn-primary" onclick="_showAccountData()"/>
					<!-- <input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/> -->
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">&nbsp;</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PAID_NO">�ɷѱ��(Bill number)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_TYPE">��������(Type)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SUM">�˵����(Amount)</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="OPP_USERNAME">������(Operator)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="OPP_DATE">��������(Date)</div>
								</th>
								<th style="width: 30%;">
									<div class="sorting" id="REMARKS">��ע(Remarks)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="ACCOUNT_LOG_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/>								</td>
								<td class="center"><BZ:data field="OPP_TYPE" checkValue="0=transfer money to;1=transfer money from;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPP_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="OPP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="REMARKS" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN" /></td>
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