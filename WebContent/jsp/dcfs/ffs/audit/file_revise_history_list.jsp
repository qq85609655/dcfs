<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: �ļ��޸ļ�¼�б�
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
	
	String af_id = (String)request.getAttribute("AF_ID");
	
%>
<BZ:html>
	<BZ:head>
		<title>�ļ��޸ļ�¼�б�</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script type="text/javascript">	
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
		var af_id = $("#AF_ID").val();
		var obj = document.forms["srcForm"];
		obj.action=path+"ffs/jbraudit/findReviseList.action?AF_ID="+af_id;
	});
	</script>
	
	<BZ:body >
		<BZ:form name="srcForm" method="post" action="" >
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<input type="hidden" name="AF_ID" id="AF_ID" value="<%=af_id%>"/>
		
		<div class="page-content">
			<div class="wrapper">
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr >
								<th style="width: 5%;">
									<div>
										���
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_FIELD">
										�޸���Ŀ
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ORIGINAL_DATA">
										�޸�ǰ
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_DATA">
										�޸ĺ�
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REVISE_USERNAME">
										�޸���
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="UPDATE_DATE">
										�޸�����
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
									<BZ:data field="UPDATE_FIELD" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="ORIGINAL_DATA" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="UPDATE_DATA" defaultValue="" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="REVISE_USERNAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="UPDATE_DATE" defaultValue="" onlyValue="true" />
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