<%
/**   
 * @Title: fileProgress_view.jsp
 * @Description:  �ļ����Ȳ鿴
 * @author yangrt   
 * @date 2014-09-03 11:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String af_id = (String)request.getAttribute("AF_ID");
	String riFlag = (String)request.getAttribute("riTab");
	String ciFlag = (String)request.getAttribute("ciTab");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�ļ����Ȳ鿴</title>
		<BZ:webScript edit="true" list="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			var riflag = "<%=riFlag %>";
			var ciflag = "<%=ciFlag %>";
			if(riflag == "false" && ciflag == "false"){
				$("#TabButton").hide();
			}else{
				if(riflag == "false"){
					$("#act2").hide();
				}else if(ciflag == "false"){
					$("#act3").hide();
				}
			}
		});
		
		function change(flag){
			var ci_id = $("#R_CI_ID").val();
			var ri_id = $("#R_RI_ID").val();
			if(flag==1){
				document.getElementById("iframe").src=path+"/ffs/filemanager/GetAdoptionPersonInfo.action?Flag=EN&type=show&AF_ID=<%=af_id %>";
				document.getElementById("act1").className="active";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
			}	
			if(flag==2){
				document.getElementById("iframe").src=path+"/ffs/filemanager/getReqDataList.action?RI_ID=" + ri_id;
				document.getElementById("act1").className="";
				document.getElementById("act2").className="active";
				document.getElementById("act3").className="";
			}
			if(flag==3){
				document.getElementById("iframe").src=path+"ffs/filemanager/ChildDataShow.action?ci_id=" + ci_id + "&RI_ID=" + ri_id;
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
			}
		}
		
		//�����б�ҳ
		function _goback(){
			window.location.href=path+'ffs/filemanager/FileProgressList.action';
		}
	</script>
	<BZ:body property="data">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<!-- ��������end -->
		<!-- Tab��ǩҳbegin -->
		<div class="widget-header" id="TabButton">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">�����˻�����Ϣ(Information about the adoptive parents)</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">Ԥ��������Ϣ</a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">������ͯ������Ϣ</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- Tab��ǩҳend -->
		<!-- iframe��ʾ����begin -->
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto" id="iframepage">
			<iframe id="iframe" scrolling="no" src="<%=path %>/ffs/filemanager/GetAdoptionPersonInfo.action?Flag=EN&type=show&AF_ID=<%=af_id %>" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		<!-- iframe��ʾ����end -->
		<!-- ��ť����Start -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>