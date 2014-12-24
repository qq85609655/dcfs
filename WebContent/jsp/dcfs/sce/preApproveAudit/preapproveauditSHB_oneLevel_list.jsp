<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapproveauditSHB_oneLevel_list.jsp
 * @Description: ��˲�Ԥ����������б� 
 * @author yangrt
 * @date 2014-9-11
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
		<title>��˲�Ԥ����������б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
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
			document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditListSHB.action?Level=one&page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_ADOPT_ORG_NAME_CN").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_NAME_CN").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_AUD_STATE2").value = "";
			document.getElementById("S_AUD_STATE1").value = "";
			document.getElementById("S_LAST_STATE").value = "";
			document.getElementById("S_ATRANSLATION_STATE").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_PASS_DATE_START").value = "";
			document.getElementById("S_PASS_DATE_END").value = "";
		}
		 
		//���
		function _audit(){
			var num = 0;
			var ri_id = "";	//Ԥ�������¼id
			var is_focus = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var aud_state = arrays[i].getAttribute("AUD_STATE1");
					var ri_state = arrays[i].getAttribute("RI_STATE");
					if(ri_state == "1" || ri_state == "2"){
						if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
							ri_id = arrays[i].value;
							is_focus = arrays[i].getAttribute("SPECIAL_FOCUS");
							num++;
						}else{
							page.alert('��ѡ��һ����˲�״̬Ϊ�����˴���˻�����е����ݣ�');
							return;
						}
					}else{
						page.alert('��ѡ��һ��Ԥ��״̬Ϊ���ύ������е����ݣ�');
						return;
					}
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ�����ݣ�');
				return;
			}else{
				var rau_id = getStr('com.dcfs.sce.preApproveAudit.PreApproveAuditAjax','AUDIT_TYPE=1&AUDIT_LEVEL=0&RI_ID=' + ri_id);
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=0&RI_ID=" + ri_id + "&RAU_ID=" + rau_id + "&SPECIAL_FOCUS=" + is_focus;
				document.srcForm.submit();
			}
		}
		
		//�鿴
		function _show(type){
			var num = 0;
			var ri_id = "";	//Ԥ�������¼id
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ri_id = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ�����ݣ�');
				return;
			}else{
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?Level=one&RI_ID=" + ri_id + "&type=" + type;
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
	<BZ:body property="data" codeNames="PROVINCE;">
		<BZ:form name="srcForm" method="post" action="sce/preapproveaudit/PreApproveAuditListSHB.action?Level=one">
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
								<td class="bz-search-title" style="width: 12%">������֯</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:input prefix="S_" field="ADOPT_ORG_NAME_CN" id="S_ADOPT_ORG_NAME_CN" defaultValue="" formTitle="" maxlength="256"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">��������</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">Ů������</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">ʡ��</td>
								<td class="bz-search-value" style="width: 13%">
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" defaultValue="" formTitle="" isCode="true" codeName="PROVINCE">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����Ժ</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="WELFARE_NAME_CN" id="S_WELFARE_NAME_CN" defaultValue="" formTitle="" maxlength="200"/>
								</td>
								
								<td class="bz-search-title">��ͯ����</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td class="bz-search-value" colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								
								<td class="bz-search-title">�Ա�</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��</BZ:option>
										<BZ:option value="2">Ů</BZ:option>
										<BZ:option value="3">����</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�ر��ע</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td class="bz-search-value" colspan="3">
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">���ò�״̬</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="AUD_STATE2" id="S_AUD_STATE2" formTitle="" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">�����</BZ:option>
										<BZ:option value="2">���ͨ��</BZ:option>
										<BZ:option value="3">��˲�ͨ��</BZ:option>
										<BZ:option value="4">�����</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��˲�״̬</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="AUD_STATE1" id="S_AUD_STATE1" formTitle="" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">�����˴����</BZ:option>
										<BZ:option value="1">�����������</BZ:option>
										<BZ:option value="2">�������δ����</BZ:option>
										<BZ:option value="3">�ֹ����δ�����</BZ:option>
										<BZ:option value="4">��˲�ͨ��</BZ:option>
										<BZ:option value="5">���ͨ��</BZ:option>
										<BZ:option value="9">�˻�����</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="LAST_STATE" id="S_LAST_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�Ѳ���</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="ATRANSLATION_STATE" id="S_ATRANSLATION_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�ѷ���</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">Ԥ��״̬</td>
								<td class="bz-search-value">
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">�����</BZ:option>
										<BZ:option value="2">�����</BZ:option>
										<BZ:option value="3">��˲�ͨ��</BZ:option>
										<BZ:option value="4">���ͨ��</BZ:option>
										<BZ:option value="5">δ����</BZ:option>
										<BZ:option value="6">������</BZ:option>
										<BZ:option value="7">��ƥ��</BZ:option>
										<BZ:option value="9">��Ч</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">ͨ������</td>
								<td class="bz-search-value" colspan="3">
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true" defaultValue="" formTitle="" />
								</td>
								
								<td style="text-align: center;" colspan="2">
									<div class="bz-search-button">
										<input type="button" value="��&nbsp;&nbsp;��" onclick="_search();" class="btn btn-sm btn-primary">
										<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show('SHBshow')"/>&nbsp;
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
									<div class="sorting_disabled">ѡ��</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ADOPT_ORG_NAME_CN">������֯</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REQ_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AUD_STATE2">���ò�״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AUD_STATE1">��˲�״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="LAST_STATE">����״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="ATRANSLATION_STATE">����״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RI_STATE">Ԥ��״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PASS_DATE">ͨ������</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
								<%	
									String revoke_state = ((Data)pageContext.getAttribute("myData")).getString("REVOKE_STATE","");
									if("".equals(revoke_state)){
								%>
									<input name="xuanze" type="radio" 
										value="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>" 
										RI_STATE="<BZ:data field="RI_STATE" defaultValue="" onlyValue="true"/>" 
										AUD_STATE1="<BZ:data field="AUD_STATE1" defaultValue="" onlyValue="true"/>" 
										SPECIAL_FOCUS="<BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true"/>"
									class="ace">
								<%	}else{ %>
									<font color="red">��</font>
								<%	} %>
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true" checkValue="1=��;2=Ů;3=����"/></td>
								<td><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/></td>
								<td><BZ:data field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUD_STATE2" defaultValue="" onlyValue="true" checkValue="0=�����;2=���ͨ��;3=��˲�ͨ��;4=�����;"/></td>
								<td><BZ:data field="AUD_STATE1" defaultValue="" onlyValue="true" checkValue="0=�����˴����;1=�����������;2=�������δ����;3=�ֹ����δ�����;4=��˲�ͨ��;5=���ͨ��;9=�˻�����;"/></td>
								<td><BZ:data field="LAST_STATE" defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�Ѳ���;"/></td>
								<td><BZ:data field="ATRANSLATION_STATE" defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���;"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" onlyValue="true" checkValue="1=�����;2=�����;3=��˲�ͨ��;4=���ͨ��;5=δ����;6=������;7=��ƥ��;9=��Ч;"/></td>
								<td><BZ:data field="PASS_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page
								form="srcForm" 
								property="List" 
								exportXls="true" 
								exportTitle="Ԥ�������¼"
								exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=FLAG,1:��&2:Ů&3:����;BIRTHDAY=DATE;SPECIAL_FOCUS=FLAG,0:��&1:��;REQ_DATE=DATE;AUD_STATE2=FLAG,0:�����&2:���ͨ��&3:��˲�ͨ��&4:�����;AUD_STATE1=FLAG,0:�����˴����&1:�����������&2:�������δ����&3:�ֹ����δ�����&4:��˲�ͨ��&5:���ͨ��&9:�˻�����;LAST_STATE=FLAG,0:������&1:������&2:�Ѳ���;ATRANSLATION_STATE=FLAG,0:������&1:������&2:�ѷ���;RI_STATE=FLAG,1:�����&2:�����&3:��˲�ͨ��&4:���ͨ��&5:δ����&6:������&7:��ƥ��&9:��Ч;PASS_DATE=DATE;"
								exportField="ADOPT_ORG_NAME_CN=������֯,15,20;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;PROVINCE_ID=ʡ��,15;WELFARE_NAME_CN=����Ժ,15;NAME=��ͯ����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;SPECIAL_FOCUS=�ر��ע,15;REQ_DATE=��������,15;AUD_STATE2=���ò�״̬,15;AUD_STATE1=��˲�״̬,15;LAST_STATE=����״̬,15;ATRANSLATION_STATE=����״̬,15;RI_STATE=Ԥ��״̬,15;PASS_DATE=ͨ������,15;"/>
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