package com.codequest;

import java.io.File;
import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

/** Starts the web application with the embedded Tomcat runtime. */
public final class CodeQuestServer {
    private CodeQuestServer() { }

    public static void main(String[] args) throws Exception {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));
        File webRoot = new File("src/main/webapp").getAbsoluteFile();
        if (!new File(webRoot, "index.jsp").isFile()) {
            throw new IllegalStateException("Web app not found at " + webRoot);
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.setBaseDir(new File(System.getProperty("java.io.tmpdir"), "codequest-tomcat").getAbsolutePath());
        tomcat.getConnector();

        Context context = tomcat.addWebapp("", webRoot.getPath());
        context.setParentClassLoader(CodeQuestServer.class.getClassLoader());
        context.setReloadable(false);

        tomcat.start();
        System.out.println("CodeQuest is running at http://localhost:" + port + "/");
        tomcat.getServer().await();
    }
}
