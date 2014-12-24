<%
/**   
 * @Title: matchAudit_add.jsp
 * @Description: 匹配审核信息添加
 * @author xugy
 * @date 2014-9-9下午1:00:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String AF_ID = data.getString("AF_ID");//收养人文件ID
String CI_ID = data.getString("CI_ID");//儿童材料ID
String MAIN_CI_ID = data.getString("MAIN_CI_ID");//儿童材料主ID
String RI_ID = data.getString("RI_ID","");//预批ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);

%>
<BZ:html>
<script type="text/javascript" src="<%=path %>/resource/js/common.js"/>
<BZ:head>
	<title>儿童信息查看</title>
	<BZ:webScript edit="true" tree="true"/>
	<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;ETXB;WJLX;SYLX;">
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	$('#tab-container').easytabs();
	
	$("#MAU_AUDIT_OPTION").change(function(){
		if($("#MAU_AUDIT_OPTION").val() == "0"){
			$("#MAU_AUDIT_CONTENT").val("通过");
		}else{
			$("#MAU_AUDIT_CONTENT").val("不通过");
		}
	}); 
	
	
});
var path = "<%=path %>/";
//查看同胞信息
function _viewEtcl(CHILD_NOs){
	$.layer({
		type : 2,
		title : "儿童材料查看",
		shade : [0.5 , '#D9D9D9' , true],
		border :[2 , 0.3 , '#000', true],
		//page : {dom : '#planList'},
		iframe: {src: '<BZ:url/>/mormalMatch/showTwinsCI.action?CHILD_NOs='+CHILD_NOs},
		area: ['1050px','580px'],
		offset: ['100px' , '50px']
	});
}
//上报部门主任审核
function _submit(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"matchAudit/auditSubmit.action";
	document.srcForm.submit();
}
//保存
function _save(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"matchAudit/auditSave.action";
	document.srcForm.submit();
}
//返回列表
function _goback(){
	document.srcForm.action=path+"matchAudit/matchAuditList.action";
	document.srcForm.submit();
}
</script>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="MAU_" field="MAU_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="MI_" field="MI_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div id="tab-container" class='tab-container'>
		<ul class="etabs">
			<li class="tab"><a href="#tab1">匹配信息</a></li>
			<li class="tab"><a href="#tab2">收养人历次匹配明细</a></li>
			<li class="tab"><a href="#tab3">儿童历次匹配明细</a></li>
			<%
			String CHILD_TYPE = data.getString("CHILD_TYPE");
			if("2".equals(CHILD_TYPE)){
			    if(!"".equals(RI_ID)){
			%>
			<li class="tab"><a href="#tab4">抚育计划（中文）</a></li>
			<li class="tab"><a href="#tab5">抚育计划（英文）</a></li>
			<li class="tab"><a href="#tab6">组织意见（中文）</a></li>
			<li class="tab"><a href="#tab7">组织意见（英文）</a></li>
			<%      
			    }
			}
			%>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<table class="specialtable">
					<tr>
						<td class="edit-data-title">国家</td>
						<td class="edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						<td class="edit-data-title">收养组织</td>
						<td class="edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">收文日期</td>
						<td class="edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="edit-data-title" width="15%">收文编号 </td>
						<td class="edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">文件类型</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="edit-data-title">收养类型</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">批准书日期</td>
						<td class="edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="edit-data-title">到期日期</td>
						<td class="edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center" colspan="4"><b>收养人基本信息</b></td>
					</tr>
					<tr>
						<td colspan="4">
							<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center" colspan="4"><b>儿童基本信息</b></td>
					</tr>
					<tr>
						<td colspan="4">
							<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFirst.action?CI_ID=<%=CI_ID%>"></iframe>
						</td>
					</tr>
				</table>
			</div>
			<div id="tab2">
				<%
				int i=0;
				%>
				<BZ:for property="allAFMatchdl" fordata="AFMatchdata">
					<table class="specialtable">
						<tr>
							<td class="edit-data-value" rowspan="8" width="5%">第<%=i+1 %>次匹配</td>
							<td class="edit-data-title" rowspan="2" width="5%">儿童信息</td>
							<td class="edit-data-title" width="10%">省份</td>
							<td class="edit-data-value" width="10%">
								<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">福利院</td>
							<td class="edit-data-value" width="20%">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">姓名</td>
							<td class="edit-data-value" width="10%">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">性别</td>
							<td class="edit-data-value" width="10%">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">出生日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">儿童类型</td>
							<td class="edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" checkValue="1=正常儿童;2=特需儿童;" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">匹配日期</td>
							<td class="edit-data-value" colspan="3">
								<BZ:dataValue field="MATCH_DATE" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" rowspan="6">审核信息</td>
							<td class="edit-data-title">审核级别</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=经办人审核;1=部门主任审核;" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">审核人</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_USERNAME" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">审核日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">审核结果</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=通过;1=不通过;" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">审核意见</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_CONTENT" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">备注</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_REMARKS" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">审核级别</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=经办人审核;1=部门主任审核;" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">审核人</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">审核日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="AFMatchdata"/>
							</td>
							<td class="edit-data-title">审核结果</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=通过;1=不通过;" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">审核意见</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">备注</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true" property="AFMatchdata"/>
							</td>
						</tr>
					</table>
				<%
				i++;
				%>
				</BZ:for>
				<%
				if(i == 0){
				%>
				<div style="text-align: center;font-size: 20px;">无匹配记录</div>
				<%} %>
			</div>
			<div id="tab3">
				<%
				int k=0;
				%>
				<BZ:for property="allCIMatchdl" fordata="CIMatchdata">
					<table class="specialtable">
						<tr>
							<td class="edit-data-value" rowspan="8" width="5%">第<%=k+1 %>次匹配</td>
							<td class="edit-data-title" rowspan="2" width="5%">收养人信息</td>
							<td class="edit-data-title" width="10%">男方</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">出生日期</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">女方</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title" width="10%">出生日期</td>
							<td class="edit-data-value" width="12.5%">
								<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">国家</td>
							<td class="edit-data-value">
								<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">收养组织</td>
							<td class="edit-data-value">
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">文件类型</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">匹配日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="MATCH_DATE" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title" rowspan="6">审核信息</td>
							<td class="edit-data-title">审核级别</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=经办人审核;1=部门主任审核;" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">审核人</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_USERNAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">审核日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">审核结果</td>
							<td class="edit-data-value">
								<BZ:dataValue field="FIRST_AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=通过;1=不通过;" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">审核意见</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_CONTENT" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">备注</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="FIRST_AUDIT_REMARKS" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">审核级别</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=经办人审核;1=部门主任审核;" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">审核人</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">审核日期</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date" property="CIMatchdata"/>
							</td>
							<td class="edit-data-title">审核结果</td>
							<td class="edit-data-value">
								<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=通过;1=不通过;" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">审核意见</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">备注</td>
							<td class="edit-data-value" colspan="7">
								<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true" property="CIMatchdata"/>
							</td>
						</tr>
					</table>
				<%
				k++;
				%>
				</BZ:for>
				<%
				if(k == 0){
				%>
				<div style="text-align: center;font-size: 20px;">无匹配记录</div>
				<%} %>
			</div>
			<%
			if("2".equals(CHILD_TYPE)){
			    if(!"".equals(RI_ID)){
			%>
			<div id="tab4">
				<iframe id="TOFrame4" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=4"></iframe>
			</div>
			<div id="tab5">
				<iframe id="TOFrame5" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=5"></iframe>
			</div>
			<div id="tab6">
				<iframe id="TOFrame6" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=6"></iframe>
			</div>
			<div id="tab7">
				<iframe id="TOFrame7" name="TOFrame" class="TOFrame" frameborder=0 style="width: 100%;" src="<%=path%>/matchAudit/getTendingAndOpinion.action?MAIN_CI_ID=<%=MAIN_CI_ID%>&CI_ID=<%=CI_ID%>&FLAG=7"></iframe>
			</div>
			<%
			    }
			}
			%>
		</div>
		<div class='panel-container'>
			<table class="specialtable">
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>审核录入信息</b></td>
				</tr>
				<tr>
					<td>
						<table class="specialtable">
							<tr>
								<td class="edit-data-title" width="10%">审核日期</td>
								<td class="edit-data-value" width="23%">
									<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true"/>
								</td>
								<td class="edit-data-title" width="10%">审核人</td>
								<td class="edit-data-value" width="23%">
									<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
								</td>
								<td class="edit-data-title" width="10%"><font color="red">*</font>审核结果</td>
								<td class="edit-data-value" width="24%">
									<BZ:select prefix="MAU_" field="AUDIT_OPTION" id="MAU_AUDIT_OPTION" formTitle="审核结果">
										<BZ:option value="0">通过</BZ:option>
										<BZ:option value="1">不通过</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="edit-data-title">审核意见</td>
								<td class="edit-data-value" colspan="5">
									<BZ:input prefix="MAU_" field="AUDIT_CONTENT" id="MAU_AUDIT_CONTENT" defaultValue="通过" type="textarea" style="width:98%;height:60px;"/>
								</td>
							</tr>
							<tr>
								<td class="edit-data-title">备注</td>
								<td class="edit-data-value" colspan="5">
									<BZ:input prefix="MAU_" field="AUDIT_REMARKS" defaultValue="" type="textarea" style="width:98%;height:60px;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;">
			<input type="button" value="上&nbsp;&nbsp;&nbsp;报" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="保&nbsp;&nbsp;&nbsp;存" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>
