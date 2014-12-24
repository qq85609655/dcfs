<%
/**   
 * @Title: ST_appointment_accept_list.jsp
 * @Description: ʡ��ԤԼ���������б�
 * @author xugy
 * @date 2014-10-2����2:56:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

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
		<title>ԤԼ���������б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>		
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1700,1700);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','230px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"appointment/STAppointmentAcceptList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_WELFARE_NAME_CN").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_ORDER_DATE_START").value = "";
			document.getElementById("S_ORDER_DATE_END").value = "";
			document.getElementById("S_SUGGEST_DATE_START").value = "";
			document.getElementById("S_SUGGEST_DATE_END").value = "";
			document.getElementById("S_ORDER_STATE").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		
		//���� 
		function _appointmentAccept(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ORDER_STATE = id.split(",")[1];
					if(ORDER_STATE != "1"){
						page.alert('��ѡ���ȷ�ϵ�����');
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"appointment/toSTAppointmentAcceptAdd.action";
				document.srcForm.submit();
			}
		}
		//
		function _show(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ORDER_STATE = id.split(",")[1];
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				$.layer({
					type : 2,
					title : "ԤԼ����鿴",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					//page : {dom : '#planList'},
					iframe: {src: '<BZ:url/>/appointment/STAppointmentAcceptDetail.action?ids='+ids},
					area: ['1050px','570px'],
					offset: ['0px' , '50px']
				});
			}
			
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;PROVINCE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="appointment/STAppointmentAcceptList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">֪ͨ���</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="֪ͨ���" maxlength=""/>
								</td>
								<td class="bz-search-title" style="width: 9%;">����</td>
								<td style="width: 18%;">
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 9%;">������֯</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">�з�</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" maxlength="" />
								</td>
								
								<td class="bz-search-title">Ů��</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="" />
								</td>
								
								<td class="bz-search-title">����Ժ</td>
								<td>
									<BZ:input prefix="S_" field="WELFARE_NAME_CN" id="S_WELFARE_NAME_CN" defaultValue="" formTitle="����Ժ" maxlength="" />
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ԤԼʱ��</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="ORDER_DATE_START" id="S_ORDER_DATE_START" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="maxDate:'#F{$dp.$D(\\'S_ORDER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼԤԼʱ��" />~
									<BZ:input prefix="S_" field="ORDER_DATE_END" id="S_ORDER_DATE_END" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="minDate:'#F{$dp.$D(\\'S_ORDER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹԤԼʱ��" />
								</td>
								<td class="bz-search-title">����ʱ��</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="SUGGEST_DATE_START" id="S_SUGGEST_DATE_START" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUGGEST_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ����ʱ��" />~
									<BZ:input prefix="S_" field="SUGGEST_DATE_END" id="S_SUGGEST_DATE_END" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="minDate:'#F{$dp.$D(\\'S_SUGGEST_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ����ʱ��" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ԤԼ״̬</td>
								<td>
									<BZ:select prefix="S_" field="ORDER_STATE" id="S_ORDER_STATE" width="148px" formTitle="ԤԼ״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
										<BZ:option value="2">ͨ��</BZ:option>
										<BZ:option value="3">��ͨ��</BZ:option>
									</BZ:select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_appointmentAccept()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="SIGN_NO">֪ͨ���</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">����</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">�з�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">Ů��</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ORDER_DATE">ԤԼʱ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SUGGEST_DATE">����ʱ��</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ORDER_STATE">ԤԼ״̬</div>
								</th>
								
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="AR_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ORDER_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME" defaultValue="" /></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="ORDER_DATE" defaultValue="" type="DateTime" dateFormat="yyyy-MM-dd HH:mm"/></td>
								<td><BZ:data field="SUGGEST_DATE" defaultValue="" type="DateTime" dateFormat="yyyy-MM-dd HH:mm"/></td>
								<td><BZ:data field="ORDER_STATE" defaultValue="" checkValue="0=δ�ύ;1=��ȷ��;2=ͨ��;3=��ͨ��;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�Ǽ�ԤԼ����" exportCode="SEX=CODE,ETXB;ORDER_STATE=FLAG,0:δ�ύ&1:��ȷ��&2:ͨ��&3:��ͨ��;BIRTHDAY=DATE,yyyy/MM/dd;ORDER_DATE=DATE;SUGGEST_DATE=DATE,yyyy-MM-dd HH:mm;" exportField="SIGN_NO=֪ͨ���,15,20;COUNTRY_CN=����,15;NAME_CN=������֯,20;MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;WELFARE_NAME_CN=����Ժ,20;NAME=����,15;SEX=�Ա�,10;BIRTHDAY=��������,15;ORDER_DATE=ԤԼʱ��,15;SUGGEST_DATE=����ʱ��,15;ORDER_STATE=ԤԼ״̬,15;"/></td>
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