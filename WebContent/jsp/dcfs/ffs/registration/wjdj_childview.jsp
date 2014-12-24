<%
/**   
 * @Title: wjdj_childview.jsp
 * @Description:  ��ͯ������Ϣ�鿴ҳ��
 * @author panfeng   
 * @date 2014-12-19 ����13:49:57 
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
		<title>��ͯ������Ϣ�鿴ҳ��</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true" list="true"/>
		<style>
		</style>
	</BZ:head>
</BZ:html>
<BZ:body codeNames="CHILD_TYPE;ETXB;BCZL;PROVINCE;ETSFLX;ETLY">
	<!-- �鿴����begin -->
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ƥ���ͯ����������ͯ������Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<BZ:for property="List" fordata="childData">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
				<%
					String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
					if("".equals(photo_card)){
						photo_card = ((Data)pageContext.getAttribute("childData")).getString("CI_ID");
					}
				%>
					<tr>
						<td class="bz-edit-data-title" width="13%">��ͯ���</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_NO" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">��ͯ����</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">���֤��</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="ID_CARD" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" rowspan="4" width="16%">
							<img src='<up:attDownload attTypeCode="CI" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ʡ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����Ժ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�ر��ע</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=��;1=��" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͯ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��Ժ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENTER_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����ͬ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=��;1=��" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SENDER" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEND_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�����˵�ַ</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
						</td>
						<td class="bz-edit-data-title">��ͯ��Դ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_SOURCE" property="childData" codeName="ETLY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��ͯ������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value" colspan="6">
							<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			</BZ:for>
		</div>
	</div>
	<!-- �鿴����end -->
</BZ:body>