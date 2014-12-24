<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    Data data = (Data)request.getAttribute("data");
    String pro_code = (String)request.getAttribute("pro_code");
%>
<BZ:html>
<BZ:head>
	<title>福利机构信息修改</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['welfare','mainFrame']);//公共功能，框架元素自适应
	});
	//返回
	function _goback(){
		document.organForm.action=path+"mkr/organSupp/findWelfareByOrgan.action?ID=<%=pro_code%>";
 		document.organForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX;PROVINCE;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 审核信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					机构基本信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-value" style="width: 20%" rowspan="6">
							单位基本信息
						</td>
						<td class="bz-edit-data-title" style="width:15%">中文名称</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">英文名称</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ENNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">法人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PRINCIPAL" defaultValue=""/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_ADDRESS_CN" defaultValue="" onlyValue="true"/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮编</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_POST"  defaultValue="" onlyValue="true" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_TEL"  defaultValue=""  onlyValue="true"  />	
						</td>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_FAX" onlyValue="true" defaultValue=""  />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-value" style="width: 20%" rowspan="4">
							经办人
						</td>
						<td class="bz-edit-data-title" style="width:15%">姓名</td>
						<td class="bz-edit-data-value" style="width:20%">
							<BZ:dataValue field="CONTACT_NAME" onlyValue="true" style="width:90%;"  defaultValue="" />			
						</td>
						<td class="bz-edit-data-title" style="width:15%">性别</td>
						<td class="bz-edit-data-value" style="width:20%">
							<BZ:select prefix="MKR_"  field="CONTACT_SEX" id="MKR_CONTACT_SEX" disabled="true"  isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="性别" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">身份证件号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_CARD" onlyValue="true"  defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">职务</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_JOB" onlyValue="true" style="width:90%;"  defaultValue="" />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">联系电话</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_TEL" onlyValue="true" style="width:90%;"  defaultValue="" />						
						</td>
						<td class="bz-edit-data-title">邮箱</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_MAIL" onlyValue="true" style="width:90%;"  defaultValue="" />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CONTACT_DESC" onlyValue="true" style="width:90%;"  defaultValue=""/>
						</td>
					</tr>
				</table>
				
			</div>
			
			<%-- <div class="bz-edit-data-content clearfix" desc="内容体">
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="15%" />
						<col width="20%" />
						<col width="15%" />
						<col width="20%" />
						<col width="15%" />
						<col width="15%"/>
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">中文名称(CN)</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">英文名称(EN)</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ENNAME" defaultValue="" onlyValue="true" defaultValue=''/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">省份</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" />
						</td>
						<td class="bz-edit-data-title">法人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PRINCIPAL" defaultValue=""/>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">登记地点(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CITY_ADDRESS_CN" style="width:90%;"  defaultValue="" />					
						</td>
						<td class="bz-edit-data-title">登记地点(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CITY_ADDRESS_EN" style="width:90%;"  defaultValue=""/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_ADDRESS_CN" defaultValue="" />				
						</td>
						<td class="bz-edit-data-title">地址(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_ADDRESS_EN" defaultValue=""/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮编</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_POST"  defaultValue=""/>	
						</td>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_TEL"  defaultValue="" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DEPT_FAX"  defaultValue="" />			
						</td>
						<td class="bz-edit-data-title">经办人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_NAME" style="width:90%;" defaultValue=""/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人姓名拼音</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_NAMEPY" style="width:90%;" defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">经办人性别</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人身份证号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_CARD" defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">经办人职务</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_JOB" style="width:90%;" defaultValue=""/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人联系电话</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_TEL" style="width:90%;" defaultValue=""/>						
						</td>
						<td class="bz-edit-data-title">经办人邮箱</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CONTACT_MAIL" style="width:90%;" defaultValue=""/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CONTACT_DESC" style="width:90%;"  defaultValue=""/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="STATE" onlyValue="true" checkValue="0=撤销;1=有效;9=暂停;" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">暂停人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PAUSE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">暂停日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">撤销人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CANCLE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">撤销日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CANCLE_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">登记人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CANCLE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">登记日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">最后修改人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="MODIFY_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">最后修改日期</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="MODIFY_DATE" onlyValue="true" defaultValue=''/>						
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div> --%>
		</div>
	</div>
	<!-- 审核信息end -->
	
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_save();"/>
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
