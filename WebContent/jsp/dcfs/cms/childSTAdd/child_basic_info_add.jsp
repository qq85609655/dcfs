<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%
/**   
 * @Description:省厅代录
 * @author xcp
 * @date 2014-9-24 21:59:25
 * @version V1.0   
 */
    /******Java代码功能区域Start******/
    String path = request.getContextPath();
	/******Java代码功能区域End******/
%>
<BZ:html>
<BZ:head>
	<title>儿童基本信息录入</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	//下一步
	function _gonextpage() {
		
		$("#P_WELFARE_NAME_CN").val($("#P_WELFARE_ID").find("option:selected").attr("title"));
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		//if(confirm('确定要保存当前填写数据吗？')){
						
			//alert($("#P_WELFARE_NAME_CN").val());
			document.srcForm.action = path + "cms/childstadd/infoadd.action";
			document.srcForm.submit();
		/*}else{
			return;
		}*/
	}
	
	function _goback(){
		if(confirm('确定要取消当前填写数据吗？')){
			document.srcForm.action = path + "cms/childstadd/findList.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
    </script>
<BZ:body property="data" codeNames="ETXB;CHILD_TYPE;PROVINCE;ETSFLX">
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="P_" field="CI_ID"  defaultValue=""/>
		<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/>		
		<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
		<input type="hidden" name="P_IS_DAILU" id="P_IS_DAILU" value="2">
		<!-- 隐藏区域end -->
		<br>
		<!-- 进度条begin -->
		<div class="stepflex" style="margin-right: 100px;">
	        <dl id="payStepFrist" class="normal doing">
	            <dt class="s-num">1</dt>
	            <dd class="s-text" style="margin-left:0px">填写儿童基本信息</dd>
	        </dl>
	        <dl id="payStepNormal" class="last">
	            <dt class="s-num">2</dt>
	            <dd class="s-text" style="margin-left:0px">填写儿童详细信息<s></s>
	                <b></b>
	            </dd>
	        </dl>	        
		</div>
		<!-- 进度条end -->
		<div>
		<table class="specialtable" align="center" style='width:80%;text-align:center'>
		<tr>
			<td class="edit-data-title" colspan="2" style="text-align:center"><b>儿童基本信息录入</b></td>
		</tr>
		<tr>
		<td class="edit-data-title" width="30%">福 利 院<font color="red">*</font></td>
		<td class="edit-data-value" width="70%">
			<BZ:select prefix="P_" field="WELFARE_ID" id="P_WELFARE_ID" isCode="true" codeName="WELFARE_LIST" defaultValue="" notnull="福利院不能为空" width="245px" formTitle="福利院">
				<BZ:option value="">--请选择--</BZ:option>
			</BZ:select>
		</td> 
		</tr>
		 <tr>
		 	<td class="edit-data-title" width="30%" >类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型<font color="red">*</font></td>
			<td class="edit-data-value" width="70%">
			    <BZ:select prefix="P_" field="CHILD_TYPE" id="P_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型"  width="245px" notnull="类型不能为空" defaultValue="">
					<BZ:option value="">--请选择--</BZ:option>
				</BZ:select>
			</td>
		 </tr>
		<tr>
			<td class="edit-data-title">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名<font color="red">*</font></td>
			<td class="edit-data-value">
				<BZ:input prefix="P_" field="NAME" id="P_NAME" defaultValue="" notnull="姓名不能为空" size="35"/>
			</td> 
		</tr>
		 
		<tr>
			<td class="edit-data-title">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别<font color="red">*</font></td>
			<td class="edit-data-value">
				<BZ:select prefix="P_" field="SEX" id="P_SEX" isCode="true" codeName="ETXB" formTitle="儿童性别" width="245px" notnull="儿童性别不能为空" defaultValue="">
					<BZ:option value="">--请选择--</BZ:option>
				</BZ:select>
			</td> 
		</tr>
		<tr>
		 
		<td class="edit-data-title">出生日期<font color="red">*</font></td>
		<td class="edit-data-value">
			<BZ:input prefix="P_" field="BIRTHDAY" id="P_BIRTHDAY" type="Date" notnull="出生日期不能为空" />
			</td> 
		 </tr>
		 <tr>
		<td class="edit-data-title">儿童身份<font color="red">*</font></td>
		<td class="edit-data-value">
		
		<BZ:input prefix="P_" field="CHILD_IDENTITY" id="S_CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="儿童身份" treeType="-1"  notnull="true" helperSync="true" showParent="false"  defaultValue="<%=ChildInfoConstants.CHILD_IDENTITY_FOUNDLING %>"  defaultShowValue="" showFieldId="CHILD_IDENTITY_ID"  style="width:250px;"/>
		
		</tr>
		
		</table>
		<br>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="下一步" class="btn btn-sm btn-primary" onclick="_gonextpage()"/>
				<input type="button" value="取消" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		
		<table class="specialtable" align="center" style='width:80%;text-align:center'>
			<tr>
				<td class="edit-data-value"><b>儿童材料填报说明 :</b><br></>在录入儿童基本信息后，系统将根据福利院名称、儿童姓名、性别、出生日期验证是否存在相同基本信息的儿童，
					如果存在则无法录入新的儿童信息。</td>
				</td>
			</tr>
		</table>
		
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>