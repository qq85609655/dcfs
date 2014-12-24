<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String organId = (String)request.getAttribute("ORGAN_ID");
if(organId == null){
    organId = "";
}
%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
function tijiao(){
	_checkData();
	if(isCheck){
		document.srcForm.action=path+"linkman/add.action";
	 	document.srcForm.submit();		
	}
}
function _back(){
 	document.srcForm.action=path+"linkman/outerlist.action";
 	document.srcForm.submit();
}
var allData = new Array();
var i = 0;
<BZ:for property="AllDataList">
allData[i] = new Array();
allData[i]["CNAME"]="<BZ:data field="CNAME" onlyValue="true" defaultValue=""/>";
allData[i]["MOBILE"]="<BZ:data field="MOBILE" onlyValue="true" defaultValue=""/>";
allData[i]["ORGNAME"]="<BZ:data field="ORGNAME" onlyValue="true" defaultValue=""/>";
i++;
</BZ:for>
var isCheck = false;
function _checkData(){
	var data = document.srcForm.linkmans.value;
	data = data.trim();
	if (data==""){
		//alert("�������������ֻ��š����ţ�\n��ʽΪ��\n����	��λ	�ֻ���\n����	��λ	�ֻ���");
		alert("�������������ֻ��ţ�\n��ʽΪ��\n����	�ֻ���\n����	�ֻ���");
	}
	data = data.replaceByString("	",","); //�Ʊ����Excel��ʽ��
	data = data.replaceByString("��",",");
	data = data.replaceByString("��",",");
	data = data.replaceByString(";",",");
	data = data.replaceByString(" ",","); //�ո�
	var dataList = data.split("\r\n");
	var str="";
	var nDatas = new Array();
	nDatas = _checkSelfData(dataList,nDatas);
	var c = true;
	for(var i=0;i<nDatas.length;i++){
		var td = nDatas[i];
		var oData = td.split(",");
		if(oData.length<2){
			alert("���ݸ�ʽ������������" + td);
			c = false;
			break;
		}else if(oData.length>=2){
			var t = td.split(",");
			var name = t[0];
			var tel = t[1];
			var orgName="";
			if (t.length>=3){
				orgName = t[2];
			}
			
			td = name + "," + orgName + "," + tel;
		}
		var d = td + "," + _CheckOneData(oData);
		if(str!=""){
			str+="\r\n";
		}
		str+=d;
	}
	isCheck = c;
	if(isCheck){
		document.srcForm.linkmans.value = str;
	}
}
function _checkSelfData(dataList,nDatas){
	var len = dataList.length;
	for(var i=0;i<len;i++){
		var oData = dataList[i].split(",");
		var ok=false;
		for(var j=(i+1);j<len;j++){
			if (j<len){
				if(dataList[j]==dataList[i]){
					ok=true;
				}
			}
		}
		if(!ok){
			nDatas[nDatas.length]=dataList[i];
		}
	}
	return nDatas;
}
function _CheckOneData(data){
	var len = allData.length;
	var name = data[0];
	//var org = data[2];
	var org = "";
	var tel = data[1];
	var gx = false;
	var hl = false;
	for(var i=0;i<len;i++){
		var cname = allData[i]["CNAME"];
		var corg = allData[i]["ORGNAME"];
		var ctel = allData[i]["MOBILE"];
		if(cname.trim()==name.trim()){
			if(ctel==tel && corg==corg){
				hl=true;
				break;
			}else{
				gx=true;
				break;
			}
		}
	}
	if(gx){
		return "����";
	}
	if(hl){
		return "�Ѵ���";
	}
	return "����";
}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<!-- ��֯ID -->
<input type="hidden" name="ORGAN_ID" value="<%=organId%>"/>

<div class="kuangjia">
<div class="heading">�����ϵ��</div>
<table class="contenttable">
<tr>
<td></td>
<td align="right">��ϵ��</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="linkmans"></textarea></td>
</tr>
<tr>
<td></td>
<td></td>
<td colspan="4">�����ʽ�������������ֻ���<br>���������������������ֻ���
</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_save" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset" />&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>