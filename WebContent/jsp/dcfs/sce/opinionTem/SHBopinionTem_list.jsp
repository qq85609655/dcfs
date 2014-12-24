<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: SHBopinionTem.jsp
	 * @Description:  
	 * @author    
	 * @date 2014-10-09 ����1:09:18 
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
		<title>��˲�Ԥ��������ģ���б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
	
		//�鿴
		function show_row(id){
			var url = path + "sce/opinionTem/showOpinionTem.action?type=show&AAM_ID=" + id;
			modalDialog(url, this, 950, 200);
		}
		
		//�޸�
		function update_row(id){
			window.open(path + "sce/opinionTem/showOpinionTem.action?type=mod&AAM_ID=" + id,"window","width=950,height=260,top=200,left=200,scrollbars=yes");
		}
		
		function open_tijiao(){
			document.srcForm.action = path + "sce/opinionTem/SHBfindListTem.action";
			document.srcForm.submit();
		}
		
		
	</script>
	<BZ:body codeNames="WJMBLX;WJSHYJ;WJSHJB">
		<BZ:form name="srcForm" method="post" action="sce/opinionTem/SHBfindListTem.action">
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
								<th style="width: 18%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="IS_CONVENTION_ADOPT">ģ������</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="AUDIT_OPTION">������</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="AUDIT_TYPE">��˼���</div>
								</th>
								<th style="width: 23%;">
									<div class="sorting_disabled" id="AUDIT_MODEL_CONTENT">ģ������</div>
								</th>
								<th style="width: 10%;">
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
								<td><a href="#" onclick="show_row('<BZ:data field="AAM_ID" defaultValue="" onlyValue="true"/>');return false;"><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="IS_CONVENTION_ADOPT" defaultValue="" codeName="WJMBLX" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_OPTION" defaultValue="" codeName="WJSHYJ" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_TYPE" defaultValue="" codeName="WJSHJB" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_MODEL_CONTENT" defaultValue="" /></td>
								<td><a href="#" onclick="update_row('<BZ:data field="AAM_ID" defaultValue="" onlyValue="true"/>');return false;">�޸�</a></td>
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