<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: Ԥ����˺Ͷ�ͯ������Ϣ
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
		<title>Ԥ����˺Ͷ�ͯ������Ϣ</title>
		<BZ:webScript edit="true"/>
		<BZ:webScript list="true"/>
	</BZ:head>
	
	<BZ:body codeNames="PROVINCE;ETXB;BCZL;BCCD">
		<BZ:form name="srcForm" method="post" action="">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		
		<div class="page-content">
			<div class="wrapper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������ͯ������Ϣ</div>
				</div>
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled" id="PROVINCE_ID">
										ʡ��
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="WELFARE_NAME_CN">
										����Ժ
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="NAME">
										����
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="SEX">
										�Ա�
									</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="BIRTHDAY">
										��������
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="SPECIAL_FOCUS">
										�ر��ע
									</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="SN_TYPE">
										��������
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="SN_DEGREE">
										���г̶�
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="IS_TWINS">
										����ͬ��
									</div>
								</th>
								<th style="width:15%;">
									<div class="sorting_disabled" id="DISEASE_CN">
										�������
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="etList">
							<tr class="emptyData">
								<td>
									<BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="NAME" type="datetime"  defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"  />
								</td>
								<td>
									<BZ:data field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date"/>
								</td>
								<td>
									<BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
								</td>
								<td>
									<BZ:data field="SN_TYPE" defaultValue="" onlyValue="true" codeName="BCZL"/>
								</td>
								<td>
									<BZ:data field="SN_DEGREE" defaultValue="" onlyValue="true" codeName="BCCD" />
								</td>
								<td>
									<BZ:data field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
								</td>
								<td>
									<BZ:data field="DISEASE_CN" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
			</div>
		</div>
		<br/>
	
		<div class="page-content">
			<div class="wrapper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ�������Ϣ</div>
				</div>
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_LEVEL">
										��˼���
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_DATE">
										���ʱ��
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_USERNAME">
										�����
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_OPTION">
										��˽��
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_CONTENT_CN">
										������
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="ypshList" fordata="myData">
							<tr class="emptyData">
								<td>
									<BZ:data field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=���������;1=�������θ���;2=�ֹ���������"/>
								</td>
								<td>
									<BZ:data field="AUDIT_DATE" defaultValue="" onlyValue="true" type="datetime"/>
								</td>
								<td>
									<BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true" />
								</td>
								<%
								String type = ((Data)pageContext.getAttribute("myData")).getString("AUDIT_TYPE","");
								if("1".equals(type)){
							%>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="1=�ϱ�;2=ͨ��;3=��ͨ��;4=������Ϣ;7=�˻�����;8=�˻ؾ�����;"/></td>
							<%	}else{ %>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="2=���ͨ��;3=��˲�ͨ��;4=������Ϣ;"/></td>
							<%	} %>
								<%-- <td>
									<BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=ͨ��;1=��ͨ��;2=�˻ؾ�����;3=�����ļ�"  />
								</td> --%>
								<td>
									<BZ:data field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true" />
								</td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>