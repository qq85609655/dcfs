<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*,java.util.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	DataList datalist = (DataList) request.getAttribute("dataList");
	int A_Count = datalist.size();
%>
<BZ:html>
<BZ:head>
	<BZ:script />
	<script type="text/javascript">
function _save(){
	var count=<%=A_Count%>;
	for(var i=0;i<count;i++){
		var UNLOCK_LIMIT = document.getElementById("UNLOCK_LIMIT_"+i).value;
		var cname = document.getElementById("A_CNAME_"+i).value;
//		if(UNLOCK_LIMIT ==""){
//			alert(cname+" "+"未填写账号解锁周期");
//			return false;
//		}
//		if (!UNLOCK_LIMIT.isPlusInt()) {
//			alert(cname+" "+"账号解锁周期只能填写正整数！");
//			return false;
//		}
		var j,myObj;
		myObj=document.getElementsByName("STATUS_"+i);
		for(j=0;j<myObj.length;j++){
			if(myObj[j].checked)break;
			}
//		if(j>=myObj.length){
//		  alert(cname+"：没有选择状态");
//		  return false;
//		}
	}	
	document.srcForm.action=path+"poAccUnlock/poAccSave.action";
	document.srcForm.submit();
}
function _goBack(){
	document.srcForm.action=path+"securityPolicy/securityPolicyList.action";
	document.srcForm.submit();
}
</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post"
		action="poAccUnlock/poAccSave.action">
		<input type="hidden" name="A_Count" value="<%=A_Count%>"></input>
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<div class="heading">账号自动解锁设置</div>
		<table class="contenttable">
			<%
				if (datalist != null&&datalist.size()>0) {
								for (int i = 0; i < datalist.size(); i++) {
									Data data = datalist.getData(i);
			%>
			<tr>
				<td></td>
				<td>
				<fieldset style="margin-top: 5px"><legend><strong><%=data.getString("A_CNAME", "")%></strong></legend>
				<table>
					<tr>
						<td>账号解锁周期</td>
						<td><input type="text" id="UNLOCK_LIMIT_<%=i%>"	name="UNLOCK_LIMIT_<%=i%>" value="<%=data.getString("UNLOCK_LIMIT", "30")%>" formTitle="账号解锁周期"  restriction="int" onkeyup="_check_one(this);" notnull="请输入账号解锁周期" ></input>分钟
							<input type="hidden" name="ID_<%=i%>" value="<%=data.getString("ID")%>">
							<input type="hidden" name="TYPEID_<%=i%>" value="<%=data.getString("A_ID")%>">
							<input type="hidden" name="A_CNAME_<%=i%>" id="A_CNAME_<%=i%>" value="<%=data.getString("A_CNAME")%>">
						</td>
					</tr>
					<tr>
						<td>状态</td>
						<td><input type="radio" name="STATUS_<%=i%>" value="1"
							<%if ("1".equals(data.getString("STATUS"))) {%> checked <%}%>>启用
						<input type="radio" id="STATUS_<%=i%>" name="STATUS_<%=i%>"
							value="0" <%if ("0".equals(data.getString("STATUS"))) {%> checked
							<%}%>>禁用</td>
					</tr>
					<tr>
						<td>备注</td>
						<td><textarea rows="3" cols="80" name="MEMO_<%=i%>"><%=data.getString("MEMO", "")%></textarea></td>
					</tr>
				</table>
				</fieldset>
				</td>
			</tr>
			<%
				}
							}
			%>
			<tr>
				<td></td>
				<td align="center"><input type="button" value="保存"
					class="button_add" onclick="_save()" />&nbsp;&nbsp;<input
					type="button" value="返回" class="button_back" onclick="_goBack()" /></td>
			</tr>
		</table>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>