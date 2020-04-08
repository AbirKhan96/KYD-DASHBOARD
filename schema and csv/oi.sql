with wsul as (
select 
	month_n, district_n,
	sum(no_chld_svr_wasting) as svr_wstg,
	sum(no_mdrtly_wasted_chld) as mdrtly_wstd,
	sum(total_no_chld_ht_wt_msrd) as no_wt_ht_msrd,
	sum(no_svrly_stunted_chld) as svrly_stntd,
	sum(no_mdrtly_stunted_chld) as mdrtly_stntd,
	sum(total_no_chld_ht_msrd) as ht_msrd,
	sum(no_svrly_uw_chld) as svrly_uw,
	sum(no_mdrtly_uw_chld) as mdrtly_uw,
	sum(total_no_chld_wgd) as tot_wgd,
	sum(no_nwborns_wid_lbw) as nb_lbw,
	sum(total_no_chld_born_wgd_in_mnth) as tot_cbwm,
	sum(no_chld_bf_at_birth) as no_chld_bf_at_birth,
	sum(no_chld_excly_bf) as no_chld_excly_bf,
	sum(no_chld_rcvg_cf_wid_adq_dt_dvsty) as no_chld_rcvg_cf_wid_adq_dt_dvsty,
	sum(no_chld_cf_wid_adq_dt_qnty) as no_chld_cf_wid_adq_dt_qnty,
	sum(total_no_chld_cf_wid_appr_hndwhg_bfr_fdg) as tot_no_chld_rcvg_cf_wid_appr_hndwhd_bfr_fdg,
	sum(total_no_chld_enrld_cas_born_lstmnth) as total_no_chld_enrld_cas_born_lstmnth,
	sum(total_no_chld_0t6mnths_enrld_cas) as total_no_chld_0t6mnths_enrld_cas,
	sum(no_chld_appr_cf) as no_chld_appr_cf,
	sum(no_chld_intd_cf_past30d) as no_chld_intd_cf_past30d,
	sum(no_of_chld_cmpltd_1yr_immunzt) as no_of_chld_cmpltd_1yr_immunzt,
	sum(total_no_chld_fr_ag_grtr_12mnths) as total_no_chld_fr_ag_grtr_12mnths,
	sum(no_chld_6t24mnths_enrld_cas) as no_chld_6t24mnths_enrld_cas,
	sum(total_no_chld_6t8mnths_enrld_cas) as total_no_chld_6t8mnths_enrld_cas
	from consolidated_child_3months
group by 
consolidated_child_3months.month_n, consolidated_child_3months.district_n
order by 
consolidated_child_3months.month_n,
consolidated_child_3months.district_n
)


select month_n, district_n, mdrtly_stntd,svrly_stntd, svr_wstg, mdrtly_wstd, svrly_uw, mdrtly_uw,nb_lbw,
round(((svr_wstg+mdrtly_wstd)/no_wt_ht_msrd)*100,2) as wasting_percent,
round(((svrly_stntd+mdrtly_stntd)/ht_msrd)*100,2) as stunting_percent,
round(((svrly_uw+mdrtly_uw)/tot_wgd)*100,2) as underweight_percent,
round((nb_lbw/tot_cbwm)*100,2) as low_birth_weight_percent,
no_chld_bf_at_birth,no_chld_excly_bf,no_chld_rcvg_cf_wid_adq_dt_dvsty,no_chld_cf_wid_adq_dt_qnty,tot_no_chld_rcvg_cf_wid_appr_hndwhd_bfr_fdg,total_no_chld_enrld_cas_born_lstmnth,total_no_chld_0t6mnths_enrld_cas,no_chld_appr_cf,
round((no_chld_bf_at_birth/total_no_chld_enrld_cas_born_lstmnth)*100 , 2) as prnt_chld_bf_at_birth,
round((no_chld_excly_bf/total_no_chld_0t6mnths_enrld_cas)*100 , 2) as prnt_chld_excly_bf,
round((no_chld_rcvg_cf_wid_adq_dt_dvsty/no_chld_appr_cf)*100 , 2) as prnt_chld_rcvg_cf_wid_adq_dt_dvsty,
round((no_chld_cf_wid_adq_dt_qnty/no_chld_appr_cf)*100 , 2) as prnt_chld_cf_wid_adq_dt_qnty,
round((tot_no_chld_rcvg_cf_wid_appr_hndwhd_bfr_fdg/no_chld_appr_cf)*100 , 2) as per_no_chld_cf_wid_appr_hndwhg_bfr_fdg,
round((no_chld_intd_cf_past30d/total_no_chld_6t8mnths_enrld_cas)*100 , 2) as prnt_intd_6to8mnth_cf_child,
round((no_of_chld_cmpltd_1yr_immunzt/total_no_chld_fr_ag_grtr_12mnths)*110 , 2) as prnt_child_1yr_immnztn,
round((no_chld_rcvg_cf_wid_adq_dt_dvsty/no_chld_6t24mnths_enrld_cas)*100 , 2) prnt_intd_CF_6to24mnth_child
from wsul;