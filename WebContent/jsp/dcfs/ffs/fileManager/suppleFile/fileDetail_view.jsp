<%
/**   
 * @Title: suppleQuery_view.jsp
 * @Description:  补充文件信息查看页面
 * @author yangrt   
 * @date 2014-9-5 下午14:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String af_id = (String)request.getAttribute("AF_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
	String type = (String)request.getAttribute("type");
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head language="CN">
		<title>补充文件信息查看页面</title>
		<BZ:webScript edit="true"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			var file_type = $("#R_FILE_TYPE").val();
			if(file_type == "20" || file_type == "21" || file_type == "22" || file_type == "23"){
				$("#act3").show();
			}else{
				$("#act3").hide();
			}
			$('#tab-container').easytabs();
		});
		
		//Tab页js
		function change(flag){
			act = flag;
			if(flag==1){
				document.getElementById("iframe").src=path+"/ffs/filemanager/GetFileDetail.action?type=CN&AF_ID=<%=af_id %>";
				document.getElementById("act1").className="active";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
			}	
			if(flag==2){
				document.getElementById("iframe").src=path+"/ffs/filemanager/GetFileDetail.action?type=EN&AF_ID=<%=af_id %>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="active";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
			}
			if(flag==3){
				document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreApproveAuditRecordsList.action?type=SHB&RI_ID=<%=ri_id %>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
				document.getElementById("act4").className="";
			}
			if(flag==4){
				document.getElementById("iframe").src=path+"/ffs/jbraudit/findAuditList.action?AF_ID=<%=af_id %>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="active";
			}
		}
		
		//返回列表页
		function _goback(){
			var flag = "<%=type %>";
			if(flag == "list"){
				window.location.href=path+"ffs/filemanager/SuppleQueryList.action?type=SHB";
			}else if(flag == "view"){
				var aa_id = $("#R_AA_ID").val();
				window.location.href=path+"ffs/filemanager/SuppleQueryShow.action?AA_ID=" + aa_id;
			}
			
		}
		
	</script>
	<BZ:body property="filedata" codeNames="WJLX;SYLX;">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="AA_ID" id="R_AA_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<!-- 隐藏区域end -->
		<div class="bz-edit clearfix" desc="编辑区域" >
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>
						文件概要信息
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="内容体" id="ggarea">
					<!-- 编辑区域 开始 -->
					<table class="bz-edit-data-table" border="0">
						<colgroup>
							<col width="10%" />
							<col width="15%" />
							<col width="10%" />
							<col width="15%" />
							<col width="10%" />
							<col width="15%" />
							<col width="10%" />
							<col width="15%" />
						</colgroup>
						<tr>
							<td class="bz-edit-data-title">收养组织(CN)</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">收养组织(EN)</td>
							<td class="bz-edit-data-value" colspan="7"> 
								<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">收文编号</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FILE_NO" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title">收文日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">收养类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">文件类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">是否公约收养</td>
							<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">是否预警名单</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_ALERT" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">是否转组织</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title"></td>
							<td class="bz-edit-data-value">
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">暂停状态</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_PAUSE" checkValue="0=未暂停;1=已暂停" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">暂停原因</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAUSE_REASON" defaultValue="" length="11"/>
							</td>
							<td class="bz-edit-data-title">退文状态</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="RETURN_STATE" checkValue="0=待确认;1=已确认;2=待处置;3=已处置" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">退文原因</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="RETURN_REASON" defaultValue=""  length="11"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">原收养组织</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title poptitle">之前收文编号</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">末次补充状态</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SUPPLY_STATE" checkValue="0=待补充;1=补充中;2=已补充" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">文件补充次数</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SUPPLY_NUM" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
					<!-- 编辑区域 结束 -->
				</div>
			</div>
		</div>
		<!-- Tab标签页begin -->
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">收养人基本信息(中)</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">收养人基本信息(外)</a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">预批审核记录</a>
					</li>
					<li id="act4" class="">
						<a href="javascript:change(4);">审核记录</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- Tab标签页end -->
		<!-- iframe显示区域begin -->
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto" id="iframepage">
			<iframe id="iframe" scrolling="no" src="<%=path %>/ffs/filemanager/GetFileDetail.action?type=CN&AF_ID=<%=af_id %>" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		<!-- iframe显示区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:body>
</BZ:html>