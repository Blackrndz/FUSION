/* ****************************************************************************
 * $Revision: 79318 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-09-12 15:21:51 +0700 (Mon, 12 Sep 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Suspense%20Accounts%20-%20Manage%20Suspense%20Accounts.sql $:
 * $Id: Manage Suspense Accounts - Manage Suspense Accounts.sql 79318 2022-09-12 08:21:51Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
select KEYFLEXFIELDSTRUCTUREINSTANC1.name RES_CHART_OF_ACCOUNTS
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