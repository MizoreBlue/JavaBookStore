package com.mizore.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/uploads/*")
public class UploadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.isEmpty() || pathInfo.contains("..")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String uploadDir = getServletContext().getRealPath("/uploads");
        File file = new File(uploadDir, pathInfo);

        if (!file.exists() || file.isDirectory()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        Files.copy(file.toPath(), response.getOutputStream());
        response.getOutputStream().flush();
    }
}
