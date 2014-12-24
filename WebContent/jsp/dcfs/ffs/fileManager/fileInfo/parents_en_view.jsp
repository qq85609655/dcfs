<%
/**   
 * @Title: parents_cn_view.jsp
 * @Description:  ˫�������ļ�_Ӣ��_��ʾ
 * @author wangzheng   
 * @date 2014-10-29
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="java.util.Map"%>

<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>

<%
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
	String strPar1 = "org_id="+orgId + ",af_id=" + afId;
%>
<BZ:html>
<BZ:head>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
    <title>�����ļ�����</title>
    <BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND;SGYJ">
	<script type="text/javascript">
		//�����ϴ�-���ܷ���ֵ	
		var path = "<%=path%>";		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//�������˵Ľ���״��
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//Ů�����˵Ľ���״��		
		//var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//������λ
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//��������Υ����Ϊ�����´���
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů������Υ����Ϊ�����´���
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//�����������޲����Ⱥ�
		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů���������޲����Ⱥ�		

		var MARRY_DATE = '<BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/>';		//�������
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//��ͥ���ʲ�
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";		//��ͥ��ծ��
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//��Ч����
		
		$(document).ready( function() {
			//����iframe
			dyniframesize(['iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ

		   
			//��ʼ������״��˵������ʾ������
			_setMale_health(male_health);
			_setFemale_health(female_health);
			//������ߡ����ص���ʾ��ʽ�����ơ�Ӣ�ƣ�
			//_setMeasurement(measurement);
			
			//����BMI
			//_setBMI("1");
			//_setBMI("2");
			
			
			//��ʼ������Υ����Ϊ�����´���
			_setMALE_PUNISHMENT_FLAG(MALE_PUNISHMENT_FLAG);
			_setFEMALE_PUNISHMENT_FLAG(FEMALE_PUNISHMENT_FLAG);
			
			//��ʼ���������޲����Ⱥ�
			_setMALE_ILLEGALACT_FLAG(MALE_ILLEGALACT_FLAG);
			_setFEMALE_ILLEGALACT_FLAG(FEMALE_ILLEGALACT_FLAG);
			//���ý��ʱ��
			
			_setMarryLength(MARRY_DATE);
			//���ü�ͥ���ʲ�
			_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
			//������Ч����
			_setValidPeriod(VALID_PERIOD);
		})
	
	
	/*
	* ����״�����ã�ѡ�񲻽�������ʾ�������˵��
	* p=2 ������ p=1 ����
	*/
	function _setMale_health(p){		
		if("2"== p){
			$("#FE_MALE_HEALTH_CONTENT_EN").show();			
		}else{
			$("#FE_MALE_HEALTH_CONTENT_EN").hide();
		}
	}
	function _setFemale_health(p){
		if("2"== p){
			$("#FE_FEMALE_HEALTH_CONTENT_EN").show();			
		}else{
			$("#FE_FEMALE_HEALTH_CONTENT_EN").hide();
		}			
	}	
	
	/*
	* ������������Υ����Ϊ�����´���	
	*f 0���� 1:��
	*/
	function _setMALE_PUNISHMENT_FLAG(f){
		if(f == "1"){	
			$("#FE_MALE_PUNISHMENT_EN").show();
		}else{
			$("#FE_MALE_PUNISHMENT_EN").hide();
		}	
	}

	//����Ů������Υ����Ϊ�����´���
	function _setFEMALE_PUNISHMENT_FLAG(f){
		if(f == "1"){
			$("#FE_FEMALE_PUNISHMENT_EN").show();
		}else{
			$("#FE_FEMALE_PUNISHMENT_EN").hide();
		}			
	}

	//�������޲����Ⱥ�
	function _setMALE_ILLEGALACT_FLAG(f){
		if("1" == f){
			$("#FE_MALE_ILLEGALACT_EN").show();
		}else{
			$("#FE_MALE_ILLEGALACT_EN").hide();
		}			
	}
	
	//�������޲����Ⱥ�
	function _setFEMALE_ILLEGALACT_FLAG(f){
		if(f == "1"){
			$("#FE_FEMALE_ILLEGALACT_EN").show();
		}else{
			$("#FE_FEMALE_ILLEGALACT_EN").hide();
		}			
	}
	
	/*
	* ���ý��ʱ��
	* d���������
	*/
	function _setMarryLength(d){		
		$("#FE_MARRY_LENGTH").text(getAge(d));
	}

	
	/*
	* ���ü�ͥ���ʲ�
	*/
	function _setTotalManny(a,d){
		if(a=="" || d==""){
			return;
		}		
		$("#FE_TOTAL_MANNY").text(a - d);
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
	</script>

	<!--˫��������start-->                            	  
	<table class="specialtable">
		<tr>
			 <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
		</tr>
		<tr>
			<td>
				<table class="specialtable">
					<tr>                                    	
						<td class="edit-data-title" width="15%">&nbsp;</td>
						<td class="edit-data-title" colspan="2" style="text-align:center">��������</td>
						<td class="edit-data-title" colspan="2" style="text-align:center">Ů������</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">����</td>
						<td class="edit-data-value" width="27%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value" width="15%" rowspan="5">							
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
						</td>
						<td class="edit-data-value" width="28%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" width="15%" rowspan="5">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>								
						</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value">
							<div id="MALE_AGE" style="font-size:14px">
							<script>								
							document.write(getAge('<BZ:dataValue field="MALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>'));
							</script>
							</div>
						</td>
						<td class="edit-data-value" style="font-size:14px">
							<div id="FEMALE_AGE" style="font-size:14px">
							<script>								
							document.write(getAge('<BZ:dataValue field="FEMALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>'));
							</script>
							</div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="GJ" field="MALE_NATION"  defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="GJ" field="FEMALE_NATION"  defaultValue="" onlyValue="true"/>							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">���պ���</td>
						<td class="edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO"  defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO"  defaultValue="" onlyValue="true"/>							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">�ܽ����̶�</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION"  defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_EDU" field="FEMALE_EDUCATION"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">ְҵ</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_JOB_EN"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_JOB_EN"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����״��</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH"  defaultValue="" onlyValue="true"/>
							<span id="FE_MALE_HEALTH_CONTENT_EN">
							<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/>
							</span>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH"  defaultValue="" onlyValue="true"/>
							<span id="FE_FEMALE_HEALTH_CONTENT_EN">
							<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/>
							</span>
						</td>
					</tr>
					 <tr>
						<td class="edit-data-title">���</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_HEIGHT" onlyValue="true" defaultValue=""/>							
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true" defaultValue=""/>							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_WEIGHT" onlyValue="true" defaultValue=""/>							
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����ָ��</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_BMI" onlyValue="true" defaultValue=""/>	
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_BMI" onlyValue="true" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">Υ����Ϊ�����´���</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>	
							<span id="FE_MALE_PUNISHMENT_EN">
							<BZ:dataValue field="MALE_PUNISHMENT_EN" onlyValue="true" defaultValue=""/>
							</span>	
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>	
							<span id="FE_FEMALE_PUNISHMENT_EN">
							<BZ:dataValue field="FEMALE_PUNISHMENT_EN" onlyValue="true" defaultValue=""/>
							</span>	
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">���޲����Ⱥ�</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>	
							<span id="FE_MALE_ILLEGALACT_EN">
							<BZ:dataValue field="MALE_ILLEGALACT_EN" onlyValue="true" defaultValue=""/>
							</span>	
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>	
							<span id="FE_FEMALE_ILLEGALACT_EN">
							<BZ:dataValue field="FEMALE_ILLEGALACT_EN" onlyValue="true" defaultValue=""/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">�ڽ�����</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_RELIGION_EN"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_RELIGION_EN"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">����״��</td>
						<td class="edit-data-value" colspan="4">�ѻ�</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">�������</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_DATE"  type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">����ʱ�����꣩</td>
						<td class="edit-data-value" colspan="2">
							<div id="FE_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">ǰ�����</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_MARRY_TIMES"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_MARRY_TIMES"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">���ҵ�λ</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue codeName="HBBZ" field="CURRENCY"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_YEAR_INCOME"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_YEAR_INCOME"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥ���ʲ�</td>
						<td class="edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">��ͥ��ծ��</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥ���ʲ�</td>
						<td class="edit-data-value" colspan="4">
							<div id="FE_TOTAL_MANNY"></div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">18����������Ů����</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��Ů���������</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥסַ</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">����Ҫ��</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					 
				</table>
			
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">��ɼҵ���֯����</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">��ͥ�����������</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">����������Σ�</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">�Ƽ��ţ��⣩</td>
						<td class="edit-data-value" width="19%">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue="" onlyValue="true"/>
					</tr>
					<tr>
						<td class="edit-data-title">������������</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="ADOPTER_HEART_REPORT" field="HEART_REPORT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="ADOPTER_ADOPT_MOTIVATION" field="HEART_REPORT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="ADOPTER_CHILDREN_ABOVE" field="CHILDREN_ABOVE" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>                                        
						<td class="edit-data-title">����ָ���໤��</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">��������Ű������</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_ABUSE_ABANDON" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>                                    
						<td class="edit-data-title">�����ƻ�</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">����ǰ׼��</td>
						<td class="edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">������ʶ</td>
						<td class="edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>                                    
						<td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
					</tr>
					
					<tr>
						<td class="edit-data-title">��������</td>
						<td class="edit-data-value">
							<BZ:dataValue field="PARENTING" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">�繤���</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="SGYJ" field="SOCIALWORKER" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">&nbsp;</td>
						<td class="edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="edit-data-title">��������������ͬס</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td>
						<td class="edit-data-title">����������ͬס˵��</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">��ͥ��˵������������</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">��׼����</td>
						<td class="edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">��Ч����</td>
						<td class="edit-data-value">							
							<div id="FE_VALID_PERIOD"></div>
						</td>
						<td class="edit-data-title">��׼��ͯ����</td>
						<td class="edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
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
						<td class="edit-data-value" width="19%">
							<BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="1" style="text-align:center"></td>
						<td class="edit-data-title" colspan="4" style="text-align:center">
						<b>������Ϣ</b></td>
						<td class="edit-data-title" colspan="1" style="text-align:center">
						</td>
					</tr>
					<tr>
						<td colspan="6">
						<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" ></IFRAME> 
						</td>
					</tr>					
				</table>
			</td>
		</tr>
	</table>
	</BZ:body>
</BZ:html>

