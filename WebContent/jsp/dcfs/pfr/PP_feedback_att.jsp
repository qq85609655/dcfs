<%
/**   
 * @Title: PP_feedback_att.jsp
 * @Description: 安置后报告附件
 * @author xugy
 * @date 2014-10-17下午3:46:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
DataList dl = (DataList)request.getAttribute("dl");
Data photoData = (Data)request.getAttribute("photoData");
String isCN = (String)request.getAttribute("isCN");//是否中文
String isEdit = (String)request.getAttribute("isEdit");//是否编辑
String LANG = (String)request.getAttribute("LANG");//
%>
<BZ:html>
<BZ:head>
	<title>安置后报告附件</title>
	<BZ:webScript edit="true" isAjax="true"/>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['attFrame','mainFrame']);//公共功能，框架元素自适应
	//intoiframesize('attFrame');
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
	<%
	if("EN".equals(LANG)){
	%>
	<table class="specialtable" width="100%">
		<%
		if("1".equals(isCN)){
		%>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>
		<tr>
			<td class="edit-data-title"></td>
			<td class="edit-data-title">原文(EN)</td>
			<td class="edit-data-title">中文(CN)</td>
		</tr>
		<%
		}else{
		%>
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tr>
			<td class="edit-data-title"></td>
			<td class="edit-data-title">原文(EN)</td>
		</tr>
		<%
		}
		for(int i=0;i<dl.size();i++){
		    String CNAME = dl.getData(i).getString("CNAME");
		    String ENAME = dl.getData(i).getString("ENAME");
		    DataList ATTDL = (DataList)dl.getData(i).get("ATTDL");
		%>
		<tr>
			<td class="edit-data-title">
				<%=CNAME %><br/><%=ENAME %>
			</td>
			<td class="edit-data-value">
			<%
			if(ATTDL.size()>0){
			%>
				<table class="attlisttable">
			<%
			    for(int j=0;j<ATTDL.size();j++){
			        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
			        String ID = ATTDL.getData(j).getString("ID");
			        String ATT_TYPE = ATTDL.getData(j).getString("ATT_TYPE");
			        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
			%>
					<tr>
						<td width="5%"><%=j+1%>.</td>
						<td width="70%"><%=ATT_NAME%></td>
						<td width="25%">&nbsp;
							<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
							<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
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
			<%
			if("1".equals(isCN)){
			%>
			<td class="edit-data-value">
			<%
			    DataList ATTCNDL = (DataList)dl.getData(i).get("ATTCNDL");
			    if(ATTCNDL.size()>0){
			%>
				<table class="attlisttable">
			<%
				    for(int j=0;j<ATTCNDL.size();j++){
				        String ATT_NAME = ATTCNDL.getData(j).getString("ATT_NAME");
				        String ID = ATTCNDL.getData(j).getString("ID");
				        String ATT_TYPE = ATTCNDL.getData(j).getString("ATT_TYPE");
				        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
			%>
					<tr>
						<td width="5%"><%=j+1%>.</td>
						<td width="70%"><%=ATT_NAME%></td>
						<td width="25%">&nbsp;
							<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
							<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
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
			<%
			}
			%>
		</tr>
		<%
		}
		if(!photoData.isEmpty()){
		    String CNAME = photoData.getString("CNAME");
		    String ENAME = photoData.getString("ENAME");
		    DataList ATTDL = (DataList)photoData.get("ATTDL");
		%>
		<tr>
			<td class="edit-data-title">
				<%=CNAME %><br/><%=ENAME %>
			</td>
			<td class="edit-data-value" colspan="2">
			<%
			if(ATTDL.size()>0){
			    for(int j=0;j<ATTDL.size();j++){
			        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
			        String ID = ATTDL.getData(j).getString("ID");
			        String DES_EN = ATTDL.getData(j).getString("DES_EN","");
			        String DES_CN = ATTDL.getData(j).getString("DES_CN","");
			        
			%>
				<div style="width: 275px;float: left;margin: 5px;text-align: center;">
					<img alt="<%= ATT_NAME %>" style="cursor: pointer;text-align: center;" src="<%= path %>/feedback/showThumbnail.action?ATT_TABLE=ATT_AR&ID=<%= ID %>" onclick="_show('<%= path %>/feedback/showPicture.action?ATT_TABLE=ATT_AR&ID=<%= ID %>')">
					<table class="bz-edit-data-table" style="border-right: 1px #ddd solid;">
						<tr>
							<td class="bz-edit-data-title" width="35%">Description(EN)</td>
							<td class="bz-edit-data-value" width="65%">
								<%
								if("1".equals(isEdit)){
								%>
								<input type="text" name="DES_EN" value="<%= DES_EN %>" onblur="_saveDES('EN','<%= ID %>',this.value)" style="width:95%;"/>
								<%
								}else{
								%>
								<%= DES_EN %>
								<%} %>
							</td>
						</tr>
						<%
						if("1".equals(isCN)){
						%>
						<tr>
							<td class="bz-edit-data-title">Description(CN)</td>
							<td class="bz-edit-data-value">
								<%
								if("1".equals(isEdit)){
								%>
								<input type="text" name="DES_CN" value="<%= DES_CN %>" onblur="_saveDES('CN','<%= ID %>',this.value)" style="width:95%;"/>
								<%
								}else{
								%>
								<%= DES_CN %>
								<%} %>
							</td>
						</tr>
						<%
						}
						%>
					</table>
				</div>
			<%
				}
			}
			%>
			</td>
		</tr>
		<%} %>
	</table>
	<%
	}else{
	%>
	<table class="specialtable" width="100%">
		<%
		if("1".equals(isCN)){
		%>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>
		<tr>
			<td class="edit-data-title"></td>
			<td class="edit-data-title">原文</td>
			<td class="edit-data-title">中文</td>
		</tr>
		<%
		}else{
		%>
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tr>
			<td class="edit-data-title"></td>
			<td class="edit-data-title">原文</td>
		</tr>
		<%
		}
		for(int i=0;i<dl.size();i++){
		    String CNAME = dl.getData(i).getString("CNAME");
		    DataList ATTDL = (DataList)dl.getData(i).get("ATTDL");
		%>
		<tr>
			<td class="edit-data-title">
				<%=CNAME %>
			</td>
			<td class="edit-data-value">
			<%
			if(ATTDL.size()>0){
			%>
				<table class="attlisttable">
			<%
			    for(int j=0;j<ATTDL.size();j++){
			        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
			        String ID = ATTDL.getData(j).getString("ID");
			        String ATT_TYPE = ATTDL.getData(j).getString("ATT_TYPE");
			        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
			%>
					<tr>
						<td width="5%"><%=j+1%>.</td>
						<td width="70%"><%=ATT_NAME%></td>
						<td width="25%">&nbsp;
							<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
							<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
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
			<%
			if("1".equals(isCN)){
			%>
			<td class="edit-data-value">
			<%
			    DataList ATTCNDL = (DataList)dl.getData(i).get("ATTCNDL");
			    if(ATTCNDL.size()>0){
			%>
				<table class="attlisttable">
			<%
				    for(int j=0;j<ATTCNDL.size();j++){
				        String ATT_NAME = ATTCNDL.getData(j).getString("ATT_NAME");
				        String ID = ATTCNDL.getData(j).getString("ID");
				        String ATT_TYPE = ATTCNDL.getData(j).getString("ATT_TYPE");
				        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
			%>
					<tr>
						<td width="5%"><%=j+1%>.</td>
						<td width="70%"><%=ATT_NAME%></td>
						<td width="25%">&nbsp;
							<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
							<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
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
			<%
			}
			%>
		</tr>
		<%
		}
		if(!photoData.isEmpty()){
		    String CNAME = photoData.getString("CNAME");
		    DataList ATTDL = (DataList)photoData.get("ATTDL");
		%>
		<tr>
			<td class="edit-data-title">
				<%=CNAME %>
			</td>
			<td class="edit-data-value" colspan="2">
			<%
			if(ATTDL.size()>0){
			    for(int j=0;j<ATTDL.size();j++){
			        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
			        String ID = ATTDL.getData(j).getString("ID");
			        String DES_EN = ATTDL.getData(j).getString("DES_EN","");
			        String DES_CN = ATTDL.getData(j).getString("DES_CN","");
			        
			%>
				<div style="width: 275px;float: left;margin: 5px;text-align: center;">
					<img alt="<%= ATT_NAME %>" style="cursor: pointer;text-align: center;" src="<%= path %>/feedback/showThumbnail.action?ATT_TABLE=ATT_AR&ID=<%= ID %>" onclick="_show('<%= path %>/feedback/showPicture.action?ATT_TABLE=ATT_AR&ID=<%= ID %>')">
					<table class="bz-edit-data-table" style="border-right: 1px #ddd solid;">
						<tr>
							<td class="bz-edit-data-title" width="35%">照片描述</td>
							<td class="bz-edit-data-value" width="65%">
								<%
								if("1".equals(isEdit)){
								%>
								<input type="text" name="DES_EN" value="<%= DES_EN %>" onblur="_saveDES('EN','<%= ID %>',this.value)" style="width:95%;"/>
								<%
								}else{
								%>
								<%= DES_EN %>
								<%} %>
							</td>
						</tr>
						<%
						if("1".equals(isCN)){
						%>
						<tr>
							<td class="bz-edit-data-title">描述翻译</td>
							<td class="bz-edit-data-value">
								<%
								if("1".equals(isEdit)){
								%>
								<input type="text" name="DES_CN" value="<%= DES_CN %>" onblur="_saveDES('CN','<%= ID %>',this.value)" style="width:95%;"/>
								<%
								}else{
								%>
								<%= DES_CN %>
								<%} %>
							</td>
						</tr>
						<%
						}
						%>
					</table>
				</div>
			<%
				}
			}
			%>
			</td>
		</tr>
		<%} %>
	</table>
	<%} %>
</BZ:body>
</BZ:html>
