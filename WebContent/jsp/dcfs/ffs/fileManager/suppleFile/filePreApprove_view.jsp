<%
/**   
 * @Title: filePreApprove_view.jsp
 * @Description:  �ļ�Ԥ����˼�¼
 * @author yangrt   
 * @date 2014-9-5 ����14:03:34 
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
		<title>�ļ�Ԥ����˼�¼</title>
		<BZ:webScript edit="true" list="true"/>
		<up:uploadResource isImage="true"/>
	</BZ:head>
	<BZ:body codeNames="ETXB;BCZL;WJSHYJ;WJSHCZZT;">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ��������ͯ������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
					<BZ:for property="childList" fordata="childData">
					<%
						String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
					%>
						<tr>
							<td class="bz-edit-data-title" width="13%">ʡ��<br>Provinces</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="PROVINCE_ID" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="13%">����Ժ<br>SWI</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="WELFARE_NAME_EN" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="13%">����<br>Name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" rowspan="3" width="16%">
								<img src='<up:attDownload attTypeCode="CMS" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">�ر��ע<br>Special Attention</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=No;1=Yes" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>Sick Species</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">�ļ��ݽ�����<br>Submission Deadline</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="VALID_PERIOD" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">����ͬ��<br>Is Twins</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=No;1=Yes" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�������<br>Disability Diagnosis</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue=""/>
							</td>
						</tr>
					</BZ:for>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ����˼�¼</div>
				</div>
				<!-- �������� end -->
				<div class="page-content">
					<div class="wrapper">
						<!--��ѯ����б���Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th style="width: 2%;">
											<div class="sorting_disabled">
												���(No.)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_USERNAME">
												��˼���
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_USERNAME">
												�����(Reviewed by)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_DATE">
												�������(Review date)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_OPTION">
												��˽��
											</div>
										</th>
										<th style="width: 10%;">
											<div class="sorting" id="AUDIT_CONTENT_CN">
												������(Review conclusion)
											</div>
										</th>
										<th style="width: 10%;">
											<div class="sorting" id="AUDIT_REMARKS">
												��ע(Remarks)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="OPERATION_STATE">
												��������
											</div>
										</th>
									</tr>
								</thead>
								<tbody>
								<BZ:for property="List">
									<tr class="emptyData">
										<td class="center">
											<BZ:i/>
										</td>
										<td>
											<BZ:data field="AUDIT_LEVEL" defaultValue="" checkValue="0=����;1=����;2=����"/>
										</td>
										<td>
											<BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true" />
										</td>
										<td>
											<BZ:data field="AUDIT_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
										</td>
										<td>
											<BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" codeName="WJSHYJ"  />
										</td>
										<td>
											<BZ:data field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true" />
										</td>
										<td>
											<BZ:data field="AUDIT_REMARKS" defaultValue="" onlyValue="true" />
										</td>
										<td>
											<BZ:data field="OPERATION_STATE" defaultValue="" onlyValue="true" codeName="WJSHCZZT"/>
										</td>
									</tr>
								</BZ:for>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
	</BZ:body>
</BZ:html>