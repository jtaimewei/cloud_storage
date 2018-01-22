package com.autumn.commons;

import java.util.UUID;

public class UUIDUtils {
	
	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}

}
