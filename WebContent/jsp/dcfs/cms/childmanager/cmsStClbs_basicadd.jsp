<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>

<%
  /**   
 * @Description: 福利院材料基本信息录入
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
		<title>材料基本信息录入（福利院）</title>
        <BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>	
<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
 
	//下一步
	function _submit(){
		if (_check(document.srcForm)) {
			if(confirm('确认要保存当前填写的数据么?')){
				document.srcForm.action=path+"/cms/childManager/infoadd.action";
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	//取消
	function _cancle(){
		if(confirm('确认要取消当前填写的数据么?')){
			document.srcForm.action=path+"/cms/childManager/findList.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;CHILD_TYPE">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<!-- 隐藏区域begin -->
<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_ID"		id="P_WELFARE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_EN"	id="P_WELFARE_NAME_EN"/>
<input type="hidden" name="listType" value="CMS_FLY_CLBS_LIST">
<input type="hidden" name="P_IS_DAILU" id="P_IS_DAILU" value="0">
<!-- 隐藏区域end -->		

<!--基本信息:start-->
<br>
<table class="specialtable" align="center" style='width:60%;text-align:center'>
	<tr>
		<td class="edit-data-title" colspan="2" style="text-align:center"><b>儿童基本信息录入</b></td>
	</tr>
	<tr>
		<td class="edit-data-title" width="30%">省份</td>
		<td class="edit-data-value" width="70%"> 
		<BZ:dataValue codeName="PROVINCE" field="PROVINCE_ID" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">福利院</td>
		<td class="edit-data-value"><BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" /></td>
	</tr>
	<tr>
		<td class="edit-data-title">儿童类型<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="CHILD_TYPE" id="P_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" width="245px" notnull="true">
			<BZ:option value="">--请选择--</BZ:option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">姓名<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="NAME" id="P_NAME" notnull="姓名不能为空！" defaultValue="" size="35"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">性别</td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="SEX" id="P_SEX" isCode="true" codeName="ETXB" formTitle="性别" width="245px" notnull="性别不能为空！">
			<option value="">--请选择--</option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">出生日期<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="BIRTHDAY" id="P_BIRTHDAY" type="date" notnull="出生日期不能为空！" />
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">儿童身份<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:select prefix="P_"  field="CHILD_IDENTITY" id="P_CHILD_IDENTITY" isCode="true" codeName="ETSFLX" formTitle="儿童身份" width="245px" notnull="儿童身份不能为空！">
			<option value="">--请选择--</option>
		</BZ:select>
		</td>
	</tr>
</table>			
<!--通知信息:end-->
<br>
<!-- 按钮区域:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="按钮区">
		<input type="button" value="下一步" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
		<input type="button" value="取&nbsp;&nbsp;消" class="btn btn-sm btn-primary" onclick="_cancle();"/>
	</div>
</div>
<!-- 按钮区域:end -->

</BZ:form>
</BZ:body>
</BZ:html>
