﻿
&После("ПриНачалеРаботыСистемы")
Процедура FAST8Дневник_ПриНачалеРаботыСистемы()
	
	Если FAST8Дневник_ВызовСервера.ЭтоКопияРабочейБазы(КлиентскоеПриложение.ПолучитьЗаголовок()) Тогда
		ОткрытьФорму("Обработка.FAST8Дневник_ДневникКопииБазы.Форма.FAST8Дневник_Форма");
	КонецЕсли;
	
КонецПроцедуры