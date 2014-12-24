<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: wjdl_add_choise.jsp
	 * @Description:  �ļ���¼ѡ���ļ����ͼ���������
	 * @author mayun   
	 * @date 2014��11��24��
	 * @version V1.0   
	 */
	 
	 //��ȡ������ϢID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
	
%>
<BZ:html>
	<BZ:head>
		<title>�ļ���¼ѡ���ļ����ͼ���������ҳ��</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		//��һ��
		function _next(){
		
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			var FAMILY_TYPE_VIEW = $("#P_FAMILY_TYPE").find("option:selected").text();
			var ADOPTER_SEX_VIEW = $("#P_ADOPTER_SEX").find("option:selected").text();
			$("#P_FAMILY_TYPE_VIEW").val(FAMILY_TYPE_VIEW);
			$("#P_ADOPTER_SEX_VIEW").val(ADOPTER_SEX_VIEW);
			
			var obj = document.forms["srcForm"];
			obj.action=path+"/ffs/registration/toAddFlieRecord.action";
			obj.submit();
		}
		
		//�����������Ͷ�̬���������Ա�ֵ
		function _dySetSyrxb(){
			var sylx = $("#P_FAMILY_TYPE").find("option:selected").text();
			if(sylx=="����������Ů��"){
				$("#P_ADOPTER_SEX")[0].selectedIndex = 2; 
			}else if(sylx=="�����������У�"){
				$("#P_ADOPTER_SEX")[0].selectedIndex = 1; 
			}else{
				$("#P_ADOPTER_SEX")[0].selectedIndex = 0; 
			}
		}
		
		/**
		*�ļ�����Ϊ����Ů����ʱ���������������б�ֻ��ѡ����������Ů����
		*@author:mayun
		*@date:2014-7-17
		*/
		function _dynamicJznsy(){
			var sylx = $("#P_FILE_TYPE").find("option:selected").text();
			if(sylx=="����Ů����"){
				//������������Ϊ˫�����������û�
				$("#P_FAMILY_TYPE")[0].selectedIndex = 1; 
				$("#P_FAMILY_TYPE").attr("disabled",true);
				$("#syrxb").show();
				$("#syrxb2").show();
				$("#P_ADOPTER_SEX").attr("notnull","�������������Ա�");
			}else{
				$("#P_FAMILY_TYPE")[0].selectedIndex = 0; 
				$("#P_FAMILY_TYPE").attr("disabled",false);   
				$("#syrxb").hide();
				$("#syrxb2").hide();
				$("#P_ADOPTER_SEX").removeAttr("notnull");
			}
		}
		
	</script>
	<BZ:body property="wjdlData" codeNames="WJLX_DL">
		<BZ:form name="srcForm" method="post" action="">
		<BZ:input type="hidden" field="FAMILY_TYPE_VIEW" prefix="P_" id="P_FAMILY_TYPE_VIEW" defaultValue="" />
		<BZ:input type="hidden" field="ADOPTER_SEX_VIEW" prefix="P_" id="P_ADOPTER_SEX_VIEW" defaultValue="" />
		<!-- ������begin -->
		<div class="bz-edit-data-content clearfix" desc="������" style="width: 98%;margin-left:auto;margin-right:auto;">
			<div class="stepflex" style="margin-right: 30px;">
		        <dl id="payStepFrist" class="first doing">
		            <dt class="s-num">1</dt>
		            <dd class="s-text" style="margin-left: 3px;">��һ����ѡ���ļ�����������</dd>
		        </dl>
		        <dl id="payStepNormal" class="last">
		            <dt class="s-num">2</dt>
		            <dd class="s-text" style="margin-left: 3px;">�ڶ�����¼���ļ��ͷ�����Ϣ<s></s>
		                <b></b>
		            </dd>
		        </dl>
			</div>
		</div>
		<!-- ������end -->
		
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>ѡ���ļ���Ҫ��Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>�ļ�����</td>
							<td class="bz-edit-data-value" cols="2" width="20%">
								<BZ:select field="FILE_TYPE" id="P_FILE_TYPE" notnull="�������ļ�����" formTitle="" prefix="P_" isCode="true" codeName="WJLX_DL" onchange="_dySetSyrxb()" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
							<td class="bz-edit-data-value" cols="2" width="20%">
								<BZ:select field="FAMILY_TYPE" id="P_FAMILY_TYPE" notnull="��������������" formTitle="" prefix="P_" isCode="false" width="70%" onchange="_dySetSyrxb()">
									<option value="">--��ѡ��--</option>
									<option value="1">˫������</option>
									<option value="2">����������Ů��</option>
									<option value="2">�����������У�</option>
								</BZ:select>
							</td>
							<!-- 
							<td class="bz-edit-data-title" width="10%" id="syrxb" style="display:none"><font color="red">*</font>�������Ա�</td>
							<td class="bz-edit-data-value" cols="2" width="20%" id="syrxb2" style="display:none">
								<BZ:select field="ADOPTER_SEX" id="P_ADOPTER_SEX" notnull="�������������Ա�" formTitle="" prefix="P_" isCode="false" width="70%">
									<option value="">--��ѡ��--</option>
									<option value="1">��</option>
									<option value="2">Ů</option>
								</BZ:select>
							</td>
							 -->
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="��һ��" class="btn btn-sm btn-primary" onclick="_next()"/>
			</div>
		</div>
		<!-- ��ť����end -->
		
		
		</BZ:form>
	</BZ:body>
</BZ:html>