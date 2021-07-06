#!/bin/bash

trans_comp_form_cnt=`ls -l /u01/data/TRANS/forms/bin/*.fmx | wc -l`
trans_forms_src_cnt=`ls -l /u01/data/TRANS/forms/src/*.fmb | wc -l`
trans_comp_lib_cnt=`ls -l /u01/data/TRANS/forms/bin/*.plx | wc -l`
trans_lib_src_cnt=`ls -l /u01/data/TRANS/forms/src/*.pll | wc -l`
trans_rdf_cnt=`ls -l /u01/data/TRANS/reports/src/*.rdf | wc -l`
trans_rep_cnt=`ls -l /u01/data/TRANS/reports/bin/*.rep | wc -l`

pud_comp_form_cnt=`ls -l /u01/data/PUD/forms/bin/*.fmx | wc -l`
pud_forms_src_cnt=`ls -l /u01/data/PUD/forms/src/*.fmb | wc -l`
pud_comp_lib_cnt=`ls -l /u01/data/PUD/forms/bin/*.plx | wc -l`
pud_lib_src_cnt=`ls -l /u01/data/PUD/forms/src/*.pll | wc -l`
pud_rdf_cnt=`ls -l /u01/data/PUD/reports/src/*.rdf | wc -l`
pud_rep_cnt=`ls -l /u01/data/PUD/reports/bin/*.rep | wc -l`

case_comp_form_cnt=`ls -l /u01/data/CASE/forms/bin/*.fmx | wc -l`
case_forms_src_cnt=`ls -l /u01/data/CASE/forms/src/*.fmb | wc -l`
case_comp_lib_cnt=`ls -l /u01/data/CASE/forms/bin/*.plx | wc -l`
case_lib_src_cnt=`ls -l /u01/data/CASE/forms/src/*.pll | wc -l`
case_rdf_cnt=`ls -l /u01/data/CASE/reports/src/*.rdf | wc -l`
case_rep_cnt=`ls -l /u01/data/CASE/reports/bin/*.rep | wc -l`

moea_comp_form_cnt=`ls -l /u01/data/OGMOEA/forms/bin/*.fmx | wc -l`
moea_forms_src_cnt=`ls -l /u01/data/OGMOEA/forms/src/*.fmb | wc -l`
moea_comp_lib_cnt=`ls -l /u01/data/OGMOEA/forms/bin/*.plx | wc -l`
moea_lib_src_cnt=`ls -l /u01/data/OGMOEA/forms/src/*.pll | wc -l`
moea_rdf_cnt=`ls -l /u01/data/OGMOEA/reports/src/*.rdf | wc -l`
moea_rep_cnt=`ls -l /u01/data/OGMOEA/reports/bin/*.rep | wc -l`

ogmenu_comp_form_cnt=`ls -l /u01/data/OGMENU/forms/bin/*.fmx | wc -l`
ogmenu_forms_src_cnt=`ls -l /u01/data/OGMENU/forms/src/*.fmb | wc -l`
ogmenu_comp_lib_cnt=`ls -l /u01/data/OGMENU/forms/bin/*.plx | wc -l`
ogmenu_lib_src_cnt=`ls -l /u01/data/OGMENU/forms/src/*.pll | wc -l`
ogmenu_rdf_cnt=`ls -l /u01/data/OGMENU/reports/src/*.rdf | wc -l`
ogmenu_rep_cnt=`ls -l /u01/data/OGMENU/reports/bin/*.rep | wc -l`

ecrs_comp_form_cnt=`ls -l /u01/data/OGECRS/forms/bin/*.fmx | wc -l`
ecrs_forms_src_cnt=`ls -l /u01/data/OGECRS/forms/src/*.fmb | wc -l`
ecrs_comp_lib_cnt=`ls -l /u01/data/OGECRS/forms/bin/*.plx | wc -l`
ecrs_lib_src_cnt=`ls -l /u01/data/OGECRS/forms/src/*.pll | wc -l`
ecrs_rdf_cnt=`ls -l /u01/data/OGECRS/reports/src/*.rdf | wc -l`
ecrs_rep_cnt=`ls -l /u01/data/OGECRS/reports/bin/*.rep | wc -l`

echo "-----------------------------------------------------"
echo "Statistics for TRANS Application..."
echo "Forms Compiled Count = " $trans_comp_form_cnt
echo "Forms Source Count = " $trans_forms_src_cnt
echo "Library Compiled Count = " $trans_comp_lib_cnt
echo "Library Source Count = " $trans_lib_src_cnt
echo "Reports Definition Count = " $trans_rdf_cnt
echo "Reports Compiled Count = " $trans_rep_cnt
echo ""
echo "-----------------------------------------------------"
echo "Statistics for PUD Application..."
echo "Forms Compiled Count = " $pud_comp_form_cnt
echo "Forms Source Count = " $pud_forms_src_cnt
echo "Library Compiled Count = " $pud_comp_lib_cnt
echo "Library Source Count = " $pud_lib_src_cnt
echo "Reports Definition Count = " $pud_rdf_cnt
echo "Reports Compiled Count = " $pud_rep_cnt
echo ""
echo "-----------------------------------------------------"
echo "Statistics for CASE Application..."
echo "Forms Compiled Count = " $case_comp_form_cnt
echo "Forms Source Count = " $case_forms_src_cnt
echo "Library Compiled Count = " $case_comp_lib_cnt
echo "Library Source Count = " $case_lib_src_cnt
echo "Reports Definition Count = " $case_rdf_cnt
echo "Reports Compiled Count = " $case_rep_cnt
echo ""
echo "-----------------------------------------------------"
echo "Statistics for MOEA Application..."
echo "Forms Compiled Count = " $moea_comp_form_cnt
echo "Forms Source Count = " $moea_forms_src_cnt
echo "Library Compiled Count = " $moea_comp_lib_cnt
echo "Library Source Count = " $moea_lib_src_cnt
echo "Reports Definition Count = " $moea_rdf_cnt
echo "Reports Compiled Count = " $moea_rep_cnt
echo ""
echo "-----------------------------------------------------"
echo "Statistics for OGMENU Application..."
echo "Forms Compiled Count = " $ogmenu_comp_form_cnt
echo "Forms Source Count = " $ogmenu_forms_src_cnt
echo "Library Compiled Count = " $ogmenu_comp_lib_cnt
echo "Library Source Count = " $ogmenu_lib_src_cnt
echo "Reports Definition Count = " $ogmenu_rdf_cnt
echo "Reports Compiled Count = " $ogmenu_rep_cnt
echo ""
echo "-----------------------------------------------------"
echo "Statistics for ECRS Application..."
echo "Forms Compiled Count = " $ecrs_comp_form_cnt
echo "Forms Source Count = " $ecrs_forms_src_cnt
echo "Library Compiled Count = " $ecrs_comp_lib_cnt
echo "Library Source Count = " $ecrs_lib_src_cnt
echo "Reports Definition Count = " $ecrs_rdf_cnt
echo "Reports Compiled Count = " $ecrs_rep_cnt
echo ""
echo "-----------------------------------------------------"

