<%
/**   
 * @Title: suppleFile_stepadd.jsp
 * @Description:  ����Ů�����ļ���Ϣ�޸�ҳ
 * @author yangrt   
 * @date 2014-7-22 17:41:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	String af_id = (String)request.getAttribute("AF_ID");
	String org_id = (String)request.getAttribute("ADOPT_ORG_ID");
	String org_af_id = "org_id=" + org_id + ";af_id=" + af_id;
	String strPar = "org_id=" + org_id + ",af_id=" + af_id;
%>
<BZ:html>
	<BZ:head language="EN">
		<title>����Ů�����ļ���Ϣ�޸�ҳ</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		
		$(document).ready(function() {
			//�����������Ա�������ʾ��������
			$("#R_ADOPTER_SEX").val();
			if(val == 1){
				//��ʾ����������Ϣ
				$(".male_info").show();
				//����Ů��������Ϣ
				$(".female_info").hide();
				//��ʾ�������˹���
				$("#R_MALE_NATION").show();
				//����Ů�����˹����������
				$("#R_FEMALE_NATION").hide();
				$("#R_FEMALE_NATION").val("");
				//��ʾ�������˻��պ���
				$("#R_MALE_PASSPORT_NO").show();
				//����Ů�����˻��պ��룬�����
				$("#R_FEMALE_PASSPORT_NO").hide();
				$("#R_FEMALE_PASSPORT_NO").val("");
				//��ʾ����������Ƭ�ϴ�
				$("#ATT_MALE_PHOTO").show();
				//����Ů��������Ƭ�ϴ�
				$("#ATT_FEMALE_PHOTO").hide();
				$("#R_FEMALE_PHOTO").attr("packageId","");
				
				//����������ʾ
				$("#R_AGE").text(_getAge($("#R_MALE_BIRTHDAY").val()));
			}else{
				//��������������Ϣ
				$(".male_info").hide();
				//��ʾŮ��������������򣬼ӷǿ���֤
				$(".female_info").show();
				//�����������˹����������
				$("#R_MALE_NATION").hide();
				$("#R_MALE_NATION").val("");
				//��ʾŮ�����˹���
				$("#R_FEMALE_NATION").show();
				//�����������˻��պ��룬�����
				$("#R_MALE_PASSPORT_NO").hide();
				$("#R_MALE_PASSPORT_NO").val("");
				//��ʾŮ�����˻��պ���
				$("#R_FEMALE_PASSPORT_NO").show();
				//��������������Ƭ�ϴ�
				$("#ATT_MALE_PHOTO").hide();
				$("#R_MALE_PHOTO").attr("packageId","");
				//��ʾŮ��������Ƭ�ϴ�
				$("#ATT_FEMALE_PHOTO").show();
				
				//����������ʾ
				$("#R_AGE").text(_getAge($("#R_FEMALE_BIRTHDAY").val()));
			}
			
		});
		
		//�����ļ���¼��Ϣ
		function _submit(){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else{
				//�������飬����ʼ������
				var att_arrays = new Array();
				var sex = $("#R_ADOPTER_SEX").val();
				if(sex == "1"){
					//����Ա�ѡ����
					att_arrays[0] = "R_MALE_PHOTO";
					att_arrays[1] = "����������Ƭ";
				}else{
					//����Ա�ѡ����
					att_arrays[0] = "R_FEMALE_PHOTO";
					att_arrays[1] = "Ů��������Ƭ";
				}
				//��֤�����Ƿ��ϴ�
				var att_name = [];	//����δ�ϴ��ĸ�����������
				var name_length = 0;	//δ�ϴ�������������
				for(var i = 0; i < att_arrays.length; i+=2){
					var table = document.getElementById("infoTable" + att_arrays[i]);
					var trslen = table.rows.length;
					if(trslen == 0){
						//��δ�ϴ��ĸ����������Ʒ�������att_name�У�����¼δ�ϴ��ĸ���������
						att_name[name_length++] = att_arrays[i+1];
					}
				}
				if(name_length > 0){
					//page.alert("���ϴ�" + att_name.join("��") + "!");
					alert("���ϴ�" + att_name.join("��") + "!");
					return;
				}else if(confirm("Are you sure you want to submit?")){
					//���ύ
					
					document.srcForm.action = path+'ffs/filemanager/BasicInfoSave.action';
					document.srcForm.submit();
					window.close();
				}
			}
			
		}
		//���صݽ���ͨ�ļ��б�ҳ��
		function _close(){
			window.close();
		}
		
		//���ݳ������ڻ�ȡ��������
		function _getAge(strBirthday)
		{       
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//ͬ�� ��Ϊ0��
		    }else{
		        var ageDiff = nowYear - birthYear ; //��֮��
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//��֮��
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//��֮��
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//����-1 ��ʾ��������������� ���ڽ���
		        }
		    }
		    
		    return returnAge;//������������
		    
		}
		
	</script>
	<BZ:body property="data" codeNames="GJ;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue="1"/>
		<!-- ��������end -->
		<!-- �༭����begin -->
			<div class="bz-edit clearfix" desc="�༭����">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<!-- �������� begin -->
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>�����˻�����Ϣ(Information about the adoptive parents)</div>
					</div>
					<!-- �������� end -->
					<!-- �������� begin -->
					<div class="bz-edit-data-content clearfix" desc="������">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��������<br>Name</td>
								<td class="bz-edit-data-value" width="25%">
									<span class="male_info"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span>
									<span class="female_info"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span>
								</td>
								<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�Ա�<br>Sex</td>
								<td class="bz-edit-data-value" width="25%">
									<BZ:dataValue field="ADOPTER_SEX" checkValue="1=Male;2=Female;" defaultValue="" onlyValue="true"/>
								</td>
								<td class="bz-edit-data-value" width="20%" rowspan="4">
									<span class="male_info">
										<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" packageId="<%=af_id%>" name="R_MALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_MALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
									<span class="female_info">
										<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" packageId="<%=af_id%>" name="R_FEMALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
									</span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title"><font color="red">*</font>��������<br>D.O.B</td>
								<td class="bz-edit-data-value">
									<span class="male_info"><BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></span>
									<span class="female_info"><BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></span>
								</td>
								<td class="bz-edit-data-title">����<br>Age</td>
								<td class="bz-edit-data-value">
									<span id="R_AGE"></span>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">����<br>Nationality</td>
								<td class="bz-edit-data-value">
									<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
									<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
									<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100" style="display:none"/>
								</td>
							</tr>
							<tr>
								<td class="bz-edit-data-title">����״��<br>Marital status</td>
								<td class="bz-edit-data-value">Married</td>
								<td class="bz-edit-data-title"><font color="red">*</font>�������<br>Date of the present marriage</td>
								<td class="bz-edit-data-value">
									<BZ:input prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="Please select the wedding date��" onchange="_setMarryLength()"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="bz-edit clearfix" desc="�༭����">
				<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<!-- �������� begin -->
					<div class="ui-state-default bz-edit-title" desc="����">
						<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
						<div>������Ϣ(Attachment)</div>
					</div>
					<!-- �������� begin -->
					<div class="bz-edit-data-content clearfix" desc="������">
						<table class="bz-edit-data-table" border="0">
							<tr>
								<td class="bz-edit-data-value">
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_PARENTS%>&packageID=<%=af_id %>" frameborder=0 width="100%" ></IFRAME>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- �༭����end -->
			<!-- ��ť����begin -->
			<div class="bz-action-frame">
				<div class="bz-action-edit" desc="��ť��">
					<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_submit()"/>
					<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_close();"/>
				</div>
			</div>
			<!-- ��ť����end -->
		</BZ:form>
		<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
		<!--����ʹ�ã�start-->
			<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
			<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value="<%=af_id %>"/>
			<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=xmlstr%>'/>
			<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
			<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
			<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
			<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
			<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='<%=strPar%>'/>		
		<!--����ʹ�ã�end-->
		</form>
	</BZ:body>
</BZ:html>