<%
/**   
 * @Title: adoptionpersoninfoCN_doubleview.jsp
 * @Description:  �����˻�����Ϣ
 * @author yangrt   
 * @date 2014-9-14 ����11:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<BZ:html>
	<BZ:head>
		<title>�����˻�����Ϣ</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript">
		$(document).ready(function(){
			setSigle();
			dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			/* ��ʼ���鿴ҳ������   */
			//�����С�Ů�����˵ĳ������ڼ���������
			var male_birth = $("#R_MALE_BIRTHDAY").val();
			var female_birth = $("#R_FEMALE_BIRTHDAY").val();
			if(male_birth != ""){
				$("#MALE_AGE").text(_getAge(male_birth));
			}
			if(female_birth != ""){
				$("#FEMALE_AGE").text(_getAge(female_birth));
			}
			
			
			//��ʼ������˵��
			var male_health = $("#R_MALE_HEALTH").val();
			var female_health = $("#R_FEMALE_HEALTH").val();
			if(male_health == "2"){
				$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_CN").val());
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_CN").val());
			}
			
			//Υ����Ϊ�����´���
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#R_MALE_PUNISHMENT_CN").show();
				$("#R_MALE_PUNISHMENT").hide();
			}else{
				$("#R_MALE_PUNISHMENT_CN").hide();
				$("#R_MALE_PUNISHMENT").show();
			}
			if(female_punishment_flag == "1"){
				$("#R_FEMALE_PUNISHMENT_CN").show();
				$("#R_FEMALE_PUNISHMENT").hide();
			}else{
				$("#R_FEMALE_PUNISHMENT_CN").hide();
				$("#R_FEMALE_PUNISHMENT").show();
			}
			
			//�����Ⱥ�
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#R_MALE_ILLEGALACT_CN").show();
				$("#R_MALE_ILLEGALACT").hide();
			}else{
				$("#R_MALE_ILLEGALACT_CN").hide();
				$("#R_MALE_ILLEGALACT").show();
			}
			if(female_illegalact_flag == "1"){
				$("#R_FEMALE_ILLEGALACT_CN").show();
				$("#R_FEMALE_ILLEGALACT").hide();
			}else{
				$("#R_FEMALE_ILLEGALACT_CN").hide();
				$("#R_FEMALE_ILLEGALACT").show();
			}
			
			
			//��ʼ����������������ͬס˵������ʾ������
			var IS_FAMILY_OTHERS_FLAG = $("#R_IS_FAMILY_OTHERS_FLAG").val();
			if(IS_FAMILY_OTHERS_FLAG == "1"){
				$("#R_FAMILY_OTHERS_FLAG").hide();
				$("#R_FAMILY_OTHERS_CN").show();
			}else{
				$("#R_FAMILY_OTHERS_FLAG").show();
				$("#R_FAMILY_OTHERS_CN").hide();
			}
			
			//���ʱ��
			var marry_date = $("#R_MARRY_DATE").val();
			$("#MARRY_LENGTH").text(_getAge(marry_date));
			
			//��ͥ���ʲ�
			var total_asset = $("#R_TOTAL_ASSET").val();
			var total_debt = $("#R_TOTAL_DEBT").val();
			$("#TOTAL_MANNY").text(total_asset - total_debt);
			
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
		</script>
	</BZ:head>
	<BZ:body property="applydata" codeNames="SYLX;WJLX;SDFS;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_MARRY_TIMES" id="R_MALE_MARRY_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_MARRY_TIMES" id="R_FEMALE_MARRY_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="CURRENCY" id="R_CURRENCY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="IS_FAMILY_OTHERS_FLAG" id="R_IS_FAMILY_OTHERS_FLAG" defaultValue=""/>
	<!-- ��������end -->
	<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����˻������</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="16%">&nbsp;</td>
							<td class="bz-edit-data-title" colspan="2" style="text-align:center">��������(Adoptive father)</td>
							<td class="bz-edit-data-title" colspan="2" style="text-align:center">Ů������(Adoptive mother)</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="16%">��������</td>
							<td class="bz-edit-data-value" width="24%">
								<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;"/>
							</td>
							<td class="bz-edit-data-value" width="24%">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="16%" rowspan="4">
								<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;"/>
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
								<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���պ���</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ܽ������</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ְҵ</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����״��</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
								<span id="MALE_HEALTH_CONTENT"></span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
								<span id="FEMALE_HEALTH_CONTENT"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_MALE_PUNISHMENT">
									<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_MALE_PUNISHMENT_CN">
									<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_FEMALE_PUNISHMENT">
									<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_FEMALE_PUNISHMENT_CN">
									<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���޲����Ⱥ�</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_MALE_ILLEGALACT">
									<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_MALE_ILLEGALACT_CN">
									<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_FEMALE_ILLEGALACT">
									<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_FEMALE_ILLEGALACT_CN">
									<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ǰ�����</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>��
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>��
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">����״��</td>
							<td class="bz-edit-data-value" width="18%">�ѻ�</td>
							<td class="bz-edit-data-title" width="15%">�������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">����ʱ��</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="MARRY_LENGTH"></span>��
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���ҵ�λ</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CURRENCY" codeName="HBBZ" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">��������������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">Ů������������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ͥ���ʲ�</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��ͥ��ծ��</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��ͥ���ʲ�</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="TOTAL_MANNY"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">18����������Ů����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>&nbsp;��
							</td>
							<td class="bz-edit-data-title">��������������ͬס<br></td>
							<td class="bz-edit-data-value" colspan="3">
								<span id="R_FAMILY_OTHERS_FLAG">
									<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_FAMILY_OTHERS_CN">
									<BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��Ů���������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ͥסַ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<%-- <tr>
							<td class="bz-edit-data-title" width="15%">����Ҫ��</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr> --%>
					</table>
				</div>
			</div>
		</div>
	</BZ:body>
</BZ:html>