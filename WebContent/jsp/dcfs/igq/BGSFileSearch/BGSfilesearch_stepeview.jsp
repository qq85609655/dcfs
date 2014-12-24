<%
/**   
 * @Title: BGSfilesearch_stepeview.jsp
 * @Description:  �ļ���ѯ��ϸ��Ϣ�鿴ҳ�棨����Ů������
 * @author yangrt   
 * @date 2014-9-21 ����15:28:52 
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
	String male_photo = (String)request.getAttribute("MALE_PHOTO");
	String female_photo = (String)request.getAttribute("FEMALE_PHOTO");
	String ci_id = (String)request.getAttribute("CI_ID");
%>
<BZ:html>
	<BZ:head>
		<title>�ļ���ѯ��ϸ��Ϣ�鿴ҳ�棨����Ů������</title>
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
			//�����Ա��ж�Ҫ��ʾ����Ϣ
			var sex_flag = $("#R_ADOPTER_SEX").val();
			if(sex_flag == "0"){
				$(".male").show();
				$(".female").hide();
				
				//�����������˵���ʾ����
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
			}else{
				$(".female").show();
				$(".male").hide();
				
				//����Ů�����˵���ʾ����
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
				
			}
			
			//��Ч����
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1"){
				$("#R_PERIOD").text(valid_period + " ��(Month)");
			}else{
				$("#R_PERIOD").text("����");
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
	<BZ:body property="data" codeNames="GJ;WJLX;SYLX;ETXB;BCZL;PROVINCE;CHILD_TYPE;ETSFLX;ETLY">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
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
		<div class="bz-edit clearfix" desc="�༭����">
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
							<td class="bz-edit-data-value" width="25%">
								<span class="male"><BZ:dataValue field="MALE_NAME" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NAME" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="SEX_FLAG" checkValue="0=��;1=Ů;" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<span class="male"><img src='<up:attDownload attTypeCode="AF" packageId="<%=male_photo %>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'/></span>
								<span class="female"><img src='<up:attDownload attTypeCode="AF" packageId="<%=female_photo %>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
								<span id="FEMALE_AGE"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_NATION" defaultValue="" codeName="GJ"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NATION" defaultValue="" codeName="GJ"/></span>
							</td>
							<td class="bz-edit-data-title">���պ���</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����״��</td>
							<td class="bz-edit-data-value">�ѻ�</td>
							<td class="bz-edit-data-title">�������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date"/>
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
		%>
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
							<td class="bz-edit-data-title" width="20%">��׼����</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">��Ч����</td>
							<td class="bz-edit-data-value" width="30%">
								<span id="R_PERIOD"></span>
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
								<up:uploadList attTypeCode="AF" id="R_ADOPTION_APPLICATION" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSY %>"/>
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
							<td class="bz-edit-data-title" width="15%">�������������ڹ����ܻ���ͬ������������Ů��֤��</td>
							<td class="bz-edit-data-value" width="35%">
								<up:uploadList attTypeCode="AF" id="R_INTERCOUNTRY_ADOPTION" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSYZM %>"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
	</BZ:body>
</BZ:html>