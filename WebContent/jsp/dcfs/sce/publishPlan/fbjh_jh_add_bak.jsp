<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_jh_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 Data data= (Data)request.getAttribute("data");
 String pub_type = data.getString("PUB_TYPE");//��������
 String pub_mode = data.getString("PUB_MODE");//�㷢����
 String pub_orgid = data.getString("PUB_ORGID");//�㷢��֯ID
 String country_code = data.getString("COUNTRY_CODE");//�㷢����
 String adopt_org_name = data.getString("ADOPT_ORG_NAME");//�㷢��֯����
 String tmp_tmp_pub_orgid_name = data.getString("TMP_TMP_PUB_ORGID_NAME");//Ⱥ����֯����
 String pub_remarks = data.getString("PUB_REMARKS");//�㷢��ע
%>
<BZ:html>
	<BZ:head>
		<title>�ƶ��ƻ���ϸҳ��</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			_dynamicFblx();
			_getAzqxForFb();
			dyniframesize(['mainFrame']);
		});
		
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
		/**
		*
		*���ݹ����г�����������֯
		*@ author :mayun
		*@ date:2014-7-24
		*/
		function _findSyzzNameList(){
			$("#P_ADOPT_ORG_NAME").val("");//���������֯����
			$("#P_PUB_ORGID").val("");//���������֯ID
			var countryCode = $("#P_COUNTRY_CODE").find("option:selected").val();//����Code
			var language = $("#P_PUB_ORGID").attr("isShowEN");//�Ƿ���ʾӢ��
			if(null != countryCode&&""!=countryCode){
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=findSyzzNameList&countryCode='+countryCode,
					type: 'POST',
					dataType: 'json',
					timeout: 1000,
					success: function(data){
				       var option ={
					      dataType: 'json',
						  width: 320,        //ָ��������Ŀ��. Default: inputԪ�صĿ��
						  max: 100,            //������ʾ��Ŀ�ĸ���.Default: 10
						  delay :1000,
						  highlight: false,
						  scroll: true,
						  minChars: 0,        //�ڴ���autoCompleteǰ�û�������Ҫ������ַ���.Default: 1�������Ϊ0�����������˫������ɾ�������������ʱ��ʾ�б�
						  autoFill: true,    //Ҫ��Ҫ���û�ѡ��ʱ�Զ����û���ǰ������ڵ�ֵ���뵽input��. Default: false
						  mustMatch:false,    //�������Ϊtrue,autoCompleteֻ������ƥ��Ľ�������������,���е��û�������ǷǷ��ַ�ʱ����ò���������.Default: false
					      matchContains: true,//�����Ƚ�ʱ�Ƿ�Ҫ���ַ����ڲ��鿴ƥ��,��ba�Ƿ���foo bar�е�baƥ��.ʹ�û���ʱ�Ƚ���Ҫ.��Ҫ��autofill����.Default: false
					      cacheLength:1,      //����ĳ���.���Դ����ݿ���ȡ���Ľ����Ҫ�����������¼.���1Ϊ������.Default: 10
					      matchSubset:false,   //autoComplete�ɲ�����ʹ�öԷ�������ѯ�Ļ���,��������foo�Ĳ�ѯ���,��ô����û�����foo�Ͳ���Ҫ�ٽ��м�����,ֱ��ʹ�û���.ͨ���Ǵ����ѡ���Լ���������ĸ������������.ֻ���ڻ��泤�ȴ���1ʱ��Ч.Default: true
					      matchCase:false,    // �Ƚ��Ƿ�����Сд���п���.ʹ�û���ʱ�Ƚ���Ҫ.����������һ��ѡ��,���Ҳ�Ͳ������,�ͺñ�footҪ��Ҫ��FOO�Ļ�����ȥ��.Default: false   	  
				          multiple:false,     //�Ƿ�����������ֵ�����ʹ��autoComplete��������ֵ. Default: false
				          multipleSeparator:",",//����Ƕ�ѡʱ,�����ֿ�����ѡ����ַ�. Default: ","
				          maxitemstoshow:-1,  //��Ĭ��ֵ�� -1 �� ���ƵĽ����������ʾ�����������Ƿǳ����õ�������д��������ݺͲ���Ϊ�û��ṩһ���嵥���г����ܰ������԰ټƵ���Ŀ��Ҫ���ô˹��ܣ�����ֵ����Ϊ-1 ��
							
				          formatItem: function(row, i, max){//���ݼ��ش���
				          	if(language){
				          		return row.CODELETTER ;
				          	}else {
				          		return row.CODENAME;
				          	}
				               
				          },
				          formatMatch: function(row, i, max){//����ƥ�䴦��
				          if(language){
				          		return row.CODELETTER ;
				          	}else {
				          		return row.CODENAME ;
				          	}
				          },
				          formatResult: function(row){//���ݽ������
				          	if(language){
				          		return row.CODELETTER ;
				          	}else {
				          		return row.CODENAME ;
				          	}
				          }            
						}
						$("#P_ADOPT_ORG_NAME").autocomplete(data,option);   
						$("#P_ADOPT_ORG_NAME").setOptions(data).flushCache();//�������
				        $("#P_ADOPT_ORG_NAME").result(function(event, value, formatted){//ѡ������Code��ֵ����
				        	$("#P_PUB_ORGID").val(value.CODEVALUE);
						}); 
					}
				  });
			}else{
				//alert("��ѡ�����!");
				return false;
			}
		}
		
		//��ͯ�����ƻ��ύ
		function _submit(){
			if(confirm("ȷ���ύ��")){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}
				//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
				$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
				$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
				//���ύ
				var obj = document.forms["srcForm"];
				obj.action=path+'sce/publishPlan/saveFbInfo.action';
				obj.submit();
			}
		}
		
		//��ͯ�����ƻ�����
		function _save(){
			if(confirm("ȷ��������")){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}
				//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
				$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
				$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
				//���ύ
				var obj = document.forms["srcForm"];
				obj.action=path+'sce/publishPlan/saveFbInfo.action';
				obj.submit();
			}
		}
		
		//���ݵ㷢��Ⱥ����̬չ���������
		function _dynamicFblx(){
			$("#P_COUNTRY_CODE").val("");
			$("#P_ADOPT_ORG_NAME").val("");
			$("#P_PUB_ORGID").val("");
			$("#M_PUB_ORGID").val("");
			$("#PUB_ORGID").val("");
			$("#P_PUB_MODE").val("");
			$("#M_PUB_MODE").val("");
			$("#P_SETTLE_DATE_NORMAL").val("");
			$("#P_SETTLE_DATE_SPECIAL").val("");
			$("#M_SETTLE_DATE_NORMAL").val("");
			$("#M_SETTLE_DATE_SPECIAL").val("");
			$("#P_PUB_REMARKS").val("");
			
			//**************�������begin********************
			var hx_pub_type = $("#H_PUB_TYPE").val();
			var hx_pub_mode = $("#H_PUB_MODE").val();
			var hx_country_code = $("#H_COUNTRY_CODE").val();
			var hx_adopt_org_name = $("#H_ADOPT_ORG_NAME").val();
			var hx_tmp_tmp_pub_orgid_name = $("#H_TMP_TMP_PUB_ORGID_NAME").val();
			var hx_pub_remarks = $("#H_PUB_REMARKS").val();
			
			if(null==hx_adopt_org_name||"null"==hx_adopt_org_name){
				hx_adopt_org_name="";
			}
			
			if(null==hx_tmp_tmp_pub_orgid_name||"null"==hx_tmp_tmp_pub_orgid_name){
				hx_tmp_tmp_pub_orgid_name="";
			}
			
			if(null==hx_pub_remarks||"null"==hx_pub_remarks){
				hx_pub_remarks="";
			}
			$("#P_ADOPT_ORG_NAME").val(hx_adopt_org_name);
			$("#PUB_ORGID").val(hx_tmp_tmp_pub_orgid_name);
			$("#P_PUB_REMARKS").val(hx_pub_remarks);
			
			var count = $("#P_PUB_TYPE option").length;  
            for ( var i = 0; i < count; i++) {  
                if ($("#P_PUB_TYPE ").get(0).options[i].value == hx_pub_type) {  
                    $("#P_PUB_TYPE ").get(0).options[i].selected = true;  
                    break;  
                }  
            } 
            
            var count2 = $("#P_PUB_MODE option").length;  
            for ( var i = 0; i < count2; i++) {  
                if ($("#P_PUB_MODE ").get(0).options[i].value == hx_pub_mode) {  
                    $("#P_PUB_MODE ").get(0).options[i].selected = true;  
                    break;  
                }  
            }
            
            var count3 = $("#P_COUNTRY_CODE option").length;  
            for ( var i = 0; i < count3; i++) {  
                if ($("#P_COUNTRY_CODE ").get(0).options[i].value == hx_country_code) {  
                    $("#P_COUNTRY_CODE ").get(0).options[i].selected = true;  
                    break;  
                }  
            }
            
            $("#H_PUB_TYPE").val("");
			$("#H_PUB_MODE").val("");
			$("#H_COUNTRY_CODE").val("");
			$("#H_ADOPT_ORG_NAME").val("");
			$("#H_TMP_TMP_PUB_ORGID_NAME").val("")
			$("#H_PUB_REMARKS").val("")
			//**************�������end********************
			
			var optionValue = $("#P_PUB_TYPE").find("option:selected").val();
			if(optionValue=="1"){//�㷢
				$("#P_COUNTRY_CODE").attr("notnull","���������");
				$("#P_ADOPT_ORG_NAME").attr("notnull","�����뷢����֯");
				$("#P_PUB_MODE").attr("notnull","������㷢����");
				$("#PUB_ORGID").removeAttr("notnull");
				
				$("#dfzz").show();
				$("#dflx").show();
				$("#dfbz").show();
				$("#qfzz").hide();
				$("#qflx").hide();
			}else{//Ⱥ��
				$("#PUB_ORGID").attr("notnull","��ѡ�񷢲���֯");
				$("#P_COUNTRY_CODE").removeAttr("notnull");
				$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
				$("#P_PUB_MODE").removeAttr("notnull");
				
				$("#dfzz").hide();
				$("#dflx").hide();
				$("#dfbz").hide();
				$("#qfzz").show();
				$("#qflx").show();
			}
			
		}
	
		//��ð�������
		function _getAzqxForFb(){
			var is_df = $("#P_PUB_TYPE").find("option:selected").val();//��������  1���㷢  2��Ⱥ��
			var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//�㷢����  
			
			if(""==pub_mode){
				pub_mode=null;
			}
			
			if("1"==is_df && (""==pub_mode||null==pub_mode)){
				return;
			}else{
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getAZQXInfo&IS_DF='+is_df+'&PUB_MODE='+pub_mode,
					type: 'POST',
					dataType: 'json',
					timeout: 1000,
					success: function(data){
						var two_type1 = data[0].TWO_TYPE;//�Ƿ��ر��ע  0:��  1����
						var settle_months1 = data[0].SETTLE_MONTHS;
						var two_type2 = data[1].TWO_TYPE;//�Ƿ��ر��ע  0:��  1����
						var settle_months2 = data[1].SETTLE_MONTHS;
						if("1"==is_df){//�㷢����
							if("0"==two_type1){//���ر��ע
								$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
								$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
							}else {//�ر��ע
								$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
								$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
							}
						}else {//Ⱥ������
							if("0"==two_type1){//���ر��ע
								$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
								$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
							}else {//�ر��ע
								$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
								$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
							}
						}
					}
				})
			}
		
		}
		
		
		//�Ƴ���ͯ
		function _removeET(){
			var num = 0;
			var ci_id ="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					if(num==0){
						ci_id=arrays[i].value;
					}else{
						ci_id += ","+arrays[i].value;
					}
					
					num++;
				}
				
			}
			if(num < 1){
				page.alert('��ѡ������һ����¼��');
				return;
			}else{
				document.getElementById("H_REMOVE_CIIDS").value=ci_id;
				document.srcForm.action=path+"sce/publishPlan/removeET.action";
				document.srcForm.submit();
			}
		
		}
		
		//ѡ��������Ķ�ͯ�б�
		function _toChoseETForJH(){
			var TOTAL_CIIDS = $("#H_TOTAL_CIIDS").val();
			$.layer({
				type : 2,
				title : "ѡ��������Ķ�ͯ�б�",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishPlan/toChoseETForJH.action?TOTAL_CIIDS='+TOTAL_CIIDS+'&METHOD=0'},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
		}
		
		
		function _goback(){
			window.location.href=path+"sce/publishPlan/findListForFBJH.action";
		}
		
		//�����ƻ�������ύ  0������  1���ύ
		function saveFBJHInfo(method){
			document.srcForm.action=path+"sce/publishPlan/saveFBJHInfo.action?method="+method;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<BZ:input type="hidden" field="PLAN_ID" prefix="H_"/>
		<BZ:input type="hidden" field="PUB_NUM" prefix="H_"/>
		<BZ:input type="hidden" field="TOTAL_CIIDS" prefix="H_" id="H_TOTAL_CIIDS"/><!-- �ܶ�ͯIDS -->
		<BZ:input type="hidden" field="ADD_CIIDS" prefix="H_" id="H_ADD_CIIDS"/><!-- ��Ӷ�ͯIDS -->
		<BZ:input type="hidden" field="REMOVE_CIIDS" prefix="H_" id="H_REMOVE_CIIDS"/><!-- �Ƴ���ͯIDS -->
		<BZ:input type="hidden" field="PUB_TYPE" prefix="H_" id="H_PUB_TYPE" defaultValue="<%=pub_type %>"/><!-- ���Է������� -->
		<BZ:input type="hidden" field="PUB_MODE" prefix="H_" id="H_PUB_MODE" defaultValue="<%=pub_mode %>"/><!-- ���Ե㷢���� -->
		<BZ:input type="hidden" field="COUNTRY_CODE" prefix="H_" id="H_COUNTRY_CODE" defaultValue="<%=country_code %>"/><!-- ���Ե㷢���� -->
		<BZ:input type="hidden" field="ADOPT_ORG_NAME" prefix="H_" id="H_ADOPT_ORG_NAME" defaultValue="<%=adopt_org_name %>"/><!-- ���Ե㷢��֯���� -->
		<BZ:input type="hidden" field="TMP_TMP_PUB_ORGID_NAME" prefix="H_" id="H_TMP_TMP_PUB_ORGID_NAME" defaultValue="<%=tmp_tmp_pub_orgid_name %>"/><!-- ����Ⱥ����֯���� -->
		<BZ:input type="hidden" field="PUB_REMARKS" prefix="H_" id="H_PUB_REMARKS" defaultValue="<%=pub_remarks %>"/><!-- ���Ե㷢��ע -->
		
		
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��Ӷ�ͯ" class="btn btn-sm btn-primary" onclick="_toChoseETForJH()"/>&nbsp;
					<input type="button" value="�Ƴ���ͯ" class="btn btn-sm btn-primary" onclick="_removeET()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!-- �༭����begin -->
				<div class="bz-edit clearfix" desc="�༭����">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>�����ƻ�������Ϣ</div>
						</div>
						<!-- �������� end -->
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>Ԥ������</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="date" field="NOTE_DATE" prefix="J_"  formTitle="Ԥ������" notnull="������Ԥ������"/>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="date" field="PUB_DATE" prefix="J_" formTitle="��������" notnull="�����뷢������"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�ƶ���</td>
									<td class="bz-edit-data-value"   width="12%">
										<BZ:dataValue field="PLAN_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�ƶ�����</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PLAN_DATE" defaultValue="" onlyValue="true" type="Date"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">��ͯ����</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">�ر��ע����</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM_TB" defaultValue=""  onlyValue="true" />
									</td>
									<td class="bz-edit-data-title" width="10%">���ر��ע����</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PUB_NUM_FTB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- �༭����end -->
				<br/>
				
				<!-- �༭����begin -->
				<div class="bz-edit clearfix" desc="�༭����">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>������Ϣ</div>
						</div>
						<!-- �������� end -->
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
									<td class="bz-edit-data-value">
										<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="�����뷢������" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()">
											<option value="1">�㷢</option>
											<option value="2">Ⱥ��</option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>������֯</td>
									<td class="bz-edit-data-value" id="dfzz">
										<BZ:select field="COUNTRY_CODE" id="P_COUNTRY_CODE" notnull="���������" formTitle="" prefix="P_" isCode="true" codeName="GJSY"  onchange="_findSyzzNameList()">
											<option value="">--��ѡ��--</option>
										</BZ:select> ��
										<BZ:input  prefix="P_" field="ADOPT_ORG_NAME" id="P_ADOPT_ORG_NAME" defaultValue="<%=adopt_org_name %>" className="inputOne" formTitle="������֯" style="height:13px;width:50%" maxlength="300" notnull="�����뷢����֯" />
										<BZ:input type="hidden" field="PUB_ORGID"  prefix="P_" id="P_PUB_ORGID"/>
									</td>
									<td class="bz-edit-data-value" id="qfzz" style="display:none">
										<BZ:input prefix="M_" field="PUB_ORGID"  type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="ѡ�񷢲���֯" treeType="1" helperSync="true" showParent="false" defaultShowValue="" defaultValue="<%=pub_orgid %>" showFieldId="PUB_ORGID" notnull="��ѡ�񷢲���֯" style="height:13px;width:80%"  />
									</td>
								</tr>
								<tr id="dflx">
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>�㷢����</td>
									<td class="bz-edit-data-value"  >
										<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="������㷢����" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
											<option value="">--��ѡ��--</option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title" width="10%">��������</td>
									<td class="bz-edit-data-value" >
										<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£��ر��ע��
										<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£����ر��ע��
									</td>
								</tr>
								<tr id="qflx" style="display:none">
									<td class="bz-edit-data-title" width="10%">��������</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£��ر��ע��
										<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£����ر��ע��
									</td>
									
								</tr>
								<tr id="dfbz">
									<td class="bz-edit-data-title poptitle">�㷢��ע</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="�㷢��ע" defaultValue="" style="width:80%"  maxlength="900"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- �༭����end -->
				<br/>
				
				<div class="bz-edit clearfix" desc="�༭����">
					<div class="ui-widget-content ui-corner-all">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>��ѡ���ͯ�б�</div>
						</div>
						<!-- �������� end -->
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
										<th style="width: 3%;">
											<div class="sorting_disabled">���</div>
										</th>
										<th style="width:5%;">
											<div class="sorting_disabled" id="PROVINCE_ID">ʡ��</div>
										</th>
										<th style="width: 9%;">
											<div class="sorting_disabled" id="WELFARE_NAME_CN">����Ժ</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="NAME">����</div>
										</th>
										<th style="width: 3%;">
											<div class="sorting_disabled" id="SEX">�Ա�</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="BIRTHDAY">��������</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="SN_TYPE">��������</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="SPECIAL_FOCUS">�ر��ע</div>
										</th>
										
									</tr>
								</thead>
								<tbody>
									<BZ:for property="List">
										<tr class="emptyData">
											<td class="center">
												<input name="xuanze" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>,<BZ:data field="SPECIAL_FOCUS" onlyValue="true"/>" class="ace">
											</td>
											<td class="center">
												<BZ:i/>
											</td>
											<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""   onlyValue="true"/></td>
											<td><BZ:data field="NAME" defaultValue=""  codeName="DFLX" onlyValue="true"/></td>
											<td><BZ:data field="SEX" defaultValue="" checkValue="1=��;2=Ů;3=����" length="20"/></td>
											<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
											<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
											<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��" onlyValue="true"/></td>
										</tr>
									</BZ:for>
								</tbody>
							</table>
						</div>
						<!--��ѯ����б���End -->
					</div>
				</div>
			
				<!-- ��ť�� ��ʼ -->
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="��ť��">
						<a href="reporter_files_list.html" >
							<input type="button" value="����" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(0);"/>
						</a>
						<a href="reporter_files_list.html" >
							<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(1);"/>
						</a>
						<a href="reporter_files_list.html" >
							<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback()"/>
						</a>
					</div>
				</div>
				<!-- ��ť�� ���� -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>