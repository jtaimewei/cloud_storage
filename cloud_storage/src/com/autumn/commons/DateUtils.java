package com.autumn.commons;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/** 
 * @author  JTAIME
 * @date 2017年8月31日 下午4:18:21 
 * @version 1.0 
 * @parameter  
 * @since
 */
public class DateUtils {
	
	public static Date getDATE(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date=null;
		try {
			date = df.parse(df.format(new Date()));
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		return date;
	}

}
