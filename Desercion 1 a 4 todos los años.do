*desercio

local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {
use B1_`x'_1Basico
append using B1_`x'_2Basico
append using B1_`x'_3Basico
append using B1_`x'_4Basico
collapse (sum) sit_fin_R_`x' sit_fin_P_`x' sit_fin_Y_`x' deserta`x' mrun cod_ense`x', by (rbd)
gen tasa_des`x'=deserta`x'/mrun
drop mrun
rename rbd`x' rbd
save B1_TDES_1A4_`x', replace
clear

}
clear
use B1_2004_1Basico
append using B1_2004_2Basico
append using B1_2004_3Basico
append using B1_2004_4Basico
collapse (sum) sit_fin_R_2004 sit_fin_P_2004 sit_fin_Y_2004 deserta2004 mrun cod_ense2004, by (rbd)
gen tasa_des=deserta2004/mrun
save B1_TDES_1A4_2004, replace

use B1_TDES_1A4_2004
local numlist 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {
merge m:n rbd using B1_TDES_1A4_`x'
drop _merge



}
save B1_TDES_1A4_ALLYEARS_WIDE, replace
order _all, alpha
