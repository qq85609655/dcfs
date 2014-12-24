/**   
 * @Title: AttTypeImp_OTHER.java 
 * @Package com.dcfs.common.atttype 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn   
 * @date 2014-7-23 下午4:57:15 
 * @version V1.0   
 */
package com.dcfs.common.atttype;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.hx.upload.diskrule.AbstractDiskStoreRule;

/** 
 * @ClassName: AttTypeImp_AR
 * @Description: 其他附件类型实现类
 * @author songhn
 * @date 2014-7-23 下午4:57:15 
 *  
 */
public class AttTypeImp_OTHER extends AbstractDiskStoreRule{

	//分类代码
	private String class_code = "";
	
	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public AttTypeImp_OTHER() {
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
			
			class_code = arg0[0].substring(arg0[0].indexOf("=")+1, arg0[0].length());
			
			dirPath.append("/")
				   .append(class_code)
				   .append("/")
				   .append(getCurDateStr())
				   .append("/");
			
			return dirPath.toString();
			
		}
		
		return null;
		
	}

	/**
	 * @Title: getCurDateStr 
	 * @Description: 获取当前日期的格式化字符串 {YYYY}_{DD}
	 * @author: songhn
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	private static String getCurDateStr(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM");
		
		Date curDate = new Date();
		
		String str = sdf.format(curDate);
		
		return str;
		
	}

	//参数格式：class_code=1212133
	public static void main(String[] args) {
		AttTypeImp_OTHER af = new AttTypeImp_OTHER();
		System.out.println(af.generateStoreRulePath("class_code=1212133"));
	}
	
}
