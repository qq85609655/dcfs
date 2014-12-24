<%
/**   
 * @Title: ffs_af_translation_view.jsp
 * @Description:  ˫�������ļ�����ҳ�鿴
 * @author wangz   
 * @date 2014-8-20
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	Data d = (Data)request.getAttribute("data");
	String afId = d.getString("AF_ID");
	String MALE_PHOTO = d.getString("MALE_PHOTO","");
	String FEMALE_PHOTO = d.getString("FEMALE_PHOTO","");
%>
<BZ:html>

<BZ:head>
    <title>�ļ�����ҳ��˫�ף�</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		var path = "<%=path%>";

		$(document).ready( function() {
			//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		    $('#tab-container').easytabs();
		})
			

	//�ر�
	function _close(){
		window.close();
	}

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
                <li class='tab'><a href="#tab1">������Ϣ(����)</a></li>
                <li class='tab'><a href="#tab2">������Ϣ(����)</a></li>
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
                    <!--˫��������start--> 
                    <table class="specialtable" id="tb_sqsy_cn">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--��������Ϣ��start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>                                    	
                                        <td class="edit-data-title" width="15%">&nbsp;</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">��������</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">Ů������</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">��������</td>
                                        <td class="edit-data-value" width="27%"><BZ:dataValue field="MALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                        <td class="edit-data-value" width="28%"><BZ:dataValue field="FEMALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/></td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">����</td>
                                    	<td class="edit-data-value">
                                    		<div id="tb_sqsy_cn_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge('<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" style="font-size:14px">
                                        	<div id="tb_sqsy_cn_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge('<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">����</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">���պ���</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">�ܽ����̶�</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">ְҵ</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_JOB_CN" defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
                                        	<script>
											var h = "<BZ:dataValue field="MALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" defaultValue=""/>');
											}
											</script>
                                        	
                                        </td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
											<script>
											var h = "<BZ:dataValue field="FEMALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>');
											}
											</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEIGHT" defaultValue=""/> ����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/> ����</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_WEIGHT" defaultValue=""/> ǧ��</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/> ǧ��</td>
                                    </tr>                                    
                                    <tr>
                                    	<td class="edit-data-title">����ָ��</td>
                                    	<td class="edit-data-value" colspan="2">
										<script>
											document.write(_bmi(<BZ:dataValue field="MALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="MALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    	<script>
											document.write(_bmi(<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>');
											}
											</script>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
									</tr>
                                    <tr>
                                        <td class="edit-data-title">���޲����Ⱥ�</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue=""/>');
											}
											</script>                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ڽ�����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_RELIGION_CN" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="4">�ѻ�</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" >�������</td>
                                        <td class="edit-data-value" ><BZ:dataValue field="MARRY_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title"  >����ʱ�����꣩</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											document.write(getAge('<BZ:dataValue type="Date" field="MARRY_DATE" onlyValue="true"/>'));
											</script>  											
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">ǰ�����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/>��
                                        </td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/>��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���ҵ�λ</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CURRENCY" codeName="ADOPTER_HEALTH" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_YEAR_INCOME" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value"><BZ:dataValue field="TOTAL_ASSET" defaultValue=""/></td>
                                        <td class="edit-data-title">��ͥ��ծ��</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="TOTAL_DEBT" defaultValue=""/></td>
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
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/> ��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��Ů���������</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CHILD_CONDITION_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥסַ</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADDRESS" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">����Ҫ��</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue=""/></td>
                                    </tr>
                                </table>
                                <table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">��ɼҵ���֯����</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">��ͥ�����������</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="FINISH_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title" width="15%">����������Σ�</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/></td>                                    
                                        <td class="edit-data-title" width="15%">�Ƽ��ţ��⣩</td>
                                        <td class="edit-data-value" width="19%"><BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������������</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_HEART_REPORT" defaultValue=""/></td>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_ADOPT_MOTIVATION" defaultValue=""/></td>                                    
                                        <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_ABOVE" codeName="ADOPTER_CHILDREN_ABOVE" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ָ���໤��</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FORMULATE" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                        <td class="edit-data-title">��������Ű������</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_ABUSE_ABANDON" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                    
                                        <td class="edit-data-title">�����ƻ�</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_MEDICALRECOVERY" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ǰ׼��</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="ADOPT_PREPARE" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                        <td class="edit-data-title">������ʶ</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="RISK_AWARENESS" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>                                            
                                        </td>
                                   
                                        <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_SUBMIT_REPORT" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                            
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="PARENTING" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                            
                                        </td>
                                        <td class="edit-data-title">�繤���</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="SOCIALWORKER" onlyValue="true"/>";
											var txt = "";
											switch (f)
											{
											case "":
												txt = "";
												break;
											case "1":
												txt = "֧��";
												break;
											case "2":
												txt = "�������";
												break;
											case "3":
												txt = "��֧��";
												break;											
											}
											document.write(txt);											
											</script>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������������ͬס</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                        <td class="edit-data-title">����������ͬס˵��</td>
                                        <td class="edit-data-value" colspan="3"><BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ��˵������������</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="REMARK_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��׼����</td>
                                        <td class="edit-data-value"><BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title">��Ч����</td>
                                        <td class="edit-data-value">
											<script>
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" ��":"����");											
											</script>
                                        </td>
                                        <td class="edit-data-title">��׼��ͯ����</td>
                                        <td class="edit-data-value"><BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������ͯ����</td>
                                        <td class="edit-data-value"><BZ:dataValue field="AGE_FLOOR" defaultValue=""/>��~ <BZ:dataValue field="AGE_UPPER" defaultValue=""/>��</td>
                                        <td class="edit-data-title">������ͯ�Ա�</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/></td>
                                        <td class="edit-data-title">������ͯ����״��</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_HEALTH_EN" codeName="ADOPTER_CHILDREN_HEALTH" defaultValue=""/></td>
                                    </tr>
									<tr id="attarea1">
										<td class="edit-data-title" colspan="6" style="text-align:center">
										<b>������Ϣ</b></td>										
                                    </tr>
									<tr id="attarea2">
										<td colspan="6">
										<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
                                </table>                                 
                            </td>
                        </tr> 
                    <!--˫��������end--> 
                    </table>
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
                                <BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                    </table>
                    <!--�ļ�������Ϣ��end-->
                    <!--˫��������start--> 
                    <table class="specialtable" id="tb_sqsy_en">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--��������Ϣ��start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>                                    	
                                        <td class="edit-data-title" width="15%">&nbsp;</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">��������</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">Ů������</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">��������</td>
                                        <td class="edit-data-value" width="27%"><BZ:dataValue field="MALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                        <td class="edit-data-value" width="28%"><BZ:dataValue field="FEMALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/></td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">����</td>
                                    	<td class="edit-data-value">
                                    		<div id="tb_sqsy_en_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge('<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" style="font-size:14px">
                                        	<div id="tb_sqsy_en_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge('<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">����</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">���պ���</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">�ܽ����̶�</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">ְҵ</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_JOB_EN" defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_JOB_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
                                        	<script>
											var h = "<BZ:dataValue field="MALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" defaultValue=""/>');
											}
											</script>
                                        	
                                        </td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
											<script>
											var h = "<BZ:dataValue field="FEMALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>');
											}
											</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEIGHT" defaultValue=""/> ����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/> ����</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_WEIGHT" defaultValue=""/> ǧ��</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/> ǧ��</td>
                                    </tr>                                    
                                    <tr>
                                    	<td class="edit-data-title">����ָ��</td>
                                    	<td class="edit-data-value" colspan="2">
										<script>
											document.write(_bmi(<BZ:dataValue field="MALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="MALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    	<script>
											document.write(_bmi(<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>');
											}
											</script>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
									</tr>
                                    <tr>
                                        <td class="edit-data-title">���޲����Ⱥ�</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>');
											}
											</script>                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ڽ�����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_RELIGION_EN" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title"  >����״��</td>
                                        <td class="edit-data-value" colspan="4">�ѻ�</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" >�������</td>
                                        <td class="edit-data-value" ><BZ:dataValue field="MARRY_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title" >����ʱ�����꣩</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											document.write(getAge('<BZ:dataValue type="Date" field="MARRY_DATE" onlyValue="true"/>'));
											</script>  											
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">ǰ�����</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/>��
                                        </td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/>��
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td class="edit-data-title">���ҵ�λ</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CURRENCY" codeName="ADOPTER_HEALTH" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_YEAR_INCOME" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="TOTAL_ASSET" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ��ծ��</td>
                                        <td class="edit-data-value"><BZ:dataValue field="TOTAL_DEBT" defaultValue=""/></td>
                                        <td class="edit-data-title" >��ͥ���ʲ�</td>
                                        <td class="edit-data-value" colspan="2">
                                            <script>
											document.write(_setTotalManny('<BZ:dataValue field="TOTAL_ASSET" onlyValue="true"/>','<BZ:dataValue field="TOTAL_DEBT" onlyValue="true"/>'));
											</script> 
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="edit-data-title">18����������Ů����</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/> ��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��Ů���������</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CHILD_CONDITION_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥסַ</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADDRESS" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">����Ҫ��</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue=""/></td>
                                    </tr>
                                </table>        
                            	<table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">��ɼҵ���֯����</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">��ͥ�����������</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="FINISH_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title" width="15%">����������Σ�</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/></td>                                    
                                        <td class="edit-data-title" width="15%">�Ƽ��ţ��⣩</td>
                                        <td class="edit-data-value" width="19%"><BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������������</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_HEART_REPORT" defaultValue=""/></td>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_ADOPT_MOTIVATION" defaultValue=""/></td>                                    
                                        <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_ABOVE" codeName="ADOPTER_CHILDREN_ABOVE" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ָ���໤��</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FORMULATE" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                        <td class="edit-data-title">��������Ű������</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_ABUSE_ABANDON" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                    
                                        <td class="edit-data-title">�����ƻ�</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_MEDICALRECOVERY" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ǰ׼��</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="ADOPT_PREPARE" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                        <td class="edit-data-title">������ʶ</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="RISK_AWARENESS" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>                                            
                                        </td>
                                   
                                        <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_SUBMIT_REPORT" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                            
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="PARENTING" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                            
                                        </td>
                                        <td class="edit-data-title">�繤���</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="SOCIALWORKER" onlyValue="true"/>";
											var txt = "";
											switch (f)
											{
											case "":
												txt = "";
												break;
											case "1":
												txt = "֧��";
												break;
											case "2":
												txt = "�������";
												break;
											case "3":
												txt = "��֧��";
												break;											
											}
											document.write(txt);											
											</script>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������������ͬס</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true"/>";
											document.write("0"==f?'��':'��');											
											</script>
                                        </td>
                                        <td class="edit-data-title">����������ͬס˵��</td>
                                        <td class="edit-data-value" colspan="3"><BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ��˵������������</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="REMARK_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��׼����</td>
                                        <td class="edit-data-value"><BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title">��Ч����</td>
                                        <td class="edit-data-value">
											<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" ��":"����");											
											</script>
                                        </td>
                                        <td class="edit-data-title">��׼��ͯ����</td>
                                        <td class="edit-data-value"><BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������ͯ����</td>
                                        <td class="edit-data-value"><BZ:dataValue field="AGE_FLOOR" defaultValue=""/>��~ <BZ:dataValue field="AGE_UPPER" defaultValue=""/>��</td>
                                        <td class="edit-data-title">������ͯ�Ա�</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/></td>
                                        <td class="edit-data-title">������ͯ����״��</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_HEALTH_EN" codeName="ADOPTER_CHILDREN_HEALTH" defaultValue=""/></td>
                                    </tr>
									<tr>
										<td class="edit-data-title" colspan="6" style="text-align:center">
										<b>������Ϣ</b></td>										
                                    </tr>
									<tr>
										<td colspan="6">
										<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
                                </table>                                 
                            </td>
                        </tr> 
                    <!--˫��������end--> 
                    </table>   
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
					<td  class="edit-data-value"><BZ:dataValue field="NOTICE_USERNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">֪ͨ����</td>
					<td  class="edit-data-value"><BZ:dataValue field="NOTICE_DATE" type="date" defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">��������</td>
					<td  class="edit-data-value"><BZ:dataValue field="RECEIVE_DATE" type="date" defaultValue=""/></td>
				</tr>
				<tr>
					<td  class="edit-data-title" width="15%">���뵥λ</td>
					<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_UNITNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">������</td>
					<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_USERNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">�������</td>
					<td  class="edit-data-value"><BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue=""/></td>
				</tr>
				<tr>
					<td  class="edit-data-title" width="15%">����״̬</td>
					<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
				</tr>
                <tr>
					<td  class="edit-data-title" width="15%">����˵��</td>
					<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_DESC"  defaultValue="" /></td>
				</tr>
			</table>
		</div>
		<!--������Ϣ��end-->
		<br/>
		<!-- ��ť����:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="��ť��" id="buttonarea">
				<input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="beforeCNPrint();javascript:window.print();afterCNPrint();"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<!-- ��ť����:end -->
		<br/>
	</BZ:body>
</BZ:html>
