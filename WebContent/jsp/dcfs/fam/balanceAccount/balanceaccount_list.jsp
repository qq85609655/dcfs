<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: balanceaccount_list.jsp
 * @Description:  ������֯����˻���ѯ�б�
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
		<title>������֯����˻���ѯ�б�</title>
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
			document.srcForm.action=path+"fam/balanceaccount/BalanceAccountList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_ADOPT_ORG_NO").value = "";
			document.getElementById("S_ACCOUNT_CURR").value = "";
			document.getElementById("S_ACCOUNT_LMT").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//ά��
		function _reviseAccount(){
			var num = 0;
			var ADOPT_ORG_ID = "";	//������֯code
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ADOPT_ORG_ID = arrays[i].value;
					num++;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ��������֯��Ϣ��');
				return;
			}else{
				document.srcForm.action=path+"fam/balanceaccount/BalanceAccountAdd.action?ADOPT_ORG_ID="+ADOPT_ORG_ID;
				document.srcForm.submit();
			}
		}
		
		//�˻���ϸ
		function _showDetail(){
			document.srcForm.action=path+"fam/balanceaccount/BalanceAccountDetailList.action?type=false";
			document.srcForm.submit();
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
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="fam/balanceaccount/BalanceAccountList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 15%">����</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="88%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 15%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title" style="width: 15%">������֯���</td>
								<td style="width: 19%">
									<BZ:input prefix="S_" field="ADOPT_ORG_NO" id="S_ADOPT_ORG_NO" defaultValue="" formTitle=""/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��ǰ���</td>
								<td>
									<BZ:input prefix="S_" field="ACCOUNT_CURR" id="S_ACCOUNT_CURR" defaultValue="" restriction="number" maxlength="22" formTitle=""/>
								</td>
								
								<td class="bz-search-title">͸֧���</td>
								<td>
									<BZ:input prefix="S_" field="ACCOUNT_LMT" id="S_ACCOUNT_LMT" defaultValue="" formTitle="" restriction="number" maxlength="22"/>
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
					<input type="button" value="ά&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_reviseAccount()"/>&nbsp;
					<input type="button" value="�˺���ϸ" class="btn btn-sm btn-primary" onclick="_showDetail()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 4%;">
									<div class="sorting_disabled">ѡ��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 30%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ADOPT_ORG_NO">������֯���</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ACCOUNT_CURR">��ǰ���</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="ACCOUNT_LMT">͸֧���</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="ADOPT_ORG_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ADOPT_ORG_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/></td>
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
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="������֯�����˻���Ϣ" 
									exportCode="COUNTRY_CODE=CODE,GJSY;" 
									exportField="COUNTRY_CODE=����,15,20;NAME_CN=������֯,15;ADOPT_ORG_NO=������֯���,15;ACCOUNT_CURR=��ǰ���,15;ACCOUNT_LMT=͸֧���,15;"/>
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