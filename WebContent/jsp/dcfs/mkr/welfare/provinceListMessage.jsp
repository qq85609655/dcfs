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
	Data data = (Data)request.getAttribute("data");
	String pro_code = data.getString("pro_code","");//ʡ��
	String ID = data.getString("ID","");  //��������ID
	String type = data.getString("type","");
%>
<BZ:html>
<BZ:head>
	<title>����ά��</title>
	<BZ:webScript edit="true"/>
</BZ:head>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	function change(flag){
		if(flag==1){
			document.getElementById("iframe").src=path+"mkr/organSupp/toWelfareModif.action?ID=<%=ID%>&pro_code=<%=pro_code%>&type=<%=type%>";
			document.getElementById("act2").className="";
			document.getElementById("act1").className="active";
		}	
		/* if(flag==2){
			document.getElementById("iframe").src=path+"";
			document.getElementById("act2").className="active";
			document.getElementById("act1").className="";
		} */
	}
	//����
	function _goback(){
		document.srcForm.action=path+"mkr/organSupp/findWelfareList.action?ID=<%=pro_code%>";
 		document.srcForm.submit();
	}
</script>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		
		<!-- ��������end -->
		<div class="page-content">
			<div class="wrapper clearfix">
			<div class="widget-header">
					<div class="widget-toolbar">
						<ul class="nav nav-tabs" id="recent-tab">
							<li id="act1" class="active"> 
								<a href="javascript:change(1);">������Ϣά��</a>
							</li>
							<!-- <li id="act2" class="active" >
								<a href="javascript:change(2);">�˻���Ϣά��</a>
							</li> -->
						</ul>
					</div>
				</div>
				<div class="widget-box no-margin" style=" width:100%; margin: 0 auto">
				 <iframe id="iframe" scrolling="no" src="<%=path %>/mkr/organSupp/toWelfareModif.action?ID=<%=ID%>&pro_code=<%=pro_code%>&type=<%=type%>" style="border:none; width:100%; overflow:hidden;  frameborder="0"></iframe>
				</div>
			</div>	
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>