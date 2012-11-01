<?php
	//строки, кот. формируются по параметрам. 1ая для поиска файла (чтоб не считать, а сразу выдать), 2ая для запуска соотв. запросу программы
	$filename = "";
	$launch = "perl ";
	$launchDict .= "perl ../newProgr/freqs_count.pl -f ";
	$launchDict1 = "perl ";
	$dict1 = ""; //файл для поиска однословных частот для MI, tscore
	$dict2 = ""; //файл для поиска Nсловных частот для MI, tscore


        $coll2path = array(
           'vz'   => 'news/vz',
           'ng'   => 'news/ng',
           'corp' => 'science/corp'
        );

	foreach ($_GET as $key => $value){
		echo "$key = $value<br>";
	}//test print
	
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
    $pathSrc = "../collections/texts/" . $coll2path[$_GET['collection']] . '/';

	//строка запуска perl progName -f fileName с указанием пути программы и файла
	
	$launchDict .= $pathSrc.$filename;

	if ($_GET['param1'] == "lemm"){
		$filename .= "_l";
	}
	else {
		$filename .= "_w"; 
		//здесь была проверка на то, что метрика - част. словарь
		$launchDict .= " -w";
	}

	if ($_GET['dop'] == "lowcase"){
		$filename .= "r";
		if ($_GET['metricR']== "freqDict"){
			$launchDict .= "-l ";
		}
	}
	else{$filename .= "R";}

	$dict1 .= $filename."_freqDict_1";
	$dict2 .= $filename."_freqDict_";	
	$filename .= "_".$_GET['metricR'];//приписываем метрику (value, пришедшее из формы);	
	$launchDict1 = $launchDict;
	
	if ($_GET['metricR'] == "freqDict" || $_GET['metricR'] == "MI"){
		//$dict1 .= "_1";
		if ($_GET['grams'] == ""){
 			$filename .= "_".$_GET['gram'];
			$launchDict .= " -n".$_GET['gram'];
			$dict2 .= $_GET['gram'];
		}else {	
			$filename .= "_".$_GET['grams'];
		
		//для запуска составления частотных словарей
		//$launchDict1 = $launchDict;
			$launchDict .= " -n".$_GET['grams'];
			$dict2 .= $_GET['grams'];
		}
	}
	
	if ($_GET['metricR'] == "tscore"){$dict2 .= "2";}
	
	if ($_GET['metricR'] == "MI" || $_GET['metricR'] == "tscore"){	 
		if ($_GET['metricR'] == "tscore"){$filename .= "_";}
		$filename .= "b".$_GET['b'];
		//$dict1 .= "b".$_GET['b'];
		$tempStr = "а для MI и tscore проверим ещё и эти: $dict1 <br> $dict2 <br>";
	}

	//работа с файлами
	//этап 0. Подключение к БД
	$host = "localhost";
	$login = "colloc";
	$PWD = "H4eSaa1L";
	$dbCon = mysql_connect($host,$login, $PWD);
	//проверка
	print "код ошибки: ". mysql_error();
	print "<br>Connected with ID: ".$dbCon."<br>"; 

	//к журналу
	$dbName = "collocs";
	mysql_select_DB($dbName, $dbCon);


	echo "ищем файл: $filename<br>".$tempStr;
	
	//где ищем?
    $path = "../collections/metric/" . $coll2path[$_GET['collection']] . '/';

	if (file_exists($path.$filename)){
		echo "отдаю файл: $path.$filename";
	}
	else {
		if ($_GET['metricR']== "freqDict"){ 
			echo "запускаю программу и радуюсь: " .$launchDict;
			//запись строки в журнал
                        mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launchDict)."','".mysql_real_escape_string($path.$filename)."', 0)");
			
		}
		else {	

			if (file_exists($path.$dict1) && file_exists($path.$dict2)){//существуют оба частотных списка	
				
				$launch .= " -f $dict2 -h $dict1 -b".$_GET['b'];
				
				echo "<br>три ".$launch;
				mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launch)."','".mysql_real_escape_string($path.$filename)."', 0)");
			}	
						
			if (file_exists($path.$dict1)&&  !file_exists($path.$dict2)){//no nGram freqdict
				echo "<br>запускаю программу раз и как-то сохраняю результат".$launchDict;	
				
                     		 mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launchDict)."','".mysql_real_escape_string($path.$dict2)."', 0)");
				
				$launch .= " -f $dict2 -h $dict1 ";//надо по dict1 прописать в перл. программе подсчёт частот
				echo "<br>запускаю программу два  ".$launch;
                        	
				mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launch)."','".mysql_real_escape_string($path.$filename)."', 0)");
			}

			
			if (!file_exists($path.$dict1) &&  file_exists($path.$dict2)){ //no unigram freqDict
				
				echo "<br>униграммный ".$launchDict1;
				mysql_query("insert into journal values(NULL'".mysql_real_escape_string($launchDict1)."','".mysql_real_escape_string($path.$dict1)."', 0)");
				
				$launch .= " -f $dict2 -h $dict1 ";
				echo "<br>запускаю программу два  ".$launch;
                        	
				mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launch)."','".mysql_real_escape_string($path.$filename)."', 0)");
			}

			if (!file_exists($path.$dict1)&&  !file_exists($path.$dict2)){ //no both freqDict
				echo "<br> вот же не повезло<br>";
				if ($_GET['metricR'] == "tscore"){ $launchDict .= " -n2";}
				
				echo "<br>раз ".$launchDict;
				mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launchDict)."','".mysql_real_escape_string($path.$dict2)."', 0)");
				
		//		print "<br>код ошибки: ". mysql_error();
				
				echo "<br>два ".$launchDict1;
				mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launchDict1)."','".mysql_real_escape_string($path.$dict1)."', 0)");
				
		//		print "<br>код ошибки: ". mysql_error();

				$launch .= " -f $dict2 -h $dict1 -b".$_GET['b'];
				
				echo "<br>три ".$launch;
				mysql_query("insert into journal values(NULL,'".mysql_real_escape_string($launch)."','".mysql_real_escape_string($path.$filename)."', 0)");
				
		//		print "<br>код ошибки: ". mysql_error();
			}	
		}

	}

//не печатает таблицу!
	
	$result = mysql_query("select * from journal");
	if ($result){
		print_journal($result);
	}
	function print_journal($received){
		$i = 0; $th ="<tr><td>номер"; $td='';
		$table ="<table border = 1>";
		while ($line = mysql_fetch_assoc($received)){
			if ($i ==0){
				foreach ($line as $k => $v){
					$th = $th."<th>$k";
				}
			}
			$i++;
			$td=$td."<tr><td>$i";
			foreach ($line as $k => $v){
				$td = $td."<td>$v";
			}
		}
		$table = $table.$th.$td."</table>";
		return $table;
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
