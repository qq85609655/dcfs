<%
/**   
 * @Title: singleparent_cn_view.jsp
 * @Description:  ��������_����_�鿴
 * @author wangz   
 * @date 2014-10-29
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
	String ADOPTER_SEX = data.getString("ADOPTER_SEX");
	String afId = data.getString("AF_ID");
%>
<BZ:html>
<BZ:head>
    <title>�����ļ�����</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
</BZ:head>
<script type="text/javascript">
	var path = "<%=path%>";
	$(document).ready( function() {
		dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
		_setValidPeriod('<%=data.getString("VALID_PERIOD")%>');
		})
	
	//����bmi
	function _bmi(h,w){
		if(""==h || ""==w || "null"==h || "null"==w){
			return ""
		}
		h = h/100;
		return parseFloat(w / (h * h)).toFixed(2);
	}
	/*
	* ���ü�ͥ���ʲ�
	*/
	function _setTotalManny(a,d){
		if(""==a || ""==d || "null"==a || "null"==d){
			return "";
		}		
		return(a - d);	
	}

	/*
	* ������Ч��������
	* 1:��Ч����
	* 2:����
	*/
	function _setValidPeriod(v){
		var strText;
		if("-1"==v){				
			strText = "����";
		}else{
			strText = v + "��";			
		}
		$("#FE_VALID_PERIOD").text(strText);	
	}

	//�ر�
	function _close(){
		window.close();
	}
	</script>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND;SEX;SGYJ">
	                 
	<!--����������start-->
	<table class="specialtable">
		<tr>
			 <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
		</tr>
		<tr>
			<td>
				<!--��������Ϣ��start-->                            	  
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">��������</td>
						<td class="edit-data-value" width="26%">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title" width="15%">�Ա�</td>
						<td class="edit-data-value" width="26%">
						<BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" width="18%" rowspan="6" style="text-align:center">
							<%if("1".equals(ADOPTER_SEX)){%>
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
							<%}else{%>
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
							<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value">
							<script>
							document.write(getAge('<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}%>'));
							</script>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">���պ���</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">�ܽ����̶�</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue  codeName="ADOPTER_EDU" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">ְҵ</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="String" field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="String" field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����״��</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>
						</td>
						<%}else{%>
						<BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>
						</td>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">���</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>
						<%}%>����
						</td>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
						<%}%>ǧ��
						</td>
					</tr>                                    
					<tr>
						<td class="edit-data-title">����ָ��</td>
						<td class="edit-data-value" colspan="4">
						<%if("1".equals(ADOPTER_SEX)){%>
							<BZ:dataValue field="MALE_BMI" defaultValue="" onlyValue="true"/>
						<%}else{%>
							<BZ:dataValue field="FEMALE_BMI" defaultValue="" onlyValue="true"/>						
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">Υ����Ϊ�����´���</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>
						</td>
						<%}else{%>
						<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue=""/>
						</td>
						<%}%>
					</tr>
					<tr>
						<td class="edit-data-title">���޲����Ⱥ�</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue=""/>
						</td>
						<%}else{%>
						<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue=""/>
						</td>
						<%}%>									
					</tr>
					<tr>
						<td class="edit-data-title">�ڽ�����</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_RELIGION_CN" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">����״��</td>
						<td class="edit-data-value" colspan="2">
						<BZ:dataValue codeName="ADOPTER_MARRYCOND" field="MARRY_CONDITION" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">ͬ�ӻ��</td>
						<td class="edit-data-value">
							<BZ:dataValue field="CONABITA_PARTNERS" defaultValue="" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">ͬ��ʱ��</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue=""/> ��
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͬ��������</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="GAY_STATEMENT" defaultValue="" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">���ҵ�λ</td>
						<td class="edit-data-value">
						<BZ:dataValue codeName="HBBZ" field="CURRENCY" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">������</td>
						<td class="edit-data-value" colspan="2">
						<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥ���ʲ�</td>
						<td class="edit-data-value"><BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/></td>
						<td class="edit-data-title">��ͥ��ծ��</td>
						<td class="edit-data-value" colspan="2"><BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/></td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥ���ʲ�</td>
						<td class="edit-data-value" colspan="4">
							<script>
							document.write(_setTotalManny('<BZ:dataValue field="TOTAL_ASSET" onlyValue="true"/>','<BZ:dataValue field="TOTAL_DEBT" onlyValue="true"/>'));
							</script>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">18����������Ů����</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/> ��
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��Ů���������</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥסַ</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����Ҫ��</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">��ɼҵ���֯����</td>
						<td class="edit-data-value" colspan="5"><BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="width:15%">��ͥ�����������</td>
						<td class="edit-data-value" style="width:18%"><BZ:dataValue type="date" field="FINISH_DATE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" style="width:15%">����������Σ�</td>
						<td class="edit-data-value" style="width:18%"><BZ:dataValue field="INTERVIEW_TIMES" defaultValue="" onlyValue="true"/>
						</td>                                    
						<td class="edit-data-title" style="width:15%">�Ƽ��ţ��⣩</td>
						<td class="edit-data-value" style="width:19%"><BZ:dataValue field="RECOMMENDATION_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������������</td>
						<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_HEART_REPORT" field="HEART_REPORT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_ADOPT_MOTIVATION" field="ADOPT_MOTIVATION" defaultValue="" onlyValue="true"/>
						</td>								
						<td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
						<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_ABOVE" field="CHILDREN_ABOVE" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����ָ���໤��</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_FORMULATE" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">��������Ű������</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_ABUSE_ABANDON" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
					
						<td class="edit-data-title">�����ƻ�</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_MEDICALRECOVERY" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����ǰ׼��</td>
						<td class="edit-data-value"><BZ:dataValue field="ADOPT_PREPARE" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">������ʶ</td>
						<td class="edit-data-value"><BZ:dataValue field="RISK_AWARENESS" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>							   
						<td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_SUBMIT_REPORT" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
					</tr>                                    
					<tr>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value"><BZ:dataValue field="PARENTING" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">�繤���</td>
						<td class="edit-data-value"><BZ:dataValue codeName="SGYJ" field="SOCIALWORKER" defaultValue="" onlyValue="true"/>										
						</td>
						<td class="edit-data-title">&nbsp;</td>
						<td class="edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="edit-data-title">��������������ͬס</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">����������ͬס˵��</td>
						<td class="edit-data-value" colspan="3"><BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥ��˵������������</td>
						<td class="edit-data-value" colspan="5"><BZ:dataValue field="REMARK_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">��׼����</td>
						<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">��Ч����</td>
						<td class="edit-data-value">
						<div id="FE_VALID_PERIOD"></div>
						</td>
						<td class="edit-data-title">��׼��ͯ����</td>
						<td class="edit-data-value"><BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������ͯ����</td>
						<td class="edit-data-value">
						<BZ:dataValue field="AGE_FLOOR" defaultValue="" onlyValue="true"/>��~
						<BZ:dataValue field="AGE_UPPER" defaultValue="" onlyValue="true"/>��
						</td>
						<td class="edit-data-title">������ͯ�Ա�</td>
						<td class="edit-data-value">
						<BZ:dataValue codeName="ADOPTER_CHILDREN_SEX" field="CHILDREN_SEX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">������ͯ����״��</td>
						<td class="edit-data-value">
						<BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center">
						<b>������Ϣ</b></td>										
					</tr>
					<tr>
						<td colspan="6">
						<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table> 
	<!--����������end-->			
	</BZ:body>
</BZ:html>
