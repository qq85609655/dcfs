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
    String ID = data.getString("ADOPT_ORG_ID","");  //组织机构ID
%>
<BZ:html>
<BZ:head>
	<title>联系人维护</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['iframeC','iframe','mainFrame']);//公共功能，框架元素自适应
	});
	//提交联系人信息
	function _save(){
		if (_check(document.organForm)) {
	    	//页面表单校验
			document.organForm.action=path+"mkr/organSupp/linkManModifySubmitEn.action";
	 		document.organForm.submit();
		}
    }
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX;GJ;ADOPTER_EDU;CARD_CODE;">
	<BZ:form name="organForm" method="post" token="<%=token %>">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 审核信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					联系人信息English
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
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
						<td class="bz-edit-data-title">姓名</td>
						<td class="bz-edit-data-value">
							<BZ:input field="NAME" defaultValue="" prefix="MKR_" maxlength="20" notnull="请输入联系人姓名" style="width:90%;"/>		
							<BZ:input field="ADOPT_ORG_ID" id="MKR_ADOPT_ORG_ID" type="hidden" defaultValue="" prefix="MKR_" maxlength="20" />
						</td>
						<td class="bz-edit-data-title">性别</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" field="SEX" id="MKR_SEX" width="100px" isCode="true" notnull="请选择性别" codeName="ADOPTER_CHILDREN_SEX" formTitle="性别" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>				
						</td>
						<td colspan="2" rowspan="3">
							<up:uploadImage 
								attTypeCode="OTHER"
								id="MKR_PHOTO" 
								packageId='<%=data.getString("PHOTO") %>'
								name="MKR_PHOTO" 
								imageStyle="width:100px;height:100px;"
								autoUpload="true"
								hiddenSelectTitle="true"
								hiddenProcess="false"
								hiddenList="true"
								selectAreaStyle="border:0;width:100px;"
								proContainerStyle="width:100px;line-height:0px;"
								/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">出生日期</td>
						<td class="bz-edit-data-value">
							<BZ:input field="BIRTHDAY" type="date" defaultValue="" style="width:100px;" prefix="MKR_" notnull="请输入出生日期" />	
							<BZ:input field="ID" defaultValue="" id="MKR_ID" prefix="MKR_" type="hidden"/>
						</td>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_"  width="100px;"  field="COUNTRY_ID" id="MKR_COUNTRY_ID" isCode="true" codeName="GJ" formTitle="国家" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">身份证明种类</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" width="100px;" field="ID_TYPE" id="MKR_ID_TYPE" isCode="true" codeName="CARD_CODE" formTitle="身份证明种类" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>				
						</td>
						<td class="bz-edit-data-title">身份证明号码</td>
						<td class="bz-edit-data-value">
							<BZ:input field="ID_NUMBER" style="width:90%;" defaultValue="" prefix="MKR_" id="MKR_ID_NUMBER" restriction="number" maxlength="20"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">学历</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MKR_" width="100px;" field="EDUCATION" id="MKR_EDUCATION" isCode="true" codeName="ADOPTER_EDU" formTitle="学历" defaultValue="">
								<BZ:option value="">--请选择--</BZ:option>
							</BZ:select>				
						</td>
						<td class="bz-edit-data-title">所学专业</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="PROFESSIONAL" style="width:90%;" defaultValue="" prefix="MKR_" maxlength="20"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">毕业院校</td>
						<td class="bz-edit-data-value">
							<BZ:input field="SCHOOL" style="width:90%;" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">联系地址</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="ADDR" style="width:90%;" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value">
							<BZ:input field="TELEPHONE" style="width:90%;" defaultValue="" prefix="MKR_" restriction="telephone"/>						
						</td>
						<td class="bz-edit-data-title">手机</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="MOBEL" style="width:90%;" defaultValue="" prefix="MKR_" restriction="mobile"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:input field="FAX" style="width:90%;" defaultValue="" prefix="MKR_" maxlength="20"/>						
						</td>
						<td class="bz-edit-data-title">电子邮件</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="EMAIL" style="width:90%;" defaultValue="" prefix="MKR_" restriction="email"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否兼职</td>
						<td class="bz-edit-data-value">
							<BZ:select field="IS_TEMP_JOB" formTitle="" prefix="MKR_" width="100px;">
								<BZ:option value="">--请选择--</BZ:option>
								<BZ:option value="0">否</BZ:option>
								<BZ:option value="1">是</BZ:option>
							</BZ:select>						
						</td>
						<td class="bz-edit-data-title">工作单位</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="WORK_UNIT" style="width:90%;" defaultValue="" prefix="MKR_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">委托期限</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="COMMITMENT_BEGIN" style="width:100px;" type="date" id="MKR_COMMITMENT_BEGIN" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_COMMITMENT_END\\')}',readonly:true" defaultValue="" prefix="MKR_"/>
							~<BZ:input field="COMMITMENT_END"  style="width:100px;"  type="date" id="MKR_COMMITMENT_END"   dateExtend="minDate:'#F{$dp.$D(\\'MKR_COMMITMENT_BEGIN\\')}',readonly:true" defaultValue="" prefix="MKR_"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">委托事项</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_COMMITMENT_ITEM"  rows="4" cols="85%"><%=data.getString("COMMITMENT_ITEM")!=null&&!"".equals(data.getString("COMMITMENT_ITEM"))?data.getString("COMMITMENT_ITEM"):""%></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">个人简历</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_PER_RESUME"  rows="4" cols="85%"><%=data.getString("PER_RESUME")!=null&&!"".equals(data.getString("PER_RESUME"))?data.getString("PER_RESUME"):""%></textarea>		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea name="MKR_MEMO"  rows="4" cols="85%"><%=data.getString("MEMO")!=null&&!"".equals(data.getString("MEMO"))?data.getString("MEMO"):""%></textarea>		
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 审核信息end -->
	
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_save();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
