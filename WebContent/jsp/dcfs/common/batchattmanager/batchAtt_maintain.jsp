<%
/**   
 * @Title: batchAtt_maintain.jsp
 * @Description:
 * @author wangz   
 * @date 2014-9-5
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>

<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	DataList attType = (DataList)request.getAttribute("attType");//
	Map<String, DataList> attMap = (Map<String, DataList>)request.getAttribute("attMap");//
	String IS_EN = (String)request.getAttribute("IS_EN");
	String bigType = (String)request.getAttribute("bigType");
%>
<BZ:html>
<BZ:head>
    <title>Batch management of attachment</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
	<script type="text/javascript" src="<%=path%>/resource/js/jquery-1.9.1.min.js.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<script type="text/javascript">

	$(document).ready( function() {
		setSigle();
		dyniframesize(['frmUpload','iframe','mainFrame']);
		dyniframesize(['frmUpload1','iframe','mainFrame']);
		/*if(parent.document.getElementById("frmUpload")){
			var obj = parent.document.getElementById("frmUpload");
			obj.style.height =	obj.contentDocument.body.offsetHeight +'px';
		}
		
		if(parent.document.getElementById("frmUpload1")){
			var obj1 = parent.document.getElementById("frmUpload1");
			obj1.style.height =	obj1.contentDocument.body.offsetHeight +'px';
		}*/
		
	})
</script>
<BZ:body>
<table class="specialtable" width="100%">
	<%
	int t = 0;//
	for(int i=0;i<attType.size();i++){
		Data dType = attType.getData(i);
		String typeName = null;
		if("true".equals(IS_EN)){
			typeName = dType.getString("ENAME");
		}else{
			typeName = dType.getString("CNAME");
		}
		String typeCode = dType.getString("CODE");
		DataList dl = (DataList)attMap.get(typeCode);
		
		if((t%2)==0){
	%>
	<tr>
	<%
		}
	%>
		<td class="edit-data-title" width="15%"><%=typeName%></td>
		<td class="edit-data-value" width="35%">
		
		<%
		if(dl!=null && dl.size()!=0){
			for(int j=0;j<dl.size();j++){
				Data d = (Data)dl.get(j);
				String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ d.getString("ATT_NAME")+"&attId="+d.getString("ID")+"&attTypeCode="+bigType+"&type="+d.getString("ATT_TYPE");
				String fileName = d.getString("ID");
				fileName = fileName.substring(0,6)+"."+d.getString("ATT_TYPE");	
				
				if("JPG".endsWith(d.getString("ATT_TYPE").toUpperCase()) || "JPEG".endsWith(d.getString("ATT_TYPE").toUpperCase()) || "GIF".endsWith(d.getString("ATT_TYPE").toUpperCase())) {
		%>
			<a href="<%=viewUrl%>" target="blank"><%=fileName%></a>&nbsp;
		<%}else{ %>
			<a href="<up:attDownload attTypeCode="<%=bigType%>" attId='<%=d.getString("ID")%>'/>"><%=fileName%>	</a>&nbsp;	
		<%
			}
		}
		}
		%>
		</td>
	<%
			if((t%2) ==1){
	%>
	</tr>
	<%
			}
	t++;
	}
	%>
	<%
		if((t%2) ==1){
	%>
		<td class="edit-data-title"></td>
		<td class="edit-data-value"></td>
		</tr>
	<%
	}
	%>
</table>
	</BZ:body>
</BZ:html>
                                
	

