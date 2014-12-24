<%
/**   
 * @Title: normalFile_add.jsp
 * @Description:  ������֯�ݽ���ͨ�ļ���ͬ�������͵���ת
 * @author yangrt   
 * @date 2014-7-22 ����4:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@	page import="hx.database.databean.Data"%>
<%@	page import="com.dcfs.ffs.common.FileCommonConstant"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String reg_state = (String)request.getAttribute("REG_STATE");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�ݽ���ͨ�ļ��������ҳ��</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			setSigle();
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			var file_id = $("#R_AF_ID").val();
			//�����ƥ����ļ���Ϣ���������ļ����͡��������Ͳ��ɱ༭
			/* if(file_id != ""){
				$("#R_FILE_TYPE").attr("disabled",true);
				$("#R_FAMILY_TYPE").attr("disabled",true);
			} */
			//�����ļ����͡��������ͼ��ز�ͬ�����ҳ��
			//var file_type = $("#R_FILE_TYPE").find("option:selected").val();
			var file_type = $("#R_FILE_TYPE").val();
			if(file_type == "33"){
				$("#R_FAMILY_TYPE")[0].selectedIndex = 1; 
				$("#R_FAMILY_TYPE").attr("disabled",true);
				//���ؼ���Ů�����ļ����ҳ��
				$("#iframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=step&AF_ID=" + file_id);
			}else{
				//var family_type = $("#R_FAMILY_TYPE").find("option:selected").val();
				var family_type = $("#R_FAMILY_TYPE").val();
				if(family_type == "1"){
					//����˫���������ҳ��
					$("#iframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=double&AF_ID=" + file_id);
				}else if(family_type == "2"){
					//���ص����������ҳ��
					$("#iframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=single&AF_ID=" + file_id);
				}
			}
			
		});
		
		//�����ļ����ͼ������ҳ��
		function _dynamicJznsy(){
			var file_id = $("#R_AF_ID").val();
			var sylx = $("#R_FILE_TYPE").find("option:selected").val();
			if(sylx=="33"){
				//������������Ϊ˫�����������û�
				$("#R_FAMILY_TYPE")[0].selectedIndex = 1; 
				$("#R_FAMILY_TYPE").attr("disabled",true);
				$("#addiframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=step&AF_ID=" + file_id);
			}else{
				$("#R_FAMILY_TYPE")[0].selectedIndex = 0; 
				$("#R_FAMILY_TYPE").attr("disabled",false);   
			}
		}
		
		//�����������ͼ������ҳ��
		function _dynamicHide(){
			var file_id = $("#R_AF_ID").val();
			var optionText = $("#R_FAMILY_TYPE").find("option:selected").val();
			if(optionText=="2"){
				$("#addiframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=single&AF_ID=" + file_id);
			}else if(optionText=="1"){
				$("#addiframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=double&AF_ID=" + file_id);
			}
		}
		
		//���صݽ���ͨ�ļ��б�ҳ��
		function _goback(){
			document.srcForm.action = path+'ffs/filemanager/NormalFileList.action';
			document.srcForm.submit();
			//window.location.href=path+'ffs/filemanager/NormalFileList.action';
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="ZCWJLX;SYLX">
	<BZ:form name="srcForm" method="post">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" defaultValue=""/>
	<!-- ��������end -->
	<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" height="16px">������֯(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">������֯(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">�ļ�����<br>Document type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FILE_TYPE" codeName="ZCWJLX" isShowEN="true" defaultValue="" onlyValue="true"/>
								<%-- <BZ:select prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" formTitle="�ļ�����" isCode="true" codeName="ZCWJLX" notnull="��ѡ���ļ�����" onchange="_dynamicJznsy()" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select> --%>
							</td>
							<td class="bz-edit-data-title" width="20%">��������<br>Adoption type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" isShowEN="true" defaultValue="" onlyValue="true"/>
								<%-- <BZ:select prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" formTitle="��������" defaultValue="" isCode="true" codeName="SYLX" notnull="��ѡ����������" onchange="_dynamicHide()" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select> --%>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<%
			if(reg_state.equals(FileCommonConstant.DJZT_DXG)){
		%>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- ����begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�˻���Ϣ</div>
				</div>
				<!-- ����end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">�˻�����<br>Return date</td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="REG_RETURN_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">�˻�ԭ��<br>Reason for return </td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="REG_RETURN_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�˻�˵��<br>Note on return</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REG_RETURN_DESC" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<%	} %>
		<iframe  id="iframe" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" width="100%" ></iframe>
		<!-- �༭����end -->
		<!-- <br/>
		��ť����begin
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="��һ��" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		��ť����end -->
	</BZ:form>
</BZ:body>