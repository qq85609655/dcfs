<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
	 * @Description: ԭ��֯���ı���б�
	 * @author mayun   
	 * @date 2014-8-6
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
		<title>ԭ��֯���ı���б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
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
			document.srcForm.action=path+"ffs/registration/toChoseFile.action";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_NAME").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
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
				alert('��ѡ��һ������');
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
				alert('��ѡ��һ��Ҫ�鿴������');
				return;
			}else{
				window.open(path+"ffs/registration/show.action?showuuid="+showuuid,'newwindow','height=550,width=1000,top=70,left=180,scrollbars=yes');
				document.srcForm.submit();
			}
		}
		
		//ҵ���Զ��幦�ܲ���JS
		
 		 /**
	*
	*���ݹ����г�����������֯
	*@ author :mayun
	*@ date:2014-7-24
	*/
	function _findSyzzNameList(){
		$("#S_ADOPT_ORG_NAME").val("");//���������֯����
		$("#S_ADOPT_ORG_ID").val("");//���������֯ID
		var countryCode = $("#S_COUNTRY_CODE").find("option:selected").val();//����Code
		var language = $("#S_ADOPT_ORG_ID").attr("isShowEN");//�Ƿ���ʾӢ��
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
					$("#S_ADOPT_ORG_NAME").autocomplete(data,option);   
					$("#S_ADOPT_ORG_NAME").setOptions(data).flushCache();//�������
			        $("#S_ADOPT_ORG_NAME").result(function(event, value, formatted){//ѡ������Code��ֵ����
			        	$("#S_ADOPT_ORG_ID").val(value.CODEVALUE);
					}); 
				}
			  });
		}else{
			//alert("��ѡ�����!");
			return false;
		}
	}
	
	//
	function _add(){
		var temp=document.getElementsByName("xuanze");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var fileNo = temp[i].value;
				window.opener._dySetFileInfo(fileNo);
				window.close();
			}
		}
	}


	</script>
	<BZ:body property="data" codeNames="GJSY;SYZZ">
		<BZ:form name="srcForm" method="post" action="ffs/registration/findList.action">
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
									<span title="����">����</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" notnull="���������" formTitle=""
										prefix="S_" isCode="true" codeName="GJSY" width="70%"
										onchange="_findSyzzNameList()">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="������֯">������֯</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="ADOPT_ORG_NAME"
										id="S_ADOPT_ORG_NAME" defaultValue="" formTitle="������֯"/>
									<BZ:input type="hidden" field="ADOPT_ORG_ID" prefix="S_"
										id="S_ADOPT_ORG_ID" defaultValue="" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="��������">��������</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />��
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%">
									<span title="���ı��">���ı��</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO"
										defaultValue="" formTitle="���ı��"/>
								</td>
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
					<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_add()"/>&nbsp;
					<input type="button" value="ȡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="javascript:window.close()"/>&nbsp;
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
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">
										���
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FILE_NO">
										���ı��
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REGISTER_DATE">
										��������
									</div>
								</th>
								<th style="width: 10%;">
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
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="dataList">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="FILE_NO" onlyValue="true"/>" 
									class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="FILE_NO" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"  />
								</td>
								<td>
									<BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" />
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
							<td><BZ:page form="srcForm" property="List"/></td>
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