<%
/**   
 * @Title: normalFile_add.jsp
 * @Description:  收养组织递交普通文件不同收养类型的跳转
 * @author yangrt   
 * @date 2014-7-22 上午4:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@	page import="hx.database.databean.Data"%>
<%@	page import="com.dcfs.ffs.common.FileCommonConstant"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String reg_state = (String)request.getAttribute("REG_STATE");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>递交普通文件加载添加页面</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			setSigle();
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			var file_id = $("#R_AF_ID").val();
			//如果有匹配的文件信息，则设置文件类型、收养类型不可编辑
			/* if(file_id != ""){
				$("#R_FILE_TYPE").attr("disabled",true);
				$("#R_FAMILY_TYPE").attr("disabled",true);
			} */
			//根据文件类型、收养类型加载不同的添加页面
			//var file_type = $("#R_FILE_TYPE").find("option:selected").val();
			var file_type = $("#R_FILE_TYPE").val();
			if(file_type == "33"){
				$("#R_FAMILY_TYPE")[0].selectedIndex = 1; 
				$("#R_FAMILY_TYPE").attr("disabled",true);
				//加载继子女收养文件添加页面
				$("#iframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=step&AF_ID=" + file_id);
			}else{
				//var family_type = $("#R_FAMILY_TYPE").find("option:selected").val();
				var family_type = $("#R_FAMILY_TYPE").val();
				if(family_type == "1"){
					//加载双亲收养添加页面
					$("#iframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=double&AF_ID=" + file_id);
				}else if(family_type == "2"){
					//加载单亲收养添加页面
					$("#iframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=single&AF_ID=" + file_id);
				}
			}
			
		});
		
		//根据文件类型加载添加页面
		function _dynamicJznsy(){
			var file_id = $("#R_AF_ID").val();
			var sylx = $("#R_FILE_TYPE").find("option:selected").val();
			if(sylx=="33"){
				//设置收养类型为双亲收养，并置灰
				$("#R_FAMILY_TYPE")[0].selectedIndex = 1; 
				$("#R_FAMILY_TYPE").attr("disabled",true);
				$("#addiframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=step&AF_ID=" + file_id);
			}else{
				$("#R_FAMILY_TYPE")[0].selectedIndex = 0; 
				$("#R_FAMILY_TYPE").attr("disabled",false);   
			}
		}
		
		//根据收养类型加载添加页面
		function _dynamicHide(){
			var file_id = $("#R_AF_ID").val();
			var optionText = $("#R_FAMILY_TYPE").find("option:selected").val();
			if(optionText=="2"){
				$("#addiframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=single&AF_ID=" + file_id);
			}else if(optionText=="1"){
				$("#addiframe").attr("src", path + "ffs/filemanager/NormalFileAdd.action?type=double&AF_ID=" + file_id);
			}
		}
		
		//返回递交普通文件列表页面
		function _goback(){
			document.srcForm.action = path+'ffs/filemanager/NormalFileList.action';
			document.srcForm.submit();
			//window.location.href=path+'ffs/filemanager/NormalFileList.action';
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="ZCWJLX;SYLX">
	<BZ:form name="srcForm" method="post">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" defaultValue=""/>
	<!-- 隐藏区域end -->
	<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" height="16px">收养组织(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">收养组织(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">文件类型<br>Document type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FILE_TYPE" codeName="ZCWJLX" isShowEN="true" defaultValue="" onlyValue="true"/>
								<%-- <BZ:select prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" formTitle="文件类型" isCode="true" codeName="ZCWJLX" notnull="请选择文件类型" onchange="_dynamicJznsy()" width="70%">
									<option value="">--请选择--</option>
								</BZ:select> --%>
							</td>
							<td class="bz-edit-data-title" width="20%">收养类型<br>Adoption type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" isShowEN="true" defaultValue="" onlyValue="true"/>
								<%-- <BZ:select prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" formTitle="收养类型" defaultValue="" isCode="true" codeName="SYLX" notnull="请选择收养类型" onchange="_dynamicHide()" width="70%">
									<option value="">--请选择--</option>
								</BZ:select> --%>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<%
			if(reg_state.equals(FileCommonConstant.DJZT_DXG)){
		%>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>退回信息</div>
				</div>
				<!-- 标题end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">退回日期<br>Return date</td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="REG_RETURN_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">退回原因<br>Reason for return </td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="REG_RETURN_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">退回说明<br>Note on return</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REG_RETURN_DESC" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<%	} %>
		<iframe  id="iframe" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" width="100%" ></iframe>
		<!-- 编辑区域end -->
		<!-- <br/>
		按钮区域begin
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="下一步" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		按钮区域end -->
	</BZ:form>
</BZ:body>