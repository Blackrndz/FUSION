/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Class%20Categories%20-%20Class%20Codes.sql $:
* $Id: Manage Project Class Categories - Class Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfClassCategory.CLASS_CATEGORY							RES_NAME
,pjfClassCodeEO.CLASS_CODE										RES_CLASS_NAME
,pjfClassCodeEO.DESCRIPTION										RES_CLASS_CODE_DESCRIPTION
,TO_CHAR(pjfClassCodeEO.START_DATE_ACTIVE,'DD-Mon-YYYY') 		RES_FROM_DATE
,TO_CHAR(pjfClassCodeEO.END_DATE_ACTIVE,'DD-Mon-YYYY') 			RES_TO_DATE
,pjfClassCodeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfClassCodeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfClassCodeEO.CREATED_BY  RSC_CREATED_BY
,pjfClassCodeEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_CLASS_CATEGORIES_VL pjfClassCategory
,PJF_CLASS_CODES_VL pjfClassCodeEO
WHERE pjfClassCategory.CLASS_CATEGORY_ID = pjfClassCodeEO.CLASS_CATEGORY_ID
ORDER BY pjfClassCategory.CLASS_CATEGORY	

