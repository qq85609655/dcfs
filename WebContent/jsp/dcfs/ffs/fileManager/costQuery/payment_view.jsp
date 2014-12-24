<%
/**   
 * @Title: payment_view.jsp
 * @Description:  �ɷ���Ϣ�鿴
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
		<title>�ɷ���Ϣ�鿴</title>
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
		//�����б�ҳ
		function _goback(){
			window.location.href=path+'ffs/filemanager/PaymentList.action';
		}
	
		//�鿴�ļ���ϸ��Ϣ
		function _showFileData(af_id){
			var url = path + "ffs/filemanager/SuppleFileShow.action?type=show&AF_ID=" + af_id;
			_open(url,"�ļ���Ϣ�鿴",1000,600);
			//window.open(url,this,'height=600,width=,top=50,left=150,toolbar=no,menubar=no,scrollbars=auto,resizable=no,location=no,status=no');
		}
	</script>
	<BZ:body property="data" codeNames="FYLB;JFFS;WJLX;">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ʊ����Ϣ(Voucher information)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�ɷѱ��<br>Bill number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">�ɷ�Ʊ��<br>Payment ticket number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="BILL_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">�ɷ�����<br>Bill category </td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">֧����ʽ<br>Payment</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">Ӧ�ɽ��<br>Amount payable</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">Ʊ����<br>Amount on the check</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAR_VALUE" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ɷ�����<br>Payment content</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PAID_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">����<br>Attachment</td>
							<td class="bz-edit-data-value" colspan="5">
								<up:uploadList attTypeCode="OTHER" id="R_ATTACHMENT" packageId="<%=file_code %>" smallType="<%=AttConstants.FAW_JFPJ %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ע<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>Transfer date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">���˽��<br>Amount transferred</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_VALUE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">����״̬<br>Transfer status</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_STATE" checkValue="0=to be confirmed;1=paid in full;2=underpaid;" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�鿴����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ļ���Ϣ</div>
				</div>
			</div>
		</div>
		<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
			<div class="wrapper">
				<!-- �������� begin -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FILE_NO">�ļ����(Log-in No.)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled" id="MALE_NAME">��������(Adoptive father)</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled" id="FEMALE_NAME">Ů������(Adoptive mother)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="REG_DATE">�Ǽ�����(Regist date)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FILE_TYPE">�ļ�����(Document type)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="AF_COST">Ӧ�ɽ��(Amount payable)</div>
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
		<!-- �༭����end -->
		<!-- ��ť����Start -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>