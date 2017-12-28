﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДатаСреза = ТекущаяДатаСеанса();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)	
	
	ТекущийЭлемент = Элементы.Аккредитуемый;	
	Если ЗначениеЗаполнено(Аккредитуемый) Тогда
		ОбновитьДанные();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Обновить(Команда)
	ОбновитьДанные();
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	ОбновитьДанные();
КонецПроцедуры

&НаКлиенте
Процедура АккредитуемыйПриИзменении(Элемент)
	ОбновитьДанные();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ФамилияНажатие(Элемент, СтандартнаяОбработка)
	ОткрытьФормуФИОФизлица(СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ОтчествоНажатие(Элемент, СтандартнаяОбработка)
	ОткрытьФормуФИОФизлица(СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ИмяНажатие(Элемент, СтандартнаяОбработка)
	ОткрытьФормуФИОФизлица(СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СписокЗаявленийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ПоказатьЗначение(, Элемент.ТекущиеДанные.Ссылка);	
КонецПроцедуры

&НаКлиенте
Процедура КомиссияНажатие(Элемент, СтандартнаяОбработка)
	ОткрытьФормуПерсональныеДатыАккредитации(СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПодКомиссияНажатие(Элемент, СтандартнаяОбработка)
	ОткрытьФормуПерсональныеДатыАккредитации(СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПотокНажатие(Элемент, СтандартнаяОбработка)
	
	ОткрытьФормуРегистраСведений(
		"ПотокиАккредитуемых", 
		Новый Структура("Аккредитуемый", Аккредитуемый), 
		СтандартнаяОбработка
	);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОткрытьФормуПерсональныеДатыАккредитации(СтандартнаяОбработка)
	
	ОткрытьФормуРегистраСведений(
		"ПерсональныеДатыАккредитации", 
		Новый Структура("Комиссия, Аккредитуемый", ПодКомиссия, Аккредитуемый), 
		СтандартнаяОбработка
	);

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуФИОФизлица(СтандартнаяОбработка)
	ОткрытьФормуРегистраСведений("ФИОФизЛиц", Новый Структура("ФизическоеЛицо", ФизическоеЛицо), СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуРегистраСведений(Знач ИмяРегистра, Отбор, СтандартнаяОбработка)
	
	ПараметрыОткрытия = Новый Структура("Отбор", Отбор);
	ОткрытьФорму(СтрШаблон("РегистрСведений.%1.ФормаСписка", ИмяРегистра), ПараметрыОткрытия, ЭтотОбъект, УникальныйИдентификатор);
	
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементов()
		
	Элементы.ЛеваяОсновная.Видимость	= ЕстьДанныеФизЛица;
	Элементы.ПраваяОсновная.Видимость 	= ЕстьДанныеФизЛица;
	Элементы.ЕстьДанныеФизЛица.Видимость= НЕ ЕстьДанныеФизЛица;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанные()
	
	Если ЗначениеЗаполнено(Аккредитуемый) Тогда		
		ОбновитьДанныеНаСервере();
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Выберите лицо",, "Аккредитуемый");
	КонецЕсли;	

КонецПроцедуры

&НаСервере
Процедура ОбновитьДанныеНаСервере()
	
	ЖурналЗаявлений.Параметры.УстановитьЗначениеПараметра("Аккредитуемый", Аккредитуемый);		
	ЖурналПротоколов.Параметры.УстановитьЗначениеПараметра("Значение", Аккредитуемый);		
	ФизическоеЛицо = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккредитуемый, "ФизическоеЛицо");
	
	ЗаполнитьОсновныеДанные();
	ЗаполнитьТекущиеДанные();
	
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОсновныеДанные()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ФИО.Фамилия КАК Фамилия,
		|	ФИО.Имя КАК Имя,
		|	ФИО.Отчество КАК Отчество,
		|	ФизЛицо.ДатаРождения КАК ДатаРождения,
		|	ФизЛицо.СтраховойНомерПФР КАК СтраховойНомерПФР,
		|	ФизЛицо.Гражданство КАК Гражданство
		|ИЗ
		|	Справочник.ФизическиеЛица КАК ФизЛицо
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ФИОФизЛиц.СрезПоследних(&Период, ФизическоеЛицо = &ФизическоеЛицо) КАК ФИО
		|		ПО ФизЛицо.Ссылка = ФИО.ФизическоеЛицо
		|ГДЕ
		|	ФизЛицо.Ссылка = &ФизическоеЛицо
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ПотокиАккредитуемыхСрезПоследних.Поток КАК Поток,
		|	ПотокиАккредитуемыхСрезПоследних.Комиссия КАК ПодКомиссия,
		|	ПотокиАккредитуемыхСрезПоследних.Комиссия.Родитель КАК Комиссия,
		|	ПотокиАккредитуемыхСрезПоследних.Комиссия.Специальность КАК Специальность,
		|	ПотокиАккредитуемыхСрезПоследних.Комиссия.ОбразовательноеУчреждение КАК ОбразовательноеУчреждение
		|ИЗ
		|	РегистрСведений.ПотокиАккредитуемых.СрезПоследних(&Период, Аккредитуемый = &Аккредитуемый) КАК ПотокиАккредитуемыхСрезПоследних
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	СвидетельстваОбАккредитации.НомерСвидетельства КАК НомерСвидетельства
		|ИЗ
		|	РегистрСведений.ВыданныеСвидетельстваОбАккредитации.СрезПервых(&Период, ФизическоеЛицо = &ФизическоеЛицо) КАК СвидетельстваОбАккредитации";
	
	Запрос.УстановитьПараметр("Аккредитуемый", Аккредитуемый);
	Запрос.УстановитьПараметр("Период", ДатаСреза);
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	
	РезультатПакета = Запрос.ВыполнитьПакет();	
	
	ВыборкаФизЛица = РезультатПакета[0].Выбрать();		
	ЕстьДанныеФизЛица = ВыборкаФизЛица.Количество() > 0;	
	Если ВыборкаФизЛица.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ВыборкаФизЛица);		
	КонецЕсли;
	
	Выборка = РезультатПакета[1].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);		
	КонецЕсли;
	
	Выборка = РезультатПакета[2].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТекущиеДанные()
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаТекущихДанных();
	
	Запрос.УстановитьПараметр("Аккредитуемый", Аккредитуемый);
	Запрос.УстановитьПараметр("Период", ДатаСреза);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();		
	
	Если Выборка.Следующий() Тогда
		
		ТекущийЭтап = Выборка.ЭтапСсылка;
		
		Решение = "";
		Если ЗначениеЗаполнено(Выборка.ОжидаетПринятияРешения) Тогда
			Решение = "Ожидает принятия решения";
		ИначеЕсли ЗначениеЗаполнено(Выборка.Сдало) Тогда
			Решение = "Сдал";
		ИначеЕсли ЗначениеЗаполнено(Выборка.НеСдало) Тогда
			Решение = "Не сдал";
		КонецЕсли;
		
 		РезультатСдачиЭтапа = ?(Выборка.Результат >= 70, "70 или более", Выборка.Результат);
		ПротоколРешение = Выборка.Регистратор;
		
	КонецЕсли;
	

КонецПроцедуры

&НаСервереБезКонтекста
Функция ТекстЗапросаТекущихДанных()
		
	Возврат 
	
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПерсональныеДатыАккредитации.Комиссия КАК Комиссия,
	|	ПерсональныеДатыАккредитации.Аккредитуемый КАК Аккредитуемый,
	|	ПерсональныеДатыАккредитации.Этап.Порядок КАК ЭтапПорядок,
	|	МАКСИМУМ(ПотокиАккредитуемых.Период) КАК ПериодПотока,
	|	ПерсональныеДатыАккредитации.Период КАК Период,
	|	ПерсональныеДатыАккредитации.ДатаПроведения КАК ДатаПроведения,
	|	ПерсональныеДатыАккредитации.Этап КАК Этап
	|ПОМЕСТИТЬ ЭтапыСДатойПотоков
	|ИЗ
	|	РегистрСведений.ПерсональныеДатыАккредитации КАК ПерсональныеДатыАккредитации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПотокиАккредитуемых КАК ПотокиАккредитуемых
	|		ПО ПерсональныеДатыАккредитации.Комиссия = ПотокиАккредитуемых.Комиссия
	|			И ПерсональныеДатыАккредитации.Аккредитуемый = ПотокиАккредитуемых.Аккредитуемый
	|			И ПерсональныеДатыАккредитации.Период >= ПотокиАккредитуемых.Период
	|			И (ПерсональныеДатыАккредитации.Активность)
	|			И (ПотокиАккредитуемых.Активность)
	|ГДЕ
	|	ПерсональныеДатыАккредитации.Аккредитуемый = &Аккредитуемый
	|	И ПотокиАккредитуемых.Аккредитуемый = &Аккредитуемый
	|	И ПотокиАккредитуемых.Период <= &Период
	|	И ПерсональныеДатыАккредитации.Период <= &Период
	|
	|СГРУППИРОВАТЬ ПО
	|	ПерсональныеДатыАккредитации.Комиссия,
	|	ПерсональныеДатыАккредитации.Аккредитуемый,
	|	ПерсональныеДатыАккредитации.Этап.Порядок,
	|	ПерсональныеДатыАккредитации.Этап,
	|	ПерсональныеДатыАккредитации.Период,
	|	ПерсональныеДатыАккредитации.ДатаПроведения
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЭтапыСДатойПотоков.Комиссия КАК Комиссия,
	|	ЭтапыСДатойПотоков.Аккредитуемый КАК Аккредитуемый,
	|	ЭтапыСДатойПотоков.ЭтапПорядок КАК ЭтапПорядок,
	|	ПотокиАккредитуемых.Поток КАК Поток,
	|	ЭтапыСДатойПотоков.Период КАК Период,
	|	ЭтапыСДатойПотоков.ПериодПотока КАК ПериодПотока
	|ПОМЕСТИТЬ ЭтапыСПотоками
	|ИЗ
	|	ЭтапыСДатойПотоков КАК ЭтапыСДатойПотоков
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПотокиАккредитуемых КАК ПотокиАккредитуемых
	|		ПО ЭтапыСДатойПотоков.Комиссия = ПотокиАккредитуемых.Комиссия
	|			И ЭтапыСДатойПотоков.Аккредитуемый = ПотокиАккредитуемых.Аккредитуемый
	|			И ЭтапыСДатойПотоков.ПериодПотока = ПотокиАккредитуемых.Период
	|			И (ПотокиАккредитуемых.Активность)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЭтапыСПотоками.Комиссия КАК Комиссия,
	|	ЭтапыСПотоками.Аккредитуемый КАК Аккредитуемый,
	|	ЭтапыСПотоками.ЭтапПорядок КАК ЭтапПорядок,
	|	ЭтапыСПотоками.Поток КАК Поток,
	|	МАКСИМУМ(ЭтапыСПотоками.Период) КАК Период,
	|	ЭтапыСПотоками.ПериодПотока КАК ПериодПотока
	|ПОМЕСТИТЬ ЭтапыСДатамиИПотоками
	|ИЗ
	|	ЭтапыСПотоками КАК ЭтапыСПотоками
	|
	|СГРУППИРОВАТЬ ПО
	|	ЭтапыСПотоками.Комиссия,
	|	ЭтапыСПотоками.Аккредитуемый,
	|	ЭтапыСПотоками.Поток,
	|	ЭтапыСПотоками.ЭтапПорядок,
	|	ЭтапыСПотоками.ПериодПотока
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЭтапыСДатамиИПотоками.Комиссия КАК Комиссия,
	|	ЭтапыСДатамиИПотоками.Аккредитуемый КАК Аккредитуемый,
	|	МАКСИМУМ(ЭтапыСДатамиИПотоками.ЭтапПорядок) КАК ЭтапПорядок,
	|	ЭтапыСДатамиИПотоками.Поток КАК Поток
	|ПОМЕСТИТЬ МаксимальныеЭтапыСПотоками
	|ИЗ
	|	ЭтапыСДатамиИПотоками КАК ЭтапыСДатамиИПотоками
	|
	|СГРУППИРОВАТЬ ПО
	|	ЭтапыСДатамиИПотоками.Комиссия,
	|	ЭтапыСДатамиИПотоками.Поток,
	|	ЭтапыСДатамиИПотоками.Аккредитуемый
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПерсональныеДатыАккредитации.Период КАК Период,
	|	ПерсональныеДатыАккредитации.Регистратор КАК Регистратор,
	|	ПерсональныеДатыАккредитации.Комиссия КАК Подкомиссия,
	|	ПерсональныеДатыАккредитации.Этап.Порядок + 1 КАК Этап,
	|	ПерсональныеДатыАккредитации.Аккредитуемый КАК КоличествоАккредитуемых,
	|	НАЧАЛОПЕРИОДА(ПерсональныеДатыАккредитации.ДатаПроведения, ДЕНЬ) КАК ДатаПроведения,
	|	ПерсональныеДатыАккредитации.НомерПопыткиРегл КАК Попытка,
	|	ПерсональныеДатыАккредитации.ПопыткаСдачи КАК ПопыткаСдачи,
	|	ПерсональныеДатыАккредитации.Аккредитуемый КАК Аккредитуемый,
	|	ПерсональныеДатыАккредитации.Комиссия.Родитель.СубъектРФ КАК СубъектРФ,
	|	ПерсональныеДатыАккредитации.Комиссия.ОбразовательноеУчреждение КАК ОбразовательноеУчреждение,
	|	ПерсональныеДатыАккредитации.Комиссия.Специальность КАК Специальность,
	|	ПерсональныеДатыАккредитации.Комиссия.ОбразовательноеУчреждение.Ведомство КАК Ведомство,
	|	ПерсональныеДатыАккредитации.Комиссия.Родитель КАК Комиссия,
	|	ПерсональныеДатыАккредитации.Этап КАК ЭтапСсылка,
	|	ЭтапыСДатамиИПотоками.Поток КАК Поток,
	|	ЭтапыСДатамиИПотоками.ПериодПотока КАК ПериодПотока
	|ПОМЕСТИТЬ ТекущееСостояниеПоДатам
	|ИЗ
	|	МаксимальныеЭтапыСПотоками КАК МаксимальныеЭтапыСПотоками
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ЭтапыСДатамиИПотоками КАК ЭтапыСДатамиИПотоками
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПерсональныеДатыАккредитации КАК ПерсональныеДатыАккредитации
	|			ПО ЭтапыСДатамиИПотоками.Комиссия = ПерсональныеДатыАккредитации.Комиссия
	|				И ЭтапыСДатамиИПотоками.Аккредитуемый = ПерсональныеДатыАккредитации.Аккредитуемый
	|				И ЭтапыСДатамиИПотоками.ЭтапПорядок = ПерсональныеДатыАккредитации.Этап.Порядок
	|				И ЭтапыСДатамиИПотоками.Период = ПерсональныеДатыАккредитации.Период
	|				И (ПерсональныеДатыАккредитации.Активность)
	|		ПО МаксимальныеЭтапыСПотоками.Комиссия = ЭтапыСДатамиИПотоками.Комиссия
	|			И МаксимальныеЭтапыСПотоками.Аккредитуемый = ЭтапыСДатамиИПотоками.Аккредитуемый
	|			И МаксимальныеЭтапыСПотоками.ЭтапПорядок = ЭтапыСДатамиИПотоками.ЭтапПорядок
	|			И МаксимальныеЭтапыСПотоками.Поток = ЭтапыСДатамиИПотоками.Поток
	|ГДЕ
	|	ПерсональныеДатыАккредитации.Аккредитуемый = &Аккредитуемый
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ТекущееСостояниеПоДатам.Период КАК Период,
	|	ТекущееСостояниеПоДатам.Регистратор КАК Регистратор,
	|	ТекущееСостояниеПоДатам.Подкомиссия КАК Подкомиссия,
	|	ТекущееСостояниеПоДатам.Этап КАК Этап,
	|	ТекущееСостояниеПоДатам.КоличествоАккредитуемых КАК КоличествоАккредитуемых,
	|	ТекущееСостояниеПоДатам.ДатаПроведения КАК ДатаПроведения,
	|	ТекущееСостояниеПоДатам.Попытка КАК Попытка,
	|	ТекущееСостояниеПоДатам.ПопыткаСдачи КАК ПопыткаСдачи,
	|	ТекущееСостояниеПоДатам.Аккредитуемый КАК Аккредитуемый,
	|	ТекущееСостояниеПоДатам.СубъектРФ КАК СубъектРФ,
	|	ТекущееСостояниеПоДатам.ОбразовательноеУчреждение КАК ОбразовательноеУчреждение,
	|	ТекущееСостояниеПоДатам.Специальность КАК Специальность,
	|	ТекущееСостояниеПоДатам.Ведомство КАК Ведомство,
	|	ТекущееСостояниеПоДатам.Комиссия КАК Комиссия,
	|	ТекущееСостояниеПоДатам.ЭтапСсылка КАК ЭтапСсылка,
	|	ВЫБОР
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.Тестирование)
	|			ТОГДА ВЫБОР
	|					КОГДА НЕ РешенияКомиссииПоТестированиюСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|							И НЕ РешенияКомиссииПоТестированиюСрезПоследних.Решение
	|							И ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|							И НЕ ТекущееСостояниеПоДатам.Попытка = 3
	|						ТОГДА 1
	|					ИНАЧЕ 0
	|				КОНЕЦ
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.ПодтверждениеПрофессиональныхНавыковИУмений)
	|			ТОГДА ВЫБОР
	|					КОГДА НЕ РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|							И НЕ РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Решение
	|							И ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|							И НЕ ТекущееСостояниеПоДатам.Попытка = 3
	|						ТОГДА 1
	|					ИНАЧЕ 0
	|				КОНЕЦ
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.РешениеСитуационныхЗадач)
	|			ТОГДА ВЫБОР
	|					КОГДА НЕ РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|							И НЕ РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Решение
	|							И ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|							И НЕ ТекущееСостояниеПоДатам.Попытка = 3
	|						ТОГДА 1
	|					ИНАЧЕ 0
	|				КОНЕЦ
	|	КОНЕЦ КАК ОжидаетПринятияРешения,
	|	ВЫБОР
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.Тестирование)
	|			ТОГДА ВЫБОР
	|					КОГДА РешенияКомиссииПоТестированиюСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|						ТОГДА 0
	|					ИНАЧЕ ВЫБОР
	|							КОГДА РешенияКомиссииПоТестированиюСрезПоследних.Решение
	|								ТОГДА 1
	|							ИНАЧЕ 0
	|						КОНЕЦ
	|				КОНЕЦ
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.ПодтверждениеПрофессиональныхНавыковИУмений)
	|			ТОГДА ВЫБОР
	|					КОГДА РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|						ТОГДА 0
	|					ИНАЧЕ ВЫБОР
	|							КОГДА РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Решение
	|								ТОГДА 1
	|							ИНАЧЕ 0
	|						КОНЕЦ
	|				КОНЕЦ
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.РешениеСитуационныхЗадач)
	|			ТОГДА ВЫБОР
	|					КОГДА РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|						ТОГДА 0
	|					ИНАЧЕ ВЫБОР
	|							КОГДА РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Решение
	|								ТОГДА 1
	|							ИНАЧЕ 0
	|						КОНЕЦ
	|				КОНЕЦ
	|	КОНЕЦ КАК Сдало,
	|	ВЫБОР
	|		КОГДА ТекущееСостояниеПоДатам.Попытка < 3
	|			ТОГДА 0
	|		ИНАЧЕ ВЫБОР
	|				КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.Тестирование)
	|					ТОГДА ВЫБОР
	|							КОГДА РешенияКомиссииПоТестированиюСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|								ТОГДА 0
	|							ИНАЧЕ ВЫБОР
	|									КОГДА РешенияКомиссииПоТестированиюСрезПоследних.Решение
	|										ТОГДА 0
	|									ИНАЧЕ 1
	|								КОНЕЦ
	|						КОНЕЦ
	|				КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.ПодтверждениеПрофессиональныхНавыковИУмений)
	|					ТОГДА ВЫБОР
	|							КОГДА РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|								ТОГДА 0
	|							ИНАЧЕ ВЫБОР
	|									КОГДА РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Решение
	|										ТОГДА 0
	|									ИНАЧЕ 1
	|								КОНЕЦ
	|						КОНЕЦ
	|				КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.РешениеСитуационныхЗадач)
	|					ТОГДА ВЫБОР
	|							КОГДА РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|								ТОГДА 0
	|							ИНАЧЕ ВЫБОР
	|									КОГДА РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Решение
	|										ТОГДА 0
	|									ИНАЧЕ 1
	|								КОНЕЦ
	|						КОНЕЦ
	|			КОНЕЦ
	|	КОНЕЦ КАК НеСдало,
	|	ТекущееСостояниеПоДатам.ПериодПотока КАК ПериодПотока,
	|	ВЫБОР
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.Тестирование)
	|			ТОГДА ВЫБОР
	|					КОГДА РешенияКомиссииПоТестированиюСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|						ТОГДА 0
	|					ИНАЧЕ РешенияКомиссииПоТестированиюСрезПоследних.Результат
	|				КОНЕЦ
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.ПодтверждениеПрофессиональныхНавыковИУмений)
	|			ТОГДА ВЫБОР
	|					КОГДА РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|						ТОГДА 0
	|					ИНАЧЕ РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Результат
	|				КОНЕЦ
	|		КОГДА ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.РешениеСитуационныхЗадач)
	|			ТОГДА ВЫБОР
	|					КОГДА РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Аккредитуемый ЕСТЬ NULL
	|						ТОГДА 0
	|					ИНАЧЕ РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Результат
	|				КОНЕЦ
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК Результат
	|ИЗ
	|	ТекущееСостояниеПоДатам КАК ТекущееСостояниеПоДатам
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РешенияКомиссииПоТестированию.СрезПоследних(&Период, Аккредитуемый = &Аккредитуемый) КАК РешенияКомиссииПоТестированиюСрезПоследних
	|		ПО ТекущееСостояниеПоДатам.Подкомиссия = РешенияКомиссииПоТестированиюСрезПоследних.Комиссия
	|			И ТекущееСостояниеПоДатам.Аккредитуемый = РешенияКомиссииПоТестированиюСрезПоследних.Аккредитуемый
	|			И ТекущееСостояниеПоДатам.ПопыткаСдачи = РешенияКомиссииПоТестированиюСрезПоследних.ПопыткаСдачи
	|			И (ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.Тестирование))
	|			И (НАЧАЛОПЕРИОДА(ТекущееСостояниеПоДатам.ДатаПроведения, ДЕНЬ) = НАЧАЛОПЕРИОДА(РешенияКомиссииПоТестированиюСрезПоследних.Период, ДЕНЬ))
	|			И ТекущееСостояниеПоДатам.Поток = РешенияКомиссииПоТестированиюСрезПоследних.Поток
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РешенияКомиссииПоОценкеПрактическихНавыков.СрезПоследних(&Период, Аккредитуемый = &Аккредитуемый) КАК РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних
	|		ПО ТекущееСостояниеПоДатам.Подкомиссия = РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Комиссия
	|			И ТекущееСостояниеПоДатам.Аккредитуемый = РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Аккредитуемый
	|			И ТекущееСостояниеПоДатам.ПопыткаСдачи = РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.ПопыткаСдачи
	|			И (ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.ПодтверждениеПрофессиональныхНавыковИУмений))
	|			И (НАЧАЛОПЕРИОДА(ТекущееСостояниеПоДатам.ДатаПроведения, ДЕНЬ) = НАЧАЛОПЕРИОДА(РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Период, ДЕНЬ))
	|			И ТекущееСостояниеПоДатам.Поток = РешенияКомиссииПоОценкеПрактическихНавыковСрезПоследних.Поток
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РешенияКомиссииПоСитуационнымЗадачам.СрезПоследних(&Период, Аккредитуемый = &Аккредитуемый) КАК РешенияКомиссииПоСитуационнымЗадачамСрезПоследних
	|		ПО ТекущееСостояниеПоДатам.Подкомиссия = РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Комиссия
	|			И ТекущееСостояниеПоДатам.Аккредитуемый = РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Аккредитуемый
	|			И ТекущееСостояниеПоДатам.ПопыткаСдачи = РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.ПопыткаСдачи
	|			И (ТекущееСостояниеПоДатам.ЭтапСсылка = ЗНАЧЕНИЕ(Перечисление.ЭтапыАккредитации.РешениеСитуационныхЗадач))
	|			И (НАЧАЛОПЕРИОДА(ТекущееСостояниеПоДатам.ДатаПроведения, ДЕНЬ) = НАЧАЛОПЕРИОДА(РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Период, ДЕНЬ))
	|			И ТекущееСостояниеПоДатам.Поток = РешенияКомиссииПоСитуационнымЗадачамСрезПоследних.Поток
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗаявленияОПовторнойСдачеЭтапа.СрезПоследних(&Период, Аккредитуемый = &Аккредитуемый) КАК ЗаявленияОПовторнойСдачеЭтапаСрезПоследних
	|		ПО ТекущееСостояниеПоДатам.Подкомиссия = ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Комиссия
	|			И ТекущееСостояниеПоДатам.ЭтапСсылка = ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Этап
	|			И ТекущееСостояниеПоДатам.Аккредитуемый = ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Аккредитуемый
	|			И (ТекущееСостояниеПоДатам.ПопыткаСдачи + 1 = ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.ПопыткаСдачи)
	|			И ТекущееСостояниеПоДатам.Поток = ЗаявленияОПовторнойСдачеЭтапаСрезПоследних.Поток";

КонецФункции

#КонецОбласти
