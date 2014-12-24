package com.dcfs.common;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;


public class DateUtil {
	
	/**
	 * ���ݸ��������Լ���������ú��ӵľ������ڣ���ʽΪ��yyyy-MM-dd��
	 * @description 
	 * @author MaYun
	 * @date Nov 21, 2014
	 * @return
	 */
	public static String getEndDate(String fromDate,int days){
		String returnDate = "";
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = java.util.Calendar.getInstance();
		Date submitDate = new Date();
		try {
			submitDate = sdf.parse(fromDate);
			cal.setTime(submitDate);
			cal.add(Calendar.DATE, days);
			returnDate = sdf.format(cal.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return returnDate;
		
	}
	

}
