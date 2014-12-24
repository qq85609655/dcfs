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
    String path = request.getContextPath();
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	Data data = (Data)request.getAttribute("data"); 
	String specil="";
	String ishope=data.getString("IS_HOPE",null);
	String isplan=data.getString("IS_PLAN",null);
	if("1".equals(ishope)){
		specil+=" 希望之旅";
	}
	if("1".equals(isplan)){
		specil+=" 明天计划";
	}
	
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料信息更新查看页面</title>
		<BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script type="text/javascript">
  	
		function _close(){
			window.close();
		}
	
    </script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;BCZL;ETSFLX;TXGXXM;CHILD_TYPE;UPDATE_STATE;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<div class="clearfix" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童信息更新查看</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">儿童编号</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="CHILD_NO" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">省份</td>
							<td class="bz-edit-data-value" width="16%">
							    <BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">福利院</td>
							<td class="bz-edit-data-value" width="20%">
							    <BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">姓名</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">性别</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">出生日期</td>
							<td class="bz-edit-data-value">
							    <BZ:dataValue field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">儿童身份</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_IDENTITY" codeName="ETSFLX" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">儿童类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">特殊活动</td>
							<td class="bz-edit-data-value">
							<%=specil%>
							</td>
						</tr>
						 <tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">病残种类</td>
							<td class="bz-edit-data-value">
							    <BZ:dataValue field="SN_TYPE" codeName="BCZL" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">病残诊断</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="DISEASE_CN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" >
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div align="left">&nbsp;&nbsp;申请单位：<BZ:dataValue field="ORG_NAME" onlyValue="true" defaultValue=""/>&nbsp;&nbsp;申请人：<BZ:dataValue field="UPDATE_USERNAME" onlyValue="true" defaultValue=""/>&nbsp;&nbsp;申请日期：<BZ:dataValue field="UPDATE_DATE" type="Date" onlyValue="true" defaultValue=""/> &nbsp;&nbsp;更新状态：<BZ:dataValue field="UPDATE_STATE" codeName="UPDATE_STATE"  onlyValue="true" defaultValue=""/></div>
				</div>
		   </div>
		</div>
	    <div class="page-content">
		   <div class="wrapper">
				<div class="table-responsive">
				   <%if(((DataList)request.getAttribute("updateList")).size()>0||((DataList)request.getAttribute("attUpdateDetail")).size()>0){ %>
	                   <table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 20%;">
									<div class="sorting" id="UPDATE_FIELD" align="left">更新项目</div>
								</th>
								<th style="width: 35%;">
									<div class="sorting" id="ORIGINAL_DATA" align="left">原数据</div>
								</th>
								<th style="width: 35%;">
									<div class="sorting" id="UPDATE_DATA" align="left">更新数据</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_TYPE" align="left">更新类型</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="updateList" fordata="myData">
				        <%
								Data dat = (Data) pageContext.getAttribute("myData");
								String updateField=dat.getString("UPDATE_FIELD");
							%>
							<tr >
								<td align="left"><BZ:data field="UPDATE_FIELD" codeName="TXGXXM" defaultValue=""  onlyValue="true"/></td>
								<%if("SN_TYPE".equals(updateField)){ %>
								<td><BZ:data field="ORIGINAL_DATA"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
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
						<BZ:for property="attUpdateDetail" fordata="attData">
						<%
							Data dat = (Data) pageContext.getAttribute("attData");
							String updateField=dat.getString("UPDATE_FIELD");
							String oldData=dat.getString("ORIGINAL_DATA","");
							String newData=dat.getString("UPDATE_DATA","");
							String updateType=dat.getString("UPDATE_TYPE","");%>
							<tr>
								<td><%=updateField %></td>
								<td>
								<%
								  if(!"".equals(oldData)){
									  String[] attOIds=oldData.split(",");
								      for(int k=0;k<attOIds.length;k++){ 
								        String attId=(attOIds[k].split("#"))[0];
								        String attName=(attOIds[k].split("#"))[1];%>
								        <a href="<up:attDownload attId='<%=attId%>' attTypeCode='CI'/> "><img src="<%=path%>/uploadComponent/view/images/att_sign.png"><%=attName%></a> <br/>
									<%}
								} %>
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
								<td><BZ:data field="UPDATE_TYPE"  checkValue="0=覆盖;1=追加;"   defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
					</tbody>
				</table>
				<%} %>
		      </div>
		   </div>
		 </div>
				
		<br/>
		</BZ:form>
		<div class="bz-action-frame" style="text-align:center">
		    <div class="bz-action-edit" desc="按钮区">		
				<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
			 </div>
        </div>
	</BZ:body>
</BZ:html>