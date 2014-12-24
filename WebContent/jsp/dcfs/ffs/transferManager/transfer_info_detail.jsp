<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:描述
 * @author xxx   
 * @date 2014-7-29 10:44:22
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
		document.srcForm.action = path + "transferinfo/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- 隐藏区域begin -->
		
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>查看</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					<td class="bz-edit-data-title" width="15%">交接单编号</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CONNECT_NO"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">份数</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="COPIES"  defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">移交人</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="TRANSFER_USERNAME"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">移交日期</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="TRANSFER_DATE"  defaultValue="" onlyValue="true" type="Date" dateFormat="yyyy-MM-dd"/>
</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">接收人</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="RECEIVER_USERNAME"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">接收时间</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="RECEIVER_DATE"  defaultValue="" onlyValue="true" type="Date" dateFormat="yyyy-MM-dd"/>
</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">移交状态</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="AT_STATE" codeName="JJDZT" defaultValue="" onlyValue="true"/>
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