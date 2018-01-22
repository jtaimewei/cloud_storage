package com.autumn.file.operate;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Component;
@Component
public class AddFolderOperate {
	public  void creat(String url){
		File file = new File(url);
		file.mkdirs();
		/*if(file.isDirectory()){   //判断file是否是文件夹
			if(!file.getParentFile().exists()){   //判断是否存在此目录
				file.mkdirs();
			}else{
				System.out.println("此文件目录已存在！");
			}
		}else{
			if(!file.getParentFile().exists()){
				try {
					file.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else{
				System.out.println("此文件已存在！");
			}
		}*/
	}
}
