<%
/**   
 * @Title: additional_view.jsp
 * @Description:  Ԥ�������ѯ�鿴ҳ��
 * @author panfeng   
 * @date 2014-9-12 ����10:11:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String ri_id = (String)request.getAttribute("RI_ID");
	String ra_id = (String)request.getAttribute("RA_ID");
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������ѯ�鿴ҳ��</title>
		<BZ:webScript edit="true" list="true"/>
		<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//dyniframesize(['mainFrame']);
			$('#tab-container').easytabs();
		});
		
		//����Ԥ�������ѯ�б�
		function _goback(){
			//window.location.href=path+'sce/additional/findAddList.action';
			document.srcForm.action = path+"sce/additional/findAddList.action";
			document.srcForm.submit();
		}
		
	</script>
	<BZ:body property="infodata" codeNames="WJLX;SYLX;">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#tab-container').easytabs();
			});
		</script>
		<div class="bz-edit clearfix" desc="�༭����" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>
						Ԥ�������Ҫ��Ϣ(PRE-APPROVED SUPPLEMENTAL SUMMARY INFORMATION)
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="������" id="ggarea">
					<!-- �༭���� ��ʼ -->
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">������֯(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">������֯(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">�ļ�����<br>File type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">��������<br>Adoption type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
							</td>
						</tr>
					</table>
					<!-- �༭���� ���� -->
				</div>
			</div>
		</div>
		<div id="tab-container" class='tab-container'>
			<ul class='etabs'>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowInfoDetail.action?type=CN&RI_ID=<%=ri_id %>" data-target="#tab1">�����˻�����Ϣ(����)</a></li>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowInfoDetail.action?type=EN&RI_ID=<%=ri_id %>" data-target="#tab2">�����˻�����Ϣ(Ӣ��)</a></li>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowNoticeDetail.action?type=CN&RA_ID=<%=ra_id %>" data-target="#tab3">����֪ͨ��Ϣ(����)</a></li>
				<li class='tab'><a href="<%=path %>/sce/additional/ShowNoticeDetail.action?type=EN&RA_ID=<%=ra_id %>" data-target="#tab3">����֪ͨ��Ϣ(Ӣ��)</a></li>
			</ul>
			<div class='panel-container'>
				<div id="tab1">
				</div>	
				<div id="tab2">
				</div>
				<div id="tab3">
				</div>
				<div id="tab4">
				</div>
			</div>
		</div>
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>