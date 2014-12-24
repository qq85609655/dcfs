<%
/**   
 * @Title: normalMatchPlanCount.jsp
 * @Description: 正常儿童预分配计划统计
 * @author xugy   
 * @date 2014-9-2下午7:23:56
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data Data = (Data)request.getAttribute("Data");
String FILE_TYPE = Data.getString("FILE_TYPE","");
String DATE_START = Data.getString("DATE_START","");
%>
<BZ:html>
	<BZ:head>
		<title>正常儿童预分配计划统计页面</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		//返回列表
		function _goback(){
			document.srcForm.action=path+"mormalMatch/normalMatchAFList.action";
			document.srcForm.submit();
		}
		//正常儿童预分配计划统计
		function _count(){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"mormalMatch/planCount.action";
			document.srcForm.submit();
		}
		//创建预分配表
		function _createYfpPlantable(){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			var COUNT_DATE = $("#C_COUNT_DATE").val();
			var FILE_TYPE = $("#C_FILE_TYPE").val();
			var DATE_START = $("#C_DATE_START").val();
			var DATE_END = $("#C_DATE_END").val();
			//alert(COUNT_DATE+","+FILE_TYPE+","+DATE_START+","+DATE_END);
			$.layer({
				type : 2,
				title : "正常儿童预分配计划表",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				//page : {dom : '#planList'},
				iframe: {src: '<BZ:url/>/mormalMatch/AFPlanList.action?COUNT_DATE='+COUNT_DATE+'&FILE_TYPE='+FILE_TYPE+'&DATE_START='+DATE_START+'&DATE_END='+DATE_END},
				area: ['1100px','600px'],
				offset: ['0px' , '0px']
			});
		}
	</script>
</BZ:html>
<BZ:body property="Data" codeNames="WJLX_DL;PROVINCE">
	<BZ:form name="srcForm" method="post" token="">
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="bz-edit-title" desc="标题">
				<div>设定匹配计划参数</div>
			</div>  
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"  style="border: 0;"><font color="red">*</font>统计基准</td>
							<td width="20%">
								<BZ:select prefix="C_" field="COUNT_DATE" id="C_COUNT_DATE" defaultValue="" formTitle="统计基准" notnull="请选择统计基准" width="170px">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="REG_DATE">收文登记日期</BZ:option>
									<BZ:option value="RECEIVER_DATE">文件交接日期</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"  style="border: 0;"><font color="red">*</font>文件类型</td>
							<td width="30%">
								<BZ:select prefix="C_" field="FILE_TYPE" id="C_FILE_TYPE" defaultValue="" formTitle="文件类型" isCode="true" codeName="WJLX_DL" width="170px" notnull="请选择文件类型">
									<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
							<td rowspan="2" align="center"><input type="button" value="统&nbsp;&nbsp;计" class="btn btn-sm btn-primary" onclick="_count()"/></td>
						</tr>
						<tr>
							<%-- <td class="bz-edit-data-title"  style="border: 0;"><font color="red">*</font>材料状态</td>
							<td>
								<BZ:select prefix="C_" field="FILE_STATE" id="R_FILE_STATE" defaultValue="" formTitle="材料状态" notnull="请选择材料状态" width="170px">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="AUD_STATE='9' and (MATCH_STATE='0' or MATCH_STATE is NULL)">审核通过</BZ:option>
									<BZ:option value="MATCH_STATE='0'">已接收</BZ:option>
								</BZ:select>
							</td> --%>
							<td class="bz-edit-data-title"  style="border: 0;"><font color="red">*</font>统计区间</td>
							<td colspan="3">
								<BZ:input prefix="C_" field="DATE_START" id="C_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始日期" notnull="请选择开始时间" />~
								<BZ:input prefix="C_" field="DATE_END" id="C_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止日期" notnull="请选择结束时间"/>
							</td>
						</tr>
					</table>
					<div class="ui-state-default bz-edit-title" style="border: 1px #DDDDDD solid;">
						<div><font color="#669FC7">正常儿童预分配计划统计</font></div>
					</div>
					<div style="padding-left: 10px;float: left;">
	            		<table>
	            			<tr style="height: 40px;">
	            				<td>
	            					统计基准： <BZ:dataValue field="COUNT_DATE" defaultValue="" onlyValue="true" checkValue="REG_DATE=收文登记日期;RECEIVER_DATE=文件交接日期;"/>
	            				</td>
	            			</tr>
	            			<tr style="height: 40px;">
	            				<td>
	            					统计区间：
					                	<%
					                	if(!"".equals(FILE_TYPE)){
					                	%>
					                	<BZ:dataValue field="DATE_START" defaultValue="" onlyValue="true" />~<BZ:dataValue field="DATE_END" defaultValue="" onlyValue="true" />
					                	<%
					                	}
					                	%>
	            				</td>
	            			</tr>
	            			<tr style="height: 40px;">
	            				<td>
	            					统计对象：
					                	<%
					                	if(!"".equals(DATE_START)){
					                	%>
					                	<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX_DL" />文件
					                	<%
					                	}
					                	%>
	            				</td>
	            			</tr>
	            		</table>
					</div>
					<table class="bz-edit-data-table">
	                	<tr>
		                    <td class="bz-edit-data-title" width="33%" style="text-align: center;">序号</td>
		                    <td class="bz-edit-data-title" width="34%" style="text-align: center;">省份</td>
		                    <td class="bz-edit-data-title" width="33%" style="text-align: center;">总数</td>
	                	</tr>
	                	<BZ:for property="CIdl">
		                  	<tr style="height: 30px;">
			                    <td class="bz-edit-data-value"><BZ:i/></td>
			                    <td class="bz-edit-data-value"><BZ:data field="CODENAME" defaultValue="" onlyValue="true"/></td>
			                    <td class="bz-edit-data-value"><BZ:data field="CI_PROVINCE_COUNT" defaultValue="" onlyValue="true" /></td>
		                  	</tr>
		                </BZ:for>
		                	<tr style="height: 30px;">
			                    <td class="bz-edit-data-value" colspan="2">正常儿童材料数量合计</td>
			                    <td class="bz-edit-data-value"><BZ:dataValue field="CI_COUNT" defaultValue="" onlyValue="true" /></td>
		                  	</tr>
		                	<tr style="height: 30px;">
			                    <td class="bz-edit-data-value" colspan="2">收养人文件数量合计</td>
			                    <td class="bz-edit-data-value"><BZ:dataValue field="AF_COUNT" defaultValue="" onlyValue="true" /></td>
		                  	</tr>
		                	<tr style="height: 30px;">
			                    <td class="bz-edit-data-value" colspan="2">剩余材料</td>
			                    <td class="bz-edit-data-value"><BZ:dataValue field="SURPLUS" defaultValue="" onlyValue="true" /></td>
		                  	</tr>
	                  	</tbody>
	                </table>
				</div>	
			</div>
		</div>
		<div class="bz-action-frame">
			<div class="bz-action" desc="按钮区" style="text-align:center;">
		        <input type="button" value="创建预分配表" class="btn btn-sm btn-primary" onclick="_createYfpPlantable()"/>
		        <input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()"/>
			</div>
		</div>
		<%-- <div id="planList">
			<iframe id="planListFrame" src="<BZ:url/>/mormalMatch/AFPlanList.action" width="100%" height="600px"></iframe>
		</div> --%>
	</BZ:form>
</BZ:body>