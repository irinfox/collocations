# Documentation #

<p><font color='#DC143C'><b>bigram_TSMI.pl</b></font>
<br>
<p><i>Описание:</i> Считает абсолютную частоту, MI, t-score для биграмм.</p>
<p><i>На вход:</i> Текст, вытянутый в строку-столбец (одно слово - одна строка).</p>
<p><i>Выход:</i> файл с префиксом <code>2_TSMI_all_</code>, в котором 4 столбца(лемма, абс.частота, MI, t-score).</p>
<p><i>Запуск:</i> perl programName fileName</p>
<br><br>



<p><font color='#DC143C'><b>count_freqs_new.pl</b></font>
<br>
<p><i>Описание:</i> Считает относительную частоту однословных конструкций, биграмм,    3-5грамм; MI для 2-5грамм, t-score для биграмм.<br>
<p><i>На вход:</i> Лемматизированный aot’ом текст. (лемматизированный текст с первым столбцом словоформ, вторым столбцом лемм).<br>
<p><i>Выход:</i>  10 файлов, файлы для относительных частот с префиксами <code>_1_,   _2_,_3_,_4_,_5_</code>; файлы длы MI c префиксами <code>_MI_2_,_MI_3_,_MI_4_,_MI_5_</code>;файл для t-score с префиксом <code>_TS_2_</code>. Каждый файл также имеет постфикс <code>_w</code> или <code>_l</code> в зависимости от выбранного параметра. В файлах для отсносительных частот 4 столбца: лемма/словоформа, абс. частота, отн. частота, ipm. В файлах для MI и T-score выводятся только сами коллокации и посчитанные для них меры.<br>
<p><i>Запуск:</i> perl programName fileName w|l<br>
Параметр w- для подсчёта словоформ, l – для подсчёта лемм. Без этих параметров программа не работает.<br>
<p><i>Примечание:</i> На данный момент в программе вручную проставляются пороги отсечения для метрики MI.<br>
<br><br>


<p><font color='#DC143C'><b>split_to_words.pl</b></font>
<br>
<p><i>Описание:</i> Программа вытягивает текстовый файл в строку (слово-строка).Снабжена подсказками и параметрами.<br>
<p><i>На вход:</i> Любой текстовый файл в кодировке utf8.<br>
<p><i>Выход:</i> Вытянутый в соответствии с заданными параметрами в строку файл. Для записи в отдельный файл необходимо использовать перенаправление STDOUT (оператор >).<br>
<p><i>Запуск:</i> perl programName -requiredParameters -additionalParameters > destinationFile <br>
Среди requiredParameters: <br>
<blockquote>-f - для чтения из файла, <br>
(тогда строка запуска будет выглядеть следующим образом: perl programName -f fileName -additionalParameters > destinationFile)<br>
-i - для чтения из стандартного входа (STDIN; из консоли. <br>
Среди additionalParameters: <br>
-l - для приведения текста к нижнему регистру, <br>
-p - для игнорирования пунктуации. <br>
При неправильном запуске программы она (программа) выдаст подсказку. <br><br><br></blockquote>

<p><font color='#DC143C'><b>metrics_abs_new</b></font>
<br>
<p><i>Описание:</i> Считает абсолютную частоту для однословных конструкций и биграмм и MI, t-score для биграмм.</p>
<p><i>На вход:</i> Текст, вытянутый в строку-столбец (одно слово - одна строка).</p>
<p><i>Выход:</i> 4 файла: файлы для абсолютных частот с префиксами <code>1_, 2_</code> и файлы для MI, t-score с префиксами <code>2_MI, 2_TS</code> соответственно. В файлах для MI и t-score 3 столбца, разделённых tab: коллокация, абс.частота, метрика (MI, t-score; с 12 знаками после запятой) </p>
<p><i>Запуск:</i> perl programName fileName</p>
<br><br>

<p><font color='#DC143C'><b>count_freqs.pl</b></font>
<br>
<p><i>Описание:</i> Считает абсолютную частоту и ipm для однословных конструкций, биграмм, биграмм через одно слово и триграмм. Берутся частоты не меньше 4</p>
<p><i>На вход:</i> Текст, вытянутый в строку-столбец (одно слово - одна строка).</p>
<p><i>Выход:</i> 4 файла: файл для однословных конструкций с префиксом <code>1_</code>, для биграмм (2 слова подряд) - <code>1-2_</code>, для биграмм через одно слово - <code>1-3_</code>, для триграмм - <code>1-2-3</code>. Во всех файлах есть столбцы, отделённые друг от друга tab: коллокация, абс.частота, ipm. В файле для биграмм через одно слово пропущенное слово заменено <code>*</code> (звёздочкой)</p>
<p><i>Запуск:</i> perl programName fileName</p>
<br><br>


<h2>Программы для работы с большими текстовыми файлами</h2>
<br><br>
<p><font color='#DC143C'><b>count_freqs_part.pl</b></font>
<br>
<p><i>Описание:</i> Разбивает исходный файл по миллиону строк и для каждого из них считает абсолютные частоты однословных конструкций, биграмм и 3-5грамм.<br>
<p><i>На вход:</i> Лемматизированный вытянутый в строку файл в кодировке utf8.<br>
<p><i>Выход:</i>Много файлов с префиксами <code>миллион_грамма_исходноеИмяФайла</code>, например, имя файла с посчитанными 5граммами для второго миллиона строк будет выглядеть так <code>2000000_5_fileName</code>. Файл в котором меньше миллиона строк (остаток) будет иметь первым префиксом tail (<code>tail_N_fileName</code>, N - номер граммы)<br>
<p><i>Запуск:</i> perl programName fileName<br><br>


<p><font color='#DC143C'><b>merge.pl</b></font>
<br>
<p><i>Описание:</i> Сливает файлы из заданной директории в один и суммирует частоты повторяющихся слов. Удобна для записи результатов предыдущей программы (<code>count_freqs_part.pl</code>) в один файл; заранее требуется разложить 1-5граммы для каждого миллиона по папкам.<br>
<p><i>На вход:</i> Директория.<br>
<p><i>Выход:</i> Текстовый файл.<br>
<p><i>Запуск:</i> perl programName directoryName destinationFileName <br><br>

<p><font color='#DC143C'><b>metrics_2.pl</b></font>
<br>
<p><i>Описание:</i> Считает MI и t-score для биграмм.<br>
<p><i>На вход:</i> Текстовые файлы с абсолютными частотами для однословных конструкций и биграмм и файл, имя которого будет использоваться, в образовании имён результирующих файлов.<br>
<p><i>Выход:</i> 2 текстовых файла с посчитанными MI и t-score с соответствующими префиксами <code>2_MI_</code> и <code>2_TS_</code> к имени результирующего файла.<br>
<p><i>Запуск:</i> perl programName 1_fileName 2_fileName destinationFileName<br>
(Пояснение: на выходе появятся файлы <code>2_MI_destinationFileName</code> и <code>2_TS_destinationFileName</code>)<br><br>

<h2>Cosegment</h2>
<br><br>

<p><font color='#DC143C'><b>cosegment</b></font>
<br>
<p><i>Описание:</i> Свободно распространяемая программа для обработки текста <a href='http://donelaitis.vdu.lt/~vidas/tools.htm'>http://donelaitis.vdu.lt/~vidas/tools.htm</a>. Работает в 2 прохода. При первом проходе считает коэффициент Dice для двусловных сочетаний, учитывая всю коллекцию. При втором проходе склеивает в сегменты слова, для которых коэф. Dice оказался выше среднего арифметического (по коэф.), между словами, для которых коэффициент Dice ниже среднего ставится разрыв. В результате такой обработки текст разбивается на сегменты переменной длины(, что удобно для извлечения терминологии из корпуса текстов и сравнимо с тем, что делают информанты при раставлении связности между словами).<br>
<p><i>На вход:</i> Текстовые файлы в кодировке utf-8 (точнее, корпус текстовых файлов), токенизированные и приведённые к нижнему регистру. Они должны быть положены в папку corpus (программа работает с файлами только из этой папки).<br>
<p><i>Выход:</i> Обработанные из папки corpus файлы с именами <code>fileName.c</code>, положенные в ту же папку corpus. Файл представляет из себя текст, разбитый на сегменты, слова, находящиеся в одном сегменте соединены нижним подчёркиванием <code>(_)}}. А также файл {{{collocations_abc.txt</code>, в котором сегменты представлены в виде частотного словаря, упорядоченного по алфавиту, и файл <code>collocations_freq.txt</code>, в котором сегменты представлены в виде частотного словаря и упорядочены по частоте. Последние 2 файла оказываются в той же папке, что и программа cosegment (т.е. НЕ в папке corpus).<br>
<p><i>Запуск:</i> ./programName<br>
<p><i>Примечание:</i> Программы предварительной обработки файлов tokenizer.pl и lowercase.pl работают только для файлов на английском языке.<br><br>


<p><font color='#DC143C'><b>prepare.pl</b></font>
<br>
<p><i>Описание:</i> Программа предварительной обработки файла для cosegment'a для файлов на русском языке. Токенизирует текст, приводит слова к нижнему регистру, между знаками препинания (знаком препинания и словом, в том числе) ставит пробелы.<br>
<p><i>На вход:</i> Текстовые файлы в кодировке utf-8. Нужно положить все необходимые для обработки файлы в папку corpus.<br>
<p><i>Выход:</i> Текстовый файл с расширением .plain (fileName.plain).<br>
<p><i>Запуск:</i> perl programName <br><br>

<p><font color='#DC143C'><b>prepare_lemma.pl</b></font>
<br>
<p><i>Описание:</i> Составляет из лемматизированного текста текст (текст из лемм).<br>
<p><i>На вход:</i> Лемматизированный текстовый файл в кодировке utf-8 со вторым столбцом, представленным в виде лемм.<br>
<p><i>Выход:</i>  Текстовый файл с расширением .plain (fileName.plain).<br>
<p><i>Запуск:</i> perl programName fileName <br><br>

<p><font color='#DC143C'><b>clear_res.pl</b></font>
<br>
<p><i>Описание:</i> Нередко знаки препинания оказываются очень частотными и поднимаются наверх файла <code>collocations_freq.txt</code>, что затрудняет восприятие обработанного текста. Эта программа удаляет знаки препинания из данного файла, оказавшиеся наверху списка. Программа должна находиться в одной папке с <code>collocations_freq.txt</code>.<br>
<p><i>На вход:</i> <code>collocations_freq.txt</code>.<br>
<p><i>Выход:</i> Текстовый файл с именем <code>collocations_freq.txt_clear</code>.<br>
<p><i>Запуск:</i> perl programName<br><br>

<h2>TF*IDF</h2>
<br><br>
<p><font color='#DC143C'><b>tfidf.pl</b></font>
<br>
<p><i>Описание:</i> Считает метрику tf*idf для лемматизированных файлов в 2 прохода. На первом проходе подсчитывается idf (кол-во документов, содержащих слова), на втором tf*idf.<br>
<p><i>На вход:</i> Папка с лемматизированными текстами (первый столбец - словоформы, второй - леммы). Каждый текст в отдельном файле. Кодировка utf8.<br>
<p><i>Выход:</i> Имена файлов: <code>fileName_tfidf_w или fileName_tfidf_l</code>. Файлов столько же, сколько и исходных. Во всех файлах есть столбцы, отделённые друг от друга tab: слово (косегмент), tfidf, tf, idf. Выходные данные отсортированы по значениям метрики tfidf. Выходные файлы сохраняются в папке, из которой запускается программа.<br>
<p><i>Запуск:</i> perl programName dirName w|l<br>
Параметр w- для подсчёта словоформ, l – для подсчёта лемм.<br>
<br><br>


<p><font color='#DC143C'><b>cut_clust.pl</b></font>
<br>
<p><i>Описание:</i> Программа для разбиения файла-коллекции на отдельные файлы-тексты. Программа разбивает текст по разделителю base. Если в коллекции использован другой разделитель, то данная программа не подходит для разбиения коллекции на отдельные файлы.<br>
<p><i>На вход:</i> Файл-коллекция.<br>
<p><i>Выход:</i>
<p><i>Запуск:</i> perl programName fileName<br>
<br><br>

<h2>Специализированные программы подсчёта частот</h2>
<br>
<p><i>Описание:</i> Данные программы считают частоты (абсолютную, относительную и ipm) для 1-5 грамм с частеречными фильтрами.<br>
<p><i>На вход:</i> Лемматизированный файл в кодировке utf8, в первом столбце которого леммы, во втором - словоформы, в третьем - граммемы.<br>
<p><i>Выход:</i> Файл с именем <code>fileName_progNameAfterCount</code>. В файле 4 столбца: коллокация, абс. частота, относительная частота, ipm.<br>
<p><i>Запуск:</i> perl programName fileName<br>
<br><br>
<p><font color='#DC143C'><b>count_nouns.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по леммам для существительных (коллокация состоит из цепочки слов, одно из которых существительное. Можно посмотреть на существительное в контексте).<br>
<br><br>
<p><font color='#DC143C'><b>count_nouns_adj.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по леммам для существительных и прилагательных(коллокация может состоять только из существительного и прилагательного, идущих в любом порядке).<br>
<br><br>
<p><font color='#DC143C'><b>count_nouns_adj_verb.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по леммам для существительных, прилагательных и глаголов (коллокация может состоять только из существительного, прилагательного и глагола, идущих подряд).<br>
<br><br>
<p><font color='#DC143C'><b>count_nouns_adj_verb_words.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по словоформам для существительных, прилагательных и глаголов (коллокация может состоять только из существительного, прилагательного и глагола).<br>
<br><br>
<p><font color='#DC143C'><b>count_nouns_adj_words.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по словоформам для существительных и прилагательных (коллокация может состоять только из существительного и прилагательного).<br>
<br><br>
<p><font color='#DC143C'><b>count_nouns_words.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по словоформам для существительных(коллокация может состоять только из существительных).<br>
<br><br>
<p><font color='#DC143C'><b>count_verbs.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по леммам для глаголов (коллокация может состоять только из глаголов).<br>
<br><br>
<p><font color='#DC143C'><b>count_verbs_words.pl</b></font>
<br>
<p><i>Описание:</i> Считает частоты по словоформам для глаголов (коллокация может состоять только из глаголов).<br>
<br><br>