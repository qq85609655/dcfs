<%
/**   
 * @Title: ffs_af_singleparent_translation.jsp
 * @Description:  �ļ�����ҳ������Ů������
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
    <title>�ļ�����ҳ������Ů������</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;SEX;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		$(document).ready( function() {
			//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		    $('#tab-container').easytabs();
		    _setValidPeriod('<%=data.getString("VALID_PERIOD")%>');
		})
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
			strText = v + " ����";			
		}
		$("#FE_VALID_PERIOD_CN").text(strText);	
		$("#FE_VALID_PERIOD_EN").text(strText);
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
							<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������֯(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" onlyValue="true"/>
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
				<!--����������start-->
				<table id="tb_jzv_cn" class="specialtable">
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
									<td class="edit-data-value" width="26%"><BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>
									</td>
									<td class="edit-data-value" width="18%" rowspan="4">
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
									<td class="edit-data-title">����״��</td>
									<td class="edit-data-value">�ѻ�</td>
									<td class="edit-data-title">�������</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/></td>
								</tr>
								<tr>
									<td class="edit-data-title" colspan="5" style="text-align:center"><b>������׼��Ϣ</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">��׼����</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">��Ч����</td>
									<td class="edit-data-value">
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true" defaultValue=""/>";
											document.write(("-1"!=v)?v+" ��":"����");											
										</script>
									</td>
								</tr>
								<tr id="attarea1">
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>������Ϣ</b></td>										
								</tr>
								<tr id="attarea2">
									<td colspan="6">
									<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
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
							<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">������֯(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" onlyValue="true"/>
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
				<!--����������start-->
				<table id="tb_jzv_en" class="specialtable">
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
									<td class="edit-data-value" width="18%" rowspan="4">
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
									<td class="edit-data-title">����״��</td>
									<td class="edit-data-value">�ѻ�</td>
									<td class="edit-data-title">�������</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/></td>
								</tr>
								<tr>
									<td class="edit-data-title" colspan="5" style="text-align:center"><b>������׼��Ϣ</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">��׼����</td>
									<td class="edit-data-title">��׼����</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">��Ч����</td>
									<td class="edit-data-value">
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true" defaultValue=""/>";
											document.write(("-1"!=v)?v+" ��":"����");											
										</script>
									</td>                                       
								</tr>
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>������Ϣ</b></td>										
								</tr>
								<tr>
									<td colspan="6">
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr>                                    
							</table>
						</td>
					</tr>

				</table>
				<!--����������end-->                                
						</td>
					</tr>
				</table>     	
			</div>
			<!--��ͥ�������(��)��end-->                                
			</div>
		</div>
		<!--������Ϣ��start-->
		<div id="tranarea">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="edit-data-title" colspan="2" style="text-align:center"><b>������Ϣ</b></td>
                </tr>
                <tr>
					<td  class="edit-data-title" width="15%">����˵��</td>
					<td  class="edit-data-value">
					<BZ:dataValue field="TRANSLATION_DESC" type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
					</td>
				</tr>
			</table>
		</div>
		<!--������Ϣ��end-->
		<br>
		<!-- ��ť����:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="��ť��" id="buttonarea">
				<input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="beforeCNPrint();javascript:window.print();afterCNPrint();"/>&nbsp;&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<br/>
		<!-- ��ť����:end -->
	</BZ:body>
</BZ:html>
