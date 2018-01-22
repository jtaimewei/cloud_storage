package com.autumn.file.model;

import java.util.Date;

import org.springframework.stereotype.Component;
@Component
public class FolderFile {
	private int subfolderid;       /*文件id*/
	private int folderid;         /* 文件根文件id*/
	private String subfolderfolder; /*文件夹名*/
	private String subfolderfile;	/*文件名*/
	private int subfoldersize;	/*文件大小*/
	private Date subfolderdate;	/*文件更改日期*/
	private int subfolderfather;/*父级目录*/
	private int subfolderflag;/*删除与否*/
	
	public int getFolderid() {
		return folderid;
	}
	public void setFolderid(int folderid) {
		this.folderid = folderid;
	}
	public int getSubfolderid() {
		return subfolderid;
	}
	public void setSubfolderid(int subfolderid) {
		this.subfolderid = subfolderid;
	}
	public String getSubfolderfolder() {
		return subfolderfolder;
	}
	public void setSubfolderfolder(String subfolderfolder) {
		this.subfolderfolder = subfolderfolder;
	}
	public String getSubfolderfile() {
		return subfolderfile;
	}
	public void setSubfolderfile(String subfolderfile) {
		this.subfolderfile = subfolderfile;
	}
	public int getSubfoldersize() {
		return subfoldersize;
	}
	public void setSubfoldersize(int subfoldersize) {
		this.subfoldersize = subfoldersize;
	}
	public Date getSubfolderdate() {
		return subfolderdate;
	}
	public void setSubfolderdate(Date subfolderdate) {
		this.subfolderdate = subfolderdate;
	}
	public int getSubfolderfather() {
		return subfolderfather;
	}
	public void setSubfolderfather(int subfolderfather) {
		this.subfolderfather = subfolderfather;
	}
	public int getSubfolderflag() {
		return subfolderflag;
	}
	public void setSubfolderflag(int subfolderflag) {
		this.subfolderflag = subfolderflag;
	}
	
	
	
}
