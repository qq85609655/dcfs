<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: 文件审核记录列表
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
		<title>文件审核记录列表</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
	});
	</script>
	
	<BZ:body codeNames="WJSHYJ;WJSHCZZT">
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findAuditList.action">
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
						<thead>
							<tr>
								<th style="width: 2%;">
									<div class="sorting_disabled">
										序号
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_USERNAME">
										审核级别
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_USERNAME">
										审核人
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_DATE">
										审核日期
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_OPTION">
										审核结果
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="AUDIT_CONTENT_CN">
										审核意见
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="AUDIT_REMARKS">
										备注
									</div>
								</th>
								<!-- 
								<th style="width: 5%;">
									<div class="sorting" id="OPERATION_STATE">
										操作处理
									</div>
								</th>
								 -->
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="AUDIT_LEVEL" defaultValue="" checkValue="0=初审;1=复审;2=审批"/>
								</td>
								<td>
									<BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="AUDIT_DATE" type="datetime"  defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" codeName="WJSHYJ"  />
								</td>
								<td>
									<BZ:data field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="AUDIT_REMARKS" defaultValue="" onlyValue="true" />
								</td>
								<!-- 
								<td>
									<BZ:data field="OPERATION_STATE" defaultValue="" onlyValue="true" codeName="WJSHCZZT"/>
								</td>
								 -->
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List"/></td>
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