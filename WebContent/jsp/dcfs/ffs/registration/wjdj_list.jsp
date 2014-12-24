<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: wjdj_list.jsp
 * @Description:  
 * @author yangrt   
 * @date 2014-7-14 ����3:00:34 
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
		<title>�ļ��Ǽ��б�</title>
		<BZ:webScript list="true" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1500,1500);
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
			document.srcForm.action=path+"ffs/registration/findList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_AF_SEQ_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_AF_COST").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_REG_STATE").value = "'1','2','3'";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
		}
		//�ֹ��Ǽ�
		function _hand_reg(){
			var num = 0;
			var reguuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "1"){
						reguuid[num++] = arrays[i].value.split("#")[0];
					}else{
						page.alert("ֻ��ѡ����Ǽǵ��ļ���Ϣ��");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('��ѡ���ֹ��Ǽǵ��ļ���');
				return;
			}else{
				document.getElementById("reguuid").value = reguuid.join("#");
				document.srcForm.action=path+"ffs/registration/FileHandReg.action?reguuid="+reguuid;
				document.srcForm.submit();
			}
		}
		
		//������ӡ������
		function _barcode(){
			var num = 0;
			var codeuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					codeuuid[num++] = arrays[i].value.split("#")[0];
				}
			}
			if(num < 1){
				page.alert('��ѡ��һ���������¼��ӡ�����룡');
				return;
			}else{
				document.getElementById("codeuuid").value = codeuuid.join("#");
				//window.open(path+"ffs/registration/barCodeList.action?codeuuid="+codeuuid,'newwindow','height=500,width=480,top=100,left=400,scrollbars=yes');
				document.srcForm.action=path+"ffs/registration/barCodeList.action?type=direct&codeuuid="+codeuuid;
				document.srcForm.submit();
			}
		}
		//�鿴
		function _show() {
			var num = 0;
			var showuuid="";
			var fileno="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					//showuuid=document.getElementsByName('xuanze')[i].value;
					showuuid=arrays[i].value.split("#")[0];
					fileno = arrays[i].value.split("#")[2];
					num += 1;
				}
			}
			if(num != "1"){
				alert('��ѡ��һ��Ҫ�鿴������');
				return;
			}else{
			    window.open(path+"ffs/registration/show.action?showuuid="+showuuid+"&fileno="+fileno,"newwindow","height=550,width=1000,top=70,left=180,scrollbars=yes");
			}
		}
		//�����ͯ�����鿴Ԥ����Ϣ
		function _showChildData(str_ci_id){
			//var url = path + "ffs/filemanager/ChildDataShow.action?ci_id=" + str_ci_id;
			//window.open(url,this,'height=600,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			//_open(url, "window", 900, 600);
			window.open(path+"ffs/registration/ChildDataShow.action?ci_id=" + str_ci_id,"newwindow","height=600,width=900,top=70,left=180,scrollbars=yes");
		}
		
		//ҵ���Զ��幦�ܲ���JS
		
 		//�ļ���¼����
		function _wjdlAdd(){
			window.location.href=path+"ffs/registration/toAddFlieRecordChoise.action";
		}
 		//�����ļ���¼
		function _batchAdd(){
			window.location.href=path+"ffs/registration/batchAddFlieRecord.action";
		}
		//�ļ��˻�����
		function _wjthAdd(){
			var num = 0;
			var AF_ID="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[1];
				if(arrays[i].checked){
					if(state == "1"){
						AF_ID=document.getElementsByName('xuanze')[i].value;
						num += 1;
					}else{
						page.alert("ֻ��ѡ����Ǽǵ��ļ���Ϣ��");
						return;
					}
				}
			}
			if(num != "1"){
				alert('��ѡ��һ��Ҫ�˻ص�����');
				return;
			}else{
				document.srcForm.action=path+"ffs/registration/toAddFlieReturnReason.action?AF_ID="+AF_ID;
				document.srcForm.submit();
			}
		}

		//�ļ��Ǽ��б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		


	</script>
	<BZ:body property="data" codeNames="WJLX_DL;WJLX;GJSY;SYZZ;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" action="ffs/registration/findList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="reguuid" name="reguuid" value=""/>
		<input type="hidden" id="codeuuid" name="codeuuid" value=""/>
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
								<td class="bz-search-title" style="width: 10%"><span title="��ˮ��">��ˮ��</span></td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="AF_SEQ_NO" id="S_AF_SEQ_NO" defaultValue="" formTitle="��ˮ��" maxlength="50"/>
								</td>
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px" 
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
									
								</td>
								
								<td class="bz-search-title" style="width: 10%"><span title="��������">��������</span></td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%">���ı��</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50"/>
								</td>	
								
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ӧ�ɽ��</td>
								<td>
									<BZ:input prefix="S_" field="AF_COST" id="S_AF_COST" defaultValue="" formTitle="Ӧ�ɽ��" restriction="int" maxlength="4"/>
								</td>
								
								<td class="bz-search-title">�ļ�����</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								
								<td class="bz-search-title">�Ǽ�״̬</td>
								<td>
									<BZ:select prefix="S_" field="REG_STATE" id="S_REG_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="'1','2','3'">--��ѡ��--</BZ:option>
										<BZ:option value="'1'">���Ǽ�</BZ:option>
										<BZ:option value="'2'">���޸�</BZ:option>
										<BZ:option value="'3'">�ѵǼ�</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�ύ����</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�ύ����" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�ύ����" />
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_hand_reg()"/>&nbsp;
					<input type="button" value="�������ӡ" class="btn btn-sm btn-primary" onclick="_barcode()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_wjthAdd()"/>&nbsp;
					<input type="button" value="�ļ���¼" class="btn btn-sm btn-primary" onclick="_wjdlAdd()"/>&nbsp;
					<input type="button" value="������¼" class="btn btn-sm btn-primary" onclick="_batchAdd()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AF_SEQ_NO">��ˮ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="NAME">��ͯ����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AF_COST">Ӧ�ɽ��</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PAID_NO">�ɷѱ��</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REG_DATE">�ύ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REG_STATE">�Ǽ�״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="resultData">
							<tr class="emptyData">
							<%
									Data resultData = (Data)pageContext.getAttribute("resultData");
									String is_pause = resultData.getString("IS_PAUSE");//�ļ���ͣ��־
							%>
								<td class="center">
									<%
									if("1".equals(is_pause)||"1"==is_pause){
									%>
										<input name="xuanze" type="checkbox" disabled value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>#<BZ:data field="FILE_NO" onlyValue="true"/>" class="ace">
									<% 
									}else {
									%>
										<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="REG_STATE" onlyValue="true"/>#<BZ:data field="FILE_NO" onlyValue="true"/>" class="ace">
									<% 
									}
									%>
								</td>
								<td class="center">
									<%
									if("1".equals(is_pause)||"1"==is_pause){
									%>
										<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="�ļ�����ͣ" width="10px" height="10px">	
									<% 
									}
									%>
									<BZ:i/>
								</td>
								<td><BZ:data field="AF_SEQ_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<%
								String str_ci_id = resultData.getString("CI_ID","");
								if("".equals(str_ci_id)){
								%>	
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<%
									}else{
								%>
								<td><a href="#" onclick="_showChildData('<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>');return false;" title="����鿴�ö�ͯԤ����Ϣ"><BZ:data field="NAME" defaultValue="Mulity" onlyValue="true" /></a></td>
								<%  } %>
								<td><BZ:data field="FILE_TYPE" defaultValue=""  codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAID_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUBMIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REG_STATE" defaultValue="" onlyValue="true" checkValue="1=���Ǽ�;2=���޸�;3=�ѵǼ�;"/></td>
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
							<td><BZ:page isShowEN="false" form="srcForm" property="List" exportXls="true" exportTitle="�ļ��Ǽ���Ϣ" exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;FILE_TYPE=CODE,WJLX;SUBMIT_DATE=DATE;REG_STATE=FLAG,1:���Ǽ�&2:���޸�&3:�ѵǼ�;" 
								exportField="AF_SEQ_NO=��ˮ��,15,20;FILE_NO=���ı��,15;REGISTER_DATE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,25;MALE_NAME=��������,30;FEMALE_NAME=Ů������,30;NAME=��ͯ����,15;FILE_TYPE=�ļ�����,15;AF_COST=Ӧ�ɽ��,15;PAID_NO=�ɷѱ��,15;SUBMIT_DATE=�ύ����,15;REG_STATE=�Ǽ�״̬,15;"/></td>
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