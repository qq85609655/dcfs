<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.hx.framework.propExtend.vo.PropExtend"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String parentId=(String)request.getParameter("parent_id");
if(parentId==null){
	parentId="";
}
String tableTitle="";
if(PropExtend.ORGAN_EXT.equals(parentId)){
	tableTitle="��֯����";
}else if(PropExtend.PERSON_EXT.equals(parentId)){
	tableTitle="��Ա";
}
%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true"/>
	<title>�������</title>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<input type="hidden" name="parent_id" value="<%=request.getParameter("parent_id") %>"/>
		<input type="hidden" name="INPUT_TYPE" id="INPUT_TYPE" value=""/>
		<input type="hidden" name="DATA_NAME" id="DATA_NAME" value=""/>
		<input type="hidden" name="DATA_VALUE" id="DATA_VALUE" value=""/>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="contenttable">
			<tbody>
				<tr>
					<td class="bodytitle" height="24"><div class="heading">����<%=tableTitle %>����</div></td>
				</tr>
				<tr>
					<td class="titledesc" height="28">
					��ָ�������Ե���ʾ���ƣ����������ͣ�����һ�������ԡ���ߡ������ͼȿ������ı������û��������������ֵ���ֿ�����ѡ��������ָ����ͬ����߷�Χ���û�ѡ��������Ϊѡ����������Ϊ���������ÿ�ѡ���ֵ��
					</td>
				</tr>
			</tbody>
		</table>
		<table border="0" width="100%" class="contenttable" align="center">
			<tr align="left">
				<td width="20%">*��ʾ���ƣ�</td>
				<td width="80%"><BZ:input field="PROP_NAME" id="PROP_NAME" prefix="Prop_" type="String" notnull="��������ʾ����" formTitle="��ʾ����" defaultValue=""/>	</td>
			</tr>
			<tr align="left">
				<td>*���Դ��룺</td>
				<td><BZ:input field="PROP_CODE" id="PROP_CODE" type="String" prefix="Prop_" notnull="���������Դ���" formTitle="���Դ���" defaultValue=""/>
			</td>
			</tr>
			<tr align="left">
				<td>*����ţ�</td>
				<td>
				<BZ:input field="SEQ_NUM" type="String" restriction="int" prefix="Prop_" notnull="�����������" formTitle="�����" defaultValue=""/>
				<!--  
				<BZ:select field="DATA_TYPE" prefix="Prop_" notnull="��ѡ����������" formTitle="��������" property="data">
				     	<BZ:option value="">--��ѡ��--</BZ:option>
				     	<BZ:option value="char">�ַ���</BZ:option>
				     	<BZ:option value="int">��&nbsp;&nbsp;��</BZ:option>
				     	<BZ:option value="float">������</BZ:option>
				</BZ:select>
			  -->
				     </td>
			</tr>
			
		</table>
		<iframe align="top" width="100%" height="100%" src="<%=request.getContextPath() %>/prop/propExtend!gotoInputTypeSet.action" id="setFrame" name="setFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
		
	</BZ:form>
</BZ:body>
</BZ:html>