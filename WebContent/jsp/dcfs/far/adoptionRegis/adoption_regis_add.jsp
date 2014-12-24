<%
/**   
 * @Title: adoption_regis_add.jsp
 * @Description: 收养登记添加
 * @author xugy
 * @date 2014-9-23下午2:21:23
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

String MI_ID = data.getString("MI_ID");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>收养登记添加</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//
function _changeType(type){
	if(type == "1"){
		//alert($("#deleteHtml span:eq(2)"));
		$("#deleteHtml span:eq(2)").remove();
	}
	if(type == "2"){
		var adregNo=document.getElementById("adregNo").innerHTML;
		$("#insertSelect").append(adregNo);
	}
}
//
function _changeResult(result){
	var tab = document.getElementById("tab");
	var tr = document.getElementById("insertTd");
	if(result == "1"){
		tr.deleteCell(3);
		tr.deleteCell(2);
		document.getElementById("adregResult").colSpan="3";
		tab.deleteRow(3);
	}
	if(result == "2"){
		document.getElementById("adregResult").colSpan="1";
		var newTd1 = tr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = tr.insertCell();
		newTd2.className="bz-edit-data-value";
		
		var dealTypeTitle=document.getElementById("dealTypeTitle").innerHTML;
		newTd1.innerHTML=dealTypeTitle;
		var dealTypeValue=document.getElementById("dealTypeValue").innerHTML;
		newTd2.innerHTML=dealTypeValue;
		
		var newTr = tab.insertRow(3);
		newTr.id="adregInvalidReason";
		var newTd1 = newTr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = newTr.insertCell();
		newTd2.className="bz-edit-data-value";
		newTd2.colSpan="3";
		
		var invalidReasonTitle=document.getElementById("invalidReasonTitle").innerHTML;
		newTd1.innerHTML=invalidReasonTitle;
		var invalidReasonValue=document.getElementById("invalidReasonValue").innerHTML;
		newTd2.innerHTML=invalidReasonValue;
	}
}
//保存
function _submit(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"adoptionRegis/saveAdoptionReg.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;ETSFLX;GJ;">
<div id="adregNo" style="display: none;">
	<BZ:select field="ADREG_NO" defaultValue="" isCode="true" codeName="OLD_FAR_SN_LIST" formTitle="登记证号" width="148px" notnull="登记证号不能为空">
		<BZ:option value="">--请选择--</BZ:option>
	</BZ:select>
</div>
<div id="dealTypeTitle" style="display: none;">
	<font color="red">*</font>家庭后续处理类型
</div>
<div id="dealTypeValue" style="display: none;">
	<BZ:select prefix="MI_" field="ADREG_DEAL_TYPE" defaultValue="" width="148px" formTitle="家庭后续处理类型">
		<BZ:option value="0">更换被收养人</BZ:option>
		<BZ:option value="1">家庭退出收养</BZ:option>
	</BZ:select>
</div>
<div id="invalidReasonTitle" style="display: none;">
	<font color="red">*</font>无效登记原因
</div>
<div id="invalidReasonValue" style="display: none;">
	<BZ:input prefix="MI_" field="ADREG_INVALID_REASON" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="无效登记原因" notnull="无效登记原因不能为空"/>
</div>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden" id="ids" name="ids" value="<%=MI_ID %>"/>
<input type="hidden" id="MI_ID" name="MI_ID" value="<%=MI_ID %>"/>
<BZ:input type="hidden" prefix="MI_" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="CI_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AF_" field="AF_ID" defaultValue=""/>
<BZ:input type="hidden" field="IS_CONVENTION_ADOPT" defaultValue=""/><!-- 是否公约收养 -->
<BZ:input type="hidden" field="COUNTRY_CODE" defaultValue=""/><!-- 省份code -->
<BZ:input type="hidden" field="PROVINCE_ID" defaultValue=""/><!-- 省份code -->
<BZ:input type="hidden" field="FILE_TYPE" defaultValue=""/><!-- 文件类型 -->
<BZ:input type="hidden" field="FAMILY_TYPE" defaultValue=""/><!-- 收养类型 -->
<BZ:input type="hidden" field="ADOPTER_SEX" defaultValue=""/><!-- 收养人性别 -->
<BZ:input type="hidden" field="SIGN_DATE" defaultValue=""/><!-- 签批日期 -->
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
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>性别</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:select prefix="CI_" field="SEX" isCode="true" codeName="ETXB" defaultValue="" formTitle="性别">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="BIRTHDAY" type="date" defaultValue="" formTitle="出生日期" notnull="出生日期不能为空"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>身份证号</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="ID_CARD" defaultValue="" formTitle="身份证号" notnull="身份证号不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>身份</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="选择儿童身份" treeType="-1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="CHILD_IDENTITY" notnull="儿童身份不能为空" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">送养人</td>
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
						<td class="bz-edit-data-title"><font color="red">*</font>国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="国籍" notnull="请选择收养人国籍">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>护照号码</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" notnull="护照号码不能为空"/>
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
						<td class="bz-edit-data-title"><font color="red">*</font>国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="国籍" notnull="请选择收养人国籍">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>护照号码</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" notnull="护照号码不能为空"/>
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
						<td class="bz-edit-data-title"><font color="red">*</font>国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="国籍" notnull="请选择收养人国籍">
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="国籍" notnull="请选择收养人国籍">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" notnull="护照号码不能为空"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" notnull="护照号码不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>家庭住址</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="家庭住址" notnull="家庭住址不能为空"/>
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
						<td class="bz-edit-data-title"><font color="red">*</font>国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="国籍" notnull="请选择收养人国籍">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>护照号码</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" notnull="护照号码不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>家庭住址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="家庭住址" notnull="家庭住址不能为空"/>
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
						<td class="bz-edit-data-title"><font color="red">*</font>国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="国籍" notnull="请选择收养人国籍">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>护照号码</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="护照号码" notnull="护照号码不能为空"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>家庭住址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="家庭住址" notnull="家庭住址不能为空"/>
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
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>登记证号</td>
						<td class="bz-edit-data-value" width="30%" id="deleteHtml" colspan="3">
						<span id="insertSelect">
							<BZ:select field="NUMBER_TYPE" onchange="_changeType(this.value)" defaultValue="" width="148px" formTitle="登记证号生成方式">
								<BZ:option value="1">自动生成</BZ:option>
								<BZ:option value="2">使用旧号</BZ:option>
							</BZ:select>
						</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>入籍日期</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="NATION_DATE" type="date" defaultValue="" formTitle="入籍日期" notnull="入籍日期不能为空"/>
						</td>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>被收养后改名</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="CI_" field="CHILD_NAME_EN" defaultValue="" formTitle="被收养后改名" notnull="姓名不能为空"/>
						</td>
					</tr>
					<tr id="insertTd">
						<td class="bz-edit-data-title"><font color="red">*</font>登记结果</td>
						<td class="bz-edit-data-value" id="adregResult" colspan="3">
							<BZ:select field="ADREG_RESULT" onchange="_changeResult(this.value)" defaultValue="" width="148px" formTitle="登记结果">
								<BZ:option value="1">登记成功</BZ:option>
								<BZ:option value="2">无效登记</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="MI_" field="ADREG_REMARKS" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="备注"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">登记人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>登记日期</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="MI_" field="ADREG_DATE" type="date" readonly="readonly" defaultValue="" formTitle="登记日期" notnull="登记日期不能为空"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="确&nbsp;&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
