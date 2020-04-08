with wsul as (
select 
	month_n, state_n,
	sum(no_chld_svr_wasting) as svrly_wstd,
	sum(no_mdrtly_wasted_chld) as mdrtly_wstd,
	sum(no_svrly_stunted_chld) as svrly_stntd,
	sum(no_mdrtly_stunted_chld) as mdrtly_stntd,
	sum(no_svrly_uw_chld) as svrly_uw,
	sum(no_mdrtly_uw_chld) as mdrtly_uw,
	sum(no_nwborns_wid_lbw) as nb_lbw,
	sum(total_no_chld_ht_msrd) as total_no_chld_ht_msrd,
	sum(total_no_chld_ht_wt_msrd) as total_no_chld_ht_wt_msrd,
	sum(total_no_chld_wgd) as total_no_chld_wgd,
	sum(total_no_chld_born_wgd_in_mnth) as total_no_chld_born_wgd_in_mnth
        from  consolidated_child_ndj
group by 
consolidated_child_ndj.month_n, consolidated_child_ndj.state_n
order by 
consolidated_child_ndj.month_n,
consolidated_child_ndj.state_n)

select month_n, state_n, mdrtly_stntd,svrly_stntd, svrly_wstd, mdrtly_wstd, svrly_uw, mdrtly_uw,nb_lbw,
round(svrly_wstd + mdrtly_wstd) as wstd_chld,
round(svrly_stntd + mdrtly_stntd) as stntd_chld,
round(svrly_uw + mdrtly_uw) as uw_chld,
round(((svrly_stntd + mdrtly_stntd)/NULLIF(total_no_chld_ht_msrd,0))*100,2) as stunting_percent,
round(((svrly_wstd + mdrtly_wstd)/NULLIF(total_no_chld_ht_wt_msrd,0))*100,2) as wasting_percent,
round(((svrly_uw + mdrtly_uw)/NULLIF(total_no_chld_wgd,0))*100,2) as underweight_percent,
round((nb_lbw/NULLIF(total_no_chld_born_wgd_in_mnth,0))*100,2) as low_birth_weight_percent
from wsul;
