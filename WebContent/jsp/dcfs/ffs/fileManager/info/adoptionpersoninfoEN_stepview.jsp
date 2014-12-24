<%
/**   
 * @Title: adoptionpersoninfoEN_stepview.jsp
 * @Description:  �����˻�����Ϣ�鿴
 * @author yangrt   
 * @date 2014-7-22 ����14:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head language="EN">
		<title>�����˻�����Ϣ�鿴</title>
		<up:uploadResource isImage="true"/>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-ui-1.10.3.min.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//�����Ա��ж�Ҫ��ʾ����Ϣ
			var sex_flag = $("#R_ADOPTER_SEX").val();
			if(sex_flag == "1"){
				$(".male").show();
				$(".female").hide();
				
				//�����������˵���ʾ����
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
			}else if(sex_flag == "2"){
				$(".female").show();
				$(".male").hide();
				
				//����Ů�����˵���ʾ����
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
			}
		});
		
		//���ݳ������ڻ�ȡ��������
		function _getAge(strBirthday)
		{       
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
	<BZ:body property="data" codeNames="GJ;">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
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
							<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
							<td class="bz-edit-data-value" width="25%">
								<span class="male"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="ADOPTER_SEX" checkValue="1=Male;2=Female;" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<span class="male">
									<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;"/>
								</span>
								<span class="female">
									<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></span>
							</td>
							<td class="bz-edit-data-title">����<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
								<span id="FEMALE_AGE"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����<br>Nationality</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_NATION" defaultValue="" codeName="GJ" isShowEN="true" onlyValue="true"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NATION" defaultValue="" codeName="GJ" isShowEN="true" onlyValue="true"/></span>
							</td>
							<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����״��<br>Marital status</td>
							<td class="bz-edit-data-value">Married</td>
							<td class="bz-edit-data-title">�������<br>Date of the present marriage</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
	</BZ:body>
</BZ:html>