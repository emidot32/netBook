package com.example.netbooks.services;

import com.example.netbooks.exceptions.DownloadFileException;
import com.example.netbooks.exceptions.UploadFileException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
@Slf4j
public class FileStorageService {
    private final Path rootLocation = Paths.get("files");

    public void saveFile(MultipartFile file, String name) {
        try{
            Files.copy(file.getInputStream(), this.rootLocation.resolve(name));
            log.info("Successful upload file");
        }catch (Exception e){
            throw new UploadFileException("Fail to upload image - " + name);
        }
    }

    public void copyFile(String name, String newName) throws IOException {
        Path file = rootLocation.resolve(name);
        Path newFile = rootLocation.resolve(newName);
        Files.copy(file, newFile);
    }

    public void deleteFile(String filename) {
        try{
            FileSystemUtils.deleteRecursively(rootLocation.resolve(filename).toFile());
            log.info("Successful remove image");
        }catch (Exception e){
            throw new DownloadFileException("Fail to remove image - " + filename);
        }
    }

    public Resource loadFile(String filename) {
        try {
            Path file = rootLocation.resolve(filename);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            } else {
                throw new DownloadFileException("Fail to download image - " + filename);
            }
        } catch (MalformedURLException e) {
            throw new DownloadFileException("[MalformedURLException] Fail to download image" + filename);
        }
    }
}
