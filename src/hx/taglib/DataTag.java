/**
 * 
 */
package hx.taglib;

import hx.code.CodeList;
import hx.common.Constants;
import hx.database.databean.Data;
import hx.log.Log;
import hx.log.UtilLog;
import hx.person.UtilPerson;
import hx.util.UtilFormat;
import hx.util.UtilString;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;


/**
 * @author lzb@qq.com
 * 
 */
@SuppressWarnings("unchecked")
public class DataTag extends BzTagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7550014449279684063L;
	private String field;
	private int length = 0;
	private String type;
	private String defaultValue;
	private String dateFormat;
	private String className;
	private String codeName;
	private String person;
	private String target;
	private String href;
	private String hrefTitle;
	private boolean onlyValue = false;
	private String checkValue;
	private String onclick;
	private boolean showParent = false;// 是否显示父节点的名称
	private static final String SPLIT = ";";
	private String codeSortid;
	//add by mayun 2014-7-23
	private boolean isShowEN = false;

	private static Log log = UtilLog.getLog(DataTag.class);

	@Override
	protected void doStart(Map context) throws JspException {
		StringBuffer buf = new StringBuffer();
		if (getIsShowEN()) {
            buf.append(" isShowEN=\"").append(isShowEN).append("\"");
        }
		
		try {
			pageContext.getOut().print(buf.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	public String getPerson() {
		return person;
	}

	public void setPerson(String person) {
		this.person = person;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#doStart(java.util.Map)
	 */
	@Override
	protected void doEnd(Map context) throws JspException {
		// 获取父标签，或者父标签的
		Tag parent = getParent();
		ForTag forTag = null;
		if (parent == null) {
			throw new JspException(UtilFormat.format(p
					.getString("notFoundParent"), "data", "for"));
		}
		try {
			forTag = (ForTag) parent;
		} catch (Exception e) {
			forTag = (ForTag) parent.getParent();
			if (parent == null) {
				throw new JspException(UtilFormat.format(p
						.getString("notFoundParent"), "data", "for"));
			}
		}
		// 获取数据
		Data d = forTag.getData();

		// 默认值
		String dValue = getDefaultValue();
		// 数据类型
		String type = getType();
		// 根据类型，拿到需要的数据
		// 最终的值
		String value = TagTools.getDataValue(d, getField(), type, dValue);
		if(getCodeSortid()!=null){
		Map<String,String> map=(Map<String, String>) pageContext.getAttribute(Constants.CODESOTRNAME);
        map = (Map<String, String>) pageContext.findAttribute(Constants.CODESOTRNAME);
        if(map==null){
            map = (Map<String, String>) pageContext.getRequest().getAttribute(Constants.CODESOTRNAME);
        }
        String checkValue = null;
        if(map!=null){
            checkValue=map.get(getCodeSortid());
        }
        if (checkValue != null && !"".equals(checkValue)){
            if (!"".equals(value)) {
                int start = checkValue.indexOf(value + "=");
                if (start >= 0) {
                    checkValue = checkValue.substring(start + value.length()
                            + 1);
                    int end = checkValue.indexOf(SPLIT);
                    if (end > 0) {
                        checkValue = checkValue.substring(0, end);
                    }
                    value = checkValue;
                }
            }
        }
		}
		//根据dateFormat格式化数据
		if (dateFormat != null) {
            try{
                if(value!=null && !value.equals(dValue)){
                    int l = value.length();
                    if(l ==10){
                        value = value + " 00:00:00";
                    }
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date date = sdf.parse(value);
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
                    value=simpleDateFormat.format(date);
                }
            }catch (Exception e) {
                value="数据值是非法的时间类型";
                if (log.isError()) {
                    log.logError(value);
                }
                e.printStackTrace();
            }
        }
		// 提示信息
		String title = value;
		// 判断是否是代码，如果是的话，就取代码，并且将值替换为代码
		if (codeName != null) {
			if (value != null && !"".equals(value)) {
				CodeList codeList = TagTools.getCodeList(pageContext, codeName);
				if (codeList == null) {
					value = "页面中没有存放名称为“" + codeName + "”的代码集";
					if (log.isError()) {
						log.logError(value);
					}
					title = value;
				} else {
					String cv="";
					if (isShowParent()) {
						cv = codeList.getFullName(value);
						title = cv;
					} else {
						if(getIsShowEN()){
							String[] vs = codeList.getLetters(value);
							cv = vs[0];
							title = vs[1];
						}else{
							String[] vs = codeList.getNames(value);
							cv = vs[0];
							title = vs[1];
						}
						
						if(title==null){
							title="";
						}
					}
					if (cv != null) {
						value = cv;
						title = value;
					} else {
						value = "[" + value + "]";
						title = value;
					}
				}
			} else {
				title = value;
			}
		} else if (checkValue != null && !"".equals(checkValue)) {
			// checkbox默认值
			if (!"".equals(value)) {
				int start = checkValue.indexOf(value + "=");
				if (start >= 0) {
					checkValue = checkValue.substring(start + value.length()
							+ 1);
					int end = checkValue.indexOf(SPLIT);
					if (end > 0) {
						checkValue = checkValue.substring(0, end);
					}
					value = checkValue;
					title = value;
				}
			}
		}else if("true".equalsIgnoreCase(getPerson())){
			//符合条件的将代码改为中文
			value=UtilPerson.getUserNameForUserId(value);
			title = value;
		}
		if (!isOnlyValue()) {
			if (length > 0 && length < 3) {
				length = 3;
			}
			if (length > 0 && value.length() > length) {
				value = value.substring(0, length - 3) + "...";
				context.put("style", "cursor:default;");
			}
			UtilString.replace(value, "\"", "&quot;");
			UtilString.replace(value, "<", "&lt;");
			UtilString.replace(value, ">", "&gt;");
		}
		UtilString.replace(title, "\"", "&quot;");
		UtilString.replace(title, "<", "&lt;");
		UtilString.replace(title, ">", "&gt;");
		// className,target,hrefTitle,
		context.put("value", value);
		context.put("title", title);
		if (className != null) {
			context.put("className", className);
		}
		if (target != null) {
			context.put("target", target);
		}
		if (hrefTitle != null) {
			context.put("hrefTitle", hrefTitle);
		}
		if (onlyValue) {
			context.put("onlyValue", onlyValue);
		}
		if (onclick != null) {
            context.put("onclick", onclick);
        }
	}

	/**
	 * @return the field
	 */
	public String getField() {
		return field;
	}

	/**
	 * @param field
	 *            the field to set
	 */
	public void setField(String field) {
		this.field = field;
	}

	/**
	 * @return the length
	 */
	public int getLength() {
		return length;
	}

	/**
	 * @param length
	 *            the length to set
	 */
	public void setLength(int length) {
		this.length = length;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the defaultValue
	 */
	public String getDefaultValue() {
		return defaultValue;
	}

	/**
	 * @param defaultValue
	 *            the defaultValue to set
	 */
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}

	/**
	 * @param className
	 *            the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
	}

	/**
	 * @return the codeName
	 */
	public String getCodeName() {
		return codeName;
	}

	/**
	 * @param codeName
	 *            the codeName to set
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	/**
	 * @return the target
	 */
	public String getTarget() {
		return target;
	}

	/**
	 * @param target
	 *            the target to set
	 */
	public void setTarget(String target) {
		this.target = target;
	}

	/**
	 * @return the href
	 */
	public String getHref() {
		return href;
	}

	/**
	 * @param href
	 *            the href to set
	 */
	public void setHref(String href) {
		this.href = href;
	}

	/**
	 * @return the hrefTitle
	 */
	public String getHrefTitle() {
		return hrefTitle;
	}

	/**
	 * @param hrefTitle
	 *            the hrefTitle to set
	 */
	public void setHrefTitle(String hrefTitle) {
		this.hrefTitle = hrefTitle;
	}

	/**
	 * @return the onlyValue
	 */
	public boolean isOnlyValue() {
		return onlyValue;
	}

	/**
	 * @param onlyValue
	 *            the onlyValue to set
	 */
	public void setOnlyValue(boolean onlyValue) {
		this.onlyValue = onlyValue;
	}

	/**
	 * @return the checkValue
	 */
	public String getCheckValue() {
		return checkValue;
	}

	/**
	 * @param checkValue
	 *            the checkValue to set
	 */
	public void setCheckValue(String checkValue) {
		this.checkValue = checkValue;
	}

	/**
	 * @return the showParent
	 */
	public boolean isShowParent() {
		return showParent;
	}

	/**
	 * @param showParent
	 *            the showParent to set
	 */
	public void setShowParent(boolean showParent) {
		this.showParent = showParent;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#getEndTagName()
	 */
	@Override
	protected String[] getEndTagName() throws JspException {
		return new String[] { "data", "head" };
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#getStartTagName()
	 */
	@Override
	protected String[] getStartTagName() throws JspException {
		return null;
	}

    /**
     * @return Returns the dateFormat.
     */
    public String getDateFormat() {
        return dateFormat;
    }

    /**
     * @param dateFormat The dateFormat to set.
     */
    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }

    /**
     * @return Returns the onclick.
     */
    public String getOnclick() {
        return onclick;
    }

    /**
     * @param onclick The onclick to set.
     */
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }

    /**
     * @return Returns the codeSortid.
     */
    public String getCodeSortid() {
        return codeSortid;
    }

    /**
     * @param codeSortid The codeSortid to set.
     */
    public void setCodeSortid(String codeSortid) {
        this.codeSortid = codeSortid;
    }
	public boolean getIsShowEN() {
		return isShowEN;
	}
	public void setIsShowEN(boolean isShowEN) {
		this.isShowEN = isShowEN;
	}

}
