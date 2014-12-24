<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title:fbgl_fb_unlock_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
    //������¼����ID
	String pubid= (String)request.getAttribute("pubid");//������¼����ID
	String riid= (String)request.getAttribute("riid");//Ԥ����¼����ID
	String ciid= (String)request.getAttribute("ciid");//��ͯ��������ID
	Data rtfbData= (Data)request.getAttribute("rtfbData");
	String IS_TWINS = rtfbData.getString("IS_TWINS");
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	
%>
<BZ:html>

<BZ:head>
	<title>��ͯ�����������ҳ��</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	
	
	
	//���������ύ
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
			$("#P_UNLOCKER_DATE").attr("disabled",false);
			$("#P_UNLOCKER_ID").attr("disabled",false);
			$("#P_UNLOCKER_NAME").attr("disabled",false);
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'sce/publishManager/saveUnlockFbInfo.action';
			obj.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.history.back();
	}
	
</script>

<BZ:body codeNames="GJSY;SYZZ;PROVINCE;BCZL;DFLX;SYS_ADOPT_ORG" property="rtfbData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="H_" field="PUB_ID" defaultValue="<%=pubid %>"/>
		<BZ:input type="hidden" prefix="H_" field="RI_ID" defaultValue="<%=riid %>"/>
		<BZ:input type="hidden" prefix="H_" field="CI_ID" defaultValue="<%=ciid %>"/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">ʡ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE"  defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">����Ժ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">����</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" checkValue="1=��;2=Ů;3=����"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date" />
							</td>
							
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true" />
							</td>
						</tr>
						<tr>
							
							<td class="bz-edit-data-title" width="10%">�ر��ע</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_TYPE" defaultValue="" onlyValue="true" checkValue="1=�㷢;2=Ⱥ��"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" defaultValue="" onlyValue="true" type="Date" />
							</td>
							<td class="bz-edit-data-title"  width="10%">������֯</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"  width="10%">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="LOCK_DATE" defaultValue="" onlyValue="true" type="Date"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">Ԥ�����</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="REQ_NO" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title" width="10%">�Ƿ���̥</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
							</td>
							<td class="bz-edit-data-title" width="10%"><%if("1".equals(IS_TWINS)||"1"==IS_TWINS){ %>ͬ������<%} %></td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="TB_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		<br/>
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>���������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>�������ԭ��</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="UNLOCKER_REASON" id="P_UNLOCKER_REASON" type="textarea" prefix="P_" formTitle="�������ԭ��" defaultValue="" style="width:80%"  maxlength="900" notnull="�����볷��ԭ��"/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">�����</td>
							<td class="bz-edit-data-value">
								<BZ:input  prefix="P_" field="UNLOCKER_NAME" id="P_REVOKE_USERNAME" defaultValue="" formTitle="�����"  readonly="true"/>
								<BZ:input type="hidden" field="UNLOCKER_ID"  prefix="P_" id="P_UNLOCKER_ID"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�������</td>
							<td class="bz-edit-data-value"  >
								<BZ:input type="Date" field="UNLOCKER_DATE" prefix="P_" readonly="true" formTitle="�������"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		<br/>
		
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
