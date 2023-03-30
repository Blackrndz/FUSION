/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Class%20Categories%20-%20Class%20Category.sql $:
* $Id: Manage Project Class Categories - Class Category.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfClassCategory.CLASS_CATEGORY							RES_NAME
,pjfClassCategory.DESCRIPTION									RES_DESCRIPTION
,TO_CHAR(pjfClassCategory.START_DATE_ACTIVE,'DD-Mon-YYYY') 		RES_FROM_DATE
,TO_CHAR(pjfClassCategory.END_DATE_ACTIVE,'DD-Mon-YYYY') 		RES_TO_DATE
,DECODE(pjfClassCategory.MANDATORY_FLAG,'Y','Yes','No') 		RES_ASSIGN_TO_ALL_PROJECTS
,DECODE(pjfClassCategory.ALL_TYPES_VALID_FLAG,'Y','Yes','No') 	RES_ASSIGN_TO_ALL_PROJECT_TYPE
,DECODE(pjfClassCategory.AUTOACCOUNTING_FLAG,'Y','Yes','No') 	RES_AVAILABLE_AS_ACCOUNTING_SO
,DECODE(pjfClassCategory.PICK_ONE_CODE_ONLY_FLAG,'Y','Yes','No') RES_ONE_CLASS_CODE_PER_PROJECT
,DECODE(pjfClassCategory.ALLOW_PERCENT_FLAG,'Y','Yes','No') 	RES_ENTER_CLASS_CODES_PERCENT
,DECODE(pjfClassCategory.TOTAL_100_PERCENT_FLAG,'Y','Yes','No') RES_TOTAL_PERCENT_MUST_EQUAL_1
,pjfClassCategory.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfClassCategory.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfClassCategory.CREATED_BY  RSC_CREATED_BY
,pjfClassCategory.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_CLASS_CATEGORIES_VL pjfClassCategory
ORDER BY pjfClassCategory.CLASS_CATEGORY	

