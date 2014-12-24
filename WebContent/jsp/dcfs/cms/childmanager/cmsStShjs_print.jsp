<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: ʡ�����ʹ�ӡ��
 * @author wangzheng   
 * @date 2014-9-18
 * @version V1.0   
 */
 String postDate=(String)request.getAttribute("postDate");
 String postPerson=(String)request.getAttribute("postPerson");
 String allSize=(String)request.getAttribute("allSize");
 String normalSize=(String)request.getAttribute("normalSize");
 String specialSize=(String)request.getAttribute("specialSize");
%>
<BZ:html>
	<BZ:head>
		<title>���ϼ��ʹ�ӡ��</title>
        <BZ:webScript list="true"/>
        <link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
	</BZ:head>
	
<script type="text/javascript">
	//�ر�
	function _close(){
		window.close();
	}	

</script>
	<BZ:body codeNames="PROVINCE;ETSFLX;BCZL;ETXB;CHILD_TYPE"> 
	<div id='PrintArea'>   
	<div class="page-content">
		<table width="100%">
			<tr>
				<td colspan="2" align="center"><font size="+2"><span class="title3">����������ͯ���ϼ��͵�</span></font></td>
			</tr>
			<tr><td style="text-align: center; border-top:none; height:25px;">&nbsp;</td></tr>
			<tr>
			    <!-- <td align="left">���͵��ţ�</td> -->
				<td colspan="2" align="right">�������ڣ�<%=postDate %>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					<!--����б���Start -->
					<table class="table table-striped table-bordered table-hover dataTable table-print" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width:5%;">���</th>
								<th style="width:8%;">ʡ��</th>
								<th style="width:17%;">����Ժ</th>
								<th style="width:6%;">����</th>
								<th style="width:5%;">�Ա�</th>
								<th style="width:10%;">��������</th>
								<th style="width:7%;">�������</th>
								<th style="width:8%;">����</th>
								<th style="width:7%;">�Ƿ�ͬ��</th>
								<th style="width:11%;">��������</th>
								<th style="width:16%;">��ע</th>
							</tr>
							</thead>
							<tbody>	
								<BZ:for property="list">
									<tr>
										<td class="center">
											<BZ:i/>
										</td>
										<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
										<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
										<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
										<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
										<td>
										<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=ϣ��֮��"/>
										<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=����ƻ�"/>
										</td>
										<td align="center"><BZ:data field="IS_TWINS" onlyValue="true" defaultValue="0" checkValue="0=��;1=��"/></td>
										<td><BZ:data field="SN_TYPE"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
										<td>&nbsp;</td>
									</tr>
								</BZ:for>
							</tbody>
						</table>
						<!--��ѯ����б���End -->
					</td>
				</tr>
				<tr>
			    <td align="left">&nbsp;��<%=allSize %>�ݣ���������<%=normalSize %>�ݣ�����<%=specialSize %>��</td> 
				<td align="right">�����ˣ�<%=postPerson %>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
				</td>
			    </tr>
			</table>		
		</div>
	</div>
	<br>
	<!-- ��ť����:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="��ť��">
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">��ӡ</button>
			<!-- <input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()"/> -->&nbsp;&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>
		</div>
	</div>
	<!-- ��ť����:end -->
	</BZ:body>
	<script>
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
</BZ:html>
