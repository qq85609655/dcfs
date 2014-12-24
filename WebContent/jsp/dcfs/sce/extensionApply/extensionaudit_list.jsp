<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: extensionaudit_list.jsp
 * @Description: ������������б�
 * @author yangrt
 * @date 2014-9-28
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
		<title>������������б�</title>
		<BZ:webScript list="true" isAjax="true" tree="true"/>
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
			document.srcForm.action=path+"sce/extensionapply/ExtensionAuditList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_AUDIT_STATE").value = "";
			document.getElementById("S_REQ_SUBMIT_DATE_START").value = "";
			document.getElementById("S_REQ_SUBMIT_DATE_END").value = "";
			document.getElementById("S_AUDIT_DATE_START").value = "";
			document.getElementById("S_AUDIT_DATE_END").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//���ҳ����ת
		function _audit(){
			var num = 0;
			var def_id = "";
			var state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					state = arrays[i].getAttribute("AUDIT_STATE");
					if(state == "0"){
						def_id = arrays[i].value;
						num += 1;
					}else{
						page.alert('��ѡ��һ������״̬Ϊ����˵����ݣ�');
						return;
					}
					
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ������״̬Ϊ����˵����ݣ�');
				return;
			}else{
				document.srcForm.action=path+"sce/extensionapply/ExtensionAuditAdd.action?DEF_ID=" + def_id;
				document.srcForm.submit();
			}
		}
		
		//�鿴ҳ����ת
		function _show(){
			var num = 0;
			var def_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					def_id = arrays[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ�����ݣ�');
				return;
			}else{
				document.srcForm.action= path +"sce/extensionapply/ExtensionApplyShow.action?type=audit&DEF_ID=" + def_id;
				document.srcForm.submit();
			}
			
		}
		
		//�б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}

	</script>
	<BZ:body property="data" codeNames="GJSY;ETXB;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="sce/extensionapply/ExtensionAuditList.action">
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
								<td class="bz-search-title" style="width: 10%">
									<span title="����">����</span>
								</td>
								<td style="width: 15%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="88%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 12%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 15%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title" style="width: 12%">��������</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">�ļ��ݽ�����</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��ͯ����</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="88%" >
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="AUDIT_STATE" id="S_AUDIT_STATE" formTitle="" defaultValue="" width="88%" >
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">�����</BZ:option>
										<BZ:option value="1">ͨ��</BZ:option>
										<BZ:option value="2">��ͨ��</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��ʱ�ݽ�����</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="REQ_SUBMIT_DATE_START" id="S_REQ_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REQ_SUBMIT_DATE_END" id="S_REQ_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="AUDIT_DATE_START" id="S_AUDIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_AUDIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="AUDIT_DATE_END" id="S_AUDIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_AUDIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
								
								<td style="text-align: center;" colspan="2">
									<div class="bz-search-button">
										<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
										<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������End -->
		
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">ѡ��</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 7%;">
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
								<th style="width: 7%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REQ_DATE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SUBMIT_DATE">�ļ��ݽ�����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REQ_SUBMIT_DATE">��ʱ�ݽ�����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AUDIT_DATE">�������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AUDIT_STATE">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="DEF_ID" onlyValue="true"/>" AUDIT_STATE="<BZ:data field="AUDIT_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REQ_SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_STATE" defaultValue="" onlyValue="true" checkValue="0=�����;1=ͨ��;2=��ͨ��;"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="��������������Ϣ" 
							exportCode="COUNTRY_CODE=CODE,GJSY;SEX=CODE,ETXB;BIRTHDAY=DATE;REQ_DATE=DATE;SUBMIT_DATE=DATE;REQ_SUBMIT_DATE=DATE;AUDIT_DATE=DATE;AUDIT_STATE=FLAG,0:�����&1:ͨ��&2:��ͨ��;"
							exportField="COUNTRY_CODE=����,15,20;ADOPT_ORG_NAME_CN=������֯,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;NAME=��ͯ����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;REQ_DATE=��������,15;SUBMIT_DATE=�ļ��ݽ�����,15;REQ_SUBMIT_DATE=��ʱ�ݽ�����,15;AUDIT_DATE=�������,15;AUDIT_STATE=����״̬,15;"/></td>
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