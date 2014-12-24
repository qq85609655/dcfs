<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	
	//����token��
	TokenProcessor processor=TokenProcessor.getInstance();
	String token=processor.getToken(request);
	
	//����ID
	String id = (String)request.getAttribute("ID");
%>
<BZ:html>
<BZ:head language="EN">
	<title>����ά��</title>
	<BZ:webScript edit="true"/>
</BZ:head>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	function change(flag){
		
		if(flag==1){
			document.getElementById("iframe").src=path+"mkr/orgexpmgr/organModify.action?ID=<%=id %>";
			document.getElementById("act7").className="";
			document.getElementById("act6").className="";
			document.getElementById("act5").className="";
			document.getElementById("act4").className="";
			document.getElementById("act3").className="";
			document.getElementById("act2").className="";
			document.getElementById("act1").className="active";
		}	
		if(flag==2){
		
			document.getElementById("iframe").src=path+"mkr/orgexpmgr/branchOrganList.action?ADOPT_ORG_ID=<%=id %>";
			document.getElementById("act2").className="active";
			document.getElementById("act1").className="";
			document.getElementById("act3").className="";
			document.getElementById("act4").className="";
			document.getElementById("act5").className="";
			document.getElementById("act6").className="";
			document.getElementById("act7").className="";
		}
		if(flag==3){
			document.getElementById("iframe").src=path+"mkr/orgexpmgr/headerModify.action?ID=<%=id %>";
			document.getElementById("act3").className="active";
			document.getElementById("act1").className="";
			document.getElementById("act2").className="";
			document.getElementById("act4").className="";
			document.getElementById("act5").className="";
			document.getElementById("act6").className="";
			document.getElementById("act7").className="";
		}
		if(flag==4){
			document.getElementById("iframe").src=path+"mkr/organSupp/linkManOrganList.action?ID=<%=id %>";
			document.getElementById("act4").className="active";
			document.getElementById("act1").className="";
			document.getElementById("act2").className="";
			document.getElementById("act3").className="";
			document.getElementById("act5").className="";
			document.getElementById("act6").className="";
			document.getElementById("act7").className="";
		}
		if(flag==5){
			document.getElementById("iframe").src=path+"mkr/organSupp/aidProjectOrganList.action?ID=<%=id %>";
			document.getElementById("act5").className="active";
			document.getElementById("act1").className="";
			document.getElementById("act2").className="";
			document.getElementById("act3").className="";
			document.getElementById("act4").className="";
			document.getElementById("act6").className="";
			document.getElementById("act7").className="";
		}
		if(flag==6){
			document.getElementById("iframe").src=path+"mkr/organSupp/receptionOrganList.action?ID=<%=id %>";
			document.getElementById("act6").className="active";
			document.getElementById("act1").className="";
			document.getElementById("act2").className="";
			document.getElementById("act3").className="";
			document.getElementById("act4").className="";
			document.getElementById("act5").className="";
			document.getElementById("act7").className="";
		}
		if(flag==7){
			document.getElementById("iframe").src=path+"mkr/organSupp/organUpdateList.action?ID=<%=id %>";
			document.getElementById("act7").className="active";
			document.getElementById("act1").className="";
			document.getElementById("act2").className="";
			document.getElementById("act3").className="";
			document.getElementById("act4").className="";
			document.getElementById("act5").className="";
			document.getElementById("act6").className="";
		}
	}
</script>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		
		<!-- ��������end -->
		<div class="page-content">
			<div class="wrapper clearfix">
			<div class="widget-header" style="height:75px;">
					<div class="widget-toolbar">
						<ul class="nav nav-tabs" id="recent-tab">
							<li id="act1" class="active"> 
								<a href="javascript:change(1);">��֯������Ϣ(Agency information)</a>
							</li>
							<li id="act2" class="active" >
								<a href="javascript:change(2);">��֧����(Branch)</a>
							</li>
							<li id="act3" class="active">
								<a href="javascript:change(3);">��������Ϣ(Information of the person in charge)</a>
							</li>
							<li id="act4" class="active">
								<a href="javascript:change(4);">�ڻ���ϵ��(Contact person in China)</a>
							</li>
							<li id="act5" class="active">
								<a href="javascript:change(5);">Ԯ���;�����Ŀ��Ϣ(Sponsorship program information)</a>
							</li>
							<li id="act6" class="active">
								<a href="javascript:change(6);">�ڻ����нӴ�(Tour reception in China)</a>
							</li>
							<li id="act7" class="active">
								<a href="javascript:change(7);">���¼�¼(Updated information)</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="widget-box no-margin" style=" width:100%; margin: 0 auto">
				 <iframe id="iframe" scrolling="no" src="<%=path %>/mkr/orgexpmgr/organModify.action?ID=<%=id %>" style="border:none; width:100%; overflow:hidden;  frameborder="0"></iframe>
				</div>
			</div>	
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>