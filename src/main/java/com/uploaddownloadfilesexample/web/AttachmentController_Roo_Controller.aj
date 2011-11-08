package com.uploaddownloadfilesexample.web;

import com.uploaddownloadfilesexample.domain.Attachment;
import java.lang.Long;
import java.lang.String;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect AttachmentController_Roo_Controller {
    
    @RequestMapping(value = "/attachment/form", method = RequestMethod.GET)
    public String AttachmentController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("attachment", new Attachment());
        return "attachment/create";
    }
    
    @RequestMapping(value = "/attachment/{id}", method = RequestMethod.GET)
    public String AttachmentController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("attachment", Attachment.findAttachment(id));
        return "attachment/show";
    }
    
    @RequestMapping(value = "/attachment", method = RequestMethod.GET)
    public String AttachmentController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("attachments", Attachment.findAttachmentEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Attachment.countAttachments() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("attachments", Attachment.findAllAttachments());
        }
        return "attachment/list";
    }
    
    @RequestMapping(value = "/attachment/{id}/form", method = RequestMethod.GET)
    public String AttachmentController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("attachment", Attachment.findAttachment(id));
        return "attachment/update";
    }
    
    @RequestMapping(value = "/attachment/{id}", method = RequestMethod.DELETE)
    public String AttachmentController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Attachment.findAttachment(id).remove();
        return "redirect:/attachment?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
