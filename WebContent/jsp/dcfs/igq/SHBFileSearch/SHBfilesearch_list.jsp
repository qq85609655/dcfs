<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: SHBfilesearch.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-9-29 ����16:19:01 
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
		<title>�ļ���ѯ�б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<link rel="stylesheet" type="text/css" href="/dcfs/resource/css/flexigrid.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/iframe.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/jquery.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/jquery-scrolltofixed.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/flexigrid.js"></script>
		<style>
		#listtitle{
			url("/dcfs/resource/css/images/fhbg.gif") repeat-x scroll center bottom rgb(250, 250, 250);
		    background-color: rgb(250, 250, 250);
		    background-image: url("/dcfs/resource/css/images/fhbg.gif");
		    background-repeat: repeat-x;
		    background-attachment: scroll;
		    background-position: center bottom;
		    background-clip: border-box;
		    background-origin: padding-box;
		    background-size: auto auto;
			font-weight: normal;
		}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			$('#anniuqu').scrollToFixed();
			$('#listtitle').scrollToFixed({marginTop:40});
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
				area: ['900px','230px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"igq/BGSFileSearch/SHBFileList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_MALE_NATION").value = "";
			document.getElementById("S_MALE_BIRTHDAY_START").value = "";
			document.getElementById("S_MALE_BIRTHDAY_END").value = "";
			document.getElementById("S_FEMALE_NATION").value = "";
			document.getElementById("S_FEMALE_BIRTHDAY_START").value = "";
			document.getElementById("S_FEMALE_BIRTHDAY_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_FAMILY_TYPE").value = "";
			document.getElementById("S_IS_CONVENTION_ADOPT").value = "";
		}
		
		//�鿴�ļ���ϸ��Ϣ
		function _show(){
			var num = 0;
			var showuuid = "";
			var ri_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split("#")[0];
					ri_id = arrays[i].value.split("#")[2];
					num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴���ļ���");
				return;
			}else{
				document.srcForm.action = path + "igq/BGSFileSearch/showSHBData.action?showuuid=" + showuuid + "&ri_id=" + ri_id;
				document.srcForm.submit();
			}
		}
		
		//�ļ���ѯ�б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		
	</script>
	<BZ:body property="data" codeNames="WJLX_DL;WJLX;GJSY;GJ;SYZZ;SYLX;FYDW;WJFYZL;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_CHILDREN_SEX;ETXB;PROVINCE;WJWZ;WJQJZT_ZX">
		<BZ:form name="srcForm" method="post" action="igq/SHBFileSearch/SHBFileList.action">
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
								<td class="bz-search-title" style="width: 10%">���ı��</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">�ļ�����</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" />
								</td>
								<td class="bz-search-title">�з�����</td>
								<td>
									<BZ:select prefix="S_" field="MALE_NATION" id="S_MALE_NATION" isCode="true" codeName="GJ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�г�������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_BIRTHDAY_START" id="S_MALE_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_MALE_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�г�������" />~
									<BZ:input prefix="S_" field="MALE_BIRTHDAY_END" id="S_MALE_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_MALE_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�г�������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150" />
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:select prefix="S_" field="FEMALE_NATION" id="S_FEMALE_NATION" isCode="true" codeName="GJ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">Ů��������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_BIRTHDAY_START" id="S_FEMALE_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEMALE_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼŮ��������" />~
									<BZ:input prefix="S_" field="FEMALE_BIRTHDAY_END" id="S_FEMALE_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEMALE_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹŮ��������" />
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="GJSY" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="FAMILY_TYPE" id="S_FAMILY_TYPE" isCode="true" codeName="SYLX" formTitle="��������" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�Ƿ�Լ����</td>
								<td>
									<BZ:select prefix="S_" field="IS_CONVENTION_ADOPT" id="S_IS_CONVENTION_ADOPT" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
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
				<div class="table-row table-btns" style="text-align: left" id="anniuqu">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="flexme1" >
						<thead id="listtitle">
							<tr>
								<th class="center" width="20">
								</th>
								<th width="40"  >���</th>
								<th width="80">���ı��</th>
								<th width="80">��������</th>
								<th width="80">����</th>
								<th width="150">������֯</th>
								<th width="80">�ļ�����</th>
	                            <th width="80">��������</th>
	                            <th width="80">�Ƿ�Լ����</th>
								<th width="150">��������</th>
								<th width="80">�г�������</th>
	                            <th width="80">�й���</th>
	                            <th width="80">���Ļ��̶�</th>
	                            <th width="80">�н���״��</th>
								<th width="150">Ů������</th>
								<th width="80">Ů��������</th>
	                            <th width="80">Ů����</th>
	                            <th width="80">Ů�Ļ��̶�</th>
	                            <th width="80">Ů����״��</th>
	                            <th width="80">����Ҫ��</th>
	                            <th width="80">δ������Ů����</th>
	                            <th width="200">��ͥ��Ҫ˵����������</th>
	                            <th width="80">������׼����</th>
	                            <th width="80">��Ч����</th>
	                            <th width="80">��׼��ͯ����</th>
	                            <th width="80">��׼��ͯ�Ա�</th>
	                            <th width="120">��׼������ͯ����״��</th>
	                            <th width="80">���뵥λ	</th>
	                            <th width="80">��������</th>
	                            <th width="80">���ϸ�ԭ��</th>
	                            <th width="80">��ͯ����</th>
								<th width="80">��ͯ�Ա�</th>
								<th width="80">��ͯ��������</th>
								<th width="80">ʡ��</th>
								<th width="120">����Ժ</th>
								<th width="80">��ͣ״̬</th>
	                            <th width="80">����״̬</th>
	                            <th width="100">�����ļ�״̬</th>
	                            <th width="80">�ļ�״̬</th>
	                            <th width="120">�ļ�λ��</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="RI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td><BZ:i/></td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="FAMILY_TYPE" defaultValue="" codeName="SYLX" onlyValue="true"/></td>
								<td><BZ:data field="IS_CONVENTION_ADOPT" defaultValue="" checkValue="0=��;1=��" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NATION" defaultValue="" codeName="GJ" onlyValue="true"/></td>
								<td><BZ:data field="MALE_EDUCATION" defaultValue="" codeName="ADOPTER_EDU" onlyValue="true"/></td>
								<td><BZ:data field="MALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NATION" defaultValue="" codeName="GJ" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_EDUCATION" defaultValue="" codeName="ADOPTER_EDU" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_REQUEST_CN" defaultValue="" /></td>
								<td><BZ:data field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REMARK_CN" defaultValue="" /></td>
								<td><BZ:data field="GOVERN_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="EXPIRE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" onlyValue="true"/></td>
								<td><BZ:data field="CHILDREN_HEALTH_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSLATION_COMPANY" defaultValue="" codeName="FYDW" onlyValue="true"/></td>
								<td><BZ:data field="TRANSLATION_QUALITY" defaultValue="" codeName="WJFYZL" onlyValue="true"/></td>
								<td><BZ:data field="UNQUALITIED_REASON" defaultValue="" /></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECOVERY_STATE" defaultValue="" checkValue="1=����ͣ;9=ȡ����ͣ" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=��ȷ��;1=��ȷ��;2=������;3=�Ѵ���;9=ȡ������" onlyValue="true"/></td>
								<td><BZ:data field="SUPPLY_STATE" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���" onlyValue="true"/></td>
								<td><BZ:data field="AF_GLOBAL_STATE" defaultValue="" codeName="WJQJZT_ZX" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" defaultValue="" codeName="WJWZ" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
					
					<script type="text/javascript">
						$('.flexme1').flexigrid({
							usepager: false,//�Ƿ��ҳ
							title: '',
							showTableToggleBtn: true,
							width: 'auto',
						   // onSubmit: addFormData,
							height: '440',
							horizontalScrollPolicy:true,
							nomsg:'û�з��������ļ�¼����',
							novstripe: false,//û�ù��������
							striped: true,  //�Ƿ���ʾ����Ч����Ĭ������ż��������ʽ
							resizable: false  //table�Ƿ������
						});
			   		</script>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�ļ���Ϣ" 
								exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;FILE_TYPE=CODE,WJLX;FAMILY_TYPE=CODE,SYLX;IS_CONVENTION_ADOPT=FLAG,0:��&1:��;MALE_BIRTHDAY=DATE;MALE_NATION=CODE,GJ;MALE_EDUCATION=CODE,ADOPTER_EDU;MALE_HEALTH=CODE,ADOPTER_HEALTH;FEMALE_BIRTHDAY=DATE;FEMALE_NATION=CODE,GJ;FEMALE_EDUCATION=CODE,ADOPTER_EDU;FEMALE_HEALTH=CODE,ADOPTER_HEALTH;GOVERN_DATE=DATE;EXPIRE_DATE=DATE;CHILDREN_SEX=CODE,ADOPTER_CHILDREN_SEX;TRANSLATION_COMPANY=CODE,FYDW;TRANSLATION_QUALITY=CODE,WJFYZL;SEX=CODE,ETXB;BIRTHDAY=DATE;PROVINCE_ID=CODE,PROVINCE;RECOVERY_STATE=FLAG,1:����ͣ&9:ȡ����ͣ;RETURN_STATE=FLAG,0:��ȷ��&1:��ȷ��&2:������&3:�Ѵ���&9:ȡ������;SUPPLY_STATE=FLAG,0:������&1:������&2:�Ѳ���;AF_POSITION=CODE,WJWZ;AF_GLOBAL_STATE=CODE,WJQJZT_ZX" 
								exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,15;FILE_TYPE=�ļ�����,15;FAMILY_TYPE=��������,15;IS_CONVENTION_ADOPT=�Ƿ�Լ����,15;MALE_NAME=��������,15;MALE_BIRTHDAY=�г�������,15;MALE_NATION=�й���,15;MALE_EDUCATION=���Ļ��̶�,15;MALE_HEALTH=�н���״��,15;FEMALE_NAME=Ů������,15;FEMALE_BIRTHDAY=Ů��������,15;FEMALE_NATION=Ů����,15;FEMALE_EDUCATION=Ů�Ļ��̶�,15;FEMALE_HEALTH=Ů����״��,15;ADOPT_REQUEST_CN=����Ҫ��,15;UNDERAGE_NUM=δ������Ů����,15;REMARK_CN=��ͥ��Ҫ˵����������,15;GOVERN_DATE=������׼����,15;EXPIRE_DATE=��Ч����,15;APPROVE_CHILD_NUM=��׼��ͯ����,15;CHILDREN_SEX=��׼��ͯ�Ա�,15;CHILDREN_HEALTH_CN=��׼������ͯ����״��,15;TRANSLATION_COMPANY=���뵥λ,15;TRANSLATION_QUALITY=��������,15;UNQUALITIED_REASON=���ϸ�ԭ��,15;NAME=��ͯ����,15;SEX=��ͯ�Ա�,15;BIRTHDAY=��ͯ��������,15;PROVINCE_ID=ʡ��,15;WELFARE_NAME_CN=����Ժ,15;RECOVERY_STATE=��ͣ״̬,15;RETURN_STATE=����״̬,15;SUPPLY_STATE=�����ļ�״̬,15;AF_GLOBAL_STATE=�ļ�״̬,15;AF_POSITION=�ļ�λ��;"/></td>
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