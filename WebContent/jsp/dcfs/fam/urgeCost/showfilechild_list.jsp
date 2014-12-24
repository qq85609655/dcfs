<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: showfilechild_list.jsp
 * @Description:  �ļ���ͯ�б�
 * @author yangrt
 * @date 2014-10-20 ����14:27:38 
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>�ļ���ͯ�б�</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<BZ:body codeNames="WJLX;PROVINCE;">
		<div class="page-content">
			<div class="wrapper">
				<!--�б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled">�ļ����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled">�ļ�����</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting_disabled">��������</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting_disabled">Ů������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled">ʡ��</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting_disabled">����Ժ</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled">��ͯ����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled">ͬ������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled">ǩ������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled">��������</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAMES" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SIGN_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ADVICE_FEEDBACK_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--�б���End -->
			</div>
		</div>
	</BZ:body>
</BZ:html>