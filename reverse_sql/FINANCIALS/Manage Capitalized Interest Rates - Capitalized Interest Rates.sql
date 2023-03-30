/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Capitalized%20Interest%20Rates%20-%20Capitalized%20Interest%20Rates.sql $:
 * $Id: Manage Capitalized Interest Rates - Capitalized Interest Rates.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
select pjcCINTRNameEO.RATE_NAME 	RES_NAME
  ,pjcCINTRNameEO.DESCRIPTION  		RES_DESCRIPTION
  ,pjfEXPTypeEO.EXPENDITURE_TYPE_NAME	RES_EXPENDITURE_TYPE
  ,TO_CHAR(pjcCINTRNameEO.START_DATE_ACTIVE,'DD/Mon/YYYY') RES_FROM_DATE
  ,TO_CHAR(pjcCINTRNameEO.END_DATE_ACTIVE,'DD/Mon/YYYY') RES_TO_DATE
  ,pjcCINTRNameEO.LAST_UPDATED_BY  	RSC_LAST_UPDATED_BY
  ,pjcCINTRNameEO.LAST_UPDATE_DATE  	RSC_LAST_UPDATE_DATE
  ,pjcCINTRNameEO.CREATED_BY 			RSC_CREATED_BY
  ,pjcCINTRNameEO.CREATION_DATE  		RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJC_CINT_RATE_NAMES pjcCINTRNameEO
,PJF_EXP_TYPES_VL pjfEXPTypeEO
WHERE pjcCINTRNameEO.EXPENDITURE_TYPE_ID = pjfEXPTypeEO.EXPENDITURE_TYPE_ID
ORDER BY pjcCINTRNameEO.RATE_NAME