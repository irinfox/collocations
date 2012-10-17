<?php
	//строки, кот. формируются по параметрам. 1ая для поиска файла (чтоб не считать, а сразу выдать), 2ая для запуска соотв. запросу программы
	$filename = "";
	$launch = "perl ";
	$launchDict .= "perl ../newProgr/freqs_count.pl -f ";
	$launchDict1 = "perl ";
	$dict1 = ""; //файл для поиска однословных частот для MI, tscore

	foreach ($_GET as $key => $value){
		echo "$key = $value<br>";
	}
	
	switch ($_GET['metricR']){
		case "freqDict":
			$launchDict;
			break;
		
		case "MI"://нужно проверять на существование ещё и другие файлы
			$launch .= "../newProgr/MI.pl ";
			break;

		case "tscore":
			$launch .= "../newProgr/tscore.pl ";
			break;
	}


	switch ($_GET['collection']){
		case "vz": 
			$filename .= "vz.ru_sport.txt.utf8.lemma";
			break;
		case "ng":
			$filename .= "ng_all.txt.af.lemma_utf8";
			break;
		case "corp":	
			$filename .= "corp.txt.utf8.lemma";
			break;	
	}
	
	//где берём файлы?
	$pathSrc = "";
	switch ($_GET['collection']){
		case "vz": 
			$pathSrc = "../collections/texts/news/vz/";
			break;
		case "ng":
			$pathSrc = "../collections/texts/news/ng/";
			break;
		case "corp":	
			$pathSrc = "../collections/texts/science/corp/";
			break;	
	}

	//строка запуска perl progName -f fileName с указанием пути программы и файла
	
	$launchDict .= $pathSrc.$filename;

	if ($_GET['param1'] == "lemm"){
		$filename .= "_l";
	}
	else {
		$filename .= "_w"; 
		if ($_GET['metricR']== "freqDict"){
			$launchDict .= " -w";
		}
	}

	if ($_GET['dop'] == "lowcase"){
		$filename .= "r";
		if ($_GET['metricR']== "freqDict"){
			$launchDict .= "-l ";
		}
	}
	else{$filename .= "R";}

	$dict1 .= $filename."_freqDict_1";
	$filename .= "_".$_GET['metricR'];//приписываем метрику (value, пришедшее из формы);	
	$launchDict1 = $launchDict;
	
	if ($_GET['metricR'] == "freqDict" || $_GET['metricR'] == "MI"){
		//$dict1 .= "_1";
		if ($_GET['grams'] == ""){
 			$filename .= "_".$_GET['gram'];
		}else {	$filename .= "_".$_GET['grams'];}
		
		//для запуска составления частотных словарей
		//$launchDict1 = $launchDict;
		$launchDict .= " -n".$_GET['grams'];
	}
	
	if ($_GET['metricR'] == "MI"){ 
		$filename .= "b".$_GET['b'];
		//$dict1 .= "b".$_GET['b'];
	}


	echo "ищем файл: $filename,<br> а для MI и tscore проверим ещё и этот: $dict1 <br>";
	
	//где ищем?
	$path = "";
	switch ($_GET['collection']){
		case "vz": 
			$path = "../collections/metric/news/vz/";
			break;
		case "ng":
			$path = "../collections/metric/news/ng/";
			break;
		case "corp":	
			$path = "../collections/metric/science/corp/";
			break;	
	}
	if (file_exists($path.$filename)){
		echo "отдаю файл: $path.$filename";
	}
	else {
		if ($_GET[metricR]== "freqDict"){ 
			echo "запускаю программу и радуюсь " .$launchDict;
		}
		else {	
			if (file_exists($path.$dict1)){
				echo "<br>запускаю программу раз и как-то сохраняю результат".$launchDict;	
				$res = "freqMonogo"; //это должен быть дескриптор файла, наверное
				$launch .= " -f $res -h $dict1 ";//надо по dict1 прописать в перл. программе подсчёт частот
				echo "<br>запускаю программу два  ".$launch;
			}
			else {
				echo "<br> вот же не повезло<br>";
				echo "<br>раз ".$launchDict;
				$res2 = "freqMnogo";//для больше 1граммы
				echo "<br>два ".$launchDict1;
				$res1 = "freqOdin"; //для однословий
				$launch .= " -f $res2 -h $res1 "; //
				echo "<br>три ".$launch;
			}	
		}

	}

	

/*../collections/texts/news/NG:
ng_all.txt.af.lemma_utf8

../collections/texts/news/VZ:
vz.ru_sport.txt.utf8.lemma

../collections/texts/science:
corp
dialog

../collections/texts/science/corp:
corp.txt.utf8.lemma
*/

?>
