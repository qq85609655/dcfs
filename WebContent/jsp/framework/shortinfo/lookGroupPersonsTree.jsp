<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��֯��Ա��</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function _onload1(){
		try{
			tree.expandAll();
		}catch(e){}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload1();">
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
		    <input type="button" value="�ر�" class="button_delete" onclick="window.close();"/>
		</td>
		</tr>
		</table>
		<div class="heading">Ⱥ����Ȩ��Ա��</div>
		<!-- Ӧ���� -->
		<table>
			<tr>
				<td><BZ:tree property="personOrgTree" type="1" selectvalue="ownPersons" /></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>