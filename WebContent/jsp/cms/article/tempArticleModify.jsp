<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.cms.article.vo.AuditOpinion"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
	//�������б�
	DataList dataList = (DataList)request.getAttribute("dataList");
	
	//�����Ȩ��
	String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
	//��ǰ��Ŀ����˵Ļ��д˱�־
	String isAuth = (String)request.getAttribute("IS_AUTH");
	//��ȡ����ID
	String id=(String)request.getParameter("ID");
%>
<BZ:html>
<BZ:head>
<title>�޸�ҳ��</title>
<up:uploadResource/>
<BZ:script isEdit="true" isDate="true"/>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.all.js"> </script>
<!--�����ֶ��������ԣ�������ie����ʱ��Ϊ��������ʧ�ܵ��±༭������ʧ��-->
<!--������ص������ļ��Ḳ������������Ŀ����ӵ��������ͣ���������������Ŀ�����õ���Ӣ�ģ�������ص����ģ�������������-->
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/lang/zh-cn/zh-cn.js"></script>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/ueditor/themes/default/css/ueditor.css"/>
<script>
	//����
	function tijiao()
	{
		//��֤���⡢�����Ƿ���д
		var title = document.getElementById("Article_TITLE").value.trim();
		/* var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true); */
		if(title==""){
			alert("���ⲻ��Ϊ��,����д���⣡");
			return;
		}
	
 		document.srcForm.action=path+"article/Article!modify.action";
 		document.srcForm.target = "_self";
 		document.srcForm.submit();
 		
 		//�رգ���ˢ���ϼ�ҳ��
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	//�ύ���
    function tijiaoshenhe(){
    	//��֤���⡢�����Ƿ���д
		var title = document.getElementById("Article_TITLE").value.trim();
		if(title==""){
			alert("���ⲻ��Ϊ��,����д���⣡");
			return;
		}
		//�ύ���ʱ����֤������Ƿ��Ѿ�ѡ��
		var shr = document.getElementById("AUDITPERSON_ARTICLE_RELA").value.trim();
		if(shr==""){
			alert("��ѡ������ˣ�");
			return;
		}
	    document.srcForm.action=path+"article/Article!submitAuditSingle.action";
	    document.srcForm.target = "_self";
	    document.srcForm.submit();
	    
	    //�رգ���ˢ���ϼ�ҳ��
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
    }
	
	//ֱ�ӷ���
	function fabu()
	{
		//��֤���⡢�����Ƿ���д
		var title = document.getElementById("Article_TITLE").value.trim();
		/* var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true); */
		if(title==""){
			alert("���ⲻ��Ϊ��,����д���⣡");
			return;
		}
	
		document.srcForm.action=path+"article/Article!tempModifyDirect.action";
		document.srcForm.target = "_self";
	 	document.srcForm.submit();
 	
 		//�رգ���ˢ���ϼ�ҳ��
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	function _back(){
	var ID = document.getElementById("CHANNEL_ID").value;
 	document.srcForm.action=path+"article/Article!queryChildren.action?CHANNEL_ID="+ID;
 	document.srcForm.submit();
	}
	
	//����ʱ���أ���ʼ��fckeditor��Ȼ����ʾҪ�޸ĵ�����
	<%-- window.onload = function(){
		//�趨�༭����߶�
		_editAreaScroll();
	
		var oFCKeditor = new FCKeditor('Article_CONTENT');
		oFCKeditor.BasePath = "<%=path %>/fckeditor/";
		oFCKeditor.Height = "600";
		oFCKeditor.ReplaceTextarea() ;
	}
	 --%>
	//���fckedit���ݵĸ�ʽ
	function clearStyle(){
		var con_true = getEditorContents(true);
		con_true = trimAll(con_true);
		con_true = replaceBrToDiv(con_true);
		var filterContent = delHtmlTag(con_true);
		filterContent = "<font face='����;����' style='text-indent:2em;line-height:100%'>" + filterContent + "</font>";
		SetContents(filterContent);
	}
	
	//ɾ������HTML��ǩ����P��br��ǩ��div��ǩ
	function delHtmlTag(str){
        //return str.replace(/<[^>]+>/g,"");//ȥ�����е�html���
		return str.replace(/<(?!\/?p|br|div\b)[^>]+>/ig,"");
	}
	
	//ȥ������
	function clearBr(key){
	    //key = key.replace(/<\/?.+?>/g,"<p>");
	    key = key.replace(/[\r\n]/g, "");
	    return key;
	}
	
	//�滻���br��һ��br
	function replaceBrToDiv(str){
		return str.replace(/(<br *> *)+/g, "<br>").replace(/(<br *\/> *)+/g, "<br>");
	}
	
	//ȥ������&nbsp;�Ϳհ�
	function trimAll(str){
		return str.replace(/&nbsp;/g, "").replace(/ /g, "");
	}
	
	/*---------FCK�����ֿ�ʼ-----------*/
	//��ȡ�༭��������
	function getEditorContents(bol){
   		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
   		return oEditor.GetXHTML(bol);
	}
	//��༭������ָ������
	function insertHTMLToEditor(codeStr){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		oEditor.InsertHtml(codeStr);
	}
	//ͳ�Ʊ༭�������ݵ�����
	function getLength(){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var oDOM = oEditor.EditorDocument;
		var iLength ;
		if(document.all){
			iLength = oDOM.body.innerText.length;
		}else{
			var r = oDOM.createRange();
			r.selectNodeContents(oDOM.body);
			iLength = r.toString().length;
		}
		alert(iLength);
	}
	//ִ��ָ������
	function ExecuteCommand(commandName){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT") ;
		oEditor.Commands.GetCommand(commandName).Execute() ;
	}
	//���ñ༭��������
	function SetContents(codeStr){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT") ;
		oEditor.SetHTML(codeStr) ;
	}
	/*---------FCK�����ֽ���-----------*/
	//ѡ����Ŀ
	/* function changeChannel(){
		var reValue = window.showModalDialog(path+"channel/Channel!generateTreeForPerson.action?treeDispatcher=changeChannelTree", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		document.getElementById("CHANNEL_ID").value = reValue["value"];
		document.getElementById("CHANNEL_NAME").value = reValue["name"];
	} */
	
	//Ԥ��
	function _chakan(){
		window.open("about:blank","_chakan");
		//document.srcForm.action=path+"article/Article!detailArt.action?<%=Article.ID %>=<%=id %>,PERSIST";
		document.srcForm.action=path+"article/Article!detailArtScan.action";
		document.srcForm.target = "_chakan";
		document.srcForm.submit();
		document.srcForm.target = "_self";
  	}
  	
  	//���ñ༭������
  	function _editAreaScroll(){
  		/*
  		var height_ = document.body.clientHeight;
  		var n_height = (height_ * 90) / 100;
  		document.getElementById("_kuangjia").style.height = n_height;
  		*/
  		document.getElementById("_kuangjia").style.overflow = "scroll";
  	}
  	
  	function num_span_sh(id,in_){
  		var span_ = document.getElementById(id);
  		if(in_.checked == true){
  			span_.style.display = "inline";
  		}else{
  			span_.style.display = "none";
  			var inputs = span_.getElementsByTagName("input");
  			if(inputs.length > 0){
  				for(var i = 0; i < inputs.length; i++){
  					inputs[i].value = "";
  				}
  			}
  		}
  	}
  	
  	function hiddenInput_(id,in_,name,value){
  		var span1 = document.getElementById(id);
  		var html_ = span1.innerHTML;
  		if(in_.checked == false){
  			span1.innerHTML = html_ + '<input type="hidden" name="'+name+'" value="'+value+'" />';
  		}
  	}
  	
  	//������Ȩ
  	function  _dataAccess(id){
  		var node = document.getElementById(id);
  		var value = node.value;
  		if(value == "1" && node.checked){
  			/* document.getElementById("Article_DATA_ACCESS_PERSON").checked=false; */
  			document.getElementById("Article_DATA_ACCESS_ORGAN").checked=false;
  			document.getElementById("PERSON_ARTICLE_RELA").value = "";
  			document.getElementById("IDS_PERSON_ARTICLE_RELA").value = "";
  			document.getElementById("ORGAN_ARTICLE_RELA").value = "";
  			document.getElementById("IDS_ORGAN_ARTICLE_RELA").value = "";
  		}
  		if((value == "2" && node.checked) || (value == "3" && node.checked)){
  			document.getElementById("Article_DATA_ACCESS_PUBLIC").checked=false;
  		}
  		
  		if((value == "2" && node.checked)){
  			//������Ա��
  			_showHelper('PERSON_ARTICLE_RELA','IDS_PERSON_ARTICLE_RELA','ѡ����Ա','SYS_ORGAN_PERSON','','','3','true');
  			
  			/* var selectedids = document.getElementById("IDS_PERSON_ARTICLE_RELA").value;
			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
			document.getElementById("IDS_PERSON_ARTICLE_RELA").value = ids; */
  		}
  		
  		if((value == "3" && node.checked)){
  			//��֯��
  			_showHelper('ORGAN_ARTICLE_RELA','IDS_ORGAN_ARTICLE_RELA','ѡ����֯','SYS_ORGAN','','','3','true');
  			
  			/* var selectedids = document.getElementById("IDS_ORGAN_ARTICLE_RELA").value;
  			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
  			document.getElementById("IDS_ORGAN_ARTICLE_RELA").value = ids; */
  		}
  	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="SECURITY_LEVEL;SECURITY_XX;SKIP_CHANNEL_TPL;SYS_CHANNELS;SYS_ORGAN;SYS_ORGAN_PERSON">
<BZ:form name="srcForm" method="post">

<table style="width: 870px;height: 100%" cellpadding="0" cellspacing="0" border="0" align="center">
	<tr>
		<td height="100%">
			<div id="_kuangjia" class="kuangjia" style="margin: 0px;margin-top: 10px;height: 100%">
			<div class="heading">�޸�����</div>
			<!-- ��ǰ�޸ĵ���֯����ID -->
			<BZ:input field="ID" type="hidden" prefix="Article_" defaultValue=""/>
			<!-- ��ĿID -->
			<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
			<table class="contenttable">
			
			<tr height="30px">
			<td class="title">������Ŀ��</td>
			<td colspan="3">
				<BZ:input id="CHANNEL_ID" field="CHANNEL_ID" prefix="Article_" type="hidden" defaultValue=""/>
				<BZ:dataValue field="CHANNEL_ID" defaultValue="" codeName="SYS_CHANNELS"/>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title"><font style="vertical-align: middle;" color="red">*</font>�ꡡ �⣺</td>
			<td colspan="3">
				<textarea name="Article_TITLE" style="width:600px;height:60px;text-align: center;"><%=data.getString(Article.TITLE,"") %></textarea>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">��&nbsp;&nbsp;��&nbsp;&nbsp;�֣�</td>
			<td colspan="3"><BZ:input field="SHORT_TITLE" prefix="Article_" type="String" style="width:66%" defaultValue=""/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">������Դ��</td>
			<td colspan="3"><BZ:input field="SOURCE" prefix="Article_" style="width:66%" defaultValue=""/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">��&nbsp;&nbsp;��&nbsp;&nbsp;�ţ�</td>
			<td colspan="3"><BZ:input field="SEQ_NUM" prefix="Article_" defaultValue=""/></td>
			</tr>
			
			<tr>
			<td class="title" >�ܡ�������</td>
			<td><BZ:dataValue field="SECURITY_LEVEL" onlyValue="true" codeName="SECURITY_LEVEL" defaultValue="��"/></td>
			<td class="title" >�������ޣ�</td>
			<td><BZ:dataValue field="PROTECT_PERIOD" onlyValue="true" codeName="SECURITY_XX" defaultValue="��"/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">�ء����ԣ�</td>
			<td colspan="3" style="font-weight: bold;">
				<span id="is_top_span">
					<input type="checkbox" name="Article_IS_TOP" value="1" <%="1".equals(data.getString("IS_TOP"))?"checked='checked'":"" %> onclick="hiddenInput_('is_top_span',this,'Article_IS_TOP','0');">�ö�
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_new_span">
					<input type="checkbox" name="Article_IS_NEW" value="1" onclick="num_span_sh('time_span',this);hiddenInput_('is_new_span',this,'Article_IS_NEW','0');" <%="1".equals(data.getString("IS_NEW"))?"checked='checked'":"" %>>��ʾnew���
				</span>
				<span id="time_span" style='<%="1".equals(data.getString("IS_NEW"))?"display: inline;":"display: none;" %>'>
					ʱ��<BZ:input field="NEW_TIME" prefix="Article_" defaultValue="" style="width:50px;"/>��
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_receipt_span">
					<input type="checkbox" name="Article_IS_RECEIPT" value="1" <%="1".equals(data.getString("IS_RECEIPT"))?"checked='checked'":"" %> onclick="hiddenInput_('is_receipt_span',this,'Article_IS_RECEIPT','0');">�����ִ
				</span>
				
				<%-- <span id="is_skip_span">
					<input type="checkbox" name="Article_IS_SKIP" value="1" <%="1".equals(data.getString("IS_SKIP"))?"checked='checked'":"" %> onclick="num_span_sh('template_span',this);hiddenInput_('is_skip_span',this,'Article_IS_SKIP','0');">����
				</span>
				<span id="template_span" style='<%="1".equals(data.getString("IS_SKIP"))?"display: inline;":"display: none;" %>'>
					ģ��<BZ:select field="TEMPLATE_ID" formTitle="" prefix="Article_" isCode="true" codeName="SKIP_CHANNEL_TPL" width="70px"/>
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_common_soft_span">
					<input type="checkbox" name="Article_IS_COMMON_SOFT" value="1" onclick="num_span_sh('num_span',this);hiddenInput_('is_common_soft_span',this,'Article_IS_COMMON_SOFT','2');" <%="1".equals(data.getString("IS_COMMON_SOFT"))?"checked='checked'":"" %>>�������
				</span>
				<span id="num_span" style='<%="1".equals(data.getString("IS_COMMON_SOFT"))?"display: inline;":"display: none;" %>'>
					����<BZ:input field="COMMON_SOFT_SEQ_NUM" prefix="Article_" defaultValue="" style="width:50px;"/>
				</span> --%>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">Ȩ�����ޣ�</td>
			<td colspan="3" style="font-weight: bold;">
				<input type="checkbox" id="Article_DATA_ACCESS_PUBLIC" name="DATA_ACCESS" value="1" onclick="_dataAccess(this.id)" <%="1".equals(data.getString(Article.DATA_ACCESS))?"checked='checked'":"" %>>����
				<%-- <input type="checkbox" id="Article_DATA_ACCESS_PERSON" name="DATA_ACCESS" value="2" onclick="_dataAccess(this.id)" <%=data.getString(Article.DATA_ACCESS)!=null&&data.getString(Article.DATA_ACCESS).contains("2")?"checked='checked'":"" %>>
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_PERSON')" style="text-decoration: none;">��Ա��Ȩ</a> --%>
				<input type="checkbox" id="Article_DATA_ACCESS_ORGAN" name="DATA_ACCESS" value="3" onclick="_dataAccess(this.id)" <%=data.getString(Article.DATA_ACCESS)!=null&&data.getString(Article.DATA_ACCESS).contains("3")?"checked='checked'":"" %>>
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_ORGAN')">��֯��Ȩ</a>
				
				<input type="hidden" id="PERSON_ARTICLE_RELA" name="PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_PERSON_ARTICLE_RELA" name="IDS_PERSON_ARTICLE_RELA" value='<%=data.getString("IDS_PERSON_ARTICLE_RELA","") %>'/>
				<input type="hidden" id="ORGAN_ARTICLE_RELA" name="ORGAN_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_ORGAN_ARTICLE_RELA" name="IDS_ORGAN_ARTICLE_RELA" value='<%=data.getString("IDS_ORGAN_ARTICLE_RELA","") %>'/>
			</td>
			</tr>
			<%
				//�ж���Ŀ�Ƿ�Ϊ���
				if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
			%>
			<tr>
				<td class="title">��&nbsp;&nbsp;��&nbsp;&nbsp;�ˣ�</td>
				<td colspan="3">
					<BZ:input prefix="IDS_" field="AUDITPERSON_ARTICLE_RELA" type="helper" helperCode="SYS_ORGAN_PERSON" helperTitle="ѡ����Ա" treeType="3" helperSync="true" showParent="false" defaultShowValue="" showFieldId="AUDITPERSON_ARTICLE_RELA" property="data" style="width:600px;" />
				</td>
			</tr>
			<%
				}
			%>
			<tr height="30px">
			<td colspan="4">
				<script id="editor" type="text/plain" name="myContent" style="width:800px;height:600px;">
					<%=data.getString("CONTENT","") %>
				</script>
				<div class="con-split"></div>
			</td>
			</tr>
			
			<tr height="35px">
			<td class="title">����������</td>
			<td colspan="3">
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT" 
					id="PACKAGE_ID" 
					name="Article_PACKAGE_ID" 
					packageId="<%=data.getString(Article.PACKAGE_ID) %>"
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			</tr>
			
			<%-- <tr height="35px">
			<td class="title" style="width: 120px;">����ͼ�꣺</td>
			<td style="width: 300px;">
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT_ICON" 
					id="ATT_ICON" 
					name="Article_ATT_ICON" 
					packageId="<%=data.getString(Article.ATT_ICON) %>"
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			<td class="title" style="white-space: nowrap;">����˵����</td>
			<td>
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT_DESC" 
					id="ATT_DESC" 
					name="Article_ATT_DESC" 
					packageId="<%=data.getString(Article.ATT_DESC) %>"
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			</tr> --%>
			
			</table>
			</div>
		</td>
	</tr>
	
	<tr>
		<td height="30px;">
			<!-- β�� -->
			<div class="kuangjia" style="margin: 0px;margin-top: 5px;">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
			<td align="center" style="padding-right:30px" colspan="2">
				<input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
					//�����ĿΪ��˲ſ��ܽ����ж��Ƿ�Ϊ�����
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
				%>
				<input type="button" style="width: 80px" value="�ύ���" class="button_add" onclick="tijiaoshenhe();"/>&nbsp;&nbsp;
				<%
					}
				%>
				<input type="button" style="width: 80px" value="ֱ�ӷ���" class="button_add" onclick="fabu()"/>&nbsp;&nbsp;
				<input type="button" value="Ԥ��" class="button_select" onclick="_chakan()"/>&nbsp;&nbsp;
				<input type="reset" value="����" class="button_reset" />&nbsp;&nbsp;
				<!-- <input type="button" value="����" class="button_back" onclick="_back()"/> -->
				<input type="button" value="�ر�" class="button_delete" onclick="window.close();"/>
			</td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<%
				if(dataList != null && dataList.size() > 0){
			%>
			<div style="width: 805px;" class="kuangjia">
			<div class="heading" style="width: 805px;">��ʷ������</div>
			<table class="contenttable" style="width: 805px;" cellspacing="0" cellpadding="0">
			<%
					for(int i = 0; i < dataList.size(); i++){
						Data audit = dataList.getData(i);
			%>
				<tr>
					<td style="border-top-width: 2px;border-top-color: #AED0F6;border-top-style: solid;border-bottom-width: 2px;border-bottom-color: #AED0F6;border-bottom-style: solid;border-left-width: 1px;border-left-color: #5FA1ED;border-left-style: solid;border-right-width: 1px;border-right-color: #5FA1ED;border-right-style: solid;">
						<table>
							<tr>
								<td style="font-size: 18px">
								<%=audit.getString(AuditOpinion.AUDIT_OPINION,"") %></td>
								<td></td>
							</tr>
							<tr>
								<td width="10%"></td>
								<td width="93%"style="color: #898989">&nbsp;&nbsp;&nbsp;&nbsp;<%=audit.getString(AuditOpinion.USER_NAME,"") %>&nbsp;&nbsp;����ڣ�&nbsp;&nbsp;<%=audit.getString(AuditOpinion.AUDIT_TIME,"") %></td>
							</tr>
							
						</table>
					</td>
				</tr>
			<%
					}
			%>
			</table>
			</div>
			<%
				}
			%>
		</td>
	</tr>
</table>

</BZ:form>

<script type="text/javascript">
    //ʵ�����༭��
    //����ʹ�ù�������getEditor���������ñ༭��ʵ���������ĳ���հ������øñ༭����ֱ�ӵ���UE.getEditor('editor')�����õ���ص�ʵ��
    var ue = UE.getEditor('editor');

    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e);
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e);
    }
    function insertHtml() {
        var value = prompt('����html����', '');
        UE.getEditor('editor').execCommand('insertHtml', value);
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml());
    }
    function getContent() {
        var arr = [];
        arr.push("ʹ��editor.getContent()�������Ի�ñ༭��������");
        arr.push("����Ϊ��");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("ʹ��editor.getPlainTxt()�������Ի�ñ༭���Ĵ���ʽ�Ĵ��ı�����");
        arr.push("����Ϊ��");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'));
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("ʹ��editor.setContent('��ӭʹ��ueditor')�����������ñ༭��������");
        UE.getEditor('editor').setContent('��ӭʹ��ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //��������ťʱ�༭�����Ѿ�ʧȥ�˽��㣬���ֱ����getText������õ����ݣ�����Ҫ��ѡ������Ȼ��ȡ������
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt);
    }

    function getContentTxt() {
        var arr = [];
        arr.push("ʹ��editor.getContentTxt()�������Ի�ñ༭���Ĵ��ı�����");
        arr.push("�༭���Ĵ��ı�����Ϊ��");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("ʹ��editor.hasContents()�����жϱ༭�����Ƿ�������");
        arr.push("�жϽ��Ϊ��");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("����ղݸ���");
    }
</script>
</BZ:body>
</BZ:html>