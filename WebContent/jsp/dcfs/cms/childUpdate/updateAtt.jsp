<%
/**   
 * @Title: childUpdate_detail.jsp
 * @Description:  儿童材料更新信息查看页面
 * @author furx   
 * @date 2014-9-16 下午14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String uploadId=(String)request.getAttribute("uploadId"); 
	String packageId=(String)request.getAttribute("packageId"); 
	String smallType=(String)request.getAttribute("smallType"); 
	String org_af_id=(String)request.getAttribute("org_af_id"); 
%>
<BZ:html>
	<BZ:head>
		<title>更新附件上传页面</title>
		<up:uploadResource/>
	 </BZ:head>
	<BZ:body >
      <up:uploadBody attTypeCode="CI" name="R_UPLOAD_IDS" id="<%=uploadId%>" packageId="<%=packageId%>" queueStyle="border: solid 1px #7F9DB9;;" autoUpload="true"
	 	selectAreaStyle="border: solid 1px #7F9DB9;;border-bottom:none;" smallType="<%=smallType %>"  bigType="CI"  diskStoreRuleParamValues="<%=org_af_id %>"></up:uploadBody>
	</BZ:body>
</BZ:html>