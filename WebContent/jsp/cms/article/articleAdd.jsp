<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
	String secid=user.getPerson().getSecretLevel();
	if(secid == null || "".equals(secid) || "null".equals(secid)){
		secid = "0";
	}
	
	//�����Ȩ��
	String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
	//Ͷ����Ȩ��
	//String writerAuth = (String)request.getAttribute("WRITER_AUTH");
	//��ǰ��Ŀ����˵Ļ��д˱�־
	String isAuth = (String)request.getAttribute("IS_AUTH");
%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<up:uploadResource cancelJquerySupport="true"/>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/resource/style/base/form.css"/>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.all.js"> </script>
<!--�����ֶ��������ԣ�������ie����ʱ��Ϊ��������ʧ�ܵ��±༭������ʧ��-->
<!--������ص������ļ��Ḳ������������Ŀ����ӵ��������ͣ���������������Ŀ�����õ���Ӣ�ģ�������ص����ģ�������������-->
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/lang/zh-cn/zh-cn.js"></script>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/ueditor/themes/default/css/ueditor.css"/>
<script>
	var secid=<%=secid %>;
	//����
	function tijiao()
	{
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
	
		document.srcForm.action=path+"article/Article!add.action";
		document.srcForm.target = "_self";
 		document.srcForm.submit();
 		
 		//�رգ���ˢ���ϼ�ҳ��
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	//�ݴ�
	function zhancun()
	{
		//��֤���⡢�����Ƿ���д
		var title = document.getElementById("Article_TITLE").value.trim();
		if(title==""){
			alert("���ⲻ��Ϊ��,����д���⣡");
			return;
		}
	
		document.srcForm.action=path+"article/Article!addTemp.action";
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
		if(title==""){
			alert("���ⲻ��Ϊ��,����д���⣡");
			return;
		}
	
		document.srcForm.action=path+"article/Article!addDirect.action";
		document.srcForm.target = "_self";
	 	document.srcForm.submit();
 	
 		//�رգ���ˢ���ϼ�ҳ��
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	/* function _back(){
	var ID = document.getElementById("CHANNEL_ID").value;
 	document.srcForm.action=path+"article/Article!query.action?CHANNEL_ID="+ID;
 	document.srcForm.submit();
	} */
	
	//���fckedit���ݵĸ�ʽ
	function clearStyle(){
		var con_true = getEditorContents(true);
		alert(con_true);
		con_true = trimAll(con_true);
		con_true = replaceBrToDiv(con_true);
		var filterContent = delHtmlTag(con_true);
		filterContent = "<font face='����;����' style='text-indent:2em;line-height:100%'>" + filterContent + "</font>";
		SetContents(filterContent);
		/*
		document.srcForm.action=path+"article/Article!clearStyle.action";
 		document.srcForm.submit();
 		*/
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
	
	
	
	//ѡ����Ŀ
	/* function changeChannel(){
		var reValue = window.showModalDialog(path+"channel/Channel!generateTreeForPerson.action?treeDispatcher=changeChannelTree", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		document.getElementById("CHANNEL_ID").value = reValue["value"];
		document.getElementById("CHANNEL_NAME").value = reValue["name"];
	} */
	
	//Ԥ��
	function _chakan(){
		window.open("about:blank","_chakan");
		document.srcForm.action=path+"article/Article!detailArtScan.action";
		document.srcForm.target = "_chakan";
		document.srcForm.submit();
		document.srcForm.target = "_self";
  	}
  	
  	//�趨�༭���߶�
  	function _editAreaScroll(){
  		document.getElementById("_kuangjia").style.overflow = "scroll";
  	}
  	
  	function num_span_sh(id,in_){
  		var span_ = document.getElementById(id);
  		if(in_.checked == true){
  			span_.style.display = "inline";
  		}else{
  			span_.style.display = "none";
  		}
  	}
  	
  	function hiddenInput_(id,in_,name,value){
  		var span1 = document.getElementById(id);
  		var html_ = span1.innerHTML;
  		if(in_.checked == false){
  			span1.innerHTML = html_ + '<input type="hidden" name="'+name+'" value="'+value+'" />';
  		}
  	}
  	
  	//��ʼ���ö���һЩֵ
  	function _initFields(){
  		//�ö�
  		hiddenInput_('is_top_span',document.getElementById("Article_IS_TOP"),'Article_IS_TOP','0');
  		//�Ƿ�new
  		hiddenInput_('is_new_span',document.getElementById("Article_IS_NEW"),'Article_IS_NEW','0');
  		//�Ƿ������ִ
  		hiddenInput_('is_receipt_span',document.getElementById("Article_IS_RECEIPT"),'Article_IS_RECEIPT','0');
  		//�Ƿ񵯳�
  		/* hiddenInput_('is_skip_span',document.getElementById("Article_IS_SKIP"),'Article_IS_SKIP','0'); */
  		//�������
  		/* hiddenInput_('is_common_soft_span',document.getElementById("Article_IS_COMMON_SOFT"),'Article_IS_COMMON_SOFT','2'); */
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
  	
  	function addMonth(s,i){ 
        var d=new Date(s.replace(/-/,"/")); 
        d.setMonth(d.getMonth()+i); 
        var m=d.getMonth()+1; 
        return d.getFullYear()+'-'+m+'-'+d.getDate(); 
      } 
  	
  	function _selectMJ(obj){
  		var mj = obj.value;
  		if(mj == "2" || mj == "3"){
  			$("#mjstartDateTitle").removeClass("DIS");
  			var mjstartDate = document.getElementById("mjstartDate").value;
  			if(mj == "2"){
  				document.getElementById("qixian").value = "120";
  				var d = addMonth(mjstartDate,120);
  				document.getElementById("mjendDate").value = d;
  			}
  			if(mj == "3"){
  				document.getElementById("qixian").value = "240";
  				var d = addMonth(mjstartDate,240);
  				document.getElementById("mjendDate").value = d;
  			}
  		}else{
  			$("#mjstartDateTitle").addClass("DIS");
  			document.getElementById("qixian").value = "-1";
  		}
  	}
  	
  	function _addMJDate(){
  		var qixian = document.getElementById("qixian").value;
  		var mjstartDate = document.getElementById("mjstartDate").value;
  		if(qixian != "-1"){
  			var d = addMonth(mjstartDate,parseInt(qixian));
  			document.getElementById("mjendDate").value = d;
  		}
  	}
  	
  	function _selectTree(id0,id,title,code,showParent,params,type){
  		if(id == "Article_CHANNEL_ID"){
	  		var CHANNEL_ID = document.getElementById("Article_CHANNEL_ID").value;
	  		document.srcForm.action=path+"article/Article!toAdd.action?CHANNEL_ID="+CHANNEL_ID;
	  		document.srcForm.submit();
  		}
  	}
</script>

<style>
.title{
	text-align: left !important;
}
.DIS{
	display: none;
}

</style>
</BZ:head>
<BZ:body property="data" codeNames="SYS_SECURITY_LEVEL_ADD;SECURITY_XX;SKIP_CHANNEL_TPL;SYS_CHANNELS_OF_PERSON;SYS_ORGAN;SYS_ORGAN_PERSON" onload="_initFields();">
<BZ:form name="srcForm" method="post">
<table style="width: 850px;height: 100%;" cellpadding="0" cellspacing="0" border="0" align="center">
	<tr>
		<td height="100%">
			<div class="kuangjia" id="_kuangjia" style="margin: 0px;margin-top: 10px;height: 100%">
			<div class="heading">�������</div>
			<!-- ��ĿID -->
			<table class="contenttable">
			
			<tr height="30px">
			<td class="title">������Ŀ��</td>
			<td colspan="3">
				<BZ:input prefix="Article_" field="CHANNEL_ID" type="helper" helperCode="SYS_CHANNELS_OF_PERSON" helperTitle="ѡ����Ŀ" treeType="0" showParent="false" defaultValue="<%=(String)request.getAttribute(Article.CHANNEL_ID) %>" defaultShowValue="" showFieldId="CHANNEL_ID" property="data" style="width:165px;" />
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title"><font style="vertical-align: middle;" color="red">*</font>�ꡡ �⣺</td>
			<td colspan="3">
				<textarea name="Article_TITLE" style="width:600px;height:60px;text-align: center;"></textarea>
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
			<td><BZ:input field="SEQ_NUM" prefix="Article_" defaultValue=""/></td>
			<td class="title">�������ڣ�</td>
			<td><BZ:input field="CREATE_TIME" prefix="Article_" type="datetime" defaultValue="%nowdatetime%"/></td>
			</tr>
			
			<tr style="display: none">
			<td class="title">�ܡ�������</td>
			<td colspan="3"><BZ:select id="miji" field="SECURITY_LEVEL" prefix="Article_" formTitle="�ܼ�" isCode="true" codeName="SYS_SECURITY_LEVEL_ADD" onchange="_selectMJ(this)" className="rs-edit-select"></BZ:select></td>
			</tr>
			<tr id="mjstartDateTitle" class="DIS">
			<td class="title" ><span id="qixianTitle">�������ޣ�</span></td>
			<td><BZ:select id="qixian" field="PROTECT_PERIOD" prefix="Article_" formTitle="��������" isCode="true" codeName="SECURITY_XX" onchange="_addMJDate()" className="rs-edit-select"></BZ:select></td>
			<td nowrap class="title" >������ʼ���ڣ�</td>
			<td>
				<BZ:input field="PROTECT_START_DATE" type="date" prefix="Article_" id="mjstartDate" defaultValue="%nowDate%" onblur="_addMJDate();" />
				<BZ:input type="hidden" field="PROTECT_END_DATE" prefix="Article_" id="mjendDate" defaultValue=""/>
			</td>
			</tr>
			<tr height="30px">
			<td class="title">�ء����ԣ�</td>
			<td colspan="3" style="font-weight: bold;">
				<span id="is_top_span">
					<input type="checkbox" id="Article_IS_TOP" name="Article_IS_TOP" value="1" onclick="hiddenInput_('is_top_span',this,'Article_IS_TOP','0');">�ö�
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_new_span">
					<input type="checkbox" id="Article_IS_NEW" name="Article_IS_NEW" value="1" onclick="num_span_sh('time_span',this);hiddenInput_('is_new_span',this,'Article_IS_NEW','0');">��ʾnew���
				</span>
				<span id="time_span" style="display: none;">
					ʱ��<BZ:input field="NEW_TIME" prefix="Article_" defaultValue="" style="width:50px;"/>��
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_receipt_span">
					<input type="checkbox" id="Article_IS_RECEIPT" name="Article_IS_RECEIPT" value="1" onclick="hiddenInput_('is_receipt_span',this,'Article_IS_RECEIPT','0');">�����ִ
				</span>
				<%-- <span id="is_skip_span">
					<input type="checkbox" id="Article_IS_SKIP" name="Article_IS_SKIP" value="1" onclick="num_span_sh('template_span',this);hiddenInput_('is_skip_span',this,'Article_IS_SKIP','0');">����
				</span>
				<span id="template_span" style="display: none;">
					ģ��<BZ:select field="TEMPLATE_ID" formTitle="" prefix="Article_" isCode="true" codeName="SKIP_CHANNEL_TPL" width="70px"/>
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --%>
				
				<%-- <span id="is_common_soft_span">
					<input type="checkbox" id="Article_IS_COMMON_SOFT" name="Article_IS_COMMON_SOFT" value="1" onclick="num_span_sh('num_span',this);hiddenInput_('is_common_soft_span',this,'Article_IS_COMMON_SOFT','2');">�������
				</span>
				<span id="num_span" style="display: none;">
					����<BZ:input field="COMMON_SOFT_SEQ_NUM" prefix="Article_" defaultValue="" style="width:50px;"/>
				</span> --%>
			</td>
			</tr>
			<tr height="30px">
			<td class="title">Ȩ�����ޣ�</td>
			<td colspan="3" style="font-weight: bold;">
				<input type="checkbox" id="Article_DATA_ACCESS_PUBLIC" name="DATA_ACCESS" value="1" onclick="_dataAccess(this.id)" checked="checked">����
				
				<!-- <input type="checkbox" id="Article_DATA_ACCESS_PERSON" name="DATA_ACCESS" value="2" onclick="_dataAccess(this.id)">
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_PERSON')" style="text-decoration: none;">��Ա��Ȩ</a> -->
				
				<input type="checkbox" id="Article_DATA_ACCESS_ORGAN" name="DATA_ACCESS" value="3" onclick="_dataAccess(this.id)">
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_ORGAN')">��֯��Ȩ</a>
				
				<input type="hidden" id="PERSON_ARTICLE_RELA" name="PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_PERSON_ARTICLE_RELA" name="IDS_PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="ORGAN_ARTICLE_RELA" name="ORGAN_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_ORGAN_ARTICLE_RELA" name="IDS_ORGAN_ARTICLE_RELA"/>
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
					
				</script>
				<div class="con-split"></div>
			</td>
			</tr>
			
			<tr height="35px">
			<%-- <td class="title">�ϴ����ģ�</td>
			<td>
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_BODY_TEXT_ATT" 
					id="BODY_TEXT_ATT" 
					name="Article_BODY_TEXT_ATT" 
					packageId=""
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td> --%>
			<td class="title">����������</td>
			<td colspan="3">
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT" 
					id="PACKAGE_ID" 
					name="Article_PACKAGE_ID" 
					packageId=""
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			</tr>
			
			<%-- <tr height="35px">
			<td class="title" style="width: 120px;">����ͼ�꣺</td>
			<td  style="width:300px;">
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT_ICON" 
					id="ATT_ICON" 
					name="Article_ATT_ICON" 
					packageId=""
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
				<input type="button" value="�ݴ�" class="button_add" onclick="zhancun()"/>&nbsp;&nbsp;
				<%-- <%
					//�����ĿΪ��˲ſ��ܽ����ж��Ƿ�Ϊ�����
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
						if(!"AUTHER_AUTH".equals(autherAuth)){
				%>
				<input type="button" style="width: 80px" value="�ύ���" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
						}
					}
				%> --%>
				<%-- <%
					//�ж���Ŀ�Ƿ�Ϊ���
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
				%>
				<input type="button" style="width: 80px" value="�ύ���" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
					}
				%> --%>
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