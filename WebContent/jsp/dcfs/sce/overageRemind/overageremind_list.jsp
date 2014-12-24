<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: overageremind_list.jsp
	 * @Description:  ��ͯ���������б�
	 * @author panfeng   
	 * @date 2014-9-16  ����2:39:31 
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
		<title>��ͯ���������б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','180px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/overageRemind/overageRemindList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_NAME_CN").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_CA_STATUS").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
		}
		//�鿴��ͯ��Ϣ
		function _showDetail(){
			var num = 0;
			var CIids = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					 CIids =arrays[i].value.split("#")[0];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴�Ĳ��ϣ�");
				return;
			}else{
				$.layer({
					type : 2,
					title : "��ͯ���ϲ鿴",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					//page : {dom : '#planList'},
					iframe: {src: '<BZ:url/>/sce/overageRemind/showChildInfo.action?CIids='+CIids},
					area: ['1050px','550px'],
					offset: ['0px' , '50px']
				});
			}
		}

	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;PROVINCE;CHILD_TYPE">
		<BZ:form name="srcForm" method="post" action="sce/overageRemind/overageRemindList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
							    <td class="bz-search-title" style="width: 10%">ʡ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
								   	<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="ʡ��" defaultValue="" width="100%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								 </td>
								
								<td class="bz-search-title" style="width: 12%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 65%"/>
								</td>
								
	                            <td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title">��ͯ����</td>
								<td>
                                   <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" formTitle="" codeName="CHILD_TYPE" defaultValue="" width="100%" >
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������ͯ</BZ:option>
										<BZ:option value="1">�����ͯ</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td >
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>

								<td class="bz-search-title">�������</td>
								<td>
									<BZ:input prefix="S_" field="DISEASE_CN" id="S_DISEASE_CN" defaultValue="" formTitle="�������" maxlength="2000" style="width: 75%"/>
								</td>
							</tr>
							<tr>
									
								<td class="bz-search-title">��������</td>
								<td >
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="�Ա�" defaultValue="" width="100%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">���״̬</td>
								<td>
									<BZ:select prefix="S_" field="AUD_STATE" id="S_AUD_STATE" formTitle="" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ�ύ</BZ:option>
										<BZ:option value="1">ʡ����</BZ:option>
										<BZ:option value="2">ʡ�����</BZ:option>
										<BZ:option value="3">ʡ��ͨ��</BZ:option>
										<BZ:option value="4">ʡͨ��</BZ:option>
										<BZ:option value="5">�Ѽ���</BZ:option>
										<BZ:option value="6">�ѽ���</BZ:option>
										<BZ:option value="7">���������</BZ:option>
										<BZ:option value="8">���Ĳ�ͨ��</BZ:option>
										<BZ:option value="9">����ͨ��</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" formTitle="" defaultValue="" width="75%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">�ƻ���</BZ:option>
										<BZ:option value="2">�ѷ���</BZ:option>
										<BZ:option value="3">������</BZ:option>
										<BZ:option value="4">������</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_showDetail()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									&nbsp;
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting" id="DISEASE_CN">�������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="IS_OVERAGE">�����ʶ</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id=AUD_STATE>���״̬</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PUB_STATE">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<input name="xuanze" type="radio" value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="TWINS_IDS" defaultValue="" onlyValue="true"/>" class="ace">
									<%
									}else{
									%>
									<input name="xuanze" type="radio" value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>" class="ace">
									<%} %>
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td>
									<%
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME" defaultValue="" onlyValue="true"/>��ͬ����
									<%}else{%><BZ:data field="NAME" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" checkValue="0=������ͯ;1=�����ͯ;" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td><BZ:data field="DISEASE_CN" defaultValue="" /></td>
								<td class="center"><BZ:data field="ADD_MONTHS(BIRTHDAY,12*14)" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="IS_OVERAGE" defaultValue="" checkValue="1=��������;2=�ѳ���;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AUD_STATE" defaultValue="" checkValue="0=δ�ύ;1=ʡ����;2=ʡ�����;3=ʡ��ͨ��;4=ʡͨ��;5=�Ѽ���;6=�ѽ���;7=���������;8=���Ĳ�ͨ��;9=����ͨ��;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PUB_STATE" defaultValue="" checkValue="0=������;1=�ƻ���;2=�ѷ���;3=������;4=������;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" /></td>
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