
package com.codequest;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/runCode")
public class RunCodeServlet extends HttpServlet {

    private static final String API_URL =
            "https://api.onlinecompiler.io/api/run-code-sync/";

    private static final HttpClient CLIENT =
            HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(15))
                    .build();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String missionValue = request.getParameter("missionId");

        int missionId;

        try {
            missionId = Integer.parseInt(missionValue);
        } catch (Exception e) {
            response.sendRedirect("missions");
            return;
        }

        String code = request.getParameter("code");
        String language = request.getParameter("language");
        String programInput = request.getParameter("programInput");

        if (code == null || code.trim().isEmpty() ||
                language == null) {
            showMessage(request, response, missionId,
                    "Please select a language and enter your code.");
            return;
        }

        // Read API key from Tomcat environment variables.
        String apiKey = System.getenv("ONLINECOMPILER_API_KEY");

        if (apiKey == null || apiKey.trim().isEmpty()) {
            showMessage(request, response, missionId,
                    "API key not found. Check the Tomcat environment variable.");
            return;
        }

        // Select the OnlineCompiler compiler ID.
        String compiler;

        if ("JAVA".equalsIgnoreCase(language)) {
            compiler = "openjdk-25";
        } else if ("PYTHON".equalsIgnoreCase(language)) {
            compiler = "python-3.14";
        } else {
            showMessage(request, response, missionId,
                    "Unsupported programming language.");
            return;
        }

        try {
            // Prepare JSON request.
            JsonObject json = new JsonObject();

            json.addProperty("compiler", compiler);
            json.addProperty("code", code);
            json.addProperty(
                    "input",
                    programInput == null ? "" : programInput
            );
            json.addProperty("time_limit", 5);

            HttpRequest apiRequest = HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .timeout(Duration.ofSeconds(35))
                    .header("Authorization", apiKey)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(
                            json.toString()))
                    .build();

            // Send code to OnlineCompiler.
            HttpResponse<String> apiResponse =
                    CLIENT.send(
                            apiRequest,
                            HttpResponse.BodyHandlers.ofString()
                    );

            if (apiResponse.statusCode() < 200 ||
                    apiResponse.statusCode() >= 300) {

                showMessage(request, response, missionId,
                        "Compiler API request failed. HTTP status: "
                                + apiResponse.statusCode());
                return;
            }

            // Read compiler response.
            JsonObject result =
                    JsonParser.parseString(apiResponse.body())
                            .getAsJsonObject();

            String status = getJsonValue(result, "status");
            String output = getJsonValue(result, "output");
            String error = getJsonValue(result, "error");
            String exitCode = getJsonValue(result, "exit_code");

            StringBuilder message = new StringBuilder();

            if ("success".equalsIgnoreCase(status)) {
                message.append("Program executed successfully!\n\n");
            } else {
                message.append("Program execution failed.\n\n");
            }

            message.append("Output:\n");

            if (output.isEmpty()) {
                message.append("(No output)");
            } else {
                message.append(output);
            }

            if (!error.isEmpty()) {
                message.append("\n\nError:\n");
                message.append(error);
            }

            message.append("\n\nExit Code: ");
            message.append(exitCode);

            message.append("\n\nXP is not awarded yet. "
                    + "Mission test-case checking will be added next.");

            showMessage(request, response, missionId,
                    message.toString());

        } catch (InterruptedException e) {

            Thread.currentThread().interrupt();

            showMessage(request, response, missionId,
                    "Code execution was interrupted. Please try again.");

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to connect to OnlineCompiler API.", e);
        }
    }

    private String getJsonValue(JsonObject json, String key) {

        if (!json.has(key) || json.get(key).isJsonNull()) {
            return "";
        }

        return json.get(key).getAsString();
    }

    private void showMessage(HttpServletRequest request,
                             HttpServletResponse response,
                             int missionId,
                             String message)
            throws ServletException, IOException {

        request.setAttribute("message", message);

        request.getRequestDispatcher(
                "mission.jsp?id=" + missionId
        ).forward(request, response);
    }
}
