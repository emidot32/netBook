package com.example.netbooks.controllers;

import com.example.netbooks.exceptions.CustomException;
import com.example.netbooks.exceptions.DownloadFileException;
import com.example.netbooks.exceptions.UploadFileException;
import com.example.netbooks.services.FileStorageService;
import com.google.common.base.Strings;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@RestController
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@RequestMapping(value = "/files")
@Slf4j
public class FilesController {
    private FileStorageService fileStorageService;

    @Autowired
    public FilesController(FileStorageService fileStorageService) {
        log.info("Class initialized");
        this.fileStorageService = fileStorageService;
    }

    @PostMapping("/upload")
    public void uploadFile(@RequestParam("file") MultipartFile file, @RequestParam("name") String name){
        log.info("POST /upload/{} by {}", name, getCurrentUserLogin());
        fileStorageService.saveFile(file, name);
    }

    @GetMapping("/download")
    public ResponseEntity<Resource> getFile(@RequestParam("filename")
                                                    String filename){
        if("null".equals(filename) || "undefined".equals(filename)) return null;
        Resource file = fileStorageService.loadFile(filename);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
                .body(file);
    }

    @DeleteMapping("/remove/{filename}")
    public void removeFile(@PathVariable("filename") String filename){
        log.info("DELETE /remove/{} by {}", filename, getCurrentUserLogin());
        fileStorageService.deleteFile(filename);
    }
    private String getCurrentUserLogin(){
        return ((UserDetails) SecurityContextHolder.getContext().
                getAuthentication().getPrincipal()).getUsername();
    }
}
