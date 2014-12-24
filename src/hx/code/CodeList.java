/**
 * 
 */
package hx.code;

import java.util.ArrayList;
/**
 * ���뼯<br>
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
	 * �õ��������ʾ����
	 * 
	 * @param key
	 *            ����ֵ
	 * @return <code>String[]</code>String[0]����<br>
	 *         String[1]����<br>
	 *         String[2]������
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
	 * ע�⣺��ֵ����Ψһ��ʱ��<br>ʹ�ø÷������Խ����е������������������<br>
	 * �õ��������ʾ���ƣ�ֻ�и������ʹ��
	 * 
	 * @param key
	 *            ����ֵ
	 * @return <code>String[]</code>String[0]���ŷָ�������<br>
	 *         String[1]����<br>
	 *         String[2]������
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
	 * ע�⣺��ֵ����Ψһ��ʱ��<br>ʹ�ø÷������Խ����е������������������<br>
	 * �õ��������ʾ���ƣ�ֻ�и������ʹ��
	 * 
	 * @param key
	 *            ����ֵ
	 * @return <code>String[]</code>String[0]���ŷָ�������<br>
	 *         String[1]����<br>
	 *         String[2]������
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
	 * �õ����е���ʾ���ƣ���ȫ���г�<br>
	 * ��Ҫ������ѡ���ϣ�����ѡ�����<br>
	 * ���磺�й�-����-������
	 * @param key ����ֵ
	 * @param join_sign ���ӵķ��ţ������û�з��ŷָ���ֻ��Ҫ���롰��
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
	 * �õ����е���ʾ���ƣ���ȫ���г�<br>
	 * ��Ҫ������ѡ���ϣ�����ѡ�����<br>
	 * ���磺�й�-����-������
	 * @param key ����ֵ
	 * @return �����Ĵ�������
	 */
	public String getFullName(String key){
		return getFullName(key,null);
	}

	/**
	 * �õ����е���ʾ���ƣ���ȫ���г�<br>
	 * ��Ҫ������ѡ���ϣ�����ѡ�����
	 * @param v ����ֵ
	 * @param join_sign ���ӵķ��ţ������û�з��ŷָ���ֻ��Ҫ���롰��
	 * @return ���ӵĴ���
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
	 * ͨ����ĸ��õ���ʾ����
	 * 
	 * @param letter
	 *            ��ĸ��
	 * @return <code>String[]</code>String[0]����<br>
	 *         String[1]����<br>
	 *         String[2]������
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
	 * �õ����뼯��ID
	 * @return codeSortId
	 */
	public String getCodeSortId() {
		return codeSortId;
	}

	/**
	 * ���ô��뼯��ID
	 * @param codeSortId
	 *            Ҫ���õ� codeSortId
	 */
	public void setCodeSortId(String codeSortId) {
		this.codeSortId = codeSortId;
	}
	/**
	 * ����codeId�õ�CodeList�е�code
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
	 * ����value�õ�code
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
	 * ���ָ���ϼ�ID��codelist
	 * @param parentId
	 * @return
	 */
	public CodeList findCodeListByParentId(String parentId){
		CodeList cl = new CodeList();
		int size = super.size();
		for (int i = 0; i < size; i++) {
			Code code = (Code) get(i);
			String pid = code.getParentValue();
			//�ж϶���
			if(parentId==null || "".equals(parentId) || "0".equals(parentId)){
				if(pid==null || "".equals(pid) || "0".equals(pid)){
					cl.add(code);
				}
			}else{
			//�ж�һ�㼶��
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
	 * ת��ΪJSON��
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
