<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: wjth_add.jsp
 * @Description:  
 * @author yangrt   
 * @date 2014-7-21 ����10:40:34 
 * @version V1.0   
 */
 	//�������ݶ���
	Data wjdlData = new Data();
	request.setAttribute("wjdlData",wjdlData);
%>
<BZ:html>

<BZ:head language="CN">
	<title>�ļ��˻�</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	
	//�����ļ���¼��Ϣ
	function _submit(){
		if(confirm("ȷ�������ļ��˻���")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveFlieReturnReason.action';
			obj.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	
</script>

<BZ:body codeNames="GJSY;WJLX;WJLX_DL;SYZZ;WJDJTHYY" property="fileData">
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="REG_USERID" id="R_REG_USERID" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="REG_USERNAME" id="R_REG_USERNAME" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="REG_RETURN_DATE" id="R_REG_RETURN_DATE" defaultValue="" />
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ļ�������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- ������ʾ���� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="15%">������֯</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME_CN" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��ˮ��</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="AF_SEQ_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�������ڣ��У�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�ļ�����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">Ů������</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�������ڣ�Ů��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">���ı��</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REG_REMARK" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- ��ʾ����end -->
		<br/>
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�˻�ԭ��</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�˻�ԭ��</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select prefix="R_" field="REG_RETURN_REASON" isCode="true" codeName="WJDJTHYY" formTitle="�˻�ԭ��" notnull="�˻�ԭ����Ϊ��" defaultValue="" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%">������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="REG_USERNAME" hrefTitle="������" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">��������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="REG_RETURN_DATE" type="Date" hrefTitle="��������" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�˻�˵��</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="REG_RETURN_DESC" id="R_REG_RETURN_DESC" type="textarea" formTitle="�˻�˵��" maxlength="500" style="width:80%" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="ȷ��" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
