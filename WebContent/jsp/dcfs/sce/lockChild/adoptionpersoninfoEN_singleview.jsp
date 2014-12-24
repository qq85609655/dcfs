<%
/**   
 * @Title: adoptionpersoninfoEN_singleview.jsp
 * @Description: �����˻�����Ϣ�鿴
 * @author yangrt   
 * @date 2014-8-14 ����16:26:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head language="EN">
		<title>�����˻�����Ϣ�鿴</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			var sex = $("#R_ADOPTER_SEX").val();
			if(sex == "2"){
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
					
				}else{
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
			}else if(sex == "1"){
				$("#femaleshow").hide();	//Ů��������Ϣ
				$("#maleshow").show();	//����������Ϣ
				$("#femalereligionshow").hide();	//Ů�����˵��ڽ�����
				$("#malereligionshow").show();	//�������˵��ڽ�����
				//�����������˵ĳ������ڼ���������
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
					
				}else{
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
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;ETXB;BCZL;">
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
	<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
	<!-- ��������end -->
	<!-- �鿴����begin -->
	<div class="bz-edit clearfix" desc="�鿴����" style="width:100%">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˻�����Ϣ(Information about the adoptive parents)</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="femaleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
						<td class="bz-edit-data-value" width="18%">Female</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;">
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
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
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������<br>Education</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��<br>Health condition</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">���<br>Height</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=Metric system;1=British system;" defaultValue="" onlyValue="true"/>
							<span id="FEMALE_HEIGHT_INCH"></span>
							<span id="FEMALE_HEIGHT_METRE">
								<BZ:dataValue field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>����(Centimeter)
							</span>
						</td>
						<td class="bz-edit-data-title">����<br>Weight</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
							<span id="FEMALE_WEIGHT_POUNDS">��(Pound)</span>
							<span id="FEMALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��<br>BMI</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BMI" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���<br>Criminal records</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_EN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�<br>Any bad habits</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_EN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0" id="maleshow">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
						<td class="bz-edit-data-value" width="18%">Male</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;">
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
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
							<BZ:dataValue field="MALE_NATION" codeName="GJ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������<br>Education</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��<br>Health condition</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-title">���<br>Height</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=Metric system;1=British system;" defaultValue="" onlyValue="true"/>
							<span id="MALE_HEIGHT_INCH"></span>
							<span id="MALE_HEIGHT_METRE">
								<BZ:dataValue field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>����(Centimeter)
							</span>
						</td>
						<td class="bz-edit-data-title">����<br>Weight</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
							<span id="MALE_WEIGHT_POUNDS">��(Pound)</span>
							<span id="MALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��<br>BMI</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BMI" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���<br>Criminal records</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_MALE_PUNISHMENT_EN">
								<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�<br>Any bad habits</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_MALE_ILLEGALACT_EN">
								<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�ڽ�����<br>Religious belief</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="femalereligionshow"><BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue="" onlyValue="true"/></span>
							<span id="malereligionshow"><BZ:dataValue field="MALE_RELIGION_EN" defaultValue="" onlyValue="true"/></span>
						</td>
						<td class="bz-edit-data-title" width="15%">����״��<br>Marital status</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">ͬ�ӻ��<br>Cohabitant partner</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CONABITA_PARTNERS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ͬ��ʱ��<br>Cohabitation period</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/>��(Year)
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
							<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
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
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>��
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
						<td class="bz-edit-data-title">����Ҫ��<br>Adoption preference</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- �鿴����end -->
</BZ:body>