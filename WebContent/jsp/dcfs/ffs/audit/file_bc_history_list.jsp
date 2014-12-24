<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Description: �ļ������¼�б�
 * @author mayun   
 * @date 2014-8-14
 * @version V1.0   
 */
	String compositor = (String) request.getAttribute("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
%>
<BZ:html>
	<BZ:head>
		<title>�ļ������¼�б�</title>
		<up:uploadResource/>
		<BZ:webScript list="true" edit="true"/>
	</BZ:head>
	<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
	});
	</script>
	<BZ:body  codeNames="SYWJBC">
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findBcRecordList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
	
		<div class="page-content">
			<div class="wrapper">
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<tbody>
						<div class="ui-state-default bz-edit-title" desc="����">
								<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
								<div>�����¼</div>
							</div>
						<BZ:for property="bcFileList" fordata="resultData">
						<%
							Data data = (Data)pageContext.getAttribute("resultData");
							String aaId = data.getString("AA_ID");
						 %>
							
							<table class="bz-edit-data-table" border="0" >
								<colgroup>
									<col width="10%" />
									<col width="15%" />
									<col width="10%" />
									<col width="15%" />
									<col width="10%" />
									<col width="15%" />
								</colgroup>
								<tr class="emptyData">
									<td class="bz-edit-data-title">֪ͨ��</td>
									<td class="bz-edit-data-value">
										<BZ:data field="SEND_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">֪ͨ����</td>
									<td class="bz-edit-data-value">
										<BZ:data field="NOTICE_DATE" defaultValue="" type="date" dateFormat="yyyy-MM-dd" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">�Ƿ������޸Ļ�����Ϣ</td>
									<td class="bz-edit-data-value" >
										<BZ:data field="IS_MODIFY" defaultValue="" checkValue="0=��;1=��"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">�Ƿ������丽��</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:data field="IS_ADDATTACH" defaultValue="" checkValue="0=��;1=��"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">֪ͨ����</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:data field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">�ظ���</td>
									<td class="bz-edit-data-value">
										<BZ:data field="FEEDBACK_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">�ظ�����</td>
									<td class="bz-edit-data-value">
										<BZ:data field="FEEDBACK_DATE" defaultValue="" type="date"  dateFormat="yyyy-MM-dd" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">����״̬</td>
									<td class="bz-edit-data-value" >
										<BZ:data field="AA_STATUS" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">�ظ�����</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:data field="ADD_CONTENT_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								
								<tr>
									<td class="bz-edit-data-title">�ظ�����</td>
									<td class="bz-edit-data-value" colspan="5">
										<up:uploadList id="UPLOAD_IDS" attTypeCode="AF" packageId="<%=aaId %>" smallType="<%=AttConstants.AF_WJBC %>"/>
									</td>
								</tr>
								
							</table>
							<br/>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				
				<!--��ҳ������Start -->
				<div class="footer-frame" >
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="bcFileList"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>