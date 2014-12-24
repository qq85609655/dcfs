/**   
 * @Title: AttTypeImp_CI.java 
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
 * @ClassName: AttTypeImp_CI
 * @Description: 儿童材料附件类型实现类
 * @author songhn
 * @date 2014-7-23 下午4:57:15 
 *  
 */
public class AttTypeImp_CI extends AbstractDiskStoreRule{

	//组织机构ID
	private String org_id = "";
	//儿童材料ID
	private String ci_id  = "";
	
	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public AttTypeImp_CI() {
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
			
				org_id = arg0[0].substring(arg0[0].indexOf("=")+1, arg0[0].length());
				
				ci_id  = arg0[1].substring(arg0[1].indexOf("=")+1, arg0[1].length());
			
				dirPath.append("/")
					   .append(org_id)
					   .append("/")
					   .append(getCurDateStr())
					   .append("/")
					   .append(ci_id)
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
	
	//参数格式：org_id=1212133;ci_id=3293932
	public static void main(String[] args) {
		AttTypeImp_CI af = new AttTypeImp_CI();
		System.out.println(af.generateStoreRulePath("org_id=1212133","ci_id=3293932"));
	}

	
}
