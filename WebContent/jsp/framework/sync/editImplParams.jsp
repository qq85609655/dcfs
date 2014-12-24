
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data=(Data)request.getAttribute("data");
	DataList paramList=(DataList)request.getAttribute("paramList");
%>
<BZ:html>
<BZ:head>
<title>目标系统添加页面</title>
<BZ:script tree="true"/>
<script type="text/javascript" language="javascript">
	function _onload(){
	  //初始化参数列表：
	  initParamList();
	}
	function initParamList(){
		var dataListSize = <%=paramList.size()%>;
		for(var i=0;i<dataListSize-1;i++){
			_addRow();
		}
		setValues();
	}
	function setValues(){
		var index=0;
		var paramNames = document.getElementsByName("P_PARAM_NAME");
		var paramValues = document.getElementsByName("P_PARAM_VALUE");
		<%
		for(int i=0;i<paramList.size();i++){
			Data param = (Data)paramList.get(i);
		%>
		 	index=<%=i%>;
		 	paramNames[index].value='<%=param.getString("PARAM_NAME")%>';
		 	paramValues[index].value='<%=param.getString("PARAM_VALUE")%>';
		<%
		}
		%>
	}
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"sync/saveImplParams.action";
	 	document.srcForm.submit();
	}
	function _back(){
	 	document.srcForm.action=path+"sync/targetSysEdit.action?jsp=edit";
	 	document.srcForm.submit();
	}
	//添加值输入行
	function _addRow(){
			var mynewrow=mtable.insertRow();
		   
		    col1=mynewrow.insertCell(0);
		    col1.style.paddingLeft="5px";
		    col2=mynewrow.insertCell(1);
		    col2.style.paddingLeft="5px";
		    col1.innerHTML="参数名称：<input name=\"P_PARAM_NAME\"  class=\"inputText\" formTitle=\"参数名称\" notnull=\"请输入参数名称\" type=\"text\" onkeyup=\"strFilter(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);\"/>";
		    col2.innerHTML="参数值：<input name=\"P_PARAM_VALUE\"  class=\"inputText\" formTitle=\"参数值\" notnull=\"请输入参数值\" type=\"text\" onkeyup=\"strFilter(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);\" size=\"50\"/>&nbsp;<img onclick='_delRow(this)' src='<BZ:resourcePath />/images/delete.png'></img>";
		}
		//删除值输入行
		function _delRow(obj){
			var tr=obj.parentNode.parentNode;
			var tbl=tr.parentNode;
			tbl.removeChild(tr); 
		}
</script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
<BZ:form name="srcForm" method="post" token="positionGradeAdd">
<BZ:input field="TARGET_ID" type="hidden" prefix="" defaultValue=""/>
<BZ:input field="PARAM_TYPE" type="hidden" prefix="" defaultValue=""/>
<BZ:frameDiv property="clueTo" className="kuangjia">
<table class="contenttable">
	<tr>
		<td width="10%">实现类：</td>
		<td width="85%"><BZ:input field="IMPL" type="String" prefix="P_" defaultValue="" disabled="true" size="80"/></td>
	</tr>
</table>
<div class="heading">编辑实现类参数</div>
<table id="mtable" width="100%"  cellspacing="0" >
	<tr id="tr1" >
			<td style="padding-left: 5px ;width:30%">参数名称：<BZ:input field="PARAM_NAME" prefix="P_" type="String" notnull="请输入参数名称" formTitle="参数名称" onkeyup="strFilter(this)" defaultValue=""/></td>
			<td style="padding-left: 5px ;width:70%">参数值：<BZ:input field="PARAM_VALUE" prefix="P_" type="String" notnull="请输入参数值" formTitle="参数值" onkeyup="strFilter(this)" defaultValue="" size="50"/>&nbsp;<img onclick="_addRow()" src="<BZ:resourcePath />/images/add.png"></img></td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>