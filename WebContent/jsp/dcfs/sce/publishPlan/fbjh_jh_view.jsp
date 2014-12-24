<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data hxData = (Data)request.getAttribute("data");
	String plan_id =hxData.getString("PLAN_ID");

 %>
<BZ:html>
	<BZ:head>
		<title>查看发布计划详细页面</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<BZ:input type="hidden" prefix="H_" field="PLAN_ID" id="H_PLAN_ID" defaultValue="<%=plan_id %>"/>
		<BZ:input type="hidden" field="PUB_NUM" prefix="H_"/>
		<BZ:input type="hidden" field="REMOVE_CIIDS" prefix="H_" id="H_REMOVE_CIIDS"/>
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!-- 编辑区域begin -->
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>发布计划基本信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%">预告日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="NOTE_DATE"  type="date" />
									</td>
									<td class="bz-edit-data-title" width="10%">发布日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PUB_DATE"  type="date" />
									</td>
									<td class="bz-edit-data-title" width="10%">制定人</td>
									<td class="bz-edit-data-value"   width="12%">
										<BZ:dataValue field="PLAN_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">制定日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PLAN_DATE" defaultValue="" onlyValue="true" type="Date"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">儿童总数</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">特别关注人数</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM_TB" defaultValue=""  onlyValue="true" />
									</td>
									<td class="bz-edit-data-title" width="10%">非特别关注人数</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PUB_NUM_FTB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- 编辑区域end -->
				<br/>
				
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>已选择儿童列表</div>
						</div>
						<!-- 标题区域 end -->
						<!--查询结果列表区Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th style="width: 3%;">
											<div class="sorting_disabled">序号</div>
										</th>
										<th style="width:5%;">
											<div class="sorting_disabled" id="PROVINCE_ID">省份</div>
										</th>
										<th style="width: 9%;">
											<div class="sorting_disabled" id="WELFARE_NAME_CN">福利院</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="NAME">姓名</div>
										</th>
										<th style="width: 3%;">
											<div class="sorting_disabled" id="SEX">性别</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="BIRTHDAY">出生日期</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="SN_TYPE">病残种类</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="SPECIAL_FOCUS">特别关注</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="PUB_TYPE">发布类型</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="PUB_ORGID">发布组织</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="PUB_MODE">点发类型</div>
										</th>
										<th style="width: 10%;">
											<div class="sorting_disabled" id="PUB_REMARKS">点发备注</div>
										</th>
										
									</tr>
								</thead>
								<tbody>
									<BZ:for property="List">
										<tr class="emptyData">
											<td class="center">
												<BZ:i/>
											</td>
											<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""   onlyValue="true"/></td>
											<td><BZ:data field="NAME" defaultValue=""  codeName="DFLX" onlyValue="true"/></td>
											<td><BZ:data field="SEX" defaultValue="" checkValue="1=男;2=女;3=两性" length="20"/></td>
											<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
											<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
											<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_TYPE" defaultValue="" checkValue="1=点发;2=群发" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_ORGID" defaultValue="" codeName="SYS_ADOPT_ORG" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_MODE" defaultValue="" codeName="DFLX" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_REMARKS" defaultValue=""  onlyValue="true"/></td>
										</tr>
									</BZ:for>
								</tbody>
							</table>
						</div>
						<!--查询结果列表区End -->
					</div>
				</div>
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>