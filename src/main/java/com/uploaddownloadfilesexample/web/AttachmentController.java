package com.uploaddownloadfilesexample.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import com.uploaddownloadfilesexample.domain.Attachment;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.stereotype.Controller;

//Cambiamos el valor del par‡metro automaticallyMaintainView a false
//Change the value of parameter automaticallyMaintainView to false
@RooWebScaffold(path = "attachment", automaticallyMaintainView = false, formBackingObject = Attachment.class)
@RequestMapping("/attachment/**")
@Controller
public class AttachmentController {
	
	@InitBinder
    public void initBinder(WebDataBinder binder)
    {
        binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
    }
	
	@RequestMapping(value = "/attachment", method = RequestMethod.POST)
    public String create(
    		@Valid Attachment attachment, 
    		BindingResult result,
    		//Se agrega el par‡metro request
    		//Add the request parameter
    		MultipartHttpServletRequest request,
    		ModelMap modelMap) {
        if (attachment == null) throw new IllegalArgumentException("A attachment is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("attachment", attachment);
            return "attachment/create";
        }
        
        //Se obtiene el nombre original del archivo proveniente del request, haciendo un split del nombre original del archivo
        //Get the original filename from the request, applying a split function
        String originalFilename = request.getFile("filedata").getOriginalFilename();
        String[] originalFileNameArray = originalFilename.split("\\.");
        
        //Seteamos el nombre del archivo al atributo FileName
        //Set the fileName attribute 
        attachment.setFileName(originalFileNameArray[0]);
        
        //Seteamos la extensi—n del archivo al atributo extension
        //Set the extension attribute
        attachment.setExtension(originalFileNameArray[1]);
        
        attachment.persist();
        return "redirect:/attachment/" + attachment.getId();
    }
	
	@RequestMapping(method = RequestMethod.POST)
    public String update(
    		@Valid Attachment attachment, 
    		BindingResult result,
    		//Se agrega el par‡metro request
    		//Add the request parameter
    		MultipartHttpServletRequest request,
    		ModelMap modelMap) {
        if (attachment == null) throw new IllegalArgumentException("A attachment is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("attachment", attachment);
            return "attachment/update";
        }
        
        //Se obtiene el nombre original del archivo proveniente del request, haciendo un split del nombre original del archivo
        //Get the original filename from the request, applying a split function
        String originalFilename = request.getFile("filedata").getOriginalFilename();
        String[] originalFileNameArray = originalFilename.split("\\.");
        
        //Seteamos el nombre del archivo al atributo FileName
        //Set the fileName attribute 
        attachment.setFileName(originalFileNameArray[0]);
        
        //Seteamos la extensi—n del archivo al atributo extension
        //Set the extension attribute
        attachment.setExtension(originalFileNameArray[1]);
        
        attachment.merge();
        return "redirect:/attachment/" + attachment.getId();
    }
	
	@RequestMapping(value = "/attachment/render/{id}", method = RequestMethod.GET)
    public void render(
            ModelMap modelMap,
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable("id") Long id)
    {
        Attachment attachment = Attachment.findAttachment(id);
        try
        {
            response.setContentType("");
            response.setHeader("Content-Disposition","attachment; filename="+ attachment.getFileName() + "."+ attachment.getExtension());
            response.getOutputStream().write(attachment.getFiledata());
        } catch (IOException e) {
        	
        }
    }
}
