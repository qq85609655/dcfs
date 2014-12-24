<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: suppleQuery_list.jsp
	 * @Description:  �����ѯ�б�
	 * @author yangrt   
	 * @date 2014-09-04 ����7:12:34 
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
	<BZ:head language="CN">
		<title>�����ѯ�б�</title>
		<BZ:webScript list="true" isAjax="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
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
				area: ['1000px','240px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/SuppleQueryList.action?type=SHB&page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
		}
		
		//������ϸ�鿴
		function _suppleShow(){
			var arrays = document.getElementsByName("xuanze");
			var num = 0;
			var aa_id = "";		//�ļ������¼id
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					aa_id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ��Ҫ�鿴������');
				return;
			}else{
				document.srcForm.action=path+"ffs/filemanager/SuppleQueryShow.action?AA_ID=" + aa_id;
				document.srcForm.submit();
			}
		}
		
		 //���
		  function _audit(){
			    var arrays = document.getElementsByName("xuanze");
				var num = 0;
				var aud_state="";	//�ļ����״̬
				var af_id = "";		//�ļ�id
				var au_id = "";		//��˼�¼id
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						aud_state=arrays[i].getAttribute("AUD_STATE");
						var aa_state = arrays[i].getAttribute("AA_STATUS"); 
						if(aud_state == "1"){
							af_id=document.getElementsByName('xuanze')[i].getAttribute("AF_ID");
							num += 1;
						}else{
							page.alert('���ļ��Ѿ���ˣ�ѡ��һ������ҪҪ��˵��ļ���');
							return;
						}
					}
				}
				if(num != "1"){
					page.alert('��ѡ��һ��Ҫ��˵�����');
					return;
				}else{	 
					var str_id_state = af_id + ";" + aud_state;
					var data = getData('com.dcfs.ffs.audit.FileAuditAjax','str_id_state=' + str_id_state+"&method=getAuditID");
					au_id = data.getString("AU_ID");
					if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
						document.srcForm.action=path+"ffs/jbraudit/toAuditForOneLevel.action?FLAG=bc&AF_ID="+af_id+"&AU_ID="+au_id;
						document.srcForm.submit();
					}else if(aud_state == "2"){
						document.srcForm.action=path+"ffs/jbraudit/toAuditForTwoLevel.action?FLAG=bc&AF_ID="+af_id+"&AU_ID="+au_id;
						document.srcForm.submit();
					}else if(aud_state == "3"){
						document.srcForm.action=path+"ffs/jbraudit/toAuditForThreeLevel.action?FLAG=bc&AF_ID="+af_id+"&AU_ID="+au_id;
						document.srcForm.submit();
					}else if(aud_state == "4"){
						page.alert("���ļ��Ѿ����δͨ�������ܽ����ٴ���ˣ�");
					}else if(aud_state == "5"){
						page.alert("���ļ��Ѿ����ͨ�������ܽ����ٴ���ˣ�");
					}
				 }
		  }
		
		
		
		//�����ļ���ϸ��Ϣ�鿴ҳ��
		function _showFileDetail(af_id){
			var url = path + "ffs/filemanager/FileDetailShow.action?type=list&AF_ID=" + af_id;
			//////_open(url, "window", 1000, 600);
			document.srcForm.action=url;
			document.srcForm.submit();
		}
		
		//�ļ��б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				/* document.srcForm.action=path+"ffs/filemanager/SuppleFileExport.action";
				document.srcForm.submit();
				document.srcForm.action=path+"ffs/filemanager/SuppleFileList.action"; */
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;GJSY;SYJBRSH;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/SuppleQueryList.action?type=SHB">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%"><span title="���ı��">���ı��</span></td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 15%">�ļ�����</td>
								<td style="width: 10%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="����">����</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="GJSY" width="148px"
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
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>	
								
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td colspan="2">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150"/>
								</td>
							</tr>	
							<tr>
								<td class="bz-search-title">����֪ͨ����</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�ύ����" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�ύ����" />
								</td>
							
								<td class="bz-search-title">��������</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�ύ����" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�ύ����" />
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" formTitle="" defaultValue="" width="70%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�Ѳ���</BZ:option>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_suppleShow()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
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
									<div class="sorting_disabled">ѡ��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="ADOPT_ORG_ID">������֯</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="NOTICE_DATE">����֪ͨ����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FEEDBACK_DATE">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AA_STATUS">����״̬</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AUD_STATE">���״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="myData">
							<tr class="emptyData">
								<td class="center">
								<%
									String is_pause = ((Data)pageContext.getAttribute("myData")).getString("IS_PAUSE");//�ļ���ͣ��־
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<input name="xuanze" type="radio" value="<BZ:data field="AA_ID" defaultValue="" onlyValue="true"/>" 
										AF_ID="<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>" 
										AUD_STATE="<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true"/>" 
										AA_STATUS="<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>" disabled="disabled" class="ace">
								<%	}else { %>
									<input name="xuanze" type="radio" value="<BZ:data field="AA_ID" defaultValue="" defaultValue="" onlyValue="true"/>" 
										AF_ID="<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>" 
										AUD_STATE="<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true"/>" 
										AA_STATUS="<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>" class="ace">
								<%	} %>
								</td>
								<td class="center">
								<%
									if("1".equals(is_pause)||"1"==is_pause){
								%>
									<img src="<%=request.getContextPath() %>/resource/images/bs_icons/pause-alt.png" title="�ļ�����ͣ" width="10px" height="10px">
								<%	} %>
									<BZ:i/>
								</td>
								<td class="center">
									<a href="#" title="�鿴�ļ���ϸ��Ϣ" onclick="_showFileDetail('<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/>
									</a>
								</td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FEEDBACK_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���;" onlyValue="true"/></td>
								<td><BZ:data field="AUD_STATE" defaultValue="" checkValue="0=�����˴����;1=�����������;2=�������δ����;3=�ֹ����δ�����;4=��˲�ͨ��;5=���ͨ��;9=�˻�����;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�����ļ�" exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;COUNTRY_CODE=CODE,GJSY;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE;AA_STATUS=FLAG,0:������&1:������&2:�Ѳ���;" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;FILE_TYPE=�ļ�����,15;NOTICE_DATE=֪ͨ����,15;FEEDBACK_DATE=��������,15;AA_STATUS=����״̬,15;"/></td>
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