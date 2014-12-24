<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>����ȷ�ϲ鿴ҳ��</title>
		<BZ:webScript edit="true" list="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"fam/receiveconfirm/ReceiveConfirmList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="JFFS;FYLB;WJLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- �༭����begin -->
		<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
			<div class="wrapper">
				<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>Ʊ����Ϣ</div>
						</div>
						<!-- �������� end -->
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="15%">�ɷѱ��</td>
									<td class="bz-edit-data-value" width="18%">
										<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="15%">�ɷѷ�ʽ</td>
									<td class="bz-edit-data-value" width="18%"> 
										<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="15%">��������</td>
									<td class="bz-edit-data-value" width="19%">
										<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">Ӧ�ɽ��</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">Ʊ����</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">���˽��</td>
									<td class="bz-edit-data-value"> 
										<BZ:dataValue field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">��������</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">ʹ������˻����</td>
									<td class="bz-edit-data-value"> 
										<BZ:dataValue field="ARRIVE_ACCOUNT_VALUE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">&nbsp;</td>
									<td class="bz-edit-data-value">&nbsp;</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title">�տ�ժҪ</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="ARRIVE_REMARKS" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!--�б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">���ı��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">�ļ�����</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">��������</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">Ů������</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">��ͯ����</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--�б���End -->
			</div>
		</div>
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>