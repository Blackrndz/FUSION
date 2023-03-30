/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Individual%20Compensation%20Plans%20-%20Eligibility.sql $:
 * $Id: Manage Individual Compensation Plans - Eligibility.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,(CASE WHEN COMPONENT_ID IS NULL
	THEN 'Plan Eligibility'
	ELSE 'Options' END) RES_PARENT_ELIGIBILITY_PROFILE
,(SELECT COMPONENT_NAME FROM CMP_COMPONENTS_VL WHERE COMPONENT_ID = cmpELIGEO.COMPONENT_ID)RES_PARENT_ELIGIBILITY_PROFI_0
,(SELECT NAME FROM BEN_ELIGY_PRFL  WHERE ELIGY_PRFL_ID = cmpELIGEO.ELIGIBILITY_PROFILE_ID)RES_ELIGIBILITY_PROFILE
,DECODE(REQUIRED_FLAG,'Y','Yes','No')RES_REQUIRED

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
WHERE cmpPLANEO.COMP_TYPE = 'ICD'
AND cmpELIGEO.COMP_TYPE = 'ICD'
AND cmpPLANEO.PLAN_ID = cmpELIGEO.PLAN_ID
ORDER BY PLAN_NAME