<%
/**   
 * @Title: filePreApprove_view.jsp
 * @Description:  文件预批审核记录
 * @author yangrt   
 * @date 2014-9-5 下午14:03:34 
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
		<title>文件预批审核记录</title>
		<BZ:webScript edit="true" list="true"/>
		<up:uploadResource isImage="true"/>
	</BZ:head>
	<BZ:body codeNames="ETXB;BCZL;WJSHYJ;WJSHCZZT;">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批锁定儿童基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
					<BZ:for property="childList" fordata="childData">
					<%
						String photo_card = ((Data)pageContext.getAttribute("childData")).getString("PHOTO_CARD","");
					%>
						<tr>
							<td class="bz-edit-data-title" width="13%">省份<br>Provinces</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="PROVINCE_ID" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="13%">福利院<br>SWI</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="WELFARE_NAME_EN" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="13%">姓名<br>Name</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" rowspan="3" width="16%">
								<img src='<up:attDownload attTypeCode="CMS" packageId='<%=photo_card %>' smallType="<%=AttConstants.CI_IMAGE %>"/>'/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">性别<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" property="childData" codeName="ETXB" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" property="childData" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">特别关注<br>Special Attention</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childData" checkValue="0=No;1=Yes" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残种类<br>Sick Species</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" property="childData" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">文件递交期限<br>Submission Deadline</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="VALID_PERIOD" property="childData" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">有无同胞<br>Is Twins</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="IS_TWINS" property="childData" checkValue="0=No;1=Yes" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">病残诊断<br>Disability Diagnosis</td>
							<td class="bz-edit-data-value" colspan="6">
								<BZ:dataValue field="DISEASE_EN" property="childData" defaultValue=""/>
							</td>
						</tr>
					</BZ:for>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批审核记录</div>
				</div>
				<!-- 标题区域 end -->
				<div class="page-content">
					<div class="wrapper">
						<!--查询结果列表区Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th style="width: 2%;">
											<div class="sorting_disabled">
												序号(No.)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_USERNAME">
												审核级别
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_USERNAME">
												审核人(Reviewed by)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_DATE">
												审核日期(Review date)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="AUDIT_OPTION">
												审核结果
											</div>
										</th>
										<th style="width: 10%;">
											<div class="sorting" id="AUDIT_CONTENT_CN">
												审核意见(Review conclusion)
											</div>
										</th>
										<th style="width: 10%;">
											<div class="sorting" id="AUDIT_REMARKS">
												备注(Remarks)
											</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting" id="OPERATION_STATE">
												操作处理
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
											<BZ:data field="AUDIT_LEVEL" defaultValue="" checkValue="0=初审;1=复审;2=审批"/>
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
		<!-- 编辑区域end -->
	</BZ:body>
</BZ:html>