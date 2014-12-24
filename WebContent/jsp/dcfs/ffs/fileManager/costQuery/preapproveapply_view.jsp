<%
/**   
 * @Title: preapproveapply_view.jsp
 * @Description:  Ԥ����Ϣ�鿴
 * @author yangrt   
 * @date 2014-09-03 11:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>Ԥ����Ϣ�鿴</title>
		<BZ:webScript edit="true" list="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			setSigle();
			dyniframesize(['iframe','mainFrame']);
		});
			
	</script>
	<BZ:body codeNames="ETXB;">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" id="pre_child">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ��������Ϣ</div>
				</div>
				<BZ:for property="riList" fordata="riData">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��ͯ����<br>Child name</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME_PINYIN" property="riData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEX" codeName="ETXB" isShowEN="true" property="riData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="BIRTHDAY" type="Date" property="riData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REQ_NO" property="riData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">��������<br>Date of application</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REQ_DATE" type="Date" property="riData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">Ԥ��״̬<br>Pre-approval status</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="RI_STATE" property="riData" checkValue="0=submitted;1=in process of review;2=no pass;3=pass;4=unoperated;5=operated;6=matched;9=invalid;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ͨ������<br>Approval date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PASS_DATE" property="riData" defaultValue="" type="Date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�ļ��ݽ�����<br>Document submission deadline</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SUBMIT_DATE" property="riData" defaultValue="" type="Date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�߰�״̬<br>Reminder status</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REMINDERS_STATE" property="riData" defaultValue="" checkValue="0=un-reminded;1=reminded;" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��˲�״̬<br>Review status</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="AUD_STATE1" property="riData" defaultValue="" checkValue="0=to be reviewed by responsible person;1=being reviewed by responsible person;2=to be reviewed by the director of  review division;3=to be reviewed and approved by deputy director-general in charge of the Review Division;4=no pass;5=pass;9=file returned to the responsible person;" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">���ò�״̬<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="AUD_STATE2" property="riData" defaultValue="" checkValue="0=�����˴����;1=�����������;2=�������δ����;3=�ֹ����δ�����;4=��˲�ͨ��;5=���ͨ��;9=�˻ؾ�����;" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
					</table>
				</div>
				</BZ:for>
			</div>
		</div>
	</BZ:body>
</BZ:html>