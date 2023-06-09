﻿// MIT License
//
// Copyright (c) 2023 FAST8.RU
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#Область ПрограммныйИнтерфейс
	
Функция ЭтоКопияРабочейБазы(ЗаголовокПриложения) Экспорт
	
	ЗаголовокКопия = СтрНайти(ВРег(ЗаголовокПриложения), "КОПИЯ") <> 0;
         
    ВнешниеРесурсыЗаблокированы = Ложь;
	
	УстановитьБезопасныйРежим(Истина);
	Попытка	
		Выполнить("ВнешниеРесурсыЗаблокированы = РегламентныеЗаданияСервер.РаботаСВнешнимиРесурсамиЗаблокирована();");
	Исключение
		ЗаписьЖурналаРегистрации("FAST8ДневникКопииБазы", УровеньЖурналаРегистрации.Ошибка,,, "Ошибка выполнения метода РегламентныеЗаданияСервер.РаботаСВнешнимиРесурсамиЗаблокирована()");
	КонецПопытки;
	УстановитьБезопасныйРежим(Ложь);
			
	ЭтоКопияРабочейБазы = (ЗаголовокКопия Или ВнешниеРесурсыЗаблокированы) И ПравоДоступа("Просмотр", Метаданные.Обработки.fast8Diary_ДневникКопииБазы);
	
	Если ЭтоКопияРабочейБазы = Ложь Тогда
		УстановитьПривилегированныйРежим(Истина);
		СохраненнаяДатаПервогоЗапуска = ХранилищеОбщихНастроек.Загрузить("fast8ДатаПервогоЗапуска", "FAST8ДневникКопииБазы",, "FAST8");
		Если СохраненнаяДатаПервогоЗапуска <> Неопределено Тогда
			ХранилищеОбщихНастроек.Удалить("fast8ДатаПервогоЗапуска", "FAST8ДневникКопииБазы", "FAST8");
		КонецЕсли;
	Иначе
		// Отметим авторизацию в базе
		ДобавитьСобытие(Пользователи.ТекущийПользователь(), "Вошел в базу");
	КонецЕсли;
	
	Возврат ЭтоКопияРабочейБазы;
	
КонецФункции // ЭтоКопияРабочейБазы()

Процедура ДобавитьСобытие(Пользователь, Событие) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТаблицаСобытий = ХранилищеОбщихНастроек.Загрузить("fast8События", "FAST8ДневникКопииБазы",, "FAST8");
    Если ТаблицаСобытий = Неопределено Тогда
		ТаблицаСобытий = Новый ТаблицаЗначений;
		ТаблицаСобытий.Колонки.Добавить("Дата",			Новый ОписаниеТипов("Дата"));
		ТаблицаСобытий.Колонки.Добавить("Пользователь",	Новый ОписаниеТипов("Строка"));
		ТаблицаСобытий.Колонки.Добавить("Событие",		Новый ОписаниеТипов("Строка"));
		
		// Вероятно, копию только что распаковали. Обнулим нумераторы в кластере 1С.
		ОбновитьНумерациюОбъектов();
	КонецЕсли;
	
	НоваяСтрока = ТаблицаСобытий.Вставить(0);
	НоваяСтрока.Дата			= ТекущаяДатаСеанса();
	НоваяСтрока.Пользователь	= Пользователь;
	НоваяСтрока.Событие			= Событие;
	
	ХранилищеОбщихНастроек.Сохранить("fast8События", "FAST8ДневникКопииБазы", ТаблицаСобытий,, "FAST8");
	
КонецПроцедуры // ДобавитьСобытие()

#КонецОбласти // ПрограммныйИнтерфейс