package com.uploaddownloadfilesexample.domain;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@Entity
@RooJavaBean
@RooToString
@RooEntity
public class Attachment {

    private String fileName;
    
    private String extension;
    
    @Lob
    @Column(length = 104857600)
    @Basic(fetch = FetchType.LAZY)
    private byte[] filedata;
}
