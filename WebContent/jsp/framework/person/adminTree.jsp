<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>管理员树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}

		//处理
		childFrame.location = "<%=request.getContextPath() %>/admin/adminList.action?ORGAN_ID="+id;
	}
	$(document).ready(function(){
		dyniframesize(['mainFrame']);
	});
	</script>
</BZ:head>
<BZ:body>
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
			<td width="25%" valign="top">
				<BZ:form name="srcForm" method="post">
					<!-- 修改栏目的标志位 -->
					<input type="hidden" name="treeDispatcher" value="adminTree" />
					<div class="kuangjia">
					<div class="list">
					<div class="heading">选择组织机构</div>
					<table width="100%">
						<tr>
							<td width="100%"><BZ:tree property="dataList" type="0"/></td>
						</tr>
					</table>
					</div>
					</div>
				</BZ:form>
			</td>
			<td width="75%" valign="top">
				<iframe id="childFrame" name="childFrame" src="<BZ:url/>/admin/adminList.action?ORGAN_ID=0" style="width: 100%;" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>