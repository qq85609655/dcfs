<%
/**   
 * @Title: preapproveapply_view.jsp
 * @Description:  预批申请信息查看页面
 * @author yangrt   
 * @date 2014-9-16 下午19:23:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String ri_id = (String)request.getAttribute("RI_ID");
	String af_id = (String)request.getAttribute("AF_ID");
	String flag = (String)request.getAttribute("Flag");
%>
<BZ:html>
	<BZ:head>
		<title>预批申请信息查看页面</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
		});
		
		 
		
		//Tab页js
		function change(flag){
			if(flag==1){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoEN&type=show";
				document.getElementById("act1").className="active";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#topinfo").show();
			}	
			if(flag==2){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=planEN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="active";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#topinfo").hide();
			}
			if(flag==3){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=planCN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#topinfo").hide();
			}
			if(flag==4){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=opinionEN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="active";
				document.getElementById("act5").className="";
				$("#topinfo").hide();
			}
			if(flag==5){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=opinionCN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="active";
				$("#topinfo").hide();
			}
		}
		
		//返回列表页
		function _goback(){
			window.close();
		}
	</script>
	<BZ:body property="applydata" codeNames="SYLX;WJLX;GJSY;SDFS;PROVINCE;ETXB;BCZL;">
		<!-- Tab标签页begin -->
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">收养人基本情况</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">抚育计划(外)</a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">抚育计划(中)</a>
					</li>
					<li id="act4" class="">
						<a href="javascript:change(4);">组织意见(外)</a>
					</li>
					<li id="act5" class="">
						<a href="javascript:change(5);">组织意见(中)</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- Tab标签页end -->
		<!-- 内容显示区域begin -->
		<%
		if(!"".equals(af_id)){
		%>
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%" id="topinfo">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">收养组织(CN)<br>Agency (CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">收养组织(EN)<br>Agency (EN)</td>
							<td class="bz-edit-data-value" colspan="3"> 
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">收文编号<br>Log-in No.</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FILE_NO" property="filedata" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="15%">收文日期<br>Log-in date</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="REGISTER_DATE" property="filedata" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">收养类型<br>Adoption type</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
							</td>
							<%-- <td class="bz-edit-data-title">文件类型<br>FILE TYPE</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
							</td> --%>
						</tr>
						<tr>
							<td class="bz-edit-data-title">锁定方式<br>Locking type</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="LOCK_MODE" codeName="SDFS" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">先前收文编号<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title">先前预备批申请编号<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<%-- <tr>
							<td class="bz-edit-data-title">撤消状态<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_STATE" checkValue="0=待确认;1=已确认;" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">撤销原因<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr> --%>
					</table>
				</div>
			</div>
		</div>
		<%} %>
		<!-- 内容显示区域end -->
		<!-- iframe显示区域begin -->
		<div class="widget-box no-margin">
			<iframe id="iframe" onload="adjustIFramesHeightOnLoad(this)" src="<%=path %>/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoEN&type=show" style="width:100%; height:px; frameborder="0"></iframe>
		</div>
		<!-- iframe显示区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:body>
</BZ:html>