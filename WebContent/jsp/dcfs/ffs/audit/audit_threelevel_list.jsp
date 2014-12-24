<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: �ֹ����������б�
 * @author mayun   
 * @date 2014-8-29
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
	

%>
<BZ:html>
	<BZ:head>
		<title>�ֹ����������б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
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
			document.srcForm.action=path+"ffs/jbraudit/findListForThreeLevel.action";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_RECEIVER_DATE_START").value = "";
			document.getElementById("S_RECEIVER_DATE_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_TRANSLATION_QUALITY").value = "";
			document.getElementById("S_AUD_STATE").value = "";
			document.getElementById("S_AA_STATUS").value = "";
			document.getElementById("S_RTRANSLATION_STATE").value = "";
			//document.getElementById("S_OPERATION_STATE").value = "";
		}
		//����������
		function _barcode(){
			var num = 0;
			var codeuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					codeuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ������');
				return;
			}else{
				window.open(path+"ffs/registration/barCode.action?codeuuid="+codeuuid,'newwindow','height=500,width=480,top=100,left=400,scrollbars=yes');
			}
		}
		//�鿴
		function _show() {
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ��Ҫ�鿴������');
				return;
			}else{
				window.open(path+"ffs/registration/show.action?showuuid="+showuuid,'newwindow','height=550,width=1000,top=70,left=180,scrollbars=yes');
				document.srcForm.submit();
			}
		}
		
		//�����б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				//document.srcForm.action=path+"ffs/jbraudit/fileExportForTwoLevel.action";
				//document.srcForm.submit();
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		//ҵ���Զ��幦�ܲ���JS
		
	
	//�Ƿ����㸴�˲���
	function _isCanAudit(){
		var xuanze = $("input[name='xuanze']:checked").val();
		if(null==xuanze||""==xuanze||"undefined"==xuanze){
			page.alert("��ѡ��һ��Ҫ���������ݣ�");
			return;
		}else{
			var dataArr = xuanze.split(";");
			var AF_ID = dataArr[0];
			//var AU_ID = dataArr[1];
			var AUDIT_STATUS = dataArr[1];
			if("3"!=AUDIT_STATUS){
				page.alert("��ѡ�����״̬Ϊ�ֹ�����[������]�ļ�¼��");
				return;
			}else{
				var AUDIT_LEVEL="2";
				var OPERATION_STATE="'0','1'";
				_audit(AF_ID,AUDIT_LEVEL,OPERATION_STATE);
			}
		}
	}
	
	//���
	function _audit(AF_ID,AUDIT_LEVEL,OPERATION_STATE){
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.audit.FileAuditAjax&method=getAuditIDForWJSH&AF_ID='+AF_ID+'&AUDIT_LEVEL='+AUDIT_LEVEL+'&OPERATION_STATE='+OPERATION_STATE,
			type: 'POST',
			dataType: 'json',
			timeout: 10000,
			success: function(data){
				var AU_ID=data.AU_ID;
				window.location.href=path+"ffs/jbraudit/toAuditForThreeLevel.action?AF_ID="+AF_ID+"&AU_ID="+AU_ID;
			}
		  });
	}
	
	//�鿴�ļ�������Ϣ�Ѿ���������Ϣ
	function _showFileAndAuditInfo(xuanze){
		var dataArr = xuanze.split(";");
		var AF_ID = dataArr[0];
		var AUDIT_STATUS = dataArr[1];
		var OPERATION_STATE="'0','1','2'";
		var AUDIT_LEVEL;
		if("0"==AUDIT_STATUS||"1"==AUDIT_STATUS||"9"==AUDIT_STATUS){
			AUDIT_LEVEL="0";
		}else if("2"==AUDIT_STATUS||"4"==AUDIT_STATUS||"5"==AUDIT_STATUS){
			AUDIT_LEVEL="1"
		}else{
			AUDIT_LEVEL="2";
		}
		
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.audit.FileAuditAjax&method=getAuditIDForWJSH&AF_ID='+AF_ID+'&AUDIT_LEVEL='+AUDIT_LEVEL+'&OPERATION_STATE='+OPERATION_STATE,
			type: 'POST',
			dataType: 'json',
			timeout: 10000,
			success: function(data){
				var AU_ID=data.AU_ID;
				$.layer({
					type : 2,
					title : "�鿴�ļ�������Ϣ����������Ϣ",
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					iframe: {src: '<BZ:url/>/ffs/jbraudit/toAuditForThreeLevelView.action?AF_ID='+AF_ID+'&AU_ID='+AU_ID},
					area: ['1150px',($(window).height() - 50) +'px'],
					offset: ['0px' , '0px']
				});
			}
		  });
		
		
	}
	
	

	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;WJLX;SYBMSH;SYZZ;SYS_ADOPT_ORG;SYWJSHZT;WJFYZL;SYJBRSH;SYWJBC;SYWJCF;WJFGZRSP;SYFGSH;WJSHCZZT;SYWJSHZT">
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findListForThreeLevel.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display:none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">
									<span title="���ı��">���ı��</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO"
										defaultValue="" formTitle="���ı��"/>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="�ļ�����">�ļ�����</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="FILE_TYPE" formTitle=""
										prefix="S_" isCode="true" codeName="WJLX" width="70%">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="����">����</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
							<tr>
								
								<td class="bz-search-title" style="width: 10%">
									<span title="��������">��������</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME"
										defaultValue="" formTitle="��������"
										restriction="hasSpecialChar" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="Ů������">Ů������</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME"
										defaultValue="" formTitle="Ů������"
										restriction="hasSpecialChar" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="��������">��������</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="TRANSLATION_QUALITY" formTitle=""
										prefix="S_" isCode="true" codeName="WJFYZL" width="70%">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="���״̬">���״̬</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="AUD_STATE" formTitle=""
										prefix="S_" isCode="true" codeName="SYWJSHZT" width="70%">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
							</tr>
							
							<tr>
								<!-- 
								<td class="bz-search-title" style="width: 10%">
									<span title="����״̬">����״̬</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="AA_STATUS" formTitle=""
										prefix="S_" isCode="true" codeName="SYWJBC" width="70%">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="�ط�״̬">�ط�״̬</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="RTRANSLATION_STATE" formTitle=""
										prefix="S_" isCode="true" codeName="SYWJCF" width="70%">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								 
								<td class="bz-search-title" style="width: 10%">
									<span title="����״̬">����״̬</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="OPERATION_STATE" formTitle=""
										prefix="S_" isCode="true" codeName="WJSHCZZT" width="70%">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								-->
								<td class="bz-search-title" style="width: 10%">
									<span title="��������">��������</span>
								</td>
								<td style="width: 30%" colspan="3">
									<BZ:input prefix="S_" field="RECEIVER_DATE_START" id="S_RECEIVER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�ύ����" />~
									<BZ:input prefix="S_" field="RECEIVER_DATE_END" id="S_RECEIVER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�ύ����" />
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_isCanAudit()"/>&nbsp;
					<input type="button" value="������ɨ��" class="btn btn-sm btn-primary" onclick=""/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 1%;">
									<div class="sorting_disabled">
									</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">
										���
									</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">
										���ı��
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RECEIVER_DATE">
										��������
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_TYPE">
										�ļ�����
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="COUNTRY_CN">
										����
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">
										������֯
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">
										��������
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">
										Ů������
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">
										��������
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AUD_STATE">
										���״̬
									</div>
								</th>
								<!-- 
								<th style="width: 5%;">
									<div class="sorting" id="AA_STATUS">
										����״̬
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RTRANSLATION_STATE">
										�ط�״̬
									</div>
								</th>
								 -->
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_QUALITY">
										��������
									</div>
								</th>
							</tr>
						</thead>
						<tbody id="tbody">
						<BZ:for property="List" fordata="resultData">
							<tr class="emptyData">
								<%
									Data resultData = (Data)pageContext.getAttribute("resultData");
									String is_pause = resultData.getString("IS_PAUSE");//�ļ���ͣ��־
									String return_state = resultData.getString("RETURN_STATE");//�ļ����ı�־
								%>
								<td class="center">
								<%
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<input name="xuanze" type="radio" disabled value="<BZ:data field="AF_ID" onlyValue="true"/>;<BZ:data field="AUD_STATE" onlyValue="true"/>" 
									class="ace">
								<% 
									}else {
								%>
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>;<BZ:data field="AUD_STATE" onlyValue="true"/>" 
									class="ace">
								<%  } %>
								</td>
								<td class="center" nowrap>
									<%
									if("1".equals(is_pause)||"1"==is_pause){//��ͣ��־
									%>
										<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="�ļ�����ͣ" width="10px" height="10px">	
									<% 
									}
									if("0".equals(return_state)||"0"==return_state){//���Ĵ�ȷ�ϱ�־
									%>
										<font size="2px" title="���Ĵ�ȷ��" color="red">��</font>
									<%} %>
									<BZ:i/>
								</td>
								<td>
									<a href="javascript:void()" onclick="_showFileAndAuditInfo('<BZ:data field="AF_ID" onlyValue="true"/>;<BZ:data field="AUD_STATE" onlyValue="true"/>')" title="����鿴��ϸ�����Ϣ">
										<BZ:data field="FILE_NO" defaultValue="" onlyValue="true" />
									</a>
								</td>
								<td>
									<BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="FILE_TYPE"  defaultValue="" onlyValue="true" codeName="WJLX" />
								</td>
								<td>
									<BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"  />
								</td>
								<td>
									<BZ:data field="NAME_CN" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true" codeName="SYWJSHZT"/>
								</td>
								<!-- 
								<td>
									<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true" codeName="SYWJBC"/>
								</td>
								<td>
									<BZ:data field="RTRANSLATION_STATE" defaultValue="" onlyValue="true" codeName="SYWJCF"/>
								</td>
								 -->
								<td>
									<BZ:data field="TRANSLATION_QUALITY" defaultValue="" onlyValue="true" codeName="WJFYZL"/>
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
							<td>
							<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�ֹ�������������" exportCode="FILE_TYPE=CODE,WJLX;COUNTRY_CODE=CODE,GJSY;ADOPT_ORG_ID=CODE,SYS_ADOPT_ORG;AUD_STATE=CODE,SYWJSHZT;SUPPLY_STATE=CODE,SYWJBC;RTRANSLATION_STATE=CODE,SYWJCF;TRANSLATION_QUALITY=CODE,WJFYZL;REGISTER_DATE=DATE;RECEIVER_DATE=DATE" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;FILE_TYPE=�ļ�����,10;COUNTRY_CODE=����,10;ADOPT_ORG_ID=������֯,20;MALE_NAME=��������,30;FEMALE_NAME=Ů������,30;RECEIVER_DATE=��������,15;AUD_STATE=���״̬,15;TRANSLATION_QUALITY=��������,15"/>
							<!--<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�����������" exportCode="COUNTRY_CODE=CODE,GJSY;ADOPT_ORG_ID=CODE,SYZZ;AUD_STATE=CODE,SYBMSH;SUPPLY_STATE=CODE,SYWJBC;RTRANSLATION_STATE=FLAG,0:���ط�&1:�ط���&2:���ط�;TRANSLATION_QUALITY=CODE,WJFYZL;REGISTER_DATE=DATE;RECEIVER_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=�ύ����,15;COUNTRY_CODE=����,10;ADOPT_ORG_ID=������֯,20;MALE_NAME=��������,30;FEMALE_NAME=Ů������,30;RECEIVER_DATE=��������,15;AUD_STATE=���״̬,15;SUPPLY_STATE=����״̬,15;RTRANSLATION_STATE=�ط�״̬,15;TRANSLATION_QUALITY=��������,15"/>-->
							
							</td>
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