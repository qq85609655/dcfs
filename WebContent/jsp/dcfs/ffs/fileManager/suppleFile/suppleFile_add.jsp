<%
/**   
 * @Title: suppleFile_add.jsp
 * @Description:  �����ļ���Ϣ���ҳ
 * @author yangrt   
 * @date 2014-8-25 ����14:03:34 
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
	String aa_id = (String)request.getAttribute("AA_ID");
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";af_id=" + aa_id;
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�����ļ���Ϣ���ҳ</title>
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
			//��ʼ�������ϴ�����ʾ������
			var is_attach = $("#R_IS_ADDATTACH").val();
			if(is_attach == "0"){
				$("#isapply_attach").hide();
			}else{
				$("#isapply_attach").show();
			}
			//��ʼ���޸Ļ�����Ϣ����ʾ������
			var is_modify = $("#R_IS_MODIFY").val();
			if(is_modify == "0"){
				$("#isapply_modify").hide();
			}else{
				$("#isapply_modify").show();
			}
			
		});
		
		//���桢�ύ�����ļ���Ϣ
		function _submit(val){
			$("#R_AA_STATUS").val(val);
			var flag = "false";
			if(val == "1"){
				document.srcForm.action = path+"ffs/filemanager/SuppleFileSave.action?FLAG=" + flag;
				document.srcForm.submit();
			}else if(val == "2"){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("Are you sure you want to submit?")){
					//�жϸ����Ƿ��ϴ�
					
					var table = document.getElementById("infoTableR_UPLOAD_IDS");
					var trslen = table.rows.length;
					if(trslen > 0){
						flag = "true";
					}
					//���ύ
					document.srcForm.action = path+"ffs/filemanager/SuppleFileSave.action?FLAG=" + flag;
					document.srcForm.submit();
				}
			}
			
		}
		
		//���ز����ļ��б�ҳ��
		function _goback(){
			window.location.href=path+'ffs/filemanager/SuppleFileList.action';
		}
		
		//���������Ϣ�޸�ҳ��
		function _modifyBasicInfo(){
			var af_id = $("#R_AF_ID").val();
			var url = path + "ffs/filemanager/SuppleFileShow.action?type=mod&AF_ID=" + af_id;
			_open(url, "window", 1000, 600);
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AA_ID" id="R_AA_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AA_STATUS" id="R_AA_STATUS" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_NO" id="R_FILE_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_NAME" id="R_MALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NOTICE_CONTENT" id="R_NOTICE_CONTENT" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NOTICE_DATE" id="R_NOTICE_DATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="IS_ADDATTACH" id="R_IS_ADDATTACH" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="IS_MODIFY" id="R_IS_MODIFY" defaultValue=""/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ļ�������Ϣ(INFORMATION ABOUT THE FILE)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������<br>Adoptive father</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_BIRTHDAY" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�ļ�����<br>Document type</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" isShowEN="true" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">Ů������<br>Adoptive mother</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">���ı��<br>Log-in No.</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FILE_NO" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>֪ͨ��Ϣ(INFORMATION ABOUT THE NOTICE)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">֪ͨ����<br>NOTICE CONTENT</td>
							<td class="bz-edit-data-value" width="85%">
								<BZ:dataValue field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">֪ͨ����<br>Date of notification</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ(INFORMATION ABOUT THE SUPPLE)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%">���丽��<br>SUPPLE ATTACH</td>
							<td class="bz-edit-data-value" width="85%">
								<up:uploadBody 
									attTypeCode="AF" 
									bigType="<%=AttConstants.AF %>"
									smallType="<%=AttConstants.AF_WJBC %>"
									id="R_UPLOAD_IDS"
									name="R_UPLOAD_IDS"
									packageId="<%=aa_id %>"
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="<%=org_af_id %>"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
								/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">�ظ�����<br>SUPPLE CONTENT</td>
							<td class="bz-edit-data-value" width="85%">
								<BZ:input prefix="R_" field="ADD_CONTENT_EN" id="R_ADD_CONTENT_EN" type="textarea" defaultValue="" maxlength="1000" style="width:85%;"/>
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
				<input type="button" value="Modify basic information" class="btn btn-sm btn-primary" id="isapply_modify" onclick="_modifyBasicInfo();"/>
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_submit('1')"/>
				<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit('2')"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>