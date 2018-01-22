package com.autumn.file.operate;

import java.io.File;

import org.springframework.stereotype.Component;

@Component
public class RenameFolderOperate {
	public void rename(String path,String filename){
		File f = new File(path);
		String name[] = path.split("/");
		StringBuffer p = new StringBuffer();
		for(int i = 0;i<name.length-1;i++){
			p.append(name[i]+"/");
		}
		p.append(filename);
		System.out.println(p.toString());
		f.renameTo(new File(p.toString()));
	}
}
