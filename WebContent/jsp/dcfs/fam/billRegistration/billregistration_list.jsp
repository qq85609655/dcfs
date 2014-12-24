<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: billregistration_list.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-11-14 ����10:23:12 
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
		<title>Ʊ�ݵǼ��б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"fam/billRegistration/billRegistrationList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PAID_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_PAID_SHOULD_NUM").value = "";
			document.getElementById("S_COST_TYPE").value = "";
			document.getElementById("S_REG_DATE_START").value = "";
			document.getElementById("S_REG_DATE_END").value = "";
			document.getElementById("S_PAR_VALUE").value = "";
			document.getElementById("S_PAID_WAY").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_CHEQUE_TRANSFER_STATE").value = "";
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		}
		
		//Ʊ�ݵǼ�
		function _registration(){
			window.location.href=path+"fam/billRegistration/billRegistrationAdd.action?init=1";
		}
		
		//�޸�
		function _revise(){
			var num = 0;
			var showuuid="";
			var fileno="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state != "0"){
						page.alert("ֻ��ѡ��δ�ύ��Ʊ����Ϣ�����޸ģ�");
						return;
					}else{
						showuuid=arrays[i].value.split("#")[0];
						fileno = arrays[i].value.split("#")[2];
						num += 1;
					}
				}
			}
			if(num != "1"){
				alert('��ѡ��һ�����ݣ�');
				return;
			}else{
			    document.srcForm.action=path+"fam/billRegistration/billRevise.action?showuuid="+showuuid+"&fileno="+fileno;
				document.srcForm.submit();
			}
		}
		
		//ɾ��δ�ύ��Ʊ����Ϣ
		function _delete(){
			var num = 0;
			var deleteuuid = [];
			var file_no = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "0"){
						deleteuuid[num++] = arrays[i].value.split("#")[0];
						file_no[num++] = arrays[i].value.split("#")[2];
					}else{
						page.alert("ֻ��ɾ��δ�ύ��Ʊ����Ϣ��");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('��ѡ��Ҫɾ�����ļ���');
				return;
			}else{
				if (confirm("ȷ��ɾ����Ʊ����Ϣ��")){
					document.getElementById("deleteuuid").value = deleteuuid.join("#");
					document.getElementById("file_no").value = file_no.join(",");
					document.srcForm.action=path+"fam/billRegistration/billDelete.action";
					document.srcForm.submit();
				}
			}
		}
		
		//�ļ��ɷ�֪ͨ����ӡ
		function _print(){
			var num = 0;
			var printuuid = "";
			var fileno="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					printuuid = arrays[i].value.split("#")[0];
					fileno = arrays[i].value.split("#")[2];
					num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ʊ�ݼ�¼��");
				return;
			}else{
				window.open(path + "fam/billRegistration/billPrint.action?printuuid="+printuuid+"&fileno="+fileno,"newwindow","height=842,width=680,top=100,left=350,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
			}
		}

		//����
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="GJSY;FYLB;JFFS;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="fam/billRegistration/billRegistrationList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="checkuuid" name="checkuuid" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="file_no" name="file_no" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="�ɷѱ��">�ɷѱ��</span></td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="PAID_NO" id="S_PAID_NO" defaultValue="" formTitle="�ɷѱ��" maxlength="14"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">����</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="88%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 34%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ӧ�ɽ��</td>
								<td>
									<BZ:input prefix="S_" field="PAID_SHOULD_NUM" id="S_PAID_SHOULD_NUM" defaultValue="" formTitle="Ӧ�ɽ��" maxlength="22"/>
								</td>	
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="COST_TYPE" id="S_COST_TYPE" isCode="true" codeName="FYLB" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">¼������</td>
								<td>
									<BZ:input prefix="S_" field="REG_DATE_START" id="S_REG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REG_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ¼������" />~
									<BZ:input prefix="S_" field="REG_DATE_END" id="S_REG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REG_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ¼������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ʊ����</td>
								<td>
									<BZ:input prefix="S_" field="PAR_VALUE" id="S_PAR_VALUE" defaultValue="" formTitle="Ʊ����" restriction="int" maxlength="22"/>
								</td>
								
								<td class="bz-search-title">�ɷѷ�ʽ</td>
								<td>
									<BZ:select prefix="S_" field="PAID_WAY" id="S_PAID_WAY" isCode="true" codeName="JFFS" formTitle="�ɷѷ�ʽ" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="bz-search-title">���ı��</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="256"/>
								</td>
								
								<td class="bz-search-title">�ƽ�״̬</td>
								<td>
									<BZ:select prefix="S_" field="CHEQUE_TRANSFER_STATE" id="S_CHEQUE_TRANSFER_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ�ύ</BZ:option>
										<BZ:option value="1">���ƽ�</BZ:option>
										<BZ:option value="2">���ƽ�</BZ:option>
										<BZ:option value="3">���ƽ�</BZ:option>
										<BZ:option value="4">�ѽ���</BZ:option>
									</BZ:select>
								</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_registration()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp;
					<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="PAID_NO">�ɷѱ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="COST_TYPE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PAID_WAY">�ɷѷ�ʽ</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PAID_SHOULD_NUM">Ӧ�ɽ��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PAR_VALUE">Ʊ����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REG_DATE">¼������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="CHEQUE_TRANSFER_STATE">�ƽ�״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<%
								Data fordata = (Data)pageContext.getAttribute("fordata");
								String file_no = fordata.getString("FILE_NO","");
								%>
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CHEQUE_ID" onlyValue="true"/>#<BZ:data field="CHEQUE_TRANSFER_STATE" onlyValue="true"/>#<BZ:data field="FILE_NO" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COST_TYPE" defaultValue="" codeName="FYLB" onlyValue="true"/></td>
								<td><BZ:data field="PAID_WAY" defaultValue="" codeName="JFFS" onlyValue="true"/></td>
								<td><BZ:data field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAR_VALUE" defaultValue="" onlyValue="true"/></td>
								<%
								if(file_no.length()<12){
								%>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<%
								}else{
								%>
								<td class="center">Multiple</td>
								<%
								}
								%>
								<td><BZ:data field="REG_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="CHEQUE_TRANSFER_STATE" defaultValue="" onlyValue="true" checkValue="0=δ�ύ;1=���ƽ�;2=���ƽ�;3=���ƽ�;4=�ѽ���"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="Ʊ�ݵǼ���Ϣ" 
							exportCode="COUNTRY_CODE=CODE,GJSY;COST_TYPE=CODE,FYLB;PAID_WAY=CODE,JFFS;REG_DATE=DATE;CHEQUE_TRANSFER_STATE=FLAG,0:δ�ƽ�&1:���ƽ�&2:���ƽ�&3:���ƽ�&4:�ѽ���;"
							exportField="PAID_NO=�ɷѱ��,15,20;COUNTRY_CODE=����,15;NAME_CN=������֯,15;COST_TYPE=��������,15;PAID_WAY=�ɷѷ�ʽ,15;PAID_SHOULD_NUM=Ӧ�ɽ��,15;PAR_VALUE=Ʊ����,15;FILE_NO=���ı��,15;REG_DATE=¼������,15;CHEQUE_TRANSFER_STATE=�ƽ�״̬,15;"/></td>
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