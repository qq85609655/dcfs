<%
/**   
 * @Title: payment_view.jsp
 * @Description:  缴费信息查看
 * @author yangrt   
 * @date 2014-8-27 18:20:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String file_code = (String)request.getAttribute("FILE_CODE");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>缴费信息查看</title>
		<BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//返回列表页
		function _goback(){
			window.location.href=path+'ffs/filemanager/PaymentList.action';
		}
	
		//查看文件详细信息
		function _showFileData(af_id){
			var url = path + "ffs/filemanager/SuppleFileShow.action?type=show&AF_ID=" + af_id;
			_open(url,"文件信息查看",1000,600);
			//window.open(url,this,'height=600,width=,top=50,left=150,toolbar=no,menubar=no,scrollbars=auto,resizable=no,location=no,status=no');
		}
	</script>
	<BZ:body property="data" codeNames="FYLB;JFFS;WJLX;">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>票据信息(Voucher information)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">缴费编号<br>Bill number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">缴费票号<br>Payment ticket number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="BILL_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">缴费类型<br>Bill category </td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">支付方式<br>Payment</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">应缴金额<br>Amount payable</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">票面金额<br>Amount on the check</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAR_VALUE" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">缴费内容<br>Payment content</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PAID_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">附件<br>Attachment</td>
							<td class="bz-edit-data-value" colspan="5">
								<up:uploadList attTypeCode="OTHER" id="R_ATTACHMENT" packageId="<%=file_code %>" smallType="<%=AttConstants.FAW_JFPJ %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">备注<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">到账日期<br>Transfer date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">到账金额<br>Amount transferred</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_VALUE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">到账状态<br>Transfer status</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_STATE" checkValue="0=to be confirmed;1=paid in full;2=underpaid;" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>文件信息</div>
				</div>
			</div>
		</div>
		<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
			<div class="wrapper">
				<!-- 内容区域 begin -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FILE_NO">文件编号(Log-in No.)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled" id="MALE_NAME">男收养人(Adoptive father)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled" id="FEMALE_NAME">女收养人(Adoptive mother)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="REG_DATE">登记日期(Regist date)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FILE_TYPE">文件类型(Document type)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AF_COST">应缴金额(Amount payable)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center">
									<a href="#" onclick="_showFileData('<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/>
									</a>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REG_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
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
		<!-- 按钮区域Start -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:body>
</BZ:html>