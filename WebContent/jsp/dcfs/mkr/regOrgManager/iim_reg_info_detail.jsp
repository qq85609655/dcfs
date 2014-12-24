<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:描述
 * @author xxx   
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
	<title>查看</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	//});
	
	function _goback(){
		document.srcForm.action = path + "/mkr/regOrgManager/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" codeNames="PROVINCE;SEX">
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		
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
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:dataValue field="PROVINCE_ID"  defaultValue="" codeName="PROVINCE" onlyValue="true"/>
						</td>
					</tr>
					<tr> 
					<td class="bz-edit-data-title" width="15%">机关名称</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="NAME_CN"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">英文名称</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="NAME_EN"  defaultValue="" onlyValue="true"/>
						</td>
					 </tr>
					 <tr>
					 <td class="bz-edit-data-title" width="15%">登记地点</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CITY_ADDRESS_CN"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">登记地点_英文</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CITY_ADDRESS_EN"  defaultValue="" onlyValue="true"/>
						</td>					
					 </tr>
					 <tr>					 
					<td class="bz-edit-data-title" width="15%">地址</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="DEPT_ADDRESS_CN"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">地址（英文）</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="DEPT_ADDRESS_EN"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					<tr>
						<td class="bz-edit-data-title" colspan="4" style="text-align:center"><b>收养登记经办人信息</b></td>
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">姓名</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_NAME"  defaultValue="" onlyValue="true"/>
						</td> 

					<td class="bz-edit-data-title" width="15%">姓名拼音</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_NAMEPY"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">性别</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_SEX" codeName="SEX" defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">身份证号</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_CARD"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">职务</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_JOB"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">联系电话</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONTACT_TEL"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">邮箱</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:dataValue field="CONTACT_MAIL"  defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">经办人_备注</td>
					<td class="bz-edit-data-value" width="18%" colspan="3">
						<BZ:dataValue field="CONTACT_DESC"  defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
				</table>
				</div>
			</div>
		</div>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>