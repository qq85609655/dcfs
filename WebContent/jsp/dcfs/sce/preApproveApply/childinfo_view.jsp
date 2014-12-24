<%
/**   
 * @Title: childinfo_view.jsp
 * @Description:  Ԥ������ͯ������Ϣ
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head>
		<title>Ԥ������ͯ������Ϣ</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
		</script>
	</BZ:head>
	<BZ:body property="childdata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ��������ͯ������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">ʡ��</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">����Ժ</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">����</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="NAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">�Ա�</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" rowspan="4" width="16%">
								<input type="image" src='<up:attDownload attTypeCode="CI" packageId='<%=(String)request.getAttribute("MAIN_PHOTO") %>' smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:150px;"/>
							</td>
						</tr>
						<tr>
							
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">�ر��ע</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=��;1=��" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">����ͬ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" checkValue="0=��;1=��;" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ļ��ݽ�����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="VALID_PERIOD" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�������</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:dataValue field="DISEASE_CN" defaultValue=""/>
							</td>
						</tr>
					<BZ:for property="childList" fordata="childData">
					<%
						Data data = (Data)pageContext.getAttribute("childData");
						String ci_id = data.getString("CI_ID","");
						String photo_card = data.getString("PHOTO_CARD", ci_id);
					%>
						<tr>
							<td class="bz-edit-data-title" width="20%">����</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">�Ա�</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" rowspan="4" width="16%">
								<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=photo_card%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:150px;">
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">��������</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">�ر��ע</td>
							<td class="bz-edit-data-value" width="22%">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=��;1=��" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">����ͬ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=��;1=��;" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ļ��ݽ�����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="VALID_PERIOD" property="childData" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue=""/>
							</td>
						</tr>
					</BZ:for>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
	</BZ:body>
</BZ:html>