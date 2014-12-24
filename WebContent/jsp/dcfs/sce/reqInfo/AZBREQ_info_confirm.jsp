<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:Ԥ��������Ϣȷ��ҳ��
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data= (Data)request.getAttribute("data");
String pub_type = data.getString("PUB_TYPE");//��������
String pub_mode = data.getString("PUB_MODE");//�㷢����
String pub_orgid = data.getString("PUB_ORGID");//�㷢��֯ID
String country_code = data.getString("COUNTRY_CODE");//�㷢����
String adopt_org_name = data.getString("ADOPT_ORG_NAME");//�㷢��֯����
String tmp_tmp_pub_orgid_name = data.getString("TMP_TMP_PUB_ORGID_NAME");//Ⱥ����֯����
String pub_remarks = data.getString("PUB_REMARKS");//�㷢��ע
%>
<BZ:html>
<BZ:head>
	<title>����������Ϣ</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		_findSyzzNameListForNew('c_COUNTRY_CODE','c_ADOPT_ORG_ID','c_PUB_ORGID');
	});
	//���ݵ㷢��Ⱥ����̬չ���������
	function _dynamicFblx(){
		_findSyzzNameListForNew('c_COUNTRY_CODE','c_ADOPT_ORG_ID','c_PUB_ORGID');
		$("#M_PUB_ORGID").val("");
		$("#PUB_ORGID").val("");
		$("#c_PUB_MODE").val("");
		$("#M_PUB_MODE").val("");
		$("#c_SETTLE_DATE_NORMAL").val("");
		$("#c_SETTLE_DATE_SPECIAL").val("");
		$("#M_SETTLE_DATE_NORMAL").val("");
		$("#M_SETTLE_DATE_SPECIAL").val("");
		$("#c_PUB_REMARKS").val("");
		
		var optionValue = $("#c_PUB_TYPE").find("option:selected").val();
		if(optionValue=="1"){//�㷢
			$("#c_COUNTRY_CODE").attr("notnull","���������");
			$("#c_ADOPT_ORG_ID").attr("notnull","�����뷢����֯");
			$("#c_PUB_MODE").attr("notnull","������㷢����");
			$("#M_PUB_ORGID").removeAttr("notnull");
			
			$("#dfzz").show();
			$("#dflx").show();
			$("#dfbz").show();
			$("#qfzz").hide();
			$("#qflx").hide();
		}else{//Ⱥ��
			$("#M_PUB_ORGID").attr("notnull","��ѡ�񷢲���֯");
			$("#c_COUNTRY_CODE").removeAttr("notnull");
			$("#c_ADOPT_ORG_ID").removeAttr("notnull");
			$("#c_PUB_MODE").removeAttr("notnull");
			
			$("#dfzz").hide();
			$("#dflx").hide();
			$("#dfbz").hide();
			$("#qfzz").show();
			$("#qflx").show();
		}
		
	}

	//��ð�������
	function _getAzqxForFb(){
		var is_df = $("#c_PUB_TYPE").find("option:selected").val();//��������  1���㷢  2��Ⱥ��
		var pub_mode = $("#c_PUB_MODE").find("option:selected").val();//�㷢����  
		
		if(""==pub_mode){
			pub_mode=null;
		}
		
		if("1"==is_df && (""==pub_mode||null==pub_mode)){
			return;
		}else{
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getAZQXInfo&IS_DF='+is_df+'&PUB_MODE='+pub_mode,
				type: 'POST',
				dataType: 'json',
				timeout: 1000,
				success: function(data){
					var two_type1 = data[0].TWO_TYPE;//�Ƿ��ر��ע  0:��  1����
					var settle_months1 = data[0].SETTLE_MONTHS;
					var two_type2 = data[1].TWO_TYPE;//�Ƿ��ر��ע  0:��  1����
					var settle_months2 = data[1].SETTLE_MONTHS;
					if("1"==is_df){//�㷢����
						if("0"==two_type1){//���ر��ע
							$("#c_SETTLE_DATE_NORMAL").val(settle_months1);
							$("#c_SETTLE_DATE_SPECIAL").val(settle_months2);
						}else {//�ر��ע
							$("#c_SETTLE_DATE_NORMAL").val(settle_months2);
							$("#c_SETTLE_DATE_SPECIAL").val(settle_months1);
						}
					}else {//Ⱥ������
						if("0"==two_type1){//���ر��ע
							$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
							$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
						}else {//�ر��ע
							$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
							$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
						}
					}
				}
			})
		}
	
	}
	
	function isPublish(obj){
		var V = obj.value;
		if(V == "1"){
			var pub_type=document.getElementById("c_PUB_TYPE").value;
			if(pub_type=="1"){
				$("#c_COUNTRY_CODE").attr("notnull","���������");
				$("#c_ADOPT_ORG_ID").attr("notnull","�����뷢����֯");
				$("#c_PUB_MODE").attr("notnull","������㷢����");
			}else{
				$("#M_PUB_ORGID").attr("notnull","��ѡ�񷢲���֯");
			}
			$("#fbxx").show();
		}else{
			$("#c_PUB_TYPE").removeAttr("notnull");
			$("#c_COUNTRY_CODE").removeAttr("notnull");
			$("#c_ADOPT_ORG_ID").removeAttr("notnull");
			$("#c_PUB_MODE").removeAttr("notnull");
			$("#M_PUB_ORGID").removeAttr("notnull");
			$("#fbxx").hide();
			
		}
	}
	
	function pubType(obj){
		var V = obj.value;
		if(V == "1"){
			$("#dflx").show();
		}else{
			$("#dflx").hide();
		}
	}
	
	function _submit(){
		if (!runFormVerify(document.srcForm, false)) {
			alert("�б�����δ��д��������֮���ٽ����ύ��");
			return;
		}else{
			var RI_ID = document.getElementById("RI_ID").value;
			document.srcForm.action=path+"info/AZBReqInfoconfirm.action?RI_ID="+RI_ID;
			document.srcForm.submit();
		}
	}
	
	//����Ԥ�������б�
	function _goback(){
		document.srcForm.action=path+"info/AZBREQInfoList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;GJSY;DFLX;SYS_ADOPT_ORG;SYS_GJSY_CN">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<BZ:input field="RI_ID" type="hidden" id="RI_ID"/>
	<BZ:input field="CI_ID" prefix="H_" type="hidden"/>
	<BZ:input field="AF_ID" prefix="H_" type="hidden"/>
	<BZ:input field="SPECIAL_FOCUS" prefix="H_" type="hidden"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="COUNTRY_CODE_NAME" codeName="GJSY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">������֯</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="MALE_NAME"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">Ů������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">ʡ��</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">����Ժ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="REVOKE_REQ_DATE" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">����״̬</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REVOKE_STATE" checkValue="0=��ȷ��;1=��ȷ��;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���볷��ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REVOKE_REASON" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ��������<font style="vertical-align: middle;" color="red">*</font></td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:select prefix="c_" field="isPublish" id="c_isPublish" formTitle="�Ƿ��������" width="150px;" onchange="isPublish(this)">
	                            <BZ:option value="1">��</BZ:option>
	                            <BZ:option value="2">��</BZ:option>
	                        </BZ:select>
						</td>
					</tr>
				</table>
			</div>
			<div id="fbxx">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PUB_TYPE" id="c_PUB_TYPE" notnull="�����뷢������" formTitle="" prefix="c_" onchange="_dynamicFblx();_getAzqxForFb()">
									<option value="1">�㷢</option>
									<option value="2">Ⱥ��</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" id="dfzz">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="c_" id="c_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="150px" onchange="_findSyzzNameListForNew('c_COUNTRY_CODE','c_ADOPT_ORG_ID','c_PUB_ORGID')">
									<option value="">--��ѡ��--</option>
								</BZ:select> �� 
								<BZ:select prefix="c_" field="ADOPT_ORG_ID" id="c_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="260px" onchange="_setOrgID('c_PUB_ORGID',this.value)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="c_PUB_ORGID" name="c_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
							<td class="bz-edit-data-value" id="qfzz" style="display:none">
								<BZ:input prefix="M_" field="PUB_ORGID" id="M_PUB_ORGID"  type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="ѡ�񷢲���֯" treeType="1" helperSync="true" showParent="false" defaultShowValue="" defaultValue="<%=pub_orgid %>" showFieldId="M_PUB_ORGID"  style="height:13px;width:80%"  />
							</td>
						</tr>
						<tr id="dflx">
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>�㷢����</td>
							<td class="bz-edit-data-value"  >
								<BZ:select field="PUB_MODE" id="c_PUB_MODE" notnull="������㷢����" formTitle="" prefix="c_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="SETTLE_DATE_SPECIAL" id="c_SETTLE_DATE_SPECIAL" prefix="c_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£��ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="c_SETTLE_DATE_NORMAL" prefix="c_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£����ر��ע��
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£��ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£����ر��ע��
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">�㷢��ע</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="c_PUB_REMARKS" type="textarea" prefix="c_" formTitle="�㷢��ע" defaultValue="" style="width:80%"  maxlength="900"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
