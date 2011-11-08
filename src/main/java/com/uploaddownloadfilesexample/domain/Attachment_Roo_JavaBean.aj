package com.uploaddownloadfilesexample.domain;

import java.lang.String;

privileged aspect Attachment_Roo_JavaBean {
    
    public String Attachment.getFileName() {
        return this.fileName;
    }
    
    public void Attachment.setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String Attachment.getExtension() {
        return this.extension;
    }
    
    public void Attachment.setExtension(String extension) {
        this.extension = extension;
    }
    
    public byte[] Attachment.getFiledata() {
        return this.filedata;
    }
    
    public void Attachment.setFiledata(byte[] filedata) {
        this.filedata = filedata;
    }
    
}
