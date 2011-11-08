package com.uploaddownloadfilesexample.domain;

import java.lang.String;

privileged aspect Attachment_Roo_ToString {
    
    public String Attachment.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("FileName: ").append(getFileName()).append(", ");
        sb.append("Extension: ").append(getExtension()).append(", ");
        sb.append("Filedata: ").append(java.util.Arrays.toString(getFiledata()));
        return sb.toString();
    }
    
}
