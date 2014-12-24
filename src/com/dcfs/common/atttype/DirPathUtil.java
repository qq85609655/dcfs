/**   
 * @Title: DirPathUtil.java 
 * @Package com.dcfs.common.atttype 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn   
 * @date 2014-7-23 ����5:51:21 
 * @version V1.0   
 */
package com.dcfs.common.atttype;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.hx.upload.datasource.DiskpathManager;

/** 
 * @ClassName: DirPathUtil 
 * @Description: �����ļ��洢·�������� 
 * @author songhn
 * @date 2014-7-23 ����5:51:21 
 *  
 */
public class DirPathUtil {

	//���������̴洢�ļ�·��
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
	 * @Description: ϵͳ��ʱ�ļ��洢·��
	 * @author: songhn
	 * @param parameters            ��ʽ��busclassid=1;busid=2
	 * @return    �趨�ļ� 
	 * @return String    �������� 
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
	 * @Description: ����ģ���ļ��洢·��             busclassid=1
	 * @author: songhn              
	 * @param parameter
	 * @return    �趨�ļ� 
	 * @return String    �������� 
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
	 * @Description: ��ȡ��ǰ���ڵĸ�ʽ���ַ��� {YYYY}_{MM}_{DD}
	 * @author: songhn
	 * @return    �趨�ļ� 
	 * @return String    �������� 
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
	 * @Description: TODO(������һ�仰�����������������)
	 * @author: songhn
	 * @param args    �趨�ļ� 
	 * @return void    �������� 
	 * @throws 
	 */
	public static void main(String[] args) {
		
		System.out.println(createTmpFileDir("busclassid=1;busid=2"));
		System.out.println(createModFileDir("busclassid=1"));

	}

}
