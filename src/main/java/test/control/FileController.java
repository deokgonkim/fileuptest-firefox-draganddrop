package test.control;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/file")
public class FileController {
    
    @RequestMapping("upload")
    public @ResponseBody String upload(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        if (! (request instanceof MultipartHttpServletRequest)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Expected multipart request");
            return null;
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        for ( String fileName : multipartRequest.getFileMap().keySet() ) {
            for ( MultipartFile file : multipartRequest.getFiles(fileName) ) {
                String originalFileName = file.getOriginalFilename();
                File destination = File.createTempFile("file", originalFileName, new File("/var/dgkim"));
            }
        }
        return "success";
    }
}
