<%
/**   
 * @Title: revokereason_view.jsp
 * @Description:  Ԥ����Чԭ��鿴ҳ��
 * @author yangrt   
 * @date 2014-9-14 ����10:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>Ԥ����Чԭ��鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<script>
			function _goback(){
				window.close();
			}
		</script>
	</BZ:head>
	<BZ:body property="applydata">
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div class="title3" style="height: 40px;">Ԥ����Чԭ��</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table table-print" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" height="16px">��������<br></td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="REVOKE_TYPE" checkValue="0=��֯����;1=���ĳ���;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����ԭ��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>