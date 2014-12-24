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
    Data temp = (Data)request.getAttribute("temp");
    String pro_code = (String)temp.getString("pro_code");
    String type = (String)temp.getString("type");
    String ID = (String)temp.getString("ID");
    
%>
<BZ:html>
<BZ:head>
	<title>福利机构信息修改</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
	});
	//提交福利机构信息
	function _save(){
		//经办人备注
		var desc = document.getElementById("MKR_CONTACT_DESC").value;
		if(desc==""){
			alert("请输入经办人备注信息");
			return false;
		}else{
			//if (_check(document.organForm)) {
				//页面表单校验
				document.organForm.action=path+"mkr/organSupp/welfareModifySubmit.action?pro_code=<%=pro_code%>&type=<%=type%>&ID=<%=ID%>";
		 		document.organForm.submit();
			//}
		}
    }
	//返回
	function _goback(){
		parent._goback();
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
					机构信息维护
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-value" rowspan="6">
							单位基本信息
						</td>
						<td class="bz-edit-data-title">中文名称</td>
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
							<BZ:input field="PRINCIPAL" defaultValue="" prefix="MKR_" maxlength="20" style="width:90%;"/>		
							<BZ:input field="INSTIT_ID" type="hidden" id="MKR_INSTIT_ID" defaultValue="" prefix="MKR_" />
							<BZ:input field="ID" type="hidden" id="MKR_ID" defaultValue="" prefix="MKR_" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="DEPT_ADDRESS_CN" defaultValue="" prefix="MKR_" maxlength="50" style="width:90%;"/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮编</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="DEPT_POST"  defaultValue=""  prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_TEL"  defaultValue="" restriction="telephone"  prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_FAX"  defaultValue=""  prefix="MKR_" />			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-value" rowspan="4">
							经办人
						</td>
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_NAME" style="width:90%;" notnull="请输入经办人姓名" defaultValue="" prefix="MKR_" maxlength="20"/>			
						</td>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="CONTACT_SEX" id="MKR_CONTACT_SEX" notnull="请选择经办人性别" width="100px" isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="性别" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">身份证件号</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_CARD" notnull="请输入经办人身份证号" style="width:90%;" restriction="number" defaultValue="" prefix="MKR_"/>						
						</td>
						<td class="bz-edit-data-title">职务</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_JOB" style="width:90%;" notnull="请输入经办人职务" maxlength="50" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">联系电话</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_TEL" style="width:90%;" notnull="请输入经办人联系电话" restriction="mobile" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">邮箱</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_MAIL" style="width:90%;" notnull="请输入经办人邮箱" restriction="email" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_CONTACT_DESC" id="MKR_CONTACT_DESC"  rows="4" cols="85%"><%=data.getString("CONTACT_DESC")!=null&&!"".equals(data.getString("CONTACT_DESC"))?data.getString("CONTACT_DESC"):""%></textarea>		
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
							<BZ:select disabled="true" field="PROVINCE_ID"  width="100px"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
							<BZ:input field="PROVINCE_ID" type="hidden" id="MKR_PROVINCE_ID" defaultValue="" prefix="MKR_" />
						</td>
						<td class="bz-edit-data-title">法人</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="PRINCIPAL" defaultValue="" prefix="MKR_" maxlength="20" style="width:90%;"/>		
							<BZ:input field="INSTIT_ID" type="hidden" id="MKR_INSTIT_ID" defaultValue="" prefix="MKR_" />
							<BZ:input field="ID" type="hidden" id="MKR_ID" defaultValue="" prefix="MKR_" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">登记地点(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CITY_ADDRESS_CN" style="width:90%;" notnull="请输入登记地点" maxlength="50" defaultValue="" prefix="MKR_" id="MKR_CITY_ADDRESS_CN"/>					
						</td>
						<td class="bz-edit-data-title">登记地点(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CITY_ADDRESS_EN" style="width:90%;" notnull="请输入登记地点" defaultValue="" prefix="MKR_" id="MKR_CITY_ADDRESS_EN"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">地址(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_ADDRESS_CN" defaultValue="" prefix="MKR_" maxlength="50" style="width:90%;"/>				
						</td>
						<td class="bz-edit-data-title">地址(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_ADDRESS_EN" defaultValue="" prefix="MKR_"  style="width:90%;"/>				
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮编</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_POST"  defaultValue=""  prefix="MKR_" />	
						</td>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="DEPT_TEL"  defaultValue="" restriction="telephone"  prefix="MKR_" />	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:input field="DEPT_FAX"  defaultValue=""  prefix="MKR_" />			
						</td>
						<td class="bz-edit-data-title">经办人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_NAME" style="width:90%;" notnull="请输入经办人姓名" defaultValue="" prefix="MKR_" maxlength="20"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人姓名拼音</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_NAMEPY" style="width:90%;" notnull="请输入经办人姓名拼音" defaultValue="" prefix="MKR_" maxlength="50"/>						
						</td>
						<td class="bz-edit-data-title">经办人性别</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="MKR_" field="CONTACT_SEX" id="MKR_CONTACT_SEX" notnull="请选择经办人性别" width="100px" isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="性别" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人身份证号</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_CARD" notnull="请输入经办人身份证号" style="width:90%;" restriction="number" defaultValue="" prefix="MKR_"/>						
						</td>
						<td class="bz-edit-data-title">经办人职务</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_JOB" style="width:90%;" notnull="请输入经办人职务" maxlength="50" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人联系电话</td>
						<td class="bz-edit-data-value">
							<BZ:input field="CONTACT_TEL" style="width:90%;" notnull="请输入经办人联系电话" restriction="mobile" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">经办人邮箱</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="CONTACT_MAIL" style="width:90%;" notnull="请输入经办人邮箱" restriction="email" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">经办人备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_CONTACT_DESC" id="MKR_CONTACT_DESC"  rows="4" cols="85%"><%=data.getString("CONTACT_DESC")!=null&&!"".equals(data.getString("CONTACT_DESC"))?data.getString("CONTACT_DESC"):""%></textarea>		
						</td>
					</tr>

					<!-- 
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
						<td class="bz-edit-data-title">暂停人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PAUSE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					 
					<tr>
						<td class="bz-edit-data-title">登记日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">登记人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CANCLE_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>

					<tr>
						<td class="bz-edit-data-title">最后修改日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MODIFY_DATE" onlyValue="true" defaultValue=''/>						
						</td>
						<td class="bz-edit-data-title">最后修改人姓名</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="MODIFY_USERNAME" onlyValue="true" defaultValue=''/>			
						</td>
					</tr>
					 
					<tr>
						<td class="bz-edit-data-title">状态</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="STATE" checkValue="0=撤销;1=有效;9=暂停;" onlyValue="true" defaultValue=''/>						
						</td>
					</tr>
					-->
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
