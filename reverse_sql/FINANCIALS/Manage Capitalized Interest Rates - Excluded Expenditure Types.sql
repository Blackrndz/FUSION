/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Capitalized%20Interest%20Rates%20-%20Excluded%20Expenditure%20Types.sql $:
 * $Id: Manage Capitalized Interest Rates - Excluded Expenditure Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

 

SELECT pjcCINTRNameEO.RATE_NAME 	RES_NAME
  ,HROrgUNITEO.NAME			  	     RES_BUSINESS_UNIT
  ,pjfExpTypeEO.EXPENDITURE_TYPE_NAME	 RES_EXPENDITURE_TYPE
  ,(SELECT EXPENDITURE_CATEGORY_NAME FROM PJF_EXP_CATEGORIES_VL
		WHERE EXPENDITURE_CATEGORY_ID = pjfExpTypeEO.EXPENDITURE_CATEGORY_ID
		) RES_EXPENDITURE_CATEGORY
  ,pjcCINTRExpEO.LAST_UPDATED_BY  	RSC_LAST_UPDATED_BY
  ,pjcCINTRExpEO.LAST_UPDATE_DATE  	RSC_LAST_UPDATE_DATE
  ,pjcCINTRExpEO.CREATED_BY 		RSC_CREATED_BY
  ,pjcCINTRExpEO.CREATION_DATE  	RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,pjcCINTRInfoEO.ORG_ID RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ORGANIZATION_UNITS HROrgUNITEO
,PJC_CINT_RATE_INFO_ALL pjcCINTRInfoEO
,PJC_CINT_EXP_TYP_ECL_ALL pjcCINTRExpEO
,PJF_EXP_TYPES_VL pjfExpTypeEO
,PJC_CINT_RATE_NAMES pjcCINTRNameEO
WHERE pjcCINTRInfoEO.RATE_INFO_ID = pjcCINTRExpEO.RATE_INFO_ID
AND pjcCINTRExpEO.EXPENDITURE_TYPE_ID = pjfExpTypeEO.EXPENDITURE_TYPE_ID
AND pjcCINTRInfoEO.ORG_ID = HROrgUNITEO.ORGANIZATION_ID
AND pjcCINTRNameEO.RATE_NAME_ID = pjcCINTRInfoEO.RATE_NAME_ID
ORDER BY pjfExpTypeEO.EXPENDITURE_TYPE_NAME
