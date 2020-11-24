clear all
cd "D:\GRAFICA MDT\Documentos\SEMINARIO 2019\BASES DE DATOS\ER_Matrícula_por_alumno_PUBL_MRUN_INT_PIE"

**LOOP to transform csv files from the Ministry of Education into dta files (for each year)**
local numlist  2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018
foreach x of local numlist {

import delimited MAT_PIE_`x'.csv , delimiter(";")
keep mrun agno rbd cod_depe cod_depe2 cod_ense cod_ense2 cod_ense3 cod_grado cod_grado2 rural_rbd gen_alu int_alu //I keep variables of mrun(student identifier), grade, type of school, gender and situation of integration
keep if cod_ense==110 //I keep students that are in the regular system in primary school
keep if cod_grado==4  // 

save MAT_PIE_`x'.dta, replace

clear
}
**
local mylist  2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018
foreach x of local mylist {

use MAT_PIE_`x'.dta
keep mrun agno rbd cod_depe cod_ense rural_rbd gen_alu int_alu

save MAT_PIE_`x'.dta, replace

clear
}
**

local numlist  2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018
foreach x of local numlist {

use MAT_PIE_`x'
destring int_alu, replace
preserve
collapse (last) rural_rbd agno cod_ense cod_depe (sum) gen_alu int_alu , by(rbd)

*rename mrun`x'
*rename agno`x'
*rename rbd`x'
*rename cod_depe2`x'
*rename rural_rbd`x'
*rename gen_alu`x'
*rename int_alu`x'

save B_PIE_`x', replace
restore
clear
}

rename rbd2004 rbd
use B_PIE_2006
**pegar las bases por año
local numlist  2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 
foreach x of local numlist {


use B_PIE_`x'
local y=`x'+1
save B_PIE_`x', replace
clear
}

use B_PIE_2004
local numlist  2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 
foreach x of local numlist {
merge m:n rbd using B_PIE_`x'.dta
drop _merge

}
save C_PIE_every_year, replace


local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 
foreach x of local numlist {
agno
rbd
cod_depe2
rural_rbd


clear
}
*


















local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 
foreach x of local numlist {




clear
}



local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 
foreach x of local numlist {




clear
}


local numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 
foreach x of local numlist {




clear
}
