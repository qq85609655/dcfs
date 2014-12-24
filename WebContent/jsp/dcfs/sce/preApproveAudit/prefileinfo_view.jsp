<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String file_no = (String)request.getAttribute("FILE_NO");
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������޸�ҳ��</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
			//Tabҳjs
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
				<!-- Tab��ǩҳbegin -->
				<div class="widget-header">
					<div class="widget-toolbar">
						<ul class="nav nav-tabs" id="recent-tab">
							<li id="act1" class="active"> 
								<a href="javascript:change(1);">������Ϣ(��)</a>
							</li>
							<li id="act2" class="">
								<a href="javascript:change(2);">������Ϣ(��)</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- Tab��ǩҳend -->
				<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title">������֯(CN)</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">������֯(EN)</td>
									<td class="bz-edit-data-value" colspan="3"> 
										<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="20%">�ļ�����<br>File type</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="20%">��������<br>Family type</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!-- iframe��ʾ����begin -->
				<div class="widget-box no-margin" style=" width:100%; margin: 0 auto" id="iframepage">
					<iframe id="iframe" scrolling="no" src="<%=path %>/sce/preapproveaudit/PreFileShow.action?FILE_NO=<%=file_no %>&Flag=infoCN" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
				</div>
				<!-- iframe��ʾ����end -->
			</div>
		</div>
	</BZ:body>
</BZ:html>