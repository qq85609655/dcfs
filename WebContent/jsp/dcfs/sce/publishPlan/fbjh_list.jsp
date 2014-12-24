<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_list.jsp
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
		<title>�����ƻ��б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
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
				area: ['920px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/publishPlan/findListForFBJH.action";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PLAN_NO").value = "";
			document.getElementById("S_PLAN_USERNAME").value = "";
			document.getElementById("S_PLAN_DATE_START").value = "";
			document.getElementById("S_PLAN_DATE_END").value = "";
			document.getElementById("S_NOTICE_STATE").value = "";
			document.getElementById("S_NOTE_DATE_START").value = "";
			document.getElementById("S_NOTE_DATE_END").value = "";
			document.getElementById("S_PLAN_STATE").value = "";
			document.getElementById("S_PUB_DATE_START").value = "";
			document.getElementById("S_PUB_DATE_END").value = "";
		}
		
		//ҵ���Զ��幦�ܲ���JS
		
		//��ת�����������ƻ�������Ϣҳ��
		function _toPlanBaseInfoAdd(){
			document.srcForm.action=path+"sce/publishPlan/toPlanBaseInfoAdd.action";
			document.srcForm.submit();
		}
		
		//��ת���޸ķ����ƻ�������Ϣҳ��
		function _toPlanBaseInfoRevise(){
			var num = 0;
			var plan_id;
			var pub_state;
			var temp;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					temp= arrays[i].value.split(";");
					plan_id = temp[0];
					pub_state = temp[1];
					num++;
				}
				
			}
			
			if(num < 1){
				page.alert('��ѡ��һ������״̬Ϊ"�ƶ���"�ļ�¼��');
				return;
			}else if(pub_state=='2'||pub_state=='1'){
				page.alert('��ѡ��һ������״̬Ϊ"�ƶ���"�ļ�¼��');
				return;
			}else{
				$("#H_PLAN_ID").val(plan_id);
				document.srcForm.action=path+"sce/publishPlan/toPlanBaseInfoRevise.action";
				document.srcForm.submit();
			}
		}
		
		//�ж��Ƿ������ƶ��µķ����ƻ�
		function _isCanMakeNewPlan(){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.sce.publishPlan.PublishPlanAjax&method=isCanMakeNewPlan',
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(data){
					if(data.FLAG){
						_toPlanBaseInfoAdd();
					}else{
						page.alert('����"�ƶ���"��"������"�ļ�¼�����ȷ��������ƶ��µļƻ���');
						return false;
					}
				}
			})
		}
		
		//ɾ�������ƻ�
		function _deletePlan(){
			if(confirm("ȷ��ɾ���üƻ���")){
				var num = 0;
				var plan_id;
				var pub_state;
				var temp;
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						temp= arrays[i].value.split(";");
						plan_id = temp[0];
						pub_state = temp[1];
						num++;
					}
					
				}
				
				if(num < 1){
					page.alert('��ѡ��һ������״̬Ϊ"�ƶ���"��"������"�ļ�¼��');
					return;
				}else if(pub_state=='2'){
					page.alert('��ѡ��һ������״̬Ϊ"�ƶ���"��"������"�ļ�¼	��');
					return;
				}else{
					$("#H_PLAN_ID").val(plan_id);
					document.srcForm.action=path+"sce/publishPlan/deletePlan.action";
					document.srcForm.submit();
				}
			}
			
		}
		
		//�ƻ�����
		function _planPublish(){
			if(confirm("ȷ�������üƻ���")){
				var num = 0;
				var plan_id;
				var pub_state;
				var temp;
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						temp= arrays[i].value.split(";");
						plan_id = temp[0];
						pub_state = temp[1];
						num++;
					}
					
				}
				
				if(num < 1){
					page.alert('��ѡ��һ������״̬Ϊ"������"�ļ�¼��');
					return;
				}else if(pub_state=='0'||pub_state=='2'){
					page.alert('��ѡ��һ������״̬Ϊ"������"�ļ�¼��');
					return;
				}else{
					$("#H_PLAN_ID").val(plan_id);
					
					$.ajax({
						url: path+'AjaxExecute?className=com.dcfs.sce.publishPlan.PublishPlanAjax&method=isCanPublishPlan&PLAN_ID='+plan_id,
						type: 'POST',
						dataType: 'json',
						timeout: 10000,
						success: function(data){
							if(data.FLAG){
								document.srcForm.action=path+"sce/publishPlan/planPublish.action";
								document.srcForm.submit();
							}else{
								page.alert('�üƻ�û�й�����ͯ�����ڡ�ά������������Ӷ�ͯ��');
								return false;
							}
						}
					})
					
				}
			}
		}
		
		//ά�������ƻ�
		function _toPlanInfoModify(){
			var num = 0;
			var plan_id;
			var pub_state;
			var temp;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					temp= arrays[i].value.split(";");
					plan_id = temp[0];
					pub_state = temp[1];
					num++;
				}
				
			}
			
			if(num < 1){
				page.alert('��ѡ��һ������״̬Ϊ"�ƶ���"��"������"�ļ�¼��');
				return;
			}else if(pub_state=='2'){
				page.alert('��ѡ��һ������״̬Ϊ"�ƶ���"��"������"�ļ�¼��');
				return;
			}else{
				$("#H_PLAN_ID").val(plan_id);
				document.srcForm.action=path+"sce/publishPlan/toModifyPlan.action";
				document.srcForm.submit();
			}
		}
		
		//�����ƻ���ӡ
		function _print(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split(";")[0];
					num ++;
				}
			}
			if(num != "1"){
				alert('��ѡ��һ������');
				return;
			}else{
				window.open(path + "sce/publishPlan/printShow.action?showuuid="+showuuid,"window","height=842,width=680,top=100,left=350,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
			}
		}
		
		//ѡ��������Ķ�ͯ�б�
		function _toViewPlan(plan_id){
			$.layer({
				type : 2,
				title : "�����ƻ���ϸ��Ϣ�鿴",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishPlan/toViewPlan.action?PLAN_ID='+plan_id},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
		}
		
		//�ֶ�Ԥ��
		function _yg(){
			if(confirm("ȷ���ֶ�Ԥ��üƻ���")){
				var num = 0;
				var plan_id;
				var pub_state;
				var notice_state;
				var temp;
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						temp= arrays[i].value.split(";");
						plan_id = temp[0];
						pub_state = temp[1];
						notice_state = temp[2];
						num++;
					}
					
				}
				
				if(num < 1){
					page.alert('��ѡ��һ��Ԥ��״̬Ϊ"δԤ��"�ҷ���״̬Ϊ"������"�ļ�¼��');
					return;
				}else if(pub_state=='0'||pub_state=='2'||notice_state=='1'){
					page.alert('��ѡ��һ��Ԥ��״̬Ϊ"δԤ��"�ҷ���״̬Ϊ"������"�ļ�¼��');
					return;
				}else{
					$("#H_PLAN_ID").val(plan_id);
					document.srcForm.action=path+"sce/publishPlan/sdyg.action";
					document.srcForm.submit();
					
				}
			}
		}

	</script>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" action="sce/publishPlan/findListForFBJH.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<BZ:input type="hidden" prefix="H_" field="PLAN_ID" id="H_PLAN_ID"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" nowrap width="10%">�ƻ�����</td>
								<td nowrap width="15%">
									<BZ:input prefix="S_" field="PLAN_NO" id="S_PLAN_NO" defaultValue="" formTitle="�ƻ�����" maxlength="9"/>
								</td>
								<td class="bz-search-title" nowrap width="10%">�ƶ���</td>
								<td nowrap width="15%">
									<BZ:input field="PLAN_USERNAME" prefix="S_" id="S_PLAN_USERNAME" formTitle="�ƶ���" defaultValue=""/> 
								</td>
								<td class="bz-search-title" nowrap width="10%">Ԥ��״̬</td>
								<td nowrap width="15%">
									<BZ:select prefix="S_" field="NOTICE_STATE" id="S_NOTICE_STATE" formTitle="Ԥ��״̬" defaultValue=""  >
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δԤ��</BZ:option>
										<BZ:option value="1">��Ԥ��</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" nowrap width="10%">����״̬</td>
								<td nowrap width="15%">
									<BZ:select prefix="S_" field="PLAN_STATE" id="S_PLAN_STATE"  formTitle="����״̬" defaultValue="" >
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">�ƶ���</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�ѷ���</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" nowrap>�ƶ�����</td>
								<td nowrap colspan="2">
									<BZ:input prefix="S_" field="PLAN_DATE_START" id="S_PLAN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PLAN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�ƶ�����" />~
									<BZ:input prefix="S_" field="PLAN_DATE_END" id="S_PLAN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PLAN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�ƶ�����" />
								</td>
								<td class="bz-search-title" nowrap>Ԥ������</td>
								<td nowrap colspan="2">
									<BZ:input prefix="S_" field="NOTE_DATE_START" id="S_NOTE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼԤ������" />~
									<BZ:input prefix="S_" field="NOTE_DATE_END" id="S_NOTE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹԤ������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" nowrap>��������</td>
								<td nowrap colspan="5">
									<BZ:input prefix="S_" field="PUB_DATE_START" id="S_PUB_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="PUB_DATE_END" id="S_PUB_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_isCanMakeNewPlan()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_toPlanBaseInfoRevise()"/>&nbsp;
					<input type="button" value="ά&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_toPlanInfoModify()"/>&nbsp;
					<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_deletePlan()"/>&nbsp;
					<input type="button" value="�ֶ�Ԥ��" class="btn btn-sm btn-primary" onclick="_yg()"/>&nbsp;
					<input type="button" value="�ֶ�����" class="btn btn-sm btn-primary" onclick="_planPublish()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print();"/>
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls');"/>
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
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width:9%;">
									<div class="sorting" id="PLAN_NO">�ƻ�����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PLAN_USERNAME">�ƶ���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PLAN_DATE">�ƶ�����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PUB_NUM">��ͯ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTICE_STATE">Ԥ��״̬</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTE_DATE">Ԥ������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PLAN_STATE">����״̬</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_DATE">��������</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="PLAN_ID" onlyValue="true"/>;<BZ:data field="PLAN_STATE" onlyValue="true"/>;<BZ:data field="NOTICE_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><a href="javascript:void" title="����鿴�ƻ���ϸ��Ϣ" onclick="_toViewPlan('<BZ:data field="PLAN_ID" onlyValue="true"/>')"><BZ:data field="PLAN_NO" defaultValue="" onlyValue="true" /></a></td>
								<td><BZ:data field="PLAN_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PLAN_DATE" defaultValue="" type="Date" onlyValue="true" /></td>
								<td><BZ:data field="PUB_NUM" defaultValue=""  onlyValue="true" /></td>
								<td><BZ:data field="NOTICE_STATE" defaultValue="" checkValue="0=δԤ��;1=��Ԥ��" onlyValue="true"/></td>
								<td><BZ:data field="NOTE_DATE" defaultValue=""  type="DateTime" onlyValue="true"/></td>
								<td><BZ:data field="PLAN_STATE" defaultValue="" checkValue="0=�ƶ���;1=������;2=�ѷ���" onlyValue="true"/></td>
								<td><BZ:data field="PUB_DATE" defaultValue="" type="DateTime" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�����ƻ��б�" exportCode="NOTICE_STATE=FLAG,0:δԤ��&1:��Ԥ��;PLAN_STATE=FLAG,0:�ƶ���&1:������&2=�ѷ���;PLAN_DATE=DATE;NOTE_DATE=DATE;PUB_DATE=DATE" 
							exportField="PLAN_NO=�ƻ�����,15,20;PLAN_USERNAME=�ƶ���,20;PLAN_DATE=�ƶ�����,15;PUB_NUM=��ͯ����,8;NOTICE_STATE=Ԥ��״̬,15;NOTE_DATE=Ԥ������,15;PLAN_STATE=����״̬,15;PUB_DATE=��������,15;"
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