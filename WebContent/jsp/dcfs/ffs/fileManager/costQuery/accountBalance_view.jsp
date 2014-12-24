<%
/**   
 * @Title: accountBalance_view.jsp
 * @Description:  �ɷѵ���ϸ�鿴
 * @author yangrt   
 * @date 2014-09-01 17:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>�ɷѵ���ϸ�鿴</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//�����б�ҳ
		function _goback(){
			window.location.href=path+'ffs/filemanager/AccountBalanceList.action';
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ɷѵ���ϸ(Payment bill details)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�ɷѱ��<br>Bill number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">��������<br>Type</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="OPP_TYPE" checkValue="0=transfer money to;1=transfer money from;" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">�˵����<br>Amount</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="SUM" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������<br>Operator</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="OPP_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��������<br>Date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="OPP_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ɷ�Ʊ��<br>Payment ticket</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="BILL_NO" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ע<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<!-- ��ť����Start -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>