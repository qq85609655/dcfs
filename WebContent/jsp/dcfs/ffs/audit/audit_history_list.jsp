<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: �ļ���˼�¼�б�
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
		<title>�ļ���˼�¼�б�</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
	});
	</script>
	
	<BZ:body codeNames="WJSHYJ;WJSHCZZT">
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findAuditList.action">
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
						<thead>
							<tr>
								<th style="width: 2%;">
									<div class="sorting_disabled">
										���
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_USERNAME">
										��˼���
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_USERNAME">
										�����
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_DATE">
										�������
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUDIT_OPTION">
										��˽��
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="AUDIT_CONTENT_CN">
										������
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="AUDIT_REMARKS">
										��ע
									</div>
								</th>
								<!-- 
								<th style="width: 5%;">
									<div class="sorting" id="OPERATION_STATE">
										��������
									</div>
								</th>
								 -->
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
									<BZ:data field="AUDIT_DATE" type="datetime"  defaultValue="" onlyValue="true" />
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
								<!-- 
								<td>
									<BZ:data field="OPERATION_STATE" defaultValue="" onlyValue="true" codeName="WJSHCZZT"/>
								</td>
								 -->
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List"/></td>
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