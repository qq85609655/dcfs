<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head>
		<title>��˼�¼</title>
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
								<div class="sorting_disabled">���</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">�����</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">�������</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">��˽��</div>
							</th>
							<th style="width: 40%;">
								<div class="sorting_disabled">������</div>
							</th>
							<th style="width: 20%;">
								<div class="sorting_disabled">��ע</div>
							</th>
							<th style="width: 8%;">
								<div class="sorting_disabled">��������</div>
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