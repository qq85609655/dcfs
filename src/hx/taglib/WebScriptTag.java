/**
 * 
 */
package hx.taglib;

import hx.config.Properties;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

/**
 * @author lzb@qq.com
 * 
 */
@SuppressWarnings("unchecked")
public class WebScriptTag extends BzTagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5525953594957938985L;
	private String index;
	private String list;
	private String edit;
	private String tree;
	private String isAjax;
	public String getIsAjax() {
		return isAjax;
	}

	public void setIsAjax(String isAjax) {
		this.isAjax = isAjax;
	}

	private static Properties p = new Properties(BzTagSupport.class.getName());

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#doEnd(java.util.Map)
	 */

	/**
	 * @return index
	 */
	public String getIndex() {
		return index;
	}

	/**
	 * @param index
	 *            Ҫ���õ� index
	 */
	public void setIndex(String index) {
		this.index = index;
	}

	/**
	 * @return tree
	 */
	public String getTree() {
		return tree;
	}

	/**
	 * @param tree Ҫ���õ� tree
	 */
	public void setTree(String tree) {
		this.tree = tree;
	}

	/**
	 * @return list
	 */
	public String getList() {
		return list;
	}

	/**
	 * @param list
	 *            Ҫ���õ� list
	 */
	public void setList(String list) {
		this.list = list;
	}

	/**
	 * @return edit
	 */
	public String getEdit() {
		return edit;
	}

	/**
	 * @param edit
	 *            Ҫ���õ� edit
	 */
	public void setEdit(String edit) {
		this.edit = edit;
	}

	@Override
	protected void doEnd(Map context) throws JspException {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#doStart(java.util.Map)
	 */
	@Override
	protected void doStart(Map context) throws JspException {
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

		String appUrl = request.getContextPath();
		String resourcePath = appUrl + "/resource";
		String oldResourcePath = appUrl + "/resources/resource1";
		context.put("resourcePath", resourcePath);
		context.put("oldResourcePath", oldResourcePath);
		if (list != null) {
			context.put("list", list);
		}
		if (index != null) {
			context.put("index", index);
		}
		if (edit != null) {
			context.put("edit", edit);
		}
		if (tree != null) {
			context.put("tree", tree);
		}
		if (isAjax != null) {
			context.put("isAjax", isAjax);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#getEndTagName()
	 */
	@Override
	protected String[] getEndTagName() throws JspException {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#getStartTagName()
	 */
	@Override
	protected String[] getStartTagName() throws JspException {
		return new String[] { "webscript", "head" };
	}

}
