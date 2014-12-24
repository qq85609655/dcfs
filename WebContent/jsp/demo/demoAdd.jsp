<%@page import="hx.code.Code"%>
<%@page import="hx.common.Constants"%>
<%@page import="java.util.HashMap"%>
<%@page import="hx.code.CodeList"%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	//��ӡ��޸�ҳ�����Ҫ��BZ��body  property����ָ��Data����
	Data data = (Data)request.getAttribute("data");
	if(data == null){
		data = new Data();
	}
	data.add("NAME", "���");
	data.add("SEX", "1");
	data.add("POST", "test2");
	data.add("TIME", "2014-6-25");
	data.add("ORG_ID", "f0efa755-073a-4f2c-a547-cf49e84f7da3");
	request.setAttribute("data", data);

	//��ʾʹ�õĶ��󼯺ϴ��뼯
	HashMap<String, CodeList> positionMap = new HashMap<String, CodeList>();
	CodeList positionList = new CodeList();
	Code code1 = new Code();
	code1.setName("������뼯1");
	code1.setValue("test1");
	code1.setParentValue("����ֵ1");
	positionList.add(code1);
	Code code2 = new Code();
	code2.setName("������뼯2");
	code2.setValue("test2");
	code2.setParentValue("����ֵ2");
	positionList.add(code2);
	positionMap.put("positionList", positionList);
	request.setAttribute(Constants.CODE_LIST, positionMap);
%>
<BZ:html>
<BZ:head>
	<title>���ߵ������</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
</script>
<BZ:body codeNames="SEX" property="data">
	<BZ:form name="srcForm" method="post">
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action" desc="��ť��">
			<a href="reporter_files_list.html" >
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
			<input type="button" value="ȡ��" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>
	</div>
	<!-- ��ť�� ���� -->

	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					���ߵ������
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">����:</td>
						<td class="bz-edit-data-value">
						<BZ:input field="NAME" prefix="P_" type="String" notnull="����������" formTitle="����" defaultValue="" />
						</td>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value">
						<BZ:select field="SEX" prefix="P_" formTitle="" isCode="true" codeName="SEX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְ��:</td>
						<td class="bz-edit-data-value">
						<BZ:select field="POST" formTitle="" prefix="P_" isCode="true" codeName="positionList" property="data"/>
						</td>
						<td class="bz-edit-data-title">������֯��</td>
						<td class="bz-edit-data-value">
						<BZ:input field="ORG_ID" prefix="P_" helperCode="SYS_ORGAN" type="helper" helperTitle="ѡ��������֯" treeType="2" helperSync="true" property="data" showParent="false" style="width:100px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����:</td>
						<td class="bz-edit-data-value">
						<BZ:input field="TIME" prefix="P_" type="date"/>
						</td>
						<td class="bz-edit-data-title">��ϸ���ڣ�</td>
						<td class="bz-edit-data-value">
						<BZ:input field="DETAIL_TIME" prefix="P_" type="datetime"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">����:</td>
						<td class="bz-edit-data-value" colspan="3">
						<textarea style="height: 60px;width: 97%;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����:</td>
						<td class="bz-edit-data-value" colspan="3">
						<up:uploadBody
							attTypeCode="PUBLISH_IMAGE"
							id="att"
							name="P_ATT"
							packageId="22dcee42-eb5c-4b7b-9046-d64d61020c67"
							queueStyle="border: solid 1px #CCCCCC;width:97%"
							selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
							/>
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
