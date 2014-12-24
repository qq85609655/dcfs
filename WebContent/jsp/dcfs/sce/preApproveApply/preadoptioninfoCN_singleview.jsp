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
	<BZ:head>
		<title>�����˻�����Ϣ�鿴</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			setSigle();
			dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
			var sex = $("#R_ADOPTER_SEX").val();
			if(sex == "1"){
				$("#femaleinfo").hide();
				$("#femaleincome").hide();
				//�����������˵ĳ������ڼ���������
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
				//��ʼ������˵��
				var male_health = $("#R_MALE_HEALTH").val();
				if(male_health == "2"){
					$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_CN").val());
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
			}else if(sex == "2"){
				$("#maleinfo").hide();	
				$("#maleincome").hide();
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
<BZ:body property="applydata" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;HBBZ;">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="CURRENCY" id="R_CURRENCY" defaultValue=""/>
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
				<div>�����˻������</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="femaleinfo">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�</td>
						<td class="bz-edit-data-value" width="18%">Ů</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
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
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
						
						<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_CN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�</td>
						<td class="bz-edit-data-value">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_CN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0" id="maleinfo">
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�</td>
						<td class="bz-edit-data-value" width="18%">��</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%" rowspan="4">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
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
							<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ܽ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ְҵ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						
						<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
							</span>
							<span id="R_MALE_PUNISHMENT_CN">
								<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
						<td class="bz-edit-data-title">���޲����Ⱥ�</td>
						<td class="bz-edit-data-value">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=��;1=��;" defaultValue=""/>
							</span>
							<span id="R_MALE_ILLEGALACT_CN">
								<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">����״��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_CONDITION" checkValue="ADOPTER_MARRYCOND" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">ͬ�ӻ��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CONABITA_PARTNERS" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">ͬ��ʱ��</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/>��
						</td>
					
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͬ��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GAY_STATEMENT" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���ҵ�λ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CURRENCY" defaultValue="" codeName="HBBZ" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<span id="femaleincome">
								<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</span>
							<span id="maleincome">
								<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥ���ʲ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ͥ��ծ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ͥ���ʲ�</td>
						<td class="bz-edit-data-value">
							<span id="TOTAL_MANNY"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">18����������Ů����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>��
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��Ů���������</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">����Ҫ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr> --%>
				</table>
			</div>
		</div>
	</div>
	<!-- �鿴����end -->
</BZ:body>