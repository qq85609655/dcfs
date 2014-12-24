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
<%@ page import="hx.database.databean.DataList"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
	<link href="<%=path%>/resource/style/base/list.css" rel="stylesheet" type="text/css" />
	 <BZ:webScript edit="true"/>
	</BZ:head>
	<script>
	$(document).ready( function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
	});
	</script>
	<BZ:body codeNames="BCZL;TXGXXM;">
		
			   <%
			        DataList updateList=(DataList)request.getAttribute("updateList");
			        if(updateList.size()==0){%>
			          <br/>
			          <center><font color="red" size="2px">没有更新记录！</font></center>
			       <% }else{%>
			          <br/>
			       <%}%>
			          
			       <% for(int i=0;i<updateList.size();i++ ){
			        	Data updateData=updateList.getData(i);
			        	String orgName=updateData.getString("ORG_NAME","");
			        	String personName=updateData.getString("UPDATE_USERNAME","");
			        	String updateDate=updateData.getString("UPDATE_DATE","");
			        	String tempDate=updateDate.substring(0,10);
			        	String details=updateData.getString("DETAILLIST","");
			        	DataList detailList=(DataList)request.getAttribute(details);
			        	String attDetails=updateData.getString("ATTDETAILLIST","");
			        	DataList attDetailList=(DataList)request.getAttribute(attDetails);
			        	%>
					   <table class="specialtable" align="center" style='width:100%;text-align:center'>
			        	 <tr>
					        <td class="edit-data-title" style="text-align: left;"><%= (i+1)%>、申请单位：<%= orgName%>&nbsp;&nbsp;申请人：<%= personName%>&nbsp;&nbsp;申请日期：<%= tempDate%></td>
				         </tr>
			           </table>
			            <%if(detailList.size()>0||attDetailList.size()>0){ %>
	                    <table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
							<thead>
								<tr>
									<th style="width: 20%;">
										<div class="sorting" id="UPDATE_FIELD">更新项目</div>
									</th>
									<th style="width: 35%;">
										<div class="sorting" id="ORIGINAL_DATA">原数据</div>
									</th>
									<th style="width: 35%;">
										<div class="sorting" id="UPDATE_DATA">更新数据</div>
									</th>
									<th style="width: 10%;">
										<div class="sorting" id="UPDATE_TYPE">更新类型</div>
									</th>
								</tr>
							</thead>
							<tbody>
							<BZ:for property="<%=details %>"  fordata="myData"> 
							  <%
									Data dat = (Data)pageContext.getAttribute("myData");
							        String updateField=dat.getString("UPDATE_FIELD");
							%>
							 <tr>
								<td><BZ:data field="UPDATE_FIELD" defaultValue="" onlyValue="true"  codeName="TXGXXM" /></td>
								<%if("SN_TYPE".equals(updateField)){ %>
								<td><BZ:data field="ORIGINAL_DATA"  codeName="BCZL"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="UPDATE_DATA"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
								<%}else if("IS_ANNOUNCEMENT".equals(updateField)||"IS_PLAN".equals(updateField)||"IS_HOPE".equals(updateField)){ %>
								<td><BZ:data field="ORIGINAL_DATA"  checkValue="0=否;1=是;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="UPDATE_DATA"  checkValue="0=否;1=是;" defaultValue="" onlyValue="true"/></td>
								<%}else{%>
								<td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="UPDATE_DATA"    defaultValue="" onlyValue="true"/></td>
								<%} %>
								<td><BZ:data field="UPDATE_TYPE"  checkValue="0=覆盖;1=追加;"   defaultValue="" onlyValue="true"/></td>
							</tr>
					    	</BZ:for>
							<%for(int j=0;j<attDetailList.size();j++){
								Data dat =attDetailList.getData(j);
								String updateField=dat.getString("UPDATE_FIELD");
								String oldData=dat.getString("ORIGINAL_DATA","");
								String newData=dat.getString("UPDATE_DATA","");
								String updateType=dat.getString("UPDATE_TYPE","");%>
								<tr>
									<td><%=updateField %></td>
									<td>
									<%if(!"".equals(oldData)){
										  String[] attOIds=oldData.split(",");
									      for(int k=0;k<attOIds.length;k++){ 
									        String attId=(attOIds[k].split("#"))[0];
									        String attName=(attOIds[k].split("#"))[1];%>
									        <a href="<up:attDownload attId='<%=attId%>' attTypeCode='CI'/> "><img src="<%=path%>/uploadComponent/view/images/att_sign.png"><%=attName%></a> <br/>
										<%}
								      }%>
								    </td>
									<td>
									<%if(!"".equals(newData)){
										  String[] attIds=newData.split(",");
									      for(int k=0;k<attIds.length;k++){ 
									        String attId=(attIds[k].split("#"))[0];
									        String attName=(attIds[k].split("#"))[1];%>
									        <a href="<up:attDownload attId='<%=attId%>' attTypeCode='CI'/> "><img src="<%=path%>/uploadComponent/view/images/att_sign.png"><%=attName%></a> <br/>
										<%}
								      }%>
								    </td>
									<td><%=updateType %></td>
								</tr>
							<% } %>
	                        </tbody>
					  </table>
					<%} %>
			   <%      	
			        }
			   %>
	</BZ:body>
</BZ:html>