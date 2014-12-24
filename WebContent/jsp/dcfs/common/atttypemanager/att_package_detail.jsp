<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:描述
 * @author xxx   
 * @date 2014-10-27 12:28:58
 * @version V1.0   
 */
    /******Java代码功能区域Start******/
 	//构造数据对象
	Data data = (Data)request.getAttribute("data");
String SMALL_TYPE_IDS = ","+data.getString("SMALL_TYPE_IDS")+",";
DataList smallTypeList = (DataList)request.getAttribute("smallTypeList");
    if(data==null){
        data = new Data();
    }
	request.setAttribute("data",data);
	/******Java代码功能区域End******/
%>
<BZ:html>
<BZ:head>
	<title>查看</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	//});
	
	function _goback(){
		document.srcForm.action = path + "attpackage/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>附件集合查看</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					 <td class="bz-edit-data-title" width="15%">业务大类</td>
						<td class="bz-edit-data-value" width="75%">
						<BZ:dataValue field="BIG_TYPE"  defaultValue="" onlyValue="true" checkValue="CI=儿童材料;AF=家庭文件;AR=反馈报告;OTHER=其他"/>
					
					</tr>
					<tr>
					<td class="bz-edit-data-title">名称</td>
					<td class="bz-edit-data-value">
						<BZ:dataValue field="PACKAGE_NAME"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					<tr>
					<td class="bz-edit-data-title">小类集合</td>
					
					<td class="bz-edit-data-value">
						<%
						if(smallTypeList!=null && smallTypeList.size()!=0){
						%>
							<table class="attlisttable">
						<%
							for(int i=0;i<smallTypeList.size();i++){
								Data typeData = smallTypeList.getData(i);
								//小类名称
								String CNAME = typeData.getString("CNAME");
								//小类代码
								String CODE = typeData.getString("CODE");
								String s = ","+CODE+",";
								String checked = "";
								if(SMALL_TYPE_IDS.indexOf(s)>-1){
									checked = "checked";
								}
												
						%>
						<% if((i%2)==0){%><tr><% }%>
							<td width="50%"><input type="checkbox" id="SMALL_TYPE" value="<%= CODE%>" <%=checked %> Disabled><%=CNAME%></td>
						<% if((i%2)==1){%></tr><% }%>
							<%}%>
						
						</table>
						<%}%>
					</td> 
					 </tr>
					 
				</table>
				</div>
			</div>
		</div>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>