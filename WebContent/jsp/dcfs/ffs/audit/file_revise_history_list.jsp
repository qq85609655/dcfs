<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: 文件修改记录列表
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
	
	String af_id = (String)request.getAttribute("AF_ID");
	
%>
<BZ:html>
	<BZ:head>
		<title>文件修改记录列表</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script type="text/javascript">	
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
		var af_id = $("#AF_ID").val();
		var obj = document.forms["srcForm"];
		obj.action=path+"ffs/jbraudit/findReviseList.action?AF_ID="+af_id;
	});
	</script>
	
	<BZ:body >
		<BZ:form name="srcForm" method="post" action="" >
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<input type="hidden" name="AF_ID" id="AF_ID" value="<%=af_id%>"/>
		
		<div class="page-content">
			<div class="wrapper">
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr >
								<th style="width: 5%;">
									<div>
										序号
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_FIELD">
										修改项目
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ORIGINAL_DATA">
										修改前
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_DATA">
										修改后
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVISE_USERNAME">
										修改人
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_DATE">
										修改日期
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="UPDATE_FIELD" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="ORIGINAL_DATA" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="UPDATE_DATA" defaultValue="" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="REVISE_USERNAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="UPDATE_DATE" defaultValue="" onlyValue="true" />
								</td>
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