<%
/**   
 * @Title: SHBfilesearch_singleview.jsp
 * @Description:  �ļ���ѯ��ϸ��Ϣ�鿴ҳ�棨����������
 * @author panfeng   
 * @date 2014-9-29 ����16:19:01 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String package_id = (String)request.getAttribute("PACKAGE_ID");
	String maleFlag = (String)request.getAttribute("maleFlag");
	String femaleFlag = (String)request.getAttribute("femaleFlag");
	String ci_id = (String)request.getAttribute("CI_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
%>
<BZ:html>
	<BZ:head>
		<title>�ļ���ѯ��ϸ��Ϣ�鿴ҳ�棨����������</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			var maleflag = "<%=maleFlag %>";
			var femaleflag = "<%=femaleFlag %>";
			/* ��ʼ���鿴ҳ�����ݵ�λ   */
			if($("#R_CONABITA_PARTNERS_TIME").val() != ""){
				$("#CONABITA_LENGTH").show();
			}
			if($("#R_UNDERAGE_NUM").val() != ""){
				$("#UNDERAGE_NUMBER").show();
			}
			if($("#R_INTERVIEW_TIMES").val() != ""){
				$("#MEET_TIMES").show();
			}
			if($("#R_RECOMMENDATION_NUM").val() != ""){
				$("#LETTER_NUM").show();
			}
			if($("#R_APPROVE_CHILD_NUM").val() != ""){
				$("#APPROVE_NUM").show();
			}
			if($("#R_AGE_FLOOR").val() != ""){
				$(".CHILD_AGE").show();
			}
			if(maleflag == "false" && femaleflag == "true"){
				$("#femaleshow").show();	//Ů��������Ϣ
				$("#maleshow").hide();	//����������Ϣ
				$("#femalereligionshow").show();	//Ů�����˵��ڽ�����
				$("#malereligionshow").hide();	//�������˵��ڽ�����
				//����Ů�����˵ĳ������ڼ���������
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
				
				//��ʼ������˵��
				var female_health = $("#R_FEMALE_HEALTH").val();
				if(female_health == "2"){
					$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_CN").val());
				}
				
				//��ʼ��������ص���ʾ��ʽ
				var measurement = $("#R_MEASUREMENT").val();
				var female_height = $("#R_FEMALE_HEIGHT").val();	//Ů���������
				if(measurement == "0"){
					$("#FEMALE_HEIGHT_INCH").hide();
					$("#FEMALE_HEIGHT_METRE").show();
					$("#FEMALE_WEIGHT_POUNDS").hide();
					$("#FEMALE_WEIGHT_KILOGRAM").show();
					
				}else if(measurement == "1"){
					$("#FEMALE_HEIGHT_INCH").show();
					$("#FEMALE_HEIGHT_METRE").hide();
					$("#FEMALE_WEIGHT_POUNDS").show();
					$("#FEMALE_WEIGHT_KILOGRAM").hide();
					
					var femaletempfeet = parseInt(female_height) / 30.48 + "";
					var femalefeet = femaletempfeet.split(".")[0];
					var femaleinch = femaletempfeet.split(".")[1] * 12;
					$("#FEMALE_HEIGHT_INCH").text(femalefeet + " Ӣ��(Feet)" + femaleinch + " Ӣ��(Inch)");
					
					var female_weight = $("#R_FEMALE_WEIGHT").val();	//Ů����������
					$("#R_FEMALE_WEIGHT").text(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
				}
				
				//Υ����Ϊ�����´���
				var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
				if(female_punishment_flag == "1"){
					$("#R_FEMALE_PUNISHMENT_CN").show();
					$("#R_FEMALE_PUNISHMENT").hide();
				}else{
					$("#R_FEMALE_PUNISHMENT_CN").hide();
					$("#R_FEMALE_PUNISHMENT").show();
				}
				
				//�����Ⱥ�
				var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
				if(female_illegalact_flag == "1"){
					$("#R_FEMALE_ILLEGALACT_CN").show();
					$("#R_FEMALE_ILLEGALACT").hide();
				}else{
					$("#R_FEMALE_ILLEGALACT_CN").hide();
					$("#R_FEMALE_ILLEGALACT").show();
				}
				
			}else if(maleflag == "true" && femaleflag == "false"){
				$("#femaleshow").hide();	//Ů��������Ϣ
				$("#maleshow").show();	//����������Ϣ
				$("#femalereligionshow").hide();	//Ů�����˵��ڽ�����
				$("#malereligionshow").show();	//�������˵��ڽ�����
				//����Ů�����˵ĳ������ڼ���������
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
				//��ʼ������˵��
				var male_health = $("#R_MALE_HEALTH").val();
				if(male_health == "2"){
					$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_CN").val());
				}
				
				//��ʼ��������ص���ʾ��ʽ
				var measurement = $("#R_MEASUREMENT").val();
				var male_height = $("#R_MALE_HEIGHT").val();	//Ů���������
				if(measurement == "0"){
					$("#MALE_HEIGHT_INCH").hide();
					$("#MALE_HEIGHT_METRE").show();
					$("#MALE_WEIGHT_POUNDS").hide();
					$("#MALE_WEIGHT_KILOGRAM").show();
					
				}else if(measurement == "1"){
					$("#MALE_HEIGHT_INCH").show();
					$("#MALE_HEIGHT_METRE").hide();
					$("#MALE_WEIGHT_POUNDS").show();
					$("#MALE_WEIGHT_KILOGRAM").hide();
					
					var maletempfeet = parseInt(male_height) / 30.48 + "";
					var malefeet = maletempfeet.split(".")[0];
					var maleinch = maletempfeet.split(".")[1] * 12;
					$("#MALE_HEIGHT_INCH").text(malefeet + " Ӣ��(Feet)" + maleinch + " Ӣ��(Inch)");
					
					var male_weight = $("#R_MALE_WEIGHT").val();	//Ů����������
					$("#R_MALE_WEIGHT").text(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				}
				
				//Υ����Ϊ�����´���
				var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
				if(male_punishment_flag == "1"){
					$("#R_MALE_PUNISHMENT_CN").show();
					$("#R_MALE_PUNISHMENT").hide();
				}else{
					$("#R_MALE_PUNISHMENT_CN").hide();
					$("#R_MALE_PUNISHMENT").show();
				}
				
				//�����Ⱥ�
				var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
				if(male_illegalact_flag == "1"){
					$("#R_MALE_ILLEGALACT_CN").show();
					$("#R_MALE_ILLEGALACT").hide();
				}else{
					$("#R_MALE_ILLEGALACT_CN").hide();
					$("#R_MALE_ILLEGALACT").show();
				}
			}
			
			//��ͥ���ʲ�
			var total_asset = $("#R_TOTAL_ASSET").val();
			var total_debt = $("#R_TOTAL_DEBT").val();
			$("#TOTAL_MANNY").text(total_asset - total_debt);
			
			//��Ч����
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1" && valid_period != ""){
				$("#R_PERIOD").text(valid_period + " ��(Month)");
			}else if(valid_period == "-1"){
				$("#R_PERIOD").text("����");
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
	</script>
</BZ:html>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;ETXB;BCZL;PROVINCE;CHILD_TYPE;ETSFLX;ETLY;YPZT">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_MARRY_TIMES" id="R_MALE_MARRY_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="INTERVIEW_TIMES" id="R_INTERVIEW_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="RECOMMENDATION_NUM" id="R_RECOMMENDATION_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="APPROVE_CHILD_NUM" id="R_APPROVE_CHILD_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="AGE_FLOOR" id="R_AGE_FLOOR" defaultValue=""/>
	<!-- ��������end -->
	<!-- �鿴����begin -->
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">������֯(CN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">������֯(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="������֯(EN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">�ļ�����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˻�����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="femaleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�</td>
						<td class="bz-edit-data-value" width="18%">Ů</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<img src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=����;1=Ӣ��;" defaultValue=""/>
							<span id="FEMALE_HEIGHT_INCH"></span>
							<span id="FEMALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/>����
							</span>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/>
							<span id="FEMALE_WEIGHT_POUNDS" style="display: none;">��(Pound)</span>
							<span id="FEMALE_WEIGHT_KILOGRAM" style="display: none;">ǧ��</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���<br>Criminal records</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_CN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_CN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue=""/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0" id="maleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�</td>
						<td class="bz-edit-data-value" width="18%">��</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<img src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_CN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=����;1=Ӣ��;" defaultValue=""/>
							<span id="MALE_HEIGHT_INCH"></span>
							<span id="MALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="MALE_HEIGHT" defaultValue=""/>����
							</span>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_WEIGHT" defaultValue=""/>
							<span id="MALE_WEIGHT_POUNDS" style="display: none;">��(Pound)</span>
							<span id="MALE_WEIGHT_KILOGRAM" style="display: none;">ǧ��</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_MALE_PUNISHMENT_CN">
								<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_MALE_ILLEGALACT_CN">
								<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue=""/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�ڽ�����</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="femalereligionshow"><BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue=""/></span>
							<span id="malereligionshow"><BZ:dataValue field="MALE_RELIGION_CN" defaultValue=""/></span>
						</td>
						<td class="bz-edit-data-title" width="15%">����״��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">ͬ�ӻ��</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CONABITA_PARTNERS" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ͬ��ʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue=""/><span id="CONABITA_LENGTH" style="display: none;">��</span>
						</td>
						<td class="bz-edit-data-title">��ͬ��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GAY_STATEMENT" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���ҵ�λ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" codeName="HBBZ"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������<br>Annual income</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��ͥ���ʲ�<br>Asset</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��ͥ��ծ��<br></td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥ���ʲ�<br>Net assets</td>
						<td class="bz-edit-data-value">
							<span id="TOTAL_MANNY"></span>
						</td>
						<td class="bz-edit-data-title">18����������Ů����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/><span id="UNDERAGE_NUMBER" style="display: none;">��</span>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADDRESS" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����Ҫ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<%
	if(!"".equals(ci_id)){
	%>
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ƥ���ͯ����������ͯ������Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
				<BZ:for property="List" fordata="childData">
				<%
					String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
				%>
					<tr>
						<td class="bz-edit-data-title" width="13%">��ͯ���</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_NO" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">��ͯ����</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="13%">���֤��</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="ID_CARD" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value" rowspan="4" width="16%">
							<img src='<up:attDownload attTypeCode="CI" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ʡ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����Ժ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" property="childData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�ر��ע</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=��;1=��" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͯ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��Ժ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENTER_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����ͬ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=��;1=��" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SENDER" defaultValue="" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEND_DATE" defaultValue="" type="date" property="childData" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�����˵�ַ</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
						</td>
						<td class="bz-edit-data-title">��ͯ��Դ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_SOURCE" property="childData" codeName="ETLY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��ͯ������</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="" defaultValue="" property="childData" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value" colspan="6">
							<BZ:dataValue field="DISEASE_CN" property="childData" defaultValue=""/>
						</td>
					</tr>
				</BZ:for>
				</table>
			</div>
		</div>
	</div>
	<%
	}
	if(!"".equals(ri_id)){
	%>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>Ԥ��������Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<BZ:for property="riList" fordata="preData">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">Ԥ��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="REQ_NO" property="preData" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">Ԥ��״̬</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="RI_STATE" property="preData" codeName="YPZT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����ƻ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="TENDING_CN" property="preData" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��֯���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="OPINION_CN" property="preData" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			</BZ:for>
		</div>
	</div>
	<%
	}
	%>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��ͥ���鼰��֯�����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��ɼҵ���֯����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͥ�����������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" type="Date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�������</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/><span id="MEET_TIMES" style="display: none;">��</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƽ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/><span id="LETTER_NUM" style="display: none;">��(Number of letter)</span>
						</td>
						<td class="bz-edit-data-title">������������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEART_REPORT" defaultValue="" codeName="ADOPTER_HEART_REPORT"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="ADOPT_MOTIVATION" defaultValue="" codeName="ADOPTER_ADOPT_MOTIVATION"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILDREN_ABOVE" defaultValue="" codeName="ADOPTER_CHILDREN_ABOVE"/>
						</td>
						<td class="bz-edit-data-title">����ָ���໤��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������Ű������</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����ƻ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����ǰ׼��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">������ʶ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ͬ��ݽ����ú󱨸�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��������������ͬס</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����������ͬס˵��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PARENTING" checkValue="0=��;1=��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�繤���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SOCIALWORKER" checkValue="1=֧��;2=�������;3=��֧��;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥ��˵������������</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_CN" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>������׼��Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��׼����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��Ч����</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="R_PERIOD"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">��׼��ͯ����</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/><span id="APPROVE_NUM" style="display: none;">��</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">������ͯ����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="AGE_FLOOR" defaultValue=""/><span class="CHILD_AGE" style="display: none;">��~</span>
							<BZ:dataValue field="AGE_UPPER" defaultValue=""/><span class="CHILD_AGE" style="display: none;">��</span>
						</td>
						<td class="bz-edit-data-title" width="15%">������ͯ�Ա�</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">������ͯ����״��</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CHILDREN_HEALTH_CN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>������Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�������������</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList id="R_ADOPTION_APPLICATION" attTypeCode="AF" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSY %>"/>
						</td>
						<td class="bz-edit-data-title" width="15%">����֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_BIRTH_CERTIFICATE" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_CSZM %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����״��֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_MARITAL_STATUS" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_HYZK %>"/>
						</td>
						<td class="bz-edit-data-title" width="15%">ְҵ���������뼰����״��֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_CAREER_PROVE" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_ZJCZM %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_SINGLE_STATEMENT" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_DQSM %>"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͬ��������</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_NONGAY_STATEMENT" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_FTSM %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">���彡�����֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_HEALTH_CHECK" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_STJK %>"/>
						</td>
					
						<td class="bz-edit-data-title" width="15%">�����ܹ����´���֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_CRIMINAL_PENALTIES" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_XSCF %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��ͥ���鱨��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_HOUSEHOLD_SURVEY" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_JTQK %>"/>
						</td>
					
						<td class="bz-edit-data-title" width="15%">������������</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_ASSESSMENT_REPORT" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_XLDC %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">�������������ڹ����ܻ���ͬ������������Ů��֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_INTERCOUNTRY_ADOPTION" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSYZM %>"/>
						</td>
					
						<td class="bz-edit-data-title" width="15%">��ͥ������Ƭ</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_LIFE_PHOTOS" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_SHZP %>"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">�Ƽ���</td>
						<td class="bz-edit-data-value" width="35%">
							<up:uploadList attTypeCode="AF" id="R_RECOMMENDATION_LETTER" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_TJX %>"/>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- �鿴����end -->
</BZ:body>