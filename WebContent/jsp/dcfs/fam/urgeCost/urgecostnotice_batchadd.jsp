<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String flag = (String)request.getAttribute("FLAG");
	String SEARCH_TYPE = (String)request.getAttribute("SEARCH_TYPE");
	String DATE_START = (String)request.getAttribute("DATE_START");
	String DATE_END = (String)request.getAttribute("DATE_END");
%>
<BZ:html>
	<BZ:head>
		<title>�߽�֪ͨ���ҳ��</title>
		<BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
				var flag = "<%=flag %>";
				if(flag == "true"){
					$(".table-responsive").show();
					$(".footer-frame").show();
				}else{
					$(".table-responsive").hide();
					$(".footer-frame").hide();
				}
				
			});
			
			//ͳ��
			function _search(){
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else{
					document.srcForm.action = path+"fam/urgecost/UrgeCostStatisticsList.action";
					document.srcForm.submit();
				}
			}
			
			//���ɽɷ�֪ͨ
			function _addNotice(){
				var size = "<%=request.getAttribute("ListSize") %>";
				if(size == "0" || size == null || size == "null"){
					page.alert("�������ɿյķ��ô߽�֪ͨ��Ϣ��");
					return;
				}else{
					document.srcForm.action = path+"fam/urgecost/UrgeCostBatchNoticeSave.action?&SEARCH_TYPE=<%=SEARCH_TYPE %>&DATE_START=<%=DATE_START %>&DATE_END=<%=DATE_END %>";
					document.srcForm.submit();
				}
			}
			
			//�鿴�ļ��б�
			function _showDetail(countrycode,orgcode){
				var url = path+"fam/urgecost/ShowFileChildList.action?COUNTRY_CODE=" + countrycode + "&ADOPT_ORG_ID=" + orgcode + "&SEARCH_TYPE=<%=SEARCH_TYPE %>&DATE_START=<%=DATE_START %>&DATE_END=<%=DATE_END %>";
				_open(url,this,960,400);
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"fam/urgecost/UrgeCostList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;FYLB;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="fam/urgecost/UrgeCostStatisticsList.action">
		<!-- ��������begin -->
		<input type="hidden" name="SEARCH_TYPE" value=""/>
		<input type="hidden" name="DATE_START" value=""/>
		<input type="hidden" name="DATE_END" value=""/>
		
		<BZ:input type="hidden" prefix="R_" field="SEARCH_TYPE" id="R_SEARCH_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="DATE_START" id="R_DATE_START" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="DATE_END" id="R_DATE_END" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="ͳ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_search()"/>&nbsp;
					<input type="button" value="���ɴ߰�֪ͨ" class="btn btn-sm btn-primary" onclick="_addNotice()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!-- ͳ����������begin -->
				<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;margin-top: 0px;">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="20%">����</td>
									<td class="bz-edit-data-value" width="30%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="70%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<td class="bz-edit-data-title" width="20%">������֯</td>
									<td class="bz-edit-data-value" width="30%"> 
										<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="" width="70%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--��ѡ��--</option>
										</BZ:select>
										<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title"><font color="red">*</font>ͳ������</td>
									<td class="bz-edit-data-value">
										<BZ:select prefix="S_" field="SEARCH_TYPE" id="S_SEARCH_TYPE" formTitle="" defaultValue="" width="70%;">
											<BZ:option value="1">�����������ȷ������</BZ:option>
											<BZ:option value="2">��������֪ͨ��ǩ������</BZ:option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title"><font color="red">*</font>����</td>
									<td class="bz-edit-data-value">
										<BZ:input prefix="S_" field="DATE_START" id="S_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_DATE_END\\')}',readonly:true" defaultValue="" notnull="��ʼ���ڲ���Ϊ�գ�" formTitle=""/>~
										<BZ:input prefix="S_" field="DATE_END" id="S_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_DATE_START\\')}',readonly:true" defaultValue="" notnull="��ֹ���ڲ���Ϊ�գ�" formTitle=""/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!-- ͳ����������end -->
				<!-- ͳ���б�����begin -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">����</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">������֯���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">������ͯ����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">�����ͯ����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">С��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">Ӧ�ɽ��</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td>
									<BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/>
									<BZ:input prefix="L" field="COUNTRY_CODE" type="hidden" property="myData" defaultValue=""/>	
								</td>
								<td>
									<BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
									<BZ:input prefix="L" field="NAME_CN" type="hidden" property="myData" defaultValue=""/>
									<BZ:input prefix="L" field="NAME_EN" type="hidden" property="myData" defaultValue=""/>
								</td>
								<td class="center">
									<BZ:data field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>
									<BZ:input prefix="L" field="ADOPT_ORG_ID" type="hidden" property="myData" defaultValue=""/>	
								</td>
								<td>
									<BZ:data field="CHILD_NUM" defaultValue="" onlyValue="true"/>
									<BZ:input prefix="L" field="CHILD_NUM" type="hidden" property="myData" defaultValue=""/>
								</td>
								<td>
									<BZ:data field="S_CHILD_NUM" defaultValue="" onlyValue="true"/>
									<BZ:input prefix="L" field="S_CHILD_NUM" type="hidden" property="myData" defaultValue=""/>
								</td>
								<td>
									<a href="#" onclick="_showDetail('<BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true"/>','<BZ:data field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="SUM" defaultValue="" onlyValue="true"/>
									</a>
								</td>
								<td>
									<BZ:data field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
									<BZ:input prefix="L" field="PAID_SHOULD_NUM" type="hidden" property="myData" defaultValue=""/>
								</td>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!-- ͳ���б�����end -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td>
								<BZ:page form="srcForm" property="List"/>
							</td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		<!-- ��ť����end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>