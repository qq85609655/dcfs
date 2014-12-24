<%
/**   
 * @Title: pauseFile_singletempleteview.jsp
 * @Description:  �ļ���Ϣ���������鿴ҳ��
 * @author panfeng   
 * @date 2014-9-11 ����10:12:06 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head>
		<title>���������鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			/* ��ʼ���鿴ҳ������   */
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
<BZ:body property="data" codeNames="WJLX_DL;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="CONABITA_PARTNERS_TIME" id="R_CONABITA_PARTNERS_TIME" defaultValue=""/>
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
							<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">�ļ�����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX_DL" defaultValue=""/>
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
				<table class="bz-edit-data-table" border="0">
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
							<BZ:dataValue field="FEMALE_JOB_EN" defaultValue=""/>
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
							<span id="FEMALE_WEIGHT_POUNDS" style="display: none;">��</span>
							<span id="FEMALE_WEIGHT_KILOGRAM" style="display: none;">ǧ��</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ָ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_EN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_EN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ڽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ͬ�ӻ��</td>
							<td class="bz-edit-data-value">
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
							<td class="bz-edit-data-title">������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��ͥ���ʲ�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��ͥ��ծ��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ͥ���ʲ�</td>
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
								<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue=""/>
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
								<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue=""/>
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
							<BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue=""/>
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
							<BZ:dataValue field="CHILDREN_HEALTH_EN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- �鿴����end -->
</BZ:body>