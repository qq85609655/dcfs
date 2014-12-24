<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>到账确认查看页面</title>
		<BZ:webScript edit="true" list="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/receiveconfirm/ReceiveConfirmList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="JFFS;FYLB;WJLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 编辑区域begin -->
		<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
			<div class="wrapper">
				<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>票据信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="15%">缴费编号</td>
									<td class="bz-edit-data-value" width="18%">
										<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="15%">缴费方式</td>
									<td class="bz-edit-data-value" width="18%"> 
										<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="15%">费用类型</td>
									<td class="bz-edit-data-value" width="19%">
										<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">应缴金额</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">票面金额</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">到账金额</td>
									<td class="bz-edit-data-value"> 
										<BZ:dataValue field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">到账日期</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">使用余额账户金额</td>
									<td class="bz-edit-data-value"> 
										<BZ:dataValue field="ARRIVE_ACCOUNT_VALUE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">&nbsp;</td>
									<td class="bz-edit-data-value">&nbsp;</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">收款摘要</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="ARRIVE_REMARKS" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!--列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">收文编号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">文件类型</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">男收养人</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">女收养人</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">儿童姓名</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--列表区End -->
			</div>
		</div>
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="返 回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>