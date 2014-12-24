<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	Data childdata = (Data)request.getAttribute("childData");
	
	String af_id = (String)request.getAttribute("AF_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
	
	String hour = Long.toString((Long)request.getAttribute("hour"));
	String minute = Long.toString((Long)request.getAttribute("minute"));
	String second = Long.toString((Long)request.getAttribute("second"));
	String djsTime =hour+":"+minute+":"+second;
%>
<BZ:html>
	<BZ:head language="EN">
		<title>Ԥ�������޸�ҳ��</title>
		<BZ:webScript edit="true"/>
		<!--ʱ�ӵ���ʱ-->
		<link media="screen" rel="stylesheet" type="text/css" href="<%=path %>/resource/js/epiclock/stylesheet/jquery.epiclock.css"/>
		<link media="screen" rel="stylesheet" type="text/css" href="<%=path %>/resource/js/epiclock/renderers/retro/epiclock.retro.css"/>
		<link media="screen" rel="stylesheet" type="text/css" href="<%=path %>/resource/js/epiclock/renderers/retro-countdown/epiclock.retro-countdown.css"/>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/javascript/jquery.dateformat.min.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/javascript/jquery.epiclock.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/renderers/retro/epiclock.retro.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/epiclock/renderers/retro-countdown/epiclock.retro-countdown.js"></script>
		<!--ʱ�ӵ���ʱ-->
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
			var act = "<%=request.getAttribute("act") %>";
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				var lock_mode = $("#R_LOCK_MODE").val();
				var file_type = $("#R_FILE_TYPE").val();
				/* if(lock_mode == "1"){
					$("#topinfo").hide();
				}else{
					if(file_type == "20"){
						$("#topinfo").hide();
					}
				} */
				
				$("#TendingOpinionInfo").hide();
				
			});
			
			//Tabҳjs
			function change(flag){
				act = flag;
				if(flag==1){
					$("#iframepage").show();
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?Flag=infoEN&type=show&RI_ID=<%=ri_id %>";
					document.getElementById("act1").className="active";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					//$("#topinfo").show();
					$("#TendingOpinionInfo").hide();
				}	
				if(flag==2){
					document.getElementById("act1").className="";
					document.getElementById("act2").className="active";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					$("#iframepage").hide();
					//$("#topinfo").hide();
					$("#TendingOpinionInfo").show();
					$("#TendingENTitle").show();
					$("#TendingENInfo").show();
					$("#TendingCNTitle").hide();
					$("#TendingCNInfo").hide();
					$("#OpinionENTitle").hide();
					$("#OpinionENInfo").hide();
					$("#OpinionCNTitle").hide();
					$("#OpinionCNInfo").hide();
				}
				if(flag==3){
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="active";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					$("#iframepage").hide();
					//$("#topinfo").hide();
					$("#TendingOpinionInfo").show();
					$("#TendingENTitle").hide();
					$("#TendingENInfo").hide();
					$("#TendingCNTitle").show();
					$("#TendingCNInfo").show();
					$("#OpinionENTitle").hide();
					$("#OpinionENInfo").hide();
					$("#OpinionCNTitle").hide();
					$("#OpinionCNInfo").hide();
				}
				if(flag==4){
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="active";
					document.getElementById("act5").className="";
					$("#iframepage").hide();
					//$("#topinfo").hide();
					$("#TendingOpinionInfo").show();
					$("#TendingENTitle").hide();
					$("#TendingENInfo").hide();
					$("#TendingCNTitle").hide();
					$("#TendingCNInfo").hide();
					$("#OpinionENTitle").show();
					$("#OpinionENInfo").show();
					$("#OpinionCNTitle").hide();
					$("#OpinionCNInfo").hide();
				}
				if(flag==5){
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="active";
					$("#iframepage").hide();
					//$("#topinfo").hide();
					$("#TendingOpinionInfo").show();
					$("#TendingENTitle").hide();
					$("#TendingENInfo").hide();
					$("#TendingCNTitle").hide();
					$("#TendingCNInfo").hide();
					$("#OpinionENTitle").hide();
					$("#OpinionENInfo").hide();
					$("#OpinionCNTitle").show();
					$("#OpinionCNInfo").show();
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"sce/preapproveapply/PreApproveApplyList.action";
			}
			
			//����/�ύԤ������
			function _applySubmit(val){
				$("#R_RI_STATE").val(val);
				getIframeInfo();
				if(val == "0"){
					document.srcForm.action = path+"sce/preapproveapply/PreApproveApplySave.action?act=" + act;
					document.srcForm.submit();
				}else if(val == "1"){
					//ҳ���У��
					if (!runFormVerify(document.srcForm, false)) {
						return;
					}else{
						if(confirm("Are you sure you want to submit?")){
							document.srcForm.action = path+"sce/preapproveapply/PreApproveApplySave.action";
							document.srcForm.submit();
						}
					}
				}
			}
			
			//��ȡiframeҳ����Ϣ
			function getIframeInfo(){
				var obj = document.getElementById("iframe").contentWindow;
				var filedNameArray=["R_MALE_NAME","R_MALE_BIRTHDAY","R_MALE_PHOTO","R_MALE_NATION","R_MALE_PASSPORT_NO","R_MALE_EDUCATION","R_MALE_JOB_EN","R_MALE_HEALTH",
				    				"R_MALE_HEALTH_CONTENT_EN","R_MALE_PUNISHMENT_FLAG","R_MALE_PUNISHMENT_EN","R_MALE_ILLEGALACT_FLAG","R_MALE_ILLEGALACT_EN","R_MALE_MARRY_TIMES","R_MALE_YEAR_INCOME",
				    				"R_FEMALE_NAME","R_FEMALE_BIRTHDAY","R_FEMALE_PHOTO","R_FEMALE_NATION","R_FEMALE_PASSPORT_NO","R_FEMALE_EDUCATION","R_FEMALE_JOB_EN","R_FEMALE_HEALTH",
				    				"R_FEMALE_HEALTH_CONTENT_EN","R_FEMALE_PUNISHMENT_FLAG","R_FEMALE_PUNISHMENT_EN","R_FEMALE_ILLEGALACT_FLAG","R_FEMALE_ILLEGALACT_EN","R_FEMALE_MARRY_TIMES","R_FEMALE_YEAR_INCOME",
				    				"R_CURRENCY","R_MARRY_CONDITION","R_MARRY_DATE","R_TOTAL_ASSET","R_TOTAL_DEBT","R_UNDERAGE_NUM","R_CHILD_CONDITION_EN","R_ADDRESS","R_ADOPT_REQUEST_EN",
				    				"R_ADOPTER_SEX","R_CONABITA_PARTNERS","R_CONABITA_PARTNERS_TIME","R_GAY_STATEMENT","R_IS_FAMILY_OTHERS_FLAG","R_IS_FAMILY_OTHERS_EN","R_TENDING_EN","R_OPINION_EN","R_TENDING_CN","R_OPINION_CN"];
				//var filedNameArray=["R_ADOPTER_SEX"];
				var hiddenStr ="";
				var i=0;
				var length=filedNameArray.length;
				for(i=0;i<length;i++){
					var filedId = filedNameArray[i];
					var tempObj = obj.document.getElementById(filedId);
					if(tempObj!="null"&&tempObj!=null){
						var tempValue = tempObj.value;
						hiddenStr+=" <input type='hidden' name='"+filedId+"' id='"+filedId+"' value='"+tempValue+"'> ";
					}
				}
				$("#hiddenFormsDiv").append(hiddenStr);
			}
		</script>
	</BZ:head>
	<BZ:body property="applydata" codeNames="SYLX;WJLX;SDFS;GJSY;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#countdown-retro').epiclock({
					mode:$.epiclock.modes.countdown,
					offset:{
						days:<%=request.getAttribute("day")%>,
						hours:<%=request.getAttribute("hour")%>,
						minutes:<%=request.getAttribute("minute")%>,
						seconds:<%=request.getAttribute("second")%>
					},
					format:'V:x:i:s',
					renderer:'retro-countdown'
				});
			});
		</script>
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PRE_REQ_NO" id="R_PRE_REQ_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PUB_ID" id="R_PUB_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="RI_STATE" id="R_RI_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="LOCK_MODE" id="R_LOCK_MODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="DJSTIME" id="R_DJSTIME" defaultValue="<%=djsTime %>"/>
		<div id="hiddenFormsDiv"></div>
		<!-- ��������end -->
		<div class="page-content">
			<div class="wrapper clearfix">
				<!-- ����ʱ����begin -->
				<div align="center">
					<table >
						<tr>
							<td align="center" style="font-size:16px" nowrap>
								The deadline for submitting pre-approval applications is in&nbsp;&nbsp;<font color="red" size="5px"><%=request.getAttribute("day")%></font>&nbsp;&nbsp;days, 
							</td>
							<td id="jnkc" style="font-size:24px;color:red" nowrap> 
								<script>setInterval("timeview();",1000);</script>  
							</td>
							<td align="center" style="font-size:16px" nowrap>
								.The system will automatically cancel the application when it has expired. <font color="red" size="5px">&nbsp;</font>
							</td>
						</tr>
						
					</table>
				</div>
				<!-- ����ʱ����end -->
				<!-- Tab��ǩҳbegin -->
				<div class="widget-header">
					<div class="widget-toolbar">
						<ul class="nav nav-tabs" id="recent-tab">
							<li id="act1" class="active"> 
								<a href="javascript:change(1);">�����˻������(Adopter basic information)</a>
							</li>
							<li id="act2" class="">
								<a href="javascript:change(2);">�����ƻ�(Care plan (English))</a>
							</li>
							<li id="act3" class="">
								<a href="javascript:change(3);">�����ƻ�(Care plan (Chinese))</a>
							</li>
							<li id="act4" class="">
								<a href="javascript:change(4);">��֯���(Agency comments (English))</a>
							</li>
							<li id="act5" class="">
								<a href="javascript:change(5);">��֯���(Agency comments (Chinese))</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- Tab��ǩҳend -->
				<!-- ������ʾ����begin -->
				<%-- <div class="bz-edit clearfix" desc="�༭����" style="width: 100%" id="topinfo">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title">������֯(CN)<br>Agency (CN)</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">������֯(EN)<br>Agency (EN)</td>
									<td class="bz-edit-data-value" colspan="3"> 
										<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="20%">��������<br>Adoption type</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="20%">�ļ�����<br>FILE TYPE</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">������ʽ<br></td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:dataValue field="LOCK_MODE" codeName="SDFS" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">��ǰ���ı��<br></td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
									</td>
									
									<td class="bz-edit-data-title" width="20%">��ǰ��������<br>Log-in date</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:dataValue field="REGISTER_DATE" property="filedata" defaultValue="" type="date" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">��ǰԤ��������<br></td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">��ǰ����״̬<br></td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="REVOKE_STATE" checkValue="0=��ȷ��;1=��ȷ��;" defaultValue="" onlyValue="true"/>
									</td>
								
									<td class="bz-edit-data-title">����ԭ��<br></td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="REVOKE_REASON" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> --%>
				<div class="bz-edit clearfix" desc="�༭����" id="TendingOpinionInfo">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div id="TendingENTitle">�����ͯ-�����ƻ�(SN child-Care plan)</div>
							<div id="TendingCNTitle">�����ͯ-�����ƻ�(SN child-Care plan)</div>
							<div id="OpinionENTitle">�����ͯ-��֯���(SN child-Agency comments)</div>
							<div id="OpinionCNTitle">�����ͯ-��֯���(SN child-Agency comments)</div>
						</div>
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%" height="16px">ʡ��<br>Provincial Civil Affairs Department</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" defaultValue='<%=childdata.getString("PROVINCE_ID","") %>' onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">����Ժ<br>SWI</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="WELFARE_NAME_EN" defaultValue='<%=childdata.getString("WELFARE_NAME_EN","") %>' onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">��ͯ����<br>Child name</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="NAME_PINYIN" defaultValue='<%=childdata.getString("NAME_PINYIN","") %>' onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�Ա�<br>Sex</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" defaultValue='<%=childdata.getString("SEX","") %>' onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">��������<br>D.O.B</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue='<%=childdata.getString("BIRTHDAY","").substring(0, 10) %>' onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">��������<br>SN type</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SN_TYPE" codeName="BCZL" isShowEN="true" defaultValue='<%=childdata.getString("SN_TYPE","") %>' onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">�������<br>Diagnosis</td>
									<td class="bz-edit-data-value" colspan="7">
										<BZ:dataValue field="DISEASE_EN" defaultValue='<%=childdata.getString("DISEASE_EN","") %>' onlyValue="true"/>
									</td>
								</tr>
								<BZ:for property="childList" fordata="childData">
								<tr>
									<td class="bz-edit-data-title" width="10%">��ͯ����<br>Name</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="NAME_PINYIN" property="childData" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�Ա�<br>Sex</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SEX" property="childData" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">��������<br>D.O.B</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">��������<br>SN type</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SN_TYPE" property="childData" codeName="BCZL" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">�������<br>Diagnosis</td>
									<td class="bz-edit-data-value" colspan="7">
										<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								</BZ:for>
								<tr id="TendingENInfo">
									<td class="bz-edit-data-value" colspan="8">
										ҽ�ƿ����������ƻ���Ӣ�ģ�<br>Medical rehabilitation and care plan (English)<br><br>
										<BZ:input prefix="R_" field="TENDING_EN" id="R_TENDING_EN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
									</td>
								</tr>
								<tr id="TendingCNInfo">
									<td class="bz-edit-data-value" colspan="8">
										ҽ�ƿ����������ƻ������ģ�<br>Medical rehabilitation and care plan (Chinese)<br><br>
										<BZ:input prefix="R_" field="TENDING_CN" id="R_TENDING_CN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
									</td>
								</tr>
								<tr id="OpinionENInfo">
									<td class="bz-edit-data-value" colspan="8">
										��֯�����Ӣ�ģ�<br>Agency comments (English)<br><br>
										<BZ:input prefix="R_" field="OPINION_EN" id="R_OPINION_EN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
									</td>
								</tr>
								<tr id="OpinionCNInfo">
									<td class="bz-edit-data-value" colspan="8">
										��֯��������ģ�<br>Agency comments (Chinese)<br><br>
										<BZ:input prefix="R_" field="OPINION_CN" id="R_OPINION_CN" type="textarea" notnull="" style="width:96%;height:200px;" defaultValue=""/>
									</td>
								</tr>
							</table>
						</div>
						<!-- �������� end -->
					</div>
				</div>
				<!-- ������ʾ����end -->
				<!-- iframe��ʾ����begin -->
				<div class="widget-box no-margin" style=" width:100%; margin: 0 auto" id="iframepage">
					<iframe id="iframe" scrolling="no" src="<%=path %>/sce/preapproveapply/PlanOpinionShow.action?Flag=infoEN&type=show&RI_ID=<%=ri_id %>" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
				</div>
				<!-- iframe��ʾ����end -->
			</div>	
		</div>
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_applySubmit('0');"/>
				<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_applySubmit('1');"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
	<script>
	//********����ʱ����begin**************//
		Date.prototype.format =function(format){
		var o = {
		"M+" : this.getMonth()+1, //month
		"d+" : this.getDate(), //day
		"h+" : this.getHours(), //hour
		"m+" : this.getMinutes(), //minute
		"s+" : this.getSeconds(), //second
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter
		"S" : this.getMilliseconds() //millisecond
		 }
		if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
		 (this.getFullYear()+"").substr(4- RegExp.$1.length));
		for(var k in o)if(new RegExp("("+ k +")").test(format))
		 format = format.replace(RegExp.$1,
		 RegExp.$1.length==1? o[k] :
		 ("00"+ o[k]).substr((""+ o[k]).length));
		return format;
 	}
 	var djsTime = $("#R_DJSTIME").val();
 	var initDate="1990/01/01 "+djsTime;
	var curDate =new Date(initDate);
	
	function timeview(){ 
		  var date2 =curDate.format('hh:mm:ss');
		  jnkc.innerHTML = date2; 
		  curDate.setSeconds(curDate.getSeconds()-1); 
	} 
	//********����ʱ����end**************//
	</script>
</BZ:html>