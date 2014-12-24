/**
 * 
 */
package hx.code;

import java.util.ArrayList;
/**
 * 代码集<br>
 * 
 * @author lzb@qq.com
 *
 */
public class CodeList extends ArrayList<Code> {


	/**
	 * 
	 */
	private static final long serialVersionUID = 7219927834186692661L;

	private String codeSortId;

	public static final String SHOW_SPLIT = "-";

	/**
	 * 得到代码的显示名称
	 * 
	 * @param key
	 *            代码值
	 * @return <code>String[]</code>String[0]名称<br>
	 *         String[1]描述<br>
	 *         String[2]索引号
	 */
	public String[] getName(String key) {

		String[] reValue = new String[3];
		if (key == null || "".equals(key)) {
			return reValue;
		}
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			if (key.equals(code.getValue())) {
				reValue[0] = code.getName();
				reValue[1] = code.getRem();
				reValue[2] = Integer.toString(i);
			}
		}
		return reValue;
	}
	/**
	 * 注意：当值不是唯一的时候，<br>使用该方法可以将所有的名称连接起来舒输出<br>
	 * 得到代码的显示名称，只有个别情况使用
	 * 
	 * @param key
	 *            代码值
	 * @return <code>String[]</code>String[0]逗号分隔的名称<br>
	 *         String[1]描述<br>
	 *         String[2]索引号
	 */
	public String[] getNames(String key) {
		String[] reValue = new String[3];
		if (key == null || "".equals(key)) {
			return reValue;
		}
		key = "," + key.trim() + ",";
		StringBuffer name = new StringBuffer();
		int m = 0;
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			if (key.indexOf("," + code.getValue() + ",") >= 0) {
				if (m > 0) {
					name.append(";");
				}
				name.append(code.getName());
				reValue[1] = code.getRem();
				reValue[2] = Integer.toString(i);
				m++;
			}
		}
		if (m > 0) {
			reValue[0] = name.toString();
		}
		return reValue;
	}
	
	/**
	 * 注意：当值不是唯一的时候，<br>使用该方法可以将所有的名称连接起来舒输出<br>
	 * 得到代码的显示名称，只有个别情况使用
	 * 
	 * @param key
	 *            代码值
	 * @return <code>String[]</code>String[0]逗号分隔的名称<br>
	 *         String[1]描述<br>
	 *         String[2]索引号
	 */
	public String[] getLetters(String key) {
		String[] reValue = new String[3];
		if (key == null || "".equals(key)) {
			return reValue;
		}
		key = "," + key.trim() + ",";
		StringBuffer name = new StringBuffer();
		int m = 0;
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			if (key.indexOf("," + code.getValue() + ",") >= 0) {
				if (m > 0) {
					name.append(";");
				}
				name.append(code.getLetter());
				reValue[1] = code.getRem();
				reValue[2] = Integer.toString(i);
				m++;
			}
		}
		if (m > 0) {
			reValue[0] = name.toString();
		}
		return reValue;
	}
	/**
	 * 得到所有的显示名称，并全部列出<br>
	 * 主要用在树选择上，例如选择地区<br>
	 * 例如：中国-北京-海淀区
	 * @param key 代码值
	 * @param join_sign 连接的符号，如果想没有符号分隔，只需要传入“”
	 * @return
	 */
	public String getFullName(String key,String join_sign){
		String reValue = null;
		if (key==null || "".equals(key)){
			return reValue;
		}
		key = "," + key.trim() + ",";
		StringBuffer name = new StringBuffer();
		int m=0;
		int size=super.size();
		for(int i=0;i<size;i++){
			Code code = (Code)get(i);
			if(key.indexOf("," + code.getValue() + ",")>=0){
				if(m>0){
					name.append(";");
				}
				name.append(getParentValues(code.getParentValue(),join_sign));
				name.append(code.getName());
				m++;
			}
		}
		return name.toString();
	}
	/**
	 * 得到所有的显示名称，并全部列出<br>
	 * 主要用在树选择上，例如选择地区<br>
	 * 例如：中国-北京-海淀区
	 * @param key 代码值
	 * @return 完整的代码名称
	 */
	public String getFullName(String key){
		return getFullName(key,null);
	}

	/**
	 * 得到所有的显示名称，并全部列出<br>
	 * 主要用在树选择上，例如选择地区
	 * @param v 代码值
	 * @param join_sign 连接的符号，如果想没有符号分隔，只需要传入“”
	 * @return 连接的代码
	 */
	private String getParentValues(String v,String join_sign) {
		if (v == null || "".equals(v)) {
			return "";
		}
		if (join_sign==null){
			join_sign=SHOW_SPLIT;
		}
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			String vs = code.getValue();
			if (vs.equals(v)) {
				String v1 = code.getParentValue();
				if (v1!=null && !"".equals(v1)){
					return getParentValues(v1,join_sign)+ code.getName() + join_sign ;
				}else{
					return code.getName() + join_sign;
				}
			}
		}
		return "";
	}

	/**
	 * 通过字母码得到显示名称
	 * 
	 * @param letter
	 *            字母码
	 * @return <code>String[]</code>String[0]名称<br>
	 *         String[1]描述<br>
	 *         String[2]索引号
	 */
	public String[] getNameByLetter(String letter) {
		String[] reValue = new String[3];
		if (letter == null || "".equals(letter)) {
			return reValue;
		}
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			if (letter.equals(code.getLetter())) {
				reValue[0] = code.getName();
				reValue[1] = code.getRem();
				reValue[2] = Integer.toString(i);
			}
		}
		return reValue;
	}

	/**
	 * 得到代码集的ID
	 * @return codeSortId
	 */
	public String getCodeSortId() {
		return codeSortId;
	}

	/**
	 * 设置代码集的ID
	 * @param codeSortId
	 *            要设置的 codeSortId
	 */
	public void setCodeSortId(String codeSortId) {
		this.codeSortId = codeSortId;
	}
	/**
	 * 根据codeId得到CodeList中的code
	 * @param codeId
	 * @return
	 */
	public Code getCodeById(String codeId){
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			if (codeId.equals(code.getId())){
				return code;
			}
		}
		return null;
	}
	/**
	 * 根据value得到code
	 * @param value
	 * @return
	 */
	public Code getCodeByValue(String value){
		if (value==null){
			return null;
		}
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			if (value.equals(code.getValue())){
				return code;
			}
		}
		return null;
	}
	/**
	 * 获得指定上级ID的codelist
	 * @param parentId
	 * @return
	 */
	public CodeList findCodeListByParentId(String parentId){
		CodeList cl = new CodeList();
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			String pid = code.getParentValue();
			//判断顶级
			if(parentId==null || "".equals(parentId) || "0".equals(parentId)){
				if(pid==null || "".equals(pid) || "0".equals(pid)){
					cl.add(code);
				}
			}else{
			//判断一般级别
				if(parentId.equals(pid)){
					cl.add(code);
				}
			}
		}
		return cl;
	}
	public String toString(){
		return super.toString();
	}
	/**
	 * 转换为JSON串
	 * 
	 * @return
	 */
	public String toJSON(String open,String url,String target) {
		String urlParamSplit="&";
		if(url!=null){
			if(url.indexOf("?")==-1){
				urlParamSplit="?";
			}
		}
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		int len = size();
		for (int i = 0; i < len; i++) {
			if (i > 0) {
				sb.append(",");
			}
			sb.append(((Code)get(i)).toJSON(open,url,urlParamSplit,target));
		}
		sb.append("]");
		return sb.toString();
	}
	public String toJSON(String open,String url,String target,String exp) {
		String urlParamSplit="&";
		if(url!=null){
			if(url.indexOf("?")==-1){
				urlParamSplit="?";
			}
		}
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		int len = size();
		for (int i = 0; i < len; i++) {
			if (i > 0) {
				sb.append(",");
			}
			sb.append(((Code)get(i)).toJSON(open,url,urlParamSplit,target,exp));
		}
		sb.append("]");
		return sb.toString();
	}
	public static void main(String[] args) {
		String[] reValue = new String[3];
		System.out.println(reValue[0]);
		System.out.println(reValue[2]);
		System.out.println(reValue[1]);
	}
}
