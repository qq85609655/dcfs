<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:描述
 * @author wangzheng
 * @date 2014-9-30 12:23:32
 * @version V1.0   
 */
    /******Java代码功能区域Start******/
 	//构造数据对象
	Data data = (Data)request.getAttribute("data");
    if(data==null){
        data = new Data();
    }
	request.setAttribute("data",data);
	/******Java代码功能区域End******/
%>
<BZ:html>
<BZ:head>
	<title>添加</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	//});
	
	function _submit() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "/mkr/regOrgManager/save.action";
			document.srcForm.submit();
		  }
	}
	
	function _goback(){
		document.srcForm.action = path + "/mkr/regOrgManager/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" codeNames="PROVINCE;SEX">
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		<BZ:input prefix="P_" field="RI_ID" type="hidden" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养登记机关信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					<td class="bz-edit-data-title" width="15%">省份</td>
					<td class="bz-edit-data-value" colspan="3">
						<BZ:select prefix="P_" field="PROVINCE_ID" id="P_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="省份" defaultValue="" width="245px" notnull="省份不能为空！">
							<BZ:option value="">--请选择--</BZ:option>
						</BZ:select>
						</td> 
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">机关名称<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="NAME_CN" id="P_NAME_CN" defaultValue="" className="inputOne" formTitle="机关名称" restriction="hasSpecialChar" notnull="机关名称不能为空！" size="50" maxlength="100"/>
						</td> 
					 <td class="bz-edit-data-title" width="15%">英文名称<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="NAME_EN" id="P_NAME_EN" defaultValue="" className="inputOne" formTitle="英文名称" restriction="hasSpecialChar" notnull="机关名称不能为空！" size="50" maxlength="100"/>
						</td>
					 </tr>
					 <tr>
					 <td class="bz-edit-data-title" width="15%">登记地点<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CITY_ADDRESS_CN" id="P_CITY_ADDRESS_CN" defaultValue="" className="inputOne" formTitle="登记地点_中文" notnull="登记地点不能为空！" restriction="hasSpecialChar" size="50"  maxlength="100"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">登记地点（英文）<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CITY_ADDRESS_EN" id="P_CITY_ADDRESS_EN" defaultValue="" className="inputOne" formTitle="登记地点_英文" notnull="登记地点不能为空！" restriction="hasSpecialChar" size="50"  maxlength="100"/>
						</td> 					
					 </tr>
					 <tr>
					 
					<td class="bz-edit-data-title" width="15%">地址</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="DEPT_ADDRESS_CN" id="P_DEPT_ADDRESS_CN" defaultValue="" className="inputOne" formTitle="地址_中文" restriction="hasSpecialChar" size="50" maxlength="120"/>
						</td> 

					<td class="bz-edit-data-title" width="15%">地址（英文）</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="DEPT_ADDRESS_EN" id="P_DEPT_ADDRESS_EN" defaultValue="" className="inputOne" formTitle="地址_英文" restriction="hasSpecialChar" size="50" maxlength="120"/>
						</td> 
					</tr>
					<tr>
						<td class="bz-edit-data-title" colspan="4" style="text-align:center"><b>收养登记经办人信息</b></td>
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">姓名<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_NAME" id="P_CONTACT_NAME" defaultValue="" className="inputOne" formTitle="经办人_姓名" restriction="hasSpecialChar" notnull="经办人姓名不能为空！" size="50" maxlength="30"/>
						</td> 

					<td class="bz-edit-data-title" width="15%">姓名拼音<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_NAMEPY" id="P_CONTACT_NAMEPY" defaultValue="" className="inputOne" formTitle="经办人_姓名拼音" restriction="hasSpecialChar" notnull="经办人姓名拼音不能为空！" size="50" maxlength="200"/>
						</td> 
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">性别<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:select prefix="P_" field="CONTACT_SEX" id="P_CONTACT_SEX" isCode="true" codeName="SEX" formTitle="性别" defaultValue="" width="245px" notnull="性别不能为空！">
							<BZ:option value="">--请选择--</BZ:option>
						</BZ:select>
					 </td>
					 
					<td class="bz-edit-data-title" width="15%">身份证号<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_CARD" id="P_CONTACT_CARD" defaultValue="" className="inputOne" formTitle="经办人_身份证号" restriction="hasSpecialChar" notnull="经办人身份证号不能为空！" size="50" maxlength="64"/>
						</td>
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">职务<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_JOB" id="P_CONTACT_JOB" defaultValue="" className="inputOne" formTitle="经办人_职务" restriction="hasSpecialChar" notnull="经办人职务不能为空！" size="50"  maxlength="64"/>
						</td> 
					
					<td class="bz-edit-data-title" width="15%">联系电话<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CONTACT_TEL" id="P_CONTACT_TEL" defaultValue="" className="inputOne" formTitle="经办人_联系电话" restriction="hasSpecialChar" notnull="经办人联系电话不能为空！" size="50" maxlength="100"/>
						</td> 
						 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">邮箱<font color="red">*</font></td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:input prefix="P_" field="CONTACT_MAIL" id="P_CONTACT_MAIL" defaultValue="" className="inputOne" formTitle="经办人_邮箱"  notnull="经办人邮箱不能为空！" size="50" maxlength="100"/>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">备注</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:input prefix="P_" field="CONTACT_DESC" id="P_CONTACT_DESC" defaultValue="" className="inputOne" formTitle="经办人_备注" restriction="hasSpecialChar" size="120"  maxlength="1000"/>
						</td> 
					 </tr>
				</table>
				</div>
			</div>
		</div>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>