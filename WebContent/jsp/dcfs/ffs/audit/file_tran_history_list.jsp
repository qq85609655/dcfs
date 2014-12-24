<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
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
		<BZ:webScript list="true"/>
	</BZ:head>
	<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
	});
	</script>
	<BZ:body  >
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findTranslationList.action">
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
									<div class="sorting" id="TRANSLATION_UNITNAME">
										���뵥λ
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTICE_DATE">
										�ͷ�ʱ��
									</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_USERNAME">
										��������
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_STATE">
										����״̬
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_USERNAME">
										������
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="COMPLETE_DATE">
										���ʱ��
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
									<BZ:data field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="NOTICE_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								
								<td>
									<BZ:data field="TRANSLATION_TYPE" defaultValue="" checkValue="0=�ļ�����;1=���䷭��;2=���·���"/>
								</td>
								<td>
									<BZ:data field="TRANSLATION_STATE" defaultValue=""  checkValue="0=������;1=������;2=�ѷ���" />
								</td>
								<td>
									<BZ:data field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="COMPLETE_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
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