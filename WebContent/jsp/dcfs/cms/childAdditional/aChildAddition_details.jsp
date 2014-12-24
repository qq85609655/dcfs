<%
/**   
 * @Title: childAddition_supply.jsp
 * @Description:  儿童材料信息补充页面
 * @author furx   
 * @date 2014-9-9 下午14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="hx.database.databean.DataList"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
		<!-- 编辑区域begin -->
		<%
	        DataList additionList=(DataList)request.getAttribute("additionList");
		    int j=0;
	        if(additionList.size()==0){
		%>
          <br/>
          <center><font color="red" size="2px">没有补充记录！</font></center>
	     <% }else{%>
	       <br/>
	     <%} %>
		<BZ:for property="additionList" fordata="myData">
		  <%
		  	Data dat = (Data) pageContext.getAttribute("myData");
		    String affix=(String)dat.getString("UPLOAD_IDS");
		    String affixId="AFFIXA"+(Integer.toString(j));
		    j++;
		   %>
		   <table class="specialtable" align="center" style='width:100%;text-align:center'>
				<tr>
					<td class="edit-data-title" style="text-align: left;"><BZ:i/>、补充通知人：<BZ:data field="SEND_USERNAME" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;补充通知日期：<BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;补充状态：<BZ:data field="CA_STATUS" onlyValue="true" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充;"/></td>
				</tr>
			</table>
			<table class="specialtable" align="center" style='width:100%;text-align:center'>
				<tr>
					<td class="edit-data-title" width="14%" style="text-align: left;padding-left: 6px">通知内容</td>
					<td class="edit-data-value" colspan="5" width="86%">
						<BZ:data field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
					</td>
					
				</tr>
				<tr>
					<td class="edit-data-title" width="14%" style="text-align: left;padding-left: 6px">回复单位</td>
					<td class="edit-data-value" width="23%">
						<BZ:data field="FEEDBACK_ORGNAME" onlyValue="true" defaultValue=""/>
					</td>
					<td class="edit-data-title" width="14%" style="text-align: left;padding-left: 6px">回复人</td>
					<td class="edit-data-value" width="16%">
						<BZ:data field="FEEDBACK_USERNAME" onlyValue="true" defaultValue=""/>
					</td>
					<td class="edit-data-title" width="14%" style="text-align: left;padding-left: 6px">回复时间</td>
					<td class="edit-data-value" width="16%">
					    <BZ:data field="FEEDBACK_DATE" type="Date" onlyValue="true" defaultValue=""/>
					</td>
				</tr>
				<tr>
					<td class="edit-data-title" width="14%" style="text-align: left;padding-left: 6px">补充附件</td>
					<td class="edit-data-value" colspan="5" width="86%">
						<up:uploadList name="AFFIX" id="<%=affixId %>" attTypeCode="CI" packageId="<%=affix%>" secondColWidth="100%" smallType="<%=AttConstants.CI_BCCL %>" />
					</td>
				</tr>
				<tr>
					<td class="edit-data-title" width="14%" style="text-align: left;padding-left: 6px">回复内容</td>
					<td class="edit-data-value" colspan="5" width="86%">
						<BZ:data field="ADD_CONTENT" onlyValue="true" defaultValue=""/>
					</td>
				</tr>
			</table>
			<br/>
		</BZ:for>
