<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:附件小类查看
 * @author wangzheng
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
	<title>查看</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	//});
	
	function _goback(){
		document.srcForm.action = path + "attsmalltype/findList.action";
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
				<div>附件小类查看</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					 	<td class="bz-edit-data-title" width="15%">业务大类</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="BIG_TYPE"  defaultValue="" onlyValue="true" checkValue="CI=儿童材料;AF=家庭文件;AR=反馈报告;OTHER=其他"/>
						</td> 
						<td class="bz-edit-data-title" width="15%">附件小类编码</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CODE"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr> 
						<td class="bz-edit-data-title" width="15%">中文名称</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CNAME"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">英文名称</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ENAME"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">是否多附件</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ATT_MORE"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">附件大小</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ATT_SIZE"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">附件格式</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ATT_FORMAT"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">是否转成缩略图</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="IS_NAILS"  defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
						</td> 
					</tr>
					
					 <tr>
					<td class="bz-edit-data-title" width="15%">显示顺序</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="SEQ_NO"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">有效标识</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="IS_VALID"  defaultValue="" onlyValue="true" checkValue="0=无效;1=有效"/>
						</td> 
					 </tr>
					  <tr>
					<td class="bz-edit-data-title" width="15%">附件说明</td>
					<td class="bz-edit-data-value" colspan="3">
						<BZ:dataValue field="REMARKS"  defaultValue="" onlyValue="true"/>
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