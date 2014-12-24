<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="hx.util.DateUtility"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: pauseFile_list.jsp
	 * @Description:  �ļ���ͣ��Ϣ�б�
	 * @author panfeng   
	 * @date 2014-9-4 ����2:03:18 
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
	//��ȡ��ǰʱ��
	String curDate = DateUtility.getCurrentDate();
%>
<BZ:html>
	<BZ:head>
		<title>�ļ���ͣ��Ϣ�б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1700,1700);
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
				area: ['1080px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/pause/pauseFileList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_PAUSE_UNITNAME").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_RECOVERY_STATE").value = "";
			document.getElementById("S_PAUSE_DATE_START").value = "";
			document.getElementById("S_PAUSE_DATE_END").value = "";
			document.getElementById("S_RECOVERY_DATE_START").value = "";
			document.getElementById("S_RECOVERY_DATE_END").value = "";
			document.getElementById("S_AF_POSITION").value = "";
		}
		
		//�ļ���������ҳ��
		function _remindShow(id){
			var url = path + "ffs/pause/remindShow.action?AP_ID=" + id;
			modalDialog(url, this, 650, 350);
		}
		
		//��ת��ѡ��Ҫ��ͣ���ļ��б�
		function _showPauseFile(){
			window.location.href=path+"ffs/pause/pauseChoiceList.action";
		}
		
		//�ļ�ȡ����ͣ����
		function _recovery(){
			var num = 0;
			var fileuuid = "";
			var recuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[2];
				if(arrays[i].checked){
					if(state != "1"){
						page.alert("ֻ��ѡ������ͣ���ļ���Ϣ��");
						return;
					}else{
						fileuuid = arrays[i].value.split("#")[0];
						recuuid = arrays[i].value.split("#")[1];
						num++;
					}
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫȡ����ͣ���ļ���");
				return;
			}else{
				if (confirm("ȷ��ȡ����ͣ�ļ���Ϣ��")){
					document.srcForm.action=path+"ffs/pause/fileRecovery.action?fileuuid="+fileuuid+"&recuuid="+recuuid;
					document.srcForm.submit();
				}
			}
		}
		
		//�鿴��ͣ��Ϣ
		function _view(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid=arrays[i].value.split("#")[1];
					num += 1;
				}
			}
			if(num != "1"){
				alert('��ѡ��һ������');
				return;
			}else{
				window.open(path + "ffs/pause/pauseSearchShow.action?type=ZX&showuuid=" + showuuid,"window","width=950,height=450,top=160,left=200,scrollbars=yes");
			}
		}
		
		//��ת������ȷ��ҳ��
		function _returnFile(){
			var d = new Date();
			var str = d.getFullYear()+"-0"+(d.getMonth()+1)+"-0"+d.getDate();
			var carr = str.split("-");
			var curdate=new Date(carr[0],carr[1],carr[2]);
			var curdates=curdate.getTime();
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var end_date = arrays[i].value.split("#")[3];
				var darr = end_date.split("-");
				var deadline=new Date(darr[0],darr[1],darr[2]);
				var deadlines=deadline.getTime();
				var state = arrays[i].value.split("#")[2];
				var match_state = arrays[i].value.split("#")[4];
				var ci_id = arrays[i].value.split("#")[5];
				var ri_state = arrays[i].value.split("#")[6];
				if(arrays[i].checked){
					if((deadlines > curdates) || (state == "2")){
						page.alert("ֻ��ѡ����ͣ���ڵ��ļ���Ϣ��");
						return;
					}else if(match_state!="null"&&ci_id!="null"){
						alert("���ļ�����ƥ����Ϣ�����Ƚ��ƥ�䣬�ٽ������Ĳ�����");
						return;
					}else if(ri_state!="9"&&ci_id!="null"){
						alert("���ļ�����Ԥ����Ϣ�����ȳ���Ԥ�����ٽ������Ĳ�����");
						return;
					}else{
						showuuid = arrays[i].value.split("#")[0];
						num++;
					}
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ����ͣ���ڵ��ļ���");
				return;
			}else{
				document.srcForm.action=path+"ffs/pause/returnFileShow.action?showuuid="+showuuid;
				document.srcForm.submit();
			}
		}
		
		//�޸���ͣ����
		function _modDeadline(){
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
				alert('��ѡ��һ������');
				return;
			}else{
				window.open(path + "ffs/pause/modDeadline.action?showuuid=" + showuuid,"window","width=250,height=210,top=220,left=550");
			}
		}
		function mod_tijiao(){
			document.srcForm.action = path +"ffs/pause/pauseFileList.action";
			document.srcForm.submit();
		}
		
		//�ļ���ͣ�б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;SYZZ;WJWZ">
		<BZ:form name="srcForm" method="post" action="ffs/pause/pauseFileList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="recuuid" name="recuuid" value=""/>
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
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50" style="width:200px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 8%">����</td>
								<td style="width: 12%">
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 12%">��������</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" maxlength="150" style="width:200px;"/>
								</td>
								
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
										onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title">��ͣ����</td>
								<td>
									<BZ:input prefix="S_" field="PAUSE_DATE_START" id="S_PAUSE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PAUSE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��ͣ����" />~
									<BZ:input prefix="S_" field="PAUSE_DATE_END" id="S_PAUSE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PAUSE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��ͣ����" />
								</td>	
								
							</tr>
							<tr>
								
								<td class="bz-search-title"><span title="Ů������">Ů������</span></td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150" style="width:200px;"/>
								</td>
								
								<td class="bz-search-title">��ͣ״̬</td>
								<td>
									<BZ:select prefix="S_" field="RECOVERY_STATE" id="S_RECOVERY_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">����ͣ</BZ:option>
										<BZ:option value="9">ȡ����ͣ</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">ȡ����ͣ����</td>
								<td>
									<BZ:input prefix="S_" field="RECOVERY_DATE_START" id="S_RECOVERY_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECOVERY_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼȡ����ͣ����" />~
									<BZ:input prefix="S_" field="RECOVERY_DATE_END" id="S_RECOVERY_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RECOVERY_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹȡ����ͣ����" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��ͣ����</td>
								<td>
									<BZ:select prefix="S_" field="PAUSE_UNITNAME" id="S_PAUSE_UNITNAME" formTitle="" defaultValue="" width="69%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="�칫��">�칫��</BZ:option>
										<BZ:option value="���ò�">���ò�</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">�ļ�λ��</td>
								<td style="width: 12%">
									<BZ:select prefix="S_" field="AF_POSITION" id="S_AF_POSITION" isCode="true" codeName="WJWZ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
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
					<input type="button" value="��&nbsp;&nbsp;ͣ" class="btn btn-sm btn-primary" onclick="_showPauseFile()"/>&nbsp;
					<input type="button" value="ȡ����ͣ" class="btn btn-sm btn-primary" onclick="_recovery()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_returnFile()"/>&nbsp;
					<input type="button" value="�޸���ͣ����" class="btn btn-sm btn-primary" onclick="_modDeadline()"/>&nbsp;
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
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AF_POSITION">�ļ�λ��</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PAUSE_UNITNAME">��ͣ����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PAUSE_DATE">��ͣ����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="END_DATE">��ͣ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="IS_OVER_DATE">�Ƿ���</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RECOVERY_DATE">ȡ����ͣ����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RECOVERY_STATE">��ͣ״̬</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled">���ѱ�ʶ</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<script type="text/javascript">
							<%
							String end_date = ((Data)pageContext.getAttribute("fordata")).getString("END_DATE","");
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							%>
							</script>
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="AP_ID" onlyValue="true"/>#<BZ:data field="RECOVERY_STATE" onlyValue="true"/>#<BZ:data field="END_DATE" type="date" onlyValue="true"/>#<BZ:data field="MATCH_STATE" onlyValue="true"/>#<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="RI_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAUSE_UNITNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PAUSE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="END_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<%
								if(sdf.parse(end_date).getTime() < sdf.parse(curDate).getTime()){
								%>
								<td>��</td>
								<%
								}else{
								%>
								<td>��</td>
								<%
								}
								%>
								<td class="center"><BZ:data field="RECOVERY_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="RECOVERY_STATE" defaultValue="" checkValue="1=����ͣ;9=ȡ����ͣ;" onlyValue="true"/></td>
								<%
								Calendar cal = Calendar.getInstance();
								cal.setTime(sdf.parse(end_date));
								cal.add(Calendar.MONTH, -1);
								if((sdf.parse(sdf.format(cal.getTime())).getTime() < sdf.parse(curDate).getTime()) && (sdf.parse(curDate).getTime() < sdf.parse(end_date).getTime())){
								%>
								<td><a href="#" onclick="_remindShow('<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>');return false;">������</td>
								<%
								}else{
								%>
								<td>δ����</td>
								<%
								}
								%>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�ļ���ͣ" exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;AF_POSITION=CODE,WJWZ;PAUSE_DATE=DATE;END_DATE=DATE;RECOVERY_DATE=DATE;RECOVERY_DATE=DATE;RECOVERY_STATE=FLAG,1:����ͣ&9:ȡ����ͣ;" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;AF_POSITION=�ļ�λ��,15;PAUSE_UNITNAME=��ͣ����,15;PAUSE_DATE=��ͣ����,15;END_DATE=��ͣ����,15;IS_PAUSE=�Ƿ���,15;RECOVERY_DATE=ȡ����ͣ����,15;RECOVERY_STATE=��ͣ״̬,15;IS_PAUSE=���ѱ�ʶ,15;"/></td>
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