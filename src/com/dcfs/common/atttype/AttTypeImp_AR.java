/**   
 * @Title: AttTypeImp_AR.java 
 * @Package com.dcfs.common.atttype 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn   
 * @date 2014-7-23 ����4:57:15 
 * @version V1.0   
 */
package com.dcfs.common.atttype;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.hx.upload.diskrule.AbstractDiskStoreRule;

/** 
 * @ClassName: AttTypeImp_AR
 * @Description: �����ļ���������ʵ����
 * @author songhn
 * @date 2014-7-23 ����4:57:15 
 *  
 */
public class AttTypeImp_AR extends AbstractDiskStoreRule {

	//�����ļ�ID
	private String ar_id = "";
	//�����������
	private String ar_class = "";
	
	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public AttTypeImp_AR() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String generateStoreRulePath() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String generateStoreRulePath(String... arg0) {
		
		StringBuffer dirPath = new StringBuffer("");
		
		if(null != arg0 && arg0.length > 0){
			
			ar_id = arg0[0].substring(arg0[0].indexOf("=")+1, arg0[0].length());
			ar_class = arg0[1].substring(arg0[1].indexOf("=")+1, arg0[1].length());
			
			dirPath.append("/")
				   .append(getCurDateStr())
				   .append("/")
				   .append(ar_id)
				   .append("/")
				   .append(ar_class)
			       .append("/");
			
			return dirPath.toString();
			
		}
		
		return null;
		
	}
	
	/**
	 * @Title: getCurDateStr 
	 * @Description: ��ȡ��ǰ���ڵĸ�ʽ���ַ��� {YYYY}_{DD}
	 * @author: songhn
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	private static String getCurDateStr(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM");
		
		Date curDate = new Date();
		
		String str = sdf.format(curDate);
		
		return str;
		
	}
	
	//������ʽ��ar_id=1212133;ar_class=1212232
	public static void main(String[] args) {
		AttTypeImp_AR ar = new AttTypeImp_AR();
		System.out.println(ar.generateStoreRulePath("ar_id=1212133","ar_class=1212232"));
	}
	
}
