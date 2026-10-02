<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>CheckOffers</title>
    <!-- Официальная библиотека Telegram Mini Apps -->
    <script src="https://telegram.org"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            height: 100vh;
            box-sizing: border-box;
            user-select: none;
            -webkit-user-select: none;
        }

        .content {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            width: 100%;
            margin-top: auto;
            margin-bottom: auto;
            padding: 0 36px;
            box-sizing: border-box;
        }

        .logos {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            margin-bottom: 24px;
        }

        .logo-tg {
            width: 72px;
            height: 72px;
            background-color: #24A1DE;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 2;
        }

        .logo-tg svg {
            width: 40px;
            height: 40px;
            fill: white;
            margin-left: -3px;
        }

        /* Оранжевая зона: контейнер для логотипа проекта */
        .logo-app {
            width: 72px;
            height: 72px;
            background-color: #1a1a1a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-left: -12px;
            z-index: 1;
            overflow: hidden;
            box-shadow: -2px 0 8px rgba(0,0,0,0.1);
        }

        .logo-app img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        h1 {
            font-size: 21px;
            font-weight: 700;
            color: #000000;
            margin: 0 0 10px 0;
        }

        .subtitle {
            font-size: 15px;
            color: #222222;
            line-height: 20px;
            margin: 0 0 36px 0;
            max-width: 300px;
        }

        /* Общий блок-селектор */
        .account-selector {
            background-color: #f1f5f9;
            border-radius: 20px;
            width: 100%;
            max-width: 320px;
            box-sizing: border-box;
            padding: 4px 0;
            margin-bottom: 12px;
        }

        /* Черная зона: строка пользователя */
        .user-row {
            display: flex;
            align-items: center;
            padding: 14px 18px;
            cursor: pointer;
        }

        .avatar {
            width: 38px;
            height: 38px;
            background-color: #24A1DE;
            border-radius: 50%;
            color: white;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            margin-right: 14px;
            overflow: hidden;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-name {
            font-size: 16px;
            font-weight: 500;
            color: #000000;
            flex-grow: 1;
            text-align: left;
        }

        /* Синяя точка выбора */
        .radio-dot {
            width: 18px;
            height: 18px;
            border: 2px solid #24A1DE;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-sizing: border-box;
        }

        .radio-dot::after {
            content: "";
            width: 10px;
            height: 10px;
            background-color: #24A1DE;
            border-radius: 50%;
        }

        .divider {
            height: 1px;
            background-color: #e2e8f0;
            margin: 0 18px;
        }

        /* Кнопка смены аккаунта */
        .switch-row {
            display: flex;
            align-items: center;
            padding: 14px 18px;
            cursor: pointer;
            color: #1d93d2;
            font-size: 15px;
            font-weight: 400;
        }

        .switch-icon {
            width: 22px;
            height: 22px;
            border: 2px solid #1d93d2;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 14px;
            font-size: 16px;
            font-weight: 500;
            box-sizing: border-box;
            line-height: 1;
        }

        .actions {
            width: 100%;
            padding: 16px 24px 48px 24px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }

        .btn-submit {
            width: 100%;
            max-width: 320px;
            background-color: #24A1DE;
            color: #ffffff;
            border: none;
            border-radius: 18px;
            padding: 15px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            text-align: center;
            box-sizing: border-box;
        }

        .btn-submit:active {
            background-color: #1d82b3;
        }

        .link-phone {
            color: #1d93d2;
            font-size: 14px;
            text-decoration: none;
            font-weight: 400;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <div class="content">
        <!-- Логотипы в центре -->
        <div class="logos">
            <div class="logo-tg">
                <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm4.64 6.8c-.15 1.58-.8 5.42-1.13 7.19-.14.75-.42 1-.68 1.03-.58.05-1.02-.38-1.58-.75-.88-.58-1.38-.94-2.23-1.5-1-.65-.35-1.01.22-1.59.15-.15 2.71-2.48 2.76-2.69.01-.03.01-.14-.07-.2-.08-.06-.19-.04-.27-.02-.12.02-1.96 1.24-5.54 3.65-.52.36-1 .53-1.42.52-.47-.01-1.37-.26-2.03-.48-.82-.27-1.47-.42-1.42-.88.03-.24.35-.49.97-.74 3.79-1.65 6.32-2.73 7.57-3.26 3.6-1.53 4.35-1.8 4.84-1.8.11 0 .35.03.5.16.13.12.17.28.18.4z"/></svg>
            </div>
            <!-- Оранжевая зона: Замените ССЫЛКА_НА_ВАШЕ_ФОТО на картинку вашего проекта -->
            <div class="logo-app">
                <img src="ССЫЛКА_НА_ВАШЕ_ФОТО" alt="App Logo" onerror="this.style.display='none'">
            </div>
        </div>

        <h1>Вход через Telegram</h1>
        <div class="subtitle">Сайту будут известны Ваше имя, публичная ссылка и фотография</div>

        <!-- Селектор выбора аккаунта -->
        <div class="account-selector">
            <!-- Черная зона: текущий пользователь -->
            <div class="user-row" id="block-user">
                <div class="avatar" id="user-avatar">?</div>
                <div class="user-name" id="user-display-name">Загрузка...</div>
                <div class="radio-dot"></div>
            </div>
            
            <div class="divider"></div>
            
            <!-- Кнопка смены аккаунта -->
            <div class="switch-row" id="btn-switch-account">
                <div class="switch-icon">+</div>
                <div>Войти в другой аккаунт</div>
            </div>
        </div>
    </div>

    <!-- Кнопки внизу -->
    <div class="actions">
        <button class="btn-submit" id="btn-continue">Продолжить через Telegram</button>
        <div class="link-phone" id="btn-login-phone">Или войти по номеру телефона</div>
    </div>

    <script>
        // Заглушка для сборщика Acode
        window['onTelegramAuth'] = function(...args) { };

        const tg = window.Telegram.WebApp;
        tg.ready();
        tg.expand(); 
        tg.setHeaderColor('#ffffff'); 

        const initDataUnsafe = tg.initDataUnsafe || {};
        const user = initDataUnsafe.user || {};

        const avatarElement = document.getElementById('user-avatar');
        const nameElement = document.getElementById('user-display-name');
        const continueBtn = document.getElementById('btn-continue');
        const switchBtn = document.getElementById('btn-switch-account');
        const phoneLink = document.getElementById('btn-login-phone');

        // Инициализация имени
        if (user.first_name) {
            nameElement.innerText = user.first_name + (user.last_name ? ' ' + user.last_name : '');
        } else {
            nameElement.innerText = "Пользователь Telegram";
        }

        // Черная зона: вывод фото
        if (user.photo_url) {
            avatarElement.innerHTML = `<img src="${user.photo_url}" alt="User Avatar">`;
        } else if (user.first_name) {
            avatarElement.innerText = user.first_name.charAt(0).toUpperCase();
        } else {
            avatarElement.innerText = "TG";
        }

        // Кнопка "Продолжить"
        if (continueBtn) {
            continueBtn.addEventListener('click', function() {
                tg.sendData(JSON.stringify({
                    action: "auth_confirmed",
                    user_id: user.id,
                    username: user.username || ""
                }));
                tg.close();
            });
        }

        // Кнопка "Войти в другой аккаунт"
        if (switchBtn) {
            switchBtn.addEventListener('click', function() {
                tg.showPopup({
                    title: "Смена аккаунта",
                    message: "Чтобы войти под другим аккаунтом, пожалуйста, переключите профиль в меню самого Telegram, а затем вернитесь в приложение.",
                    buttons: [{ type: "close", text: "ОК" }]
                });
            });
        }

        // ВАРИАНТ Б: Ввод номера телефона по ссылке снизу
        if (phoneLink) {
            phoneLink.addEventListener('click', function() {
                // Показываем официальное уведомление
                tg.showPopup({
                    title: "Ввод номера телефона",
                    message: "Пожалуйста, введите ваш контактный номер телефона для связи с магазином.",
                    buttons: [
                        { type: "ok", text: "Ввести номер" },
                        { type: "cancel", text: "Отмена" }
                    ]
                }, function(buttonId) {
                    if (buttonId === "ok") {
                        // Запрашиваем ввод через стандартное окно браузера внутри Mini App
                        const userPhone = prompt("Введите ваш номер телефона (например, +79991234567):");
                        
                        if (userPhone && userPhone.trim() !== "") {
                            // Безопасно отправляем введенный номер боту
                            tg.sendData(JSON.stringify({
                                action: "manual_phone_submitted",
                                phone: userPhone.trim()
                            }));
                            tg.close(); // Закрываем Mini App
                        } else if (userPhone !== null) {
                            tg.showAlert("Номер телефона не может быть пустым.");
                        }
                    }
                });
            });
        }
    </script>
</body>
</html>
