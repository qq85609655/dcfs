<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_jh_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 
 //生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
 Data data= (Data)request.getAttribute("data");
 String plan_state = data.getString("PLAN_STATE");//计划状态
%>
<BZ:html>
	<BZ:head>
		<title>新增或修改计划基本信息页面</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		
		function _goback(){
			window.location.href=path+"sce/publishPlan/findListForFBJH.action";
		}
		
		//发布计划保存或提交  0：保存  1：提交
		function saveFBJHInfo(method){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"sce/publishPlan/saveFBJHBaseInfo.action?method="+method;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<BZ:input type="hidden" field="PLAN_ID" prefix="H_"/>
			
		<div class="page-content">
			<div class="wrapper">
				
				<!-- 编辑区域begin -->
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>发布计划基本信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>预告日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="DateTime" field="NOTE_DATE" prefix="J_"  formTitle="预告日期" notnull="请输入预告日期"/>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="DateTime" field="PUB_DATE" prefix="J_" formTitle="发布日期" notnull="请输入发布日期"/>
									</td>
									<td class="bz-edit-data-title" width="10%">制定人</td>
									<td class="bz-edit-data-value"   width="12%">
										<BZ:dataValue field="PLAN_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">制定日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PLAN_DATE" defaultValue="" onlyValue="true" type="Date"/>
									</td>
								</tr>
								
							</table>
						</div>
					</div>
				</div> 
				<!-- 编辑区域end -->
				<br/>
				
				
			
				<!-- 按钮区 开始 -->
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="按钮区">
					<%if("".equals(plan_state)||""==plan_state||"0".equals(plan_state)||"0"==plan_state||"null".equals(plan_state)||"null"==plan_state||null==plan_state){ %>
						<a href="reporter_files_list.html" >
							<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(0);"/>
						</a>
					<%} %>
						<a href="reporter_files_list.html" >
							<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(1);"/>
						</a>
						<a href="reporter_files_list.html" >
							<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback()"/>
						</a>
					</div>
				</div>
				<!-- 按钮区 结束 -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>