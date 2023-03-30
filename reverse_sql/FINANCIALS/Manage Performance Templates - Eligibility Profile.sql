/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT pfTemplatesE0.NAME RES_NAME
,(SELECT NAME
    FROM BEN_ELIGY_PRFL
    WHERE ELIGY_PRFL_ID = eligibilityPfE0.ELIGY_PRFL_ID
    ) RES_ELIGIBILITY_PROFILE
,DECODE(eligibilityPfE0.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED

,eligibilityPfE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,eligibilityPfE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,eligibilityPfE0.CREATED_BY  RSC_CREATED_BY
,eligibilityPfE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRT_ELGBLTY_PROFILE_OBJECTS eligibilityPfE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = eligibilityPfE0.OBJECT_ID
AND eligibilityPfE0.OBJECT_TYPE = 'TEMPLATE'
ORDER BY pfTemplatesE0.NAME
