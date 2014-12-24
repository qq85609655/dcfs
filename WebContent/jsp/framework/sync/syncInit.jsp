
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	DataList dataList = (DataList)request.getAttribute("dataList");
%>
<BZ:html>
<BZ:head>
<title>����ͬ����ʼ��</title>
<style>
	.mytable {width:100%; background:#e9f2fd; color:#020202; font-family:"����";}
	.mytable td {height:24px; line-height:24px; padding:0 5px;vertical-align:top}
	.mytable tr{height:24px;}
</style>
<BZ:script tree="true"/>
<script type="text/javascript" language="javascript">
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		var checkboxs = document.getElementsByName("P_SYNC_TYPE");
		if(!isChecked(checkboxs)){
			alert("��ѡ��[ͬ������]��");
			return ;
		}
		checkboxs = document.getElementsByName("P_TARGET_ID");
		if(!isChecked(checkboxs)){
			alert("��ѡ��[Ŀ��ϵͳ]��");
			return ;
		}
		document.srcForm.action=path+"sync/doSyncInit.action";
	 	document.srcForm.submit();
	}
	function isChecked(obj){
		var result=false;
		for(var i=0;i<obj.length;i++){
			if(obj[i].checked){
				result=true;
				break;
			}
		}
		return result;
	}
	function _back(){
	 	document.srcForm.action=path+"sync/TargetSys.action";
	 	document.srcForm.submit();
	}
	function _checkAll(obj,id){
		var checkboxs;
		if(id=='CheckAllType'){
		  checkboxs = document.getElementsByName("P_SYNC_TYPE");
		}else if(id=='CheckAllTarget'){
		  checkboxs = document.getElementsByName("P_TARGET_ID");
		}
		if(!checkboxs){
			return
		}
		if(obj.checked){
			for(var i=0;i<checkboxs.length;i++){
				checkboxs[i].checked=true;
			}
		}else{
			for(var i=0;i<checkboxs.length;i++){
				checkboxs[i].checked=false;
			}
		}
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" token="positionGradeAdd">
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">����ͬ����ʼ��</div>
<table class="mytable">
<tr>
<td width="30%">
	<table>
		<tr><td>ͬ�����ͣ�<input type="checkbox" value="1" id="CheckAllType" onclick="_checkAll(this,'CheckAllType')">ȫѡ</td></tr>
		<tr><td>
			<BZ:checkbox field="SYNC_TYPE" value="userSync" formTitle="" prefix="P_">�û�ͬ��</BZ:checkbox><br>
			<BZ:checkbox field="SYNC_TYPE" value="orgSync" formTitle="" prefix="P_">��֯����ͬ��</BZ:checkbox>
		</td></tr>
	</table>
	<br>
</td>
<td width="70%">
	<table>
		<tr><td>Ŀ��ϵͳ��<input type="checkbox" value="1" id="CheckAllTarget" onclick="_checkAll(this,'CheckAllTarget')">ȫѡ</td></tr>
		<tr><td>
			<%
				for(int i = 0;i<dataList.size();i++){
					Data data = dataList.getData(i);
					String targetId = data.getString("TARGET_ID");
					String targetName = data.getString("TARGET_NAME");
					%>
					<input type="checkbox" value="<%=targetId %>" name="P_TARGET_ID"><%=targetName %><br>
					<%
				}
			%>
		</td></tr>
	</table>
</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="left" style="padding-left:30px" colspan="2"><input type="button" value="ִ��ͬ��" class="button_send" onclick="tijiao()"/></td>
</tr>
</table>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>