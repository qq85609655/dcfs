<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String is_change_org = (String) request.getAttribute("is_change_org");
	String male_name = (String)request.getAttribute("male_name");
	String famale_name = (String)request.getAttribute("famale_name");
	String file_code = (String)request.getAttribute("file_code");
	System.out.println(is_change_org);
%>
<BZ:html>
<BZ:head>
	<title>文件登记信息查看</title>
	<BZ:webScript edit="true" tree="false"/>
	<up:uploadResource/>
	<script>
	/*function _goback(){
		window.history.go(-1);	
	}*/
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;FYLB;JFFS;SYZZ;WJWZ" property="wjdlData">
	<BZ:form name="srcForm" method="post">
	
	<BZ:input field="AF_ID" id="AF_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>文件基本信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">文件类型</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">收养类型</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" checkValue="1=双亲收养;2=单亲收养;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">国家</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title" width="20%">收养组织</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						
					</tr>
					<%
					if("1".equals(is_change_org)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">转组织</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="IS_CHANGE_ORG" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/>
						</td>
						<td class="bz-edit-data-title" width="20%">原收文编号</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%
					}
					%>
					<%
					if(!"".equals(male_name)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">男收养人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">出生日期（男）</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<%
					}
					if(!"".equals(famale_name)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">女收养人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">出生日期（女）</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<%
					}
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">文件位置</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">文件状态</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="REG_STATE" checkValue="1=未登记;2=待修改;3=已登记;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REG_REMARK" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					票据信息
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">费用类别</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">应缴金额</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">缴费方式</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">票面金额</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">缴费编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">缴费票号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">缴费日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">缴费凭据</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadList id="FILE_CODE" firstColWidth="20px" attTypeCode="OTHER" packageId='<%=file_code%>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">缴费备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<!-- <div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div> -->
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
