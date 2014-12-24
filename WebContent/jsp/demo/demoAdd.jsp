<%@page import="hx.code.Code"%>
<%@page import="hx.common.Constants"%>
<%@page import="java.util.HashMap"%>
<%@page import="hx.code.CodeList"%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	//添加、修改页面必须要给BZ：body  property属性指定Data对象
	Data data = (Data)request.getAttribute("data");
	if(data == null){
		data = new Data();
	}
	data.add("NAME", "李杰");
	data.add("SEX", "1");
	data.add("POST", "test2");
	data.add("TIME", "2014-6-25");
	data.add("ORG_ID", "f0efa755-073a-4f2c-a547-cf49e84f7da3");
	request.setAttribute("data", data);

	//演示使用的对象集合代码集
	HashMap<String, CodeList> positionMap = new HashMap<String, CodeList>();
	CodeList positionList = new CodeList();
	Code code1 = new Code();
	code1.setName("对象代码集1");
	code1.setValue("test1");
	code1.setParentValue("父级值1");
	positionList.add(code1);
	Code code2 = new Code();
	code2.setName("对象代码集2");
	code2.setValue("test2");
	code2.setParentValue("父级值2");
	positionList.add(code2);
	positionMap.put("positionList", positionList);
	request.setAttribute(Constants.CODE_LIST, positionMap);
%>
<BZ:html>
<BZ:head>
	<title>记者档案添加</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
</script>
<BZ:body codeNames="SEX" property="data">
	<BZ:form name="srcForm" method="post">
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action" desc="按钮区">
			<a href="reporter_files_list.html" >
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
			<input type="button" value="取消" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>
	</div>
	<!-- 按钮区 结束 -->

	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					记者档案添加
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">姓名:</td>
						<td class="bz-edit-data-value">
						<BZ:input field="NAME" prefix="P_" type="String" notnull="请输入姓名" formTitle="姓名" defaultValue="" />
						</td>
						<td class="bz-edit-data-title">性别：</td>
						<td class="bz-edit-data-value">
						<BZ:select field="SEX" prefix="P_" formTitle="" isCode="true" codeName="SEX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职务:</td>
						<td class="bz-edit-data-value">
						<BZ:select field="POST" formTitle="" prefix="P_" isCode="true" codeName="positionList" property="data"/>
						</td>
						<td class="bz-edit-data-title">所属组织：</td>
						<td class="bz-edit-data-value">
						<BZ:input field="ORG_ID" prefix="P_" helperCode="SYS_ORGAN" type="helper" helperTitle="选择所属组织" treeType="2" helperSync="true" property="data" showParent="false" style="width:100px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">日期:</td>
						<td class="bz-edit-data-value">
						<BZ:input field="TIME" prefix="P_" type="date"/>
						</td>
						<td class="bz-edit-data-title">详细日期：</td>
						<td class="bz-edit-data-value">
						<BZ:input field="DETAIL_TIME" prefix="P_" type="datetime"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">姓名:</td>
						<td class="bz-edit-data-value" colspan="3">
						<textarea style="height: 60px;width: 97%;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">附件:</td>
						<td class="bz-edit-data-value" colspan="3">
						<up:uploadBody
							attTypeCode="PUBLISH_IMAGE"
							id="att"
							name="P_ATT"
							packageId="22dcee42-eb5c-4b7b-9046-d64d61020c67"
							queueStyle="border: solid 1px #CCCCCC;width:97%"
							selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
							/>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
