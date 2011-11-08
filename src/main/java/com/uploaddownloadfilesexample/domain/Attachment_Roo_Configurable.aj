package com.uploaddownloadfilesexample.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Attachment_Roo_Configurable {
    
    declare @type: Attachment: @Configurable;
    
}
