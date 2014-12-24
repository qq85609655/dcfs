/*jadclipse*/// Decompiled by Jad v1.5.8f. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) radix(10) lradix(10) 
// Source File Name:   InputTag.java

package hx.taglib;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.database.databean.Data;
import hx.organ.UtilOrgan;
import hx.person.UtilPerson;
import hx.tools.helper.UtilHelper;
import hx.util.UtilDateTime;
import hx.util.UtilFormat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;

import org.lilystudio.smarty4j.TemplateException;

// Referenced classes of package hx.taglib:
//            BzTagSupport, TagTools

public class InputTag extends BzTagSupport {

    public InputTag() {
    }

    public String getHelperTitle() {
        return helperTitle;
    }

    public void setHelperTitle(String helperTitle) {
        this.helperTitle = helperTitle;
    }

    public String getDefaultShowValue() {
        return defaultShowValue;
    }

    public void setDefaultShowValue(String defaultShowValue) {
        this.defaultShowValue = defaultShowValue;
    }

    public String getTreeType() {
        return treeType;
    }

    public void setTreeType(String treeType) {
        this.treeType = treeType;
    }

    public boolean isShowParent() {
        return showParent;
    }

    public void setShowParent(boolean showParent) {
        this.showParent = showParent;
    }

    public String getHelperParam() {
        if (helperParam == null)
            helperParam = "";
        return helperParam;
    }

    public void setHelperParam(String helperParam) {
        this.helperParam = helperParam;
    }

    public boolean isSaveShowField() {
        return saveShowField;
    }

    public void setSaveShowField(boolean saveShowField) {
        this.saveShowField = saveShowField;
    }

    public String getShowField() {
        return showField;
    }

    public void setShowField(String showField) {
        this.showField = showField;
    }

    public String getShowFieldId() {
        if (showFieldId == null)
            showFieldId = (new StringBuilder(String.valueOf(getField())))
                    .append("_showid").toString();
        return showFieldId;
    }

    public void setShowFieldId(String showFieldId) {
        this.showFieldId = showFieldId;
    }

    public String getHelperCode() {
        return helperCode;
    }

    public void setHelperCode(String helperCode) {
        this.helperCode = helperCode;
    }

    public String getHelperCommonCode() {
        return helperCommonCode;
    }

    public void setHelperCommonCode(String helperCommonCode) {
        this.helperCommonCode = helperCommonCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getHelperSync() {
        return helperSync;
    }

    public void setHelperSync(String helperSync) {
        this.helperSync = helperSync;
    }

    protected void doStart(Map map) throws JspException {
    }

    protected void doEnd(Map context) throws JspException {
        Data d = null;
        if (getProperty() != null) {
            d = (Data) pageContext.getAttribute(getProperty());
            if (d == null)
                d = (Data) pageContext.getRequest().getAttribute(getProperty());
        } else {
            d = (Data) pageContext.getAttribute("_DEAFULTDATA");
            if (d == null)
                d = (Data) pageContext.getRequest()
                        .getAttribute("_DEAFULTDATA");
        }
        String value;
        if (d == null)
            value = "";
        else
            value = TagTools.getDataValue(d, getField(), type,
                    getDefaultValue());
        if ("helper".equals(getType()) || "helpersuggest".equals(getType())) {
            String showValue;
            if (isSaveShowField()) {
                if (d == null)
                    showValue = "";
                else
                    showValue = TagTools.getDataValue(d, getShowField(), type,
                            getDefaultShowValue());
            } else {
                Map map = (Map) pageContext.findAttribute("_CODELIST");
                if (map == null
                        || map.get((new StringBuilder(String
                                .valueOf(getHelperCode()))).append(
                                getHelperParam()).toString()) == null) {
                    CodeList cl = UtilHelper.getCodeList(getHelperCode(),
                            getHelperParam());
                    UtilCode.setCodeListToRequest(
                            (HttpServletRequest) pageContext.getRequest(),
                            (new StringBuilder(String.valueOf(getHelperCode())))
                                    .append(getHelperParam()).toString(), cl);
                    map = (Map) pageContext.findAttribute("_CODELIST");
                }
                CodeList codeList = (CodeList) map.get((new StringBuilder(
                        String.valueOf(getHelperCode()))).append(
                        getHelperParam()).toString());
                if (codeList == null)
                    codeList = new CodeList();
                map.put((new StringBuilder(String.valueOf(getHelperCode())))
                        .append(getHelperParam()).toString(), codeList);
                showValue = UtilHelper.getCodeValue(codeList, getHelperCode(),
                        getHelperParam(), value, isShowParent());
                if (showValue == null)
                    showValue = "";
            }
            context.put("showValue", showValue);
            context.put("sync", getHelperSync());
        }
        if ("helpersuggest".equals(getType())) {
            Map map = (Map) pageContext.findAttribute("_CODELIST");
            if (map == null
                    || map.get((new StringBuilder(String
                            .valueOf(getHelperCode())))
                            .append(getHelperParam()).toString()) == null) {
                CodeList cl = UtilHelper.getCodeList(getHelperCode(),
                        getHelperParam());
                UtilCode.setCodeListToRequest((HttpServletRequest) pageContext
                        .getRequest(),
                        (new StringBuilder(String.valueOf(getHelperCode())))
                                .append(getHelperParam()).toString(), cl);
                map = (Map) pageContext.findAttribute("_CODELIST");
            }
            CodeList codeList = (CodeList) map.get((new StringBuilder(String
                    .valueOf(getHelperCode()))).append(getHelperParam())
                    .toString());
            if (codeList == null)
                codeList = new CodeList();
            if (getHelperCommonCode() != null
                    && (map == null || map.get(getShowField()) == null)) {
                CodeList cl = UtilHelper.getCodeList(getHelperCommonCode(), "");
                UtilCode.setCodeListToRequest(
                        (HttpServletRequest) pageContext.getRequest(),
                        getHelperCommonCode(), cl);
                map = (Map) pageContext.findAttribute("_CODELIST");
            }
            CodeList commonCodeList = (CodeList) map.get(getHelperCommonCode());
            if (commonCodeList == null)
                commonCodeList = new CodeList();
            if (getShowField() != null)
                map.put(getShowField(), commonCodeList);
            if (getHelperCode() != null)
                map.put((new StringBuilder(String.valueOf(getHelperCode())))
                        .append(getHelperParam()).toString(), codeList);
            context.put("codeList", codeList);
            context.put("commoncodeList", commonCodeList);
        }
        if (getNotnull() != null || getRestriction() != null)
            context.put("verify", Boolean.valueOf(true));
        String name = (new StringBuilder(String.valueOf(getPrefix()))).append(
                getField()).toString();
        context.put("name", name);
        context.put("value", value);
        if (getId() != null)
            context.put("id", getId());
        if (getProperty() != null)
            context.put("property", getProperty());
        if (getFormTitle() != null)
            context.put("formTitle", getFormTitle());
        if (getField() != null)
            context.put("field", getField());
        if (getPrefix() != null)
            context.put("prefix", getPrefix());
        if (getType() != null)
            context.put("type", getType());
        if (getDefaultValue() != null)
            context.put("defaultValue", getDefaultValue());
        if (getRestriction() != null)
            context.put("restriction", getRestriction());
        if (getNotnull() != null)
            context.put("notnull", getNotnull());
        if (getAccesskey() != null)
            context.put("accesskey", getAccesskey());
        if (getAlign() != null)
            context.put("align", getAlign());
        if (getClassName() != null)
            context.put("className", getClassName());
        if (getMaxlength() != null)
            context.put("maxlength", getMaxlength());
        if (getOnblur() != null)
            context.put("onblur", getOnblur());
        if (getOnchange() != null)
            context.put("onchange", getOnchange());
        if (getOnclick() != null)
            context.put("onclick", getOnclick());
        if (getOndblclick() != null)
            context.put("ondblclick", getOndblclick());
        if (getOnfocus() != null)
            context.put("onfocus", getOnfocus());
        if (getOnkeydown() != null)
            context.put("onkeydown", getOnkeydown());
        if (getOnkeypress() != null)
            context.put("onkeypress", getOnkeypress());
        if (getOnkeyup() != null)
            context.put("onkeyup", getOnkeyup());
        if (getOnmousedown() != null)
            context.put("onmousedown", getOnmousedown());
        if (getOnmousemove() != null)
            context.put("onmousemove", getOnmousemove());
        if (getOnmouseout() != null)
            context.put("onmouseout", getOnmouseout());
        if (getOnmouseover() != null)
            context.put("onmouseover", getOnmouseover());
        if (getOnmouseup() != null)
            context.put("onmouseup", getOnmouseup());
        if (getOnselect() != null)
            context.put("onselect", getOnselect());
        if (getSize() != null)
            context.put("size", getSize());
        if (getStyle() != null)
            context.put("style", getStyle());
        if (getTabindex() != null)
            context.put("tabindex", getTabindex());
        if (getTitle() != null)
            context.put("title", getTitle());
        if (isChecked())
            context.put("checked", Boolean.valueOf(true));
        if (isDisabled())
            context.put("disabled", Boolean.valueOf(true));
        if (isReadonly())
            context.put("readonly", Boolean.valueOf(true));
        if (getDateExtend() != null)
            context.put("dateExtend", getDateExtend());
        if (getDateFormat() != null)
            context.put("dateFormat", getDateFormat());
        if (getMessage() != null)
            context.put("message", getMessage());
        String showName = getShowField();
        if (showName == null || "".equals(showName))
            showName = (new StringBuilder(String.valueOf(getField()))).append(
                    "_NAME").toString();
        String showId = getShowFieldId();
        if (showId == null || "".equals(showId))
            showId = showName;
        context.put("showFieldId", showId);
        if (isSaveShowField()) {
            context.put("saveShowField", Boolean.valueOf(true));
            showName = (new StringBuilder(String.valueOf(getPrefix()))).append(
                    showName).toString();
            context.put("showName", showName);
            setShowField("");
        } else {
            showName = (new StringBuilder("TMP_")).append(showName).toString();
            context.put("showName", (new StringBuilder("TMP_"))
                    .append(showName).toString());
            setShowField("");
        }
        if (isShowParent())
            context.put("showParent", Boolean.valueOf(true));
        if (getShowField() != null)
            context.put("showField", getShowField());
        if (getHelperCode() != null)
            context.put("helperCode", getHelperCode());
        if (getHelperParam() != null)
            context.put("helperParam", getHelperParam());
        if (getHelperTitle() != null)
            context.put("helperTitle", getHelperTitle());
        if (getTreeType() != null)
            context.put("treeType", getTreeType());
        else
            context.put("treeType", "0");
        try {
            HttpServletRequest request = (HttpServletRequest) pageContext
                    .getRequest();
            context.put("resourcePath", TagTools.getResourcePath(request, null));
        } catch (TemplateException e) {
            throw new JspTagException(UtilFormat.format(p.getString("tagErr"),
                    new Object[] { e.getMessage() }));
        }
    }

    protected String[] getEndTagName() throws JspException {
        return (new String[] { "input", getType() });
    }

    protected String[] getStartTagName() throws JspException {
        return null;
    }

    public String getProperty() {
        return property;
    }

    public void setProperty(String property) {
        this.property = property;
    }

    public String getField() {
        return field.toUpperCase();
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getPrefix() {
        if (prefix == null)
            prefix = "Ins_";
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public String getType() {
        if (type == null)
            type = "string";
        return type.toLowerCase();
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDefaultValue() {
        if (defaultValue != null) {
            if ("%nowDate%".equalsIgnoreCase(defaultValue))
                return UtilDateTime.nowDateString();
            if ("%nowDateTime%".equalsIgnoreCase(defaultValue))
                return UtilDateTime.nowDateTimeString();
            if ("%LoginPersonId%".equalsIgnoreCase(defaultValue))
                return UtilPerson.getLoginUserId();
            if ("%LoginPersonName%".equalsIgnoreCase(defaultValue))
                return UtilPerson.getLoginUserName();
            if ("%LoginOrganId%".equalsIgnoreCase(defaultValue))
                return UtilOrgan.getLoginOrganId();
            if ("%LoginOrganName%".equalsIgnoreCase(defaultValue))
                return UtilOrgan.getLoginOrganName();
        }
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getRestriction() {
        if ("".equals(restriction))
            restriction = null;
        return restriction;
    }

    public void setRestriction(String restriction) {
        this.restriction = restriction;
    }

    public String getNotnull() {
        if ("".equals(notnull))
            notnull = null;
        return notnull;
    }

    public void setNotnull(String notnull) {
        this.notnull = notnull;
    }

    public String getAccesskey() {
        return accesskey;
    }

    public void setAccesskey(String accesskey) {
        this.accesskey = accesskey;
    }

    public String getAlign() {
        return align;
    }

    public void setAlign(String align) {
        this.align = align;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    public String getMaxlength() {
        return maxlength;
    }

    public void setMaxlength(String maxlength) {
        this.maxlength = maxlength;
    }

    public String getOnblur() {
        return onblur;
    }

    public void setOnblur(String onblur) {
        this.onblur = onblur;
    }

    public String getOnchange() {
        return onchange;
    }

    public void setOnchange(String onchange) {
        this.onchange = onchange;
    }

    public String getOnclick() {
        return onclick;
    }

    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }

    public String getOndblclick() {
        return ondblclick;
    }

    public void setOndblclick(String ondblclick) {
        this.ondblclick = ondblclick;
    }

    public String getOnfocus() {
        return onfocus;
    }

    public void setOnfocus(String onfocus) {
        this.onfocus = onfocus;
    }

    public String getOnkeydown() {
        return onkeydown;
    }

    public void setOnkeydown(String onkeydown) {
        this.onkeydown = onkeydown;
    }

    public String getOnkeypress() {
        return onkeypress;
    }

    public void setOnkeypress(String onkeypress) {
        this.onkeypress = onkeypress;
    }

    public String getOnkeyup() {
        return onkeyup;
    }

    public void setOnkeyup(String onkeyup) {
        this.onkeyup = onkeyup;
    }

    public String getOnmousedown() {
        return onmousedown;
    }

    public void setOnmousedown(String onmousedown) {
        this.onmousedown = onmousedown;
    }

    public String getOnmousemove() {
        return onmousemove;
    }

    public void setOnmousemove(String onmousemove) {
        this.onmousemove = onmousemove;
    }

    public String getOnmouseout() {
        return onmouseout;
    }

    public void setOnmouseout(String onmouseout) {
        this.onmouseout = onmouseout;
    }

    public String getOnmouseover() {
        return onmouseover;
    }

    public void setOnmouseover(String onmouseover) {
        this.onmouseover = onmouseover;
    }

    public String getOnmouseup() {
        return onmouseup;
    }

    public void setOnmouseup(String onmouseup) {
        this.onmouseup = onmouseup;
    }

    public String getOnselect() {
        return onselect;
    }

    public void setOnselect(String onselect) {
        this.onselect = onselect;
    }

    public boolean isReadonly() {
        return readonly;
    }

    public void setReadonly(boolean readonly) {
        this.readonly = readonly;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getTabindex() {
        return tabindex;
    }

    public void setTabindex(String tabindex) {
        this.tabindex = tabindex;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFormTitle() {
        return formTitle;
    }

    public void setFormTitle(String formTitle) {
        this.formTitle = formTitle;
    }

    public String getDateExtend() {
        return dateExtend;
    }

    public void setDateExtend(String dateExtend) {
        this.dateExtend = dateExtend;
    }

    public String getDateFormat() {
        return dateFormat;
    }

    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    private static final long serialVersionUID = -3530014668824166740L;
    private String property;
    private String id;
    private String field;
    private String prefix;
    private String type;
    private String showField;
    private String showFieldId;
    private boolean saveShowField;
    private boolean showParent;
    private String helperCode;
    private String helperCommonCode;
    private String helperParam;
    private String treeType;
    private String helperTitle;
    private String helperSync;
    private String defaultShowValue;
    private String defaultValue;
    private String restriction;
    private String notnull;
    private String dateExtend;
    private String dateFormat;
    private String accesskey;
    private String align;
    private boolean checked;
    private String className;
    private boolean disabled;
    private String maxlength;
    private String onblur;
    private String formTitle;
    private String onchange;
    private String onclick;
    private String ondblclick;
    private String onfocus;
    private String onkeydown;
    private String onkeypress;
    private String onkeyup;
    private String onmousedown;
    private String onmousemove;
    private String onmouseout;
    private String onmouseover;
    private String onmouseup;
    private String onselect;
    private boolean readonly;
    private String size;
    private String style;
    private String tabindex;
    private String title;
    private String message;
}


/*
    DECOMPILATION REPORT

    Decompiled from: D:\21softech_workspaces\xhs\WebContent\WEB-INF\lib\breeze.jar
    Total time: 47 ms
    Jad reported messages/errors:
The class file version is 49.0 (only 45.3, 46.0 and 47.0 are supported)
    Exit status: 0
    Caught exceptions:
*/