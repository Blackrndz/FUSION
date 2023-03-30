/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Suspense%20Accounts%20-%20Manage%20Suspense%20Accounts.sql $:
 * $Id: Manage Suspense Accounts - Manage Suspense Accounts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_ACCOUNT/GET_CODE_COMBINATION 

select KEYFLEXFIELDSTRUCTUREINSTANC1.name RES_CHART_OF_ACCOUNTS
,GLLEDGERS.name RES_LEDGER
,JournalSourcePEO.JE_SOURCE_NAME  RES_SOURCE 
,JOURNALCATEGORYPEO.JE_CATEGORY_NAME  RES_CATEGORY
,SUSPENSEACCOUNTEO.CODE_COMBINATION_ID RES_ACCOUNT
,SuspenseAccountEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SuspenseAccountEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SuspenseAccountEO.CREATED_BY  RSC_CREATED_BY
,SuspenseAccountEO.CREATION_DATE  RSC_CREATION_DATE
,SuspenseAccountEO.Ledger_id RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_SUSPENSE_ACCOUNTS SuspenseAccountEO
,GL_LEDGERS GlLedgers
,GL_JE_CATEGORIES_VL JournalCategoryPEO
,GL_JE_SOURCES_VL JOURNALSOURCEPEO
,FUSION.FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1
WHERE(SuspenseAccountEO.Ledger_id      = GlLedgers.Ledger_id)
AND(SuspenseAccountEO.JE_SOURCE_NAME   = JournalSourcePEO.JE_SOURCE_NAME)
and(SUSPENSEACCOUNTEO.JE_CATEGORY_NAME = JOURNALCATEGORYPEO.JE_CATEGORY_NAME)
and GLLEDGERS.CHART_OF_ACCOUNTS_ID                         = KEYFLEXFIELDSTRUCTUREINSTANC1.STRUCTURE_INSTANCE_NUMBER
ORDER BY GlLedgers.NAME
,SuspenseAccountEO.JE_SOURCE_NAME
,SuspenseAccountEO.JE_CATEGORY_NAME
,SuspenseAccountEO.CODE_COMBINATION_ID