<%
/**   
 * @Title: childAddition_supply.jsp
 * @Description:  ��ͯ������Ϣ����ҳ��
 * @author furx   
 * @date 2014-9-9 ����14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String signal = (String)request.getAttribute("signal");
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
	String isModify=(String)data.getString("IS_MODIFY");
	String ci_id = (String)data.getString("CI_ID");
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";ci_id=" + ci_id;
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ������Ϣ����ҳ</title>
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

		//�����ͯ���ϲ�����Ϣ
		function _save(){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else if(confirm("ȷ��������")){
					document.getElementById("R_CA_STATUS").value = "1";
				document.srcForm.action = path+"cms/childaddition/childSupplySave.action";
				document.srcForm.submit();
			}
		}
		
		//�ύ��ͯ���ϲ�����Ϣ
		function _submit(){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else if(confirm("ȷ���ύ��")){
					document.getElementById("R_CA_STATUS").value = "2";
				document.srcForm.action = path+"cms/childaddition/childSupplySave.action";
				document.srcForm.submit();
			}
		}
		
		//���ز����ļ��б�ҳ��
		function _goback(signal){
			if(signal=='1'){
				window.location.href=path+'cms/childaddition/findListFLY.action';
				}else if(signal=='2'){
					window.location.href=path+'cms/childaddition/findListST.action';
					}
		}
		
		function _close(){
			window.close();
		}
		
		//�����ͯ���ϻ�����Ϣ�޸�ҳ��
		function _toMofify(){
			var CI_ID =document.getElementById("R_CI_ID").value;
			var url = path + "/cms/childManager/toChildInfoModify.action?CI_ID=" + CI_ID;
			_open(url, "window", 1100, 700);
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<input name="signal" id="signal" type="hidden" value="<%=signal%>"/>
		<BZ:input type="hidden" prefix="R_" field="CA_ID" id="R_CA_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CA_STATUS" id="R_CA_STATUS" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="SOURCE" id="R_SOURCE" defaultValue=""/>
		<br/>		
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<!--<div class="bz-edit clearfix">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ������Ϣ</div>
				</div>
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">���</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="CHILD_NO" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">ʡ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">����Ժ</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��ͯ����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE"  onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		-->
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>֪ͨ��Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
					    <tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ��Դ</td>
							<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="SOURCE" onlyValue="true" defaultValue="" checkValue="2=ʡ��;3=����;"/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ��</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEND_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ����</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="NOTICE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ����</td>
							<td class="bz-edit-data-value" colspan="5" width="85%">
								<BZ:dataValue field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- bz-edit  -->
		<div class="clearfix"  style="margin-left: 11px;margin-right: 11px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">���䵥λ</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_ORGNAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">������</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="FEEDBACK_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">����״̬</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="CA_STATUS" onlyValue="true" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���;"/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">���丽��</td>
							<td class="bz-edit-data-value" colspan="2" >
                            <up:uploadBody attTypeCode="CI"
							name="R_UPLOAD_IDS" id="scfj" packageId="<%=affix%>" 
							queueStyle="border: solid 1px #7F9DB9;;" autoUpload="true"
									selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" smallType="<%=AttConstants.CI_BCCL %>"  bigType="CI"   diskStoreRuleParamValues="<%=org_af_id %>"></up:uploadBody>
							</td>
							<td class="bz-edit-data-value" width="35%">
							<%if("1".equals(isModify)){ %>
							<input type="button" value="�޸Ĳ�����Ϣ" class="btn btn-sm btn-primary" onclick="_toMofify();"/>
							<% }%>
							</td>

						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="R_" field="ADD_CONTENT" id="R_ADD_CONTENT" type="textarea" defaultValue="" maxlength="1000" style="width:90%;"/>
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
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_save()"/>
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="ȡ��" class="btn btn-sm btn-primary" onclick="_goback('<%=signal %>')"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>