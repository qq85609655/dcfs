<%
/**   
 * @Title: cms_child_attList.jsp
 * @Description: 儿童材料附件
 * @author xugy
 * @date 2014-11-30下午3:46:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
DataList dl = (DataList)request.getAttribute("attType");
%>
<BZ:html>
<BZ:head>
	<title>儿童材料附件</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['attFrame','iframe','mainFrame']);//公共功能，框架元素自适应
	//intoiframesize('attFrame');
	//var obj = parent.document.getElementById("attFrame");
	//var doc = obj.contentWindow.document || obj.contentDocument;
	//obj.style.height =	doc.body.offsetHeight +'px';
});

function _show(path){
	parent._showPhoto(path);
}

function _saveDES(type,id,des){
	getData("com.dcfs.pfr.AjaxSavePPFeedbackAttDES", "type="+type+"&id="+id+"&des="+des);
}
</script>
</BZ:head>
<BZ:body>
	<table class="specialtable" border="0">
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>
		<tr>
			<td class="edit-data-title">项目  Item</td>
			<td class="edit-data-title" style="text-align: center;">中文  Chinese</td>
			<td class="edit-data-title" style="text-align: center;">英文  English</td>
		</tr>
		<%
		for(int i=0;i<dl.size();i++){
		    String CNAME = dl.getData(i).getString("CNAME");
		    String ENAME=dl.getData(i).getString("ENAME");
		    String smallTyeCode=dl.getData(i).getString("CODE");
		    DataList ATTCNLIST = (DataList)dl.getData(i).get("ATTCNLIST");//中文附件
		    DataList ATTENLIST = (DataList)dl.getData(i).get("ATTENLIST");//英文附件
		%>
		<tr>
			<td class="edit-data-title" align="center">
				<%=CNAME %><br/><%=ENAME%>
			</td>
			<%if(AttConstants.CI_SHZP.equals(smallTyeCode)||AttConstants.CI_CJSQ.equals(smallTyeCode)||AttConstants.CI_CJSH.equals(smallTyeCode)) {%>
				<td class="edit-data-value" colspan="2">
						<%
						if(ATTCNLIST.size()>0){
						    for(int j=0;j<ATTCNLIST.size();j++){
						        String ATT_NAME = ATTCNLIST.getData(j).getString("ATT_NAME");
						        String ID = ATTCNLIST.getData(j).getString("ID");
						        
						%>
							<div style="width: 275px;float: left;margin: 5px;text-align: center;">
								<input type="image" src='<up:attDownload attTypeCode="CI" attId="<%=ID%>" smallType="<%=smallTyeCode %>"/>' height="150px" onclick="_show('<%= path %>/feedback/showPicture.action?ATT_TABLE=ATT_CI&ID=<%=ID %>')" />
							</div>
						<%
							}
						}
						%>
						</td>
			<%
			 }else{%>
			    <td class="edit-data-value">
				<%
				if(ATTCNLIST.size()>0){
				%>
					<table class="attlisttable">
				<%
				    for(int j=0;j<ATTCNLIST.size();j++){
				        String ATT_NAME = ATTCNLIST.getData(j).getString("ATT_NAME");
				        String ID = ATTCNLIST.getData(j).getString("ID");
				        String ATT_TYPE = ATTCNLIST.getData(j).getString("ATT_TYPE");
				        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=CI&type="+ATT_TYPE;
				%>
						<tr>
							<td width="5%"><%=j+1%>.</td>
							<td width="70%"><%=ATT_NAME%></td>
							<td width="25%">&nbsp;
								<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
								<a href="<up:attDownload attTypeCode="CI" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
							</td>
						</tr>
				<%
					}
				%>
					</table>
				<%
				}
				%>
				</td>
				<td class="edit-data-value">
				<%
				    if(ATTENLIST.size()>0){
				%>
						<table class="attlisttable">
				<%
					    for(int j=0;j<ATTENLIST.size();j++){
					        String ATT_NAME = ATTENLIST.getData(j).getString("ATT_NAME");
					        String ID = ATTENLIST.getData(j).getString("ID");
					        String ATT_TYPE = ATTENLIST.getData(j).getString("ATT_TYPE");
					        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=CI&type="+ATT_TYPE;
				%>
						<tr>
							<td width="5%"><%=j+1%>.</td>
							<td width="70%"><%=ATT_NAME%></td>
							<td width="25%">&nbsp;
								<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
								<a href="<up:attDownload attTypeCode="CI" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
							</td>
						</tr>
				<%
					    }
				%>
					</table>
				<%
				    }
				%>
				</td>
			</tr>
	 <% }%>
	<%} %>
  </table>
</BZ:body>
</BZ:html>
