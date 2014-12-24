<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: ���ò�Ԥ������
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
	<BZ:head>
		<title>���ò�Ԥ�������б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
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
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//����
		function _export(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//ȷ��
		function _confirm(){
			var num = 0;
			var ids="";
			var yptype="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var REVOKE_STATE = id.split(",")[1];
					if(REVOKE_STATE !="0"){
						page.alert('��ѡ���ȷ�ϵ�����');
						return ;
					}
					ids = id.split(",")[0];
					yptype = id.split(",")[2];
					num += 1;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				if(yptype=="7"){
					page.alert('���Ƚ��ƥ��');
					return;
				}else{
					document.srcForm.action=path+"info/AZBREQInfoSearchById.action?id="+ids+"&type=revise";
					document.srcForm.submit();
				}
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
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.srcForm.action=path+"info/AZBREQInfoSearchById.action?id="+ids+"&type=show";
			   document.srcForm.submit();
			}
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"info/AZBREQInfoList.action?page=1";
			document.srcForm.submit();
		}
		
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_REVOKE_REQ_DATE_START").value= "";
			document.getElementById("S_REVOKE_REQ_DATE_END").value = "";
			document.getElementById("S_REVOKE_CFM_DATE_START").value = "";
			document.getElementById("S_REVOKE_CFM_DATE_END").value = "";
			document.getElementById("S_REVOKE_STATE").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm"  method="post" action="info/AZBREQInfoList.action">
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
								<td class="bz-search-title" style="width: 8%;">����</td>
								<td style="width: 18%;">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="88%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 9%;">������֯</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								<td class="bz-search-title" style="width: 9%;">��������</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="" />
								</td>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="REVOKE_REQ_DATE_START" id="S_REVOKE_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REVOKE_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REVOKE_REQ_DATE_END" id="S_REVOKE_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REVOKE_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ȷ������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="REVOKE_CFM_DATE_START" id="S_REVOKE_CFM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REVOKE_CFM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼȷ������" />~
									<BZ:input prefix="S_" field="REVOKE_CFM_DATE_END" id="S_REVOKE_CFM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REVOKE_CFM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="����ȷ������" />
								</td>
								<td class="bz-search-title">����״̬</td>
								<td colspan="3">
									<BZ:select prefix="S_" field="REVOKE_STATE" id="S_REVOKE_STATE" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��ȷ��</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
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
					<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADOPT_ORG_NAME_CN">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVOKE_REQ_DATE">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVOKE_CFM_DATE">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVOKE_STATE">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="REVOKE_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="RI_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REVOKE_REQ_DATE" defaultValue="" type="date"  onlyValue="true"/></td>
								<td><BZ:data field="REVOKE_CFM_DATE" defaultValue=""  type="date" onlyValue="true"/></td>
								<td><BZ:data field="REVOKE_STATE" defaultValue="" checkValue="0=��ȷ��;1=��ȷ��;" onlyValue="true"/></td>
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
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="Ԥ������" exportCode="COUNTRY_CODE=CODE,GJSY;REVOKE_REQ_DATE=DATE;REVOKE_CFM_DATE=DATE;REVOKE_STATE=FLAG,0:��ȷ��&1:��ȷ��;" exportField="COUNTRY_CODE=����,15,20;ADOPT_ORG_NAME_CN=��֯����,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;NAME=����,15;REVOKE_REQ_DATE=��������,15;REVOKE_CFM_DATE=ȷ������,15;REVOKE_STATE=����״̬,15;"/>
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