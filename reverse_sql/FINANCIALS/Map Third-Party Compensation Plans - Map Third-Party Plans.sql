/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Map%20Third-Party%20Compensation%20Plans%20-%20Map%20Third-Party%20Plans.sql $:
 * $Id: Map Third-Party Compensation Plans - Map Third-Party Plans.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
  
SELECT cmpPLANMAPEO.VENDOR_PLAN_CODE RES_THIRD_PARTY_PLAN
,cmpPLANMAPEO.VENDOR_COMPONENT_CODE RES_THIRD_PARTY_PLAN_COMPONENT
,(SELECT PLAN_NAME FROM CMP_PLANS_VL WHERE PLAN_ID = cmpPLANMAPEO.FUSION_PLAN_ID)  RES_INDIVIDUAL_COMPENSATION_PL
,(SELECT COMPONENT_NAME FROM CMP_COMPONENTS_VL WHERE COMPONENT_ID = cmpPLANMAPEO.FUSION_COMPONENT_ID)  RES_INDIVIDUAL_COMPENSATION__0

,cmpPLANMAPEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpPLANMAPEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpPLANMAPEO.CREATED_BY RSC_CREATED_BY
,cmpPLANMAPEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLAN_MAPPINGS cmpPLANMAPEO
ORDER BY cmpPLANMAPEO.VENDOR_PLAN_CODE,cmpPLANMAPEO.VENDOR_COMPONENT_CODE