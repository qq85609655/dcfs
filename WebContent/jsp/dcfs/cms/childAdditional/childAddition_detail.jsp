<%
/**   
 * @Title: childAddition_supply.jsp
 * @Description:  ��ͯ������Ϣ����ҳ��
 * @author furx   
 * @date 2014-9-9 ����14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ������Ϣ����鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script type="text/javascript">
  	
		function _close(){
			window.close();
		}
	
    </script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<!--<div class="bz-edit clearfix" style="">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ������Ϣ</div>
				</div>
				
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">���</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="CHILD_NO" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">ʡ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">����Ժ</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��ͯ����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE"  codeName="CHILD_TYPE" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>-->
		<div class="clearfix" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>֪ͨ��Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
					    <tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ��Դ</td>
							<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="SOURCE" onlyValue="true" defaultValue="" checkValue="2=ʡ��;3=����;"/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ��</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEND_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ����</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="NOTICE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">֪ͨ����</td>
							<td class="bz-edit-data-value" colspan="5" width="85%">
								<BZ:dataValue field="NOTICE_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title">
				    <div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">���䵥λ</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_ORGNAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">������</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="FEEDBACK_USERNAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEEDBACK_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">����״̬</td>
							<td class="bz-edit-data-value" width="35%">
				             <BZ:dataValue field="CA_STATUS" onlyValue="true" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">��������</td>
							<td class="bz-edit-data-value" colspan="3">
							    <BZ:dataValue field="ADD_CONTENT" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">���丽��</td>
							<td class="bz-edit-data-value" colspan="3" >
							<up:uploadList name="AFFIX" id="AFFIX" attTypeCode="CI" smallType="<%=AttConstants.CI_BCCL %>" 
							 packageId="<%=affix%>" secondColWidth="100%"/>
							</td>
						</tr>
						
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		</BZ:form>
		<div class="bz-action-frame" style="text-align:center">
		    <div class="bz-action-edit" desc="��ť��">		
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>
			 </div>
        </div>
<!-- ��ť����:end -->
	</BZ:body>
</BZ:html>