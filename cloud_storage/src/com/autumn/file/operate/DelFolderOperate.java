package com.autumn.file.operate;

import java.io.File;

import org.springframework.stereotype.Component;
@Component
public class DelFolderOperate {
	public void delete(String path){
		File file = new File(path);
		deleteAllFilesOfDir(file);
	}
	public  void deleteAllFilesOfDir(File path) {  
	    if (!path.exists()) {
	    	System.out.println("文件不存在");
	    	return;
	    }
	    if (path.isFile()) {  
	        path.delete();  
	        return;  
	    }  
	    File[] files = path.listFiles();  
	    for (int i = 0; i < files.length; i++) {  
	        deleteAllFilesOfDir(files[i]);  
	    }  
	    path.delete();  
	}
}
