<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title:fbgl_fb_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
    //��ô�������ͯ����ID
	String ciids= (String)request.getAttribute("ciids");
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	
%>
<BZ:html>

<BZ:head language="CN">
	<title>��ͯ�����ύҳ��</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" tree="true"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_PUB_ORGID','P_HIDDEN_PUB_ORGID');
	});
	
	
	
	
	
	
	//��ͯ�����ύ
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
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'sce/publishManager/saveFbInfo.action';
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
		$("#M_PUB_ORGID").val("");
		$("#P_PUB_ORGID").val("");
		$("#P_PUB_MODE").val("");
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
			$("#P_PUB_ORGID").removeAttr("notnull");
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
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;SYZZ;DFLX" property="rtfbData" onload="_dynamicFblx()">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="H_" field="CIIDS" defaultValue="<%=ciids %>"/>
		<!-- ��������end -->
		
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
								<BZ:input prefix="M_" field="PUB_ORGID" id="M_PUB_ORGID"  type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="ѡ�񷢲���֯" treeType="3" helperSync="true" showParent="false" defaultShowValue="" showFieldId="PUB_ORGID" notnull="��ѡ�񷢲���֯" style="height:13px;width:80%"  />
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
								<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�죨�ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�죨���ر��ע��
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�죨�ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>�죨���ر��ע��
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">�㷢��ע</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="�㷢��ע" defaultValue="" style="width:80%"  maxlength="900"/>
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
