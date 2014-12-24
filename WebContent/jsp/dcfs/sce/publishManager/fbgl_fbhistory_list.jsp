<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_fbhistory_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 Data data= (Data)request.getAttribute("data");
 String IS_TWINS = data.getString("IS_TWINS");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ���η�����Ϣ</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
		//�鿴�÷�����¼������֯�б�
		function _showFbOrgList(pub_id){
			$.layer({
				type : 2,
				title : "���η�����֯�б�",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/findListForFBORG.action?pub_id='+pub_id},
				area: ['1150px','800px'],
				offset: ['0px' , '0px']
			});
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;">
		<BZ:form name="srcForm" method="post">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		
		
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
							<div>��ͯ������Ϣ</div>
						</div>
						<!-- �������� end -->
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%">ʡ��</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE"  defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">����Ժ</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">����</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�Ա�</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" checkValue="1=��;2=Ů;3=����"/>
									</td>
									<td class="bz-edit-data-title" width="10%">��������</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date" />
									</td>
									
									<td class="bz-edit-data-title" width="10%">��������</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">�ر��ע</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�Ƿ���̥</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
									</td>
									<td class="bz-edit-data-title" width="10%"><%if("1".equals(IS_TWINS)||"1"==IS_TWINS){ %>ͬ������<%} %></td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:dataValue field="TB_NAME" defaultValue="" onlyValue="true"/>
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
							<div>���η�����¼�б�</div>
						</div>
						<!-- �������� end -->
						<!--��ѯ����б���Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th style="width: 4%;">
											<div class="sorting_disabled">���</div>
										</th>
										<th style="width:9%;">
											<div class="sorting_disabled" id="PUB_DATE">��������</div>
										</th>
										<th style="width: 4%;">
											<div class="sorting_disabled" id="PUB_TYPE">��������</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="PUB_MODE">�㷢����</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="PUB_ORGID">������֯</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="PUB_REMARKS">�㷢��ע</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="PUBLISHER_NAME">������</div>
										</th>
										<th style="width: 9%;">
											<div class="sorting_disabled" id="REVOKE_DATE">������������</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="REVOKE_USERNAME">����������</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="REVOKE_REASON">��������ԭ��</div>
										</th>
										
									</tr>
								</thead>
								<tbody>
								<BZ:for property="List" fordata="resultData">
									<tr class="emptyData">
										<td class="center">
											<BZ:i/>
										</td>
										<td><BZ:data field="PUB_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
										<td><BZ:data field="PUB_TYPE" defaultValue=""  checkValue="1=�㷢;2=Ⱥ��" onlyValue="true"/></td>
										<td><BZ:data field="PUB_MODE" defaultValue=""  codeName="DFLX" onlyValue="true"/></td>
										<td>
											<%
											   Data resultData=(Data)pageContext.getAttribute("resultData");
											   String pubOrgId = resultData.getString("PUB_ORGID","");
												if(null!=pubOrgId&&!"".equals(pubOrgId)){
											     if(pubOrgId.indexOf(",")>0){
											 %>
											 <a href="javascript:_showFbOrgList('<BZ:data field="PUB_ID" defaultValue="" onlyValue="true" />')" title="����鿴������֯��Ϣ">
											 	Ⱥ��
											 </a>
											 <%
											   }else{
											 %>
											 	<BZ:data field="PUB_ORGID" defaultValue=""  codeName="SYS_ADOPT_ORG" length="20"/>
											 <% 
											   }
											}
											 %>
											
										</td>
										<td><BZ:data field="PUB_REMARKS" defaultValue="" length="20"/></td>
										<td><BZ:data field="PUBLISHER_NAME" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="REVOKE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
										<td><BZ:data field="REVOKE_USERNAME" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="REVOKE_REASON" defaultValue="" length="20"/></td>
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