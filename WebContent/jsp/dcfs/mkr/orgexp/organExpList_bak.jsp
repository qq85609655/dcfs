<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	String personName = SessionInfo.getCurUser().getPerson().getCName();
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    //数据ID
    String id = (String)request.getAttribute("ID");
%>
<BZ:html>
<BZ:head>
	<title>机构维护</title>
	<BZ:webScript edit="true" list="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		$('#tab-container').easytabs();
	});
</script>
<BZ:body>
<script type="text/javascript">	
	$(document).ready(function() {
		$('#tab-container').easytabs();
		_dyShowYjArea();
		_dyShowArea();
	});
    function _showInfo(){
    	$('#ggarea').show();
    	$('#img1').show();
    	$('#img2').hide();
    }
    
    function _hideInfo(){
    	$('#ggarea').hide();
    	$('#img1').hide();
    	$('#img2').show();
    }
    
    //审核意见保存
    function _save(){
    	//页面表单校验
		/* if (!runFormVerify(document.srcFormForThreeLevel, false)) {
			return;
		} */
		document.organForm.action=path+"mkr/orgexpmgr/organModifySubmit.action";
 		document.organForm.submit();
    }
    
    //审核意见提交
    function _submit(){
    	//页面表单校验
		if (!runFormVerify(document.srcFormForThreeLevel, false)) {
			return;
		}
	 	document.srcFormForThreeLevel.action=path+"ffs/jbraudit/submitForThreeLevel.action?FLAG=";
	 	document.srcFormForThreeLevel.submit();
    	
    }
    
    //根据类别、公约类型、审核级别、审核意见动态获得审核意见模板内容
	function _dyGetContent(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//审核意见
		var gy_type = $('#P_IS_CONVENTION_ADOPT').val();//是否公约收养
		if(null!=audit_option&&""!=audit_option){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.audit.OpinionTemAjax&method=getAuditModelContent&TYPE=00&AUDIT_TYPE=2&AUDIT_OPTION='+audit_option+'&GY_TYPE='+gy_type,
				type: 'POST',
				timeout:1000,
				dataType: 'json',
				success: function(data){
					$("#AUD_AUDIT_CONTENT_CN").val(data.AUDIT_MODEL_CONTENT);//审核意见
				}
		  	  });
		}
	}
	
	//根据审核意见动态显示退文区域
	function _dyShowArea(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//审核意见
		if("3"==audit_option){//不通过
			$("#twArea").show();
			$("#twArea2").show();
			$("#twArea3").show();
		}else {//其他
			$("#twArea").hide();
			$("#twArea2").hide();
			$("#twArea3").hide();
		}
		//dyniframesize(['mainFrame']);
	}
		
	//动态显示加入预警区域信息
	function _dyShowYjArea(){
		var flag = $("input[name='BLM_IS_WARNING']:checked").val();
		if(flag=="0"){
			$("#YJArea").hide();
		}else{
			$("#YJArea").show();
		}
		//dyniframesize(['mainFrame']);
	}
</script>
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
			<li class='tab'><a href="<%=path %>/mkr/orgexpmgr/organModify.action?ID=<%=id %>" data-target="#tab1">组织基本信息</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab2">分支机构</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab3">负责人信息</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab4">在华联系人</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab5">援助和捐助项目</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab6">在华旅行接待</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1"></div>
			<div id="tab2"></div>
			<div id="tab3"></div>
			<div id="tab4"></div>
			<div id="tab5"></div>
			<div id="tab6"></div>
		</div>
	</div>
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
