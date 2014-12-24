<%
/**   
 * @Title: pauseFile_steptempleteview.jsp
 * @Description:  ����Ů�����ļ���ϸ��Ϣ�鿴ҳ
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
<%
	String male_photo = (String)request.getAttribute("MALE_PHOTO");
	String female_photo = (String)request.getAttribute("FEMALE_PHOTO");
%>
<BZ:html>
	<BZ:head>
		<title>����Ů�����ļ���ϸ��Ϣ�鿴ҳ</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
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
	<BZ:body property="data" codeNames="GJ;WJLX_DL;SYLX">
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
		<!-- �༭����end -->
	</BZ:body>
</BZ:html>