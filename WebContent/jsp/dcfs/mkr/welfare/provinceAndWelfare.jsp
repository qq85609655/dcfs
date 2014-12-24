<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();

	Data data = new Data();
	
	//用于回显的省份代码
	data.add("PROVINCE_ID", "110000");
	//用于回显的福利院id
	data.add("SELECTED_ORGAN", "6159");
	request.setAttribute("data", data);
%>
<BZ:html>
<BZ:head>
	<title></title>
	<BZ:webScript edit="true" isAjax="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['welfare','mainFrame']);//公共功能，框架元素自适应
	});
	function selectWelfare(node){
		var provinceId = node.value;
		//用于回显得福利机构ID
		var selectedId = '<%=data.getString("SELECTED_ORGAN") %>';
		var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
		if(dataList != null && dataList.size() > 0){
			//清空
			document.getElementById("welfare_id").options.length=0;
			for(var i=0;i<dataList.size();i++){
				var data = dataList.getData(i);
				if(selectedId==data.getString("ID")){
					document.getElementById("welfare_id").options.add(new Option(data.getString("CNAME"),data.getString("ID")));
					var option = document.getElementById("welfare_id");
					option.options[i].selected = 'selected';
				}else{					
					document.getElementById("welfare_id").options.add(new Option(data.getString("CNAME"),data.getString("ID")));
				}
			}
		}else{
			//清空
			document.getElementById("welfare_id").options.length=0;
			document.getElementById("welfare_id").options.add(new Option("--请选择福利院--",""));
		}
	}
	function initProvOrg(){
		var str = document.getElementById("PROVINCE_ID");
		if(str.value!=""){			
			selectWelfare(str);
		}
	}
	</script>
</BZ:head>
<BZ:body property="data" onload="initProvOrg()" codeNames="PROVINCE;">
	<BZ:form name="organForm" method="post">
		<table>
			<tr>
				<td>
					<BZ:select id="PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="100px"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
						<BZ:option value="">--请选择省份--</BZ:option>
					</BZ:select>
					<BZ:select id="welfare_id" field="welfare_id" formTitle="福利院">
						<BZ:option value="">--请选择福利院--</BZ:option>
					</BZ:select>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>
