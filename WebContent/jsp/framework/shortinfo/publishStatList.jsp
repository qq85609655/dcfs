<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

String statType = (String)request.getAttribute("STAT_TYPE");
DataList dataList = (DataList)request.getAttribute("dataList");
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
function _onload(){

}

function search_(){
document.srcForm.action=path+"shortInfoManager/PublishStat.action";
document.srcForm.submit();
}
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="shortInfoManager/PublishStat.action">
<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
			<table class="chaxuntj">
					<tr>
						<td>统计时间：</td>
						<td  colspan="3">
								从<BZ:input field="BEGIN_TIME" prefix="Search_" style="width:150px" type="Date" defaultValue="" property="data" id="Search_BEGIN_TIME" dateExtend="maxDate:'#F{$dp.$D(\\'Search_END_TIME\\')}',readOnly:true"/>
								&nbsp;&nbsp;到<BZ:input field="END_TIME" style="width:150px" prefix="Search_" type="Date" defaultValue="" property="data" id="Search_END_TIME" dateExtend="minDate:'#F{$dp.$D(\\'Search_BEGIN_TIME\\')}',readOnly:true"/>
						</td>
						<td colspan="4" style="align:right">
								<input type="button" value="查询" class="button_search" onclick="search_()"/>
						</td>
					</tr>
				</table>
</div>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="list">
<div class="heading">短信列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="6%" sortplan="jsp"/>
<BZ:th name="发送人" sortType="string" width="14%" sortplan="jsp"/>
<BZ:th name="发送次数" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="待发送条数" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="发送到网关成功" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="发送到网关失败" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="发送到手机成功" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="发送到手机失败" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="总条数" sortType="string" width="8%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<%
	//总次数
	int total_send_nums = 0;
	//总待发送
	int total_wait_nums = 0;
	//总网关成功
	int total_netgate_suc_nums = 0;
	//总网关失败
	int total_netgate_fal_nums = 0;
	//总手机成功
	int total_tel_suc_nums = 0;
	//总手机失败
	int total_tel_fal_nums = 0;
	//总条数合计
	int total_sum_nums = 0;
%>
<BZ:for property="dataList" fordata="curData">
<%
	Data curData = (Data)pageContext.findAttribute("curData");
	//合计部分
	total_send_nums+=curData.getInt("SEND_NUMS");
	total_wait_nums+=curData.getInt("WAIT_SEND_NUM");
	total_netgate_suc_nums+=curData.getInt("NETGATE_SUC_NUM");
	total_netgate_fal_nums+=curData.getInt("NETGATE_FAL_NUM");
	total_tel_suc_nums+=curData.getInt("TEL_SUC_NUM");
	total_tel_fal_nums+=curData.getInt("TEL_FAL_NUM");
	total_sum_nums+=curData.getInt("TOTAL_SUM_NUM");
%>
<tr>
<td noselect="true"><BZ:i></BZ:i></td>
<td><BZ:data field="P_CNAME" defaultValue=""/>[<BZ:data field="D_CNAME" defaultValue="" onlyValue="true"/>]</td>
<td><BZ:data field="SEND_NUMS" defaultValue=""/></td>
<td><BZ:data field="WAIT_SEND_NUM" defaultValue=""/></td>
<td><BZ:data field="NETGATE_SUC_NUM" defaultValue=""/></td>
<td><BZ:data field="NETGATE_FAL_NUM" defaultValue=""/></td>
<td><BZ:data field="TEL_SUC_NUM" defaultValue=""/></td>
<td><BZ:data field="TEL_FAL_NUM" defaultValue=""/></td>
<td><BZ:data field="TOTAL_SUM_NUM" defaultValue=""/></td>
</tr>
</BZ:for>
<%
	if(dataList != null && dataList.size() > 0){
%>
<tr>
<td colspan="2" align="center" noselect="true">总&nbsp;&nbsp;计</td>
<td><%=total_send_nums %></td>
<td><%=total_wait_nums %></td>
<td><%=total_netgate_suc_nums %></td>
<td><%=total_netgate_fal_nums %></td>
<td><%=total_tel_suc_nums %></td>
<td><%=total_tel_fal_nums %></td>
<td><%=total_sum_nums %></td>
</tr>
<%
	}
%>
</BZ:tbody>
</BZ:table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>