<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true"/>
	<title>�������</title>
<script>
function changeButton(flag){
	if(flag==1){
		document.getElementById("qddiv").style.display="";
		document.getElementById("xybdiv").style.display='none';
	}
	else{
		document.getElementById('xybdiv').style.display = "";
		document.getElementById('qddiv').style.display = 'none';
	}
}
</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="contenttable">
			<tbody>
				<tr>
					<td class="bodytitle" height="24"><div class="heading">������֯����</div></td>
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
				<td width="80%"><BZ:input field="CNAME" type="String" notnull="��������ʾ����" formTitle="��ʾ����" defaultValue=""/>	</td>
			</tr>
			<tr align="left">
				<td>*���Ա��룺</td>
				<td><BZ:input field="CODE" type="String" notnull="���������Ա���" formTitle="���Ա���" defaultValue=""/>
			</td>
			</tr>
			<tr align="left">
				<td>*������</td>
				<td><BZ:input field="MEMO" type="String" notnull="����������" formTitle="����" defaultValue=""/></td>
			</tr>
		</table>
		<table border="0" width="100%" class="contenttable">
			<tr><td colspan="2" align="left"><div class="heading">ѡ������</div></td></tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>�ı������ <span>(�ʺ����������ı�)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>�ı���  <span>(����������ı�������,���������ݽ϶���ı�)</span></td></tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>��ѡ��ť <span>(��ѡ��ť ʹ�õ�ѡ��ťѡ��һ��ֵ)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>��ѡ��ť <span>(ʹ�ø�ѡ��ťѡ����ֵ)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>��ѡ�б� <span>(ʹ�õ�ѡ�����б�,ѡ��һ��ֵ)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>��ѡ�б� <span>(ʹ�ö�ѡ�б��ѡ����ֵ,Ĭ��ֵΪ3)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>��Աѡ�� <span>(ʹ��Framework��Աѡ��ؼ�,����һ����Ա)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>��֯ѡ�� <span>(ʹ��Framework��֯ѡ��ؼ�,����һ����֯)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>����ѡ�� <span>(ʹ������ѡ��ؼ���������)</span></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">
					<div id="qddiv" style="display: none">
						<input id="qd" type="button" class="button_add" value="ȷ��" />
					</div>
					<div id="xybdiv" style="display: none">
						<input id="xyb" type="button" class="button_goto" value="��һ��" />
					</div>
				</td>
				<td align="left">
					<input type="button" class="button_back" onclick="javascript:window.close();" value="����"/>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>