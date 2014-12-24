<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Description: 文件补充记录列表
 * @author mayun   
 * @date 2014-8-14
 * @version V1.0   
 */
	String compositor = (String) request.getAttribute("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
%>
<BZ:html>
	<BZ:head>
		<title>文件补充记录列表</title>
		<up:uploadResource/>
		<BZ:webScript list="true" edit="true"/>
	</BZ:head>
	<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
	});
	</script>
	<BZ:body  codeNames="SYWJBC">
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findBcRecordList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
	
		<div class="page-content">
			<div class="wrapper">
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<tbody>
						<div class="ui-state-default bz-edit-title" desc="标题">
								<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
								<div>补充记录</div>
							</div>
						<BZ:for property="bcFileList" fordata="resultData">
						<%
							Data data = (Data)pageContext.getAttribute("resultData");
							String aaId = data.getString("AA_ID");
						 %>
							
							<table class="bz-edit-data-table" border="0" >
								<colgroup>
									<col width="10%" />
									<col width="15%" />
									<col width="10%" />
									<col width="15%" />
									<col width="10%" />
									<col width="15%" />
								</colgroup>
								<tr class="emptyData">
									<td class="bz-edit-data-title">通知人</td>
									<td class="bz-edit-data-value">
										<BZ:data field="SEND_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">通知日期</td>
									<td class="bz-edit-data-value">
										<BZ:data field="NOTICE_DATE" defaultValue="" type="date" dateFormat="yyyy-MM-dd" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">是否允许修改基本信息</td>
									<td class="bz-edit-data-value" >
										<BZ:data field="IS_MODIFY" defaultValue="" checkValue="0=否;1=是"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">是否允许补充附件</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:data field="IS_ADDATTACH" defaultValue="" checkValue="0=否;1=是"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">通知内容</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:data field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">回复人</td>
									<td class="bz-edit-data-value">
										<BZ:data field="FEEDBACK_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">回复日期</td>
									<td class="bz-edit-data-value">
										<BZ:data field="FEEDBACK_DATE" defaultValue="" type="date"  dateFormat="yyyy-MM-dd" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">补充状态</td>
									<td class="bz-edit-data-value" >
										<BZ:data field="AA_STATUS" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">回复内容</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:data field="ADD_CONTENT_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								
								<tr>
									<td class="bz-edit-data-title">回复附件</td>
									<td class="bz-edit-data-value" colspan="5">
										<up:uploadList id="UPLOAD_IDS" attTypeCode="AF" packageId="<%=aaId %>" smallType="<%=AttConstants.AF_WJBC %>"/>
									</td>
								</tr>
								
							</table>
							<br/>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				
				<!--分页功能区Start -->
				<div class="footer-frame" >
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="bcFileList"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>