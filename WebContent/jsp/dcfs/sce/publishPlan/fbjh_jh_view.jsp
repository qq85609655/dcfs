<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data hxData = (Data)request.getAttribute("data");
	String plan_id =hxData.getString("PLAN_ID");

 %>
<BZ:html>
	<BZ:head>
		<title>�鿴�����ƻ���ϸҳ��</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<BZ:input type="hidden" prefix="H_" field="PLAN_ID" id="H_PLAN_ID" defaultValue="<%=plan_id %>"/>
		<BZ:input type="hidden" field="PUB_NUM" prefix="H_"/>
		<BZ:input type="hidden" field="REMOVE_CIIDS" prefix="H_" id="H_REMOVE_CIIDS"/>
		
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!-- �༭����begin -->
				<div class="bz-edit clearfix" desc="�༭����">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>�����ƻ�������Ϣ</div>
						</div>
						<!-- �������� end -->
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%">Ԥ������</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="NOTE_DATE"  type="date" />
									</td>
									<td class="bz-edit-data-title" width="10%">��������</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PUB_DATE"  type="date" />
									</td>
									<td class="bz-edit-data-title" width="10%">�ƶ���</td>
									<td class="bz-edit-data-value"   width="12%">
										<BZ:dataValue field="PLAN_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�ƶ�����</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PLAN_DATE" defaultValue="" onlyValue="true" type="Date"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">��ͯ����</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�ر��ע����</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM_TB" defaultValue=""  onlyValue="true" />
									</td>
									<td class="bz-edit-data-title" width="10%">���ر��ע����</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PUB_NUM_FTB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- �༭����end -->
				<br/>
				
				<div class="bz-edit clearfix" desc="�༭����">
					<div class="ui-widget-content ui-corner-all">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>��ѡ���ͯ�б�</div>
						</div>
						<!-- �������� end -->
						<!--��ѯ����б���Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th style="width: 3%;">
											<div class="sorting_disabled">���</div>
										</th>
										<th style="width:5%;">
											<div class="sorting_disabled" id="PROVINCE_ID">ʡ��</div>
										</th>
										<th style="width: 9%;">
											<div class="sorting_disabled" id="WELFARE_NAME_CN">����Ժ</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="NAME">����</div>
										</th>
										<th style="width: 3%;">
											<div class="sorting_disabled" id="SEX">�Ա�</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="BIRTHDAY">��������</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="SN_TYPE">��������</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="SPECIAL_FOCUS">�ر��ע</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="PUB_TYPE">��������</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="PUB_ORGID">������֯</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="PUB_MODE">�㷢����</div>
										</th>
										<th style="width: 10%;">
											<div class="sorting_disabled" id="PUB_REMARKS">�㷢��ע</div>
										</th>
										
									</tr>
								</thead>
								<tbody>
									<BZ:for property="List">
										<tr class="emptyData">
											<td class="center">
												<BZ:i/>
											</td>
											<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""   onlyValue="true"/></td>
											<td><BZ:data field="NAME" defaultValue=""  codeName="DFLX" onlyValue="true"/></td>
											<td><BZ:data field="SEX" defaultValue="" checkValue="1=��;2=Ů;3=����" length="20"/></td>
											<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
											<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
											<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_TYPE" defaultValue="" checkValue="1=�㷢;2=Ⱥ��" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_ORGID" defaultValue="" codeName="SYS_ADOPT_ORG" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_MODE" defaultValue="" codeName="DFLX" onlyValue="true"/></td>
											<td><BZ:data field="W_PUB_REMARKS" defaultValue=""  onlyValue="true"/></td>
										</tr>
									</BZ:for>
								</tbody>
							</table>
						</div>
						<!--��ѯ����б���End -->
					</div>
				</div>
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>