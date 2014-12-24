<%
/**   
 * @Title: organopinion_view.jsp
 * @Description:  ��֯����鿴ҳ��
 * @author yangrt   
 * @date 2014-9-14 ����10:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String isPrint = (String)request.getAttribute("isPrint");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>��֯����鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
		</script>
	</BZ:head>
	<BZ:body property="childdata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="OPINION_EN" id="R_OPINION_EN" defaultValue=""/>
		<!-- ��������end -->
		<br/>
		<%
			if("true".equals(isPrint)){
		%>
		<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>
		<%	} %>
		<div id='PrintArea'>
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div class="title3" style="height: 40px;">�����ͯ-��֯���(SN child-Agency comments)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table table-print" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%" height="16px">ʡ��<br>Provincial Civil Affairs Department</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">����Ժ<br>SWI</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">��ͯ����<br>Child name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" isShowEN="true" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL" defaultValue="" isShowEN="true" onlyValue="true"/>
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
							<td class="bz-edit-data-title" width="10%">��ͯ����<br>Child name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" isShowEN="true" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������<br>SN type</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SN_TYPE" property="childData" codeName="BCZL" isShowEN="true" defaultValue="" onlyValue="true"/>
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
								��֯�����Ӣ�ģ�<br>Agency comments (English)<br>
								<BZ:dataValue field="OPINION_EN" style="width:96%;height:200px;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		</div>
	<script>
	//��ӡ�������
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
	</BZ:body>
</BZ:html>