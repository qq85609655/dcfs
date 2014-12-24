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
	
	//审核人权限
	String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
	//投稿人权限
	//String writerAuth = (String)request.getAttribute("WRITER_AUTH");
	//当前栏目不审核的话有此标志
	String isAuth = (String)request.getAttribute("IS_AUTH");
%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<up:uploadResource cancelJquerySupport="true"/>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/resource/style/base/form.css"/>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.all.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/lang/zh-cn/zh-cn.js"></script>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/ueditor/themes/default/css/ueditor.css"/>
<script>
	var secid=<%=secid %>;
	//发布
	function tijiao()
	{
		//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
		//提交审核时，验证审核人是否已经选择
		var shr = document.getElementById("AUDITPERSON_ARTICLE_RELA").value.trim();
		if(shr==""){
			alert("请选择审核人！");
			return;
		}
	
		document.srcForm.action=path+"article/Article!add.action";
		document.srcForm.target = "_self";
 		document.srcForm.submit();
 		
 		//关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	//暂存
	function zhancun()
	{
		//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
	
		document.srcForm.action=path+"article/Article!addTemp.action";
		document.srcForm.target = "_self";
 		document.srcForm.submit();
 	
 		//关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	//直接发布
	function fabu()
	{
		//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
	
		document.srcForm.action=path+"article/Article!addDirect.action";
		document.srcForm.target = "_self";
	 	document.srcForm.submit();
 	
 		//关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	/* function _back(){
	var ID = document.getElementById("CHANNEL_ID").value;
 	document.srcForm.action=path+"article/Article!query.action?CHANNEL_ID="+ID;
 	document.srcForm.submit();
	} */
	
	//清楚fckedit内容的格式
	function clearStyle(){
		var con_true = getEditorContents(true);
		alert(con_true);
		con_true = trimAll(con_true);
		con_true = replaceBrToDiv(con_true);
		var filterContent = delHtmlTag(con_true);
		filterContent = "<font face='宋体;楷体' style='text-indent:2em;line-height:100%'>" + filterContent + "</font>";
		SetContents(filterContent);
		/*
		document.srcForm.action=path+"article/Article!clearStyle.action";
 		document.srcForm.submit();
 		*/
	}
	
	//删除所有HTML标签除了P和br标签和div标签
	function delHtmlTag(str){
        //return str.replace(/<[^>]+>/g,"");//去掉所有的html标记
		return str.replace(/<(?!\/?p|br|div\b)[^>]+>/ig,"");
	}
	
	//去除换行
	function clearBr(key){
	    //key = key.replace(/<\/?.+?>/g,"<p>");
	    key = key.replace(/[\r\n]/g, "");
	    return key;
	}
	
	//替换多个br成一个br
	function replaceBrToDiv(str){
		return str.replace(/(<br *> *)+/g, "<br>").replace(/(<br *\/> *)+/g, "<br>");
	}
	
	//去掉所有&nbsp;和空白
	function trimAll(str){
		return str.replace(/&nbsp;/g, "").replace(/ /g, "");
	}
	
	
	
	//选择栏目
	/* function changeChannel(){
		var reValue = window.showModalDialog(path+"channel/Channel!generateTreeForPerson.action?treeDispatcher=changeChannelTree", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		document.getElementById("CHANNEL_ID").value = reValue["value"];
		document.getElementById("CHANNEL_NAME").value = reValue["name"];
	} */
	
	//预览
	function _chakan(){
		window.open("about:blank","_chakan");
		document.srcForm.action=path+"article/Article!detailArtScan.action";
		document.srcForm.target = "_chakan";
		document.srcForm.submit();
		document.srcForm.target = "_self";
  	}
  	
  	//设定编辑区高度
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
  	
  	//初始化置顶等一些值
  	function _initFields(){
  		//置顶
  		hiddenInput_('is_top_span',document.getElementById("Article_IS_TOP"),'Article_IS_TOP','0');
  		//是否new
  		hiddenInput_('is_new_span',document.getElementById("Article_IS_NEW"),'Article_IS_NEW','0');
  		//是否允许回执
  		hiddenInput_('is_receipt_span',document.getElementById("Article_IS_RECEIPT"),'Article_IS_RECEIPT','0');
  		//是否弹出
  		/* hiddenInput_('is_skip_span',document.getElementById("Article_IS_SKIP"),'Article_IS_SKIP','0'); */
  		//常用软件
  		/* hiddenInput_('is_common_soft_span',document.getElementById("Article_IS_COMMON_SOFT"),'Article_IS_COMMON_SOFT','2'); */
  	}
  	
  	//数据授权
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
  			//弹出人员树
  			_showHelper('PERSON_ARTICLE_RELA','IDS_PERSON_ARTICLE_RELA','选择人员','SYS_ORGAN_PERSON','','','3','true');
  			
  			/* var selectedids = document.getElementById("IDS_PERSON_ARTICLE_RELA").value;
			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
			document.getElementById("IDS_PERSON_ARTICLE_RELA").value = ids; */
  		}
  		
  		if((value == "3" && node.checked)){
  			//组织树
  			_showHelper('ORGAN_ARTICLE_RELA','IDS_ORGAN_ARTICLE_RELA','选择组织','SYS_ORGAN','','','3','true');
  			
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
			<div class="heading">添加内容</div>
			<!-- 栏目ID -->
			<table class="contenttable">
			
			<tr height="30px">
			<td class="title">所属栏目：</td>
			<td colspan="3">
				<BZ:input prefix="Article_" field="CHANNEL_ID" type="helper" helperCode="SYS_CHANNELS_OF_PERSON" helperTitle="选择栏目" treeType="0" showParent="false" defaultValue="<%=(String)request.getAttribute(Article.CHANNEL_ID) %>" defaultShowValue="" showFieldId="CHANNEL_ID" property="data" style="width:165px;" />
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title"><font style="vertical-align: middle;" color="red">*</font>标　 题：</td>
			<td colspan="3">
				<textarea name="Article_TITLE" style="width:600px;height:60px;text-align: center;"></textarea>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">关&nbsp;&nbsp;键&nbsp;&nbsp;字：</td>
			<td colspan="3"><BZ:input field="SHORT_TITLE" prefix="Article_" type="String" style="width:66%" defaultValue=""/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">来　　源：</td>
			<td colspan="3"><BZ:input field="SOURCE" prefix="Article_" style="width:66%" defaultValue=""/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">排&nbsp;&nbsp;序&nbsp;&nbsp;号：</td>
			<td><BZ:input field="SEQ_NUM" prefix="Article_" defaultValue=""/></td>
			<td class="title">发布日期：</td>
			<td><BZ:input field="CREATE_TIME" prefix="Article_" type="datetime" defaultValue="%nowdatetime%"/></td>
			</tr>
			
			<tr style="display: none">
			<td class="title">密　　级：</td>
			<td colspan="3"><BZ:select id="miji" field="SECURITY_LEVEL" prefix="Article_" formTitle="密级" isCode="true" codeName="SYS_SECURITY_LEVEL_ADD" onchange="_selectMJ(this)" className="rs-edit-select"></BZ:select></td>
			</tr>
			<tr id="mjstartDateTitle" class="DIS">
			<td class="title" ><span id="qixianTitle">保密期限：</span></td>
			<td><BZ:select id="qixian" field="PROTECT_PERIOD" prefix="Article_" formTitle="保密期限" isCode="true" codeName="SECURITY_XX" onchange="_addMJDate()" className="rs-edit-select"></BZ:select></td>
			<td nowrap class="title" >保密起始日期：</td>
			<td>
				<BZ:input field="PROTECT_START_DATE" type="date" prefix="Article_" id="mjstartDate" defaultValue="%nowDate%" onblur="_addMJDate();" />
				<BZ:input type="hidden" field="PROTECT_END_DATE" prefix="Article_" id="mjendDate" defaultValue=""/>
			</td>
			</tr>
			<tr height="30px">
			<td class="title">特　　性：</td>
			<td colspan="3" style="font-weight: bold;">
				<span id="is_top_span">
					<input type="checkbox" id="Article_IS_TOP" name="Article_IS_TOP" value="1" onclick="hiddenInput_('is_top_span',this,'Article_IS_TOP','0');">置顶
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_new_span">
					<input type="checkbox" id="Article_IS_NEW" name="Article_IS_NEW" value="1" onclick="num_span_sh('time_span',this);hiddenInput_('is_new_span',this,'Article_IS_NEW','0');">显示new标记
				</span>
				<span id="time_span" style="display: none;">
					时间<BZ:input field="NEW_TIME" prefix="Article_" defaultValue="" style="width:50px;"/>天
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_receipt_span">
					<input type="checkbox" id="Article_IS_RECEIPT" name="Article_IS_RECEIPT" value="1" onclick="hiddenInput_('is_receipt_span',this,'Article_IS_RECEIPT','0');">允许回执
				</span>
				<%-- <span id="is_skip_span">
					<input type="checkbox" id="Article_IS_SKIP" name="Article_IS_SKIP" value="1" onclick="num_span_sh('template_span',this);hiddenInput_('is_skip_span',this,'Article_IS_SKIP','0');">弹出
				</span>
				<span id="template_span" style="display: none;">
					模板<BZ:select field="TEMPLATE_ID" formTitle="" prefix="Article_" isCode="true" codeName="SKIP_CHANNEL_TPL" width="70px"/>
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --%>
				
				<%-- <span id="is_common_soft_span">
					<input type="checkbox" id="Article_IS_COMMON_SOFT" name="Article_IS_COMMON_SOFT" value="1" onclick="num_span_sh('num_span',this);hiddenInput_('is_common_soft_span',this,'Article_IS_COMMON_SOFT','2');">常用软件
				</span>
				<span id="num_span" style="display: none;">
					排序<BZ:input field="COMMON_SOFT_SEQ_NUM" prefix="Article_" defaultValue="" style="width:50px;"/>
				</span> --%>
			</td>
			</tr>
			<tr height="30px">
			<td class="title">权　　限：</td>
			<td colspan="3" style="font-weight: bold;">
				<input type="checkbox" id="Article_DATA_ACCESS_PUBLIC" name="DATA_ACCESS" value="1" onclick="_dataAccess(this.id)" checked="checked">公开
				
				<!-- <input type="checkbox" id="Article_DATA_ACCESS_PERSON" name="DATA_ACCESS" value="2" onclick="_dataAccess(this.id)">
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_PERSON')" style="text-decoration: none;">人员授权</a> -->
				
				<input type="checkbox" id="Article_DATA_ACCESS_ORGAN" name="DATA_ACCESS" value="3" onclick="_dataAccess(this.id)">
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_ORGAN')">组织授权</a>
				
				<input type="hidden" id="PERSON_ARTICLE_RELA" name="PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_PERSON_ARTICLE_RELA" name="IDS_PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="ORGAN_ARTICLE_RELA" name="ORGAN_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_ORGAN_ARTICLE_RELA" name="IDS_ORGAN_ARTICLE_RELA"/>
			</td>
			</tr>
			<%
				//判断栏目是否为审核
				if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
			%>
			<tr>
				<td class="title">审&nbsp;&nbsp;核&nbsp;&nbsp;人：</td>
				<td colspan="3">
					<BZ:input prefix="IDS_" field="AUDITPERSON_ARTICLE_RELA" type="helper" helperCode="SYS_ORGAN_PERSON" helperTitle="选择人员" treeType="3" helperSync="true" showParent="false" defaultShowValue="" showFieldId="AUDITPERSON_ARTICLE_RELA" property="data" style="width:600px;" />
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
			<%-- <td class="title">上传正文：</td>
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
			<td class="title">附　　件：</td>
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
			<td class="title" style="width: 120px;">附件图标：</td>
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
			<td class="title" style="white-space: nowrap;">附件说明：</td>
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
			<!-- 尾部 -->
			<div class="kuangjia" style="margin: 0px;margin-top: 5px;">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
			<td align="center" style="padding-right:30px" colspan="2">
				<input type="button" value="暂存" class="button_add" onclick="zhancun()"/>&nbsp;&nbsp;
				<%-- <%
					//如果栏目为审核才可能进入判断是否为审核人
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
						if(!"AUTHER_AUTH".equals(autherAuth)){
				%>
				<input type="button" style="width: 80px" value="提交审核" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
						}
					}
				%> --%>
				<%-- <%
					//判断栏目是否为审核
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
				%>
				<input type="button" style="width: 80px" value="提交审核" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
					}
				%> --%>
				<input type="button" style="width: 80px" value="直接发布" class="button_add" onclick="fabu()"/>&nbsp;&nbsp;
				<input type="button" value="预览" class="button_select" onclick="_chakan()"/>&nbsp;&nbsp;
				<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;
				<!-- <input type="button" value="返回" class="button_back" onclick="_back()"/> -->
				<input type="button" value="关闭" class="button_delete" onclick="window.close();"/>
			</td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
</table>
</BZ:form>


<script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
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
        var value = prompt('插入html代码', '');
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
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'));
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
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
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt);
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
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
        alert("已清空草稿箱");
    }
</script>
</BZ:body>
</BZ:html>