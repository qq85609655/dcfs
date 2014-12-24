<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	String path = request.getContextPath();
	Data filedata = (Data)request.getAttribute("filedata");
	String file_type = filedata.getString("FILE_TYPE");//�ļ�����
	Data auditdata = (Data)request.getAttribute("auditdata");
	String afId=filedata.getString("AF_ID");//�ļ�����
	String aaId=filedata.getString("AA_ID");//�ļ������¼����
	String auId=auditdata.getString("AU_ID");//�������
	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	String personName = SessionInfo.getCurUser().getPerson().getCName();
	String curDate = DateUtility.getCurrentDate();
	String flag = (String)request.getAttribute("FLAG");
	if(flag == null || flag.equals("null")){
		flag = "";
	}
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>��ͥ�ļ����������(�鿴ҳ��)</title>
	<BZ:webScript edit="true"/>
	<BZ:webScript list="true"/>
	<!-- link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" /-->
	<!--script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/-->
</BZ:head>

<BZ:body property="returnData" codeNames="SYLX;WJLX;WJJBRSH">
<script type="text/javascript">	
	$(document).ready(function() {
		setSigle();
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		
		//m by kins //$('#tab-container').easytabs();
		//m by kins //_dyShowHG();
		//m by kins //_dyShowArea();
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
    
    function _dyShowHG(){
   		var zhiliang = $("input[name='P_TRANSLATION_QUALITY']:checked").val();
    	if(zhiliang=='1'){//�ϸ�
    		$('#fanyibuhege').hide();
    		$("#P_UNQUALITIED_REASON").removeAttr("notnull");
    	}else{//���ϸ�
    		$('#fanyibuhege').show();
    		$("#P_UNQUALITIED_REASON").attr("notnull","�����뷭�벻�ϸ�ԭ��");
    	}
    }
    
    //����������
    function _save(){
    	
   		//ҳ���У��
		if (!runFormVerify(document.srcFormForOneLevel, false)) {
			return;
		}
		getIframeFileInfo();
		
    	var company_name=$("#P_TRANSLATION_COMPANY").find("option:selected").text();//��ȡ���뵥λSelectѡ���Text
 		var company_id=$("#P_TRANSLATION_COMPANY").val();  //��ȡ���뵥λSelectѡ���Value
 		$('#TRA_TRANSLATION_UNIT').val(company_id);
 		$('#TRA_TRANSLATION_UNITNAME').val(company_name);
 		document.srcFormForOneLevel.action=path+"ffs/jbraudit/saveForOneLevel.action?FLAG=<%=flag %>";
 		document.srcFormForOneLevel.submit();
    }
    
    //�������ύ
    function _submit(){
    	//ҳ���У��
		if (!runFormVerify(document.srcFormForOneLevel, false)) {
			return;
		}
		getIframeFileInfo();
    	var audit_option = $('#AUD_AUDIT_OPTION').val();//������
    	if(_checkCanSubmit(audit_option)){
    		var company_name=$("#P_TRANSLATION_COMPANY").find("option:selected").text();//��ȡ���뵥λSelectѡ���Text
	 		var company_id=$("#P_TRANSLATION_COMPANY").val();  //��ȡ���뵥λSelectѡ���Value
	 		$('#TRA_TRANSLATION_UNIT').val(company_id);
	 		$('#TRA_TRANSLATION_UNITNAME').val(company_name);
	 		document.srcFormForOneLevel.action=path+"ffs/jbraudit/submitForOneLevel.action?FLAG=<%=flag %>";
	 		document.srcFormForOneLevel.submit();
    	}
    	
    }
    
    function _goback(){
    	var flag = "<%=flag %>";
    	if(flag == "bf"){
    		window.location.href=path+"ffs/ffsaftranslation/adTranslationList.action";
    	}else if(flag == "cf"){
    		window.location.href=path+"ffs/ffsaftranslation/reTranslationList.action";
    	}else if(flag == "bc"){
    		window.location.href=path+"ffs/filemanager/SuppleQueryList.action";
    	}else{
    		window.location.href=path+"ffs/jbraudit/findListForOneLevel.action";
    	}
    }
    
    //������𡢹�Լ���͡���˼�����������̬���������ģ������
	function _dyGetContent(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//������
		var gy_type = $('#P_IS_CONVENTION_ADOPT').val();//�Ƿ�Լ����
		if(null!=audit_option&&""!=audit_option){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.audit.OpinionTemAjax&method=getAuditModelContent&TYPE=00&AUDIT_TYPE=0&AUDIT_OPTION='+audit_option+'&GY_TYPE='+gy_type,
				type: 'POST',
				timeout:1000,
				dataType: 'json',
				success: function(data){
					$("#AUD_AUDIT_CONTENT_CN").val(data.AUDIT_MODEL_CONTENT);//������
				}
		  	  });
		}
	}
	
	//������������̬��ʾ�����������
	function _dyShowArea(){
		var audit_option = $('#AUD_AUDIT_OPTION').val();//������
		if("4"==audit_option){//�����ļ�
			$("#WJBCArea").show();
			$("#WJBFArea").hide();
			$("#WJCFArea").hide();
		}else if("5"==audit_option){//�����ļ�����
			$("#WJBCArea").hide();
			$("#WJBFArea").show();
			$("#WJCFArea").hide();
		}else if("6"==audit_option){//�ط�
			$("#WJBCArea").hide();
			$("#WJBFArea").hide();
			$("#WJCFArea").show();
		}else{
			$("#WJBCArea").hide();
			$("#WJBFArea").hide();
			$("#WJCFArea").hide();
		}
	}
	
	//����Ƿ������ύ����
	function _checkCanSubmit(audit_option){
		var flag = true;
		var atranslation_state = $("#P_ATRANSLATION_STATE").val();//����״̬
		var rtranslation_state = $("#P_RTRANSLATION_STATE").val();//�ط�״̬
		var supply_state = $("#P_SUPPLY_STATE").val();//ĩ���ļ�����״̬
		var AA_ID = $("#P_AA_ID").val();//����ID
		
		if("4"==audit_option){//�����ļ�
			if("0"==supply_state||"1"==supply_state){//ĩ���ļ�״̬Ϊ"������"��"������"��
				alert("���ļ����ڲ����У�������ѡ����˽������");
				flag = false;
			}else if("0"==atranslation_state||"1"==atranslation_state){
				alert("���ļ����ڲ����У�������ѡ����˽������");
				flag = false;
			} else if("0"==rtranslation_state||"1"==rtranslation_state){
				alert("���ļ������ط��У�������ѡ����˽������");
				flag = false;
			}
		}else if("5"==audit_option){//����
			if(null==AA_ID||""==AA_ID){
				alert("�����ڲ����ļ���¼�����Ȳ����ļ���");
				flag = false;
			}else{
				if("0"==atranslation_state||"1"==atranslation_state){//����״̬Ϊ"������"��"������"��
					alert("���ļ����ڲ����У�������ѡ����˽������");
					flag = false;
				}else if("0"==rtranslation_state||"1"==rtranslation_state){
					alert("���ļ������ط��У�������ѡ����˽������");
					flag = false;
				}else if("0"==supply_state||"1"==supply_state){
					alert("���ļ����ڲ����У�������ѡ����˽������");
					flag = false;
				}
			}
			
		}else if("6"==audit_option){//�ط�
			if("0"==rtranslation_state||"1"==rtranslation_state){//�ط�״̬Ϊ"���ط�"��"�ط���"��
				alert("���ļ������ط��У�������ѡ����˽������");
				flag = false;
			}else if("0"==atranslation_state||"1"==atranslation_state){
				alert("���ļ����ڲ����У�������ѡ����˽������");
				flag = false;
			}else if("0"==supply_state||"1"==supply_state){
				alert("���ļ����ڲ����У�������ѡ����˽������");
				flag = false;
			}
		}
		
		return flag;
	}
	
	var tempFlag=1;
	
	//add by kings
	function change(flag){
		if(tempFlag!=flag){
			document.all("iframe").style.height=document.body.scrollHeight; 
			if(flag==1){//��ʾ�ļ�����
				document.getElementById("iframe").src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=cn&oper=view";
				document.getElementById("act1").className="active";
				document.getElementById("act6").className="";
				document.getElementById("act5").className="";
				document.getElementById("act4").className="";
				document.getElementById("act3").className="";
				document.getElementById("act2").className="";
				document.getElementById("act7").className="";
				
				
			}	
			if(flag==2){//��ʾ�ļ�Ӣ��
						
				document.getElementById("iframe").src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=en&oper=view";
				document.getElementById("act2").className="active";
				document.getElementById("act1").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==3){
				
						
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findAuditList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==4){
						
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findBcRecordList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="active";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==5){
						
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findReviseList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="active";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="";
			}
			if(flag==6){	
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findTranslationList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="active";
				document.getElementById("act7").className="";
			}
			if(flag==7){	
				document.getElementById("iframe").src="<%=path%>/ffs/jbraudit/findYpshAndEtInfoList.action?AF_ID=<%=afId%>";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				document.getElementById("act6").className="";
				document.getElementById("act7").className="active";
			}
			
			document.all("iframe").style.height=document.body.scrollHeight; 
			
			tempFlag=flag;
		}
		
}

	//����ļ�������Ϣ����Ӣ�ģ�iframeҳ���������ֶ�ֵ
	function getIframeFileInfo(){
		//var iframe = document.frames["iframe"];
		//var obj = iframe.document.forms["fileForm"];
		var obj = document.getElementById("iframe").contentWindow;
		 
		var filedNameArray=["FE_AF_ID","FE_ADOPTER_SEX","FE_MALE_NAME","FE_MALE_BIRTHDAY","FE_MALE_PHOTO","FE_MALE_NATION",
							"FE_MALE_PASSPORT_NO","FE_MALE_EDUCATION","FE_MALE_JOB_CN","FE_MALE_JOB_EN","FE_MALE_HEALTH",
							"FE_MALE_HEALTH_CONTENT_CN","FE_MALE_HEALTH_CONTENT_EN","FE_MEASUREMENT","FE_MALE_HEIGHT",
							"FE_MALE_WEIGHT","FE_MALE_BMI","FE_MALE_PUNISHMENT_FLAG","FE_MALE_PUNISHMENT_CN",
							"FE_MALE_PUNISHMENT_EN","FE_MALE_ILLEGALACT_FLAG","FE_MALE_ILLEGALACT_CN","FE_MALE_ILLEGALACT_EN",
							"FE_MALE_RELIGION_CN","FE_MALE_RELIGION_EN","FE_MALE_MARRY_TIMES","FE_MALE_YEAR_INCOME",
							"FE_FEMALE_NAME","FE_FEMALE_BIRTHDAY","FE_FEMALE_PHOTO","FE_FEMALE_NATION","FE_FEMALE_PASSPORT_NO",
							"FE_FEMALE_EDUCATION","FE_FEMALE_JOB_CN","FE_FEMALE_JOB_EN","FE_FEMALE_HEALTH","FE_FEMALE_HEALTH_CONTENT_CN",
							"FE_FEMALE_HEALTH_CONTENT_EN","FE_FEMALE_HEIGHT","FE_FEMALE_WEIGHT","FE_FEMALE_BMI","FE_FEMALE_PUNISHMENT_FLAG",
							"FE_FEMALE_PUNISHMENT_CN","FE_FEMALE_PUNISHMENT_EN","FE_FEMALE_ILLEGALACT_FLAG","FE_FEMALE_ILLEGALACT_CN",
							"FE_FEMALE_ILLEGALACT_EN","FE_FEMALE_RELIGION_CN","FE_FEMALE_RELIGION_EN","FE_FEMALE_MARRY_TIMES",
							"FE_FEMALE_YEAR_INCOME","FE_MARRY_CONDITION","FE_MARRY_DATE","FE_CONABITA_PARTNERS","FE_CONABITA_PARTNERS_TIME",
							"FE_GAY_STATEMENT","FE_CURRENCY","FE_TOTAL_ASSET","FE_TOTAL_DEBT","FE_CHILD_CONDITION_CN","FE_CHILD_CONDITION_EN",
							"FE_UNDERAGE_NUM","FE_ADDRESS","FE_ADOPT_REQUEST_CN","FE_ADOPT_REQUEST_EN","FE_FINISH_DATE",
							"FE_HOMESTUDY_ORG_NAME","FE_RECOMMENDATION_NUM","FE_HEART_REPORT","FE_IS_MEDICALRECOVERY",
							"FE_MEDICALRECOVERY_CN","FE_MEDICALRECOVERY_EN","FE_IS_FORMULATE","FE_ADOPT_PREPARE","FE_RISK_AWARENESS",
							"FE_IS_ABUSE_ABANDON","FE_IS_SUBMIT_REPORT","FE_IS_FAMILY_OTHERS_FLAG","FE_IS_FAMILY_OTHERS_CN",
							"FE_IS_FAMILY_OTHERS_EN","FE_ADOPT_MOTIVATION","FE_CHILDREN_ABOVE","FE_INTERVIEW_TIMES",
							"FE_PARENTING","FE_SOCIALWORKER","FE_REMARK_CN","FE_REMARK_EN","FE_GOVERN_DATE","FE_VALID_PERIOD",
							"FE_EXPIRE_DATE","FE_APPROVE_CHILD_NUM","FE_AGE_FLOOR","FE_AGE_UPPER","FE_CHILDREN_SEX","FE_CHILDREN_HEALTH_CN",
							"FE_CHILDREN_HEALTH_EN","FE_PACKAGE_ID","FE_PACKAGE_ID_CN","FE_IS_CONVENTION_ADOPT"];
		var hiddenStr ="";
		var i=0;
		var length=filedNameArray.length;
		
		for(i=0;i<length;i++){
			var filedId = filedNameArray[i];
			var tempObj = obj.document.getElementById(filedId);
			 //var tempObj = document.frames["iframe"].document.getElementById(filedId);
			
			
			if(tempObj!="null"&&tempObj!=null){
				var tempValue = tempObj.value;
				
				hiddenStr+=" <input type='hidden' name='"+filedId+"' id='"+filedId+"' value='"+tempValue+"'> ";
			}
		}
		
		
		$("#hiddenFormsDiv").append(hiddenStr);

	}
	
	function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
	
</script>
	<BZ:form name="srcFormForOneLevel" method="post" token="<%=token %>" >
	<div id="hiddenFormsDiv"></div>
	<!-- ���ڱ������ݽ����ʾ -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	
	
	<div class="bz-edit clearfix" desc="�༭����" >
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ļ���Ҫ��Ϣ
				</div>
				<div style="position:absolute;top:3px;right:25px;">
					<img id="img1" src="<%=path %>/resource/images/bs_blue_icons/caret-down.png"  width="10px" height="10px"  style="display:''" onclick="_hideInfo()"/>
					<img id="img2" src="<%=path %>/resource/images/bs_blue_icons/caret-left.png"  width="10px" height="10px" style="display:none" onclick="_showInfo()"/>
				</div>
				
			</div>
			<div class="bz-edit-data-content clearfix" desc="������" id="ggarea">
				<BZ:input type="hidden" field="ATRANSLATION_STATE" id="P_ATRANSLATION_STATE" prefix="P_"/><!-- ����״̬ -->
				<BZ:input type="hidden" field="RTRANSLATION_STATE" id="P_RTRANSLATION_STATE" prefix="P_"/><!-- �ط�״̬ -->
				<BZ:input type="hidden" field="SUPPLY_STATE" id="P_SUPPLY_STATE" prefix="P_"/><!-- ĩ���ļ�����״̬ -->
				<BZ:input type="hidden" field="IS_CONVENTION_ADOPT" id="P_IS_CONVENTION_ADOPT" prefix="P_"/><!-- �Ƿ�Լ���� -->
				<!-- �༭���� ��ʼ -->
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
						<td class="bz-edit-data-title">������֯(CN)</td>
						<td class="bz-edit-data-value" colspan="7">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������֯(EN)</td>
						<td class="bz-edit-data-value" colspan="7"> 
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���ı��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue=""  onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ�Լ����</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=��;1=��" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ƿ�Ԥ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_ALERT" checkValue="0=��;1=��" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ƿ�ת��֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=��;1=��" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value">
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͣ״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PAUSE" checkValue="0=δ��ͣ;1=����ͣ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��ͣԭ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_REASON" defaultValue="" length="11"/>
						</td>
						<td class="bz-edit-data-title">����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" checkValue="0=��ȷ��;1=��ȷ��;2=������;3=�Ѵ���" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue=""  length="11"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ԭ������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">֮ǰ���ı��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ĩ�β���״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_STATE" checkValue="0=������;1=������;2=�Ѳ���" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	
	<div class="bz-edit clearfix" desc="�༭����" >
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">������Ϣ(��)</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">������Ϣ(Ӣ)</a>
					</li>
					<%
						if(file_type=="20"||"20".equals(file_type)||file_type=="21"||"21".equals(file_type)||file_type=="22"||"22".equals(file_type)||file_type=="23"||"23".equals(file_type)){
					 %>
					<li id="act7" class="">
						<a href="javascript:change(7);">Ԥ�������Ϣ</a>
					</li>
					 <%} %>
					<li id="act7" class="" style="display:none">
						<a href="javascript:change(7);"></a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">��˼�¼</a>
					</li>
					<li id="act4" class="">
						<a href="javascript:change(4);">�����¼</a>
					</li>
					<li id="act5" class="">
						<a href="javascript:change(5);">�޸ļ�¼</a>
					</li>
					<li id="act6" class="">
						<a href="javascript:change(6);">�����¼</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto;">
			<iframe id="iframe" scrolling="no" src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=cn&oper=view" style="border:none; width:100%; overflow:hidden;text-align: center" frameborder="0" ></iframe>
		</div>
	</div>
	<!-- �����Ϣbegin -->
	<!-- 
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					������
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" prefix="AUD_" field="AU_ID" defaultValue="<%=auId %>"/>
				<BZ:input type="hidden" prefix="AUD_" field="AUDIT_USERID" defaultValue="<%=personId %>"/>
				<BZ:input type="hidden" prefix="TRA_" id="TRA_TRANSLATION_UNIT" field="TRANSLATION_UNIT"/>
				<BZ:input type="hidden" prefix="TRA_" id="TRA_TRANSLATION_UNITNAME" field="TRANSLATION_UNITNAME" />
				<BZ:input type="hidden" prefix="P_" field="AF_ID" defaultValue="<%=afId %>"/>
				<BZ:input type="hidden" prefix="P_" field="AA_ID" id="P_AA_ID" defaultValue="<%=aaId %>"/>
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">����֤���</td>
						<td class="bz-edit-data-value">
				    		<BZ:dataValue field="ACCEPTED_CARD" defaultValue="" onlyValue="true" checkValue="1=��ȫ;2=����ȫ"  />
						</td>
						<td class="bz-edit-data-title">���뵥λ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TRANSLATION_COMPANY" defaultValue="" onlyValue="true" checkValue="9151=��֮��;9221=����"  />
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TRANSLATION_QUALITY" defaultValue="" onlyValue="true" checkValue="1=�ϸ�;2=���ϸ�"  />
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">��˽��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" codeName="WJJBRSH"  />
						</td>
						<td class="bz-edit-data-title">�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>				
						</td>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr id="fanyibuhege" style="display:none">
						<td class="bz-edit-data-title"><font color="red">*</font>���벻�ϸ�ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="UNQUALITIED_REASON" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	 -->
	<!-- �����Ϣend -->
	<!-- �ļ�����֪ͨ��Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����" id="WJBCArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ļ�����֪ͨ��Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" field="SEND_USERID" prefix="ADD_" defaultShowValue="<%=personId %>"/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ������޸Ļ�����Ϣ</td>
						<td class="bz-edit-data-value">
				    		<BZ:dataValue field="IS_MODIFY" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
						<td class="bz-edit-data-title">�Ƿ������丽��</td>
						<td class="bz-edit-data-value">
				    		<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>	
						</td>
						<td class="bz-edit-data-title">����֪ͨ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true"/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����֪ͨ��������</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true"/>		
						</td>
					</tr>
					
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- �ļ�����֪ͨ��Ϣend -->
	
	<!-- �ļ�����֪ͨ��Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����" id="WJBFArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ļ�����֪ͨ��Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" field="NOTICE_USERID" prefix="TRA_"/>
				<BZ:input type="hidden" field="TRANSLATION_TYPE" prefix="TRA_" defaultValue="1"/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="AA_CONTENT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����֪ͨ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEND_USERNAME" defaultValue="" onlyValue="true"/>				
						</td>
						<td class="bz-edit-data-title">����֪ͨ����</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true"/>			
						</td>
					</tr>
					
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- �ļ�����֪ͨ��Ϣend -->
	
	<!-- �ļ��ط�֪ͨ��Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����" id="WJCFArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ļ��ط�֪ͨ��Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<BZ:input type="hidden" field="NOTICE_USERID" prefix="TRAN_"/>
				<BZ:input type="hidden" field="TRANSLATION_TYPE" prefix="TRAN_" defaultValue="2"/>
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">�ط�ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="AA_CONTENT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ط�֪ͨ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEND_USERNAME" defaultValue="" onlyValue="true"/>				
						</td>
						<td class="bz-edit-data-title">�ط�֪ͨ����</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true"/>		
						</td>
					</tr>
					
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- �ļ�����֪ͨ��Ϣend -->
	
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<a href="reporter_files_list.html" >
				<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="_close()"/>
			</a>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
