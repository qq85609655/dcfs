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
<up:uploadResource/>
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<script type="text/javascript" src="<%=path %>/fckeditor/fckeditor.js"></script>
<script>
	var secid=<%=secid %>;
	//发布
	function tijiao()
	{
		//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true);
		if(title==""){
			alert("标题不能为空,请填写标题！");
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
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true);
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
	
		document.srcForm.action=path+"article/Article!addTemp.action";
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
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true);
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
	
		document.srcForm.action=path+"article/Article!addDirect.action";
	 	document.srcForm.submit();
 	
 		//关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	function _back(){
	var ID = document.getElementById("CHANNEL_ID").value;
 	document.srcForm.action=path+"article/Article!query.action?CHANNEL_ID="+ID;
 	document.srcForm.submit();
	}
	
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
	
	/*---------FCK处理部分开始-----------*/
	//获取编辑器中内容
	function getEditorContents(bol){
   		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
   		return oEditor.GetXHTML(bol);
		//return oEditor.EditorDocument.body.innerText;   		
	}
	//向编辑器插入指定代码
	function insertHTMLToEditor(codeStr){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		oEditor.InsertHtml(codeStr);
	}
	//统计编辑器中内容的字数
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
	//执行指定动作
	function ExecuteCommand(commandName){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT") ;
		oEditor.Commands.GetCommand(commandName).Execute() ;
	}
	//设置编辑器中内容
	function SetContents(codeStr){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT") ;
		oEditor.SetHTML(codeStr) ;
	}
	/*---------FCK处理部分结束-----------*/
	
	//选择栏目
	function changeChannel(){
		var reValue = window.showModalDialog(path+"channel/Channel!generateTreeForPerson.action?treeDispatcher=changeChannelTree", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		document.getElementById("CHANNEL_ID").value = reValue["value"];
		document.getElementById("CHANNEL_NAME").value = reValue["name"];
	}
	
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
  		//是否弹出
  		hiddenInput_('is_skip_span',document.getElementById("Article_IS_SKIP"),'Article_IS_SKIP','0');
  		//常用软件
  		hiddenInput_('is_common_soft_span',document.getElementById("Article_IS_COMMON_SOFT"),'Article_IS_COMMON_SOFT','2');
  	}
  	
  	//数据授权
  	function  _dataAccess(id){
  		var node = document.getElementById(id);
  		var value = node.value;
  		if(value == "1" && node.checked){
  			document.getElementById("Article_DATA_ACCESS_PERSON").checked=false;
  			document.getElementById("Article_DATA_ACCESS_ORGAN").checked=false;
  		}
  		if((value == "2" && node.checked) || (value == "3" && node.checked)){
  			document.getElementById("Article_DATA_ACCESS_PUBLIC").checked=false;
  		}
  		
  		if((value == "2" && node.checked)){
  			//弹出人员树
  			var selectedids = document.getElementById("IDS_PERSON_ARTICLE_RELA").value;
			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
			document.getElementById("IDS_PERSON_ARTICLE_RELA").value = ids;
  		}
  		
  		if((value == "3" && node.checked)){
  			//组织树
  			var selectedids = document.getElementById("IDS_ORGAN_ARTICLE_RELA").value;
  			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
  			document.getElementById("IDS_ORGAN_ARTICLE_RELA").value = ids;
  		}
  	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="SECURITY_LEVEL;SECURITY_XX;SKIP_CHANNEL_TPL" onload="_selectMJ(secid);_editAreaScroll();_initFields();">
<BZ:form name="srcForm" method="post">
<table style="width: 850px;height: 100%;" cellpadding="0" cellspacing="0" border="0" align="center">
	<tr>
		<td height="100%">
			<div class="kuangjia" id="_kuangjia" style="margin: 0px;margin-top: 10px;height: 100%">
			<div class="heading">添加内容</div>
			<!-- 栏目ID -->
			<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
			<table class="contenttable">
			
			<tr height="30px">
			<td class="title">所属栏目：</td>
			<td colspan="3">
				<BZ:input id="CHANNEL_ID" field="CHANNEL_ID" prefix="Article_" type="hidden" defaultValue=""/>
				<input type="text" id="CHANNEL_NAME" name="CHANNEL_NAME" value="<%=data.getString(Channel.NAME)!=null?data.getString(Channel.NAME):"" %>" readonly="readonly" onclick="changeChannel();"/>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">标　　题：</td>
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
			<td><BZ:input field="SEQ_NUM" prefix="Article_" defaultValue="2147483647"/></td>
			<td class="title">发布日期：</td>
			<td><BZ:input field="CREATE_TIME" prefix="Article_" type="datetime" defaultValue="%nowdatetime%"/></td>
			</tr>
			
			<tr>
			<td class="title">密　　级：</td>
			<td><BZ:select id="miji" field="SECURITY_LEVEL" prefix="Article_" formTitle="密级" isCode="true" codeName="SECURITY_LEVEL" onchange="_selectMJ()"></BZ:select></td>
			<td class="title" ><span id="qixianTitle">保密期限：</span></td>
			<td><BZ:select id="qixian" field="PROTECT_PERIOD" prefix="Article_" formTitle="保密期限" isCode="true" codeName="SECURITY_XX" onchange="_addMJDate()"></BZ:select></td>
			</tr>
			<tr id="mjstartDateTitle">
			<td nowrap class="title" >保密起始日期：</td>
			<td colspan="3">
				<BZ:input field="PROTECT_START_DATE" type="date" prefix="Article_" id="mjstartDate" defaultValue="%nowDate%" onblur="_addMJDate();" />
				<BZ:input field="PROTECT_END_DATE" prefix="Article_" type="hidden" id="mjendDate" defaultValue=""/>
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
				
				<span id="is_skip_span">
					<input type="checkbox" id="Article_IS_SKIP" name="Article_IS_SKIP" value="1" onclick="num_span_sh('template_span',this);hiddenInput_('is_skip_span',this,'Article_IS_SKIP','0');">弹出
				</span>
				<span id="template_span" style="display: none;">
					模板<BZ:select field="TEMPLATE_ID" formTitle="" prefix="Article_" isCode="true" codeName="SKIP_CHANNEL_TPL" width="70px"/>
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_common_soft_span">
					<input type="checkbox" id="Article_IS_COMMON_SOFT" name="Article_IS_COMMON_SOFT" value="1" onclick="num_span_sh('num_span',this);hiddenInput_('is_common_soft_span',this,'Article_IS_COMMON_SOFT','2');">常用软件
				</span>
				<span id="num_span" style="display: none;">
					排序<BZ:input field="COMMON_SOFT_SEQ_NUM" prefix="Article_" defaultValue="" style="width:50px;"/>
				</span>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">权　　限：</td>
			<td colspan="3" style="font-weight: bold;">
				<input type="checkbox" id="Article_DATA_ACCESS_PUBLIC" name="DATA_ACCESS" value="1" onclick="_dataAccess(this.id)" checked="checked">公开
				<input type="checkbox" id="Article_DATA_ACCESS_PERSON" name="DATA_ACCESS" value="2" onclick="_dataAccess(this.id)">
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_PERSON')" style="text-decoration: none;">人员授权</a>
				<input type="checkbox" id="Article_DATA_ACCESS_ORGAN" name="DATA_ACCESS" value="3" onclick="_dataAccess(this.id)">
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_ORGAN')">组织授权</a>
				<input type="hidden" id="IDS_PERSON_ARTICLE_RELA" name="IDS_PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_ORGAN_ARTICLE_RELA" name="IDS_ORGAN_ARTICLE_RELA"/>
			</td>
			</tr>
			
			<tr height="30px">
			<td colspan="4">
				<!-- 
				<input type="button" value="格式初始化" onclick="clearStyle();">
				 -->
				<script type="text/javascript">
					var oFCKeditor = new FCKeditor( 'Article_CONTENT' ) ;
					oFCKeditor.BasePath	= "<%=path %>/fckeditor/" ;
					oFCKeditor.Height	= 600;
					oFCKeditor.Value	= '' ;
					oFCKeditor.Create() ;
				</script>
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
				
				<%
					//如果栏目为审核才可能进入判断是否为审核人
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
						if(!"AUTHER_AUTH".equals(autherAuth)){
				%>
				<input type="button" style="width: 80px" value="提交审核" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
						}
					}
				%>
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
</BZ:body>
</BZ:html>