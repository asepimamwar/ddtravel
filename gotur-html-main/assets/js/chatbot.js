let chatOpen = false;
let greeted = false;

function toggleChat() {
    const window = document.getElementById('dd-chatbot-window');
    const button = document.getElementById('dd-chatbot-button');
    chatOpen = !chatOpen;
    window.style.display = chatOpen ? 'flex' : 'none';
    
    // Change button icon when open
    if (chatOpen) {
        button.innerHTML = '<i class="fas fa-times"></i> <span>Tutup</span>';
        button.style.animation = 'none';
    } else {
        button.innerHTML = '<i class="fas fa-headset"></i> <span>Asisten DD Travel</span>';
    }
    
    if (chatOpen && !greeted) {
        greeted = true;
        setTimeout(() => {
            appendMessage('bot', 'Halo! Selamat datang di DD Travel. Silakan pilih informasi yang Anda butuhkan:', [
                { id: 'umrah', text: '🕋 Paket Umrah' },
                { id: 'wisata', text: '🏖️ Paket Wisata' },
                { id: 'ticketing', text: '🎫 Ticketing & Lainnya' },
                { id: 'admin', text: '💬 Hubungi Admin' }
            ]);
        }, 500);
    }
}

function appendMessage(sender, text, options = null) {
    const msgContainer = document.getElementById('dd-chatbot-messages');
    
    const msgDiv = document.createElement('div');
    msgDiv.className = 'chat-msg ' + sender;
    msgDiv.innerHTML = text;
    msgContainer.appendChild(msgDiv);
    
    if (options) {
        const optionsDiv = document.createElement('div');
        optionsDiv.className = 'chat-options';
        
        options.forEach(opt => {
            const btn = document.createElement('button');
            btn.className = 'chat-btn';
            btn.innerText = opt.text;
            btn.onclick = () => handleOption(opt.id, opt.text, optionsDiv);
            optionsDiv.appendChild(btn);
        });
        msgContainer.appendChild(optionsDiv);
    }
    
    // Scroll to bottom
    msgContainer.scrollTop = msgContainer.scrollHeight;
}

function handleOption(id, userText, optionsDivElement) {
    // Hide previous options
    if (optionsDivElement) {
        optionsDivElement.style.display = 'none';
    }
    
    // Show user message
    appendMessage('user', userText);
    
    // Bot responds
    setTimeout(() => {
        let response = '';
        if (id === 'umrah') {
            response = 'Kami menyediakan berbagai paket Umrah Reguler, Plus, dan Haji Khusus dengan pelayanan terbaik. Untuk detail harga dan jadwal, silakan ngobrol dengan Icha.';
        } else if (id === 'wisata') {
            response = 'Kami melayani Paket Wisata Halal Domestik maupun Internasional dengan destinasi menarik. Mari rencanakan liburan Anda bersama kami!';
        } else if (id === 'ticketing') {
            response = 'Butuh tiket pesawat, kereta api, atau voucher hotel? Kami siap membantu keperluan perjalanan Anda dengan harga kompetitif.';
        } else {
            response = 'Baik, saya akan menghubungkan Anda dengan Icha untuk bantuan lebih lanjut.';
        }
        
        // Show response with WA button
        appendWAButton(response, id);
    }, 800);
}

function appendWAButton(text, topicId) {
    const msgContainer = document.getElementById('dd-chatbot-messages');
    
    const msgDiv = document.createElement('div');
    msgDiv.className = 'chat-msg bot';
    msgDiv.innerHTML = text;
    msgContainer.appendChild(msgDiv);
    
    // Encode topic for WA text
    let topicName = topicId === 'umrah' ? 'Paket Umrah' : 
                    topicId === 'wisata' ? 'Paket Wisata' : 
                    topicId === 'ticketing' ? 'Ticketing' : 'Layanan DD Travel';
    let waText = encodeURIComponent(`Halo DD Travel, saya ingin bertanya lebih lanjut tentang ${topicName}...`);
    
    const waDiv = document.createElement('div');
    waDiv.className = 'chat-options';
    waDiv.innerHTML = `<a href="https://wa.me/62811133446?text=${waText}" target="_blank" class="chat-btn wa-btn"><i class="fab fa-whatsapp"></i> Lanjut ke WhatsApp</a>`;
    msgContainer.appendChild(waDiv);
    
    msgContainer.scrollTop = msgContainer.scrollHeight;
}
