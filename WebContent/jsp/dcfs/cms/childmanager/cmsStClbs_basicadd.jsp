<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>

<%
  /**   
 * @Description: ����Ժ���ϻ�����Ϣ¼��
 * @author wangzheng   
 * @date 2014-9-10
 * @version V1.0   
 */
TokenProcessor processor = TokenProcessor.getInstance();
String token = processor.getToken(request);
String path = request.getContextPath();
%>

<BZ:html>
	<BZ:head>
		<title>���ϻ�����Ϣ¼�루����Ժ��</title>
        <BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>	
<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
 
	//��һ��
	function _submit(){
		if (_check(document.srcForm)) {
			if(confirm('ȷ��Ҫ���浱ǰ��д������ô?')){
				document.srcForm.action=path+"/cms/childManager/infoadd.action";
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	//ȡ��
	function _cancle(){
		if(confirm('ȷ��Ҫȡ����ǰ��д������ô?')){
			document.srcForm.action=path+"/cms/childManager/findList.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;CHILD_TYPE">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<!-- ��������begin -->
<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_ID"		id="P_WELFARE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_EN"	id="P_WELFARE_NAME_EN"/>
<input type="hidden" name="listType" value="CMS_FLY_CLBS_LIST">
<input type="hidden" name="P_IS_DAILU" id="P_IS_DAILU" value="0">
<!-- ��������end -->		

<!--������Ϣ:start-->
<br>
<table class="specialtable" align="center" style='width:60%;text-align:center'>
	<tr>
		<td class="edit-data-title" colspan="2" style="text-align:center"><b>��ͯ������Ϣ¼��</b></td>
	</tr>
	<tr>
		<td class="edit-data-title" width="30%">ʡ��</td>
		<td class="edit-data-value" width="70%"> 
		<BZ:dataValue codeName="PROVINCE" field="PROVINCE_ID" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">����Ժ</td>
		<td class="edit-data-value"><BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" /></td>
	</tr>
	<tr>
		<td class="edit-data-title">��ͯ����<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="CHILD_TYPE" id="P_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" width="245px" notnull="true">
			<BZ:option value="">--��ѡ��--</BZ:option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">����<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="NAME" id="P_NAME" notnull="��������Ϊ�գ�" defaultValue="" size="35"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">�Ա�</td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="SEX" id="P_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" width="245px" notnull="�Ա���Ϊ�գ�">
			<option value="">--��ѡ��--</option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">��������<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="BIRTHDAY" id="P_BIRTHDAY" type="date" notnull="�������ڲ���Ϊ�գ�" />
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">��ͯ���<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:select prefix="P_"  field="CHILD_IDENTITY" id="P_CHILD_IDENTITY" isCode="true" codeName="ETSFLX" formTitle="��ͯ���" width="245px" notnull="��ͯ��ݲ���Ϊ�գ�">
			<option value="">--��ѡ��--</option>
		</BZ:select>
		</td>
	</tr>
</table>			
<!--֪ͨ��Ϣ:end-->
<br>
<!-- ��ť����:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="��һ��" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
		<input type="button" value="ȡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_cancle();"/>
	</div>
</div>
<!-- ��ť����:end -->

</BZ:form>
</BZ:body>
</BZ:html>
