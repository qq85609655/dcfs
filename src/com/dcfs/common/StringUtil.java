package com.dcfs.common;

import java.util.Vector;


public class StringUtil {
	
	/**
	 * 把类似a,b,c字符串转换成在sql里能执行的字符串'a','b','c'
	 * @description 
	 * @author MaYun
	 * @date Sep 28, 2014
	 * @param String a,b,c
	 * @return String 'a','b','c'
	 */
	public static String convertSqlString(String oldStr){
		String newStr = "";
		if("".equals(oldStr)||null==oldStr){
			return newStr;
		}else{
			String [] oldStrArray = oldStr.split(",");
			for(int i=0;i<oldStrArray.length;i++){
				if(i==0){
					newStr="'"+oldStrArray[i]+"'";
				}else{
					newStr+=","+"'"+oldStrArray[i]+"'";
				}
			}
			return newStr;
		}
	}
	
	/**
	 * 根据指定的过滤字符串将原字符串里相同的字符串过滤掉
	 * @description 
	 * @author MaYun
	 * @param Stirng oldString 原字符串，格式为 a,b,c,d,e
	 * @param String filterString 过滤字符串，格式为 a,b,c
	 * @date Sep 29, 2014
	 * @return
	 */
	public static String filterSameString(String oldString,String filterString){
		String returnString = "";
		
		String []totalArray = oldString.split(",");
		String []removeArray = filterString.split(",");
		
		Vector totalVector= new Vector<String>();
		for(int i=0;i<totalArray.length;i++){
			totalVector.add(i, totalArray[i]);
		}
		
		for(int k=0;k<removeArray.length;k++){
			String temp = removeArray[k];
			for(int j=0;j<totalVector.size();j++){
				if(temp.equals(totalVector.get(j))){
					totalVector.remove(j);
					break;
				}
			}
		}
		
		for (int y=0;y<totalVector.size();y++){
			if(y==0){
				returnString = (String)totalVector.get(y);
			}else{
				returnString+=","+totalVector.get(y);
			}
		}
		
		
		return returnString;
	}
	
	
	public static void main(String[] args){
		StringUtil.convertSqlString("a,b,c,d");
	}

}
