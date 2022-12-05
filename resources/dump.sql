CREATE TABLE users (
    login VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    PRIMARY KEY (login)
);

INSERT INTO users (login, password, description) VALUES ('user', '123', 'Описание пользователя');
INSERT INTO users (login, password, description) VALUES ('folkorNanGnu', '123', 'Институт искусствоведения, этнографии и фольклора им. К. Крапивы НАН РБ ГНУ');
INSERT INTO users (login, password, description) VALUES ('glavHozUpravlenie', '123', '"Главное хозяйственное управление" Управления делами Президента Республики Беларусь');
INSERT INTO users (login, password, description) VALUES ('skidSahar', '123', 'Скидельский сахарный комбинат ОАО');
INSERT INTO users (login, password, description) VALUES ('rudensk', '123', 'Открытое акционерное общество "Руденск"');
INSERT INTO users (login, password, description) VALUES ('ggktu', '123', 'Учреждение образования "Гомельский государственный колледж торговли и услуг"');
INSERT INTO users (login, password, description) VALUES ('MinskMetro', '123', 'Коммунальное траспортное унитарное предприятие "Минский метрополитен"');
INSERT INTO users (login, password, description) VALUES ('BelForce', '123', 'Войсковая часть 1257');
INSERT INTO users (login, password, description) VALUES ('StroiIngenerGroup', '123', 'Общество с ограниченной ответственностью "СтройИнженерГрупп');



CREATE TABLE tender_statuses (
    id INT NOT NULL,
    value VARCHAR(255),
    PRIMARY KEY (id)
);

INSERT INTO tender_statuses VALUES (0, 'Закрыт');
INSERT INTO tender_statuses VALUES (1, 'Открыт');
INSERT INTO tender_statuses VALUES (2, 'Отменён');


CREATE TABLE tenders (
    id INT NOT NULL AUTO_INCREMENT,
    owner VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(10000),
    date DATE NOT NULL,
    starting_price INT,
    current_price INT,
    executant VARCHAR(255),
    status INT DEFAULT 1,
    PRIMARY KEY (id),
    FOREIGN KEY (owner) REFERENCES tender.users(login),
    FOREIGN KEY (executant) REFERENCES tender.users(login),
    FOREIGN KEY (status) REFERENCES tender.tender_statuses(id)
);

INSERT INTO tenders (owner, name, date, starting_price, description, current_price) VALUE ('folkorNanGnu', 'Активная акустическая система', '2023-01-01', 7920, 'Модель: Behringer B215XL, количество: 2шт., номинальная мощность: 250 Ватт, состояние: новое', 7920);

INSERT INTO tenders (owner, name, date, starting_price, description, current_price) VALUE ('glavHozUpravlenie', 'Осциллограф и анализатор спектра', '2022-12-30', 167600, 'MDO3032, Осциллограф комбинированный цифровой с анализатором спектра, 2 канала x 350МГц.
Осциллограф
• Модели с 2 и 4 аналоговыми каналами
• Модели с полосой пропускания 1 ГГц, 500 МГц, 350 МГц, 200 МГц и 100 МГц
• Полоса пропускания может быть расширена (до 1 ГГц)
• Частота дискретизации до 5 Гвыб./с
• Длина записи 10 млн. точек во всех каналах
• Максимальная скорость захвата сигнала >280 000 осциллограмм в секунду
• Стандартные пассивные пробники напряжения с входной емкостью 3,9 пФ и аналоговой полосой пропускания 1 ГГц, 500 МГц или 250 МГц

Анализатор спектра
• Диапазон частот
• В стандартной конфигурации: от 9 кГц до верхней границы полосы пропускания осциллографа
• Опция: от 9 кГц до 3 ГГц
• Сверхширокая полоса захвата до 3 ГГц', 167600);

INSERT INTO tenders (owner, name, date, starting_price, description, current_price, executant) VALUE ('skidSahar', 'Промышленный программатор', '2023-02-15', 9340, 'Максимальная производительность 1000 микросхем в час
6 программирующих платформ на, каждой из которых может быть установлено до 4х микросхем, обеспечивают до 24 программируемых мест
Система поддерживает устройства высокой плотности
Програмирование микросхем с размерами от 2х3мм  до 42х42мм', 8500, 'folkorNanGnu');

INSERT INTO tenders (owner, name, date, starting_price, current_price, description, status) VALUE ('rudensk', 'Горизонтально-расточное ремнотное оборудование', '2023-02-17', 50450, 50450, 'Закупка горизонтально-расточного оборудования для:"Реконструкция участка механической обработки корпусных деталей и деталей тел вращения карьерных самосвалов грузоподъемностью 90-360 т. на базе 17-го пролета цеха программных станков" в количестве 10 единиц', 2);

INSERT INTO tenders (owner, name, date, starting_price, current_price, description, executant) VALUE ('MinskMetro', 'Головной вагон метро мод. 81-7036', '2023-02-17', 190500, 180500, 'Ширина колеи, мм	1 520
Длина кузова, мм	19 030
Длина по осям автосцепки, мм	19 430
Ширина кузова, мм	2 676
Высота крыши над уровнем головки рельса, мм	3 650
Высота пола над уровнем головки рельса, мм	1 208
База вагона, мм	12 600
База тележки, мм	2 100
Диаметр колес по поверхности катания, мм	860
Скорость конструкционная, км/ч	90
Ускорение при разгоне, среднее, м/с²	1,2
Замедление при торможении, среднее, м/с	1,15
Расчётный коэффициент возврата эл.энергии в сеть за счёт рекупирации при торможении, %	20
Удельный расход электроэнергии, Вт·ч/Т·км, не более	37
Тормозной путь со скорости 90 км/ч, м:
- при электродинамическом торможении, с тормозом замещения
- при экстренном торможении	
320
295
Минимальный радиус проходных кривых, м:
- на главных путях
- в депо	
200
60
Тележка	68-797 тип 5 и тип 6
Количество сидячих мест	36
Вместимость вагона при плотности стоящих пассажиров 8/10 чел/м²	264/322
Масса тары вагона, т	33', 'glavHozUpravlenie');

INSERT INTO tenders (owner, name, date, starting_price, current_price, description) VALUE ('BelForce', 'Дрель ударная 10 шт.', '2023-05-07', 2500, 2500, 'Дрель Bosch UniversalImpact 700.
Тип питания: Сеть
Режимы работы: Сверление с ударом');

INSERT INTO tenders (owner, name, date, starting_price, current_price, description, executant) VALUE ('StroiIngenerGroup', 'Станок настолько-сверлильный', '2023-01-10', 17200, 12900, 'Закупка станка настольно-сверлильного для объекта: «Строительство свиноводческого репродуктора на 3600 голов основных свиноматок в ОАО "Климовичский комбинат хлебопродуктов»', 'ggktu');

