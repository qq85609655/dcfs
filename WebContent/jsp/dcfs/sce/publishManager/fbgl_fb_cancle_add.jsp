<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title:fbgl_fb_cancle_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
    //������¼����ID
	String pubid= (String)request.getAttribute("pubid");
	Data rtfbData= (Data)request.getAttribute("rtfbData");
	String IS_TWINS = rtfbData.getString("IS_TWINS");
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	
%>
<BZ:html>

<BZ:head>
	<title>��ͯ��������ҳ��</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" tree="true"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID');
	});
	
	
	
	
	//���������ύ
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
			$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
			$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
			$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
			$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
			$("#P_REVOKE_DATE").attr("disabled",false);
			$("#P_REVOKE_USERNAME").attr("disabled",false);
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'sce/publishManager/saveCxfbInfo.action';
			obj.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.history.back();
	}
	
	//���ݵ㷢��Ⱥ����̬չ���������
	function _dynamicFblx(){
		$("#P_COUNTRY_CODE").val("");
		$("#P_ADOPT_ORG_NAME").val("");
		$("#P_PUB_ORGID").val("");
		$("#M_PUB_ORGID").val("");
		$("#PUB_ORGID").val("");
		$("#P_PUB_MODE").val("");
		$("#M_PUB_MODE").val("");
		$("#P_SETTLE_DATE_NORMAL").val("");
		$("#P_SETTLE_DATE_SPECIAL").val("");
		$("#M_SETTLE_DATE_NORMAL").val("");
		$("#M_SETTLE_DATE_SPECIAL").val("");
		$("#P_PUB_REMARKS").val("");
		var optionValue = $("#P_PUB_TYPE").find("option:selected").val();
		if(optionValue=="1"){//�㷢
			$("#P_COUNTRY_CODE").attr("notnull","���������");
			$("#P_ADOPT_ORG_NAME").attr("notnull","�����뷢����֯");
			$("#P_PUB_MODE").attr("notnull","������㷢����");
			$("#PUB_ORGID").removeAttr("notnull");
			
			$("#dfzz").show();
			$("#dflx").show();
			$("#dfbz").show();
			$("#qfzz").hide();
			$("#qflx").hide();
		}else{//Ⱥ��
			$("#PUB_ORGID").attr("notnull","��ѡ�񷢲���֯");
			$("#P_COUNTRY_CODE").removeAttr("notnull");
			$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
			$("#P_PUB_MODE").removeAttr("notnull");
			
			$("#dfzz").hide();
			$("#dflx").hide();
			$("#dfbz").hide();
			$("#qfzz").show();
			$("#qflx").show();
		}
		
	}
	
	//��ð�������
	function _getAzqxForFb(){
		var is_df = $("#P_PUB_TYPE").find("option:selected").val();//��������  1���㷢  2��Ⱥ��
		var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//�㷢����  
		
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
							$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
							$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
						}else {//�ر��ע
							$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
							$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
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
	
	//�Ƿ�ֱ�ӷ���
	function _isShowFB(){
		
		var is_df = $("#S_IS_FB").find("option:selected").val();//�Ƿ�ֱ�ӷ���  0����  1����
		if("1"==is_df){//ֱ�ӷ���
			$("#fbArea").show();
			_dynamicFblx();
		}else{
			$("#fbArea").hide();
			$("#PUB_ORGID").removeAttr("notnull");
			$("#P_COUNTRY_CODE").removeAttr("notnull");
			$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
			$("#P_PUB_MODE").removeAttr("notnull");
		}
	
	}
	
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;SYZZ;PROVINCE;BCZL;DFLX;SYS_ADOPT_ORG" property="rtfbData" onload="_isShowFB();">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="H_" field="PUBID" defaultValue="<%=pubid %>"/>
		<BZ:input type="hidden" prefix="H_" field="CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="H_" field="SPECIAL_FOCUS" defaultValue=""/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">ʡ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE"  defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">����Ժ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">����</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" checkValue="1=��;2=Ů;3=����"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date" />
							</td>
							
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true" />
							</td>
						</tr>
						<tr>
							
							<td class="bz-edit-data-title" width="10%">�ر��ע</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_TYPE" defaultValue="" onlyValue="true" checkValue="1=�㷢;2=Ⱥ��"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" defaultValue="" onlyValue="true" type="Date" />
							</td>
							<td class="bz-edit-data-title"  width="10%">����״̬</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_STATE" defaultValue="" onlyValue="true" checkValue="3=������;2=δ����;0=δ����;1=δ����;4=δ����;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SETTLE_DATE" defaultValue="" onlyValue="true" type="Date"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ƿ���̥</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
							</td>
							<td class="bz-edit-data-title" width="10%"><%if("1".equals(IS_TWINS)||"1"==IS_TWINS){ %>ͬ������<%} %></td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="TB_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td class="bz-edit-data-title"  width="10%">������֯</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true" codeName="SYS_ADOPT_ORG"  />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		<br/>
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>����ԭ��</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="REVOKE_REASON" id="P_REVOKE_REASON" type="textarea" prefix="P_" formTitle="����ԭ��" defaultValue="" style="width:80%"  maxlength="900" notnull="�����볷��ԭ��"/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">�Ƿ�ֱ�ӷ���</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="S_" field="IS_FB" id="S_IS_FB" formTitle="�Ƿ�ֱ�ӷ���" defaultValue="" onchange="_isShowFB();">
									<BZ:option value="0" selected="true">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">������</td>
							<td class="bz-edit-data-value">
								<BZ:input  prefix="P_" field="REVOKE_USERNAME" id="P_REVOKE_USERNAME" defaultValue="" formTitle="������"  readonly="true"/>
								<BZ:input type="hidden" field="REVOKE_USERID"  prefix="P_" id="P_REVOKE_USERID"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value"  >
								<BZ:input type="Date" field="REVOKE_DATE" prefix="P_" readonly="true"/>
							</td>
							
							
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		<br/>
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper" id="fbArea" sytle="display:none">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="�����뷢������" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()">
									<option value="1">�㷢</option>
									<option value="2">Ⱥ��</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" id="dfzz">
								<BZ:select field="COUNTRY_CODE" notnull="�����뷢������" formTitle="" defaultValue="" prefix="P_" id="P_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN"  width="168px"
								 onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID')">
									<option value="">--��ѡ��--</option>
								</BZ:select> ��
								<BZ:select prefix="P_" field="PUB_ORGID" id="P_PUB_ORGID" notnull="������������֯" formTitle="" prefix="P_" width="168px"
									onchange="_setOrgID('P_HIDDEN_PUB_ORGID',this.value)">
									<option value="">--��ѡ��������֯--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_PUB_ORGID" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>' />
							
							</td>
							<td class="bz-edit-data-value" id="qfzz" style="display:none">
								<BZ:input prefix="M_" field="PUB_ORGID" type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="ѡ�񷢲���֯" treeType="1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="PUB_ORGID" notnull="��ѡ�񷢲���֯" style="height:13px;width:80%"  />
							</td>
						</tr>
						<tr id="dflx">
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>�㷢����</td>
							<td class="bz-edit-data-value"  >
								<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="������㷢����" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�գ��ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�գ����ر��ע��
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�գ��ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�գ����ر��ע��
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">�㷢��ע</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="�㷢��ע" defaultValue="" style="width:80%" maxlength="900"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		<br/>
		
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
