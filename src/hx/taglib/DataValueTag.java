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
import hx.util.UtilString;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.jsp.JspException;


/**
 * 
 */
@SuppressWarnings("unchecked")
public class DataValueTag extends BzTagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6959282886160184084L;
	private String field;
	private int length = 0;
	private String type;
	private String defaultValue;
	private String className;
	private String dateFormat;
	private String codeName;
	private String target;
	private String href;
	private String hrefTitle;
	private boolean onlyValue = false;
	private String checkValue;
	private String property;
	private String person;
	private String style;
	private String onclick;
	//add by mayun 2014-7-23
	private boolean isShowEN = false;
	
	
	public boolean getIsShowEN() {
		return isShowEN;
	}

	public void setIsShowEN(boolean isShowEN) {
		this.isShowEN = isShowEN;
	}

	/**
	 * @return style
	 */
	public String getStyle() {
		return style;
	}

	/**
	 * @param style 要设置的 style
	 */
	public void setStyle(String style) {
		this.style = style;
	}

	/**
	 * @return onclick
	 */
	public String getOnclick() {
		return onclick;
	}

	/**
	 * @param onclick 要设置的 onclick
	 */
	public void setOnclick(String onclick) {
		this.onclick = onclick;
	}

	public String getPerson() {
		return person;
	}

	public void setPerson(String person) {
		this.person = person;
	}

	/**
	 * @return the property
	 */
	public String getProperty() {
		return property;
	}

	/**
	 * @param property
	 *            the property to set
	 */
	public void setProperty(String property) {
		this.property = property;
	}

	private boolean showParent = false;// 是否显示父节点的名称
	private static final String SPLIT = ";";

	private static Log log = UtilLog.getLog(DataValueTag.class);

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

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#doStart(java.util.Map)
	 */
	@Override
	protected void doEnd(Map context) throws JspException {
		// 获取数据
		Data d = null;
		if (property != null) {
			d = (Data) pageContext.getAttribute(property);
		} else {
			d = (Data) pageContext.getAttribute(Constants.DEAFULT_DATA);
		}
		// 最终的值
		String value = "";
		// 提示信息
		String title = "";
		// 默认值
		String dValue = getDefaultValue();
		// 数据类型
		String type = getType();
		if (d != null) {
			// 最终的值
			value = TagTools.getDataValue(d, getField(), type, dValue);
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
			title = value;
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
			            String cv;
			            if (isShowParent()) {
			                cv = codeList.getFullName(value);
			                
			                //所属地区父级节点过滤掉‘市辖区’和‘县’：add by mazhihui at 20130604
			                cv =(cv==null)?"":cv.replaceFirst("-市辖区-","-").replaceFirst("-县-","-");
			                
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
			            } else {
			                value = "[" + value + "]";
			                title = value;
			            }
			        }
			    }else{
			        title = value;
			    }
			} else if (checkValue != null && !"".equals(checkValue) && value!=null) {
				// checkbox默认值
				if (!"".equals(value)) {
					String[] values = value.split(",");
					String tmpValue="";
					for(int m=0;m<values.length;m++){
						int start = checkValue.indexOf(values[m] + "=");
						if (m>0){
							tmpValue +=",";
						}
						if (start >= 0) {
							String checkValue1 = checkValue.substring(start + values[m].length() + 1);
							int end = checkValue1.indexOf(SPLIT);
							if (end > 0) {
								checkValue1 = checkValue1.substring(0, end);
							}
							tmpValue += checkValue1;
						}else{
							tmpValue += values[m];
						}
					}
					value=tmpValue;
					title = value;
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
		} else {
			value = dValue;
			title = value;
		}
		// className,target,hrefTitle,
		context.put("value", value);
		context.put("title", title);
		if (className != null) {
			context.put("className", className);
		}
		if (target != null) {
			context.put("target", target);
		}
		if (href != null) {
			context.put("href", href);
		}
		if (hrefTitle != null) {
			context.put("hrefTitle", hrefTitle);
		}
		if (onlyValue) {
			context.put("onlyValue", onlyValue);
		}
		if (style!= null) {
			context.put("style", style);
		}
		if (onclick!= null) {
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
		return new String[] { "dataValue", "foot" };
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

}
