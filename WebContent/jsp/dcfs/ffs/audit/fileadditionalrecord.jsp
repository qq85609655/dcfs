<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head>
		<title>补充记录</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
	</script>
	<BZ:body property="data">
		<div class="page-content">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
					<thead>
						<tr>
							<th class="center" style="width: 3%;">
								<div class="sorting_disabled">序号</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">通知人</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">通知日期</div>
							</th>
							<th style="width: 40%;">
								<div class="sorting_disabled">通知内容</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">补充人</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">反馈日期</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">补充状态</div>
							</th>
						</tr>
					</thead>
					<tbody>
					<BZ:for property="List">
						<tr class="odd">
							<td class="center"><BZ:i/></td>
							<td><BZ:data field="" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="" defaultValue="" onlyValue="true"/></td>
						</tr>
					</BZ:for>
					</tbody>
				</table>
			</div>
		</div>
	</BZ:body>
</BZ:html>