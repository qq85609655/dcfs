<%
/**   
 * @Title: tendingplan_add.jsp
 * @Description:  �����ƻ����ҳ��
 * @author yangrt   
 * @date 2014-9-14 ����10:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head>
		<title>�����ƻ����ҳ��</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
			$(document).ready(function() {
				dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
		</script>
	</BZ:head>
	<BZ:body property="childdata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;">
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����ͯ-�����ƻ�(SN child-Care plan)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%" height="16px">ʡ��<br>Province</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">����Ժ<br>SWI</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">��ͯ����<br>Name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�<br>Gendar</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">�������<br>Diagnosis</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="DISEASE_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="childList" fordata="childData">
						<tr>
							<td class="bz-edit-data-title" width="10%">��ͯ����<br>Name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�<br>Gendar</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" property="childData" codeName="BCZL" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">�������<br>Diagnosis</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
						<tr>
							<td class="bz-edit-data-value" colspan="8">
								ҽ�ƿ����������ƻ�<br>Rehabilitation and Nurture Plan for the Child<br><br>
								<BZ:input prefix="R_" field="TENDING_EN" id="R_TENDING_EN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
	</BZ:body>
</BZ:html>