/* ****************************************************************************
 * $Revision: 72749 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-10-23 15:22:46 +0700 (Wed, 23 Oct 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Availability%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage Availability Lookups - Lookup Types.sql 72749 2019-10-23 08:22:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=CMP_PLANS_VL 
 
SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,DECODE(cmpPLANEO.TRACK_INELIGIBLE_FLAG,'Y','Yes','No') RES_TRACK_INELIGIBLE_WORKERS
,DECODE(cmpPLANEO.HIDE_INELIGIBLE_FLAG,'Y','Yes','No') RES_HIDE_INELIGIBLE_WORKERS


 
,cmpELIGEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpELIGEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpELIGEO.CREATED_BY RSC_CREATED_BY
,cmpELIGEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLANS_VL cmpPLANEO
,CMP_ELIGIBILITY cmpELIGEO
,BEN_ELIGY_PRFL benELIGPREO
WHERE cmpPLANEO.PLAN_ID = cmpELIGEO.PLAN_ID
AND cmpELIGEO.ELIGIBILITY_PROFILE_ID = benELIGPREO.ELIGY_PRFL_ID 
AND cmpPLANEO.COMP_TYPE = 'CWB'
--AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY PLAN_NAME