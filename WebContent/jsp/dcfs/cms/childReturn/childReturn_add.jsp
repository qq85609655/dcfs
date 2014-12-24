<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String RETURN_LEVEL = (String)request.getAttribute("RETURN_LEVEL");
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
	String ci_id = (String)data.getString("CI_ID");
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";ci_id=" + ci_id;
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ�����˲������루��¼��ҳ��</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ	
		});
		//�ύ��ͯ�����˲�����Ϣ
		function _submit(){
            var APPLE_TYPE=document.getElementById('R_APPLE_TYPE').value;
            if(APPLE_TYPE==''){
            	alert('��ѡ���˲�������');
            	return;
            }
            var RETURN_REASON=document.getElementById('R_RETURN_REASON').value;
            if(RETURN_REASON==''){
            	alert('����д�˲���ԭ��');
            	return;
            }
          //�ϴ�����У��
			var table = document.getElementById('infoTable'+'scfj');
            var trs=table.rows;
       		var trsLen = trs.length;
            if(trsLen == 0){
                alert('���ϴ�����');
                return;
            }
            if(trsLen > 0){
                var tds = trs[0].cells;
                var succ = tds[2].innerHTML;
                if(succ == '' || succ.indexOf('OK') < 0){
                	alert('���ϴ�����');
                    return;
                }
            }
	        if(confirm('ȷ���ύ��')){
				document.srcForm.action = path+'cms/childreturn/saveReturnData.action';
				document.srcForm.submit();
			}
		}
		
		//���ز��˲����б�ҳ��
		function _goback(signal){
			if(signal=='1'){
				window.location.href=path+'cms/childreturn/returnListFLY.action';
			}else if(signal=='2'){
				window.location.href=path+'cms/childreturn/returnListST.action';
			}else if(signal=='3'){
				window.location.href=path+'cms/childreturn/returnListZX.action';
			}
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;CHILD_TYPE;BCZL;TCLLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<input name="RETURN_LEVEL" id="RETURN_LEVEL" type="hidden" value="<%=RETURN_LEVEL%>"/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<!-- ��������end -->
		<br/>
		<!-- �༭����begin -->
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ��Ϣ</div>
				</div>
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">����Ժ</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">��ͯ����</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">�Ա�</td>
							<td class="bz-edit-data-value" width="21%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">��ͯ����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE"  onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL"  onlyValue="true" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;"">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�˲�����Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
						    <td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">������</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="APPLE_PERSON_NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="APPLE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">�˲�������<font color=red>*</font></td>
							<td class="bz-edit-data-value" width="21%">
								<BZ:select prefix="R_" field="APPLE_TYPE" id="R_APPLE_TYPE" isCode="true" codeName="TCLLX" formTitle="�˲�������" defaultValue="" width="100%" notnull="��ѡ���˲�������">
										<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">����<font color=red>*</font></td>
							<td class="bz-edit-data-value" colspan="5" >
                            <up:uploadBody attTypeCode="CI"
							name="R_UPLOAD_IDS" id="scfj" packageId="<%=affix%>" 
							queueStyle="border: solid 1px #7F9DB9;;width:80%;" autoUpload="true"
									selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;width:80%;" smallType="<%=AttConstants.CI_CLTW %>"  bigType="CI"  diskStoreRuleParamValues="<%=org_af_id %>"></up:uploadBody>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">�˲���ԭ��<font color=red>*</font></td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" defaultValue="" maxlength="1000" style="width:80%;" />
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
			<div class="bz-action-edit" >
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="ȡ��" class="btn btn-sm btn-primary" onclick="_goback('<%=RETURN_LEVEL %>')"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>