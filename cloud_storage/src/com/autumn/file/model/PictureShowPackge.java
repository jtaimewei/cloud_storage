package com.autumn.file.model;

import org.springframework.stereotype.Component;

@Component
public class PictureShowPackge {
	private String path;
	private FolderFile folderFile;
	public PictureShowPackge() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PictureShowPackge(String path, FolderFile folderFile) {
		super();
		this.path = path;
		this.folderFile = folderFile;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public FolderFile getFolderFile() {
		return folderFile;
	}
	public void setFolderFile(FolderFile folderFile) {
		this.folderFile = folderFile;
	}
	
	
}
