<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�ļ���ͣȷ��ҳ��</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	/*function startCheck(){
		alert("startcheck");
		stopInterv=setInterval(checkFunction, 1000); //ÿ1��ִ��һ��
	}*/
	//�ļ���ͣȷ���ύ
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("ȷ���ύ���ύ����ͣȷ����Ϣ�����޸ģ�")) {
				document.srcForm.action = path + "ffs/pause/pauseFileSave.action";
				document.srcForm.submit();
				window.opener.open_tijiao();
			    window.close();
			}
		}
	}
	
/*function checkFunction(){
     try{
    	 alert("1");
	     window.opener.open_tijiao();
	     window.close();	
	     alert("2");
        clearInterval(stopInterv);
      }catch(e){
    	  alert("3");
   }
}*/

	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;WJWZ;WJQJZT_ZX" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<!-- ������begin -->
	<div class="stepflex" style="margin-right: 30px;">
        <dl id="payStepFrist" class="first done">
            <dt class="s-num">1</dt>
            <dd class="s-text" style="margin-left: -8px;">��һ����ѡ���ļ���ͣ</dd>
        </dl>
        <dl id="payStepNormal" class="normal doing">
            <dt class="s-num">2</dt>
            <dd class="s-text" style="margin-left: -8px;">�ڶ�����¼����ͣԭ��<s></s>
                <b></b>
            </dd>
        </dl>
        <dl id="payStepLast" class="last">
            <dt class="s-num">3</dt>
            <dd class="s-text" style="margin-left: -8px;">���������ύ<s></s>
                <b></b>
            </dd>
        </dl>
	</div>
	<!-- ������end -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ�������Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���ı��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ļ�����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ�λ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ�״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_GLOBAL_STATE" codeName="WJQJZT_ZX" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ļ���ͣ��Ϣ
				</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��ͣ����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_UNITNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="PAUSE_UNITID" type="hidden" defaultValue=""/>
							<BZ:input prefix="R_" field="PAUSE_UNITNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͣ��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_USERNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="PAUSE_USERID" type="hidden" defaultValue=""/>
							<BZ:input prefix="R_" field="PAUSE_USERNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͣ����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="PAUSE_DATE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��ͣ����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:input field="END_DATE" id="R_END_DATE" prefix="R_" type="date"/>
						</td>
						<td class="bz-edit-data-title poptitle"><font color="red">*</font>��ͣԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="PAUSE_REASON" id="R_PAUSE_REASON" type="textarea" prefix="R_" formTitle="��ͣԭ��" defaultValue="" notnull="��������ͣԭ��" style="width:75%" maxlength="1000"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
