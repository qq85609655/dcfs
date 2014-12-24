<%
/**   
 * @Title: addmaterial_revise_OP.jsp
 * @Description:  �����ƻ�/��֯����޸�ҳ��
 * @author panfeng   
 * @date 2014-11-4 15:41:15 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�����ƻ�/��֯����޸�ҳ��</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-ui-1.10.3.min.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
	
	//�������
	function _save() {
		if (confirm("ȷ��������")) {
			document.srcForm.action = path + "sce/addMaterial/modInfoSave.action?type=PO";
			document.srcForm.submit();
			window.close();
		}
	}
	
	</script>
	<BZ:body property="data">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="P_" field="RI_ID" type="hidden" defaultValue="" />
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����ͯ-�����ƻ�(Rehabilitation and Nurture Plan)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">����(CN)</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="P_" field="TENDING_CN" id="P_TENDING_CN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����(EN)</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="P_" field="TENDING_EN" id="P_TENDING_EN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����ͯ-��֯���(Agency Opinion)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">����(CN)</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="P_" field="OPINION_CN" id="P_OPINION_CN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����(EN)</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="P_" field="OPINION_EN" id="P_OPINION_EN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
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
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save()"/>
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="window.close();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
	</BZ:body>
</BZ:html>