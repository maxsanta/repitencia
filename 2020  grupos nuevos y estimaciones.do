///PC GRAFICA///
clear all
cd "D:\Downloads"


///NOTEBOOK///
clear all
cd "C:\Users\56989\Downloads"

///
local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018
foreach x of local numlist {
use simce4b`x'_rbd_publica_final
keep rbd cod_grupo
gen grA=0
gen grB=0
gen grC=0
gen grD=0
gen grE=0
gen grDE=0

replace grA=1 if cod_grupo==1
replace grB=1 if cod_grupo==2
replace grC=1 if cod_grupo==3
replace grD=1 if cod_grupo==4
replace grE=1 if cod_grupo==5
replace grDE=1 if grE+grD==1

rename grA grA`x'
rename grB grB`x'
rename grC grC`x'
rename grD grD`x'
rename grE grE`x'
rename grDE grDE`x'

drop cod_grupo

save simce`x'_rbd_dummies_grupos, replace
clear
}
**17 y 18 estan con numeros en vez

use simce2004_rbd_dummies_grupos

clear
use RBD_COMUNAS2004
local numlist 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018
foreach x of local numlist {

merge 1:1 rbd using RBD_COMUNAS`x', update
drop _merge


}
save RBD_COMUNAS_TODAS, replace

////////////////////PEGADO BASES DE DATOS GRUPOS NUEVOS 2020////////
{
merge m:m rbd using simce2005_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2006_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2007_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2008_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2009_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2010_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2011_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2012_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2013_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2014_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2015_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2016_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2017_rbd_dummies_grupos
drop _merge
merge m:m rbd using simce2018_rbd_dummies_grupos
drop _merge

use simcetodos_dummies_grupos_wide, replace //grupos nuevos
sort rbd
save simcetodos_dummies_grupos_wide, replace
}
////////////////////////////ya corrido//////////////////////////////



clear
use D_TINC_TREP_PIE_SEP_PS_WIDE
sort rbd
drop _merge
merge rbd using  simcetodos_dummies_grupos_wide 

save E_TINC_TREP_PIE_SEP_PS_WIDE, replace //con nuevos grupos ya corrido

local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {

	replace asep1xgA`x' = grA`x'*ysu_1_`x'
	replace asep1xgA`x' = grA`x'*ysu_2_`x'
	replace asep1xgA`x' = grA`x'*ysu_3_`x'
	replace asep1xgA`x' = grA`x'*ysu_4_`x'
	replace asep1xgA`x' = grA`x'*ysu_5_`x'
	replace asep1xgA`x' = grA`x'*ysu_6_`x'
	replace asep1xgA`x' = grA`x'*ysu_7_`x'
	replace asep1xgA`x' = grA`x'*ysu_8_`x'
	replace asep1xgA`x' = grA`x'*ysu_9_`x'
	
}

local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {

	replace asep1xgB`x' = grB`x'*ysu_1_`x'
	replace asep1xgB`x' = grB`x'*ysu_2_`x'
	replace asep1xgB`x' = grB`x'*ysu_3_`x'
	replace asep1xgB`x' = grB`x'*ysu_4_`x'
	replace asep1xgB`x' = grB`x'*ysu_5_`x'
	replace asep1xgB`x' = grB`x'*ysu_6_`x'
	replace asep1xgB`x' = grB`x'*ysu_7_`x'
	replace asep1xgB`x' = grB`x'*ysu_8_`x'
	replace asep1xgB`x' = grB`x'*ysu_9_`x'
	
}
local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {

	replace asep1xgC`x' = grC`x'*ysu_1_`x'
	replace asep1xgC`x' = grC`x'*ysu_2_`x'
	replace asep1xgC`x' = grC`x'*ysu_3_`x'
	replace asep1xgC`x' = grC`x'*ysu_4_`x'
	replace asep1xgC`x' = grC`x'*ysu_5_`x'
	replace asep1xgC`x' = grC`x'*ysu_6_`x'
	replace asep1xgC`x' = grC`x'*ysu_7_`x'
	replace asep1xgC`x' = grC`x'*ysu_8_`x'
	replace asep1xgC`x' = grC`x'*ysu_9_`x'
	
}

local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {

	replace asep1xgDE`x' = grDE`x'*ysu_1_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_2_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_3_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_4_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_5_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_6_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_7_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_8_`x'
	replace asep1xgDE`x' = grDE`x'*ysu_9_`x'
	
}

reshape long asep1xgA asep1xgB asep1xgC asep1xgDE ///
asep2xgA asep2xgB asep2xgC asep2xgDE ///
asep3xgA asep3xgB asep3xgC asep3xgDE ///
asep4xgA asep4xgB asep4xgC asep4xgDE ///
asep5xgA asep5xgB asep5xgC asep5xgDE ///
asep6xgA asep6xgB asep6xgC asep6xgDE ///
asep7xgA asep7xgB asep7xgC asep7xgDE ///
asep8xgA asep8xgB asep8xgC asep8xgDE ///
asep9xgA asep9xgB asep9xgC asep9xgDE ///
clasificacion_sep cod_ense conv_sep ///
depenencia deserta gA gB gC gD gDE gE ///
grA grB grC grD grDE grE int_alu muj mujer n_ben n_prio ///
pie ps rural_rbd sit_fin_P_ sit_fin_R_ sit_fin_Y_ ///
t_alu t_alu_b t_alub tasa_des tasa_inc tasa_rep uptake ysu_10_pie ///
ysu_11_pie ysu_12_pie ysu_13_pie ysu_1_ ///
ysu_1_pie ysu_2_ ysu_2_pie ysu_3_ ///
ysu_3_pie ysu_4_ ysu_5_ ysu_5_pie ///
ysu_6_ ysu_6_pie ysu_7_ ///
ysu_7_pie ysu_8_ ysu_8_pie ysu_9_ ysu_9_pie ///
,i(rbd) j(agno)

save E_TINC_TREP_PIE_SEP_PS_LONG, replace
use E_TINC_TREP_PIE_SEP_PS_LONG, replace
use D_TINC_TREP_PIE_SEP_PS_WIDE
clear
use D_TINC_TREP_PIE_SEP_PS_LONG
preserve
merge m:1 rbd using RBD_COMUNAS_TODAS
drop if _merge!=3
drop _merge
restore
xtset rbd agno

drop if ps!=1

tabstat tasa_rep , statistics(mean, sd) by(agno) column(s)
tabstat tasa_rep if gA==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_rep if gB==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_rep if gC==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_rep if gD==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_rep if gE==1, statistics(mean, sd) by(agno) column(s)

tabstat tasa_rep if ysu_1_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_2_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_3_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_4_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_5_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_6_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_7_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_8_==1, statistics(mean, sd) column(s)
tabstat tasa_rep if ysu_9_==1, statistics(mean, sd) column(s)

tabstat tasa_rep if rural_rbd==0, statistics(mean, sd) by(agno) column(s)
tabstat tasa_rep if rural_rbd==1, statistics(mean, sd) by(agno) column(s)

tabstat tasa_inc , statistics(mean, sd) by(agno) column(s)
tabstat tasa_inc if grA==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_inc if grB==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_inc if grC==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_inc if grD==1, statistics(mean, sd) by(agno) column(s)
tabstat tasa_inc if grE==1, statistics(mean, sd) by(agno) column(s)

mean tasa_rep , over(agno)
ciplot tasa_rep if cincogrupos==5, by(agno)  msymbol(s) mlcolor(black) mfcolor(black) ylabel(0(0.01)0.04, grid angle(0)) xlabel(,labsize(small)) graphregion(color(white))

mean tasa_inc , over(agno)
ciplot tasa_inc, by(agno) ytitle("Tasa de Incidencia de la Deserción") ysc(r(0 0.015)) ylabel(0(0.005)0.018, grid angle(0)) xlabel(,labsize(small)) graphregion(color(white))

mean tasa_rep , over(gA gB gC gD gE)
mean tasa_rep if agno==2007, over(gA gB gC gD gE)
mean tasa_rep if conv_sep==1, over(gA gB gC gD gE)
mean tasa_rep if conv_sep==1, over(agno)
mean tasa_rep if conv_sep==0 &agno>=2008, over(agno)

gen grupo=.
replace grupo =1 if grA==1
replace grupo =2 if grB==1
replace grupo =3 if grC==1
replace grupo =4 if grD==1 
replace grupo =4 if grE==1
gen cincogrupos=.
replace cincogrupos =1 if grA==1
replace cincogrupos =2 if grB==1
replace cincogrupos =3 if grC==1
replace cincogrupos =4 if grD==1 
replace cincogrupos =5 if grE==1
ciplot tasa_rep if agno==2017, by(grupo)
ciplot tasa_rep, by(grupo)
ciplot tasa_rep, by(cincogrupos)

ciplot tasa_inc, by(grupo) ytitle("Tasa de Incidencia de la Deserción") ysc(r(0 0.015)) ylabel(0(0.005)0.018, grid angle(0)) xlabel(,labsize(small)) graphregion(color(white))
ciplot tasa_inc, by(cincogrupos)

mean tasa_rep if agno==2009, over(gA gB gC gD gE)
ciplot tasa_rep if agno==2009, by(grupo)

mean tasa_inc , over(gA gB gC gD gE)
ciplot tasa_inc, by(grupo)


///////////////////////ESTIMACIONES CON desercion //////////////////////////////
quietly 
gen cA = 0
gen cB = 0
gen cC = 0 
gen cDE = 0
replace cA = conv_sep*gA 
replace cB = conv_sep*gB 
replace cC = conv_sep*gC 
replace cDE = conv_sep*gDE
xtreg tasa_rep cA cB  cC cDE pie i.agno, fe vce(cluster rbd)
estimates store m1, title(Tasa Repitencia - Modelo x)
//////////////////////////////// MODELO 1///////////////////////////////////////

quietly 
xtreg tasa_rep conv_sep pie i.agno, fe vce(cluster rbd)
estimates store m1, title(Tasa Repitencia - Modelo 1)

quietly xtreg tasa_rep conv_sep pie i.agno gB gC gDE, fe vce(cluster rbd)
estimates store m2, title(Tasa Repitencia - Modelo 2)

quietly xtreg tasa_inc conv_sep pie i.agno, fe vce(cluster rbd)
estimates store m3, title(Tasa Deserción - Modelo 3)

quietly xtreg tasa_inc conv_sep pie i.agno gB gC gDE, fe vce(cluster rbd)
estimates store m4, title(Tasa Deserción - Modelo 4)

estout m1 m2 m3 m4, cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant) stats(N_g)

quietly xtreg tasa_rep conv_sep pie i.agno, fe vce(cluster cod_com_rbd)
estimates store m1, title(Tasa Repitencia - Modelo 1)

quietly xtreg tasa_rep conv_sep pie i.agno gB gC gDE, fe vce(cluster cod_com_rbd)
estimates store m2, title(Tasa Repitencia - Modelo 2)

quietly xtreg tasa_inc conv_sep pie i.agno, fe vce(cluster cod_com_rbd)
estimates store m3, title(Tasa Deserción - Modelo 3)

quietly xtreg tasa_inc conv_sep pie i.agno gB gC gDE, fe vce(cluster cod_com_rbd)
estimates store m4, title(Tasa Deserción - Modelo 4)

estout m1 m2 m3 m4, cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant) stats(N_g)

/////////////////////////////// MODELO 2 ///////////////////////////////////////

quietly xtreg tasa_rep  ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie i.agno, fe vce(cluster rbd)
estimates store m5, title(TR 5)

quietly xtreg tasa_rep ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie gB gC gDE i.agno, fe vce(cluster rbd)
estimates store m6, title(TR 6)

quietly xtreg tasa_inc ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie i.agno, fe vce(cluster rbd)
estimates store m7, title(TD 7)

quietly xtreg tasa_inc ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie gB gC gDE i.agno, fe vce(cluster rbd)
estimates store m8, title(TD 8)

estout m5 m6 m7 m8, cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant)
/////////////////////////////// MODELO 2 ///////////////////////////////////////

quietly xtreg tasa_rep  ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie i.agno, fe vce(cluster cod_com_rbd )
estimates store m5, title(TR 5)

quietly xtreg tasa_rep ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie gB gC gDE i.agno, fe vce(cluster cod_com_rbd)
estimates store m6, title(TR 6)

quietly xtreg tasa_inc ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie i.agno, fe vce(cluster cod_com_rbd )
estimates store m7, title(TD 7)

quietly xtreg tasa_inc ysu_1_ ysu_2_ ysu_3_ ysu_4_ ysu_5_ ysu_6_ ysu_7_ ysu_8_ ysu_9_ pie gB gC gDE i.agno, fe vce(cluster cod_com_rbd )
estimates store m8, title(TD 8)

estout m5 m6 m7 m8, cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant)

//////////////////////////////////MODELO 3//////////////////////////////////////
xtreg tasa_rep asep1xgA asep2xgA asep3xgA asep4xgA asep5xgA asep6xgA asep7xgA asep8xgA asep9xgA /// 
asep1xgB asep2xgB asep3xgB asep4xgB asep5xgB asep6xgB asep7xgB asep8xgB asep9xgB /// 
asep1xgC  asep2xgC asep3xgC asep4xgC asep5xgC asep6xgC asep7xgC asep8xgC asep9xgC pie ///
asep1xgDE asep2xgDE asep3xgDE asep4xgDE asep5xgDE asep6xgDE asep7xgDE asep8xgDE asep9xgDE /// 
i.agno , fe //vce(cluster rbd)
estimates store m10, title(Model 1)
estout m10 , cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant)


xtreg tasa_rep asep1xgA asep2xgA asep3xgA asep4xgA asep5xgA asep6xgA asep7xgA asep8xgA asep9xgA /// 
asep1xgB asep2xgB asep3xgB asep4xgB asep5xgB asep6xgB asep7xgB asep8xgB asep9xgB /// 
asep1xgC  asep2xgC asep3xgC asep4xgC asep5xgC asep6xgC asep7xgC asep8xgC asep9xgC pie ///
asep1xgDE asep2xgDE asep3xgDE asep4xgDE asep5xgDE asep6xgDE asep7xgDE asep8xgDE asep9xgDE /// 
i.agno, fe vce(cluster rbd) //cod_com_rbd para cluster por comuna
estimates store m11, title(Model 1)
estout m10 m11, cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant)





xtreg tasa_inc asep1xgA asep2xgA asep3xgA asep4xgA asep5xgA asep6xgA asep7xgA asep8xgA asep9xgA /// 
asep1xgB asep2xgB asep3xgB asep4xgB asep5xgB asep6xgB asep7xgB asep8xgB asep9xgB /// 
asep1xgC  asep2xgC asep3xgC asep4xgC asep5xgC asep6xgC asep7xgC asep8xgC asep9xgC  ///
asep1xgDE asep2xgDE asep3xgDE asep4xgDE asep5xgDE asep6xgDE asep7xgDE asep8xgDE asep9xgDE /// 
i.agno, fe vce(cluster rbd)
estimates store m11, title(Model 1)
estout m11 , cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant)

xtreg tasa_inc asep1xgA asep2xgA asep3xgA asep4xgA asep5xgA asep6xgA asep7xgA asep8xgA asep9xgA /// 
asep1xgB asep2xgB asep3xgB asep4xgB asep5xgB asep6xgB asep7xgB asep8xgB asep9xgB /// 
asep1xgC  asep2xgC asep3xgC asep4xgC asep5xgC asep6xgC asep7xgC asep8xgC asep9xgC  ///
asep1xgDE asep2xgDE asep3xgDE asep4xgDE asep5xgDE asep6xgDE asep7xgDE asep8xgDE asep9xgDE /// 
i.agno, fe vce(cluster cod_com_rbd)
estimates store m11, title(Model 1)
estout m11 , cells(b(star fmt(3)) se(par)) legend label collabels(none) varlabels(_cons Constant)
