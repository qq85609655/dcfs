<%
/**   
 * @Title: adoption_regis_info_mod.jsp
 * @Description: 收养登记信息修改
 * @author xugy
 * @date 2014-9-23下午8:21:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");
//文件类型
String FILE_TYPE = data.getString("FILE_TYPE");
//收养类型
String FAMILY_TYPE = data.getString("FAMILY_TYPE");
//收养人性别
String ADOPTER_SEX = data.getString("ADOPTER_SEX");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>收养登记信息修改</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//提交
function _submit(){
	//页面表单校验
	/* if (!runFormVerify(document.srcForm, false)) {
		return;
	} */
	document.srcForm.action=path+"adoptionRegis/saveAdoptionRegInfo.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;ETSFLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_MARRYCOND;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="MI_" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="CI_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AF_" field="AF_ID" defaultValue=""/>
<BZ:input type="hidden" field="FILE_TYPE" defaultValue=""/><!-- 文件类型 -->
<BZ:input type="hidden" field="FAMILY_TYPE" defaultValue=""/><!-- 收养类型 -->
<BZ:input type="hidden" field="ADOPTER_SEX" defaultValue=""/><!-- 收养人性别 -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>被收养人信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">姓名</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">性别</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:select prefix="CI_" field="SEX" isCode="true" codeName="ETXB" defaultValue="" formTitle="性别">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="BIRTHDAY" type="date" defaultValue="" formTitle="出生日期"/>
						</td>
						<td class="bz-edit-data-title">身份证号</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="ID_CARD" defaultValue="" formTitle="身份证号"/>
							
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">身份</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="选择儿童身份" treeType="-1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="CHILD_IDENTITY" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">送养人（中文）</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="SENDER" defaultValue="" formTitle="送养人"/>
						</td>
						<td class="bz-edit-data-title">送养人（英文）</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="SENDER_EN" defaultValue="" formTitle="送养人"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">送养人地址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="SENDER_ADDR" defaultValue="" formTitle="送养人地址" style="width:98%;"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<%
					if("33".equals(FILE_TYPE)){//继子女收养
					    if("1".equals(ADOPTER_SEX)){//男收养人
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">性别</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="男" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="国籍" >
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" />
						</td>
						<td class="bz-edit-data-title">婚姻状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="" defaultValue="已婚"/>
						</td>
					</tr>
					<%
					    }
					    if("2".equals(ADOPTER_SEX)){//女收养人
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">性别</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="女" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="国籍" >
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" />
						</td>
						<td class="bz-edit-data-title">婚姻状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="" defaultValue="已婚"/>
						</td>
					</tr>
					<%        
					    }
					}else{//非继子女收养
					    if("1".equals(FAMILY_TYPE)){//双亲收养
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%"></td>
						<td class="bz-edit-data-title" width="40%" style="text-align: center;"><b>男收养人</b></td>
						<td class="bz-edit-data-title" width="40%" style="text-align: center;"><b>女收养人</b></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="国籍" >
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="国籍" >
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">文化程度</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" formTitle="文化程度">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" formTitle="文化程度">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_JOB_CN" defaultValue="" formTitle="职业" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_JOB_CN" defaultValue="" formTitle="职业" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" formTitle="健康状况">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" formTitle="健康状况">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">婚姻状况</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="已婚"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">货币单位</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">总资产</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="TOTAL_ASSET" defaultValue="" formTitle="总资产" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">总债务</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="TOTAL_DEBT" defaultValue="" formTitle="总债务" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">子女数量及情况</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="CHILD_CONDITION_CN" type="textarea" defaultValue="" style="width:98%;height:40px;" formTitle="子女数量及情况" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">现住址</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="家庭住址" />
						</td>
					</tr>
					<%
					    }
						if("2".equals(FAMILY_TYPE)){//单亲收养
						    if("1".equals(ADOPTER_SEX)){//男收养人
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">性别</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="男" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="国籍" >
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" />
						</td>
						<td class="bz-edit-data-title">文化程度</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" defaultValue="" formTitle="文化程度">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_JOB_CN" defaultValue="" formTitle="职业" />
						</td>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" formTitle="健康状况">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">婚姻状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MARRY_CONDITION" defaultValue="" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
						</td>
						<td class="bz-edit-data-title">货币单位</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">总资产</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="TOTAL_ASSET" defaultValue="" formTitle="总资产" />
						</td>
						<td class="bz-edit-data-title">总债务</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="TOTAL_DEBT" defaultValue="" formTitle="总债务" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">子女数量及情况</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="CHILD_CONDITION_CN" type="textarea" defaultValue="" style="width:98%;height:40px;" formTitle="子女数量及情况" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭住址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="家庭住址" />
						</td>
					</tr>
					<%	        
						    }
							if("2".equals(ADOPTER_SEX)){//女收养人
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">性别</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="男" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" formTitle="国籍" >
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" />
						</td>
						<td class="bz-edit-data-title">文化程度</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_EDUCATION" isCode="true" codeName="ADOPTER_EDU" defaultValue="" formTitle="文化程度">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_JOB_CN" defaultValue="" formTitle="职业" />
						</td>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_HEALTH" isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" formTitle="健康状况">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">婚姻状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MARRY_CONDITION" defaultValue="" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
						</td>
						<td class="bz-edit-data-title">货币单位</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">总资产</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="TOTAL_ASSET" defaultValue="" formTitle="总资产" />
						</td>
						<td class="bz-edit-data-title">总债务</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="TOTAL_DEBT" defaultValue="" formTitle="总债务" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">子女数量及情况</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="CHILD_CONDITION_CN" type="textarea" defaultValue="" style="width:98%;height:40px;" formTitle="子女数量及情况" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭住址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="家庭住址" />
						</td>
					</tr>
					<%		    
							}
						}
					}
					%>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养登记信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title">登记证号</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADREG_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">入籍日期</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="CI_" field="NATION_DATE" type="date" defaultValue="" formTitle="入籍日期"/>
						</td>
						<td class="bz-edit-data-title" width="20%">被收养后改名</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="CI_" field="CHILD_NAME_EN" defaultValue="" formTitle="被收养后改名" />
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title">登记状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_STATE" defaultValue="" onlyValue="true" checkValue="0=未登记;1=已登记;2=无效登记;3=注销;"/>
							<BZ:input prefix="MI_" field="ADREG_STATE" type="hidden" defaultValue=""/>
							<BZ:input prefix="MI_" field="SIGN_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">登记日期</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="MI_" field="ADREG_DATE" type="date" readonly="readonly" defaultValue="" formTitle="登记日期"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="MI_" field="ADREG_REMARKS" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="备注"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提&nbsp;&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
