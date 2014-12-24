<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: setsettle_list.jsp
	 * @Description:  
	 * @author    
	 * @date 2014-9-16 ����10:02:12 
	 * @version V1.0   
	 */
	 //1 ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>
	<BZ:head>
		<title>���޲����б�</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script>
	
		
		//���á��������޲�������
		function update_row(id){
			window.open(path + "sce/setSettle/showSettleMonth.action?showuuid=" + id,"window","width=280,height=210,top=220,left=550");
		}
		
		function open_tijiao(){
			document.srcForm.action = path + "sce/setSettle/settleParaList.action";
			document.srcForm.submit();
		}
		
		
	</script>
	<BZ:body>
		<BZ:form name="srcForm" method="post" action="sce/setSettle/settleParaList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="page-content">
			<div class="wrapper">
				<!--�б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 10%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="ONE_TYPE">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="THREE_TYPE">�㷢����</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="TWO_TYPE">�Ƿ��ر��ע</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="SETTLE_MONTHS">�������ޣ���λ���գ�</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="SETTLE_MONTHS">�������ޣ���λ���գ�</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="IS_VALID">�Ƿ���Ч</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting_disabled">����</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ONE_TYPE" defaultValue="" onlyValue="true" checkValue="1=�㷢;2=Ⱥ��;"/></td>
								<td><BZ:data field="THREE_TYPE" defaultValue="" onlyValue="true" checkValue="10=�Կڰ��;20=�ر��ע;30=ϣ��֮��;40=�쵼����;50=����;60=����Ӫ����Ӫ;"/></td>
								<td><BZ:data field="TWO_TYPE" defaultValue="" onlyValue="true" checkValue="0=���ر��ע;1=�ر��ע;"/></td>
								<td><BZ:data field="SETTLE_MONTHS" defaultValue="0" onlyValue="true" checkValue="0=δ��;"/></td>
								<td><BZ:data field="DEADLINE" defaultValue="δ��" onlyValue="true"/></td>
								<td><BZ:data field="IS_VALID" defaultValue="" onlyValue="true" checkValue="0=��Ч;1=��Ч;"/></td>
								<td><a href="#" onclick="update_row('<BZ:data field="SETTLE_ID" defaultValue="" onlyValue="true"/>');return false;">���޲�������</a></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--�б���End -->
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
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>