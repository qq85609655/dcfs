<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapproveauditrecords_list.jsp
 * @Description: 预批申请审核记录列表 
 * @author yangrt
 * @date 2014-10-13
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>预批申请审核记录列表</title>
		<BZ:webScript list="true"/>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
			});
		</script>
	</BZ:head>
	<BZ:body>
		<div class="page-content">
			<div class="wrapper">
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="AUDIT_TYPE">审核类型</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="AUDIT_LEVEL">审核级别</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AUDIT_USERNAME">审核人</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AUDIT_DATE">审核日期</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AUDIT_OPTION">审核结果</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled" id="AUDIT_CONTENT_CN">审核意见</div>
								</th>
								<th style="width: 30%;">
									<div class="sorting_disabled" id="AUDIT_REMARKS">备注</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="AUDIT_TYPE" checkValue="1=审核部;2=安置部;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_LEVEL" checkValue="0=经办人审核;1=部门主任审核;2=分管主任审批;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<%
								String type = ((Data)pageContext.getAttribute("myData")).getString("AUDIT_TYPE","");
								if("1".equals(type)){
							%>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="1=上报;2=通过;3=不通过;4=补充信息;7=退回重审;8=退回经办人;"/></td>
							<%	}else{ %>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="2=审核通过;3=审核不通过;4=补充信息;"/></td>
							<%	} %>
								
								<td><BZ:data field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_REMARKS" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</BZ:body>
</BZ:html>