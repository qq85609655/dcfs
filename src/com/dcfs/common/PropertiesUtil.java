package com.dcfs.common;

import hx.log.Log;
import hx.log.UtilLog;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Properties;


/**
 * @Title: PropertiesUtil.java
 * @Description:Properties文件读取类
 * @Company: 21softech
 * @Created on 2014-10-31
 * @author mayun
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PropertiesUtil {
    
 private static Log log=UtilLog.getLog(PropertiesUtil.class);
 
 String url = this.getClass().getResource("/").getPath();
 
 
  //根据key读取value
    public  String readValue(String fileName,String key) {
     Properties props = new Properties();
           try {
        	   InputStream in = new BufferedInputStream (new FileInputStream(url+fileName));
        	   props.load(in);
        	   String value = props.getProperty (key);
               //System.out.println("key="+key+",Value="+value);
               return value;
           } catch (Exception e) {
            e.printStackTrace();
            return null;
           }
    }
    
    //读取properties的全部信息
      public  void readProperties(String fileName) {
        Properties props = new Properties();
           try {
            InputStream in = new BufferedInputStream (new FileInputStream(url+fileName));
            props.load(in);
               Enumeration en = props.propertyNames();
                while (en.hasMoreElements()) {
                 String key = (String) en.nextElement();
                       String Property = props.getProperty (key);
                       System.out.println(key+Property);
                   }
           } catch (Exception e) {
            e.printStackTrace();
           }
       }

      //写入properties信息
      public  void writeProperties(String fileName,String parameterName,String parameterValue) {
        Properties prop = new Properties();
        try {
         InputStream fis = new FileInputStream(url+fileName);
               //从输入流中读取属性列表（键和元素对）
              prop.load(fis);
               //调用 Hashtable 的方法 put。使用 getProperty 方法提供并行性。
              //强制要求为属性的键和值使用字符串。返回值是 Hashtable 调用 put 的结果。
              OutputStream fos = new FileOutputStream(fileName);
               prop.setProperty(parameterName, parameterValue);
               //以适合使用 load 方法加载到 Properties 表中的格式，
              //将此 Properties 表中的属性列表（键和元素对）写入输出流
              prop.store(fos, "Update '" + parameterName + "' value");
           } catch (IOException e) {
            System.err.println("Visit "+fileName+" for updating "+parameterName+" value error");
           }
       }

      public static void main(String[] args) {
        //readValue("D:/newworkspace/dcfs/src/filemodifyhistorycodename-config.properties","IS_ALERT");
          // writeProperties("info.properties","age","21");
           //readProperties("info.properties" );
           //System.out.println("OK");
       }

    
}
