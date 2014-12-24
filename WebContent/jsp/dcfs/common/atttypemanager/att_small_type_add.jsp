<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:描述
 * @author xxx   
 * @date 2014-10-27 9:38:04
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
			document.srcForm.action = path + "attsmalltype/save.action";
			document.srcForm.submit();
		  }
	}
	
	function _goback(){
		document.srcForm.action = path + "attsmalltype/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		<BZ:input prefix="P_" field="ID" type="hidden" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>附件小类信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					 	<td class="bz-edit-data-title" width="15%">业务大类</td>
						<td class="bz-edit-data-value" width="18%">
						
						<BZ:select prefix="P_" field="BIG_TYPE" id="P_BIG_TYPE" isCode="false" formTitle="业务大类" notnull="业务大类不能为空">
							<option value="">--请选择--</option>
							<BZ:option value="AF">家庭文件</BZ:option>
							<BZ:option value="CI">儿童材料</BZ:option>
							<BZ:option value="AR">反馈报告</BZ:option>
						</BZ:select>
						</td> 
						<td class="bz-edit-data-title" width="15%">附件小类编码</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CODE" id="P_CODE" defaultValue="" className="inputOne" formTitle="附件小类编码" restriction="hasSpecialChar" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">中文名称</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CNAME" id="P_CNAME" defaultValue="" className="inputOne" formTitle="中文名称" maxlength="200"/>
						</td> 
					 
						<td class="bz-edit-data-title" width="15%">英文名称</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ENAME" id="P_ENAME" defaultValue="" className="inputOne" formTitle="英文名称"  maxlength="200"/>
						</td> 
					</tr>
					 <tr>
						<td class="bz-edit-data-title" width="15%">是否多附件</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ATT_MORE" id="P_ATT_MORE" defaultValue="" className="inputOne" formTitle="是否多附件" maxlength="100"/>
						</td> 
					
					<td class="bz-edit-data-title" width="15%">附件大小</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ATT_SIZE" id="P_ATT_SIZE" defaultValue="" className="inputOne" formTitle="附件大小"  maxlength="10"/>
						</td> 
					 </tr>
					 <tr>
						<td class="bz-edit-data-title" width="15%">附件格式</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ATT_FORMAT" id="P_ATT_FORMAT" defaultValue="" className="inputOne" formTitle="附件格式" maxlength="1000"/>
						</td> 
					
					<td class="bz-edit-data-title" width="15%">是否转成缩略图</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:select prefix="P_" field="IS_NAILS" id="P_IS_NAILS" isCode="false" formTitle="是否转成缩略图" notnull="是否转成缩略图">
							<option value="">--请选择--</option>
							<BZ:option value="0">否</BZ:option>
							<BZ:option value="1">是</BZ:option>
						</BZ:select>
						
						</td> 
					 </tr>
					
					 <tr>
					<td class="bz-edit-data-title" width="15%">显示顺序</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="SEQ_NO" id="P_SEQ_NO" defaultValue="" className="inputOne" formTitle="显示顺序" restriction="hasSpecialChar" maxlength="10"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">有效标识</td>
					<td class="bz-edit-data-value" width="18%">
					
						<BZ:select prefix="P_" field="IS_VALID" id="P_IS_VALID" isCode="false" formTitle="有效标识" notnull="有效标识">
							<option value="">--请选择--</option>
							<BZ:option value="0">无效</BZ:option>
							<BZ:option value="1">有效</BZ:option>
						</BZ:select>
						</td> 
					 </tr>
					  <tr>
					<td class="bz-edit-data-title" width="15%">附件说明</td>
					<td colspan="3">
						<textarea name="P_REMARKS" id="P_REMARKS" rows="3" cols="100" maxlength="1000"><BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/></textarea>
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