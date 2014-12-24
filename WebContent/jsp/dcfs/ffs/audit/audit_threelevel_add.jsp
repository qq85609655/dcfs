<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	Data filedata = (Data)request.getAttribute("filedata");
	String file_type = filedata.getString("FILE_TYPE");//�ļ�����
	Data auditdata = (Data)request.getAttribute("auditdata");
	Data jbrdata = (Data)request.getAttribute("jbrdata");
	String afId=filedata.getString("AF_ID");//�ļ�����
	String riId=filedata.getString("RI_ID");//Ԥ��ID
	String fileNo=filedata.getString("FILE_NO");//���ı��
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
	<title>��ͥ�ļ��ֹ���������</title>
	<BZ:webScript edit="true"/>
	<BZ:webScript list="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		setSigle();
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		$('#tab-container').easytabs();
		
	});
</script>



<BZ:body property="returnData" codeNames="GJSY;SYZZ;SYS_ADOPT_ORG_ALL;SYLX;WJLX;WJFGZRSP;TWCZFS_ALL">
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
		//if (!runFormVerify(document.srcFormForThreeLevel, false)) {
		//	return;
		//}
		
		getIframeFileInfo();
 		document.srcFormForThreeLevel.action=path+"ffs/jbraudit/saveForThreeLevel.action?FLAG=<%=flag %>";
 		document.srcFormForThreeLevel.submit();
    }
    
    //�������ύ
    function _submit(){
    	//ҳ���У��
		if (!runFormVerify(document.srcFormForThreeLevel, false)) {
			return;
		}
		
		getIframeFileInfo();
	 	document.srcFormForThreeLevel.action=path+"ffs/jbraudit/submitForThreeLevel.action?FLAG=<%=flag %>";
	 	document.srcFormForThreeLevel.submit();
    	
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
    		window.location.href=path+"ffs/jbraudit/findListForThreeLevel.action";
    	}
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
	
	var tempFlag=1;
	
	//add by kings
	function change(flag){
		if(tempFlag!=flag){
			document.all("iframe").style.height=document.body.scrollHeight; 
			if(flag==1){//��ʾ�ļ�����
				document.getElementById("iframe").src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=cn&oper=edit";
				document.getElementById("act1").className="active";
				document.getElementById("act6").className="";
				document.getElementById("act5").className="";
				document.getElementById("act4").className="";
				document.getElementById("act3").className="";
				document.getElementById("act2").className="";
				document.getElementById("act7").className="";
				
			}	
			if(flag==2){//��ʾ�ļ�Ӣ��
						
				document.getElementById("iframe").src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=en&oper=edit";
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
	
	
</script>
	<BZ:form name="srcFormForThreeLevel" method="post" token="<%=token %>" >
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
				<div style="display:;position:absolute;top:3px;right:25px;">
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
		 <iframe id="iframe" scrolling="no" src="<%=path%>/ffs/filemanager/GetFileInfo.action?AF_ID=<%=afId%>&show=cn&oper=edit" style="border:none; width:100%; overflow:hidden;text-align: center" frameborder="0" ></iframe>
		</div>
	</div>
	
	<!-- �����Ϣbegin -->
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
				<BZ:input type="hidden" prefix="P_" field="FILE_NO" defaultValue="<%=fileNo %>"/>
				<BZ:input type="hidden" prefix="P_" field="AA_ID" defaultValue="<%=aaId %>"/>
				<BZ:input type="hidden" prefix="P_" field="RI_ID" defaultValue="<%=riId %>"/>
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
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_USERNAME_JBR" onlyValue="true" defaultValue='<%=jbrdata.getString("AUDIT_USERNAME") %>' />					
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_DATE_JBR" type="date" onlyValue="true" defaultValue='<%=jbrdata.getDate("AUDIT_DATE") %>' />					
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title">����֤���</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="ACCEPTED_CARD" value="1" prefix="P_" formTitle="" defaultChecked="true"></BZ:radio>��ȫ
				    		<BZ:radio field="ACCEPTED_CARD" value="2" prefix="P_" formTitle=""></BZ:radio>����ȫ
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>�������</td>
						<td class="bz-edit-data-value">
							<BZ:select field="AUDIT_OPTION" formTitle="�������" prefix="AUD_" id="AUD_AUDIT_OPTION" codeName="WJFGZRSP" isCode="true" notnull="��ѡ���������" onchange="_dyGetContent();_dyShowArea();">
								<BZ:option value="" selected="true">-��ѡ��-</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value" colspan="3" style="height:70px">
							<BZ:dataValue field="AUDIT_CONTENT_CN_JBR" onlyValue="true" defaultValue='<%=jbrdata.getString("AUDIT_CONTENT_CN","")%>'/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" field="AUDIT_CONTENT_CN" id="AUD_AUDIT_CONTENT_CN" prefix="AUD_" maxlength="500"  style="width:92%;height:70px" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="AUDIT_USERNAME" defaultValue="<%=personName %>" prefix="AUD_" />					
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="AUDIT_DATE" defaultValue="<%=curDate %>" type="date" prefix="AUD_"/>			
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" field="AUDIT_REMARKS" id="AUD_AUDIT_REMARKS" prefix="AUD_" maxlength="500"  style="width:92%" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ����Ԥ������</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="IS_WARNING" value="0" prefix="BLM_" formTitle="" defaultChecked="true" onclick="_dyShowYjArea()"></BZ:radio>��
				    		<BZ:radio field="IS_WARNING" value="1" prefix="BLM_" formTitle="" onclick="_dyShowYjArea()"></BZ:radio>��
						</td>
						<td class="bz-edit-data-title" id="twArea" style="display:none">���Ĵ��÷�ʽ</td>
						<td class="bz-edit-data-value" id="twArea2" style="display:none">
							<BZ:select field="HANDLE_TYPE" formTitle="���Ĵ��÷�ʽ" prefix="RET_"  codeName="TWCZFS_ALL" isCode="true">
							</BZ:select>
						</td>
					</tr>
					<tr id="twArea3" style="display:none">
						<td class="bz-edit-data-title" >����ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" field="RETURN_REASON" id="AUD_AUDIT_REMARKS" prefix="P_" maxlength="500" defaultValue="" style="width:92%"/>
						</td>
					</tr>
					
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- �����Ϣend -->
	
	<!-- Ԥ��������Ϣbegin -->
	<div class="bz-edit clearfix" desc="�༭����" id="YJArea" style="display:none">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					����Ԥ��������Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
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
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME"  onlyValue="true"  defaultValue=""/>	
						</td>
						<td class="bz-edit-data-title">�г�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY"  onlyValue="true"  type="date"/>	
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME"  onlyValue="true" defaultValue=""/>				
						</td>
						<td class="bz-edit-data-title">Ů��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY"onlyValue="true"  type="date"/>						
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value" >
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY"  onlyValue="true"/>			
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADOPT_ORG_ID" codeName="SYS_ADOPT_ORG_ALL"   onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����Ԥ������ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input type="textarea" field="WARNING_CONTENT" id="BLM_WARNING_CONTENT" prefix="BLM_" maxlength="1000" defaultValue="" style="width:92%"/>
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
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_save();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback()"/>
			</a>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
