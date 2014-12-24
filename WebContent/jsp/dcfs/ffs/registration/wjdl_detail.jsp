<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String is_change_org = (String) request.getAttribute("is_change_org");
	String male_name = (String)request.getAttribute("male_name");
	String famale_name = (String)request.getAttribute("famale_name");
	String file_code = (String)request.getAttribute("file_code");
	System.out.println(is_change_org);
%>
<BZ:html>
<BZ:head>
	<title>�ļ��Ǽ���Ϣ�鿴</title>
	<BZ:webScript edit="true" tree="false"/>
	<up:uploadResource/>
	<script>
	/*function _goback(){
		window.history.go(-1);	
	}*/
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;FYLB;JFFS;SYZZ;WJWZ" property="wjdlData">
	<BZ:form name="srcForm" method="post">
	
	<BZ:input field="AF_ID" id="AF_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ļ�������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">�ļ�����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" checkValue="1=˫������;2=��������;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title" width="20%">������֯</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						
					</tr>
					<%
					if("1".equals(is_change_org)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">ת��֯</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="IS_CHANGE_ORG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
						</td>
						<td class="bz-edit-data-title" width="20%">ԭ���ı��</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%
					}
					%>
					<%
					if(!"".equals(male_name)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�������ڣ��У�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<%
					}
					if(!"".equals(famale_name)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">Ů������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�������ڣ�Ů��</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<%
					}
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">�ļ�λ��</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�ļ�״̬</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="REG_STATE" checkValue="1=δ�Ǽ�;2=���޸�;3=�ѵǼ�;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REG_REMARK" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					Ʊ����Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">Ӧ�ɽ��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ɷѷ�ʽ</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Ʊ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ɷѱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ɷ�Ʊ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ɷ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">�ɷ�ƾ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadList id="FILE_CODE" firstColWidth="20px" attTypeCode="OTHER" packageId='<%=file_code%>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">�ɷѱ�ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<!-- <div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div> -->
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
