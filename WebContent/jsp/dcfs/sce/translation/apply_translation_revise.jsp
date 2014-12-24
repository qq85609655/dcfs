<%
/**   
 * @Title: apply_translation_revise.jsp
 * @Description:  Ԥ�����뷭��ҳ��
 * @author panfeng   
 * @date 2014-10-14 ����17:48:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�����뷭��ҳ��</title>
		<BZ:webScript edit="true"/>
		<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
	</BZ:head>
	<script>
	
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			$('#tab-container').easytabs();
			//�����С�Ů�����˵ĳ������ڼ���������
			var male_birth = $("#R_MALE_BIRTHDAY").val();
			var female_birth = $("#R_FEMALE_BIRTHDAY").val();
			if(male_birth != ""){
				$("#MALE_AGE").text(_getAge(male_birth));
			}
			if(female_birth != ""){
				$("#FEMALE_AGE").text(_getAge(female_birth));
			}
			
			//ְҵ
			var male_job_cn = $("#R_MALE_JOB_CN").val();
			var male_job_en = $("#R_MALE_JOB_EN").val();
			var female_job_cn = $("#R_FEMALE_JOB_CN").val();
			var female_job_en = $("#R_FEMALE_JOB_EN").val();
			if(male_job_cn != "" || male_job_en != ""){
				$("#MALE_JOB_AREA").show();
			}else{
				$("#MALE_JOB_AREA").hide();
			}
			if(female_job_cn != "" || female_job_en != ""){
				$("#FEMALE_JOB_AREA").show();
			}else{
				$("#FEMALE_JOB_AREA").hide();
			}
			
			//����˵��
			var male_health = $("#R_MALE_HEALTH").val();
			var female_health = $("#R_FEMALE_HEALTH").val();
			if(male_health == "2"){
				$("#MALE_HEALTH_AREA").show();
				$("#MALE_HEALTH_AREA2").show();
			}else{
				$("#MALE_HEALTH_AREA").hide();
				$("#MALE_HEALTH_AREA2").hide();
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_AREA").show();
				$("#FEMALE_HEALTH_AREA2").show();
			}else{
				$("#FEMALE_HEALTH_AREA").hide();
				$("#FEMALE_HEALTH_AREA2").hide();
			}
			
			//Υ����Ϊ�����´���
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#MALE_PUNISHMENT_AREA").show();
				$("#MALE_PUNISHMENT_AREA2").show();
			}else{
				$("#MALE_PUNISHMENT_AREA").hide();
				$("#MALE_PUNISHMENT_AREA2").hide();
			}
			if(female_punishment_flag == "1"){
				$("#FEMALE_PUNISHMENT_AREA").show();
				$("#FEMALE_PUNISHMENT_AREA2").show();
			}else{
				$("#FEMALE_PUNISHMENT_AREA").hide();
				$("#FEMALE_PUNISHMENT_AREA2").hide();
			}
			
			//�����Ⱥ�
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#MALE_ILLEGALACT_AREA").show();
				$("#MALE_ILLEGALACT_AREA2").show();
			}else{
				$("#MALE_ILLEGALACT_AREA").hide();
				$("#MALE_ILLEGALACT_AREA2").hide();
			}
			if(female_illegalact_flag == "1"){
				$("#FEMALE_ILLEGALACT_AREA").show();
				$("#FEMALE_ILLEGALACT_AREA2").show();
			}else{
				$("#FEMALE_ILLEGALACT_AREA").hide();
				$("#FEMALE_ILLEGALACT_AREA2").hide();
			}
			
			//��Ů���������
			var child_condition_cn = $("#R_CHILD_CONDITION_CN").val();
			var child_condition_en = $("#R_CHILD_CONDITION_EN").val();
			if(child_condition_cn != "" || child_condition_en != ""){
				$("#CHILD_CONDITION_AREA").show();
				$("#CHILD_CONDITION_AREA2").show();
			}else{
				$("#CHILD_CONDITION_AREA").hide();
				$("#CHILD_CONDITION_AREA2").hide();
			}
			
			//����Ҫ��
			var adopt_request_cn = $("#R_ADOPT_REQUEST_CN").val();
			var adopt_request_en = $("#R_ADOPT_REQUEST_EN").val();
			if(adopt_request_cn != "" || adopt_request_en != ""){
				$("#ADOPT_REQUEST_AREA").show();
				$("#ADOPT_REQUEST_AREA2").show();
			}else{
				$("#ADOPT_REQUEST_AREA").hide();
				$("#ADOPT_REQUEST_AREA2").hide();
			}
			
			//��������������ͬס
			if($("#R_IS_FAMILY_OTHERS_FLAG").val() == "1"){
				$("#IS_FAMILY_OTHERS_AREA").show();
				$("#IS_FAMILY_OTHERS_AREA2").show();
			}else{
				$("#IS_FAMILY_OTHERS_AREA").hide();
				$("#IS_FAMILY_OTHERS_AREA2").hide();
			}
			
		});	
		
		//���ݳ������ڻ�ȡ��������
		function _getAge(strBirthday){     
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//ͬ�� ��Ϊ0��
		    }else{
		        var ageDiff = nowYear - birthYear ; //��֮��
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//��֮��
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//��֮��
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//����-1 ��ʾ��������������� ���ڽ���
		        }
		    }
		    return returnAge;//������������
		}
		
		//���뱣��
		function _save() {
		if (_check(document.srcForm)) {
			document.getElementById("P_TRANSLATION_STATE").value = "1";
			document.getElementById("R_TRANSLATION_STATE").value = "1";
			document.srcForm.action = path + "/sce/translation/preTranslationSave.action?type=save";
			
			document.srcForm.submit();
		  }
		}
		//��������ύ
		function _submit() {
		if (confirm("ȷ���ύ���ύ������Ϣ�޷��޸ģ�")) {
			document.getElementById("P_TRANSLATION_STATE").value = "2";
			document.getElementById("R_TRANSLATION_STATE").value = "2";
			document.srcForm.action = path + "/sce/translation/preTranslationSave.action?type=submit";
			document.srcForm.submit();
		  }
		}
		//�����б�
		function _goback(){
			document.srcForm.action = path + "/sce/translation/applyTranslationList.action";
			document.srcForm.submit();
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="GJ">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="P_" field="AT_ID"                    id="P_AT_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="P_" field="TRANSLATION_STATE"        id="P_TRANSLATION_STATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TRANSLATION_STATE"        id="R_TRANSLATION_STATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="RI_ID"              		 id="R_RI_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY"            id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY"          id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH"              id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH"            id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG"     id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG"   id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG"     id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG"   id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="IS_FAMILY_OTHERS_FLAG"    id="R_IS_FAMILY_OTHERS_FLAG" defaultValue=""/>
	<!-- ��������end -->
	<!-- �༭����begin -->
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
            <li class='tab'><a href="#tab1">�����˻�����Ϣ</a></li>
            <li class='tab'><a href="#tab2">�����ƻ�</a></li>
            <li class='tab'><a href="#tab3">��֯���</a></li>
        </ul>
        <div class='panel-container'>
			<div id="tab1">
				<table class="bz-edit-data-table" border="0">
                    <tr>
                        <td class="bz-edit-data-title" width="15%">������֯(CN)</td>
                        <td class="bz-edit-data-value" colspan="5">
                            <BZ:dataValue field="ADOPT_ORG_NAME_CN" hrefTitle="������֯(CN)" defaultValue="" onlyValue="true"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="bz-edit-data-title">������֯(EN)</td>
                        <td class="bz-edit-data-value" colspan="5">
                            <BZ:dataValue field="ADOPT_ORG_NAME_EN" hrefTitle="������֯(EN)" defaultValue="" onlyValue="true"/>
                        </td>
                    </tr>
                </table>
				<table class="bz-edit-data-table" border="0">
					<tr>
                          	<td class="bz-edit-data-title" colspan="6" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                      	</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">&nbsp;</td>
						<td class="bz-edit-data-title" width="40%" style="text-align:center">��������</td>
						<td class="bz-edit-data-title" width="40%" style="text-align:center">Ů������</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue=""  onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="MALE_JOB_EN" id="R_MALE_JOB_EN" type="String" formTitle="��������ְҵ" defaultValue="" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" type="String" formTitle="Ů������ְҵ" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ְҵ�����룩</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="MALE_JOB_CN" id="R_MALE_JOB_CN" type="String" formTitle="��������ְҵ" defaultValue="" />
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="FEMALE_JOB_CN" id="R_FEMALE_JOB_CN" type="String" formTitle="Ů������ְҵ" defaultValue="" />
						</td>
					</tr>
					<tr id="MALE_HEALTH_AREA">
						<td class="bz-edit-data-title">�н���˵��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="MALE_HEALTH_AREA2">
						<td class="bz-edit-data-title">�н���˵�������룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="FEMALE_HEALTH_AREA">
						<td class="bz-edit-data-title">Ů����˵��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="FEMALE_HEALTH_AREA2">
						<td class="bz-edit-data-title">Ů����˵�������룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" type="textarea" defaultValue="" maxlength="500" style="width:90%"/>
						</td>
					</tr>
					<tr id="MALE_PUNISHMENT_AREA">
						<td class="bz-edit-data-title">��Υ����Ϊ�����´���</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="MALE_PUNISHMENT_AREA2">
						<td class="bz-edit-data-title">��Υ����Ϊ�����´��������룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_PUNISHMENT_CN" id="R_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_PUNISHMENT_AREA">
						<td class="bz-edit-data-title">ŮΥ����Ϊ�����´���</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_PUNISHMENT_AREA2">
						<td class="bz-edit-data-title">ŮΥ����Ϊ�����´��������룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_CN" id="R_FEMALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="MALE_ILLEGALACT_AREA">
						<td class="bz-edit-data-title">�в����Ⱥ�</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="MALE_ILLEGALACT_AREA2">
						<td class="bz-edit-data-title">�в����Ⱥã����룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="MALE_ILLEGALACT_CN" id="R_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_ILLEGALACT_AREA">
						<td class="bz-edit-data-title">Ů�����Ⱥ�</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="FEMALE_ILLEGALACT_AREA2">
						<td class="bz-edit-data-title">Ů�����Ⱥã����룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_CN" id="R_FEMALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="CHILD_CONDITION_AREA">
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="CHILD_CONDITION_EN" id="R_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="CHILD_CONDITION_AREA2">
						<td class="bz-edit-data-title">��Ů��������������룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="CHILD_CONDITION_CN" id="R_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="ADOPT_REQUEST_AREA">
						<td class="bz-edit-data-title">����Ҫ��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="ADOPT_REQUEST_EN" id="R_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="ADOPT_REQUEST_AREA2">
						<td class="bz-edit-data-title">����Ҫ�󣨷��룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="ADOPT_REQUEST_CN" id="R_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:90%" />
						</td>
					</tr>
					<tr id="IS_FAMILY_OTHERS_AREA">
						<td class="bz-edit-data-title">����������ͬס˵��</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="IS_FAMILY_OTHERS_EN" id="R_IS_FAMILY_OTHERS_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="width:90%" />
						</td>
					</tr>
					<tr id="IS_FAMILY_OTHERS_AREA2">
						<td class="bz-edit-data-title">����������ͬס˵�������룩</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="R_" field="IS_FAMILY_OTHERS_CN" id="R_IS_FAMILY_OTHERS_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="width:90%" />
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� begin -->
			<div id="tab2">
				<table class="bz-edit-data-table" border="0">
					<tr>
                          	<td class="bz-edit-data-title" colspan="2" style="text-align:center"><b>�����ƻ�</b></td>
                      	</tr>
					<tr>
						<td class="bz-edit-data-title" width="10%">����(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="TENDING_CN" id="R_TENDING_CN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="TENDING_EN" id="R_TENDING_EN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� begin -->
			<div id="tab3">
				<table class="bz-edit-data-table" border="0">
					<tr>
                          	<td class="bz-edit-data-title" colspan="2" style="text-align:center"><b>��֯���</b></td>
                      	</tr>
					<tr>
						<td class="bz-edit-data-title" width="10%">����(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="OPINION_CN" id="R_OPINION_CN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="R_" field="OPINION_EN" id="R_OPINION_EN" formTitle="" defaultValue="" type="textarea" style="width:98%; height:200px" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
		<!--������Ϣ��start-->
		<div id="tab-translation">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="bz-edit-data-title" colspan="2" style="text-align:center"><b>������Ϣ</b></td>
                </tr>
                <tr>
					<td class="bz-edit-data-title" width="16%">����˵��</td>
					<td class="bz-edit-data-value">
					<BZ:input prefix="P_" field="TRANSLATION_DESC" id="P_TRANSLATION_DESC" type="textarea" formTitle="����˵��" defaultValue="" maxlength="500" style="width:90%"/>
					</td>
				</tr>
			</table>
		</div>
		<!--������Ϣ��end-->
		<br>
		<!-- ��ť����:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����:end -->
		<!-- �༭����end -->
	</BZ:form>
</BZ:body>