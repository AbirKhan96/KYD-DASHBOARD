﻿ SELECT
  consolidated_child_3months.month_n,
  consolidated_child_3months.block_n,
  sum(demo_consolidated_3months.no_chld_0to6yrs_enrld_svcs) as no_enrolled,
  sum(consolidated_child_3months.total_no_chld_elgb_wgd) as tot_elgb_wghd,
  sum(consolidated_child_3months.total_no_chld_elgb_hght) as tot_elgb_hght,
  sum(consolidated_child_3months.total_no_chld_wgd) as no_wt,
  sum(consolidated_child_3months.total_no_chld_ht_msrd) as no_ht,
  sum(consolidated_child_3months.total_no_chld_ht_wt_msrd) as no_wt_ht,
  round((sum(consolidated_child_3months.total_no_chld_wgd) / sum(no_chld_0to6yrs_enrld_svcs) * 100), 2) as wt_percent,
  round((sum(consolidated_child_3months.total_no_chld_ht_msrd) / sum(no_chld_0to6yrs_enrld_svcs) * 100), 2) as ht_percent,
round((sum(consolidated_child_3months.total_no_chld_ht_wt_msrd) / sum(no_chld_0to6yrs_enrld_svcs) * 100), 2) as ht_wt_percent
  
  
FROM
  public.consolidated_child_3months,demo_consolidated_3months
  where 
consolidated_child_3months.month_n = demo_consolidated_3months.month_n and
consolidated_child_3months.block_n = demo_consolidated_3months.block_n
group by
consolidated_child_3months.month_n,consolidated_child_3months.block_n
order by consolidated_child_3months.block_n ;

with wsul as (
select 
	month_n, block_n,
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
	sum(total_no_chld_born_wgd_in_mnth) as tot_cbwm
	from consolidated_child_3months
group by 
consolidated_child_3months.month_n, consolidated_child_3months.block_n
order by 
consolidated_child_3months.month_n,
consolidated_child_3months.block_n)

select month_n, block_n, mdrtly_stntd,svrly_stntd, svr_wstg, mdrtly_wstd, svrly_uw, mdrtly_uw,nb_lbw,
round(((svr_wstg+mdrtly_wstd)/no_wt_ht_msrd)*100,2) as wasting_percent,
round(((svrly_stntd+mdrtly_stntd)/ht_msrd)*100,2) as stunting_percent,
round(((svrly_uw+mdrtly_uw)/tot_wgd)*100,2) as underweight_percent,
round((nb_lbw/tot_cbwm)*100,2) as low_birth_weight_percent
from wsul;

	
 select
  consolidated_child_3months.month_n,
  consolidated_child_3months.block_n,
  sum(demo_consolidated_3months.no_chld_0to6yrs_enrld_svcs) as no_enrolled,
  sum(consolidated_child_3months.total_no_chld_elgb_wgd) as tot_elgb_wghd,
  sum(consolidated_child_3months.total_no_chld_elgb_hght) as tot_elgb_hght,
  sum(consolidated_child_3months.total_no_chld_wgd) as no_wt,
  sum(consolidated_child_3months.total_no_chld_ht_msrd) as no_ht,
  sum(consolidated_child_3months.total_no_chld_ht_wt_msrd) as no_wt_ht
  
  
FROM
  public.consolidated_child_3months,demo_consolidated_3months
  where 
consolidated_child_3months.month_n = demo_consolidated_3months.month_n and
consolidated_child_3months.block_n = demo_consolidated_3months.block_n
group by
consolidated_child_3months.month_n,consolidated_child_3months.block_n
order by consolidated_child_3months.month_n ,consolidated_child_3months.block_n ;

with wsul as (
select 
	month_n, block_n, project_n,
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
	sum(total_no_chld_born_wgd_in_mnth) as tot_cbwm
	from consolidated_child_3months
group by 
consolidated_child_3months.month_n, consolidated_child_3months.block_n, consolidated_child_3months.project_n
order by 
consolidated_child_3months.month_n,
consolidated_child_3months.block_n,
consolidated_child_3months.project_n)

select month_n, block_n, project_n, mdrtly_stntd,svrly_stntd, svr_wstg, mdrtly_wstd, svrly_uw, mdrtly_uw,nb_lbw,
round(((svr_wstg+mdrtly_wstd)/no_wt_ht_msrd)*100,2) as wasting_percent,
round(((svrly_stntd+mdrtly_stntd)/ht_msrd)*100,2) as stunting_percent,
round(((svrly_uw+mdrtly_uw)/tot_wgd)*100,2) as underweight_percent,
round((nb_lbw/tot_cbwm)*100,2) as low_birth_weight_percent
from wsul;

with wsul as (
select 
	month_n, block_n, project_n, beat_n,
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
	sum(total_no_chld_born_wgd_in_mnth) as tot_cbwm
	from consolidated_child_3months
group by 
consolidated_child_3months.month_n, consolidated_child_3months.block_n, consolidated_child_3months.project_n , consolidated_child_3months.beat_n
order by 
consolidated_child_3months.month_n,
consolidated_child_3months.block_n,
consolidated_child_3months.project_n,
consolidated_child_3months.beat_n)

select month_n, block_n, project_n,beat_n,mdrtly_stntd,svrly_stntd, svr_wstg, mdrtly_wstd, svrly_uw, mdrtly_uw,nb_lbw,
round(((svr_wstg+mdrtly_wstd)/no_wt_ht_msrd)*100,2) as wasting_percent,
round(((svrly_stntd+mdrtly_stntd)/ht_msrd)*100,2) as stunting_percent,
round(((svrly_uw+mdrtly_uw)/tot_wgd)*100,2) as underweight_percent,
round((nb_lbw/tot_cbwm)*100,2) as low_birth_weight_percent
from wsul;	

with wsul as (
select 
	month_n, block_n, project_n, beat_n,
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
	sum(total_no_chld_born_wgd_in_mnth) as tot_cbwm
	from consolidated_child_3months
group by 
consolidated_child_3months.month_n, consolidated_child_3months.block_n, consolidated_child_3months.project_n , consolidated_child_3months.beat_n
order by 
consolidated_child_3months.month_n,
consolidated_child_3months.block_n,
consolidated_child_3months.project_n,
consolidated_child_3months.beat_n)

select month_n, block_n, project_n,beat_n,mdrtly_stntd,svrly_stntd, svr_wstg, mdrtly_wstd, svrly_uw, mdrtly_uw,nb_lbw,
round(((svr_wstg+mdrtly_wstd)/no_wt_ht_msrd)*100,2) as wasting_percent,
round(((svrly_stntd+mdrtly_stntd)/ht_msrd)*100,2) as stunting_percent,
round(((svrly_uw+mdrtly_uw)/tot_wgd)*100,2) as underweight_percent,
round((nb_lbw/tot_cbwm)*100,2) as low_birth_weight_percent
from wsul;	

