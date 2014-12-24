<%
/**   
 * @Title: adoptionpersoninfoEN_doubleview.jsp
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
	<BZ:head language="EN">
		<title>�����˻�����Ϣ(Information about the adoptive parents)</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script type="text/javascript">
		$(document).ready(function(){
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
				$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_EN").val());
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_EN").val());
			}
			
			//Υ����Ϊ�����´���
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#R_MALE_PUNISHMENT_EN").show();
				$("#R_MALE_PUNISHMENT").hide();
			}else{
				$("#R_MALE_PUNISHMENT_EN").hide();
				$("#R_MALE_PUNISHMENT").show();
			}
			if(female_punishment_flag == "1"){
				$("#R_FEMALE_PUNISHMENT_EN").show();
				$("#R_FEMALE_PUNISHMENT").hide();
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").hide();
				$("#R_FEMALE_PUNISHMENT").show();
			}
			
			//�����Ⱥ�
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#R_MALE_ILLEGALACT_EN").show();
				$("#R_MALE_ILLEGALACT").hide();
			}else{
				$("#R_MALE_ILLEGALACT_EN").hide();
				$("#R_MALE_ILLEGALACT").show();
			}
			if(female_illegalact_flag == "1"){
				$("#R_FEMALE_ILLEGALACT_EN").show();
				$("#R_FEMALE_ILLEGALACT").hide();
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").hide();
				$("#R_FEMALE_ILLEGALACT").show();
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
	<BZ:body property="data" codeNames="SYLX;WJLX;SDFS;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<!-- ��������end -->
	<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����˻�����Ϣ(Information about the adoptive parents)</div>
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
							<td class="bz-edit-data-title">��������<br>Name</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="16%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="24%">
								<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;">
							</td>
							<td class="bz-edit-data-value" width="24%">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="16%" rowspan="4">
								<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;">
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
							</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_AGE"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ܽ������<br>Education</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����״��<br>Health condition</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
								<span id="MALE_HEALTH_CONTENT"></span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
								<span id="FEMALE_HEALTH_CONTENT"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">Υ����Ϊ�����´���<br>Criminal records</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_MALE_PUNISHMENT">
									<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_MALE_PUNISHMENT_EN">
									<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_FEMALE_PUNISHMENT">
									<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue=""/>
								</span>
								<span id="R_FEMALE_PUNISHMENT_EN">
									<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���޲����Ⱥ�<br>Any bad habits</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_MALE_ILLEGALACT">
									<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_MALE_ILLEGALACT_EN">
									<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_FEMALE_ILLEGALACT">
									<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_FEMALE_ILLEGALACT_EN">
									<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ڽ�����<br>Religious belief</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_RELIGION_EN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���ҵ�λ<br>Currency</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:dataValue field="CURRENCY" codeName="HBBZ" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������<br>Annual income</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ǰ�����<br>Number of previous marriages</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>��(Times)
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>��(Times)
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">����״��<br>Marital status </td>
							<td class="bz-edit-data-value" width="18%">Married</td>
							<td class="bz-edit-data-title" width="15%">�������<br>Date of the present marriage </td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">����ʱ��<br>Length of the present marriage</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="MARRY_LENGTH"></span>��(Year)
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ͥ���ʲ�<br>Assets</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��ͥ��ծ��<br>Debts</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��ͥ���ʲ�<br>Net assets</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="TOTAL_MANNY"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">18����������Ů����<br>Number and age of children under 18 years old</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>&nbsp;��</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="18%">&nbsp;</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��Ů���������<br>Number of children</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ͥסַ<br>Address</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</BZ:body>
</BZ:html>