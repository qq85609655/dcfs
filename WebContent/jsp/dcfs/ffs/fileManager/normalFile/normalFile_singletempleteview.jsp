<%
/**   
 * @Title: normalFile_singletempleteview.jsp
 * @Description:  ������֯�ݽ���ͨ�ļ����������鿴ҳ��
 * @author yangrt   
 * @date 2014-8-4 ����13:26:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String packageId = (String)request.getAttribute("PACKAGE_ID");
	String maleFlag = (String)request.getAttribute("maleFlag");
	String femaleFlag = (String)request.getAttribute("femaleFlag");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�����ļ��������������鿴ҳ��</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
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
					$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_EN").val());
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
					$("#R_FEMALE_PUNISHMENT_EN").show();
					$("#R_FEMALE_PUNISHMENT").hide();
				}else{
					$("#R_FEMALE_PUNISHMENT_EN").hide();
					$("#R_FEMALE_PUNISHMENT").show();
				}
				
				//�����Ⱥ�
				var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
				if(female_illegalact_flag == "1"){
					$("#R_FEMALE_ILLEGALACT_EN").show();
					$("#R_FEMALE_ILLEGALACT").hide();
				}else{
					$("#R_FEMALE_ILLEGALACT_EN").hide();
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
					$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_EN").val());
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
					$("#R_MALE_PUNISHMENT_EN").show();
					$("#R_MALE_PUNISHMENT").hide();
				}else{
					$("#R_MALE_PUNISHMENT_EN").hide();
					$("#R_MALE_PUNISHMENT").show();
				}
				
				//�����Ⱥ�
				var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
				if(male_illegalact_flag == "1"){
					$("#R_MALE_ILLEGALACT_EN").show();
					$("#R_MALE_ILLEGALACT").hide();
				}else{
					$("#R_MALE_ILLEGALACT_EN").hide();
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
				$("#R_PERIOD").text("����(Long-term)");
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

<BZ:body property="data" codeNames="ZCWJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;SGYJ;">
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
	
	<!-- ��ť����begin -->
	<div class="blue-hr"> 
		<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>&nbsp;&nbsp;
		<button class="btn btn-sm btn-primary" onclick="window.close();">Close</button>
	</div>
	<!-- ��ť����end -->
	<div id='PrintArea'>
	<!-- �鿴����begin -->
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">������֯(CN)<br>Agency(CN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">������֯(EN)<br>Agency(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">�ļ�����<br>Document type</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="ZCWJLX" isShowEN="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">��������<br>Adoption type</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" isShowEN="true" defaultValue=""/>
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
				<div class="title3" style="height: 35px; padding-top: 5px;">�����˻�����Ϣ(Information about the adoptive parents)</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table table-print" border="0" id="femaleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
						<td class="bz-edit-data-value" width="18%">Female</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����<br>Age</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����<br>Nationality</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" isShowEN="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������<br>Education</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_EN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��<br>Health condition</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue=""/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">���<br>Height</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=Metric system;1=British system;" defaultValue=""/>
							<span id="FEMALE_HEIGHT_INCH"></span>
							<span id="FEMALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/>����(Centimeter)
							</span>
						</td>
						<td class="bz-edit-data-title">����<br>Weight</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/>
							<span id="FEMALE_WEIGHT_POUNDS" style="display: none;">��(Pound)</span>
							<span id="FEMALE_WEIGHT_KILOGRAM" style="display: none;">ǧ��(Kilogram)</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��<br>BMI</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���<br>Criminal records</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_EN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�<br>Any bad habits</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_EN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table table-print" border="0" id="maleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
						<td class="bz-edit-data-value" width="18%">Male</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����<br>Age</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����<br>Nationality</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" isShowEN="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������<br>Education</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_EN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��<br>Health condition</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue=""/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">���<br>Height</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=Metric system;1=British system;" defaultValue=""/>
							<span id="MALE_HEIGHT_INCH"></span>
							<span id="MALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="MALE_HEIGHT" defaultValue=""/>����(Centimeter)
							</span>
						</td>
						<td class="bz-edit-data-title">����<br>Weight</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_WEIGHT" defaultValue=""/>
							<span id="MALE_WEIGHT_POUNDS" style="display: none;">��(Pound)</span>
							<span id="MALE_WEIGHT_KILOGRAM" style="display: none;">ǧ��(Kilogram)</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��<br>BMI</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���<br>Criminal records</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue=""/>
							</span>
							<span id="R_MALE_PUNISHMENT_EN">
								<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�<br>Any bad habits</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue=""/>
							</span>
							<span id="R_MALE_ILLEGALACT_EN">
								<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�ڽ�����<br>Religious belief</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="femalereligionshow"><BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue="" onlyValue="true"/></span>
							<span id="malereligionshow"><BZ:dataValue field="MALE_RELIGION_EN" defaultValue="" onlyValue="true"/></span>
						</td>
						<td class="bz-edit-data-title" width="15%">����״��<br>Marital status</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">ͬ�ӻ��<br>Cohabitant partner</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CONABITA_PARTNERS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ͬ��ʱ��<br>Cohabitation period</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/><span id="CONABITA_LENGTH" style="display: none;">��(Year)</span>
						</td>
						<td class="bz-edit-data-title">��ͬ��������<br>Non-Homosexual statement</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GAY_STATEMENT" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���ҵ�λ<br>Currency</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" codeName="HBBZ" isShowEN="true" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������<br>Annual income</td>
						<td class="bz-edit-data-value">
							<span id="femalereligionshow"><BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/></span>
							<span id="malereligionshow"><BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/></span>
						</td>
						<td class="bz-edit-data-title">��ͥ���ʲ�<br>Assets</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ͥ��ծ��<br>Debts</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥ���ʲ�<br>Net assets</td>
						<td class="bz-edit-data-value">
							<span id="TOTAL_MANNY"></span>
						</td>
						<td class="bz-edit-data-title">18����������Ů����<br>Number and age of children under 18 years old</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/><span id="UNDERAGE_NUMBER" style="display: none;">��</span>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������<br>Number of children</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ<br>Address</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����Ҫ��<br>Adoption preference</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<h1></h1>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div class="title3" style="height: 35px; padding-top: 5px;">��ͥ���鼰��֯�����Ϣ(Home study and agency comments)</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��ɼҵ���֯����<br>Adoption agency preparing the report</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͥ�����������<br>Date of completion for home study</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" type="Date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�������<br>Meeting times</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/><span id="MEET_TIMES" style="display: none;">��(Times)</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƽ���<br>Recommendation letter</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/><span id="LETTER_NUM" style="display: none;">��(Number of letter)</span>
						</td>
						<td class="bz-edit-data-title">������������<br>Psychological assessment</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEART_REPORT" defaultValue="" codeName="ADOPTER_HEART_REPORT" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������<br>Motive of adoption</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="ADOPT_MOTIVATION" defaultValue="" codeName="ADOPTER_ADOPT_MOTIVATION" isShowEN="true" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����10���꼰���Ϻ��Ӷ����������<br>Opinion of adoption by children in the family over age 10</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILDREN_ABOVE" defaultValue="" codeName="ADOPTER_CHILDREN_ABOVE" isShowEN="true" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����ָ���໤��<br>Any designated guardian</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������Ű������<br>Statement of no abandonment and no abuse</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����ƻ�<br>Care plan </td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����ǰ׼��<br>Pre-adoption preparation</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������ʶ<br>Risk awareness</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ͬ��ݽ����ú󱨸�����<br>Statement of consent for post-placement reports</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������������ͬס<br>Anyone else living with the family</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����������ͬס˵��<br>Description of whether any other people living with the family</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>Parenting experience</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PARENTING" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�繤���<br>Conclusion of social worker</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SOCIALWORKER" codeName="SGYJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<%-- <td class="bz-edit-data-title">�Ƿ�Լ����<br>Hague/Non-Hague adoption</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td> --%>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥ��˵������������<br>Other issues requiring clarification from the adoptive family</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_EN" defaultValue=""/>
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
				<div class="title3" style="height: 35px; padding-top: 5px;">������׼��Ϣ(Government approval information)</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table table-print" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��׼����<br>Date of approval</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��Ч����<br>Validity period</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="R_PERIOD"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">��׼��ͯ����<br>Number of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/><span id="APPROVE_NUM" style="display: none;">��</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">������ͯ����<br>Age of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="AGE_FLOOR" defaultValue=""/><span class="CHILD_AGE" style="display: none;">��~</span>
							<BZ:dataValue field="AGE_UPPER" defaultValue=""/><span class="CHILD_AGE" style="display: none;">��</span>
						</td>
						<td class="bz-edit-data-title" width="15%">������ͯ�Ա�<br>Gender of children approved to be adopted</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">������ͯ����״��<br>Health status of children approved to be adopted </td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CHILDREN_HEALTH_EN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH" isShowEN="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</div>
	<div class="bz-edit clearfix" desc="�༭����" id="print2">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>������Ϣ(Attachment)</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-value">
							<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<%=packageId %>" frameborder=0 width="100%" ></IFRAME>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- �鿴����end -->
<script>
//��ӡ�������
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>	
</BZ:body>
</BZ:html>