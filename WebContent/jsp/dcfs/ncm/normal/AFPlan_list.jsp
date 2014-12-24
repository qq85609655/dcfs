<%
/**   
 * @Title: AFPlan_list.jsp
 * @Description: 正常儿童预分配计划表
 * @author xugy   
 * @date 2014-9-3下午3:14:37
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
DataList AFdl = (DataList)request.getAttribute("AFdl");
int i=0;
if(AFdl.size()>0){
    i=AFdl.size();
}
%>
<BZ:html>
	<BZ:head>
		<title>正常儿童预分配计划表</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
	</BZ:head>
	<script>
	$(document).ready(function() {
		dyniframesize(['planListFrame']);
		_scroll(1500,1500);
	});
	//导出excel
	function _export(){
		document.srcForm.action=path+"mormalMatch/exportExcel.action";
		document.srcForm.submit();
	}
	//关闭弹出页
	function _close(){
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
	</script>
</BZ:html>
<BZ:body property="Data" codeNames="WJLX_DL">
	<BZ:form name="srcForm" method="post" token="">
		<BZ:input type="hidden" prefix="E_" field="COUNT_DATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="E_" field="DATE_START" defaultValue=""/>
		<BZ:input type="hidden" prefix="E_" field="DATE_END" defaultValue=""/>
		<BZ:input type="hidden" prefix="E_" field="FILE_TYPE" defaultValue=""/>
		<div class="bz-action-frame">
			<div class="bz-action" desc="按钮区" style="text-align: left;">
				<input type="button" value="导出" class="btn btn-sm btn-primary" onclick="_export()" />
				<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="_close()" />
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<div class="ui-state-default bz-edit-title" style="border: 1px #DDDDDD solid;">
						<div><font color="#669FC7">正常儿童预分配计划表</font></div>
					</div>
					<div style="padding-left: 10px;">
	            		<table>
	            			<tr style="height: 40px;">
	            				<td>
	            					制表基准：<BZ:dataValue field="COUNT_DATE" defaultValue="" checkValue="REG_DATE=收文登记日期;RECEIVER_DATE=文件交接日期;"/>
	            				</td>
	            			</tr>
	            			<tr style="height: 40px;">
	            				<td>
	            					制表区间：<BZ:dataValue field="DATE_START" defaultValue="" />~<BZ:dataValue field="DATE_END" defaultValue="" />
	            				</td>
	            			</tr>
	            			<tr style="height: 40px;">
	            				<td>
	            					制表对象：<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX_DL" />文件
	            				</td>
	            			</tr>
	            		</table>
					</div>
					<div style="overflow-x:scroll;">
					<div id="scrollDiv">
					<table width="500" border="1" cellspacing="0" cellpadding="0" style="border-color:#DDDDDD;" class="table-infocontent">
	                	<thead>
		                	<tr style="height: 30px;" align="center">
			                    <th width="3%" bgcolor="#EFF3F8">序号</th>
			                    <th width="6%" bgcolor="#EFF3F8">文件编号</th>
			                    <th width="6%" bgcolor="#EFF3F8">登记日期</th>
			                    <th width="4%" bgcolor="#EFF3F8">国家</th>
			                    <th width="14%" bgcolor="#EFF3F8">收养机构</th>
			                    <th width="11%" bgcolor="#EFF3F8">男收养人</th>
			                    <th width="6%" bgcolor="#EFF3F8">男方出生日期</th>
			                    <th width="11%" bgcolor="#EFF3F8">女收养人</th>
			                    <th width="6%" bgcolor="#EFF3F8">女方出生日期</th>
			                    <th width="7%" bgcolor="#EFF3F8">政府批准书日期</th>
			                    <th width="6%" bgcolor="#EFF3F8">到期日期</th>
			                    <th width="10%" bgcolor="#EFF3F8">子女情况</th>
			                    <th width="10%" bgcolor="#EFF3F8">收养要求</th>
		                	</tr>
	                	</thead>
	                	<tbody>
	                	<BZ:for property="AFdl">
		                  	<tr style="height: 30px;">
			                    <td><BZ:i/></td>
			                    <td><BZ:data field="FILE_NO" defaultValue=""/></td>
			                    <td><BZ:data field="REG_DATE" defaultValue="" type="date" /></td>
			                    <td><BZ:data field="COUNTRY_CN" defaultValue=""/></td>
			                    <td><BZ:data field="NAME_CN" defaultValue="" /></td>
			                    <td><BZ:data field="MALE_NAME" defaultValue=""/></td>
			                    <td><BZ:data field="MALE_BIRTHDAY" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
			                    <td><BZ:data field="FEMALE_BIRTHDAY" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="GOVERN_DATE" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="EXPIRE_DATE" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="CHILD_CONDITION_CN" defaultValue="" /></td>
			                    <td><BZ:data field="ADOPT_REQUEST_CN" defaultValue="" /></td>
		                  	</tr>
		                </BZ:for>
		                	<tr>
		                		<td colspan="13" style="height: 30px;">合计：共计<%=i %>份</td>
		                	</tr>
	                  	</tbody>
	                </table>
	                </div>
	                </div>
				</div>	
			</div>
		</div>
	</BZ:form>
</BZ:body>