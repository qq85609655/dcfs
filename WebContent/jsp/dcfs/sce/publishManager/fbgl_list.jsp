<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="org.jaxen.Context"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
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
		<title>���������б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
			_findSyzzNameListForNew('S_COUNTRY_CODE2','S_ADOPT_ORG_ID2','S_HIDDEN_ADOPT_ORG_ID2')
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','350px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/publishManager/findListForFBGL.action";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_PUB_TYPE").value = "";
			document.getElementById("S_PUB_MODE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_PUB_STATE").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_LOCK_NUM").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_PUB_ORGID").value = "";
			document.getElementById("S_COUNTRY_CODE2").value = "";
			document.getElementById("S_ADOPT_ORG_ID2").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_PUB_FIRSTDATE_START").value = "";
			document.getElementById("S_PUB_FIRSTDATE_END").value = "";
			document.getElementById("S_SETTLE_DATE_START").value = "";
			document.getElementById("S_SETTLE_DATE_END").value = "";
			document.getElementById("S_PUB_LASTDATE_START").value = "";
			document.getElementById("S_PUB_LASTDATE_END").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_DISEASE_CN").value = "";
			
			
		}
		
		 
		//��������
		function _fbcx(){
			var num = 0;
			var pub_id;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					pub_id = arrays[i].value;
					num++;
				}
				
			}
			if(num < 1){
				page.alert('��ѡ��һ������״̬Ϊ"�ѷ���"�ļ�¼��');
				return;
			}else{
				_isFB(pub_id);
			}
		}
		
		//�жϷ�����¼�ķ���״̬�Ƿ�Ϊ�ѷ��� true:��  false:��
		function _isFB(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=isFB&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						_isTH(pub_id);
					}else{
						page.alert('��ѡ��һ������״̬Ϊ"�ѷ���"�ļ�¼��');
						return false;
					}
				}
			})
		}
		
		//�жϷ�����¼�ķ���״̬�Ƿ�����������˻� true:��  false:��
		function _isTH(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=isTH&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						page.alert('�ü�¼�ѽ����˵㷢�˻أ���������з�������������');
						return false;
					}else{
						_isCanFBCX(pub_id);
					}
				}
			})
		}
		
		//�Ƿ�ɽ��г�����������
		function _isCanFBCX(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getFbjlAndEtInfo&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if("1"==data.MATCH_STATE){
						page.alert('��ƥ��ö�ͯ�����Ƚ��н��ƥ�������');
						return false;
					}else if("3"==data.PUB_STATE_FBRECORD){
						page.alert('�������ö�ͯ�����Ƚ��н������������');
						return false;
					}else if("4"==data.PUB_STATE_FBRECORD){
						page.alert('�ѵݽ�Ԥ�������Ƚ���Ԥ������������');
						return false;
					}else{
						document.srcForm.action=path+"sce/publishManager/toCancleFB.action?pubid="+pub_id;
						document.srcForm.submit();
					}
				}
			})
		}
		
		
		//�������
		function _jcsd(){
			var num = 0;
			var pub_id;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					pub_id = arrays[i].value;
					num++;
				}
				
			}
			if(num < 1){
				page.alert('��ѡ��һ������״̬Ϊ"������"��Ԥ��״̬Ϊ"δ�ݽ�"�ļ�¼��');
				return;
			}else{
				_isSD(pub_id);
			}
		}
		
		//�жϷ�����¼�ķ���״̬�Ƿ�����������˻� true:��  false:��
		function _isSD(pub_id){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=isSD&PUB_ID='+pub_id,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						document.srcForm.action=path+"sce/publishManager/toUnlockFB.action?pubid="+pub_id;
						document.srcForm.submit();
					}else{
						page.alert('��ѡ��һ������״̬Ϊ"������"��Ԥ��״̬Ϊ"δ�ݽ�"�ļ�¼��');
						return false;
					}
				}
			})
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
				document.srcForm.submit();
			}
		}
		
		
		//ҵ���Զ��幦�ܲ���JS
		
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
		
		//��ת����������ͯѡ��ҳ��
		function _toChoseETForFB(){
			_reset();
			document.srcForm.action=path+"sce/publishManager/toChoseETForFB.action";
			document.srcForm.submit();
		}
		
		//�鿴�ö�ͯ����������Ϣ
		function _showLockHistory(ciid){
			$.layer({
				type : 2,
				title : "����������ϸ��Ϣ",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/showLockHistory.action?ciid='+ciid},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
		}
		
		//�鿴�ö�ͯ���η�����Ϣ
		function _showFbHistory(ciid){
			$.layer({
				type : 2,
				title : "��ͯ���η�����ϸ��Ϣ",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/showFbHistory.action?ciid='+ciid},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
		}
		
		//ʡ������Ժ��ѯ�����������跽��
	function selectWelfare(node){
		var provinceId = node.value;
		//���ڻ��Եø�������ID
		var selectedId;
		var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
		if(dataList != null && dataList.size() > 0){
			//���
			document.getElementById("S_WELFARE_ID").options.length=0;
			document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
			for(var i=0;i<dataList.size();i++){
				var data = dataList.getData(i);
				if(selectedId==data.getString("ORG_CODE")){
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					var option = document.getElementById("S_WELFARE_ID");
					document.getElementById("S_WELFARE_ID").value = selectedId;
				}else{					
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
				}
			}
		}else{
			//���
			document.getElementById("S_WELFARE_ID").options.length=0;
			document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
		}
	}
	//ʡ������Ժ��ѯ�����������跽��
	function initProvOrg(){
		var str = document.getElementById("S_PROVINCE_ID");
	     selectWelfare(str);
	}
	
	
	//�鿴�÷�����¼������֯�б�
		function _showFbOrgList(pub_id){
			$.layer({
				type : 2,
				title : "���η�����֯�б�",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/findListForFBORG.action?pub_id='+pub_id},
				area: ['1150px','800px'],
				offset: ['0px' , '0px']
			});
		}

	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_GJSY_CN;BCZL;DFLX_ALL;FBZT;SYS_ADOPT_ORG;PROVINCE;YPZT">
		<BZ:form name="srcForm" method="post" action="sce/publishManager/findListForFBGL.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="reguuid" name="reguuid" value=""/>
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
								<td class="bz-search-title" width="10%">ʡ��</td>
								<td width="15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="77%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="" >
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" width="10%">����Ժ</td>
								<td width="15%">
								   <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="77%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					               </BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="PUB_TYPE" id="S_PUB_TYPE" formTitle="��������" defaultValue="" width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">�㷢</BZ:option>
										<BZ:option value="2">Ⱥ��</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�㷢����</td>
								<td>
									<BZ:select prefix="S_" field="PUB_MODE" id="S_PUB_MODE" isCode="true" codeName="DFLX_ALL" formTitle="�㷢����" defaultValue=""  width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�ر��ע</td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="�ر��ע" defaultValue=""  width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" width="10%">����</td>
								<td width="15%">
									<BZ:input style="width:100px;height:10px" prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150"/>
								</td>
								<td class="bz-search-title" width="10%">�Ա�</td>
								<td width="15%">
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="�Ա�" defaultValue=""  width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��</BZ:option>
										<BZ:option value="2">Ů</BZ:option>
										<BZ:option value="3">����</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" formTitle="" defaultValue=""  width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="2">�ѷ���</BZ:option>
										<BZ:option value="3">������</BZ:option>
										<BZ:option value="4">������</BZ:option>
										
									</BZ:select>
								</td>
								<td class="bz-search-title">Ԥ��״̬</td>
								<td>
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" formTitle="" defaultValue="" codeName="YPZT" isCode="true" width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input style="width:100px;height:10px" field="LOCK_NUM" prefix="S_" id="S_LOCK_NUM" formTitle="��������" defaultValue=""/> 
								</td>
								<td class="bz-search-title">�������</td>
								<td>
									<BZ:input style="width:100px;height:10px" field="DISEASE_CN" prefix="S_" id="S_DISEASE_CN" formTitle="�������" defaultValue=""/> 
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select field="COUNTRY_CODE" notnull="�����뷢������" formTitle="" defaultValue="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN"  width="168px"
									 onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_PUB_ORGID','S_HIDDEN_PUB_ORGID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="PUB_ORGID" id="S_PUB_ORGID" notnull="�����뷢����֯" formTitle="" width="168px"
											onchange="_setOrgID('S_HIDDEN_PUB_ORGID',this.value)">
											<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_PUB_ORGID" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>'>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select field="COUNTRY_CODE2" notnull="��������������" formTitle="" defaultValue="" prefix="S_" isCode="true" id="S_COUNTRY_CODE2" codeName="SYS_GJSY_CN"  width="77%;" 
									onchange="_findSyzzNameListForNew('S_COUNTRY_CODE2','S_ADOPT_ORG_ID2','S_HIDDEN_ADOPT_ORG_ID2')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID2" id="S_ADOPT_ORG_ID2" notnull="������������֯" formTitle="" 
											onchange="_setOrgID('S_ADOPT_ORG_ID2',this.value)">
											<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID2" value='<BZ:dataValue field="PUB_ORGID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />-
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">�״η�������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_START" id="S_PUB_FIRSTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_END\\')}',readonly:true" defaultValue="" formTitle="�״η�������" />-
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_END" id="S_PUB_FIRSTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_START\\')}',readonly:true" defaultValue="" formTitle="�״η�������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="SETTLE_DATE_START" id="S_SETTLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SETTLE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��������" />-
									<BZ:input prefix="S_" field="SETTLE_DATE_END" id="S_SETTLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SETTLE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��������" />
								</td>
								<td class="bz-search-title">ĩ�η�������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="PUB_LASTDATE_START" id="S_PUB_LASTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_END\\')}',readonly:true" defaultValue="" formTitle="ĩ�η�������" />-
									<BZ:input prefix="S_" field="PUB_LASTDATE_END" id="S_PUB_LASTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_START\\')}',readonly:true" defaultValue="" formTitle="ĩ�η�������" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">�ݽ�����</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />-
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_toChoseETForFB()"/>&nbsp;
					<input type="button" value="��������" class="btn btn-sm btn-primary" onclick="_fbcx()"/>&nbsp;
					<input type="button" value="�������" class="btn btn-sm btn-primary" onclick="_jcsd()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls');"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 0.5%;">
									<div class="sorting_disabled">
									</div>
								</th>
								<th style="width: 1%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width:5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="DISEASE_CN">�������</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="PUB_NUM">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_FIRSTDATE">�״η�������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_LASTDATE">ĩ�η�������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_TYPE">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="PUB_ORGID">������֯</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_MODE">�㷢����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SETTLE_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_STATE">����״̬</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ADOPT_ORG_ID">������֯</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting" id="LOCK_NUM">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SUBMIT_DATE">�ݽ�����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RI_STATE">Ԥ��״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="resultData" >
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="PUB_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" /></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue=""  onlyValue="true" checkValue="1=��;2=Ů;3=����"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL"  length="10"/></td>
								<td><BZ:data field="DISEASE_CN" defaultValue="" length="10"/></td>
								<td><a href="javascript:_showFbHistory('<BZ:data field="CI_ID" defaultValue="" onlyValue="true" />')" title="����鿴�ö�ͯ���η�����Ϣ"><BZ:data field="PUB_NUM" defaultValue="" onlyValue="true"/></a></td>
								<td><BZ:data field="PUB_FIRSTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_LASTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_TYPE" defaultValue="" checkValue="1=�㷢;2=Ⱥ��" onlyValue="true"/></td>
								<td>
									
										<%
										   Data resultData=(Data)pageContext.getAttribute("resultData");
										   String pubOrgId = resultData.getString("PUB_ORGID");
										  // System.out.println("pub-->"+pubOrgId);
										   if(null!=pubOrgId && !"".equals(pubOrgId)&& pubOrgId.indexOf(",")>0){
										 %>	
										 <a href="javascript:_showFbOrgList('<BZ:data field="PUB_ID" defaultValue="" onlyValue="true" />')" title="����鿴������֯��Ϣ">
										 	Ⱥ��
										 </a>
										 <%
										   }else{
										 %>
										 	<BZ:data field="PUB_ORGID" defaultValue=""  codeName="SYS_ADOPT_ORG" length="30"/>
										 <% 
										   }
										 %>
									
								</td>
								<td><BZ:data field="PUB_MODE" defaultValue=""  codeName="DFLX_ALL" onlyValue="true"/></td>
								<td><BZ:data field="SETTLE_DATE" defaultValue="" type="Date" onlyValue="true" /></td>
								<td><BZ:data field="PUB_STATE" defaultValue="" onlyValue="true" codeName="FBZT"/></td>
								<td><BZ:data field="ADOPT_ORG_ID" defaultValue="" codeName="SYS_ADOPT_ORG"  onlyValue="true"/></td>
								<td><a href="javascript:_showLockHistory('<BZ:data field="CI_ID" defaultValue="" onlyValue="true" />')" title="����鿴����������¼"><BZ:data field="LOCK_NUM" defaultValue="" onlyValue="true" /></a></td>
								<td><BZ:data field="SUBMIT_DATE" defaultValue="" onlyValue="true" type="Date"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" codeName="YPZT" onlyValue="true" /></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�����ͯ�����б�" exportCode="PROVINCE_ID=CODE,PROVINCE;SN_TYPE=CODE,BCZL;PUB_ORGID=CODE,SYS_ADOPT_ORG;PUB_MODE=CODE,DFLX_ALL;SEX=FLAG,1:��&2:Ů&3:����;SPECIAL_FOCUS=FLAG,0:��&1:��;PUB_TYPE=FLAG,1:�㷢&2:Ⱥ��;PUB_STATE=CODE,FBZT;PUB_FIRSTDATE=DATE;PUB_LASTDATE=DATE;SETTLE_DATE=DATE;SUBMIT_DATE=DATE" 
							exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,20;NAME=��ͯ����,15;SEX=�Ա�,8;SPECIAL_FOCUS=�Ƿ��ر��ע,18;SN_TYPE=��������,15;PUB_FIRSTDATE=�״η�������,18;PUB_LASTDATE=ĩ�η�������,18;PUB_TYPE=��������,15;PUB_ORGID=������֯,40;PUB_MODE=�㷢����,15;SETTLE_DATE=��������,15;PUB_STATE=����״̬,15;ADOPT_ORG_ID=������֯,25;LOCK_NUM=��������,15;SUBMIT_DATE=�ݽ�����,15;"
							/></td>
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