Generate the code needed to reproduce any sas table using sql inserts or datalines or R

github
https://tinyurl.com/vzjyazt
https://github.com/rogerjdeangelis/utl-generate-the-code-needed-to-reproduce-any-sas-table-using-sql-inserts-or-datalines-or-R

It is interesting that R does the best job of recreating a SAS dataset from raw data.
R captures more meta data, like labels and formats.
Unfortunately WPS/R has removed command line processing
so we have no way to create a SAS dataset with WPS(unless we use the inconvienent intertative interface)

Related to
https://tinyurl.com/rxw25xs
https://communities.sas.com/t5/SAS-Procedures/Is-it-possible-to-get-code-that-will-replicate-an-existing-table/m-p/632147#M77781

Generate the code needed to reproduce any sas table using sql inserts or datalines or R

    Three Solutions

        a. Macro data2datastep  (enhance to put dataset creation code into the clipboard)
           https://tinyurl.com/r8epgs8

           %data2datastep(dsn,file);
           file is optional
           generated code is written to
               1. log
               2. clipbrd (just paste it where you want it)
               3. To a file if requested

        b. tagset sql (enhanced to output sql inserts to clipboard and log)
           Tagset code https://tinyurl.com/wdhh89u
           SQL insert  https://tinyurl.com/syk5wtb


           Usefull to insert data into any relational database
           All charater variables are 200 bytes.
           You probably will want to do minor edits to the generated code

           Limited functionality does not handle dates, formats, labels, indexes ... only float, integer and character?
           Does not work well with fat tables

           You need to do this once to store the template in sasuser.templates;

           download https://tinyurl.com/wdhh89u
           I put it in c:/oto/tagsets_sql.sas

           ods _all_ close;
           libname odslib v9 "%sysfunc(pathname(sasuser))";
           ods path odslib.templates sashelp.tmplmst sasuser.templates(update);
           %inc "c:/oto/tagsets_sql.sas";
           ods listing;

           2               ods _all_ close;
           3                libname odslib v9 "%sysfunc(pathname(sasuser))";
           NOTE: Libref ODSLIB refers to the same physical library as SASUSER.
           NOTE: Libref ODSLIB was successfully assigned as follows:
                 Engine:        V9
                 Physical Name: c:\etc
           4                ods path odslib.templates sashelp.tmplmst sasuser.templates(update);
           5                %inc "c:/oto/tagsets_sql.sas";
           NOTE: Overwriting existing template/link: Tagsets.SQL
           NOTE: TAGSET 'Tagsets.SQL' has been saved to: SASUSER.TEMPLATES
           NOTE: PROCEDURE TEMPLATE used (Total process time):
                 real time           0.01 seconds
                 cpu time            0.00 seconds

        c. R dput


enhanced data2datastep
https://tinyurl.com/r8epgs8
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories/blob/master/data2datastep.sas

tagsets_sql  (enhanced)
https://tinyurl.com/wdhh89u
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories/blob/master/tagsets_sql.sas

SQL insert macro
https://tinyurl.com/syk5wtb
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories/blob/master/utl_sqlinsert.sas

XPT2LOC * convert V8 tansport file to SAS dataset (I don't believe Python, PERL can read a V* transport - consider V5)
https://tinyurl.com/whqhyna
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories/blob/master/xpt2loc.sas

related githib (old more limited version)
https://tinyurl.com/y6o4n943
https://github.com/rogerjdeangelis/utl_excel_create_sql_insert_and_value_statements_to_update_databases

*              _       _        ____     _       _            _
  __ _      __| | __ _| |_ __ _|___ \ __| | __ _| |_ __ _ ___| |_ ___ _ __
 / _` |    / _` |/ _` | __/ _` | __) / _` |/ _` | __/ _` / __| __/ _ \ '_ \
| (_| |_  | (_| | (_| | || (_| |/ __/ (_| | (_| | || (_| \__ \ ||  __/ |_) |
 \__,_(_)  \__,_|\__,_|\__\__,_|_____\__,_|\__,_|\__\__,_|___/\__\___| .__/
 _                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data class(label="Math Class");
  set sashelp.class;
  format sex $5.;
  label sex = "gender";
run;quit;

WORK.CLASS total obs=19

   NAME       SEX    AGE    HEIGHT    WEIGHT

   Joyce       F      11     51.3       50.5
   Louise      F      12     56.3       77.0
   Alice       F      13     56.5       84.0
   James       M      12     57.3       83.0
   Thomas      M      11     57.5       85.0
   John        M      12     59.0       99.5

 Variables in Creation Order

#    Variable    Type    Len

1    NAME        Char      8
2    SEX         Char      1
3    AGE         Num       8
4    HEIGHT      Num       8
5    WEIGHT      Num       8

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

* The generated code is placed in the log and clipbrd;
* if a file is is specified then the code will also be in the file;

I you do not specify a table this will appear in the output not in the log;

*** Please Provide a table ***
*** Please Provide a table ***
*** Please Provide a table ***


* 'ctl V' to paste or copy from log;

data WORK.CLASS;
  infile datalines dsd truncover;
  input NAME:$8. SEX:$1. AGE:32. HEIGHT:32. WEIGHT:32.;
datalines4;
Joyce,F,11,51.3,50.5
Louise,F,12,56.3,77
Alice,F,13,56.5,84
James,M,12,57.3,83
Thomas,M,11,57.5,85
John,M,12,59,99.5
Jane,F,12,59.8,84.5
Janet,F,15,62.5,112.5
Jeffrey,M,13,62.5,84
Carol,F,14,62.8,102.5
Henry,M,14,63.5,102.5
Judy,F,14,64.3,90
Robert,M,12,64.8,128
Barbara,F,13,65.3,98
Mary,F,15,66.5,112
William,M,15,66.5,112
Ronald,M,15,67,133
Alfred,M,14,69,112.5
Philip,M,16,72,150
;;;;
run;quit

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

* create input;
data class(label="Math Class");
  set sashelp.class;
  format sex $5.;
  label sex = "gender";
run;quit;


* download data2datastep;
* https://tinyurl.com/r8epgs8j
* I copy to my autocall library;
%inc "c:/oto/data2datastep.sas";

%data2datastep;
%data2datastep(class);
%data2datastep(class,file=d:/sas/gencde.sas);

* paste the code wherever you want it;

*_                  _   _                       _
| |__     ___  __ _| | | |_ __ _  __ _ ___  ___| |_
| '_ \   / __|/ _` | | | __/ _` |/ _` / __|/ _ \ __|
| |_) |  \__ \ (_| | | | || (_| | (_| \__ \  __/ |_
|_.__(_) |___/\__, |_|  \__\__,_|\__, |___/\___|\__|
                 |_|             |___/
 _                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

SASHELP.CITIYR


Up to 40 obs from SASHELP.CITIYR total obs=10

Obs     DATE      PAN      PAN17     PAN18     PANF      PANM

  1     7305    227757    172456    138358    116869    110888
  2     7671    230138    175017    140618    118074    112064
  3     8036    232520    177346    142740    119275    113245
  4     8401    234799    179480    144591    120414    114385
  5     8766    237001    181514    146257    121507    115494
  6     9132    239279    183583    147759    122631    116648
  7     9497    241625    185766    149149    123795    117830
  8     9862    243942    187988    150542    124945    118997
  9    10227    246307    189867    152113    126118    120189
 10    10593    248762    191570    153695    127317    121445

You need to do this once to store the template in sasuser.templates;

download https://tinyurl.com/wdhh89u
I put it in c:/oto/tagsets_sql.sas

ods _all_ close;

libname odslib v9 "%sysfunc(pathname(sasuser))";
ods path odslib.templates sashelp.tmplmst sasuser.templates(update);
%inc "c:/oto/tagsets_sql.sas";

ods listing;

WHAT THE LOG SHOULD LOOK LIKE

2               ods _all_ close;
3                libname odslib v9 "%sysfunc(pathname(sasuser))";
NOTE: Libref ODSLIB refers to the same physical library as SASUSER.
NOTE: Libref ODSLIB was successfully assigned as follows:
      Engine:        V9
      Physical Name: c:\etc
4                ods path odslib.templates sashelp.tmplmst sasuser.templates(update);
5                %inc "c:/oto/tagsets_sql.sas";
NOTE: Overwriting existing template/link: Tagsets.SQL
NOTE: TAGSET 'Tagsets.SQL' has been saved to: SASUSER.TEMPLATES
NOTE: PROCEDURE TEMPLATE used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds

YOU ALSO NEED THIS MACRO;

* you can download from https://tinyurl.com/syk5wtb;

%macro utl_sqlinsert(dsn)/des="send sql insert code to the log and clipbord paste buffer";

   options ls=256;

   filename tmp temp lrecl=4096;

   ods tagsets.sql file=tmp;

   proc print data=&dsn;
   run;quit;

   ods _all_ close; ** very important;

   filename clp clipbrd;
   data _null_;
    retain flg 0;
    length once $255 remain $255;
    infile tmp end=dne;
    file clp;
    input;
    select;
       when (_n_ < 3)  do;
           put _infile_;
           putlog _infile_;
       end;
       when (_infile_=:"Insert into" and flg=0)  do;
          flg=1;
          once=cats(scan(_infile_,1,')'),')');
          remain=cats(scan(_infile_,2,')'),')');
          put once;
          putlog once;
          put remain;
          putlog remain;
       end;
       when (_infile_=:"Insert into") do;
          remain=cats(scan(_infile_,2,')'),')');
          put remain;
          putlog remain;
       end;
       * leave otherwise off to force error;
    end;
    if dne then do;
         putlog ';quit;';
         put ';quit;';
    end;
   run;quit;

   filename tmp clear;

   ods listing;

   options ls=255;

%mend utl_sqlinsert;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_sqlinsert(sashelp.citiyr);

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

Just ctl v (copy from paste buffer)
or highlight code in loag and copy to your program

proc sql;
 Create table citiyr(date float, pan float, pan17 float, pan18 float, panf float, panm float);
Insert into citiyr(date, pan, pan17, pan18, panf, panm)
Values(1980, 227757, 172456, 138358, 116869, 110888)
Values(1981, 230138, 175017, 140618, 118074, 112064)
Values(1982, 232520, 177346, 142740, 119275, 113245)
Values(1983, 234799, 179480, 144591, 120414, 114385)
Values(1984, 237001, 181514, 146257, 121507, 115494)
Values(1985, 239279, 183583, 147759, 122631, 116648)
Values(1986, 241625, 185766, 149149, 123795, 117830)
Values(1987, 243942, 187988, 150542, 124945, 118997)
Values(1988, 246307, 189867, 152113, 126118, 120189)
Values(1989, 248762, 191570, 153695, 127317, 121445)
;quit;


*         ____        _             _
  ___    |  _ \    __| |_ __  _   _| |_
 / __|   | |_) |  / _` | '_ \| | | | __|
| (__ _  |  _ <  | (_| | |_) | |_| | |_
 \___(_) |_| \_\  \__,_| .__/ \__,_|\__|
                       |_|
 _                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.citiyr;
  set sashelp.citiyr(obs=5 keep=date pan pan17);;
run;quit;

Up to 40 obs from SD1.CITIYR total obs=5

Obs    DATE      PAN      PAN17

 1     7305    227757    172456
 2     7671    230138    175017
 3     8036    232520    177346
 4     8401    234799    179480
 5     8766    237001    181514


Variables in Creation Order

 Variable    Type    Len    Format    Label

 DATE        Num       6    YEAR4.    Date of Observation
 PAN         Num       7              POPULATION EST.: ALL AGES, INC.ARMED F.
 PAN17       Num       7              POPULATION EST.: 16 YRS AND OVER,INC ARM


*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

R DATAFRAME

  DATE    PAN  PAN17
1 7305 227757 172456
2 7671 230138 175017
3 8036 232520 177346
4 8401 234799 179480
5 8766 237001 181514


* gets labels and formats;

'data.frame':   5 obs. of  3 variables:
 $ DATE : num  7305 7671 8036 8401 8766
  ..- attr(*, "label")= chr "Date of Observation"

  Has format information
  ====================================
  ..- attr(*, "format.sas")= chr "YEAR"
  =====================================

 $ PAN  : num  227757 230138 232520 234799 237001
  ..- attr(*, "label")= chr "POPULATION EST.: ALL AGES, INC.ARMED F."
 $ PAN17: num  172456 175017 177346 179480 181514
  ..- attr(*, "label")= chr "POPULATION EST.: 16 YRS AND OVER,INC ARM"
 - attr(*, "label")= chr "CITIYR"

SAS DATASET

Up to 40 obs from WANT total obs=5

Obs    DATE      PAN      PAN17

 1     7305    227757    172456
 2     7671    230138    175017
 3     8036    232520    177346
 4     8401    234799    179480
 5     8766    237001    181514


Variables in Creation Order

#    Variable    Type    Len    Label

1    DATE        Num       8    Date of Observation                      ==> kas labels
2    PAN         Num       8    POPULATION EST.: ALL AGES, INC.ARMED F.
3    PAN17       Num       8    POPULATION EST.: 16 YRS AND OVER,INC ARM

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

proc datasets lib=work;
  delete want;
run;quit;

%utlfkil(d:/xpt/want.xpt);

%utl_submit_r64('
library(haven);
have<-as.data.frame(read_sas("d:/sd1/citiyr.sas7bdat"));
dput(have);
');

* copy from log and insert in code below;

%utl_submit_r64('
library(SASxport);
library(haven);
class<-structure(list(
    DATE = structure(c(7305, 7671, 8036, 8401, 8766), label = "Date of Observation", format.sas = "YEAR"),
    PAN  = structure(c(227757,230138, 232520, 234799, 237001), label = "POPULATION EST.: ALL AGES, INC.ARMED F."),
    PAN17 = structure(c(172456, 175017, 177346, 179480, 181514), label = "POPULATION EST.: 16 YRS AND OVER,INC ARM")),
label = "CITIYR", row.names = c(NA,-5L), class = "data.frame");
class;
str(class);
write_xpt(as.data.frame(class),"d:/xpt/want.xpt",version=8);
');

%xpt2loc(libref=work,
   memlist=_all_,
   filespec='d:/xpt/want.xpt' );

proc print data=want;
run;quit;


*
 _ __ ___   __ _  ___ _ __ ___  ___
| '_ ` _ \ / _` |/ __| '__/ _ \/ __|
| | | | | | (_| | (__| | | (_) \__ \
|_| |_| |_|\__,_|\___|_|  \___/|___/
     _       _        ____     _       _            _
  __| | __ _| |_ __ _|___ \ __| | __ _| |_ __ _ ___| |_ ___ _ __
 / _` |/ _` | __/ _` | __) / _` |/ _` | __/ _` / __| __/ _ \ '_ \
| (_| | (_| | || (_| |/ __/ (_| | (_| | || (_| \__ \ ||  __/ |_) |
 \__,_|\__,_|\__\__,_|_____\__,_|\__,_|\__\__,_|___/\__\___| .__/
                                                           |_|
;
%macro data2datastep(dsn,file);

%local varlist ;

* write message to output not log because lag has source;
%let rc=%sysfunc(dosubl('
  data _null_;
       file print;
       if "&dsn" ="" then do;
           put "*** Please Provide a table ***";
           put "*** Please Provide a table ***";
           put "*** Please Provide a table ***";
       end;
   run;quit;
'));

%if "%scan(&dsn,2,%str(.))" = "" %then %do;
  %let lib=%upcase(work);
  %let dsn=%upcase(&dsn);
%end;
%else %do;
   %let lib=%upcase(%scan(&dsn,1,%str(.)));
   %let dsn=%upcase(%scan(&dsn,2,%str(.)));
%end;

%if "&dsn" ^= "" %then %do;

    proc sql noprint;
      select Name
          into :varlist separated by ' '
       from dictionary.columns
       where libname="&lib"
         and memname="&dsn"
    ;
      select case type
              when 'num' then
                 case
                    when missing(format) then cats(Name,':32.')
                    else cats(Name,':',format)
                 end
              else cats(Name,':$',length,'.')
           end
          into :inputlist separated by ' '
       from dictionary.columns
       where libname="&lib"
         and memname="&dsn"
    ;
    quit;

    %if %superq(file)= %then %do;
       filename __out dummy;
    %end;
    %else %do;
       filename __out "&file";
    %end;

    filename __dm clipbrd;

    data _null_;
       if _n_ =1 then do;
          file __out dsd;
          put "data &lib..&dsn;";
          put @3 "infile datalines4 dsd truncover;";
          put @3 "input %superq(inputlist);";
          put "datalines4;";
          file __dm dsd;
          put "data &lib..&dsn;";
          put @3 "infile datalines dsd truncover;";
          put @3 "input %superq(inputlist);";
          put "datalines4;";
          file log dsd;
          put "data &lib..&dsn;";
          put @3 "infile datalines dsd truncover;";
          put @3 "input %superq(inputlist);";
          put "datalines4;";
       end;
       set &lib..&dsn end=last;
       file __out dsd;
       put &varlist @;
       file __dm dsd;
       put &varlist @;
       file log dsd;
       put &varlist @;
       if last then do;
          file __out dsd;
          put;
          put ';;;;';
          put 'run;quit';
          file __dm dsd;
          put;
          put ';;;;';
          put 'run;quit';
          file log dsd;
          put;
          put ';;;;';
          put 'run;quit';
       end;
       else do;
          file __out dsd;
          put;
          file __dm dsd;
          put;
          file log dsd;
          put;
      end;
    run;

%end;

%mend data2datastep;

*      _   _               _     _                     _
 _   _| |_| |    ___  __ _| |   (_)_ __  ___  ___ _ __| |_
| | | | __| |   / __|/ _` | |   | | '_ \/ __|/ _ \ '__| __|
| |_| | |_| |   \__ \ (_| | |   | | | | \__ \  __/ |  | |_
 \__,_|\__|_|___|___/\__, |_|___|_|_| |_|___/\___|_|   \__|
           |_____|      |_||_____|
;

%macro utl_sqlinsert(dsn)/des="send sql insert code to the log and clipbord paste buffer";

   options ls=256;

   filename tmp temp lrecl=4096;

   ods tagsets.sql file=tmp;

   proc print data=&dsn;
   run;quit;

   ods _all_ close; ** very important;

   filename clp clipbrd;
   data _null_;
    retain flg 0;
    length once $255 remain $255;
    infile tmp end=dne;
    file clp;
    input;
    select;
       when (_n_ < 3)  do;
           put _infile_;
           putlog _infile_;
       end;
       when (_infile_=:"Insert into" and flg=0)  do;
          flg=1;
          once=cats(scan(_infile_,1,')'),')');
          remain=cats(scan(_infile_,2,')'),')');
          put once;
          putlog once;
          put remain;
          putlog remain;
       end;
       when (_infile_=:"Insert into") do;
          remain=cats(scan(_infile_,2,')'),')');
          put remain;
          putlog remain;
       end;
       * leave otherwise off to force error;
    end;
    if dne then do;
         putlog ';quit;';
         put ';quit;';
    end;
   run;quit;

   filename tmp clear;

   ods listing;

   options ls=255;

%mend utl_sqlinsert;

*_                       _                 _
| |_ __ _  __ _ ___  ___| |_     ___  __ _| |
| __/ _` |/ _` / __|/ _ \ __|   / __|/ _` | |
| || (_| | (_| \__ \  __/ |_    \__ \ (_| | |
 \__\__,_|\__, |___/\___|\__|___|___/\__, |_|
          |___/            |_____|      |_|
;

/*------------------------------------------------------------eric-*/
/*-- This tagset creates sql statements to create a table        --*/
/*-- and insert all the records in the dataset.  The resulting   --*/
/*-- output will have the table create statement followed by     --*/
/*-- the insert statements.                                      --*/
/*--                                                             --*/
/*-- This has only been tested with proc print, although it may  --*/
/*-- Work with other proc's as well.                             --*/
/*--                                                             --*/
/*-- This isn't anything fancy, all it handles are strings,      --*/
/*-- integers and numbers.  It could do more by using the        --*/
/*-- value of sasformat.                                         --*/
/*---------------------------------------------------------12Feb04-*/

proc template ;
  define tagset tagsets.sql / STORE=sasuser.templates;

      /*---------------------------------------------------------------eric-*/
      /*-- Set up some look-up tables for convenience.                    --*/
      /*------------------------------------------------------------11Feb04-*/
      /* type translations */
      define event type_translations;
          set $types['string'] 'varchar';
          set $types['double'] 'float';
          set $types['int']    'integer';
      end;

      /* column name translation */
      define event name_translations;
          set $name_trans['desc'] 'description';
      end;

      define event initialize;
          trigger type_translations;
          trigger name_translations;

          /* types that need widths */
          set $types_with_widths['string'] "True";

          /* types that need quotes */
          set $types_with_quotes['string'] "True";
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Reset everything so we can run one proc print after another.   --*/
      /*------------------------------------------------------------11Feb04-*/
      define event table;
          unset $names;
          unset $col_types;
          unset $columns;
          unset $values;
          unset $lowname;
      end;


      define event colspec_entry;
          /*---------------------------------------------------------------eric-*/
          /*-- Ignore the obs column.  The value will get ignored because     --*/
          /*-- it will be in a header cell and we don't define a header       --*/
          /*-- event to catch it.                                             --*/
          /*------------------------------------------------------------12Feb04-*/
          break /if cmp(name, 'obs');

          /*---------------------------------------------------------------eric-*/
          /*-- Create a list of column names.  Translate the names            --*/
          /*-- if they are in the translate list.                             --*/
          /*------------------------------------------------------------11Feb04-*/
          set $lowname lowcase(name);
          do /if $name_trans[$lowname];
              set $names[] $name_trans[$lowname];
          else;
              set $names[] $lowname;
          done;

          /* keep a list of types */
          set $col_types[] type;

          /* make a list of column type definitions */
          set $col_def $types[type];

          /* append width if needed */
          /*set $col_def $col_def "(" width ")" /if $types_with_widths[type];*/
          set $col_def $col_def "(" "200" ")" /if $types_with_widths[type];

          set $columns[] $col_def;
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Catch the data label and get the data set name from it.        --*/
      /*------------------------------------------------------------11Feb04-*/
      define event output;
          start:
              set $table_name reverse(label);
              set $table_name scan($table_name, 1, '.');
              set $table_name reverse($table_name);
              set $table_name lowcase($table_name);
      end;

     /*---------------------------------------------------------------eric-*/
     /*-- Print out the create table statement before Any data           --*/
     /*-- rows come along.                                               --*/
     /*------------------------------------------------------------11Feb04-*/
      define event table_body;
          put "proc sql;" nl; put " Create table " $table_name "(";
          /* put "           "; */

          /* loop over the names, and column definitions */
          eval $i 1;
          unset $not_first;
          do /while $i <= $names;
              /* comma's only after the first name */
              put ', ' /if $not_first;
              put $names[$i] " ";
              put $columns[$i];
              eval $i $i+1;
              set $not_first "True";
          done;

          put ");" nl;
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Reset the values at the beginning of each row.  Print the      --*/
      /*-- insert statement at the end of each row.                       --*/
      /*------------------------------------------------------------11Feb04-*/
      define event row;
          start:
              unset $values;
          finish:
              trigger insert;
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Save away the data.  The Obs column won't hit this because     --*/
      /*-- it's a header.                                                 --*/
      /*------------------------------------------------------------12Feb04-*/
      define event data;
          do /if value;
              set $values[] strip(value);
          else;
              set $values[] ' ';
          done;
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Create the insert statement                                    --*/
      /*------------------------------------------------------------12Feb04-*/
      define event insert;
          finish:
              break /if ^$values;

              put "Insert into " $table_name;
              trigger print_names;
              put;
              put  " Values";
              trigger print_values;
              put ";" nl;
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Print the list of names.  This could use                       --*/
      /*-- a single putvars statement if it weren't for                   --*/
      /*-- the commas.                                                    --*/
      /*------------------------------------------------------------12Feb04-*/
      define event print_names;
          put "(";
          iterate $names;
          unset $not_first;
          do /while _value_;
              /* comma's only after the first name */
              put ", " /if $not_first;
              put lowcase(_value_);
              set $not_first "true";
              next $names;
          done;
          put ")";
      end;

      /*---------------------------------------------------------------eric-*/
      /*-- Print the values for the insert statement. Commas and quoting  --*/
      /*-- are an issue.  double up the quotes in strings.  Remove        --*/
      /*-- commas from numbers.                                           --*/
      /*------------------------------------------------------------12Feb04-*/
      define event print_values;
          put "(" ;

          eval $i 1;
          unset $not_first;

          iterate $values;

          do /while _value_;
              put ", " /if $not_first;

              do /if $types_with_quotes[$col_types[$i]];
                  put "'" ;
                  put tranwrd(_value_, "'", "''") /if ^cmp(_value_, ' ');
                  put "'";
              else;
                  do /if cmp(_value_, ' ');
                      put '0';
                  else;
                      put tranwrd(_value_, "," , "") ;
                  done;
              done;

              set $not_first "true";

              next $values;
              eval $i $i+1;
          done;

          put ")";
      end;

  end;
run;

