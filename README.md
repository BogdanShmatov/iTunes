
Тестовое задание: iTunes

Необходимо разработать приложение, отображающее список песен по ключевому слову. В приложении использовать API: https://itunes.apple.com/search?term=SEARCH_KEYWORD, где SEARCH_KEYWORD - ключевое слово для поиска. Для каждой песни необходимо отобразить обложку песни, название песни и название артиста. Ключевое слово должно содержать минимум 3 символа, если введено меньше - поиск не начинается. С помощью индикатора активности необходимо и/или скелетона показывать загрузку/обновление списка песен. При нажатии на песню из списка должен открываться экран с плеером. Дизайн можно использовать на свое усмотрение.

Плеер содержит в себе: 
- Обложку песни. +
- Имя исполнителя. +
- Название песни. +
- Кнопку play/stop (можно не реализовывать механизм воспроизведения звука) +

Будет плюсом:
- Использовать архитектуру VIPER +
- Не использовать Storyboard +
- Использовать URLSession вместо Alamofire, Moya и др. +
- Реализовать воспроизведение песни. +
- Реализовать пагинацию для списка -

-------------------------------------------------------------------------------------
Проект основан на VIPER в связке с Coordinator паттерном.

- Экран онбординга, реализован на SwiftUI
- Основной экран, сверстан кодом с использованием SnapKit
- Экран поиска, сверстан кодом с использованием SnapKit
- Экран плеера, реализован на SwiftUI

Локальные Packages
+ Cannonball - модуль, реализующий создание, отправку, декодинг и логирование запросов.
+ AzazelUI - модуль содержащий UI компоненты

![IMG_9217_-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/514bb6bc-8589-423a-980d-464ebc85a042)
