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
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    //����ID
    String id = (String)request.getAttribute("ID");
%>
<BZ:html>
<BZ:head>
	<title>����ά��</title>
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
    
    //����������
    function _save(){
    	//ҳ���У��
		/* if (!runFormVerify(document.srcFormForThreeLevel, false)) {
			return;
		} */
		document.organForm.action=path+"mkr/orgexpmgr/organModifySubmit.action";
 		document.organForm.submit();
    }
    
    //�������ύ
    function _submit(){
    	//ҳ���У��
		if (!runFormVerify(document.srcFormForThreeLevel, false)) {
			return;
		}
	 	document.srcFormForThreeLevel.action=path+"ffs/jbraudit/submitForThreeLevel.action?FLAG=";
	 	document.srcFormForThreeLevel.submit();
    	
    }
    
    //������𡢹�Լ���͡���˼�����������̬���������ģ������
	function _dyGetContent(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//������
		var gy_type = $('#P_IS_CONVENTION_ADOPT').val();//�Ƿ�Լ����
		if(null!=audit_option&&""!=audit_option){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.audit.OpinionTemAjax&method=getAuditModelContent&TYPE=00&AUDIT_TYPE=2&AUDIT_OPTION='+audit_option+'&GY_TYPE='+gy_type,
				type: 'POST',
				timeout:1000,
				dataType: 'json',
				success: function(data){
					$("#AUD_AUDIT_CONTENT_CN").val(data.AUDIT_MODEL_CONTENT);//������
				}
		  	  });
		}
	}
	
	//������������̬��ʾ��������
	function _dyShowArea(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//������
		if("3"==audit_option){//��ͨ��
			$("#twArea").show();
			$("#twArea2").show();
			$("#twArea3").show();
		}else {//����
			$("#twArea").hide();
			$("#twArea2").hide();
			$("#twArea3").hide();
		}
		//dyniframesize(['mainFrame']);
	}
		
	//��̬��ʾ����Ԥ��������Ϣ
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
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
			<li class='tab'><a href="<%=path %>/mkr/orgexpmgr/organModify.action?ID=<%=id %>" data-target="#tab1">��֯������Ϣ</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab2">��֧����</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab3">��������Ϣ</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab4">�ڻ���ϵ��</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab5">Ԯ���;�����Ŀ</a></li>
			<li class='tab'><a href="javaScript:void(0);" data-target="#tab6">�ڻ����нӴ�</a></li>
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
