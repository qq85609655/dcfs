/**   
 * @Title: DirPathUtil.java 
 * @Package com.dcfs.common.atttype 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn   
 * @date 2014-7-23 下午5:51:21 
 * @version V1.0   
 */
package com.dcfs.common.atttype;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.hx.upload.datasource.DiskpathManager;

/** 
 * @ClassName: DirPathUtil 
 * @Description: 创建文件存储路径工具类 
 * @author songhn
 * @date 2014-7-23 下午5:51:21 
 *  
 */
public class DirPathUtil {

	//服务器磁盘存储文件路径
	private static String diskFilePath = "";
	
	static{
		
//		diskFilePath = "D:/ATT/";
		
		diskFilePath = DiskpathManager.getDiskPath();
		
	}
	
	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public DirPathUtil() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @Title: createTmpFileDir 
	 * @Description: 系统临时文件存储路径
	 * @author: songhn
	 * @param parameters            格式：busclassid=1;busid=2
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public static String createTmpFileDir(String parameter){
		
		if(null != parameter){
			
			String[] parameters = parameter.split(";"); 
			
			if(null != parameters && parameters.length > 0){
				
				String modclassid = parameters[0];
				
				String modid = parameters[1];
				
				StringBuffer serverDirPath = new StringBuffer(diskFilePath + "ATT_TMP/");
				
				serverDirPath.append(getCurDateStr()).append("/");
				
				serverDirPath.append(modclassid.split("=")[1]).append("/");
				
				serverDirPath.append(modid.split("=")[1]).append("/");
				
				File file = new File(serverDirPath.toString());
				
				if(!file.exists() || !file.isDirectory()){
					
					file.mkdirs();
					
				}
				
				return serverDirPath.toString();
				
			}
			
		}
		
		return null;
		
	}
	
	/**
	 * @Title: createModFileDir 
	 * @Description: 创建模板文件存储路径             busclassid=1
	 * @author: songhn              
	 * @param parameter
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public static String createModFileDir(String parameter){
		
		if(null != parameter){
			
			StringBuffer serverDirPath = new StringBuffer(diskFilePath + "ATT_MOD/");
				
			serverDirPath.append(parameter.split("=")[1]).append("/");
				
			File file = new File(serverDirPath.toString());
				
			if(!file.exists() || !file.isDirectory()){
				
				file.mkdirs();
				
			}
			
			return serverDirPath.toString();
				
		}
		
		return null;
		
	}
	
	/**
	 * @Title: getCurDateStr 
	 * @Description: 获取当前日期的格式化字符串 {YYYY}_{MM}_{DD}
	 * @author: songhn
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	private static String getCurDateStr(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd");
		
		Date curDate = new Date();
		
		String str = sdf.format(curDate);
		
		return str;
		
	}
	
	/** 
	 * @Title: main 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @author: songhn
	 * @param args    设定文件 
	 * @return void    返回类型 
	 * @throws 
	 */
	public static void main(String[] args) {
		
		System.out.println(createTmpFileDir("busclassid=1;busid=2"));
		System.out.println(createModFileDir("busclassid=1"));

	}

}
