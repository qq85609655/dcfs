<%
/**   
 * @Title: childinfo_view.jsp
 * @Description:  �����ͯ����-��ͯ��Ϣ�鿴
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String ci_id = (String)request.getAttribute("CI_ID");
	String pub_id = (String)request.getAttribute("PUB_ID");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ��Ϣ�鿴</title>
		<BZ:webScript edit="true"/>
		<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"></script>
		<script>
			$(document).ready(function() {
				setSigle();
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				//$('#tab-container').easytabs();
				
			});

			var tempFlag=1;
			function change(flag){
				if(tempFlag!=flag){
					document.all("iframe").style.height=document.body.scrollHeight; 
					if(flag==1){//��ʾ������Ϣ
						document.getElementById("iframe").src="<%=path%>/cms/childManager/showForAdoption.action?UUID=<%=ci_id%>";
						document.getElementById("act1").className="active";
						document.getElementById("act2").className="";
					}	
					if(flag==2){//��ʾ���¼�¼
						document.getElementById("iframe").src="<%=path%>/cms/childupdate/getShowDataByCIIDForAdoption.action?CI_ID=<%=ci_id%>";
						document.getElementById("act2").className="active";
						document.getElementById("act1").className="";
					}
					document.all("iframe").style.height=document.body.scrollHeight; 
					tempFlag=flag;
				}
		    } 
			function _goLock(){
				document.srcForm.action = path + "sce/lockchild/LockTypeSelect.action";
				document.srcForm.submit();
			}
			function _goBack(){
				document.srcForm.action = path + "sce/lockchild/LockChildList.action";
				document.srcForm.submit();
			}
		</script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" defaultValue=""/>		
		<!-- ��������end -->
		<div class="bz-edit clearfix" desc="�༭����" >
			<div class="widget-header">
				<div class="widget-toolbar">
					<ul class="nav nav-tabs" id="recent-tab">
						<li id="act1" class="active"> 
							<a href="javascript:change(1);">������Ϣ(Basic information)</a>
						</li>
						<li id="act2" class="">
							<a href="javascript:change(2);">���¼�¼(Updated information)</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="widget-box no-margin" style=" width:100%; margin: 0 auto;">
			 <iframe id="iframe" scrolling="no" src="<%=path%>/cms/childManager/showForAdoption.action?UUID=<%=ci_id%>" style="border:none; width:100%; overflow:hidden;text-align: center" frameborder="0" ></iframe>
			</div>
		</div>
		<!-- �༭����end -->
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Lock" class="btn btn-sm btn-primary" onclick="_goLock();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>