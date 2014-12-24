<%
/**   
 * @Title: CIs_info_inChildNo.jsp
 * @Description: 儿童信息查看
 * @author xugy
 * @date 2014-10-30上午10:53:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
DataList CIdls = (DataList)request.getAttribute("CIdls");
%>
<BZ:html>
<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/common.js"/>
<BZ:head>
	<title>儿童信息查看</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<!-- <script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
</script> -->
<BZ:body codeNames="PROVINCE;ETXB;ETSFLX;">
<script type="text/javascript">
$(document).ready(function() {
	//intoiframesize('CIsFrame');
	$('#tab-container').easytabs();
});
</script>
<BZ:form name="srcForm" method="post">
	<div id="tab-container" class='tab-container'>
        <%
		if(CIdls.size()>1){
		%>
		<ul class="etabs">
			<%
			for(int i=0;i<CIdls.size();i++){
			    Data d = CIdls.getData(i);
			    String NAME = d.getString("NAME");
			%>
		   <li class="tab"><a href="#tab<%=i+1 %>"><%=NAME %></a></li>
		   <%} %>
		</ul>
		<%} %>
		<div class='panel-container'>
			<%
			int i=0;
			%>
			<BZ:for property="CIdls" fordata="mydata">
            	<div id="tab<%=i+1 %>">
					<table class="specialtable">
						<tr>
	                    	<td class="edit-data-title" style="text-align:center" colspan="5"><b>儿童基本信息</b></td>
	                    </tr>
						<tr>
							<td class="edit-data-title" width="13%">儿童编号</td>
							<td class="edit-data-value" width="30%">
								<BZ:dataValue field="CHILD_NO" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title" width="13%">儿童类型</td>
							<td class="edit-data-value" width="30%">
								<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" checkValue="1=正常;2=特需;" property="mydata"/>
							</td>
							<td class="edit-data-value" width="14%" rowspan="5">
								<%
								String CI_ID = ((Data) pageContext.getAttribute("mydata")).getString("CI_ID");
								%>
								<img src='<up:attDownload attTypeCode="CI" packageId="<%=CI_ID%>" smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">省份</td>
							<td class="edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" property="mydata"/>
							</td>
							<td class="edit-data-title">福利院</td>
							<td class="edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">姓名</td>
							<td class="edit-data-value">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title">姓名拼音</td>
							<td class="edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">性别</td>
							<td class="edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" property="mydata"/>
							</td>
							<td class="edit-data-title">出生日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">体检日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="CHECKUP_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">是否有同胞</td>
							<td class="edit-data-value">
								<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=否;1=是;" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">身份证号</td>
							<td class="edit-data-value">
								<BZ:dataValue field="ID_CARD" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title">儿童身份</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">送养人</td>
							<td class="edit-data-value">
								<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title">送养人地址</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">捡拾日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="PICKUP_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">入院日期</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="ENTER_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">报送日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="SEND_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">是否报刊公告</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="IS_ANNOUNCEMENT" defaultValue="" onlyValue="true" checkValue="0=否;1=是;" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">公告日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="ANNOUNCEMENT_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">报刊名称</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="NEWS_NAME" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">备注</td>
							<td class="edit-data-value" colspan="4">
								<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
					</table>
                </div>
                <%
				i++;
				%>
			</BZ:for>
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>
