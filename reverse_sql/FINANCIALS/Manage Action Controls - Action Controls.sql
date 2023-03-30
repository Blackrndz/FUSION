/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Action%20Controls%20-%20Action%20Controls.sql $:
 * $Id: Manage Action Controls - Action Controls.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select DISTINCT fnLOOKEO.MEANING RES_SOURCE_APPLICATION
  ,null RSC_LAST_UPDATED_BY
  ,null RSC_LAST_UPDATE_DATE
  ,null RSC_CREATED_BY
  ,null RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PM_PROD_CNTRL_RULES pjfPMEO , FND_LOOKUPS fnLOOKEO
WHERE pjfPMEO.PM_PRODUCT_CODE  = fnLOOKEO.LOOKUP_CODE
AND fnLOOKEO.LOOKUP_TYPE = 'PJF_PM_PRODUCT_CODE'
ORDER BY fnLOOKEO.MEANING
