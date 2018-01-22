package com.autumn.commons;

import java.util.Random;

public class RandomCode {
	
	public static String randomHexString(int len)  {  
        try {  
            StringBuffer result = new StringBuffer();  
            for(int i=0;i<len;i++) {  
                result.append(Integer.toHexString(new Random().nextInt(16)));  
            }  
            return result.toString().toUpperCase();  
              
        } catch (Exception e) {  
            // TODO: handle exception  
            e.printStackTrace();  
              
        }  
        return null;  
          
    }
	

}
