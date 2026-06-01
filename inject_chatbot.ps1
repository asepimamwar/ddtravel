$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

$chatbotHtml = @"
    <!-- Asisten Web Chatbot -->
    <div id="dd-chatbot-container">
        <!-- Floating Button -->
        <div id="dd-chatbot-button" onclick="toggleChat()">
            <i class="fas fa-comment-dots"></i>
        </div>
        
        <!-- Chat Window -->
        <div id="dd-chatbot-window">
            <div class="dd-chatbot-header">
                <div>
                    <strong>Asisten DD Travel</strong>
                    <span class="online-status">● Online</span>
                </div>
                <button class="close-btn" onclick="toggleChat()">&times;</button>
            </div>
            <div class="dd-chatbot-messages" id="dd-chatbot-messages">
                <!-- Messages will be appended here via JS -->
            </div>
        </div>
    </div>
    
    <!-- Chatbot Script -->
    <script src="assets/js/chatbot.js"></script>
</body>
"@

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Remove the floating-wa WhatsApp button
    $content = $content -replace '(?s)<!-- WhatsApp Floating Button -->\s*<a href="https://wa\.me/[^>]*class="floating-wa"[^>]*>.*?</a>\s*', ''
    
    # Inject chatbot if not already present
    if ($content -notmatch 'id="dd-chatbot-container"') {
        $content = $content -replace '</body>', $chatbotHtml
    }

    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "Updated $($file.FullName)"
}

$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content $cssFile -Raw
    
    # Remove the old floating-wa CSS
    $cssContent = $cssContent -replace '(?s)/\* WhatsApp Floating Assistant \*/.*?@keyframes pulse-wa \{.*?\}', ''
    
    $cssChatbot = @"

/* DD Chatbot CSS */
#dd-chatbot-container {
    position: fixed;
    bottom: 30px;
    left: 30px;
    z-index: 9999;
    font-family: inherit;
}

#dd-chatbot-button {
    width: 60px;
    height: 60px;
    background-color: #056965;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
    animation: pulse-bot 2s infinite;
}

#dd-chatbot-button:hover {
    transform: scale(1.05);
}

#dd-chatbot-window {
    display: none;
    position: absolute;
    bottom: 80px;
    left: 0;
    width: 320px;
    height: 450px;
    background-color: #f0f2f5;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    overflow: hidden;
    flex-direction: column;
}

.dd-chatbot-header {
    background-color: #056965;
    color: white;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.dd-chatbot-header strong {
    display: block;
    font-size: 16px;
    margin-bottom: 2px;
}

.dd-chatbot-header .online-status {
    font-size: 12px;
    color: #4CAF50;
    font-weight: 500;
}

.dd-chatbot-header .close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 26px;
    cursor: pointer;
    padding: 0;
    line-height: 1;
}

.dd-chatbot-messages {
    flex: 1;
    padding: 15px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.chat-msg {
    max-width: 85%;
    padding: 10px 14px;
    border-radius: 8px;
    font-size: 14px;
    line-height: 1.4;
    word-wrap: break-word;
}

.chat-msg.bot {
    background-color: #fff;
    color: #333;
    align-self: flex-start;
    border-bottom-left-radius: 2px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

.chat-msg.user {
    background-color: #dcf8c6;
    color: #333;
    align-self: flex-end;
    border-bottom-right-radius: 2px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

.chat-options {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-top: 5px;
}

.chat-btn {
    background-color: #fff;
    border: 1px solid #056965;
    color: #056965;
    padding: 8px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    text-align: left;
    transition: all 0.2s;
    font-family: inherit;
}

.chat-btn:hover {
    background-color: #056965;
    color: white;
}

.chat-btn.wa-btn {
    background-color: #25d366;
    color: white;
    border-color: #25d366;
    text-align: center;
    font-weight: bold;
    display: block;
    text-decoration: none;
    margin-top: 5px;
}
.chat-btn.wa-btn:hover {
    background-color: #128C7E;
    color: white;
}
@keyframes pulse-bot {
    0% { box-shadow: 0 0 0 0 rgba(5, 105, 101, 0.5); }
    70% { box-shadow: 0 0 0 15px rgba(5, 105, 101, 0); }
    100% { box-shadow: 0 0 0 0 rgba(5, 105, 101, 0); }
}
"@
    
    if ($cssContent -notmatch '#dd-chatbot-container') {
        Add-Content -Path $cssFile -Value $cssChatbot
        Write-Host "Injected CSS into $cssFile"
    }
}
