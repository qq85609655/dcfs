<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%
/**   
 * @Description:ʡ����¼
 * @author xcp
 * @date 2014-9-24 21:59:25
 * @version V1.0   
 */
    /******Java���빦������Start******/
    String path = request.getContextPath();
	/******Java���빦������End******/
%>
<BZ:html>
<BZ:head>
	<title>��ͯ������Ϣ¼��</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	//��һ��
	function _gonextpage() {
		
		$("#P_WELFARE_NAME_CN").val($("#P_WELFARE_ID").find("option:selected").attr("title"));
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		//if(confirm('ȷ��Ҫ���浱ǰ��д������')){
						
			//alert($("#P_WELFARE_NAME_CN").val());
			document.srcForm.action = path + "cms/childstadd/infoadd.action";
			document.srcForm.submit();
		/*}else{
			return;
		}*/
	}
	
	function _goback(){
		if(confirm('ȷ��Ҫȡ����ǰ��д������')){
			document.srcForm.action = path + "cms/childstadd/findList.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
    </script>
<BZ:body property="data" codeNames="ETXB;CHILD_TYPE;PROVINCE;ETSFLX">
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="P_" field="CI_ID"  defaultValue=""/>
		<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/>		
		<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
		<input type="hidden" name="P_IS_DAILU" id="P_IS_DAILU" value="2">
		<!-- ��������end -->
		<br>
		<!-- ������begin -->
		<div class="stepflex" style="margin-right: 100px;">
	        <dl id="payStepFrist" class="normal doing">
	            <dt class="s-num">1</dt>
	            <dd class="s-text" style="margin-left:0px">��д��ͯ������Ϣ</dd>
	        </dl>
	        <dl id="payStepNormal" class="last">
	            <dt class="s-num">2</dt>
	            <dd class="s-text" style="margin-left:0px">��д��ͯ��ϸ��Ϣ<s></s>
	                <b></b>
	            </dd>
	        </dl>	        
		</div>
		<!-- ������end -->
		<div>
		<table class="specialtable" align="center" style='width:80%;text-align:center'>
		<tr>
			<td class="edit-data-title" colspan="2" style="text-align:center"><b>��ͯ������Ϣ¼��</b></td>
		</tr>
		<tr>
		<td class="edit-data-title" width="30%">�� �� Ժ<font color="red">*</font></td>
		<td class="edit-data-value" width="70%">
			<BZ:select prefix="P_" field="WELFARE_ID" id="P_WELFARE_ID" isCode="true" codeName="WELFARE_LIST" defaultValue="" notnull="����Ժ����Ϊ��" width="245px" formTitle="����Ժ">
				<BZ:option value="">--��ѡ��--</BZ:option>
			</BZ:select>
		</td> 
		</tr>
		 <tr>
		 	<td class="edit-data-title" width="30%" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<font color="red">*</font></td>
			<td class="edit-data-value" width="70%">
			    <BZ:select prefix="P_" field="CHILD_TYPE" id="P_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����"  width="245px" notnull="���Ͳ���Ϊ��" defaultValue="">
					<BZ:option value="">--��ѡ��--</BZ:option>
				</BZ:select>
			</td>
		 </tr>
		<tr>
			<td class="edit-data-title">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<font color="red">*</font></td>
			<td class="edit-data-value">
				<BZ:input prefix="P_" field="NAME" id="P_NAME" defaultValue="" notnull="��������Ϊ��" size="35"/>
			</td> 
		</tr>
		 
		<tr>
			<td class="edit-data-title">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<font color="red">*</font></td>
			<td class="edit-data-value">
				<BZ:select prefix="P_" field="SEX" id="P_SEX" isCode="true" codeName="ETXB" formTitle="��ͯ�Ա�" width="245px" notnull="��ͯ�Ա���Ϊ��" defaultValue="">
					<BZ:option value="">--��ѡ��--</BZ:option>
				</BZ:select>
			</td> 
		</tr>
		<tr>
		 
		<td class="edit-data-title">��������<font color="red">*</font></td>
		<td class="edit-data-value">
			<BZ:input prefix="P_" field="BIRTHDAY" id="P_BIRTHDAY" type="Date" notnull="�������ڲ���Ϊ��" />
			</td> 
		 </tr>
		 <tr>
		<td class="edit-data-title">��ͯ���<font color="red">*</font></td>
		<td class="edit-data-value">
		
		<BZ:input prefix="P_" field="CHILD_IDENTITY" id="S_CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="��ͯ���" treeType="-1"  notnull="true" helperSync="true" showParent="false"  defaultValue="<%=ChildInfoConstants.CHILD_IDENTITY_FOUNDLING %>"  defaultShowValue="" showFieldId="CHILD_IDENTITY_ID"  style="width:250px;"/>
		
		</tr>
		
		</table>
		<br>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="��һ��" class="btn btn-sm btn-primary" onclick="_gonextpage()"/>
				<input type="button" value="ȡ��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		
		<table class="specialtable" align="center" style='width:80%;text-align:center'>
			<tr>
				<td class="edit-data-value"><b>��ͯ�����˵�� :</b><br></>��¼���ͯ������Ϣ��ϵͳ�����ݸ���Ժ���ơ���ͯ�������Ա𡢳���������֤�Ƿ������ͬ������Ϣ�Ķ�ͯ��
					����������޷�¼���µĶ�ͯ��Ϣ��</td>
				</td>
			</tr>
		</table>
		
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>