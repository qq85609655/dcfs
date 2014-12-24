<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_jh_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 
 //����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
 Data data= (Data)request.getAttribute("data");
 String plan_state = data.getString("PLAN_STATE");//�ƻ�״̬
%>
<BZ:html>
	<BZ:head>
		<title>�������޸ļƻ�������Ϣҳ��</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		
		function _goback(){
			window.location.href=path+"sce/publishPlan/findListForFBJH.action";
		}
		
		//�����ƻ�������ύ  0������  1���ύ
		function saveFBJHInfo(method){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"sce/publishPlan/saveFBJHBaseInfo.action?method="+method;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<BZ:input type="hidden" field="PLAN_ID" prefix="H_"/>
			
		<div class="page-content">
			<div class="wrapper">
				
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
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>Ԥ������</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="DateTime" field="NOTE_DATE" prefix="J_"  formTitle="Ԥ������" notnull="������Ԥ������"/>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="DateTime" field="PUB_DATE" prefix="J_" formTitle="��������" notnull="�����뷢������"/>
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
								
							</table>
						</div>
					</div>
				</div> 
				<!-- �༭����end -->
				<br/>
				
				
			
				<!-- ��ť�� ��ʼ -->
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="��ť��">
					<%if("".equals(plan_state)||""==plan_state||"0".equals(plan_state)||"0"==plan_state||"null".equals(plan_state)||"null"==plan_state||null==plan_state){ %>
						<a href="reporter_files_list.html" >
							<input type="button" value="����" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(0);"/>
						</a>
					<%} %>
						<a href="reporter_files_list.html" >
							<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(1);"/>
						</a>
						<a href="reporter_files_list.html" >
							<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback()"/>
						</a>
					</div>
				</div>
				<!-- ��ť�� ���� -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>