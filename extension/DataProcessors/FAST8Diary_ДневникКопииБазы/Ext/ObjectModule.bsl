// MIT License
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

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ИнформацияОПрограмме() Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	Расширения = РасширенияКонфигурации.Получить(Новый Структура("Имя", "FAST8BaseCopyDiary"));
	МетаданныеРасширения = Новый ОбъектМетаданныхКонфигурация(Расширения.Получить(0).ПолучитьДанные());
		
	Информация = Новый Структура;
	Информация.Вставить("АдресНаСайте", "https://fast8.ru/FAST8BaseCopyDiary/");
	Информация.Вставить("Версия", МетаданныеРасширения.Версия);
	Информация.Вставить("Имя", МетаданныеРасширения.Имя);
	Информация.Вставить("Синоним", МетаданныеРасширения.Синоним);
	Информация.Вставить("Описание", "Дневник копии базы для 1С:Предприятие 8");
	Информация.Вставить("БезопасныйРежим", Истина);
	Информация.Вставить("Автор", "sa1m0nn FAST8, Екатеринбург, 2020");
	
	Возврат Информация;
	
КонецФункции // ИнформацияОПрограмме()

#КонецОбласти // ПрограммныйИнтерфейс

#КонецЕсли