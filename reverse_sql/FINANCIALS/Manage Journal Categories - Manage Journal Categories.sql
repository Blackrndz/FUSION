/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Journal%20Categories%20-%20Manage%20Journal%20Categories.sql $:
 * $Id: Manage Journal Categories - Manage Journal Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=DISALLOW_MJE_FLAG

SELECT JOURNALCATEGORYEO.USER_JE_CATEGORY_NAME RES_NAME
,JOURNALCATEGORYEO.JE_CATEGORY_KEY RES_CATEGORY_KEY
,JOURNALCATEGORYEO.DESCRIPTION RES_DESCRIPTION
,DECODE(JOURNALCATEGORYEO.DISALLOW_MJE_FLAG,'Y','Yes','No') RES_EXCLUDE_FROM_MANUAL_JOURNA
,JournalCategoryEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,JournalCategoryEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,JournalCategoryEO.CREATED_BY  RSC_CREATED_BY
,JournalCategoryEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_JE_CATEGORIES_VL JOURNALCATEGORYEO
ORDER BY JournalCategoryEO.USER_JE_CATEGORY_NAME