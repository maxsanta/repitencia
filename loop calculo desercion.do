//LOOP
//DESERCION

clear all
cd "D:\GRAFICA MDT\Documentos\SEMINARIO 2019\BASES DE DATOS"

local mylist 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 
foreach x of local mylist {
use mrun rbd sit_fin cod_grad cod_ense using Rendimiento20`x' //Rendimineto DB's contain 
keep if cod_ense==110
destring mrun, replace
drop if mrun==. //borro los sin mrun

sort mrun
quietly by mrun:  gen dup`x' = cond(_N==1,0,_n) //identifico los duplicados


preserve 
// voy a crear la bbdd de los duplicados, los que se retiraron de un colegio
drop if dup`x'==0 //saco los no duplicados
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin_R=1  if sit_fin=="R" //creo dummies 
replace sit_fin_P=1  if sit_fin=="P"
replace sit_fin_Y=1  if sit_fin=="Y"
collapse (max) dup`x' cod_grad cod_ense sit_fin_Y sit_fin_R sit_fin_P (last)rbd sit_fin ,by(mrun)
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
rename sit_fin sit_fin`x', replace
drop sit_fin_Y  sit_fin_R sit_fin_P 
rename cod_grad cod_grad`x' ,replace
rename cod_ense cod_ense`x' ,replace
rename rbd rbd`x'
save Rend_20`x'_duplicados, replace //bbdd duplicados
keep if sit_fin`x'=="Y"             //bbdd duplicados con situacion final retirados  
save Rend_20`x'_dup_Y_intra`x', replace //bbdd duplicados con situacion final retirados (desertores intra-año)
restore

preserve // voy a crear la bbdd de los no duplicados
keep if dup`x'==0 //saco los duplicados
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin_R=1  if sit_fin=="R" //creo dummies 
replace sit_fin_P=1  if sit_fin=="P"
replace sit_fin_Y=1  if sit_fin=="Y"
collapse (max) dup`x' cod_grad cod_ense sit_fin_Y sit_fin_R sit_fin_P (last)rbd sit_fin ,by(mrun)
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
rename sit_fin sit_fin`x', replace
drop sit_fin_Y  sit_fin_R sit_fin_P 
rename cod_grad cod_grad`x' ,replace
rename cod_ense cod_ense`x' ,replace
rename rbd rbd`x'
save Rend_20`x'_nonduplicados, replace //bbdd duplicados
keep if sit_fin`x'=="Y"             //bbdd duplicados con situacion final retirados  
save Rend_20`x'_nondup_Y_intra`x', replace //bbdd duplicados con situacion final retirados (desertores intra-año)
restore

preserve
clear
use Rend_20`x'_dup_Y_intra`x'
append using Rend_20`x'_nondup_Y_intra`x'
save Bdes_Y_intra`x', replace //bases con dup y non dup de alumnos que a fin de año estaban retirados Y
clear
restore

preserve
drop if dup`x'==0 //saco los no duplicados
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin_R=1  if sit_fin=="R" //creo dummies 
replace sit_fin_P=1  if sit_fin=="P"
replace sit_fin_Y=1  if sit_fin=="Y"
collapse (max) dup`x' cod_grad cod_ense sit_fin_Y sit_fin_R sit_fin_P (last)rbd sit_fin ,by(mrun)
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
rename sit_fin sit_fin`x', replace
drop sit_fin_Y  sit_fin_R sit_fin_P 
rename cod_grad cod_grad`x' ,replace
rename cod_ense cod_ense`x' ,replace
rename rbd rbd`x'
save Rend_20`x'_duplicados, replace //bbdd duplicados
drop if sit_fin`x'=="Y"             //bbdd duplicados con situacion final retirados  
save Rend_20`x'_dup_RyP_intra`x', replace //bbdd duplicados con situacion final retirados (desertores intra-año)
restore

preserve // voy a crear la bbdd de los no duplicados
keep if dup`x'==0 //saco los duplicados
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin_R=1  if sit_fin=="R" //creo dummies 
replace sit_fin_P=1  if sit_fin=="P"
replace sit_fin_Y=1  if sit_fin=="Y"
collapse (max) dup`x' cod_grad cod_ense sit_fin_Y sit_fin_R sit_fin_P (last)rbd sit_fin ,by(mrun)
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
rename sit_fin sit_fin`x', replace
drop sit_fin_Y  sit_fin_R sit_fin_P 
rename cod_grad cod_grad`x' ,replace
rename cod_ense cod_ense`x' ,replace
rename rbd rbd`x'
save Rend_20`x'_nonduplicados, replace //bbdd duplicados
drop if sit_fin`x'=="Y"             
save Rend_20`x'_nondup_RyP_intra`x', replace //bbdd duplicados con situacion final retirados (desertores intra-año)
restore


clear
use Rend_20`x'_dup_Y_intra`x'
append using Rend_20`x'_nondup_Y_intra`x'
save Bdes_RyP_intra`x', replace //bases con dup y non dup de alumnos que a fin de año estaban retirados Y

clear
use Rend_20`x'_duplicados
append using Rend_20`x'_nonduplicados
save Rend_20`x'_unificados, replace
clear


clear
}
*
//mini analisis
use Rend_2018_intra18.dta
keep if cod_grad18==4
sort rbd
quietly by rbd:  gen dup_rbd = cond(_N==1,0,_n) 
gen dummy=1
collapse (last) mrun dup18 cod_grad18  sit_fin18 dup_rbd (sum) dummy (count) cod_ense18, by(rbd18)
//usar sum dummy o count algo para aobtener el numero de desertores intra año por rbd

//loop de desercion por colegio considerandio desertores intra año para 4to básico
local mylist 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 
foreach x of local mylist {
use Rend_20`x'_unificados

gen sit_fin_R_`x'=0 
gen sit_fin_P_`x'=0  
gen sit_fin_Y_`x'=0 
replace sit_fin_R_`x'=1  if sit_fin`x'=="R"
replace sit_fin_P_`x'=1  if sit_fin`x'=="P"
replace sit_fin_Y_`x'=1  if sit_fin`x'=="Y"

keep if cod_grad`x'==4 & cod_ense`x'==110 //elimino todos los que están en 4to básico
collapse (sum) sit_fin_R_`x' sit_fin_P_`x' sit_fin_Y_`x' (count) mrun cod_ense`x', by(rbd`x')
gen tasadesercion_intra=sit_fin_Y_`x'/mrun
gen n_d_intra`x'=sit_fin_Y_`x'  //numerod de desertor intra-año
save Rend_20`x'_unificados_by_rbd, replace
clear

}
*
*
*
use Rend_2004_unificados
merge m:n mrun using Rend_2005_unificados

keep if cod_grad04==4 & cod_ense04==110 
gen des_inter04=.
replace des_inter04=1 if cod_grad04==4 & cod_grad05==.
drop dup05 cod_grad05 cod_ense05 rbd05 sit_fin05 _merge
save Rend_2004_inter, replace


merge m:n mrun using Rend_2004_unificados
keep if cod_grad04==4
gen deserta=0
replace deserta=1 if des_inter04==1
replace deserta=1 if sit_fin04=="Y"
save Rend_2004_todos, replace


use Rendimiento2004
keep if cod_grad==4 & cod_ense==110
















//vuelvo a la base original y uso los no duplicados
preserve
keep if dup`x'==0 //mantengo los no duplicados
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
drop sit_fin_Y  sit_fin_R sit_fin_P 
rename cod_grad cod_grad`x' ,replace
rename cod_ense cod_ense`x' ,replace
rename rbd rbd`x'
save Rend_20`x'_nonduplicados, replace
drop if sit_fin`x'=="Y"
save Rend_20`x'_nondup_des_intra`x', replace //bbdd desertores intra-año  de los no duplicados 
restore

preserve
clear
use Rend_20`x'_duplicados
save Rend_20`x'_dup_ryp_`x', replace
restore

preserve
clear
use Rend_20`x'_duplicados
drop if sit_fin`x'=="Y"
save Rend_20`x'_dup_ryp_`x', replace
restore


clear







}




// Appendo las Bases de desertores de dup y nondup
local mylist 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 
foreach x of local mylist {
use  Rend_20`x'_dup_des_intra`x'
append using Rend_20`x'_nondup_des_intra`x'
save Rend_20`x'_des_intra`x', replace
clear


}
clear
use  Rend_2004_des_intra04, replace
merge m:n mrun using Rend_2005_des_intra05
merge m:n mrun using Rend_2006_des_intra06
drop _merge
merge m:n mrun using Rend_2007_des_intra07
drop _merge
merge m:n mrun using Rend_2008_des_intra08
drop _merge
merge m:n mrun using Rend_2009_des_intra09
drop _merge
merge m:n mrun using Rend_2010_des_intra10
drop _merge
merge m:n mrun using Rend_2011_des_intra11
drop _merge
merge m:n mrun using Rend_2012_des_intra12
drop _merge
merge m:n mrun using Rend_2013_des_intra13
drop _merge
merge m:n mrun using Rend_2014_des_intra14
drop _merge
merge m:n mrun using Rend_2015_des_intra15
drop _merge
merge m:n mrun using Rend_2016_des_intra16
drop _merge
merge m:n mrun using Rend_2017_des_intra17
drop _merge
merge m:n mrun using Rend_2018_des_intra18
drop _merge



















drop if dup>0
rename sit_fin sit_fin`x', replace
rename sit_fin_Y sit_fin_Y`x' ,replace
rename sit_fin_R sit_fin_R`x' ,replace
rename sit_fin_P sit_fin_P`x' ,replace
rename cod_grad cod_grad`x' ,replace
rename cod_grad cod_grad`x' ,replace
rename rbd rbd`x'
save Rend_20`x'_noduplicados

save rend_des`x',replace
clear
}

use rend_des04
merge m:n using rend_des05, by(mrun)

local mylist 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 
foreach x of local mylist {


}
//PRUEBA
use mrun rbd sit_fin cod_grad cod_ense using Rendimiento2004 
keep if cod_ense==110
destring mrun, replace
drop if mrun==.  //borro los sin mrun
sort mrun
quietly by mrun:  gen dup04 = cond(_N==1,0,_n) //identifico los duplicados
keep if cod_ense==110
preserve
drop if dup04==0 //saco los no duplicados
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin_R=1  if sit_fin=="R" //creo dummies de 
replace sit_fin_P=1  if sit_fin=="P"
replace sit_fin_Y=1  if sit_fin=="Y"
collapse (max) dup cod_grad cod_ense sit_fin_Y sit_fin_R sit_fin_P (last)rbd sit_fin ,by(mrun)
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
rename dup dup_04
rename sit_fin sit_fin04, replace
rename sit_fin_Y sit_fin_Y04 ,replace
rename sit_fin_R sit_fin_R04 ,replace
rename sit_fin_P sit_fin_P04 ,replace
rename cod_grad cod_grad04 ,replace
rename cod_ense cod_ense04 ,replace
rename rbd rbd04
save Rend_2004_duplicados, replace //esta base contiene a los que pasaron por mas de un colegio en el año 
keep if sit_fin04=="Y"
save Rend_2004_dup_des_intra04, replace // esta base contiene a los que pasaron por mas de un colegio en el año y no teerminaro el año
restore
keep if dup==0
gen sit_fin_R=0 
gen sit_fin_P=0  
gen sit_fin_Y=0 
replace sit_fin="R" if sit_fin_R==1
replace sit_fin="P" if sit_fin_P==1
rename dup dup_04
rename sit_fin sit_fin04, replace
rename sit_fin_Y sit_fin_Y04 ,replace
rename sit_fin_R sit_fin_R04 ,replace
rename sit_fin_P sit_fin_P04 ,replace
rename cod_grad cod_grad04 ,replace
rename cod_ense cod_ense04 ,replace
rename rbd rbd04
keep if sit_fin04=="Y"
save Rend_2004_nondup_des_intra04, replace
