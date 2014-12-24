<%
/**   
 * @Title: supply_translation_view.jsp
 * @Description:  Ԥ��������Ϣ�鿴
 * @author panfeng   
 * @date 2014-10-16 
 * @version V1.0   
 */
%>

<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data adData = (Data)request.getAttribute("data");
	
	String UPLOAD_IDS = adData.getString("UPLOAD_IDS","");
	String UPLOAD_IDS_CN = adData.getString("UPLOAD_IDS_CN","");
	String RA_ID = adData.getString("RA_ID","");
%>

<BZ:html>
<BZ:head>
    <title>Ԥ��������Ϣ�鿴</title>
    <BZ:webScript edit="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<up:uploadResource/>
</BZ:head>
<BZ:body property="data" codeNames="">
	<script type="text/javascript">
		var path = "<%=path%>";
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			$('#tab-container').easytabs();
		})
	
	</script>	
	<!--֪ͨ��Ϣ:start-->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����֪ͨ��Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">֪ͨ��</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">֪ͨ����</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="NOTICE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">����״̬</td>
						<td class="bz-edit-data-value" width="19%"> <BZ:dataValue field="TRANSLATION_STATE" defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" colspan="5" width="85%"><BZ:dataValue field="ADD_CONTENT_EN" defaultValue="" /></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">���丽��</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--֪ͨ��Ϣ:end-->

	<!--������Ϣ��start-->
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���䷭����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<BZ:dataValue field="ADD_CONTENT_CN" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���븽��</td>
						<td class="bz-edit-data-value" colspan="5" width="85%">
						<up:uploadList id="UPLOAD_IDS_CN" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS_CN%>'/>				
						</td>
					</tr>
					<tr>
						<td  class="bz-edit-data-title">����˵��</td>
						<td  class="bz-edit-data-value" colspan="5">
						<BZ:dataValue field="TRANSLATION_DESC" defaultValue="" />
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title" width="15%">���뵥λ</td>
						<td class="bz-edit-data-value" width="18%"><BZ:dataValue field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">������</td>
						<td class="bz-edit-data-value" width="18%"> <BZ:dataValue field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true" /></td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="19%"> <BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--������Ϣ��end-->
	<br>
	<!-- ��ť����:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- ��ť����:end -->
	</BZ:body>
</BZ:html>