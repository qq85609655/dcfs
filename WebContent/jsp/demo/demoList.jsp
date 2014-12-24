<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head>
		<title>记者档案库列表</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
	</script>
	<BZ:body>
		<div class="page-content">
			<div class="wrapper">
				<div class="table-header">
					<h4 class="lighter">记者档案库列表</h4>
					<div class="widget-toolbar">
						<div class="icon-chevron-up"></div>
					</div>
				</div>
				<div class="table-row">
					<table cellspacing="0" cellpadding="0">
						<tr>
							<td style="width: 80%;">
								<table>
									<tr>
										<td style="width: 5%;"></td>
										<td class="bz-search-title"><span title="姓名">姓名:</span></td>
										<td><input type="text" class="rs-search-txt" /></td>
										<td class="bz-search-title">性别:</td>
										<td>
											<select class="rs-edit-select" style="width: 160px;" >
												<option value="">--请选择--</option>
												<option value="1">男</option>
												<option value="2">女</option>
											</select>
										</td>
										<td class="bz-search-title">所属部门:</td>
										<td>
											<input type="text" class="rs-search-txt" />
										</td>
									</tr>
									<tr>
										<td style="width: 5%;"></td>
										<td class="bz-search-title">研究领域:</td>
										<td><input type="text" class="rs-search-txt" /></td>
										<td class="bz-search-title">主要作品:</td>
										<td><input type="text" class="rs-search-txt" /></td>
										<td></td>
										<td></td>
									</tr>
								</table>
							</td>
							<td style="width: 20%;">
								<div class="bz-search-button">
									<input type="button" value="搜索" onclick="page.showPage('fdsfs');" class="btn btn-sm btn-primary">
									<input type="button" value="重置" class="btn btn-sm btn-primary">
								</div>
							</td>
							<td class="bz-search-right"></td>
						</tr>
					</table>
				</div>
				<div class="blue-hr"></div>
				<div class="table-row table-btns">
					<a href="reporter_files_add.html">
						<input type="button" value="新增" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_add.html'"/>
					</a>
					<input type="button" value="删除" class="btn btn-sm btn-primary" />
				</div>
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 5%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting">
										姓名
									</div>
								</th>
								<th style="width: 25%;">
								<div class="sorting">
									性别
								</div></th>
								<th style="width: 20%;">
								<div class="sorting">
									所属部门
								</div></th>
								<th style="width: 20%;">
								<div class="sorting">
									主要作品
								</div></th>
								<th style="width: 15%;">
								<div class="sorting_disabled">
									操作
								</div></th>
							</tr>
						</thead>
						<tbody>
							<tr class="odd">
								<td class="center">
								<input type="checkbox" class="ace">
								</td>
								<td class="poptitle">张三</td>
								<td>男</td>
								<td>XX机构</td>
								<td>XX作品</td>
								<td>
								<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
									<a href="reporter_files_detail.html" class="blue"> <i class="icon-zoom-in bigger-130"></i></a>
									<a href="reporter_files_modify.html" class="green"> <i class="icon-pencil bigger-130"></i></a>
									<a href="#" class="red"> <i class="icon-trash bigger-130"></i></a>
								</div></td>
							</tr>
							<tr class="even">
								<td class="center">
								<input type="checkbox" class="ace">
								</td>
								<td>李四</td>
								<td>男</td>
								<td>XX机构</td>
								<td>XX作品</td>
								<td>
								<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
									<a href="#" class="blue"> <i class="icon-zoom-in bigger-130"></i></a>
									<a href="#" class="green"> <i class="icon-pencil bigger-130"></i></a>
									<a href="#" class="red"> <i class="icon-trash bigger-130"></i></a>
								</div></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="footer-frame">
					<div class="table-row tablepager">
						<div class="table-pagina clearfix">
							<div class="col-sm-4">
								<div class="dataTables_info" id="sample-table-2_info">
									显示 第1条 到 第10条 记录，共2条记录
								</div>
							</div>
							<div class="col-sm-6">
								<div class="dataTables_paginate paging_bootstrap">
									<ul class="pagination">
										<li class="prev disabled">
											<a href="#">&laquo; 上一页</a>
										</li>
										<li class="active">
											<a href="#">1</a>
										</li>
										<li>
											<a href="#">2</a>
										</li>
										<li>
											<a href="#">3</a>
										</li>
										<li>
											<a href="#">...</a>
										</li>
										<li>
											<a href="#">10</a>
										</li>
										<li class="next">
											<a href="#">下一页 &raquo;</a>
										</li>
										<li>
											<span class="paggo">
												<span class="pull-left">到&nbsp;<input type="text" style="width: 20px;" />&nbsp;页&nbsp; </span>
												<input type="button" value="确定" class="btn btn-sm btn-primary pull-left">
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</BZ:body>
</BZ:html>
