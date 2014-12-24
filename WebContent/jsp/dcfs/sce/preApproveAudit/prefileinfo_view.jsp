<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String file_no = (String)request.getAttribute("FILE_NO");
%>
<BZ:html>
	<BZ:head>
		<title>预批申请修改页面</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
			//Tab页js
			function change(flag){
				if(flag==1){
					document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreFileShow.action?FILE_NO=<%=file_no %>&Flag=infoCN";
					document.getElementById("act1").className="active";
					document.getElementById("act2").className="";
				}	
				if(flag==2){
					document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreFileShow.action?FILE_NO=<%=file_no %>&Flag=infoEN";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="active";
				}
			}
		
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="WJLX;SYLX;">
		<div class="page-content">
			<div class="wrapper clearfix">
				<!-- Tab标签页begin -->
				<div class="widget-header">
					<div class="widget-toolbar">
						<ul class="nav nav-tabs" id="recent-tab">
							<li id="act1" class="active"> 
								<a href="javascript:change(1);">基本信息(中)</a>
							</li>
							<li id="act2" class="">
								<a href="javascript:change(2);">基本信息(外)</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- Tab标签页end -->
				<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title">收养组织(CN)</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">收养组织(EN)</td>
									<td class="bz-edit-data-value" colspan="3"> 
										<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="20%">文件类型<br>File type</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="20%">收养类型<br>Family type</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!-- iframe显示区域begin -->
				<div class="widget-box no-margin" style=" width:100%; margin: 0 auto" id="iframepage">
					<iframe id="iframe" scrolling="no" src="<%=path %>/sce/preapproveaudit/PreFileShow.action?FILE_NO=<%=file_no %>&Flag=infoCN" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
				</div>
				<!-- iframe显示区域end -->
			</div>
		</div>
	</BZ:body>
</BZ:html>