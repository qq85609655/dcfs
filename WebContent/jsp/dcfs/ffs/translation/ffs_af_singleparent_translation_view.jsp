<%
/**   
 * @Title: ffs_af_singleparent_translation.jsp
 * @Description:  �ļ�����ҳ������������
 * @author wangz   
 * @date 2014-8-11 ����10:00:00 
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
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
    <title>�ļ�����ҳ������������</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" ></link>
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>	
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND;SEX;">

<script type="text/javascript">
	var path = "<%=path%>";
	$(document).ready( function() {
			//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		    $('#tab-container').easytabs();
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

	//�ر�
	function _close(){
		window.close();
	}
	
	//-----  �����Ǵ�ӡ�������  ----------
	window.onbeforeprint=beforeCNPrint;
	window.onafterprint=afterCNPrint;
	//��ӡ֮ǰ���ز����ӡ��������Ϣ
	function beforeCNPrint()
	{
		_title.style.display='none';
		tab2.style.display='none';
		attarea1.style.display='none';
		attarea2.style.display='none';
		buttonarea.style.display='none';
		tranarea.style.display='none';
	}
	//��ӡ֮�����ص�����Ϣ����ʾ����
	function afterCNPrint()
	{
		_title.style.display='';
		attarea1.style.display='';
		attarea2.style.display='';
		buttonarea.style.display='';
		tranarea.style.display='';
	}
	
	</script>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs' id="_title">
				<li class='tab' id="tb1"><a href="#tab1">������Ϣ(����)</a></li>
				<li class='tab' id="tb2"><a href="#tab2">������Ϣ(����)</a></li>
		</ul>
		<div class='panel-container'>
			<!--��ͥ�������(��)��start-->
			<div id="tab1">
				<!--�ļ�������Ϣ��start-->
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">������֯(CN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������֯(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">�ļ�����</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">��������</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">���ı��</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!--�ļ�������Ϣ��end-->                   
				<!--����������start-->
				<table id="tb_dqsy_cn" class="specialtable">
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
									<td class="edit-data-value" width="18%" rowspan="6">
										<%if("1".equals(ADOPTER_SEX)){%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}else{%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">���պ���</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">�ܽ����̶�</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue  codeName="ADOPTER_EDU" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">ְҵ</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����״��</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>
									</td>
									<%}else{%><BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH" defaultValue="" onlyValue="true"/>
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}%>����
									</td>
									<td class="edit-data-title">����</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_RELIGION_CN" defaultValue=""/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_RELIGION_CN" defaultValue=""/>
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
									<BZ:dataValue type="String" field="MALE_YEAR_INCOME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͥ���ʲ�</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue=""/></td>
									<td class="edit-data-title">��ͥ��ծ��</td>
									<td class="edit-data-value" colspan="2"><BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue=""/></td>
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
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="UNDERAGE_NUM" defaultValue=""/> ��
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��Ů���������</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="CHILD_CONDITION_CN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͥסַ</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADDRESS" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����Ҫ��</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADOPT_REQUEST_CN" defaultValue=""/>
									</td>
								</tr>
							</table>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">��ɼҵ���֯����</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="HOMESTUDY_ORG_NAME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" style="width:15%">��ͥ�����������</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="date" field="FINISH_DATE" defaultValue=""/>
									</td>
									<td class="edit-data-title" style="width:15%">����������Σ�</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="String" field="INTERVIEW_TIMES" defaultValue=""/>
									</td>                                    
									<td class="edit-data-title" style="width:15%">�Ƽ��ţ��⣩</td>
									<td class="edit-data-value" style="width:19%"><BZ:dataValue type="String" field="RECOMMENDATION_NUM" defaultValue=""/>
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
									<td class="edit-data-value"><BZ:dataValue field="SOCIALWORKER" defaultValue="" onlyValue="true" checkValue="1=֧��;2=�������;3=��֧��"/>										
									</td>
									<td class="edit-data-title">&nbsp;</td>
									<td class="edit-data-value">&nbsp;</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������������ͬס</td>
									<td class="edit-data-value"><BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
									</td>
									<td class="edit-data-title">����������ͬס˵��</td>
									<td class="edit-data-value" colspan="3"><BZ:dataValue type="String" field="IS_FAMILY_OTHERS_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͥ��˵������������</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="REMARK_CN" defaultValue="" onlyValue="true"/>
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
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" ��":"����");											
										</script>
									</td>
									<td class="edit-data-title">��׼��ͯ����</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">������ͯ����</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="AGE_FLOOR" defaultValue="" onlyValue="true"/>��~<BZ:dataValue type="String" field="AGE_UPPER" defaultValue="" onlyValue="true"/>��
									</td>
									<td class="edit-data-title">������ͯ�Ա�</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_SEX" field="CHILDREN_SEX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">������ͯ����״��</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr id="attarea1">
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>������Ϣ</b></td>										
								</tr>
								<tr id="attarea2">
									<td colspan="6">
									<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> 
				<!--����������end-->
			</div>
			<!--��ͥ�������(��)��end-->
			<!--��ͥ�������(��)��start-->
			<div id="tab2">
				<!--�ļ�������Ϣ��start-->
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">������֯(CN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������֯(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">�ļ�����</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">��������</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">���ı��</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" hrefTitle="���ı��" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!--�ļ�������Ϣ��end-->                   
				<!--��������(EN)��start-->
				<table id="tb_dqsy_cn" class="specialtable">
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									
									<td class="edit-data-title" width="15%">�Ա�</td>
									<td class="edit-data-value" width="26%">
									<BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="" onlyValue="true"/>
									</td>
									
									<td class="edit-data-value" width="18%" rowspan="6">
										<%if("1".equals(ADOPTER_SEX)){%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}else{%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">����</td>
									<td class="edit-data-value">
										<div id="tb_dqsy_cn_MALE_AGE" style="font-size:14px">
										<script>
										document.write(getAge('<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}%>'));
										</script>
										</div>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">���պ���</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">�ܽ����̶�</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue  codeName="ADOPTER_EDU" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">ְҵ</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����״��</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>
									</td>
									<%}else{%><BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>
									</td>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">���</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}%>����
									</td>
									<td class="edit-data-title">����</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
									<%}%>ǧ��
									</td>
								</tr>                                    
								<tr>
									<td class="edit-data-title">����ָ��</td>
									<td class="edit-data-value" colspan="4">
									<%if("1".equals(ADOPTER_SEX)){%>
									<script>
										document.write(_bmi(<BZ:dataValue field="MALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="MALE_WEIGHT" onlyValue="true"/>));
									</script>
									<%}else{%>
									<script>
										document.write(_bmi(<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true"/>));
									</script>
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
										<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
									</td>
									<%}else{%>
									<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
									</td>
									<td class="edit-data-value" colspan="3">
										<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
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
										<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>
									</td>
									<%}else{%>
									<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=��;1=��"/>
									</td>
									<td class="edit-data-value" colspan="3">
										<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
									</td>
									<%}%>									
								</tr>
								<tr>
									<td class="edit-data-title">�ڽ�����</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_RELIGION_EN" defaultValue=""/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_RELIGION_EN" defaultValue=""/>
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
									<BZ:dataValue type="String" field="MALE_YEAR_INCOME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͥ���ʲ�</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue=""/></td>
									<td class="edit-data-title">��ͥ��ծ��</td>
									<td class="edit-data-value" colspan="2"><BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue=""/></td>
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
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="UNDERAGE_NUM" defaultValue=""/> ��
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��Ů���������</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="CHILD_CONDITION_EN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͥסַ</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADDRESS" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����Ҫ��</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADOPT_REQUEST_EN" defaultValue=""/>
									</td>
								</tr>
							</table>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">��ɼҵ���֯����</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="HOMESTUDY_ORG_NAME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" style="width:15%">��ͥ�����������</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="date" field="FINISH_DATE" defaultValue=""/>
									</td>
									<td class="edit-data-title" style="width:15%">����������Σ�</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="String" field="INTERVIEW_TIMES" defaultValue=""/>
									</td>                                    
									<td class="edit-data-title" style="width:15%">�Ƽ��ţ��⣩</td>
									<td class="edit-data-value" style="width:19%"><BZ:dataValue type="String" field="RECOMMENDATION_NUM" defaultValue=""/>
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
									<td class="edit-data-value"><BZ:dataValue field="SOCIALWORKER" defaultValue="" onlyValue="true" checkValue="1=֧��;2=�������;3=��֧��"/>										
									</td>
									<td class="edit-data-title">&nbsp;</td>
									<td class="edit-data-value">&nbsp;</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������������ͬס</td>
									<td class="edit-data-value"><BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true" defaultValue="" defaultValue="" checkValue="0=��;1=��"/>
									</td>
									<td class="edit-data-title">����������ͬס˵��</td>
									<td class="edit-data-value" colspan="3"><BZ:dataValue type="String" field="IS_FAMILY_OTHERS_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͥ��˵������������</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="REMARK_EN" defaultValue="" onlyValue="true"/>
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
									<td class="edit-data-value"><BZ:dataValue field="VALID_PERIOD_TYPE" onlyValue="true" defaultValue="" checkValue="1=��Ч����;2=����"/>
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" ��":"����");											
										</script>
									</td>
									<td class="edit-data-title">��׼��ͯ����</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">������ͯ����</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="AGE_FLOOR" defaultValue="" onlyValue="true"/>��~<BZ:dataValue type="String" field="AGE_UPPER" defaultValue="" onlyValue="true"/>��
									</td>
									<td class="edit-data-title">������ͯ�Ա�</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_SEX" field="CHILDREN_SEX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">������ͯ����״��</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>������Ϣ</b></td>										
								</tr>
								<tr>
									<td colspan="6">
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> 
				<!--����������end-->
			</div>  	
			<!--��ͥ�������(��)��end-->                                
		</div>
	</div>
	<!--������Ϣ��start-->
	<div id="tranarea">
		<table class="specialtable" align="center" style="width:98%;text-align:center">
			<tr>
				<td class="edit-data-title" colspan="6" style="text-align:center"><b>������Ϣ</b></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">����֪ͨ��</td>
				<td  class="edit-data-value"><BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">֪ͨ����</td>
				<td  class="edit-data-value"><BZ:dataValue field="NOTICE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">��������</td>
				<td  class="edit-data-value"><BZ:dataValue field="RECEIVE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">���뵥λ</td>
				<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_UNITNAME"  defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">������</td>
				<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_USERNAME"  defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">�������</td>
				<td  class="edit-data-value"><BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">����״̬</td>
				<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">����˵��</td>
				<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_DESC"  defaultValue="" onlyValue="true"/></td>
			</tr>
		</table>
	</div>
	<br>
		<!-- ��ť����:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="��ť��" id="buttonarea">
				<input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="beforeCNPrint();javascript:window.print();afterCNPrint();"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<!-- ��ť����:end -->
	</BZ:body>
</BZ:html>
