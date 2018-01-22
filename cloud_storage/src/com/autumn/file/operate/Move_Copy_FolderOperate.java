package com.autumn.file.operate;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Component;

@Component
public class Move_Copy_FolderOperate {
	
	public void moveTo(String oldPath,String newPath,String filename) throws IOException{//对文件重命名
		String name[] = oldPath.split("/");
		StringBuffer path = new StringBuffer();
		for(int i = 0;i<name.length-1;i++){
			path.append(name[i]+"/");
		}
		path.append(filename);
		move(path.toString(),newPath);
	}
	
	public void move(String oldPath,String newPath) throws IOException{
		File oldP = new File(oldPath);
		File newP = new File(newPath+File.separator+oldP.getName());  //将源文件的文件名或者文件夹名添加到该新文件下
		if(!newP.exists()&&!oldP.isFile()){ //如果这个新文件不存在这个目录，或者这个老文件不是文件夹，则创建这个目录
			newP.mkdirs();
		}
		if(oldP.isFile()){  //如果是一个文件
			newP.createNewFile();     //创建文件  利用字节流读取；
			FileInputStream in = new FileInputStream(oldP); 
			FileOutputStream out = new FileOutputStream(newP);
			byte[] b = new byte[1024];
			int len = 0 ;
			while((len = in.read(b))!=-1){
				out.write(b, 0, len);
			}
			out.flush();
			out.close();
			in.close();
			return;
		}
		File[] file = oldP.listFiles();
		if(file == null){
			return;
		}else{
			for(File f : file){
				move(oldP+File.separator+f.getName(),newP+"");  //递归调用。
			}
		}
	}
}
