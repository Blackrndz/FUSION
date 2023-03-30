/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Suspense%20Accounts%20-%20Manage%20Suspense%20Accounts%20-%20DFF.sql $:
 * $Id: Manage Suspense Accounts - Manage Suspense Accounts - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_SUSPENSE_ACCOUNTS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT KEYFLEXFIELDSTRUCTUREINSTANC1.name RES_CHART_OF_ACCOUNTS
,GLLEDGERS.name RES_LEDGER
,JournalSourcePEO.JE_SOURCE_NAME RES_SOURCE
,JOURNALCATEGORYPEO.JE_CATEGORY_NAME RES_CATEGORY
,SuspenseAccountEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,SuspenseAccountEO.ATTRIBUTE1
,SuspenseAccountEO.ATTRIBUTE2
,SuspenseAccountEO.ATTRIBUTE3
,SuspenseAccountEO.ATTRIBUTE4
,SuspenseAccountEO.ATTRIBUTE5
,SuspenseAccountEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SuspenseAccountEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SuspenseAccountEO.CREATED_BY RSC_CREATED_BY
,SuspenseAccountEO.CREATION_DATE RSC_CREATION_DATE
,SuspenseAccountEO.Ledger_id RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_SUSPENSE_ACCOUNTS SuspenseAccountEO
,GL_LEDGERS GlLedgers
,GL_JE_CATEGORIES_VL JournalCategoryPEO
,GL_JE_SOURCES_VL JOURNALSOURCEPEO
,FUSION.FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1
WHERE(SuspenseAccountEO.Ledger_id          = GlLedgers.Ledger_id)
AND(SuspenseAccountEO.JE_SOURCE_NAME       = JournalSourcePEO.JE_SOURCE_NAME)
AND(SUSPENSEACCOUNTEO.JE_CATEGORY_NAME     = JOURNALCATEGORYPEO.JE_CATEGORY_NAME)
AND GLLEDGERS.CHART_OF_ACCOUNTS_ID         = KEYFLEXFIELDSTRUCTUREINSTANC1.STRUCTURE_INSTANCE_NUMBER
AND( SuspenseAccountEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR SuspenseAccountEO.ATTRIBUTE1           IS NOT NULL
OR SuspenseAccountEO.ATTRIBUTE2           IS NOT NULL
OR SuspenseAccountEO.ATTRIBUTE3           IS NOT NULL
OR SuspenseAccountEO.ATTRIBUTE4           IS NOT NULL
OR SuspenseAccountEO.ATTRIBUTE5           IS NOT NULL)
ORDER BY GlLedgers.NAME
,SuspenseAccountEO.JE_SOURCE_NAME
,SuspenseAccountEO.JE_CATEGORY_NAME
,SuspenseAccountEO.CODE_COMBINATION_ID