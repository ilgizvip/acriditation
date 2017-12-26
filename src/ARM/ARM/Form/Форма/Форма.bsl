﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	//УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДатаСреза = ТекущаяДатаСеанса();
	
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)	
	ТекущийЭлемент = Элементы.Аккредитуемый;	
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


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

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
	
	ФизическоеЛицо = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккредитуемый, "ФизическоеЛицо");
	
	ЗаполнитьОсновнуюИнформацию();
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьОсновнуюИнформацию()
	
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
Процедура УстановитьУсловноеОформление()

//	УсловноеОформление.Элементы.Очистить();

//	//

//	Элемент = УсловноеОформление.Элементы.Добавить();

//	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
//	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ГруппыПользователейГруппа.Имя);

//	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
//	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ГруппыПользователей.ПомеченоПользователей");
//	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Больше;
//	ОтборЭлемента.ПравоеЗначение = 0;

//	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт("Arial", 10, Истина));
//	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", Новый ПолеКомпоновкиДанных("ГруппыПользователей.НаименованиеГруппыИПомеченоПользователей"));

КонецПроцедуры



#КонецОбласти
