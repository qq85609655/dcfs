<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: balanceaccountdetail_list.jsp
 * @Description:  ������֯����˻���ϸ�б�
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
		<title>������֯����˻���ϸ�б�</title>
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
				area: ['800px','160px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"fam/balanceaccount/BalanceAccountDetailList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_OPP_DATE_START").value = "";
			document.getElementById("S_OPP_DATE_END").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//�����б�ҳ��
		function _goback(){
			window.location.href=path+"fam/balanceaccount/BalanceAccountList.action";
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
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="fam/balanceaccount/BalanceAccountDetailList.action">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ��������begin -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 20%">����</td>
								<td style="width: 30%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="93%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 20%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 30%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�˵�����</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="OPP_DATE_START" id="S_OPP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_OPP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ¼������" />~
									<BZ:input prefix="S_" field="OPP_DATE_END" id="S_OPP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_OPP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ¼������" />
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADOPT_ORG_NAME">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PAID_NO">�ɷѱ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_TYPE">�˵�����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_DATE">�˵�����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SUM">�˵����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="OPP_USERNAME">������</div>
								</th>
								<th style="width: 26%;">
									<div class="sorting_disabled" id="REMARKS">��ע</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="OPP_TYPE" defaultValue="" checkValue="0=����;1=����;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="OPP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="SUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="OPP_USERNAME" defaultValue="" onlyValue="true"/></td>
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
							<td>
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="����˻�ʹ����ϸ��Ϣ"
									exportCode="COUNTRY_CODE=CODE,GJSY;OPP_TYPE=FLAG,0:����&1:����;"
									exportField="COUNTRY_CODE=����,15,20;ADOPT_ORG_NAME=������֯,15;PAID_NO=�ɷѱ��,15;OPP_TYPE=�˵�����,15;OPP_DATE=�˵�����,15;SUM=�˵����,15;OPP_USERNAME=������,15;REMARKS=��ע,30;"/>
							</td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>