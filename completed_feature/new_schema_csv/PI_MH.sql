with wsul as (
select 
	month_n, state_n,
	sum(no_anemic_wmn) as no_anemic_wmn,
	sum(no_pregnant_women) as no_pregnant_women,
	sum(no_tenatus_cmpltd) as no_tenatus_cmpltd,
	sum(no_wmn_rstg_drg_prgncy) as no_wmn_rstg_drg_prgncy,
	sum(no_wmn_etg_xtr_ml_drg_prgncy) as no_wmn_etg_xtr_ml_drg_prgncy,
	sum(no_trmstr_3wmn_cnsld_imdtbf) as no_trmstr_3wmn_cnsld_imdtbf,
	sum(no_wmn_1_anc_vst_dlvry) as no_wmn_1_anc_vst_dlvry,
	
	sum(no_wmn_4_anc_vst_dlvry) as no_wmn_4_anc_vst_dlvry
        from pregnant_women_ndj
group by 
pregnant_women_ndj.month_n, pregnant_women_ndj.state_n
order by 
pregnant_women_ndj.month_n,
pregnant_women_ndj.state_n)

select month_n, state_n, no_anemic_wmn,no_pregnant_women, no_tenatus_cmpltd, no_wmn_rstg_drg_prgncy, no_wmn_etg_xtr_ml_drg_prgncy,no_trmstr_3wmn_cnsld_imdtbf, no_wmn_4_anc_vst_dlvry,
round((no_anemic_wmn/no_pregnant_women)*100 , 2) as prnt_anwmic_wmn,
round((no_wmn_4_anc_vst_dlvry/no_pregnant_women)*100 , 2) as prnt_4_anc_vst_dlvry,
round((no_wmn_etg_xtr_ml_drg_prgncy/no_pregnant_women)*100 , 2) as prnt_wmn_etg_xtr_ml_drng_prgncy,
round((no_wmn_rstg_drg_prgncy/no_pregnant_women)*100 , 2) as prnt_wmn_rstg_drg_prgncy,
round((no_trmstr_3wmn_cnsld_imdtbf/no_pregnant_women)*100 , 2) as prnt_trmstr_3wmn_cnsld_imdtbf
from wsul;